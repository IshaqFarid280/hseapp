import 'package:gsheets/gsheets.dart';
import 'package:hseapp/model/user.dart';

class UserSheetApi {
  static const _credentials = r'''
  {
  //your cloud console credentials here
}
''';
  static final _gsheets = GSheets(_credentials);
  static final _spreadsheetId = 'your_sheets_id';
  static Worksheet ? _usersheet;

  static Future init()async{
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _usersheet = await _getWorkSheet(spreadsheet, title: 'Users');
      final firstRow = UserFields.getFields();
      _usersheet!.values.insertRow(1, firstRow);
    }  catch (e) {
      print('print error: $e');
    }
  }
  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,{
    required String title,})async{
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {

      return await spreadsheet.worksheetByTitle(title)!;
    }
  }
  static Future insert(List<Map<String, dynamic>> rowList) async{
    if(_usersheet == null) return;
    _usersheet!.values.map.appendRows(rowList);
  }
  static Future<int> getRowCount() async {
    if(_usersheet == null) return 0;
    final lastRow = await _usersheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;

  }
}
