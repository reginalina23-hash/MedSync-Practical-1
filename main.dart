// main.dart
import 'package:flutter/material.dart';
String registeredEmail = '';
String registeredPassword = '';

void main() {
  runApp(const MedSyncApp());
}

// MEDSYNC — Smart Medication Scheduling and Reminder Mobile Application
// Single-file Practical 1 version. Data is kept in memory while the app is open.
// The splash screen is ready for a video to be added later.

const Color medBlue = Color(0xFF075FC4);
const Color medDarkBlue = Color(0xFF082B63);
const Color medRed = Color(0xFFEF3340);
const Color medPaleBlue = Color(0xFFEAF6FF);
const Color medBackground = Colors.transparent;
const Color medText = Color(0xFF173B5E);
const Color medMuted = Color(0xFF71869A);

class MedSyncApp extends StatelessWidget {
  const MedSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedSync',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: medBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: medBlue,
          primary: medBlue,
          error: medRed,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          foregroundColor: medDarkBlue,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: medDarkBlue,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF7FBFE),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 15,
          ),
          hintStyle: const TextStyle(color: Color(0xFF9AAFC0), fontSize: 13),
          labelStyle: const TextStyle(color: medMuted, fontSize: 13),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: Color(0xFFDCEAF5)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: Color(0xFFDCEAF5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: medBlue, width: 1.5),
          ),
        ),
      ),
      builder: (context, child) => Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/image/medsync_background.png',
            fit: BoxFit.cover,
          ),
          if (child != null) child,
        ],
      ),
      home: const SplashScreen(),
    );
  }
}

ButtonStyle medButton({Color color = medBlue}) {
  return ElevatedButton.styleFrom(
    backgroundColor: color,
    foregroundColor: Colors.white,
    elevation: 0,
    minimumSize: const Size(double.infinity, 49),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
  );
}

Widget brandMark({double size = 54}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: const Color(0xFFFFEEF0),
      borderRadius: BorderRadius.circular(size * .28),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.favorite, color: medRed, size: size * .77),
        Icon(Icons.monitor_heart, color: Colors.white, size: size * .48),
        Positioned(
          right: size * .02,
          bottom: size * .02,
          child: Container(
            decoration: const BoxDecoration(
              color: medBlue,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(size * .035),
            child: Icon(Icons.add, color: Colors.white, size: size * .22),
          ),
        ),
      ],
    ),
  );
}

Widget fieldLabel(String text) => Padding(
  padding: const EdgeInsets.only(bottom: 7),
  child: Text(
    text,
    style: const TextStyle(
      color: medText,
      fontWeight: FontWeight.w700,
      fontSize: 12,
    ),
  ),
);

Widget pageHeading(String title, String subtitle) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      title,
      style: const TextStyle(
        color: medDarkBlue,
        fontSize: 23,
        fontWeight: FontWeight.w900,
      ),
    ),
    const SizedBox(height: 5),
Text(
  subtitle,
  style: const TextStyle(
    color: Color(0xFF405875),
    fontSize: 13,
    fontWeight: FontWeight.w700,
  ),
),  ],
);

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
  );
}

// DATA MODEL
class Medication {
  String name;
  String dosage;
  String frequency;
  String startDate;
  String endDate;
  List<String> times;
  bool active;

  Medication({
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.startDate,
    required this.endDate,
    required this.times,
    this.active = true,
  });
}

final List<Medication> medStore = [
  Medication(
    name: 'Paracetamol 500mg',
    dosage: '1 tablet',
    frequency: '3 times daily',
    startDate: '20 Nov 2026',
    endDate: '',
    times: ['08:00 AM', '02:00 PM', '08:00 PM'],
  ),
  Medication(
    name: 'Vitamin D 1000IU',
    dosage: '1 capsule',
    frequency: 'Once daily',
    startDate: '20 Nov 2026',
    endDate: '',
    times: ['08:00 AM'],
  ),
  Medication(
    name: 'Amoxicillin 500mg',
    dosage: '1 capsule',
    frequency: '3 times daily',
    startDate: '20 Nov 2026',
    endDate: '25 Nov 2026',
    times: ['08:00 AM', '02:00 PM', '08:00 PM'],
  ),
  Medication(
    name: 'Atorvastatin 20mg',
    dosage: '1 tablet',
    frequency: 'Once daily',
    startDate: '20 Nov 2026',
    endDate: '',
    times: ['08:00 PM'],
  ),
];


// 1. SPLASH SCREEN
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/image/medsync_splash_background.png',
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 20,
              ),
              child: Column(
                children: [
                  const Spacer(flex: 1),

                  Transform.translate(
                    offset: const Offset(0, -50),
                    child: Column(
                      children: [
                        brandMark(size: 112),
                        const SizedBox(height: 18),

                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 39,
                              fontWeight: FontWeight.w900,
                            ),
                            children: [
                              TextSpan(
                                text: 'Med',
                                style: TextStyle(color: medRed),
                              ),
                              TextSpan(
                                text: 'Sync',
                                style: TextStyle(color: medBlue),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 5),

                        const Text(
                          'Smart Medication Management',
                          style: TextStyle(
                            color: medDarkBlue,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: 28),

                        const Text(
                          'Your Health, Our Priority',
                          style: TextStyle(
                            color: medDarkBlue,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
  'Stay on track with your medication,\nfor a healthier tomorrow.',
  textAlign: TextAlign.center,
  style: TextStyle(
    color: medDarkBlue,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  const Icon(
                    Icons.favorite,
                    color: medRed,
                    size: 38,
                  ),

                  const SizedBox(height: 14),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: medButton(),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OnboardingScreen(),
                        ),
                      ),
                      child: const Text('Get Started'),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'SMALL STEPS • BIG HEALTH CHANGES',
                    style: TextStyle(
                      color: medBlue,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// 2–4. ONBOARDING
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int page = 0;

  final List<Map<String, dynamic>> slides = [
    {
      'icon': Icons.medical_services_rounded,
      'title': 'Manage Your\nMedications Easily',
      'body': 'Add, edit and view your medications\nall in one place.',
    },
    {
      'icon': Icons.calendar_month_rounded,
      'title': 'Never Miss\nYour Dose',
      'body': 'Get timely reminders and keep\ntrack of your health.',
    },
    {
      'icon': Icons.health_and_safety_rounded,
      'title': 'Better Health\nStarts Here',
      'body': 'Simple. Smart. Reliable.',
    },
  ];

  void next() {
    if (page < 2) {
      controller.nextPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                ),
                child: const Text('Skip'),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: slides.length,
                onPageChanged: (v) => setState(() => page = v),
                itemBuilder: (context, index) {
                  final item = slides[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 205,
                          width: 205,
                          decoration: BoxDecoration(
                            color: medPaleBlue,
                            borderRadius: BorderRadius.circular(65),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(item['icon'], size: 105, color: medBlue),
                              Positioned(
                                right: 24,
                                top: 25,
                                child: Icon(
                                  index == 0
                                      ? Icons.person
                                      : index == 1
                                          ? Icons.alarm
                                          : Icons.favorite,
                                  color: medRed,
                                  size: 34,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 38),
                        Text(
                          item['title'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: medDarkBlue,
                            fontSize: 25,
                            height: 1.2,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
  item['body'],
  textAlign: TextAlign.center,
  style: const TextStyle(
    color: medDarkBlue,
    height: 1.6,
    fontSize: 13,
    fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: page == i ? 22 : 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: page == i ? medRed : const Color(0xFFB9DDF5),
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: medButton(),
                  onPressed: next,
                  child: Text(page == 2 ? 'Get Started' : 'Next'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 5. LOGIN
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(25, 32, 25, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: brandMark(size: 76)),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'MedSync',
                  style: TextStyle(
                    color: medRed,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const Center(
                child: Text(
                  'Smart Medication Management',
style: TextStyle(color: medDarkBlue, fontSize: 11),                ),
              ),
              const SizedBox(height: 35),
              pageHeading('Login to Your Account', 'Welcome back to MedSync.'),
              const SizedBox(height: 22),
              fieldLabel('Email Address'),
              TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 17),
              fieldLabel('Password'),
              TextField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: Icon(Icons.visibility_outlined),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => showMessage(context, 'Password reset is a demo feature.'),
                  child: const Text('Forgot Password?'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: medButton(),
                  onPressed: () {
  if (email.text.trim().isEmpty || password.text.isEmpty) {
    showMessage(context, 'Please enter your email and password.');
    return;
  }

  if (email.text.trim() != registeredEmail ||
      password.text != registeredPassword) {
    showMessage(context, 'Invalid email or password. Please try again.');
    return;
  }

  showMessage(context, 'Login successful! Welcome back.');

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const MainShell()),
  );
},
                  child: const Text('Login'),
                ),
              ),
              const SizedBox(height: 14),
              const Center(child: Text('or', style: TextStyle(color: medMuted))),
              const SizedBox(height: 8),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  foregroundColor: medBlue,
                  side: const BorderSide(color: Color(0xFFD4E9F8)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterScreen()),
                ),
                child: const Text('Create an account'),
              ),
              const SizedBox(height: 18),
              const Center(
                child: Text(
                  'By continuing, you agree to our Terms & Conditions\nand Privacy Policy.',
                  textAlign: TextAlign.center,
style: TextStyle(
  color: medDarkBlue,
  fontSize: 10,
  height: 1.5,
  fontWeight: FontWeight.w700,
),                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 6. REGISTRATION
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  bool agree = true;

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              pageHeading('Join MedSync', 'Set up your account and take control of your health.'),
              const SizedBox(height: 25),
              fieldLabel('Full Name'),
              TextField(controller: name, decoration: const InputDecoration(hintText: 'Full name', prefixIcon: Icon(Icons.person_outline))),
              const SizedBox(height: 15),
              fieldLabel('Email'),
              TextField(controller: email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(hintText: 'Email address', prefixIcon: Icon(Icons.email_outlined))),
              const SizedBox(height: 15),
              fieldLabel('Phone Number'),
              TextField(controller: phone, keyboardType: TextInputType.phone, decoration: const InputDecoration(hintText: 'Phone number', prefixIcon: Icon(Icons.phone_outlined))),
              const SizedBox(height: 15),
              fieldLabel('Password'),
              TextField(controller: password, obscureText: true, decoration: const InputDecoration(hintText: 'Create password', prefixIcon: Icon(Icons.lock_outline))),
              const SizedBox(height: 15),
              CheckboxListTile(
                value: agree,
                onChanged: (v) => setState(() => agree = v ?? false),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: medBlue,
                title: const Text('I agree to the Terms & Conditions and Privacy Policy', style: TextStyle(fontSize: 11, color: medMuted)),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: medButton(),
                onPressed: () {
  if (name.text.trim().isEmpty ||
      email.text.trim().isEmpty ||
      phone.text.trim().isEmpty ||
      password.text.isEmpty ||
      !agree) {
    showMessage(context, 'Complete all fields and accept the terms.');
    return;
  }

  registeredEmail = email.text.trim();
  registeredPassword = password.text;

showMessage(context, 'Registration successful! Please login.');

Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (_) => const LoginScreen()),
  (route) => false,
);
},
                child: const Text('Register'),
              ),
              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Already have an account? Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// APP SHELL — bottom navigation
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;

  void goTo(int value) => setState(() => index = value);

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardPage(onOpenMedications: () => goTo(1), onAdd: () async {
  final message = await Navigator.push<String>(
    context,
    MaterialPageRoute(builder: (_) => const MedicationFormScreen()),
  );

  setState(() {});

  if (message != null && mounted) {
    showMessage(context, message);
  }
}),
      MedicationListPage(onChanged: () => setState(() {})),
      const DoseSchedulePage(),
      const SettingsPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            brandMark(size: 31),
            const SizedBox(width: 9),
            const Text('MedSync', style: TextStyle(fontWeight: FontWeight.w900)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationPermissionScreen())),
            icon: const Icon(Icons.notifications_none_rounded, color: medRed),
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        height: 66,
        backgroundColor: Colors.white,
        indicatorColor: medPaleBlue,
        selectedIndex: index,
        onDestinationSelected: goTo,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home, color: medBlue), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.medication_outlined), selectedIcon: Icon(Icons.medication, color: medBlue), label: 'Medication'),
          NavigationDestination(icon: Icon(Icons.calendar_month_outlined), selectedIcon: Icon(Icons.calendar_month, color: medBlue), label: 'Schedule'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings, color: medBlue), label: 'Settings'),
        ],
      ),
    );
  }
}

// 7. DASHBOARD
class DashboardPage extends StatelessWidget {
  final VoidCallback onOpenMedications;
  final VoidCallback onAdd;

  const DashboardPage({super.key, required this.onOpenMedications, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final upcoming = medStore.where((m) => m.active).take(2).toList();
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 15, 18, 22),
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 23,
              backgroundColor: medPaleBlue,
              child: Icon(Icons.person, color: medBlue),
            ),
            const SizedBox(width: 11),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Good Morning,', style: TextStyle(color: medMuted, fontSize: 18)),
                  Text('ArJaIz!', style: TextStyle(color: medDarkBlue, fontWeight: FontWeight.w900, fontSize: 15)),
                ],
              ),
            ),
            IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationPermissionScreen())), icon: const Icon(Icons.notifications_none, color: medBlue)),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [medBlue, Color(0xFF42A9E8)]),
            borderRadius: BorderRadius.circular(19),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Today's Medication", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
              const SizedBox(height: 9),
              Row(
                children: [
                  const Text('2 / 3 taken', style: TextStyle(color: Colors.white, fontSize: 12)),
                  const Spacer(),
                  const Text('67%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                ],
              ),
              const SizedBox(height: 9),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const LinearProgressIndicator(value: .67, minHeight: 8, backgroundColor: Color(0x8877C9F3), valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text('Quick Overview', style: TextStyle(color: medDarkBlue, fontWeight: FontWeight.w900, fontSize: 16)),
        const SizedBox(height: 10),
        Row(
          children: const [
            Expanded(child: _QuickTimeCard(icon: Icons.wb_sunny_outlined, title: 'Morning', time: '08:00 AM', color: medBlue)),
            SizedBox(width: 8),
            Expanded(child: _QuickTimeCard(icon: Icons.wb_twilight, title: 'Afternoon', time: '02:00 PM', color: Color(0xFFF39B32))),
            SizedBox(width: 8),
            Expanded(child: _QuickTimeCard(icon: Icons.nightlight_round, title: 'Evening', time: '08:00 PM', color: medRed)),
          ],
        ),
        const SizedBox(height: 22),
        Row(
          children: [
            const Expanded(child: Text('Upcoming Reminders', style: TextStyle(color: medDarkBlue, fontWeight: FontWeight.w900, fontSize: 16))),
            TextButton(onPressed: onOpenMedications, child: const Text('See all')),
          ],
        ),
        ...upcoming.map((m) => _ReminderTile(medication: m)),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add),
          label: const Text('Add Medication'),
          style: OutlinedButton.styleFrom(foregroundColor: medBlue, side: const BorderSide(color: Color(0xFFB9DDF5)), minimumSize: const Size(double.infinity, 47), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
        ),
      ],
    );
  }
}

class _QuickTimeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String time;
  final Color color;
  const _QuickTimeCard({required this.icon, required this.title, required this.time, required this.color});

@override
Widget build(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 5),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFE4EFF7)),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 23),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            color: medDarkBlue,
            fontSize: 10,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          time,
          style: const TextStyle(
            color: Color(0xFF12345A),
            fontSize: 9,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
}

class _ReminderTile extends StatelessWidget {
  final Medication medication;
  const _ReminderTile({required this.medication});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE4EFF7))),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(color: medPaleBlue, borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.medication, color: medBlue),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(medication.name, style: const TextStyle(color: medDarkBlue, fontWeight: FontWeight.w800, fontSize: 12)),
                const SizedBox(height: 3),
Text(
  '${medication.dosage} • ${medication.times.first}',
  style: const TextStyle(
    color: Color(0xFF12345A),
    fontSize: 10,
    fontWeight: FontWeight.w600,
  ),
),              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: medBlue),
        ],
      ),
    );
  }
}

// 8. MEDICATION LIST
class MedicationListPage extends StatefulWidget {
  final VoidCallback onChanged;
  const MedicationListPage({super.key, required this.onChanged});

  @override
  State<MedicationListPage> createState() => _MedicationListPageState();
}

class _MedicationListPageState extends State<MedicationListPage> {
  String filter = 'All';

  List<Medication> get shown {
    if (filter == 'Active') return medStore.where((m) => m.active).toList();
    if (filter == 'Today') return medStore.where((m) => m.times.isNotEmpty).toList();
    return medStore;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 17, 18, 10),
          child: Row(
            children: [
              const Expanded(child: Text('My Medications', style: TextStyle(color: medDarkBlue, fontSize: 22, fontWeight: FontWeight.w900))),
              IconButton(
                onPressed: () async {
  final message = await Navigator.push<String>(
    context,
    MaterialPageRoute(
      builder: (_) => const MedicationFormScreen(),
    ),
  );

  setState(() {});
  widget.onChanged();

  if (message != null && mounted) {
    showMessage(context, message);
  }
},
                icon: const Icon(Icons.add_circle_outline, color: medBlue),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            children: ['All', 'Today', 'Active'].map((v) {
              final selected = filter == v;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(v),
                  selected: selected,
                  onSelected: (_) => setState(() => filter = v),
                  selectedColor: medBlue,
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(color: selected ? Colors.white : medMuted, fontWeight: FontWeight.w700, fontSize: 11),
                  side: BorderSide.none,
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(18),
            itemCount: shown.length,
            itemBuilder: (context, i) {
              final medication = shown[i];
              final realIndex = medStore.indexOf(medication);
              return _MedicationListCard(
                medication: medication,
                onEdit: () async {
  final message = await Navigator.push<String>(
    context,
    MaterialPageRoute(
      builder: (_) => MedicationFormScreen(index: realIndex),
    ),
  );

  setState(() {});
  widget.onChanged();

  if (message != null && mounted) {
    showMessage(context, message);
  }
},
                onDelete: () {
                  setState(() => medStore.remove(medication));
                  widget.onChanged();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _MedicationListCard extends StatelessWidget {
  final Medication medication;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const _MedicationListCard({required this.medication, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2EDF5))),
      child: Row(
        children: [
          Container(width: 43, height: 43, decoration: BoxDecoration(color: medPaleBlue, borderRadius: BorderRadius.circular(13)), child: const Icon(Icons.medication_outlined, color: medBlue, size: 25)),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(medication.name, style: const TextStyle(color: medDarkBlue, fontWeight: FontWeight.w800, fontSize: 12)),
                const SizedBox(height: 4),
Text(
  '${medication.dosage} • ${medication.frequency}',
  style: const TextStyle(
    color: Color(0xFF12345A),
    fontSize: 10,
    fontWeight: FontWeight.w600,
  ),
),                const SizedBox(height: 6),
Text(
  medication.times.join('  •  '),
  style: const TextStyle(
    color: Color(0xFF12345A),
    fontSize: 9,
    fontWeight: FontWeight.w700,
  ),
),              ],
            ),
          ),
          Column(
            children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFE4F8EE), borderRadius: BorderRadius.circular(20)), child: const Text('Active', style: TextStyle(color: Color(0xFF16875A), fontSize: 9, fontWeight: FontWeight.w800))),

PopupMenuButton<String>(
  onSelected: (v) async {
    final isEdit = v == 'edit';

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(isEdit ? 'Edit Medication?' : 'Delete Medication?'),
        content: Text(
          isEdit
              ? 'Do you want to edit ${medication.name}?'
              : 'Are you sure you want to delete ${medication.name}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(isEdit ? 'Continue' : 'Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    if (isEdit) {
      onEdit();
    } else {
      onDelete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Medication deleted successfully!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  },
  itemBuilder: (_) => const [
    PopupMenuItem(value: 'edit', child: Text('Edit')),
    PopupMenuItem(value: 'delete', child: Text('Delete')),
  ],
  icon: const Icon(Icons.more_vert, color: medMuted, size: 20),
),

            ],
          ),
        ],
      ),
    );
  }
}

// 9–10. ADD AND EDIT MEDICATION
class MedicationFormScreen extends StatefulWidget {
  final int? index;
  const MedicationFormScreen({super.key, this.index});

  @override
  State<MedicationFormScreen> createState() => _MedicationFormScreenState();
}

class _MedicationFormScreenState extends State<MedicationFormScreen> {
  final name = TextEditingController();
  final dosage = TextEditingController();
  String frequency = '3 times daily';
  String startDate = '20 Nov 2026';
  String endDate = '';
  List<String> times = ['08:00 AM', '02:00 PM', '08:00 PM'];

  bool get editing => widget.index != null;

  @override
  void initState() {
    super.initState();
    if (editing) {
      final m = medStore[widget.index!];
      name.text = m.name;
      dosage.text = m.dosage;
      frequency = m.frequency;
      startDate = m.startDate;
      endDate = m.endDate;
      times = List<String>.from(m.times);
    }
  }

  @override
  void dispose() {
    name.dispose();
    dosage.dispose();
    super.dispose();
  }

  Future<void> chooseDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2026, 11, 20),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      final value = '${picked.day} ${_month(picked.month)} ${picked.year}';
      setState(() {
        if (isStart) {
          startDate = value;
        } else {
          endDate = value;
        }
      });
    }
  }

  String _month(int m) => const ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][m];

  Future<void> chooseTime(int index) async {
    final picked = await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 8, minute: 0));
    if (picked != null) {
      setState(() {
        final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
        final minute = picked.minute.toString().padLeft(2, '0');
        times[index] = '$hour:$minute ${picked.period == DayPeriod.am ? 'AM' : 'PM'}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(editing ? 'Edit Medication' : 'Add Medication'), leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back))),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 25),
        children: [
          pageHeading(editing ? 'Update Medication' : 'New Medication', 'Enter the details for your medication.'),
          const SizedBox(height: 22),
          fieldLabel('Medication Name *'),
          TextField(controller: name, decoration: const InputDecoration(hintText: 'e.g. Paracetamol 500mg')),
          const SizedBox(height: 15),
          fieldLabel('Dosage *'),
          TextField(controller: dosage, decoration: const InputDecoration(hintText: 'e.g. 1 tablet')),
          const SizedBox(height: 15),
          fieldLabel('Frequency *'),
          DropdownButtonFormField<String>(
            value: frequency,
            decoration: const InputDecoration(),
            items: ['Once daily', 'Twice daily', '3 times daily', '4 times daily', 'As needed'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
            onChanged: (v) => setState(() {
              frequency = v ?? frequency;
              final count = frequency == 'Once daily' ? 1 : frequency == 'Twice daily' ? 2 : frequency == '4 times daily' ? 4 : 3;
              while (times.length < count) { times.add('08:00 AM'); }
              while (times.length > count) { times.removeLast(); }
            }),
          ),
          const SizedBox(height: 15),
          fieldLabel('Reminder Time(s)'),
          ...List.generate(times.length, (i) => Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: InkWell(
              onTap: () => chooseTime(i),
              borderRadius: BorderRadius.circular(13),
              child: InputDecorator(
                decoration: InputDecoration(prefixIcon: const Icon(Icons.access_time, color: medBlue), suffixIcon: const Icon(Icons.keyboard_arrow_down)),
                child: Text(times[i], style: const TextStyle(color: medText)),
              ),
            ),
          )),
          const SizedBox(height: 7),
          fieldLabel('Start Date *'),
          OutlinedButton.icon(
            onPressed: () => chooseDate(true),
            icon: const Icon(Icons.calendar_today_outlined, size: 17),
            label: Align(alignment: Alignment.centerLeft, child: Text(startDate)),
style: OutlinedButton.styleFrom(
  backgroundColor: Colors.white,
  foregroundColor: medText,
  side: const BorderSide(color: Color(0xFFDCEAF5)),
  minimumSize: const Size(double.infinity, 48),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(13),
  ),
),          ),
          const SizedBox(height: 15),
          fieldLabel('End Date (optional)'),
          OutlinedButton.icon(
            onPressed: () => chooseDate(false),
            icon: const Icon(Icons.calendar_today_outlined, size: 17),
            label: Align(alignment: Alignment.centerLeft, child: Text(endDate.isEmpty ? 'Select date' : endDate)),
style: OutlinedButton.styleFrom(
  backgroundColor: Colors.white,
  foregroundColor: medText,
  side: const BorderSide(color: Color(0xFFDCEAF5)),
  minimumSize: const Size(double.infinity, 48),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(13),
  ),
),          ),
          const SizedBox(height: 25),
          ElevatedButton(
            style: medButton(),
            onPressed: () {
              if (name.text.trim().isEmpty || dosage.text.trim().isEmpty) {
                showMessage(context, 'Please enter the medication name and dosage.');
                return;
              }
              final item = Medication(name: name.text.trim(), dosage: dosage.text.trim(), frequency: frequency, startDate: startDate, endDate: endDate, times: List<String>.from(times));
              final message = editing
    ? 'Medication updated successfully!'
    : 'Medication saved successfully!';

if (editing) {
  medStore[widget.index!] = item;
} else {
  medStore.add(item);
}

Navigator.pop(context, message);
            },
            child: Text(editing ? 'Update' : 'Save'),
          ),
          if (editing) ...[
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                medStore.removeAt(widget.index!);
                Navigator.pop(context);
              },
              child: const Text('Delete Medication', style: TextStyle(color: medRed, fontWeight: FontWeight.w700)),
            ),
          ],
        ],
      ),
    );
  }
}

// 11. DOSE SCHEDULE
class DoseSchedulePage extends StatefulWidget {
  const DoseSchedulePage({super.key});

  @override
  State<DoseSchedulePage> createState() => _DoseSchedulePageState();
}

class _DoseSchedulePageState extends State<DoseSchedulePage> {
  final Map<String, bool> enabled = {};

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(19),
      children: [
        pageHeading('Dose Schedule', 'Your planned medication times.'),
        const SizedBox(height: 18),
        ...medStore.expand((m) => m.times.map((time) {
          final key = '${m.name}-$time';
          enabled.putIfAbsent(key, () => true);
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xFFE3EEF6))),
            child: Row(
              children: [
                Container(width: 40, height: 40, decoration: BoxDecoration(color: medPaleBlue, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.medication, color: medBlue)),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(m.name, style: const TextStyle(color: medDarkBlue, fontWeight: FontWeight.w800, fontSize: 12)),
                  const SizedBox(height: 3),
Text(
  '${m.dosage} • $time',
  style: const TextStyle(
    color: Color(0xFF12345A),
    fontSize: 10,
    fontWeight: FontWeight.w600,
  ),
),                ])),
                Switch(value: enabled[key]!, activeColor: medBlue, onChanged: (v) => setState(() => enabled[key] = v)),
              ],
            ),
          );
        })),
        const SizedBox(height: 10),
const Text(
  'Next dose: Today, 08:00 AM',
  style: TextStyle(
    color: Color.fromARGB(255, 238, 241, 244),
    fontSize: 11,
    fontWeight: FontWeight.w800,
  ),
),      ],
    );
  }
}

// 12. NOTIFICATION PERMISSION
class NotificationPermissionScreen extends StatelessWidget {
  const NotificationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)), title: const Text('Local Notification')),
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 190, height: 190, decoration: const BoxDecoration(color: medPaleBlue, shape: BoxShape.circle), child: const Stack(alignment: Alignment.center, children: [
              Icon(Icons.notifications_active_rounded, color: medRed, size: 94),
              Positioned(right: 25, top: 25, child: Icon(Icons.notifications, color: medBlue, size: 30)),
            ])),
            const SizedBox(height: 30),
            const Text('Enable Notifications', style: TextStyle(color: medDarkBlue, fontSize: 23, fontWeight: FontWeight.w900)),
            const SizedBox(height: 10),
            const Text('Get reminded when it is time\nto take your medication.', textAlign: TextAlign.center, style: TextStyle(color: medMuted, height: 1.6)),
            const SizedBox(height: 30),
            ElevatedButton(style: medButton(), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReminderPreviewScreen())), child: const Text('Allow Notifications')),
            const SizedBox(height: 10),
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Maybe Later')),
            const SizedBox(height: 18),
            const Text('Demo screen: real notifications require notification permissions and a local-notification package.', textAlign: TextAlign.center, style: TextStyle(color: medMuted, fontSize: 10)),
          ],
        ),
      ),
    );
  }
}

// 13. REMINDER NOTIFICATION PREVIEW
class ReminderPreviewScreen extends StatelessWidget {
  const ReminderPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0879C6),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(top: -80, right: -90, child: _waveCircle(280, const Color(0xFF4CAAE6))),
            Positioned(bottom: -100, left: -90, child: _waveCircle(330, const Color(0xFFEF5361))),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Spacer(),
                  const Text('08:00', style: TextStyle(color: Colors.white, fontSize: 64, fontWeight: FontWeight.w300)),
                  const Text('Thu, 20 Nov', style: TextStyle(color: Colors.white70, fontSize: 15)),
                  const SizedBox(height: 35),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(17),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: .96), borderRadius: BorderRadius.circular(18)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(children: [Icon(Icons.favorite, color: medRed, size: 20), SizedBox(width: 7), Text('MedSync', style: TextStyle(color: medDarkBlue, fontWeight: FontWeight.w900)), Spacer(), Text('now', style: TextStyle(color: medMuted, fontSize: 10))]),
                        const SizedBox(height: 12),
                        const Text('Time for your medication!', style: TextStyle(color: medDarkBlue, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 6),
                        const Text('Paracetamol 500mg\nTake 1 tablet now.', style: TextStyle(color: medMuted, height: 1.5, fontSize: 12)),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Text('Swipe up to unlock', style: TextStyle(color: Colors.white70, fontSize: 11)),
                  const SizedBox(height: 15),
                  OutlinedButton(onPressed: () => Navigator.pop(context), style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white54)), child: const Text('Back to MedSync')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _waveCircle(double size, Color color) => Container(width: size, height: size, decoration: BoxDecoration(color: color.withValues(alpha: .55), shape: BoxShape.circle));
}

// 14. SETTINGS
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(19),
      children: [
        pageHeading('Settings', 'Manage your MedSync preferences.'),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Row(children: [
            const CircleAvatar(radius: 25, backgroundColor: medPaleBlue, child: Icon(Icons.person, color: medBlue)),
            const SizedBox(width: 12),
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('ArJaIz', style: TextStyle(color: medDarkBlue, fontWeight: FontWeight.w900)), Text('ArJaIz@example.com', style: TextStyle(color: medMuted, fontSize: 11))])),
            IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())), icon: const Icon(Icons.chevron_right, color: medBlue)),
          ]),
        ),
        const SizedBox(height: 15),
        _SettingTile(icon: Icons.person_outline, title: 'Profile', subtitle: 'Manage your personal information', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()))),
        _SettingTile(icon: Icons.notifications_none, title: 'Notification Settings', subtitle: 'Manage reminder notifications', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationPermissionScreen()))),
        _SettingTile(icon: Icons.medication_outlined, title: 'Medication Reminders', subtitle: 'Manage your dose schedule', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReminderSettingsScreen()))),
        _SettingTile(icon: Icons.palette_outlined, title: 'App Appearance', subtitle: 'MedSync colours and display', onTap: () => showMessage(context, 'Appearance settings demo.')),
        _SettingTile(icon: Icons.language, title: 'Language', subtitle: 'English', onTap: () => showMessage(context, 'English selected.')),
        _SettingTile(icon: Icons.help_outline, title: 'Help & Support', subtitle: 'Get help using MedSync', onTap: () => showMessage(context, 'Help and support demo.')),
        _SettingTile(icon: Icons.info_outline, title: 'About MedSync', subtitle: 'Smart Medication Management', onTap: () => showAboutDialog(context: context, applicationName: 'MedSync', applicationVersion: '1.0.0', applicationLegalese: 'Smart Medication Management')),
        const SizedBox(height: 12),
        ElevatedButton(
  style: medButton(),
  onPressed: () {
    showMessage(context, 'Logout successful! See you again.');

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  },
  child: const Text('Log Out'),
),
      ],
    );
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _SettingTile({required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 7),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13)),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: medBlue),
        title: Text(title, style: const TextStyle(color: medDarkBlue, fontWeight: FontWeight.w800, fontSize: 12)),
        subtitle: Text(subtitle, style: const TextStyle(color: medMuted, fontSize: 10)),
        trailing: const Icon(Icons.chevron_right, color: medMuted),
      ),
    );
  }
}

// 15. PROFILE
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final name = TextEditingController(text: 'ArJaIz');
  final email = TextEditingController(text: 'ArJaIz@example.com');
  final phone = TextEditingController(text: '+60 12 345 6789');

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          const CircleAvatar(radius: 48, backgroundColor: medPaleBlue, child: Icon(Icons.person, color: medBlue, size: 52)),
          const SizedBox(height: 10),
          const Center(child: Text('ArJaIz', style: TextStyle(color: medDarkBlue, fontWeight: FontWeight.w900, fontSize: 17))),
          const Center(child: Text('ArJaIz@example.com', style: TextStyle(color: medMuted, fontSize: 11))),
          const SizedBox(height: 28),
          fieldLabel('Full Name'),
          TextField(controller: name, decoration: const InputDecoration(prefixIcon: Icon(Icons.person_outline))),
          const SizedBox(height: 16),
          fieldLabel('Email'),
          TextField(controller: email, decoration: const InputDecoration(prefixIcon: Icon(Icons.email_outlined))),
          const SizedBox(height: 16),
          fieldLabel('Phone Number'),
          TextField(controller: phone, keyboardType: TextInputType.phone, decoration: const InputDecoration(prefixIcon: Icon(Icons.phone_outlined))),
          const SizedBox(height: 28),
          ElevatedButton(style: medButton(), onPressed: () {
            showMessage(context, 'Profile details saved for this demo.');
            Navigator.pop(context);
          }, child: const Text('Save Changes')),
        ],
      ),
    );
  }
}

// Extra settings destination opened from Settings.
class ReminderSettingsScreen extends StatefulWidget {
  const ReminderSettingsScreen({super.key});

  @override
  State<ReminderSettingsScreen> createState() => _ReminderSettingsScreenState();
}

class _ReminderSettingsScreenState extends State<ReminderSettingsScreen> {
  bool reminders = true;
  bool sound = true;
  bool vibration = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medication Reminders')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          pageHeading('Reminder Preferences', 'Choose how MedSync reminds you.'),
          const SizedBox(height: 15),
          SwitchListTile(title: const Text('Medication reminders'), value: reminders, activeColor: medBlue, onChanged: (v) => setState(() => reminders = v)),
          SwitchListTile(title: const Text('Sound'), value: sound, activeColor: medBlue, onChanged: (v) => setState(() => sound = v)),
          SwitchListTile(title: const Text('Vibration'), value: vibration, activeColor: medBlue, onChanged: (v) => setState(() => vibration = v)),
          const SizedBox(height: 15),
          const Text('These switches are demonstration settings. Actual scheduled alerts require local notification setup.', style: TextStyle(color: medMuted, fontSize: 11)),
        ],
      ),
    );
  }
}

