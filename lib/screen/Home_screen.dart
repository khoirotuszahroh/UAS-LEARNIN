import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Pembelajaran CE-LOE',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'sans-serif',
      ),
      home: const LoginPage(),
    );
  }
}

// --- 1. HALAMAN LOGIN ---
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  final Color primaryColor = const Color(0xFF8B0000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  color: primaryColor,
                  child: const Center(
                    child: Icon(Icons.school, size: 100, color: Colors.white),
                  ),
                ),
                Positioned(
                  bottom: -1,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Text("Login", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: primaryColor)),
                  const SizedBox(height: 30),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Username",
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    },
                    child: const Text("LOGIN", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 2. HOME SCREEN (DASHBOARD) ---
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final Color primaryColor = const Color(0xFF8B0000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text("CE-LOE", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 40),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Selamat Datang,", style: TextStyle(color: Colors.white70, fontSize: 14)),
                SizedBox(height: 5),
                Text(
                  "DANDY CANDRA PRATAMA", 
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(25),
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: [
                _buildMenuCard(context, "Kelas Saya", Icons.class_outlined, const ClassProgressPage()),
                _buildMenuCard(context, "Mulai Quiz", Icons.quiz_outlined, const QuizPage()),
                _buildMenuCard(context, "Sertifikat", Icons.workspace_premium_outlined, null),
                _buildMenuCard(context, "Profil Saya", Icons.person_outline, const ProfileScreen()),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon, Widget? targetPage) {
    return InkWell(
      onTap: () {
        if (targetPage != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => targetPage));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 2, blurRadius: 8, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: primaryColor.withOpacity(0.1),
              radius: 30,
              child: Icon(icon, size: 30, color: primaryColor),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.school, color: Colors.white60),
          Icon(Icons.person, color: Colors.white60),
        ],
      ),
    );
  }
}

// --- 3. CLASS PROGRESS PAGE (ANIMASI) ---
class ClassProgressPage extends StatefulWidget {
  const ClassProgressPage({super.key});
  @override
  _ClassProgressPageState createState() => _ClassProgressPageState();
}

class _ClassProgressPageState extends State<ClassProgressPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final Color primaryColor = const Color(0xFF8B0000);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: primaryColor, title: const Text("Progres Kelas")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildAnimatedItem("DESAIN ANTARMUKA & UX", 0.89),
          _buildAnimatedItem("KEWARGANEGARAAN", 0.95),
          _buildAnimatedItem("SISTEM OPERASI", 0.90),
        ],
      ),
    );
  }

  Widget _buildAnimatedItem(String title, double target) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: _animation.value * target,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
              Text("${(_animation.value * target * 100).toInt()}% Selesai"),
            ],
          ),
        );
      },
    );
  }
}

// --- 4. PROFILE SCREEN ---
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  final Color primaryColor = const Color(0xFF8B0000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: primaryColor, title: const Text("Profil Saya")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            const SizedBox(height: 20),
            const Text("DANDY CANDRA PRATAMA", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage())),
              child: const Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}

// --- 5. QUIZ PAGE ---
class QuizPage extends StatelessWidget {
  const QuizPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF8B0000), title: const Text("Quiz")),
      body: const Center(child: Text("Halaman Quiz")),
    );
  }
}