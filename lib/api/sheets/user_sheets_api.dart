import 'package:gsheets/gsheets.dart';
import 'package:hseapp/model/user.dart';

class UserSheetApi {
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "modular-oven-448109-j0",
  "private_key_id": "30f4cb5613e18d5330117630f9cf35dea1186518",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDEWd1g9W4Myh40\n37tLvwdDTy2wS2EMEEmEBMx6WDL5TXjQoCyazkX36q+6hupfgsGbqAmsWlf1JeRX\nHhkOmNhP3ExvL0wcCuYo7R+nlRKu3cZlpwWVwK5SEvpO6bYSIYjEwVKQl4YlC5QB\nYrsXl/0eaGeiC+0ZDt/14dagv+Omz2ZdLqsHY9ID0AfjcuCJ1rxlHU4fYHjJUgZ/\nmJhKT/D3oY0v5C6XQ966qzObvo5kmhPLDZGknUi4GPrvZ07JrbP5lrFErgDFnq0k\n1t3+OtIE4l5mprMAkWReoCiR5xr4AG0in40HP7QQwkDtNRdr0XXG5lzy+2eYqpW3\n1kLaCe6NAgMBAAECggEASvlne0zr8y1AQH9HtMIiI1T6BK2bxm/3qlXswDCqciBf\naAYpUgk+lU5DQI2gs8ypYebVnr62hFCuMoe3GKhLPJ9JflEIllKhFPKKWkKlaikb\nxxfyHX7/8S327yf1klHEuCB7huOc4MtdffP1raonCDPkkm9MXvubj/dmrWXoJvqy\nRz6zEJhfTA7iBMUL6ZC/JTJwNoIYgRCdyuParrFXodVL2DD9gpFKhQcV0gidSLoz\n6ckCSMr90bJFCCPUV5PJSNIOzeXBlqusNXsHMkUf1mF65wtv471LCzKxAuO2UFJA\n7GtgRfEI7u7Gz4sDqi7CUn9gqMtOLHiv0aiud91d/wKBgQDtBNM+MUubCpGRLQ0z\n4OG4y0y+slTcs/UfGx2F1p15GyFbgYTW4icyWJ+OnjOLT4NfmVS++VThQpinqwHx\nHr4ddGNXxx9dt936NbG8O3N9rXohDMFpIEzaF5snqXOBeQiKO4keGmTJH3hhr3PP\ndme8LFOYsKGgkk1KHZwlZMvGmwKBgQDUE0zHG5J1fA2HIUoc8BwsGMXe8GE1eaQY\ngazz47CFbKrbOk4JWwIoCNgaMapX3Buc4qZxrkMVWe46iYGHeTToXoccf/NLfwGQ\nN5iuyHqC8FzOBKFl5OZpR93BDTsskR2XbeUp7Qfw7rlLX7hmO3QKuZFuFdHp2Zgp\nJkPfh8Vd9wKBgBU0NE3BDTl+lY0+UYsNmEP29BOvUoY4FzrEKzz4+TeHZNGR4bdz\nnfwUD5orrwLMhz07M2iuV5ibY5rEYrUWgf2SlvyYVMcGlvY2bYMgcnGQ3ncsc/Ua\nraVpLTk8IJg5orjzII4v4EpZ5WQf1SV/O0KLWKM1UhBSZlW2Fm0F+nD3AoGADLyb\n/9lIEoZAybzWFqbVClDykVEehXeow1AGcx9ZmqnMGR6HUUiF+KGPWQNil6RAhEuY\nc3tjzAR6qklX3isJYmtK8gs9MWuPTHoKUXT45qRI7paYmuYEcI5AYzfINgUBIfcX\nrEzwDShJOJ2nFXy8m2hJs7LbyI+o88+4g9RDpkECgYA6YpyjUgI24+DGDaKqe4WP\nDN5RoUdIt7Xo/xIuFpAJelo8nQVZVSxZT80DS7bY+SEjQu3xcJmBU+6HJNvb5tz7\nxYBzpFM1uSERQKj/l9cPBJhTucHRxDwVSsVUeQbVbMN4Ct8meTFhZzDYf/Pm8F/2\n0GrrbaCmQHlk1H7M4M1/Fg==\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@modular-oven-448109-j0.iam.gserviceaccount.com",
  "client_id": "108107329908832066940",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40modular-oven-448109-j0.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';
  static final _gsheets = GSheets(_credentials);
  static final _spreadsheetId = '1IRv6mcJBP_x_USCpGWM088cmWHNDvGDJBsxNhL31BL8';
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