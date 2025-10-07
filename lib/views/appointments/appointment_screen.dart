import 'package:flutter/material.dart';

import '../doctors/doctor_presence.dart';
import '../home_screen/home_screen.dart';
import '../queue/queue_dashboard.dart';
import '../reschedule/reschedule_dashboard.dart';
import '../appointments/new_booking_dialog.dart';
import '../appointments/appointment_details.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final _searchController = TextEditingController();
  String _selectedDoctor = 'All Doctor';

  final List<Map<String, dynamic>> _mockAppointments = [
    {
      'time': '09:00 AM',
      'duration': '15 min',
      'patientName': 'John Smith',
      'doctorName': 'Dr. Fathima',
      'status': 'Consulting',
      'token': 'T-01',
      'statusColor': Colors.orange,
    },
    {
      'time': '09:00 AM',
      'duration': '15 min',
      'patientName': 'Lisa Davis',
      'doctorName': 'Dr. Yalini',
      'status': 'Consulting',
      'token': 'T-01',
      'statusColor': Colors.orange,
    },
    {
      'time': '09:15 AM',
      'duration': '15 min',
      'patientName': 'Hannah Robin',
      'doctorName': 'Dr. Fathima',
      'status': 'Scheduled',
      'token': 'T-02',
      'statusColor': Colors.blue,
    },
    {
      'time': '09:15 AM',
      'duration': '15 min',
      'patientName': 'Steve Smith',
      'doctorName': 'Dr. Yalini',
      'status': 'Scheduled',
      'token': 'T-02',
      'statusColor': Colors.blue,
    },
    {
      'time': '09:30 AM',
      'duration': '15 min',
      'patientName': 'Peter Parker',
      'doctorName': 'Dr. Fathima',
      'status': 'Scheduled',
      'token': 'T-03',
      'statusColor': Colors.blue,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      extendBody: true, // Important for floating navbar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(Icons.calendar_today_outlined, color: Colors.teal, size: 24),
            const SizedBox(width: 8),
            Text(
              'Appointments',
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
          _buildSearchAndNewBooking(),
          _buildDoctorFilter(),
          Expanded(child: _buildAppointmentsList()),
        ],
      ),
      bottomNavigationBar: _buildFloatingBottomNav(),
    );
  }

  Widget _buildSearchAndNewBooking() {
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
          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const SelectPatientDialog(),
              );
            },
            icon: Icon(Icons.add, size: 20),
            label: Text('New Booking'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: DropdownButton<String>(
              value: _selectedDoctor,
              underline: SizedBox(),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey.shade600,
              ),
              items: ['All Doctor', 'Dr. Fathima', 'Dr. Yalini']
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

  Widget _buildAppointmentsList() {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100),
      itemCount: _mockAppointments.length,
      itemBuilder: (context, index) {
        final appointment = _mockAppointments[index];
        return _buildAppointmentCard(appointment);
      },
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AppointmentDetailsScreen(appointment: appointment),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Time section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment['time'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                Text(
                  appointment['duration'],
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
            const SizedBox(width: 16),
            // Patient info section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        appointment['patientName'],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    appointment['doctorName'],
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: appointment['statusColor'],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      appointment['status'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Token section
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.teal, width: 2),
              ),
              child: Center(
                child: Text(
                  appointment['token'],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingBottomNav() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(Icons.home_outlined, false, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            }),
            _buildNavItem(Icons.calendar_today, true, () {
              // Already on appointments screen
            }),
            _buildNavItem(Icons.people_outline, false, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QueueBoardScreen(),
                ),
              );
            }),
            _buildNavItem(Icons.favorite_border, false, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DoctorPresenceScreen(),
                ),
              );
            }),
            _buildNavItem(Icons.person_outline, false, () {
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
    );
  }

  Widget _buildNavItem(IconData icon, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? Colors.white : Colors.transparent,
        ),
        child: Icon(
          icon,
          color: isActive ? Colors.black : Colors.white,
          size: 28,
        ),
      ),
    );
  }
}