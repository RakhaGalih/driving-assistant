import 'package:intl/intl.dart';

String targetConvert(int time) {
  int temp;
  if (time < 0) {
    time = time * -1;
  }
  int hours = (time / 3600).floor();
  temp = time - hours * 3600;
  int minutes = (temp / 60).floor();
  temp = temp - minutes * 60;
  int seconds = temp;
  if (hours != 0) {
    return '$hours Jam $minutes Menit';
  } else if (minutes != 0) {
    return '$minutes Menit $seconds Detik';
  } else {
    return '$seconds Detik';
  }
}

String convertTanggal(String? date) {
  if (date == null) {
    return "null";
  }

  // Parse string ke dalam DateTime
  DateTime dateTime = DateTime.parse(date);

  // Membuat format tanggal sesuai dengan kebutuhan
  String formattedDate =
      DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(dateTime);
  String formattedTime = DateFormat('HH:mm:ss', 'id_ID').format(dateTime);

  // Menggabungkan format tanggal dan waktu
  return '$formattedDate Jam $formattedTime';
}

String addZero(int value) {
  if ((value / 10).floor() == 0) {
    return '0$value';
  } else {
    return '$value';
  }
}
