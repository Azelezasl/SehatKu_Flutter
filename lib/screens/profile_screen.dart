import 'package:flutter/material.dart';
import '../widgets/app_card.dart';

class ProfileScreen extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool>? onThemeChanged;

  const ProfileScreen({
    super.key,
    this.isDarkMode = false,
    this.onThemeChanged,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController(text: 'Pengguna');
  bool _reminder = true;
  TimeOfDay _time = const TimeOfDay(hour: 8, minute: 0);

  Future<void> _pickTime() async {
    final result = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (result != null) setState(() => _time = result);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timeText = _time.format(context);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Profil & Pengaturan',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: CircleAvatar(
              radius: 42,
              child: Icon(Icons.person, size: 42),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nama',
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Pengingat harian'),
                  subtitle: Text(_reminder ? 'Aktif' : 'Nonaktif'),
                  value: _reminder,
                  onChanged: (value) => setState(() => _reminder = value),
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.access_time),
                  title: const Text('Jam pengingat'),
                  trailing: Text(timeText),
                  onTap: _pickTime,
                ),
                const Divider(),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Mode gelap'),
                  subtitle: const Text('Tema terang dan gelap Material Design 3'),
                  value: Theme.of(context).brightness == Brightness.dark,
                  onChanged: widget.onThemeChanged,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profil berhasil disimpan.')),
              );
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}
