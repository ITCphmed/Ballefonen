import 'package:postgres/postgres.dart';

void main(List<String> arguments) async {
  final conn = PostgreSQLConnection(
      'batyr.db.elephantsql.com', 5432, 'trokydhm',
      username: 'trokydhm', password: 'ZxOBGtlupYzbh0B_auYbCnOOvuvs-S2q');

  await conn.open();

  print('Connected to DB mon frezo');

//**TEST** Henter alle center med deres id
  List<List<dynamic>> center = await conn.query("SELECT * FROM centers");
  print(center);

  await conn.close();
}
