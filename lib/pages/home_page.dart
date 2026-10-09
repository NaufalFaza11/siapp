import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const pekerjaanTerlambat = [
      {
        'judul': 'Periksa pompa air',
        'lokasi': 'Kos Blok A',
        'tanggal': '30 September 2026',
      },
    ];

    const pekerjaanTerdekat = [
      {
        'judul': 'Bersihkan area parkir',
        'lokasi': 'Area Parkir',
        'tanggal': '2 Oktober 2026',
      },
      {
        'judul': 'Cek lampu lorong',
        'lokasi': 'Lorong Kos',
        'tanggal': '3 Oktober 2026',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 20,
        title: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
            children: [
              TextSpan(
                text: 'SIAP ',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                ),
              ),
              TextSpan(
                text: 'KOSKU',
                style: TextStyle(
                  color: Color(0xFF2563EB),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          20,
          18,
          20,
          24,
        ),
        children: [
          const Text(
            'Halo,',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Pemilik Kos 👋',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Siap mengelola kos hari ini?',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 22),

          // HERO CARD
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF2563EB),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2563EB).withOpacity(0.18),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.16),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Text(
                          'RINGKASAN PEKERJAAN',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        '4',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 1),
                      const Text(
                        'Pekerjaan belum selesai',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.14),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/icon/Icon Siap Kosku.png',
                        width: 44,
                        height: 44,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Ringkasan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              Text(
                '12 selesai',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF2563EB),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 11),

          Row(
            children: const [
              Expanded(
                child: SummaryCard(
                  icon: Icons.assignment_outlined,
                  value: 4,
                  label: 'Belum Selesai',
                  backgroundColor: Color(0xFFEFF6FF),
                  iconBackground: Color(0xFFDBEAFE),
                  iconColor: Color(0xFF2563EB),
                ),
              ),
              SizedBox(width: 9),
              Expanded(
                child: SummaryCard(
                  icon: Icons.warning_amber_rounded,
                  value: 1,
                  label: 'Terlambat',
                  backgroundColor: Color(0xFFFFF1F2),
                  iconBackground: Color(0xFFFFE4E6),
                  iconColor: Color(0xFFDC2626),
                ),
              ),
              SizedBox(width: 9),
              Expanded(
                child: SummaryCard(
                  icon: Icons.history_outlined,
                  value: 12,
                  label: 'Riwayat',
                  backgroundColor: Color(0xFFF1F5F9),
                  iconBackground: Color(0xFFE2E8F0),
                  iconColor: Color(0xFF64748B),
                ),
              ),
            ],
          ),

          const SizedBox(height: 26),

          if (pekerjaanTerlambat.isNotEmpty) ...[
            const SectionTitle(
              title: 'Pekerjaan Terlambat',
            ),
            const SizedBox(height: 11),
            ...pekerjaanTerlambat.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: HomeJobCard(
                  icon: Icons.assignment_outlined,
                  title: item['judul']!,
                  location: item['lokasi']!,
                  date: item['tanggal']!,
                  isLate: true,
                ),
              ),
            ),
            const SizedBox(height: 6),
          ],

          const SectionTitle(
            title: 'Pekerjaan Terdekat',
          ),

          const SizedBox(height: 11),

          ...pekerjaanTerdekat.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: HomeJobCard(
                icon: Icons.assignment_outlined,
                title: item['judul']!,
                location: item['lokasi']!,
                date: item['tanggal']!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final IconData icon;
  final int value;
  final String label;
  final Color backgroundColor;
  final Color iconBackground;
  final Color iconColor;

  const SummaryCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.backgroundColor,
    required this.iconBackground,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(
              icon,
              size: 17,
              color: iconColor,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 1),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 9,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Color(0xFF0F172A),
      ),
    );
  }
}

class HomeJobCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String location;
  final String date;
  final bool isLate;

  const HomeJobCard({
    super.key,
    required this.icon,
    required this.title,
    required this.location,
    required this.date,
    this.isLate = false,
  });

  @override
  Widget build(BuildContext context) {
    final background = isLate
        ? const Color(0xFFFEE2E2)
        : const Color(0xFFDBEAFE);

    final iconColor = isLate
        ? const Color(0xFFDC2626)
        : const Color(0xFF2563EB);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isLate
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
              color: background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 20,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 5),
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
                        location,
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
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 12,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
                if (isLate) ...[
                  const SizedBox(height: 7),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEE2E2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Terlambat',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFDC2626),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}