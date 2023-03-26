import 'package:intl/intl.dart';

class MonthlyUpdateItem {
  final String title;
  final String pdfUrl;
  final String jpgUrl;
  final String postedDate;

  const MonthlyUpdateItem({
    required this.title,
    required this.pdfUrl,
    required this.jpgUrl,
    required this.postedDate,
  });

  factory MonthlyUpdateItem.fromJson(Map<String, dynamic> json) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime dateTime = dateFormat.parse(json['cct_modified']);
    String formattedDate = DateFormat('MMM dd, yyyy (hh:mm)').format(dateTime);

    return MonthlyUpdateItem(
      title: 'Your Monthly Update',
      pdfUrl: json['pdffile']['url'],
      jpgUrl: json['tilegraphic']['url'],
      postedDate: formattedDate,
    );
  }
}

class ChristmasItem {
  final String title;
  final String program_url;
  final String program_date;
  final String program_description;

  const ChristmasItem({
    required this.title,
    required this.program_url,
    required this.program_date,
    required this.program_description,
  });

  factory ChristmasItem.fromJson(Map<String, dynamic> json) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime dateTime = dateFormat.parse(json['cct_modified']);
    String formattedDate = DateFormat('MMM dd, yyyy (hh:mm)').format(dateTime);

    return ChristmasItem(
      title: json['title'],
      program_url: json['program_url'],
      program_date: formattedDate,
      program_description: json['program_description'],
    );
  }
}