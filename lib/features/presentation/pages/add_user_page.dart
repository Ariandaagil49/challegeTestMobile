import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_cubit.dart';
import '../../domain/entities/user_entity.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();

  final _nip = TextEditingController();
  final _namaLengkap = TextEditingController();
  final _jabatan = TextEditingController();
  final _jenisKelamin = TextEditingController(text: 'Laki-Laki');
  final _namaGolongan = TextEditingController();
  final _namaPangkat = TextEditingController();
  final _unitKerja = TextEditingController();
  final _skpd = TextEditingController();
  final _alamatLengkap = TextEditingController();

  bool _submitting = false;

  @override
  void dispose() {
    _nip.dispose();
    _namaLengkap.dispose();
    _jabatan.dispose();
    _jenisKelamin.dispose();
    _namaGolongan.dispose();
    _namaPangkat.dispose();
    _unitKerja.dispose();
    _skpd.dispose();
    _alamatLengkap.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);

    try {
      final user = UserEntity(
        id: '',
        nip: _nip.text.trim(),
        namaLengkap: _namaLengkap.text.trim(),
        jabatan: _jabatan.text.trim(),
        jenisKelamin: _jenisKelamin.text.trim(),
        namaGolongan: _namaGolongan.text.trim(),
        namaPangkat: _namaPangkat.text.trim(),
        unitKerja: _unitKerja.text.trim(),
        skpd: _skpd.text.trim(),
        alamatLengkap: _alamatLengkap.text.trim(),
      );

      await context.read<UserCubit>().addUser(user);

      if (!mounted) return;
      Navigator.pop(context, true);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Pegawai')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _field(_nip, label: 'NIP', required: true),
                const SizedBox(height: 12),
                _field(_namaLengkap, label: 'Nama Lengkap', required: true),
                const SizedBox(height: 12),
                _field(_jabatan, label: 'Jabatan', required: true),
                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  value: _jenisKelamin.text,
                  decoration: const InputDecoration(
                    labelText: 'Jenis Kelamin',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Laki-Laki',
                      child: Text('Laki-Laki'),
                    ),
                    DropdownMenuItem(
                      value: 'Perempuan',
                      child: Text('Perempuan'),
                    ),
                  ],
                  onChanged: (v) {
                    if (v != null) _jenisKelamin.text = v;
                  },
                ),

                const SizedBox(height: 12),
                _field(_namaGolongan, label: 'Nama Golongan', required: true),
                const SizedBox(height: 12),
                _field(_namaPangkat, label: 'Nama Pangkat', required: true),
                const SizedBox(height: 12),
                _field(_unitKerja, label: 'Unit Kerja', required: true),
                const SizedBox(height: 12),
                _field(_skpd, label: 'SKPD', required: true),
                const SizedBox(height: 12),
                _field(
                  _alamatLengkap,
                  label: 'Alamat Lengkap',
                  required: true,
                  maxLines: 3,
                ),

                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitting ? null : _submit,
                    child: _submitting
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Simpan'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController c, {
    required String label,
    bool required = false,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: c,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (v) {
        if (!required) return null;
        if (v == null || v.trim().isEmpty) return '$label wajib diisi';
        return null;
      },
    );
  }
}
