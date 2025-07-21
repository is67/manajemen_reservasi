class Validators {
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Field ini wajib diisi';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email wajib diisi';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Format email tidak valid';
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nomor telepon wajib diisi';
    }

    final phoneRegex = RegExp(r'^[\d\+\-\(\)\s]+$');
    if (!phoneRegex.hasMatch(value.trim()) || value.trim().length < 10) {
      return 'Format nomor telepon tidak valid';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password wajib diisi';
    }

    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }

    return null;
  }

  static String? confirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi password wajib diisi';
    }

    if (value != originalPassword) {
      return 'Konfirmasi password tidak cocok';
    }

    return null;
  }

  static String? currency(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Harga wajib diisi';
    }

    final numericValue = double.tryParse(
      value.replaceAll(RegExp(r'[^\d.]'), ''),
    );
    if (numericValue == null || numericValue <= 0) {
      return 'Harga harus berupa angka positif';
    }

    return null;
  }

  static String? duration(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Durasi wajib diisi';
    }

    final duration = int.tryParse(value);
    if (duration == null || duration <= 0) {
      return 'Durasi harus berupa angka positif';
    }

    return null;
  }

  static String? minLength(String? value, int minLength) {
    if (value == null || value.trim().isEmpty) {
      return 'Field ini wajib diisi';
    }

    if (value.trim().length < minLength) {
      return 'Minimal $minLength karakter';
    }

    return null;
  }

  static String? maxLength(String? value, int maxLength) {
    if (value != null && value.trim().length > maxLength) {
      return 'Maksimal $maxLength karakter';
    }

    return null;
  }
}
