import 'package:excel/excel.dart';

class DBHelper {
  static void read() {
    var db = Excel.createExcel();
    var sheetObject = db['Expe'];
    var link = db.link('Expenses', sheetObject);
  }
}
