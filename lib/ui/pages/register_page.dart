part of 'pages.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool? isUsernameValid;
  bool? isPasswordValid;
  bool? isConfirmPasswordValid;
  bool showPassword = false, showConfirmPassword = false, isCallingApi = false;
  bool? isPhoneNumberValid;
  bool? isEmailValid;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: LoadingOverlay(
        isLoading: isCallingApi,
        progressIndicator: const CircularProgressIndicator(
          color: AppColor.primary,
        ),
        color: AppColor.black,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.defaultPadding),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        const Text(
                          "Daftar Akun",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColor.black,
                          ),
                        ),
                        const Text(
                          "Daftar untuk memulai pengalaman belajar super seru",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColor.black,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Username",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColor.black,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            TextField(
                              controller: usernameController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                isDense: true,
                                hintText: 'Username Pengguna Roketin',
                                errorText: isUsernameValid != true &&
                                        isUsernameValid != null
                                    ? 'Harus lebih dari 5 karakter'
                                    : null,
                              ),
                              onChanged: (value) => {
                                setState(() {
                                  if (!(value.length > 5) && value.isNotEmpty) {
                                    isUsernameValid = false;
                                  } else {
                                    isUsernameValid = true;
                                  }
                                }),
                              },
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Kata Sandi",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColor.black,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            TextField(
                              controller: passwordController,
                              obscureText: !showPassword,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  child: Icon(
                                    Icons.remove_red_eye,
                                    size: 26,
                                    color: showPassword
                                        ? AppColor.primary
                                        : AppColor.grey,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                isDense: true,
                                hintText: 'Masukkan kata sandi',
                                errorText: isPasswordValid != true &&
                                        isPasswordValid != null
                                    ? 'Harus lebih dari 5 karakter'
                                    : null,
                              ),
                              onChanged: (value) => {
                                setState(() {
                                  if (!(value.length > 5) && value.isNotEmpty) {
                                    isPasswordValid = false;
                                  } else {
                                    isPasswordValid = true;
                                  }
                                }),
                              },
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Konfirmasi Kata Sandi",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColor.black,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            TextField(
                              controller: confirmPasswordController,
                              obscureText: !showConfirmPassword,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showConfirmPassword =
                                          !showConfirmPassword;
                                    });
                                  },
                                  child: Icon(
                                    Icons.remove_red_eye,
                                    size: 26,
                                    color: showConfirmPassword
                                        ? AppColor.primary
                                        : AppColor.grey,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                isDense: true,
                                hintText: 'Konfirmasi kata sandi',
                                errorText: isConfirmPasswordValid != true &&
                                        isConfirmPasswordValid != null
                                    ? 'Kata sandi yang dimasukkan tidak sama'
                                    : null,
                              ),
                              onChanged: (value) => {
                                setState(() {
                                  if (confirmPasswordController.text !=
                                      passwordController.text) {
                                    isConfirmPasswordValid = false;
                                  } else {
                                    isConfirmPasswordValid = true;
                                  }
                                }),
                              },
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Nomer HP",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColor.black,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            TextField(
                              controller: phoneNumberController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                isDense: true,
                                hintText: '08123456789',
                                errorText: isPhoneNumberValid != true &&
                                        isPhoneNumberValid != null
                                    ? 'Nomer hp belum valid'
                                    : null,
                              ),
                              onChanged: (value) => {
                                setState(() {
                                  if (!(value.length > 9) && value.isNotEmpty) {
                                    isPhoneNumberValid = false;
                                  } else {
                                    isPhoneNumberValid = true;
                                  }
                                }),
                              },
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        const Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColor.black,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            isDense: true,
                            hintText: 'david@gmail.com',
                            errorText:
                                isEmailValid != true && isEmailValid != null
                                    ? 'Email tidak valid'
                                    : null,
                          ),
                          onChanged: (value) => {
                            setState(() {
                              if (EmailValidator.validate(value) != false) {
                                isEmailValid = true;
                              } else {
                                isEmailValid = false;
                              }
                            }),
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    PrimaryButton(
                      title: "Daftar",
                      onPressed: () async {
                        setState(() {
                          isCallingApi = true;
                        });

                        if (isUsernameValid != true ||
                            isUsernameValid == null &&
                                isPasswordValid != true ||
                            isPasswordValid == null &&
                                isConfirmPasswordValid != true ||
                            isConfirmPasswordValid == null &&
                                isPhoneNumberValid != true ||
                            isPhoneNumberValid == null &&
                                isEmailValid != true ||
                            isEmailValid == null) {
                          ToastAlert().showToastWarningTop(
                              "Harap lengkapi data pengguna");
                        } else {
                          SignInSignUpResult? result =
                              await PersonService.signUp(
                            username: usernameController.text,
                            password: passwordController.text,
                            phoneNumber: phoneNumberController.text,
                            email: emailController.text,
                          );

                          if (result != null) {
                            if (result.message != null) {
                              ToastAlert().showToastWarningTop(
                                  result.message.toString());
                            } else {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                              );
                            }
                          }
                        }

                        setState(() {
                          isCallingApi = false;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: HorizontalLine(),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: const Text(
                                "atau masuk dengan",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.grey,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: HorizontalLine(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          width: size.width,
                          height: 45,
                          child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  isCallingApi = true;
                                });

                                SignInSignUpResult? result =
                                    await PersonService.signInWithGoogle(
                                        context: context);

                                if (result != null) {
                                  if (result.person != null) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage(),
                                        ));
                                  } else {
                                    ToastAlert().showToastWarningTop(
                                        result.message.toString());
                                  }
                                }

                                setState(() {
                                  isCallingApi = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: AppColor.white,
                                onPrimary: AppColor.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/google.svg",
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  const Text(
                                    "Masuk dengan Google",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    )
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
