import 'package:intl/intl.dart';

String targetConvert(int time) {
  int temp;
  if (time < 0) {
    time = time * -1;
  }
  int days = (time / 86400).floor();
  temp = time - days * 86400;
  int hours = (temp / 3600).floor();
  temp = temp - hours * 3600;
  int minutes = (temp / 60).floor();
  temp = temp - minutes * 60;
  int seconds = temp;
  if (days != 0) {
    return '$days Hari $hours Jam $minutes Menit';
  } else if (hours != 0) {
    return '$hours Jam $minutes Menit';
  } else if (minutes != 0) {
    return '$minutes Menit $seconds Detik';
  } else {
    return '$seconds Detik';
  }
}

String convertTanggal(String? date, {bool? pakaiWaktu}) {
  if (date == null) {
    return "null";
  }

  if (pakaiWaktu == null || pakaiWaktu == false) {
    // Parse string ke dalam DateTime
    DateTime dateTime = DateTime.parse(date);

    // Membuat format tanggal sesuai dengan kebutuhan
    String formattedDate =
        DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(dateTime);
    String formattedTime = DateFormat('HH:mm:ss', 'id_ID').format(dateTime);

    // Menggabungkan format tanggal dan waktu
    return '$formattedDate Jam $formattedTime';
  } else {
    DateTime dateTime = DateTime.parse(date);

    // Membuat format tanggal sesuai dengan kebutuhan
    return DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(dateTime);
  }
}

String addZero(int value) {
  if ((value / 10).floor() == 0) {
    return '0$value';
  } else {
    return '$value';
  }
}

String dateTimeConverter(DateTime utcDateTime) {
  // Format the DateTime into the desired format
  String formattedDate =
      '${utcDateTime.year}-${_twoDigits(utcDateTime.month)}-${_twoDigits(utcDateTime.day)}';

  return formattedDate; // Output: 2024-07-06
}

// Helper function to ensure two digits in month and day
String _twoDigits(int n) {
  if (n >= 10) {
    return '$n';
  }
  return '0$n';
}
