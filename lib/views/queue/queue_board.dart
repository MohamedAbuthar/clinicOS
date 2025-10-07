import 'package:flutter/material.dart';

import '../appointments/appointment_screen.dart';
import '../doctors/doctor_presence.dart';
import '../home_screen/home_screen.dart';
import '../reschedule/reschedule_dashboard.dart';
import 'queue_dashboard.dart';

class QueueBoardDragScreen extends StatefulWidget {
  const QueueBoardDragScreen({Key? key}) : super(key: key);

  @override
  State<QueueBoardDragScreen> createState() => _QueueBoardDragScreenState();
}

class _QueueBoardDragScreenState extends State<QueueBoardDragScreen> {
  final _searchController = TextEditingController();
  String _selectedDoctor = 'Dr. Fathima';

  // Mock token data
  final List<Map<String, dynamic>> _tokens = [
    {'id': 'T-01', 'color': Colors.teal},
    {'id': 'T-02', 'color': Colors.amber},
    {'id': 'T-03', 'color': Colors.amber},
    {'id': 'T-05', 'color': Colors.amber},
    {'id': 'T-04', 'color': Colors.amber},
    {'id': 'T-06', 'color': Colors.amber},
    {'id': 'T-07', 'color': Colors.amber},
    {'id': 'T-08', 'color': Colors.amber},
    {'id': 'T-09', 'color': Colors.amber},
    {'id': 'T-10', 'color': Colors.amber},
    {'id': 'T-11', 'color': Colors.amber},
    {'id': 'T-12', 'color': Colors.amber},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(Icons.people_outline, color: Colors.teal, size: 24),
            const SizedBox(width: 8),
            Text(
              'Queue Board',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildSearchAndFilter(),
          _buildInfoBanner(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemCount: _tokens.length,
                itemBuilder: (context, index) {
                  return _buildTokenCard(_tokens[index]);
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey.shade400, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search by name or phone number',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: DropdownButton<String>(
              value: _selectedDoctor,
              underline: SizedBox(),
              isDense: true,
              icon: Icon(Icons.keyboard_arrow_down, size: 20),
              items: ['Dr. Fathima', 'Dr. Yalini']
                  .map(
                    (doctor) => DropdownMenuItem(
                      value: doctor,
                      child: Text(doctor, style: TextStyle(fontSize: 14)),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() => _selectedDoctor = value!);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: Colors.grey.shade600, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '"You can drag and skip tokens to modify the patient order based on availability."',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTokenCard(Map<String, dynamic> token) {
    return Container(
      decoration: BoxDecoration(
        color: token['color'],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: Center(
            child: Text(
              '#${token['id']}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Home', false, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              }),
              _buildNavItem(Icons.calendar_today, 'Appointment', false, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AppointmentsScreen(),
                  ),
                );
              }),
              _buildNavItem(Icons.queue, 'Queue', false, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QueueBoardScreen(),
                  ),
                );
              }),
              _buildNavItem(Icons.medical_services, 'Doctor', false, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DoctorPresenceScreen(),
                  ),
                );
              }),
              _buildNavItem(Icons.event_repeat, 'Reschedule', false, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RescheduleAndCancelScreen(),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      IconData icon,
      String label,
      bool isActive,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isActive ? Colors.white : Colors.white60, size: 26),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white60,
              fontSize: 11,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
