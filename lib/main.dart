import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator Volume',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Kalkulator Volume Bangun Ruang'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  double? _result;

  // Controllers for Kubus
  final TextEditingController _kubusController = TextEditingController();

  // Controllers for Tabung
  final TextEditingController _tabungJariController = TextEditingController();
  final TextEditingController _tabungTinggiController = TextEditingController();

  // Controllers for Piramida
  final TextEditingController _piraAlasPController = TextEditingController();
  final TextEditingController _piraAlaslController = TextEditingController();
  final TextEditingController _piraTinggiController = TextEditingController();

  final List<String> _shapes = ['Kubus', 'Tabung', 'Piramida'];

  void _hitungVolume() {
    setState(() {
      _result = null;
      try {
        if (_selectedIndex == 0) {
          // Kubus: V = s^3
          double s = double.parse(_kubusController.text);
          _result = pow(s, 3).toDouble();
        } else if (_selectedIndex == 1) {
          // Tabung: V = π * r^2 * t
          double r = double.parse(_tabungJariController.text);
          double t = double.parse(_tabungTinggiController.text);
          _result = pi * pow(r, 2) * t;
        } else if (_selectedIndex == 2) {
          // Piramida: V = (1/3) * p * l * t
          double p = double.parse(_piraAlasPController.text);
          double l = double.parse(_piraAlaslController.text);
          double t = double.parse(_piraTinggiController.text);
          _result = (1 / 3) * p * l * t;
        }
      } catch (e) {
        _result = null;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Masukkan angka yang valid!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  void _reset() {
    setState(() {
      _result = null;
      _kubusController.clear();
      _tabungJariController.clear();
      _tabungTinggiController.clear();
      _piraAlasPController.clear();
      _piraAlaslController.clear();
      _piraTinggiController.clear();
    });
  }

  Widget _buildKubusForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rumus: V = s³',
          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.teal),
        ),
        const SizedBox(height: 16),
        _buildTextField(_kubusController, 'Panjang Sisi (s)', 'cm'),
      ],
    );
  }

  Widget _buildTabungForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rumus: V = π × r² × t',
          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.teal),
        ),
        const SizedBox(height: 16),
        _buildTextField(_tabungJariController, 'Jari-jari (r)', 'cm'),
        const SizedBox(height: 12),
        _buildTextField(_tabungTinggiController, 'Tinggi (t)', 'cm'),
      ],
    );
  }

  Widget _buildPiramidaForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rumus: V = ⅓ × p × l × t',
          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.teal),
        ),
        const SizedBox(height: 16),
        _buildTextField(_piraAlasPController, 'Panjang Alas (p)', 'cm'),
        const SizedBox(height: 12),
        _buildTextField(_piraAlaslController, 'Lebar Alas (l)', 'cm'),
        const SizedBox(height: 12),
        _buildTextField(_piraTinggiController, 'Tinggi (t)', 'cm'),
      ],
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, String suffix) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        suffixText: suffix,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.teal, width: 2),
        ),
      ),
    );
  }

  Widget _buildShapeIcon(int index) {
    final icons = [Icons.crop_square, Icons.circle_outlined, Icons.change_history];
    final labels = ['Kubus', 'Tabung', 'Piramida'];
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          _result = null;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [BoxShadow(color: Colors.teal.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 3))]
              : [],
        ),
        child: Column(
          children: [
            Icon(icons[index], color: isSelected ? Colors.white : Colors.grey.shade600, size: 28),
            const SizedBox(height: 4),
            Text(
              labels[index],
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey.shade600,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Shape Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (i) => _buildShapeIcon(i)),
            ),
            const SizedBox(height: 28),

            // Form Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Volume ${_shapes[_selectedIndex]}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Divider(height: 24),
                    if (_selectedIndex == 0) _buildKubusForm(),
                    if (_selectedIndex == 1) _buildTabungForm(),
                    if (_selectedIndex == 2) _buildPiramidaForm(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _hitungVolume,
                    icon: const Icon(Icons.calculate),
                    label: const Text('Hitung'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _reset,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Colors.teal),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Result Card
            AnimatedOpacity(
              opacity: _result != null ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 400),
              child: Visibility(
                visible: _result != null,
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                child: Card(
                  color: Colors.teal.shade50,
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          'Hasil Volume',
                          style: TextStyle(fontSize: 16, color: Colors.teal),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _result != null ? '${_result!.toStringAsFixed(4)} cm³' : '',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
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