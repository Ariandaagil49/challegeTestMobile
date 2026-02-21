import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_cubit.dart';
import '../bloc/user_state.dart';
import '../../domain/entities/user_entity.dart';
import '../widgets/user_search_bar.dart';
import '../widgets/user_card.dart';
import 'user_form_page.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  String _query = '';
  bool _sortAZ = true;

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        final msg = state.message;
        if (msg != null && msg.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(msg)));
          context.read<UserCubit>().clearMessage();
        }
      },
      builder: (context, state) {
        final filtered = _filterUsers(state.users, _query);
        final shown = _sortUsers(filtered, _sortAZ);

        return Scaffold(
          appBar: AppBar(
            title: const Text('User Management'),
            actions: [
              IconButton(
                tooltip: _sortAZ ? 'Sort Z-A' : 'Sort A-Z',
                icon: const Icon(Icons.sort_by_alpha),
                onPressed: () => setState(() => _sortAZ = !_sortAZ),
              ),
              IconButton(
                tooltip: 'Refresh',
                icon: const Icon(Icons.refresh),
                onPressed: () => context.read<UserCubit>().fetchUsers(),
              ),
            ],
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final ok = await Navigator.push<bool>(
                context,
                MaterialPageRoute(builder: (_) => const UserFormPage()),
              );

              if (ok == true && mounted) {
                context.read<UserCubit>().fetchUsers();
              }
            },
            child: const Icon(Icons.add),
          ),

          body: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserSearchBar(
                  value: _query,
                  onChanged: (v) => setState(() => _query = v),
                ),
                const SizedBox(height: 10),

                Text(
                  'Menampilkan ${shown.length} dari ${state.users.length} user',
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 10),

                Expanded(child: _buildBody(state, shown)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(UserState state, List<UserEntity> users) {
    if (state.status == UserStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == UserStatus.failure) {
      return Center(
        child: Text(
          state.message?.isNotEmpty == true
              ? state.message!
              : 'Terjadi kesalahan',
          textAlign: TextAlign.center,
        ),
      );
    }

    if (users.isEmpty) {
      return const Center(child: Text('Data belum ada.'));
    }

    return ListView.separated(
      itemCount: users.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final u = users[i];

        return UserCard(
          user: u,

          onEdit: () async {
            final ok = await Navigator.push<bool>(
              context,
              MaterialPageRoute(builder: (_) => UserFormPage(initial: u)),
            );

            if (ok == true && mounted) {
              context.read<UserCubit>().fetchUsers();
            }
          },

          onDelete: () {
            context.read<UserCubit>().deleteUser(u.id);
          },
        );
      },
    );
  }

  List<UserEntity> _filterUsers(List<UserEntity> list, String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return list;

    bool contains(String v) => v.toLowerCase().contains(q);

    return list.where((u) {
      return contains(u.namaLengkap) ||
          contains(u.nip) ||
          contains(u.jabatan) ||
          contains(u.skpd) ||
          contains(u.unitKerja);
    }).toList();
  }

  List<UserEntity> _sortUsers(List<UserEntity> list, bool az) {
    final copy = [...list];
    copy.sort(
      (a, b) =>
          a.namaLengkap.toLowerCase().compareTo(b.namaLengkap.toLowerCase()),
    );
    return az ? copy : copy.reversed.toList();
  }
}
