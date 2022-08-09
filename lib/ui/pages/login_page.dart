part of 'pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool? isEmailValid;
  bool? isPasswordValid;
  bool showPassword = false, isCallingApi = false;

  @override
  Widget build(BuildContext context) {
    DateTime? lastPressed;
    return Scaffold(
      body: LoadingOverlay(
        isLoading: isCallingApi,
        progressIndicator: const CircularProgressIndicator(
          color: AppColor.primary,
        ),
        color: AppColor.black,
        child: WillPopScope(
          onWillPop: () async {
            final now = DateTime.now();
            const maxDuration = Duration(seconds: 2);
            final isWarning = lastPressed == null ||
                now.difference(lastPressed!) > maxDuration;

            if (isWarning) {
              lastPressed = DateTime.now();

              ToastAlert().showToastCenter("Tap sekali lagi untuk keluar");

              return false;
            } else {
              return true;
            }
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/roketin_logo.png"),
                    TextButton(
                      child: const Text(
                        "Get It Now",
                        style: TextStyle(fontSize: 50, color: AppColor.primary),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ));
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            isDense: true,
                            hintText: 'Username Pengguna Roketin',
                            errorText:
                                isEmailValid != true && isEmailValid != null
                                    ? 'Harus lebih dari 5 karakter'
                                    : null,
                          ),
                          onChanged: (value) => {
                            setState(() {
                              if (!(value.length > 5) && value.isNotEmpty) {
                                isEmailValid = false;
                              } else {
                                isEmailValid = true;
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
                    PrimaryButton(
                      title: "Daftar",
                      onPressed: () async {
                        setState(() {
                          isCallingApi = true;
                        });

                        if (isEmailValid != true ||
                            isEmailValid == null && isPasswordValid != true ||
                            isPasswordValid == null) {
                          ToastAlert().showToastWarningTop(
                              "Harap lengkapi data pengguna");
                        } else {
                          SignInSignUpResult? result =
                              await PersonService.signIn(
                            password: passwordController.text,
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
