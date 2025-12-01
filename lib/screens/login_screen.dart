import 'package:flutter/material.dart';
import '../app_constants.dart';
import '../widgets/custom_primary_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  
  final Map<String, String> _texts = {
    'languageOption': 'English',   
    'title': 'Login',
    'subtitle': 'Please enter your login details to log in.',
    'phone': 'Phone Number',
    'password': 'Password',
    'login': 'Log in',
    'forgotPassword': 'Forgot password?',
    'haveAccount': "Don't have an account?",
    'createAccount': 'Create account',
    'phoneRequired': 'Please enter phone number',
    'phoneLengthError': 'Phone Number must be exactly 10 digits', // رسالة جديدة
    'passwordRequired': 'Please enter password',
    'passwordLengthError': 'Password must be between 8 and 16 characters', // رسالة جديدة
  };

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {

      Navigator.of(context).pushNamed(
        AppRoutes.success,
        arguments: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // تم تثبيت اتجاه النص إلى LTR (من اليسار لليمين)
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final verticalSpacer = SizedBox(height: screenHeight * 0.03);

    return Directionality(
      textDirection: TextDirection.ltr, // تثبيت الاتجاه على LTR
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.paddingLarge),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: screenWidth > 600 ? 500 : screenWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Login', 
                          style: AppStyles.titleStyle.copyWith(
                            fontSize: AppSizes.fontSizeTitle * 0.9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        Text(
                          _texts['languageOption']!,
                          style: const TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.05),
                    // الشعار
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: screenHeight * 0.06,
                            backgroundColor: AppColors.primaryBlue,
                            child: Icon(
                              Icons.home_work_rounded,
                              size: screenHeight * 0.06,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          const Text(
                            'STAY BAY',
                            style: AppStyles.titleStyle,
                          ),
                          const Text(
                            'Dream House',
                            style: TextStyle(color: AppColors.secondaryText),
                          ),
                        ],
                      ),
                    ),

                    verticalSpacer,
                    SizedBox(height: screenHeight * 0.02),

                    // عنوان الشاشة
                    Text(
                      _texts['title']!,
                      style: AppStyles.titleStyle.copyWith(
                        fontSize: AppSizes.fontSizeTitle * 0.9,
                        color:AppColors.secondaryText,
                      ),
                      textAlign: TextAlign.left, // تثبيت المحاذاة لليسار
                    ),
                    Text(
                      _texts['subtitle']!,
                      style: const TextStyle(color: AppColors.secondaryText),
                      textAlign: TextAlign.left, // تثبيت المحاذاة لليسار
                    ),

                    SizedBox(height: screenHeight * 0.04),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // حقل رقم الهاتف (مع قيد 10 أرقام)
                          CustomTextField(
                            controller: _phoneController,
                            hintText: _texts['phone']!,
                            keyboardType: TextInputType.phone,
                            maxLength: 10, // قيد أقصى عدد أحرف
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return _texts['phoneRequired'];
                              }
                              // التحقق من أن القيمة تحتوي على 10 أرقام بالضبط
                              if (value.length != 10) {
                                return _texts['phoneLengthError'];
                              }
                              return null;
                            },
                            suffixIcon: const Icon(Icons.phone_android_outlined, color: AppColors.secondaryText),
                          ),

                          verticalSpacer,

                          // حقل كلمة المرور (مع قيد 8-16 حرفاً)
                          CustomTextField(
                            controller: _passwordController,
                            hintText: _texts['password']!,
                            isPassword: !_isPasswordVisible,
                            keyboardType: TextInputType.visiblePassword,
                            maxLength: 16, // قيد أقصى عدد أحرف
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return _texts['passwordRequired'];
                              }
                              // التحقق من أن طول القيمة بين 8 و 16
                              if (value.length < 8 || value.length > 16) {
                                return _texts['passwordLengthError'];
                              }
                              return null;
                            },
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: AppColors.secondaryText,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),

                          // نسيان كلمة المرور
                          Align(
                            alignment: Alignment.bottomRight, // تثبيت المحاذاة لليمين
                            child: TextButton(
                              onPressed: () {
                                // إجراء نسيان كلمة المرور
                              },
                              child: Text(
                                _texts['forgotPassword']!,
                                style: const TextStyle(
                                  color: AppColors.primaryBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          verticalSpacer,

                          CustomPrimaryButton(
                            text: _texts['login']!,
                            onPressed: _handleLogin,
                          ),

                          verticalSpacer,

                          // لا يوجد لديك حساب؟ (الحفاظ على مرونة الانتقال)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _texts['haveAccount']!,
                                style: const TextStyle(color: AppColors.primaryText),
                              ),
                              const SizedBox(width: 5),
                              InkWell(
                                onTap: () {
                                  // الانتقال إلى شاشة التسجيل (تم الحفاظ على الانتقال)
                                  Navigator.of(context).pushNamed(AppRoutes.signUp);
                                },
                                child: Text(
                                  _texts['createAccount']!,
                                  style: const TextStyle(
                                    color: AppColors.primaryBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import '../app_constants.dart';
// import '../widgets/custom_primary_button.dart';
// import '../widgets/custom_text_field.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();

  
//   final _phoneController = TextEditingController(); 
//   final _passwordController = TextEditingController();
  
//   bool _isPasswordVisible = false;
//   bool _isArabic = false; // حالة تحديد اللغة (افتراضياً الإنجليزية)

//   // النصوص التي تتغير حسب اللغة
//   Map<String, String> get _texts => _isArabic
//       ? {
//           'languageOption': 'English | العربية',
//           'title': 'تسجيل الدخول',
//           'subtitle': 'الرجاء إدخال بيانات الدخول الخاصة بك.',
//           'phone': 'رقم الهاتف',
//           'password': 'كلمة المرور',
//           'login': 'دخول',
//           'forgotPassword': 'نسيت كلمة المرور؟',
//           'haveAccount': 'ليس لديك حساب؟',
//           'createAccount': 'إنشاء حساب',
//           'phoneRequired': 'الرجاء إدخال رقم الهاتف',
//           'passwordRequired': 'الرجاء إدخال كلمة المرور',
//         }
//       : {
//           'languageOption': 'English | العربية',
//           'title': 'Login',
//           'subtitle': 'Please enter your login details to log in.',
//           'phone': 'Phone Number',
//           'password': 'Password',
//           'login': 'Log in',
//           'forgotPassword': 'Forgot password?',
//           'haveAccount': "Don't have an account?",
//           'createAccount': 'Create account',
//           'phoneRequired': 'Please enter phone number',
//           'passwordRequired': 'Please enter password',
//         };

//   @override
//   void dispose() {
//     _phoneController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   /// محاكاة لعملية تسجيل الدخول والانتقال إلى شاشة النجاح.
//   void _handleLogin() {
//     if (_formKey.currentState?.validate() ?? false) {
//       // الانتقال إلى شاشة النجاح مع تمرير 'true' لنجاح تسجيل الدخول
//       Navigator.of(context).pushNamed(
//         AppRoutes.success,
//         arguments: true, 
//       );
//     }
//   }
  
//   // دالة لبناء خيار اللغة
//   Widget _buildLanguageText(String text, bool isArabicOption) {
//     bool isSelected = isArabicOption ? _isArabic : !_isArabic;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _isArabic = isArabicOption;
//         });
//       },
//       child: Text(
//         text,
//         textDirection: TextDirection.ltr, // تثبيت الاتجاه للغة
//         style: TextStyle(
//           color: isSelected ? AppColors.primaryText : AppColors.secondaryText,
//           fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//           decoration: isSelected ? TextDecoration.underline : TextDecoration.none,
//           decorationColor: AppColors.primaryText,
//           decorationThickness: 2,
//           fontSize: AppSizes.fontSizeLabel,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // استخدام MediaQuery للحصول على ارتفاع وعرض الشاشة لتطبيق الاستجابة
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     // استخدام نسبة مئوية لتباعد العناصر
//     final verticalSpacer = SizedBox(height: screenHeight * 0.03); 

//     // تحديد اتجاه النص العام بناءً على اللغة المختارة
//     return Directionality(
//       textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
//       child: Scaffold(
//         body: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(AppSizes.paddingLarge),
//             child: Center(
//               // تحديد أقصى عرض للواجهة على الشاشات الكبيرة
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(maxWidth: screenWidth > 600 ? 500 : screenWidth),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     // دعم اللغة (الآن مع إمكانية التبديل)
//                     Align(
//                       alignment: Alignment.topRight,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           _buildLanguageText('English', false),
//                           const SizedBox(width: AppSizes.paddingSmall),
//                           _buildLanguageText('العربية', true),
//                         ],
//                       ),
//                     ),
                    
//                     SizedBox(height: screenHeight * 0.05),
                    
//                     // الشعار
//                     Align(
//                       alignment: Alignment.center,
//                       child: Column(
//                         children: [
//                           CircleAvatar(
//                             radius: screenHeight * 0.06,
//                             backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
//                             child: Icon(
//                               Icons.home_work_rounded,
//                               size: screenHeight * 0.06,
//                               color: AppColors.primaryBlue,
//                             ),
//                           ),
//                           SizedBox(height: screenHeight * 0.01),
//                           const Text(
//                             'STAY BAY',
//                             style: AppStyles.titleStyle,
//                           ),
//                           const Text(
//                             'Dream House',
//                             style: TextStyle(color: AppColors.secondaryText),
//                           ),
//                         ],
//                       ),
//                     ),

//                     verticalSpacer,
//                     SizedBox(height: screenHeight * 0.02),

//                     // عنوان الشاشة
//                     Text(
//                       _texts['title']!,
//                       style: AppStyles.titleStyle.copyWith(
//                         fontSize: AppSizes.fontSizeTitle * 0.9,
//                       ),
//                       textAlign: _isArabic ? TextAlign.right : TextAlign.left,
//                     ),
//                     Text(
//                       _texts['subtitle']!,
//                       style: const TextStyle(color: AppColors.secondaryText),
//                       textAlign: _isArabic ? TextAlign.right : TextAlign.left,
//                     ),

//                     SizedBox(height: screenHeight * 0.04),

//                     Form(
//                       key: _formKey,
//                       child: Column(
//                         children: [
//                           // حقل رقم الهاتف (باستخدام CustomTextField)
//                           CustomTextField(
//                             controller: _phoneController,
//                             hintText: _texts['phone']!,
//                             // تغيير نوع لوحة المفاتيح إلى رقم الهاتف
//                             keyboardType: TextInputType.phone, 
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return _texts['phoneRequired'];
                                
//                               }
//                               return null;
//                             },
//                             suffixIcon: const Icon(Icons.phone_android_outlined, color: AppColors.secondaryText),
//                           ),

//                           verticalSpacer,
//                           // حقل كلمة المرور (باستخدام CustomTextField)
//                           CustomTextField(
//                             controller: _passwordController,
//                             hintText: _texts['password']!,
//                             isPassword: !_isPasswordVisible,
//                             keyboardType: TextInputType.visiblePassword,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return _texts['passwordRequired'];
//                               }
//                               return null;
//                             },
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                                 color: AppColors.secondaryText,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _isPasswordVisible = !_isPasswordVisible;
//                                 });
//                               },
//                             ),
//                           ),
                          
//                           // تم حذف SizedBox(height: AppSizes.paddingSmall)
                          
//                           // نسيان كلمة المرور
//                           Align(
//                             alignment: _isArabic ? Alignment.bottomLeft : Alignment.bottomRight,
//                             child: TextButton(
//                               onPressed: () {
//                                 // إجراء نسيان كلمة المرور
//                               },
//                               child: Text(
//                                 _texts['forgotPassword']!,
//                                 style: const TextStyle(
//                                   color: AppColors.primaryBlue,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
                          

//                           verticalSpacer,

//                           CustomPrimaryButton(
//                             text: _texts['login']!,
//                             onPressed: _handleLogin,
//                           ),
                          
//                           verticalSpacer,

//                           // لا يوجد لديك حساب؟
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 _texts['haveAccount']!,
//                                 style: const TextStyle(color: AppColors.primaryText),
//                               ),
//                               const SizedBox(width: 5),
//                               InkWell(
//                                 onTap: () {
//                                   // الانتقال إلى شاشة التسجيل
//                                   Navigator.of(context).pushNamed(AppRoutes.signUp);
//                                 },
//                                 child: Text(
//                                   _texts['createAccount']!,
//                                   style: const TextStyle(
//                                     color: AppColors.primaryBlue,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

