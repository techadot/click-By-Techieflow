import 'package:click/class/credentials.dart';
import 'package:gsheets/gsheets.dart';

import '../model/headings.dart';

class ScoreApi {
  static const _spreadsheetid = '1KpFqmEjaFdSESdasPRb0-teFSurF7wuluJFi92kaw4A';

  static const _credentials = credentials;
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _scoresheet;
  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetid);
      _scoresheet = await _getWorksheet(spreadsheet, title: 'Scores');
      final firstrow = Headings.getfields();
      _scoresheet!.values.insertRow(1, firstrow);
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<Worksheet> _getWorksheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      print("worksheet Exists");
      return spreadsheet.worksheetByTitle(title)!;
    }
  }
}
