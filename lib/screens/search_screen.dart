
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _fromController =
  TextEditingController(text: 'Kuala Lumpur (KUL)');

  final TextEditingController _toController =
  TextEditingController(text: 'Singapore (SIN)');

  DateTime? _departureDate = DateTime.now().add(
    const Duration(days: 7),
  );

  int _passengers = 1;
  String _travelClass = 'Economy';

  final Color primaryColor = const Color(0xFF526400);

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  String get formattedDate {
    if (_departureDate == null) {
      return 'Select departure date';
    }

    final date = _departureDate!;

    const months = [
      'January', 'February', 'March', 'April',
      'May', 'June', 'July', 'August',
      'September', 'October', 'November', 'December'
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _departureDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );

    if (picked != null) {
      setState(() {
        _departureDate = picked;
      });
    }
  }

  void _swapLocations() {
    setState(() {
      final temp = _fromController.text;
      _fromController.text = _toController.text;
      _toController.text = temp;
    });
  }

  void _searchFlights() {
    if (_fromController.text.trim().isEmpty ||
        _toController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both airports.'),
        ),
      );
      return;
    }

    if (_fromController.text.trim().toLowerCase() ==
        _toController.text.trim().toLowerCase()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Departure and destination must be different.'),
        ),
      );
      return;
    }

    if (_departureDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a departure date.'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Flight Search'),
          content: Text(
            'Your search details:\n\n'
                'From: ${_fromController.text}\n'
                'To: ${_toController.text}\n'
                'Date: $formattedDate\n'
                'Passengers: $_passengers\n'
                'Class: $_travelClass\n\n'
                'No live flight results are connected yet.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAirportField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: primaryColor),
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: primaryColor),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),

            const Text(
              'Find Your Flight',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Where would you like to go?',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            // Airport selection card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  _buildAirportField(
                    label: 'FROM',
                    hint: 'Departure airport',
                    icon: Icons.flight_takeoff,
                    controller: _fromController,
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: _swapLocations,
                      icon: Icon(
                        Icons.swap_vert_circle,
                        color: primaryColor,
                        size: 32,
                      ),
                      tooltip: 'Swap airports',
                    ),
                  ),

                  _buildAirportField(
                    label: 'TO',
                    hint: 'Destination airport',
                    icon: Icons.flight_land,
                    controller: _toController,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // Departure date
            _buildSectionTitle(
              'Departure Date',
              Icons.calendar_month,
            ),

            const SizedBox(height: 12),

            InkWell(
              onTap: _selectDate,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: primaryColor),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        formattedDate,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 22),

            // Passengers
            _buildSectionTitle(
              'Passengers',
              Icons.people_outline,
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Adults',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),

                  IconButton(
                    onPressed: _passengers > 1
                        ? () {
                      setState(() {
                        _passengers--;
                      });
                    }
                        : null,
                    icon: const Icon(Icons.remove_circle_outline),
                  ),

                  Text(
                    '$_passengers',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  IconButton(
                    onPressed: _passengers < 9
                        ? () {
                      setState(() {
                        _passengers++;
                      });
                    }
                        : null,
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // Travel class
            _buildSectionTitle(
              'Travel Class',
              Icons.airline_seat_recline_normal,
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _travelClass,
                  isExpanded: true,
                  items: [
                    'Economy',
                    'Premium Economy',
                    'Business',
                    'First Class',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _travelClass = value;
                      });
                    }
                  },
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Search button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: _searchFlights,
                icon: const Icon(Icons.search),
                label: const Text(
                  'Search Flights',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
