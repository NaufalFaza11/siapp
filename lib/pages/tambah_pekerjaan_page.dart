import 'package:flutter/material.dart';

class TambahPekerjaanPage extends StatefulWidget {
  const TambahPekerjaanPage({super.key});

  @override
  State<TambahPekerjaanPage> createState() =>
      _TambahPekerjaanPageState();
}

class _TambahPekerjaanPageState
    extends State<TambahPekerjaanPage> {
  final judulController = TextEditingController();
  final deskripsiController = TextEditingController();
  final lokasiController = TextEditingController();

  DateTime tanggalMulai = DateTime.now();

  int? frekuensi;

  bool isLoading = false;

  String get tanggalMulaiText {
    const namaHari = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];

    const namaBulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return '${namaHari[tanggalMulai.weekday - 1]}, '
        '${tanggalMulai.day} '
        '${namaBulan[tanggalMulai.month - 1]} '
        '${tanggalMulai.year}';
  }

  Future<void> pilihTanggal() async {
    final hasil = await showDatePicker(
      context: context,
      initialDate: tanggalMulai,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2563EB),
            ),
          ),
          child: child!,
        );
      },
    );

    if (hasil != null) {
      setState(() {
        tanggalMulai = hasil;
      });
    }
  }

  Future<void> pilihFrekuensi() async {
    final hasil = await showModalBottomSheet<int?>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              18,
              20,
              20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Frekuensi Pekerjaan',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Pilih seberapa sering pekerjaan dilakukan.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 15),
                buildFrequencyOption(
                  label: 'Sekali saja',
                  value: null,
                ),
                buildFrequencyOption(
                  label: 'Setiap 1 hari',
                  value: 1,
                ),
                buildFrequencyOption(
                  label: 'Setiap 7 hari',
                  value: 7,
                ),
                buildFrequencyOption(
                  label: 'Setiap 30 hari',
                  value: 30,
                ),
              ],
            ),
          ),
        );
      },
    );

    setState(() {
      frekuensi = hasil;
    });
  }

  Widget buildFrequencyOption({
    required String label,
    required int? value,
  }) {
    final selected = frekuensi == value;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.pop(context, value);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
        margin: const EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFEFF6FF)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? const Color(0xFFBFDBFE)
                : const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              size: 20,
              color: selected
                  ? const Color(0xFF2563EB)
                  : const Color(0xFF94A3B8),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: selected
                    ? FontWeight.w600
                    : FontWeight.w400,
                color: const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void simpanPekerjaan() {
    final judul = judulController.text.trim();

    if (judul.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Judul pekerjaan wajib diisi',
          ),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        if (!mounted) return;

        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Pekerjaan berhasil ditambahkan.',
            ),
            backgroundColor: Color(0xFF16A34A),
          ),
        );

        Navigator.pop(context);
      },
    );
  }

  InputDecoration inputDecoration({
    required String hintText,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        fontSize: 13,
        color: Color(0xFF94A3B8),
      ),
      prefixIcon: Icon(
        icon,
        size: 18,
        color: const Color(0xFF94A3B8),
      ),
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(
          color: Color(0xFFE2E8F0),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(
          color: Color(0xFFE2E8F0),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(
          color: Color(0xFF2563EB),
          width: 1.5,
        ),
      ),
    );
  }

  @override
  void dispose() {
    judulController.dispose();
    deskripsiController.dispose();
    lokasiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: isLoading
              ? null
              : () {
                  Navigator.pop(context);
                },
          style: IconButton.styleFrom(
            backgroundColor: const Color(0xFFF8FAFC),
            side: const BorderSide(
              color: Color(0xFFE2E8F0),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          icon: const Icon(
            Icons.chevron_left,
            color: Color(0xFF0F172A),
          ),
        ),
        title: const Text(
          'Tambah Pekerjaan',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          20,
          18,
          20,
          30,
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                17,
                20,
                17,
                20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(19),
                border: Border.all(
                  color: const Color(0xFFE2E8F0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const RequiredLabel(
                    text: 'Judul Pekerjaan ',
                  ),
                  const SizedBox(height: 7),
                  TextField(
                    controller: judulController,
                    textInputAction: TextInputAction.next,
                    decoration: inputDecoration(
                      hintText:
                          'Masukkan judul pekerjaan',
                      icon: Icons.assignment_outlined,
                    ),
                  ),

                  const SizedBox(height: 17),

                  const OptionalLabel(
                    text: 'Deskripsi ',
                  ),
                  const SizedBox(height: 7),
                  TextField(
                    controller: deskripsiController,
                    maxLines: 3,
                    decoration: inputDecoration(
                      hintText:
                          'Tambahkan deskripsi',
                      icon: Icons.notes_outlined,
                    ),
                  ),

                  const SizedBox(height: 17),

                  const Text(
                    'Lokasi',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 7),
                  TextField(
                    controller: lokasiController,
                    textInputAction: TextInputAction.done,
                    decoration: inputDecoration(
                      hintText: 'Masukkan lokasi',
                      icon: Icons.location_on_outlined,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Divider(
                    height: 1,
                    color: Color(0xFFE2E8F0),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Frekuensi Pekerjaan',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 7),

                  GestureDetector(
                    onTap: pilihFrekuensi,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 13,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius:
                            BorderRadius.circular(11),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.autorenew_outlined,
                            size: 18,
                            color: Color(0xFF2563EB),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              frekuensi == null
                                  ? 'Sekali saja'
                                  : 'Setiap $frekuensi hari',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            size: 19,
                            color: Color(0xFF94A3B8),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Pilih frekuensi pekerjaan sesuai kebutuhan.',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF94A3B8),
                    ),
                  ),

                  const SizedBox(height: 18),

                  const RequiredLabel(
                    text: 'Tanggal Mulai ',
                  ),
                  const SizedBox(height: 7),

                  GestureDetector(
                    onTap: pilihTanggal,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 13,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius:
                            BorderRadius.circular(11),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 18,
                            color: Color(0xFF2563EB),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              tanggalMulaiText,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            size: 19,
                            color: Color(0xFF94A3B8),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                onPressed:
                    isLoading ? null : simpanPekerjaan,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF2563EB),
                  disabledBackgroundColor:
                      const Color(0xFF93C5FD),
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shadowColor:
                      const Color(0xFF2563EB)
                          .withOpacity(0.30),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(13),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2.2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : const Text(
                        'SIMPAN PEKERJAAN',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RequiredLabel extends StatelessWidget {
  final String text;

  const RequiredLabel({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F172A),
            ),
          ),
          const TextSpan(
            text: '*',
            style: TextStyle(
              color: Color(0xFFDC2626),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class OptionalLabel extends StatelessWidget {
  final String text;

  const OptionalLabel({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F172A),
            ),
          ),
          const TextSpan(
            text: '(opsional)',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}