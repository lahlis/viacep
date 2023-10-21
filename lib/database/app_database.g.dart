// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CepDao? _cepDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `cep` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `cep` TEXT NOT NULL, `logradouro` TEXT NOT NULL, `complemento` TEXT, `bairro` TEXT NOT NULL, `localidade` TEXT NOT NULL, `uf` TEXT NOT NULL, `ibge` TEXT NOT NULL, `gia` TEXT NOT NULL, `ddd` TEXT NOT NULL, `siafi` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CepDao get cepDao {
    return _cepDaoInstance ??= _$CepDao(database, changeListener);
  }
}

class _$CepDao extends CepDao {
  _$CepDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _cepEntityInsertionAdapter = InsertionAdapter(
            database,
            'cep',
            (CepEntity item) => <String, Object?>{
                  'id': item.id,
                  'cep': item.cep,
                  'logradouro': item.logradouro,
                  'complemento': item.complemento,
                  'bairro': item.bairro,
                  'localidade': item.localidade,
                  'uf': item.uf,
                  'ibge': item.ibge,
                  'gia': item.gia,
                  'ddd': item.ddd,
                  'siafi': item.siafi
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CepEntity> _cepEntityInsertionAdapter;

  @override
  Future<List<CepEntity>> fetchAllCEP() async {
    return _queryAdapter.queryList('SELECT *     FROM cep',
        mapper: (Map<String, Object?> row) => CepEntity(
            id: row['id'] as int?,
            cep: row['cep'] as String,
            logradouro: row['logradouro'] as String,
            complemento: row['complemento'] as String?,
            bairro: row['bairro'] as String,
            localidade: row['localidade'] as String,
            uf: row['uf'] as String,
            ibge: row['ibge'] as String,
            gia: row['gia'] as String,
            ddd: row['ddd'] as String,
            siafi: row['siafi'] as String));
  }

  @override
  Future<void> deleteEntity(int id) async {
    await _queryAdapter.queryNoReturn('DELETE     FROM cep     WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertCEP(CepEntity entity) async {
    await _cepEntityInsertionAdapter.insert(entity, OnConflictStrategy.replace);
  }
}
