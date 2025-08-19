import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todoapp/data/data.dart';
import 'package:todoapp/utils/utils.dart';

class TaskDatasource {
  static final TaskDatasource _instance = TaskDatasource._();
  factory TaskDatasource() => _instance;

  TaskDatasource._() {
    _initDB();
  }

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DBKeys.dbName);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Future<void> deleteDatabaseFile() async {
  //   final dbPath = await getDatabasesPath();
  //   final path = join(dbPath, DBKeys.dbName); // DBKeys.dbName = 'task.db'
  //   await deleteDatabase(path);
  //   _database = null; // Bellekteki referansı da temizle
  //   print('Database deleted');
  // }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE ${DBKeys.dbName} (
        ${DBKeys.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
         ${DBKeys.titleColumn} TEXT,
        ${DBKeys.timeColumn} TEXT,
        ${DBKeys.noteColumn} TEXT,
        ${DBKeys.dateColumn} TEXT,
        ${DBKeys.categoryColumn} TEXT,
        ${DBKeys.isCompletedColumn} INTEGER
      )
    ''');
  }

  Future<int> addTask(Task task) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.insert(
        DBKeys.dbTable,
        task.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<int> updateTask(Task task) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.update(
        DBKeys.dbTable,
        task.toJson(),

        where: "id = ?",
        whereArgs: [task.id],
      );
    });
  }

  Future<int> deleteTask(Task task) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.delete(
        DBKeys.dbTable,
        where: "id = ?",
        whereArgs: [task.id],
      );
    });
  }

  Future<List<Task>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> data = await db.query(
      DBKeys.dbTable,
      orderBy: "id DESC",
    );
    return List.generate(data.length, (index) => Task.fromJson(data[index]));
  }
}
