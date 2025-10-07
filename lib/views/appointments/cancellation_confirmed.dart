import 'package:flutter/material.dart';

class CancellationConfirmedScreen extends StatelessWidget {
  final Map<String, dynamic> appointment;

  const CancellationConfirmedScreen({
    Key? key,
    required this.appointment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(Icons.cancel_outlined, color: Colors.black87, size: 22),
            const SizedBox(width: 8),
            Text(
              'Cancellation',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cancellation Confirmed',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              _buildConfirmationCard(),
              const SizedBox(height: 24),
              _buildBackToHomeButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmationCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Token Number Circle
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFF6750A4), width: 2),
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                '#T-02',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6750A4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Token Number',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6750A4),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 32),
          // Appointment Details
          _buildDetailRow('Patient:', 'Hannah Robins'),
          const SizedBox(height: 20),
          _buildDetailRow('Doctor:', 'Dr. Fathima'),
          const SizedBox(height: 20),
          _buildDetailRow('Specialization:', 'Cardiologist'),
          const SizedBox(height: 20),
          _buildDetailRow('Date:', 'September 26, 2025'),
          const SizedBox(height: 20),
          _buildDetailRow('Time:', '09:15 AM'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildBackToHomeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Navigate back to home or pop until home
          Navigator.popUntil(context, (route) => route.isFirst);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          elevation: 0,
        ),
        child: Text(
          'Back to Home',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}