import 'package:flutter/material.dart';
import '../widgets/app_card.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final _heightController = TextEditingController(text: '170');
  final _weightController = TextEditingController(text: '65');

  double? _bmi;
  String _category = '-';

  void _calculate() {
    final height = double.tryParse(_heightController.text);
    final weight = double.tryParse(_weightController.text);

    if (height == null || weight == null || height <= 0 || weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan tinggi dan berat yang valid.')),
      );
      return;
    }

    final meter = height / 100;
    final bmi = weight / (meter * meter);

    String category;
    if (bmi < 18.5) {
      category = 'Berat badan kurang';
    } else if (bmi < 25) {
      category = 'Normal';
    } else if (bmi < 30) {
      category = 'Berat badan berlebih';
    } else {
      category = 'Obesitas';
    }

    setState(() {
      _bmi = bmi;
      _category = category;
    });
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kalkulator BMI')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Masukkan data tubuh',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _heightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Tinggi (cm)',
              prefixIcon: Icon(Icons.height),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Berat (kg)',
              prefixIcon: Icon(Icons.monitor_weight),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _calculate,
            icon: const Icon(Icons.calculate),
            label: const Text('Hitung'),
          ),
          const SizedBox(height: 20),
          if (_bmi != null)
            AppCard(
              child: Column(
                children: [
                  const Text('Hasil BMI'),
                  const SizedBox(height: 8),
                  Text(
                    _bmi!.toStringAsFixed(1),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _category,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
