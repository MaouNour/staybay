import 'package:flutter/material.dart';
import 'package:staybay/screens/bookings_screen.dart';
import 'package:staybay/screens/favorites_screen.dart';
import 'package:staybay/screens/welcome_screen.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'الملف الشخصي',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: OutlinedButton(
              onPressed: () {
                // أنت ستربط تغيير اللغة هنا لاحقًا
              },
              child: const Text('العربية'),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            /// HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [

                  /// صورة شخصية + زر تعديل
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 65,
                        backgroundImage: AssetImage('assets/profile.jpg'),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            // الانتقال إلى صفحة تغيير الصورة
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  /// الاسم
                  const Text(
                    'الاسم الكامل',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// الرقم
                  Text(
                    '+963 9XX XXX XXX',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            /// الأزرار
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [

                  _profileTile(
                    icon: Icons.favorite_border,
                    title: 'المفضلة',
                    onTap: () {
                      Navigator.of( context).pushNamed(FavoritesScreen.routeName);
                    },
                  ),

                  _profileTile(
                    icon: Icons.bookmark,
                    title: 'حجوزاتي',
                    
                    onTap: () {
                      Navigator.of(context).pushNamed(BookingsScreen.routeName);
                    },
                  ),

                  _profileTile(
                    icon: Icons.dark_mode_outlined,
                    title: 'تبديل الوضع',
                    onTap: () {
                      // تغيير الثيم على مستوى التطبيق    //nabil
                    },
                  ),

                  _profileTile(icon: Icons.logout, title: 'تسجيل الخروج', onTap: () {
                    // تسجيل الخروج من الحساب
                    Navigator.of(context).pushNamed(WelcomeScreen.routeName);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, size: 26, color: Colors.blue),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
