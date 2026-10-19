import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final bool isDark;
  final void Function(bool) onToggleTheme;
  const ProfilePage({super.key, required this.isDark, required this.onToggleTheme});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _name = TextEditingController(text: 'Pengguna');
  final _height = TextEditingController(text: '170');
  final _weight = TextEditingController(text: '65');
  TimeOfDay _reminder = const TimeOfDay(hour: 8, minute: 0);
  double? _bmi;

  @override
  void dispose() { _name.dispose(); _height.dispose(); _weight.dispose(); super.dispose(); }

  String get _bmiCategory {
    final bmi = _bmi;
    if (bmi == null) return '-';
    if (bmi < 18.5) return 'Berat badan kurang';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Berat badan berlebih';
    return 'Obesitas';
  }

  void _calculateBmi() {
    final h = double.tryParse(_height.text.replaceAll(',', '.'));
    final w = double.tryParse(_weight.text.replaceAll(',', '.'));
    if (h == null || w == null || h <= 0 || w <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Masukkan tinggi dan berat yang valid.')));
      return;
    }
    setState(() => _bmi = w / ((h / 100) * (h / 100)));
  }

  @override
  Widget build(BuildContext context) {
    final time = _reminder.format(context);
    return ListView(padding: const EdgeInsets.fromLTRB(20, 8, 20, 28), children: [
      Card(child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [
        const CircleAvatar(radius: 30, child: Icon(Icons.person, size: 30)),
        const SizedBox(width: 14),
        Expanded(child: TextField(controller: _name, decoration: const InputDecoration(labelText: 'Nama'))),
      ]))),
      const SizedBox(height: 14),
      Card(child: Column(children: [
        SwitchListTile(title: const Text('Mode gelap'), value: widget.isDark, onChanged: widget.onToggleTheme),
        ListTile(leading: const Icon(Icons.alarm_outlined), title: const Text('Pengingat harian'), subtitle: Text('Jam pengingat: $time'), trailing: const Icon(Icons.chevron_right_rounded), onTap: _pickTime),
      ])),
      const SizedBox(height: 20),
      Text('Kalkulator BMI', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
      const SizedBox(height: 10),
      Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(children: [
        Row(children: [Expanded(child: TextField(controller: _height, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Tinggi (cm)'))), const SizedBox(width: 12), Expanded(child: TextField(controller: _weight, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Berat (kg)')))]),
        const SizedBox(height: 12),
        SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: _calculateBmi, icon: const Icon(Icons.calculate_outlined), label: const Text('Hitung'))),
        if (_bmi != null) Padding(padding: const EdgeInsets.only(top: 14), child: Row(children: [const Icon(Icons.monitor_weight_outlined), const SizedBox(width: 10), Text('BMI ${_bmi!.toStringAsFixed(1)} · $_bmiCategory', style: const TextStyle(fontWeight: FontWeight.w800))])),
      ]))),
      const SizedBox(height: 14),
      FilledButton.tonalIcon(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profil tersimpan.'))), icon: const Icon(Icons.save_outlined), label: const Text('Simpan pengaturan')),
    ]);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _reminder);
    if (picked != null) setState(() => _reminder = picked);
  }
}
