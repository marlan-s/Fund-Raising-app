import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fundraising Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF8F9FE),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),
      ),
      home: const LoginScreen(),
      routes: {
        '/dashboard': (context) => const DashboardScreen(),
        '/leaderboard': (context) => const LeaderboardScreen(),
        '/announcements': (context) => const AnnouncementsScreen(),
      },
    );
  }
}

// ==================== MODELS ====================
class Reward {
  final String title;
  final int points;
  final bool unlocked;
  final IconData icon;

  const Reward({
    required this.title,
    required this.points,
    required this.unlocked,
    required this.icon,
  });
}

class LeaderboardEntry {
  final String name;
  final int score;
  final int rank;

  const LeaderboardEntry({
    required this.name,
    required this.score,
    required this.rank,
  });
}

class Announcement {
  final String title;
  final String content;
  final String date;

  const Announcement({
    required this.title,
    required this.content,
    required this.date,
  });
}

// ==================== MOCK DATA ====================
final mockData = {
  'internName': 'Marlan Frando',
  'referralCode': 'marlan2025',
  'totalRaised': 5000,
  'targetAmount': 10000,
  'rewards': const [
    Reward(
      title: "T-Shirt",
      points: 2000,
      unlocked: true,
      icon: Icons.emoji_events,
    ),
    Reward(
      title: "Water Bottle",
      points: 5000,
      unlocked: false,
      icon: Icons.emoji_events,
    ),
    Reward(
      title: "Backpack",
      points: 10000,
      unlocked: false,
      icon: Icons.emoji_events,
    ),
  ],
  'leaderboard': const [
    LeaderboardEntry(name: "Marlan Frando", score: 5000, rank: 1),
    LeaderboardEntry(name: "Sam Wilson", score: 4500, rank: 2),
    LeaderboardEntry(name: "Jamie Lee", score: 4000, rank: 3),
    LeaderboardEntry(name: "Taylor Smith", score: 3800, rank: 4),
    LeaderboardEntry(name: "Jordan Brown", score: 3500, rank: 5),
  ],
  'announcements': const [
    Announcement(
      title: "New Fundraising Campaign",
      content: "We're launching a new campaign next week. Get ready!",
      date: "2023-11-15",
    ),
    Announcement(
      title: "Bonus Rewards",
      content: "Top 3 performers this month will get bonus rewards.",
      date: "2023-11-10",
    ),
  ],
};

// ==================== WIDGETS ====================
class MetricsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final double progress;

  const MetricsCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            LinearPercentIndicator(
              lineHeight: 8,
              percent: progress,
              progressColor: Colors.blue,
              backgroundColor: Colors.blue.withOpacity(0.1),
              barRadius: const Radius.circular(4),
              animation: true,
            ),
          ],
        ),
      ),
    );
  }
}

class RewardCard extends StatelessWidget {
  final Reward reward;

  const RewardCard({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              reward.icon,
              size: 40,
              color: reward.unlocked ? Colors.blue : Colors.grey,
            ),
            const SizedBox(height: 8),
            Text(
              reward.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: reward.unlocked ? Colors.black : Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "${reward.points} pts",
              style: TextStyle(
                color: reward.unlocked ? Colors.blue : Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: reward.unlocked 
                  ? Colors.blue.withOpacity(0.2) 
                  : Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                reward.unlocked ? "Unlocked" : "Locked",
                style: TextStyle(
                  color: reward.unlocked ? Colors.blue : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== SCREENS ====================
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              FlutterLogo(size: 100)
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .scale(),
              const SizedBox(height: 24),
              Text(
                "Fundraising Dashboard",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Intern Portal",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ).animate().fadeIn(delay: 400.ms),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/dashboard');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Sign In'),
                ),
              ).animate().fadeIn(delay: 600.ms),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                child: const Text('Create an account'),
              ).animate().fadeIn(delay: 800.ms),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacementNamed(context, '/'),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person, size: 30),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Marlan Frando',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Fundraising Intern',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/dashboard');
              },
            ),
            ListTile(
              leading: const Icon(Icons.leaderboard),
              title: const Text('Leaderboard'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/leaderboard');
              },
            ),
            ListTile(
              leading: const Icon(Icons.announcement),
              title: const Text('Announcements'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/announcements');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.share, color: Colors.blue),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Referral Code',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          mockData['referralCode'] as String,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                MetricsCard(
                  title: 'Total Raised',
                  value: '₹${mockData['totalRaised']}',
                  icon: Icons.attach_money,
                  progress: (mockData['totalRaised'] as int) / (mockData['targetAmount'] as int),
                ),
                MetricsCard(
                  title: 'Target',
                  value: '₹${mockData['targetAmount']}',
                  icon: Icons.flag,
                  progress: 1.0,
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Your Rewards',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: (mockData['rewards'] as List<Reward>).length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: RewardCard(
                      reward: (mockData['rewards'] as List<Reward>)[index],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: (mockData['leaderboard'] as List<LeaderboardEntry>).length,
        itemBuilder: (context, index) {
          final entry = (mockData['leaderboard'] as List<LeaderboardEntry>)[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${entry.rank}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '₹${entry.score} raised',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.emoji_events, color: Colors.amber),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcements'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: (mockData['announcements'] as List<Announcement>).length,
        itemBuilder: (context, index) {
          final announcement = (mockData['announcements'] as List<Announcement>)[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        announcement.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        announcement.date,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(announcement.content),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
