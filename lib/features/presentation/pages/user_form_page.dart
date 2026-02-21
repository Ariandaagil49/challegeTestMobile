import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_entity.dart';
import '../bloc/user_cubit.dart';

class UserFormPage extends StatefulWidget {
  final UserEntity? initial;

  const UserFormPage({super.key, this.initial});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _submitting = false;

  late final TextEditingController _nip;
  late final TextEditingController _namaLengkap;
  late final TextEditingController _jabatan;
  late final TextEditingController _jenisKelamin;
  late final TextEditingController _namaGolongan;
  late final TextEditingController _namaPangkat;
  late final TextEditingController _unitKerja;
  late final TextEditingController _skpd;
  late final TextEditingController _alamatLengkap;

  bool get isEdit => widget.initial != null;

  @override
  void initState() {
    super.initState();
    final u = widget.initial;

    _nip = TextEditingController(text: u?.nip ?? '');
    _namaLengkap = TextEditingController(text: u?.namaLengkap ?? '');
    _jabatan = TextEditingController(text: u?.jabatan ?? '');
    _jenisKelamin = TextEditingController(text: u?.jenisKelamin ?? 'Laki-Laki');
    _namaGolongan = TextEditingController(text: u?.namaGolongan ?? '');
    _namaPangkat = TextEditingController(text: u?.namaPangkat ?? '');
    _unitKerja = TextEditingController(text: u?.unitKerja ?? '');
    _skpd = TextEditingController(text: u?.skpd ?? '');
    _alamatLengkap = TextEditingController(text: u?.alamatLengkap ?? '');
  }

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
      final entity = UserEntity(
        id: widget.initial?.id ?? '',
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

      if (isEdit) {
        await context.read<UserCubit>().updateUser(entity);
      } else {
        await context.read<UserCubit>().addUser(entity);
      }

      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menyimpan: $e')));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Pegawai' : 'Tambah Pegawai')),
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
                  value:
                      (_jenisKelamin.text == 'Laki-Laki' ||
                          _jenisKelamin.text == 'Perempuan')
                      ? _jenisKelamin.text
                      : null,
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
                        : Text(isEdit ? 'Simpan Perubahan' : 'Simpan'),
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
