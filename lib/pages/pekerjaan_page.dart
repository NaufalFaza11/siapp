import 'package:flutter/material.dart';

import 'tambah_pekerjaan_page.dart';

class PekerjaanPage extends StatefulWidget {
  const PekerjaanPage({super.key});

  @override
  State<PekerjaanPage> createState() => _PekerjaanPageState();
}

class _PekerjaanPageState extends State<PekerjaanPage> {
  final TextEditingController searchController =
      TextEditingController();

  final List<PekerjaanData> pekerjaan = const [
    PekerjaanData(
      judul: 'Periksa pompa air',
      lokasi: 'Kos Blok A',
      tanggal: '30 September 2026',
      status: 'Terlambat',
      isLate: true,
    ),
    PekerjaanData(
      judul: 'Cek lampu lorong',
      lokasi: 'Lorong Kos',
      tanggal: '3 Oktober 2026',
      status: 'Terjadwal',
    ),
    PekerjaanData(
      judul: 'Bersihkan area parkir',
      lokasi: 'Area Parkir',
      tanggal: '2 Oktober 2026',
      status: 'Terjadwal',
    ),
    PekerjaanData(
      judul: 'Cek meteran listrik',
      lokasi: 'Ruang Meteran',
      tanggal: '5 Oktober 2026',
      status: 'Terjadwal',
    ),
    PekerjaanData(
      judul: 'Periksa pintu kamar',
      lokasi: 'Blok B',
      tanggal: '6 Oktober 2026',
      status: 'Terjadwal',
    ),
  ];

  List<PekerjaanData> get filteredPekerjaan {
    final keyword = searchController.text.trim().toLowerCase();

    if (keyword.isEmpty) {
      return pekerjaan;
    }

    return pekerjaan.where((item) {
      return item.judul.toLowerCase().contains(keyword) ||
          item.lokasi.toLowerCase().contains(keyword) ||
          item.status.toLowerCase().contains(keyword);
    }).toList();
  }

  Future<void> bukaTambahPekerjaan() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TambahPekerjaanPage(),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = filteredPekerjaan;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Pekerjaan',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: bukaTambahPekerjaan,
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              icon: const Icon(
                Icons.add,
                size: 22,
              ),
              tooltip: 'Tambah Pekerjaan',
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              12,
              20,
              12,
            ),
            child: TextField(
              controller: searchController,
              onChanged: (_) {
                setState(() {});
              },
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Cari pekerjaan...',
                hintStyle: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF94A3B8),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 19,
                  color: Color(0xFF94A3B8),
                ),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          searchController.clear();
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 18,
                          color: Color(0xFF94A3B8),
                        ),
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFE2E8F0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFE2E8F0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF2563EB),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: list.isEmpty
                ? ListView(
                    physics:
                        const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(24),
                    children: const [
                      SizedBox(height: 100),
                      Icon(
                        Icons.assignment_outlined,
                        size: 50,
                        color: Color(0xFFCBD5E1),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Pekerjaan tidak ditemukan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF475569),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Coba gunakan kata kunci lain.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      4,
                      20,
                      20,
                    ),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return PekerjaanCard(
                        item: list[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class PekerjaanCard extends StatelessWidget {
  final PekerjaanData item;

  const PekerjaanCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final iconBackground = item.isLate
        ? const Color(0xFFFEE2E2)
        : const Color(0xFFDBEAFE);

    final iconColor = item.isLate
        ? const Color(0xFFDC2626)
        : const Color(0xFF2563EB);

    final statusBackground = item.isLate
        ? const Color(0xFFFEE2E2)
        : const Color(0xFFDBEAFE);

    final statusText = item.isLate
        ? const Color(0xFFDC2626)
        : const Color(0xFF2563EB);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: item.isLate
              ? const Color(0xFFFECACA)
              : const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.assignment_outlined,
              size: 20,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  item.judul,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 13,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        item.lokasi,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.isLate
                            ? Icons.warning_amber
                            : Icons.access_time,
                        size: 10,
                        color: statusText,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.status,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: statusText,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Berikutnya: ${item.tanggal}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(
              Icons.chevron_right,
              size: 19,
              color: Color(0xFFCBD5E1),
            ),
          ),
        ],
      ),
    );
  }
}

class PekerjaanData {
  final String judul;
  final String lokasi;
  final String tanggal;
  final String status;
  final bool isLate;

  const PekerjaanData({
    required this.judul,
    required this.lokasi,
    required this.tanggal,
    required this.status,
    this.isLate = false,
  });
}