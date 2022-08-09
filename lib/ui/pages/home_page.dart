part of 'pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Pendaftaran Akun Berhasil",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Center(
            child: TextButton(
              child: const Text(
                "Keluar",
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () async {
                SignInSignUpResult? result = await PersonService.signOut();
                if (result!.message == "signOut") {
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
