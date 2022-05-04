import 'dart:ui';

class
InputModel {
  int? id;
  String? type;
  double? amount;
  String? category;
  String? description;
  String? date;
  String? time;
  Color? color;

  InputModel(
      {this.id,
      this.type,
      this.amount,
      this.category,
      this.description,
      this.date,
      this.time,
      this.color});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'type': type,
      'amount': amount,
      'category': category,
      'description': description,
      'date': date,
      'time': time
    };
    // use for updating - not necessary?
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static InputModel fromMap(Map<String, dynamic> map) {
    return InputModel(
      id: map['id'],
      type: map['type'],
      amount: map['amount'],
      category: map['category'],
      description: map['description'],
      date: map['date'],
      time: map['time'],
    );
  }
}
