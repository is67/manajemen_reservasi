import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/form_input.dart';
import '../widgets/role_dropdown.dart';
import '../utils/validators.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _selectedRole = 'admin';
  String _selectedServiceType = 'salon';
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Akun')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Text(
                  'Buat Akun Baru',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),

                Text(
                  'Daftar sebagai admin atau staf',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                ),
                const SizedBox(height: 32),

                // Name Field
                FormInput(
                  controller: _nameController,
                  label: 'Nama Lengkap',
                  hintText: 'Masukkan nama lengkap',
                  validator: Validators.required,
                  prefixIcon: Icons.person_outlined,
                ),
                const SizedBox(height: 16),

                // Email Field
                FormInput(
                  controller: _emailController,
                  label: 'Email',
                  hintText: 'Masukkan email',
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                  prefixIcon: Icons.email_outlined,
                ),
                const SizedBox(height: 16),

                // Phone Field
                FormInput(
                  controller: _phoneController,
                  label: 'Nomor Telepon',
                  hintText: 'Masukkan nomor telepon',
                  keyboardType: TextInputType.phone,
                  validator: Validators.phone,
                  prefixIcon: Icons.phone_outlined,
                ),
                const SizedBox(height: 16),

                // Role Dropdown
                RoleDropdown(
                  value: _selectedRole,
                  onChanged: (value) {
                    setState(() {
                      _selectedRole = value ?? 'admin';
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Service Type (only for admin)
                if (_selectedRole == 'admin') ...[
                  DropdownButtonFormField<String>(
                    value: _selectedServiceType,
                    decoration: const InputDecoration(
                      labelText: 'Jenis Layanan',
                      prefixIcon: Icon(Icons.business_outlined),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'salon', child: Text('Salon')),
                      DropdownMenuItem(value: 'mua', child: Text('MUA')),
                      DropdownMenuItem(
                        value: 'dekorasi',
                        child: Text('Dekorasi'),
                      ),
                      DropdownMenuItem(
                        value: 'kostum',
                        child: Text('Sewa Kostum'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedServiceType = value ?? 'salon';
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                ],

                // Password Field
                FormInput(
                  controller: _passwordController,
                  label: 'Password',
                  hintText: 'Masukkan password',
                  obscureText: _obscurePassword,
                  validator: Validators.password,
                  prefixIcon: Icons.lock_outlined,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Confirm Password Field
                FormInput(
                  controller: _confirmPasswordController,
                  label: 'Konfirmasi Password',
                  hintText: 'Konfirmasi password',
                  obscureText: _obscureConfirmPassword,
                  validator: (value) => Validators.confirmPassword(
                    value,
                    _passwordController.text,
                  ),
                  prefixIcon: Icons.lock_outlined,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Register Button
                ElevatedButton(
                  onPressed: _handleRegister,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Daftar', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 16),

                // Login Link
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Sudah punya akun? Masuk di sini'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrasi akan diimplementasi')),
      );
      Navigator.pop(context);
    }
  }
}
