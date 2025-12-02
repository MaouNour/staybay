import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_primary_button.dart';
import '../app_theme.dart';

class SignUpScreen extends StatefulWidget {
  
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordObscured = true;
  // تم حذف متغير _isArabic حيث تم تثبيت اللغة على الإنجليزية
  
  String? _profileImagePath;
  String? _identityImagePath;

  // Controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  // النصوص الثابتة بالإنجليزية
  final Map<String, String> _texts = {
    'title': 'Sign Up',
    'firstName': 'First Name',
    'lastName': 'Last Name',
    'phone': 'Phone Number',
    'password': 'Password',
    'dob': 'Date of Birth',
    'idImage': 'Identity Image',
    'selectImage': 'Select Image',
    'resetImage': 'Reset',
    'signUp': 'Sign Up',
    'haveAccount': 'Already have an account?',
    'login': 'Login',
    // رسائل التحقق الجديدة
    'required': 'This field is required',
    'nameLengthError': 'Max 20 characters allowed',
    'phoneRequired': 'Please enter phone number',
    'phoneLengthError': 'Phone Number must be exactly 10 digits',
    'passwordRequired': 'Please enter password',
    'passwordLengthError': 'Password must be between 8 and 16 characters',
    'profileRequired': 'Please select profile image.',
    'idRequired': 'Please select identity image.',
    'allRequired': 'Please fill all required fields',
    'imageSelected': 'Image selected successfully',
  };

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  // دالة لاختيار تاريخ الميلاد
  Future<void> _selectDateOfBirth() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('en'), // تم تثبيت اللغة على الإنجليزية
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: AppTheme.lightTheme.copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryBlue,
              onPrimary: Colors.white,
              onSurface: AppColors.primaryText,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        _dateOfBirthController.text =
            "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
      });
    }
  }

  // دالة وهمية لاختيار صورة من المعرض
  void _pickImage(bool isProfile) {
    setState(() {
      final String mockPath = 'Image path: ${DateTime.now().second}';
      if (isProfile) {
        _profileImagePath = mockPath;
        } else {
        _identityImagePath = mockPath;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(_texts['imageSelected']!)),
    );
  }

  // دالة وهمية لإعادة تعيين الصورة
  void _resetImage(bool isProfile) {
    setState(() {
      if (isProfile) {
        _profileImagePath = null;
      } else {
        _identityImagePath = null;
      }
    });
  }
  // منطق عملية التسجيل
  void _handleSignUp() {
    // 1. التحقق من صحة جميع حقول النموذج
    if (_formKey.currentState?.validate() ?? false) {
      // 2. التحقق من اختيار الصور
      if (_profileImagePath == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_texts['profileRequired']!)),
        );
        return;
      }
      if (_identityImagePath == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_texts['idRequired']!)),
        );
        return;
      }

      // إذا كانت جميع الحقول والملفات مختارة، ننفذ التنقل إلى شاشة النجاح
      Navigator.of(context).pushNamed(
        AppRoutes.success,
        arguments: false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_texts['allRequired']!)),
      );
    }
  }

  // دالة لبناء واجهة اختيار الصورة (تم تثبيت النصوص الإنجليزية)
  Widget _buildImagePickerField(
      String labelText, String? imagePath, VoidCallback onSelect, VoidCallback onReset) {
    bool isImageSelected = imagePath != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: AppStyles.labelStyle),
        const SizedBox(height: AppSizes.paddingSmall),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                isImageSelected
                    ? 'Image Selected' // تم تثبيت النص
                    : 'No image selected yet', // تم تثبيت النص
                style: TextStyle(
                  color: isImageSelected ? AppColors.primaryBlue : AppColors.secondaryText,
                  fontStyle: isImageSelected ? FontStyle.normal : FontStyle.italic,
                  fontSize: AppSizes.fontSizeLabel,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: AppSizes.paddingSmall),
            // زر اختيار صورة
            OutlinedButton.icon(
              onPressed: onSelect,
              icon: const Icon(Icons.file_upload_outlined, size: 18),
              label: Text(_texts['selectImage']!),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryBlue,
                side: const BorderSide(color: AppColors.primaryBlue),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadiusSmall)),
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSmall, vertical: 0),
              ),
            ),
            const SizedBox(width: 5),
            // زر إعادة تعيين الصورة
            if (isImageSelected)
              OutlinedButton(
                onPressed: onReset,
                child: Text(_texts['resetImage']!),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.errorRed,
                  side: const BorderSide(color: AppColors.errorRed),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadiusSmall)),
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSmall, vertical: 0),
                ),
              ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.ltr, // تم تثبيت الاتجاه على LTR
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMedium,
              vertical: AppSizes.paddingLarge
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: screenWidth > 600 ? 500 : screenWidth),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth > 600 ? AppSizes.paddingLarge : 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 1. العنوان واللغة (تم تثبيت الإنجليزية وحذف خيار التبديل)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_texts['title']!, style: AppStyles.titleStyle),
                          // تم حذف الـ Row الخاص باللغة العربية والانجليزية
                          Text(
                            'English', // عرض اللغة الإنجليزية فقط
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.bold,
                              fontSize: AppSizes.fontSizeLabel,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.paddingExtraLarge),

                      // 2. صورة الملف الشخصي التفاعلية
                      Center(
                        child: GestureDetector(
                          onTap: () => _pickImage(true), 
                          child: Stack(
                            alignment: Alignment.bottomRight, // تثبيت الاتجاه لـ LTR
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: _profileImagePath != null
                                    ? AppColors.primaryBlue.withOpacity(0.1) 
                                    : Colors.grey[300],
                                foregroundImage: _profileImagePath != null
                                  ? const AssetImage('assets/profile_placeholder.png')
                                  : null,
                                child: _profileImagePath == null ? Icon(
                                  Icons.person,
                                  size: 50,
                                  color: AppColors.primaryBlue,
                                ) : null,
                                ),
                               Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryBlue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (_profileImagePath != null)
                        Center(
                          child: TextButton(
                            onPressed: () => _resetImage(true),
                            child: Text(_texts['resetImage']!, style: const TextStyle(color: AppColors.errorRed)),
                          ),
                        ),
                      const SizedBox(height: AppSizes.paddingExtraLarge),

                      // 3. حقول الإدخال (مع قيود التحقق الجديدة)
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // الاسم الأول (قيد 20 حرفاً)
                            CustomTextField(
                              controller: _firstNameController,
                              hintText: _texts['firstName']!,
                              keyboardType: TextInputType.text,
                              maxLength: 20, // قيد 20 حرفاً
                              suffixIcon: const Icon(Icons.person_outline, color: AppColors.secondaryText),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return _texts['required'];
                                }
                                if (value.length > 20) {
                                  return _texts['nameLengthError'];
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: AppSizes.paddingMedium),

                            // الاسم الأخير (قيد 20 حرفاً)
                            CustomTextField(
                              controller: _lastNameController,
                              hintText: _texts['lastName']!,
                              keyboardType: TextInputType.text,
                              maxLength: 20, // قيد 20 حرفاً
                              suffixIcon: const Icon(Icons.person_outline, color: AppColors.secondaryText),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return _texts['required'];
                                }
                                if (value.length > 20) {
                                  return _texts['nameLengthError'];
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: AppSizes.paddingMedium),

                            // رقم الهاتف (قيد 10 أرقام بالضبط)
                            CustomTextField(
                              controller: _phoneController,
                              hintText: _texts['phone']!,
                              keyboardType: TextInputType.phone,
                              maxLength: 10, // قيد 10 أرقام
                              suffixIcon: const Icon(Icons.phone_android_outlined, color: AppColors.secondaryText),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return _texts['phoneRequired'];
                                }
                                if (value.length != 10) {
                                  return _texts['phoneLengthError'];
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: AppSizes.paddingMedium),

                            // كلمة المرور (قيد 8-16 حرفاً)
                            CustomTextField(
                              controller: _passwordController,
                              hintText: _texts['password']!,
                              isPassword: _isPasswordObscured,
                              maxLength: 16, // قيد 16 حرفاً
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return _texts['passwordRequired'];
                                }
                                if (value.length < 8 || value.length > 16) {
                                  return _texts['passwordLengthError'];
                                }
                                return null;
                              },
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                  color: AppColors.secondaryText,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordObscured = !_isPasswordObscured;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: AppSizes.paddingMedium),

                            // حقل تاريخ الميلاد
                            CustomTextField(
                              controller: _dateOfBirthController,
                              hintText: _texts['dob']!,
                              maxLength: 16,
                              keyboardType: TextInputType.datetime,
                              readOnly: true,
                              onTap: _selectDateOfBirth,
                              validator: (value) => (value == null || value.isEmpty) ? _texts['required'] : null,
                              suffixIcon: const Icon(Icons.calendar_today, color: AppColors.secondaryText),
                            ),
                            const SizedBox(height: AppSizes.paddingMedium),
                          ],
                        ),
                      ),
                      
                      // حقل صورة الهوية
                      _buildImagePickerField(_texts['idImage']!, _identityImagePath,
                          () => _pickImage(false), () => _resetImage(false)),
                      const SizedBox(height: AppSizes.paddingExtraLarge),

                      // 4. زر التسجيل (Sign Up Button)
                      CustomPrimaryButton(
                        text: _texts['signUp']!,
                        onPressed: _handleSignUp,
                      ),
                      const SizedBox(height: AppSizes.paddingMedium),

                      // 5. رابط "Login" (الحفاظ على الانتقال)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_texts['haveAccount']!,
                              style: const TextStyle(color: AppColors.secondaryText)),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              // تم الحفاظ على التنقل إلى شاشة تسجيل الدخول
                              Navigator.of(context).pushNamed(AppRoutes.login);
                            },
                            child: Text(
                              _texts['login']!,
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
// import '../widgets/custom_text_field.dart';
// import '../widgets/custom_primary_button.dart';
// import '../app_theme.dart';

// class SignUpScreen extends StatefulWidget {
  
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();
//   bool _isPasswordObscured = true;
//   bool _isArabic = false; // حالة تحديد اللغة
  
//   String? _profileImagePath;
//   String? _identityImagePath;

//   // Controllers
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _dateOfBirthController = TextEditingController();

//   // النصوص التي تتغير حسب اللغة
//   Map<String, String> get _texts => _isArabic
//       ? {
//           'title': 'إنشاء حساب',
//           'firstName': 'الاسم الأول',
//           'lastName': 'الاسم الأخير',
//           'phone': 'رقم الهاتف',
//           'password': 'كلمة المرور',
//           'dob': 'تاريخ الميلاد',
//           'idImage': 'صورة الهوية',
//           'selectImage': 'اختيار صورة',
//           'resetImage': 'إعادة تعيين',
//           'signUp': 'تسجيل',
//           'haveAccount': 'هل لديك حساب بالفعل؟',
//           'login': 'تسجيل الدخول',
//           'required': 'هذا الحقل مطلوب',
//           'profileRequired': 'الرجاء اختيار صورة الملف الشخصي.',
//           'idRequired': 'الرجاء اختيار صورة الهوية.',
//           'allRequired': 'الرجاء إدخال جميع الحقول المطلوبة',
//           'imageSelected': 'تم اختيار الصورة بنجاح',
//         }
//       : {
//           'title': 'Sign Up',
//           'firstName': 'First Name',
//           'lastName': 'Last Name',
//           'phone': 'Phone Number',
//           'password': 'Password',
//           'dob': 'Date of Birth',
//           'idImage': 'Identity Image',
//           'selectImage': 'Select Image',
//           'resetImage': 'Reset',
//           'signUp': 'Sign Up',
//           'haveAccount': 'Already have an account?',
//           'login': 'Login',
//           'required': 'This field is required',
//           'profileRequired': 'Please select profile image.',
//           'idRequired': 'Please select identity image.',
//           'allRequired': 'Please fill all required fields',
//           'imageSelected': 'Image selected successfully',
//         };

//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _phoneController.dispose();
//     _passwordController.dispose();
//     _dateOfBirthController.dispose();
//     super.dispose();
//   }

//   // دالة لاختيار تاريخ الميلاد
//   Future<void> _selectDateOfBirth() async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//       locale: Locale(_isArabic ? 'ar' : 'en'), 
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: AppTheme.lightTheme.copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: AppColors.primaryBlue,
//               onPrimary: Colors.white,
//               onSurface: AppColors.primaryText,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (pickedDate != null) {
//       setState(() {
//         _dateOfBirthController.text =
//             "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
//       });
//     }
//   }
//   // دالة وهمية لاختيار صورة من المعرض
//   void _pickImage(bool isProfile) {
//     setState(() {
//       final String mockPath = 'Image path: ${DateTime.now().second}';
//       if (isProfile) {
//         _profileImagePath = mockPath;
//         } else {
//         _identityImagePath = mockPath;
//       }
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(_texts['imageSelected']!)),
//     );
//   }

//   // دالة وهمية لإعادة تعيين الصورة
//   void _resetImage(bool isProfile) {
//     setState(() {
//       if (isProfile) {
//         _profileImagePath = null;
//       } else {
//         _identityImagePath = null;
//       }
//     });
//   }

//   // منطق عملية التسجيل
//   void _handleSignUp() {
//     // 1. التحقق من صحة جميع حقول النموذج
//     if (_formKey.currentState?.validate() ?? false) {
//       // 2. التحقق من اختيار الصور
//       if (_profileImagePath == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(_texts['profileRequired']!)),
//         );
//         return;
//       }
//       if (_identityImagePath == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(_texts['idRequired']!)),
//         );
//         return;
//       }

//       // إذا كانت جميع الحقول والملفات مختارة، ننفذ التنقل إلى شاشة النجاح
//       // هذا هو السطر الذي ينقلك إلى شاشة النجاح
//       Navigator.of(context).pushNamed(
//         AppRoutes.success,
//         arguments: false, // تمرير false للإشارة إلى نجاح التسجيل وليس الدخول
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(_texts['allRequired']!)),
//       );
//     }
//   }

//   // دالة لبناء واجهة اختيار الصورة
//   Widget _buildImagePickerField(
//       String labelText, String? imagePath, VoidCallback onSelect, VoidCallback onReset) {
//     bool isImageSelected = imagePath != null;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(labelText, style: AppStyles.labelStyle),
//         const SizedBox(height: AppSizes.paddingSmall),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Text(
//                 isImageSelected
//                     ? _isArabic ? 'تم اختيار صورة' : 'Image Selected'
//                     : _isArabic ? 'لم يتم اختيار صورة بعد' : 'No image selected yet',
//                 style: TextStyle(
//                   color: isImageSelected ? AppColors.primaryBlue : AppColors.secondaryText,
//                   fontStyle: isImageSelected ? FontStyle.normal : FontStyle.italic,
//                   fontSize: AppSizes.fontSizeLabel,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             const SizedBox(width: AppSizes.paddingSmall),
//             // زر اختيار صورة
//             OutlinedButton.icon(
//               onPressed: onSelect,
//               icon: const Icon(Icons.file_upload_outlined, size: 18),
//               label: Text(_texts['selectImage']!),
//               style: OutlinedButton.styleFrom(
//                 foregroundColor: AppColors.primaryBlue,
//                 side: const BorderSide(color: AppColors.primaryBlue),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadiusSmall)),
//                 padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSmall, vertical: 0),
//               ),
//             ),
//             const SizedBox(width: 5),
//             // زر إعادة تعيين الصورة
//             if (isImageSelected)
//               OutlinedButton(
//                 onPressed: onReset,
//                 child: Text(_texts['resetImage']!),
//                 style: OutlinedButton.styleFrom(
//                   foregroundColor: AppColors.errorRed,
//                   side: const BorderSide(color: AppColors.errorRed),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.borderRadiusSmall)),
//                   padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSmall, vertical: 0),
//                 ),
//               ),
//           ],
//         ),
//       ],
//     );
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
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Directionality(
//       textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
//       child: Scaffold(
//         backgroundColor: AppColors.backgroundColor,
//         body: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(
//               horizontal: AppSizes.paddingMedium, 
//               vertical: AppSizes.paddingLarge
//             ),
//             child: Center(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(maxWidth: screenWidth > 600 ? 500 : screenWidth),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: screenWidth > 600 ? AppSizes.paddingLarge : 0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       // 1. العنوان واللغة
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(_texts['title']!, style: AppStyles.titleStyle),
//                           Row(
//                             children: [
//                               _buildLanguageText('English', false),
//                               const SizedBox(width: AppSizes.paddingSmall),
//                               _buildLanguageText('العربية', true),
//                             ],
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: AppSizes.paddingExtraLarge),

//                       // 2. صورة الملف الشخصي التفاعلية
//                       Center(
//                         child: GestureDetector(
//                           onTap: () => _pickImage(true), 
//                           child: Stack(
//                             alignment: _isArabic ? Alignment.bottomLeft : Alignment.bottomRight,
//                             children: [
//                               CircleAvatar(
//                                 radius: 50,
//                                 backgroundColor: _profileImagePath != null
//                                     ? AppColors.primaryBlue.withOpacity(0.1) 
//                                     : Colors.grey[300],
//                                 foregroundImage: _profileImagePath != null
//                                   ? const AssetImage('assets/profile_placeholder.png')
//                                   : null,
//                                 child: _profileImagePath == null ? Icon(
//                                   Icons.person,
//                                   size: 50,
//                                   color: AppColors.primaryBlue,
//                                 ) : null,
//                                 ),
//                               Positioned(
//                                 right: _isArabic ? null : 0,
//                                 left: _isArabic ? 0 : null,
//                                 bottom: 0,
//                                 child: Container(
//                                   padding: const EdgeInsets.all(4),
//                                   decoration: const BoxDecoration(
//                                     color: AppColors.primaryBlue,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       if (_profileImagePath != null)
//                         Center(
//                           child: TextButton(
//                             onPressed: () => _resetImage(true),
//                             child: Text(_texts['resetImage']!, style: const TextStyle(color: AppColors.errorRed)),
//                           ),
//                         ),
//                       const SizedBox(height: AppSizes.paddingExtraLarge),

//                       // 3. حقول الإدخال
//                       Form(
//                         key: _formKey,
//                         child: Column(
//                           children: [
//                             CustomTextField(
//                               controller: _firstNameController,
//                               hintText: _texts['firstName']!,
//                               keyboardType: TextInputType.text,
//                               suffixIcon: const Icon(Icons.person_outline, color: AppColors.secondaryText),
//                               validator: (value) => (value == null || value.isEmpty) ? _texts['required'] : null,
//                             ),
//                             const SizedBox(height: AppSizes.paddingMedium),

//                             CustomTextField(
//                               controller: _lastNameController,
//                               hintText: _texts['lastName']!,
//                               keyboardType: TextInputType.text,
//                               suffixIcon: const Icon(Icons.person_outline, color: AppColors.secondaryText),
//                               validator: (value) => (value == null || value.isEmpty) ? _texts['required'] : null,
//                             ),
//                             const SizedBox(height: AppSizes.paddingMedium),

//                             CustomTextField(
//                               controller: _phoneController,
//                               hintText: _texts['phone']!,
//                               keyboardType: TextInputType.phone,
//                               suffixIcon: const Icon(Icons.phone_android_outlined, color: AppColors.secondaryText),
//                               validator: (value) => (value == null || value.isEmpty) ? _texts['required'] : null,
//                             ),
//                             const SizedBox(height: AppSizes.paddingMedium),

//                             CustomTextField(
//                               controller: _passwordController,
//                               hintText: _texts['password']!,
//                               isPassword: _isPasswordObscured,
//                               validator: (value) => (value == null || value.isEmpty) ? _texts['required'] : null,
//                               suffixIcon: IconButton(
//                                 icon: Icon(
//                                   _isPasswordObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
//                                   color: AppColors.secondaryText,
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     _isPasswordObscured = !_isPasswordObscured;
//                                   });
//                                 },
//                               ),
//                             ),
//                             const SizedBox(height: AppSizes.paddingMedium),
//                             // حقل تاريخ الميلاد
//                             CustomTextField(
//                               controller: _dateOfBirthController,
//                               hintText: _texts['dob']!,
//                               keyboardType: TextInputType.datetime,
//                               readOnly: true,
//                               onTap: _selectDateOfBirth,
//                               validator: (value) => (value == null || value.isEmpty) ? _texts['required'] : null,
//                               suffixIcon: const Icon(Icons.calendar_today, color: AppColors.secondaryText),
//                             ),
//                             const SizedBox(height: AppSizes.paddingMedium),
//                           ],
//                         ),
//                       ),
                      
//                       // حقل صورة الهوية
//                       _buildImagePickerField(_texts['idImage']!, _identityImagePath,
//                           () => _pickImage(false), () => _resetImage(false)),
//                       const SizedBox(height: AppSizes.paddingExtraLarge),

//                       // 4. زر التسجيل (Sign Up Button)
//                       CustomPrimaryButton(
//                         text: _texts['signUp']!,
//                         onPressed: _handleSignUp,
//                       ),
//                       const SizedBox(height: AppSizes.paddingMedium),

//                       // 5. رابط "Login"
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(_texts['haveAccount']!,
//                               style: const TextStyle(color: AppColors.secondaryText)),
//                           const SizedBox(width: 5),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.of(context).pushNamed(AppRoutes.login);
//                             },
//                             child: Text(
//                               _texts['login']!,
//                               style: const TextStyle(
//                                 color: AppColors.primaryBlue,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
