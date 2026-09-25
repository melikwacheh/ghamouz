import 'package:flutter/material.dart';

void main() {
  runApp(const FinWiseApp());
}

// ============================================================
// COLORS
// ============================================================

class C {
  static const green = Color(0xFF00D09E);
  static const pale = Color(0xFFF1FFF7);
  static const soft = Color(0xFFDFF7E8);
  static const ink = Color(0xFF073B3A);
  static const blue = Color(0xFF2F80ED);
}

// ============================================================
// APP
// ============================================================

class FinWiseApp extends StatefulWidget {
  const FinWiseApp({super.key});

  @override
  State<FinWiseApp> createState() => _FinWiseAppState();
}

class _FinWiseAppState extends State<FinWiseApp> {
  bool dark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FinWise',
      themeMode: dark ? ThemeMode.dark : ThemeMode.light,

      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: C.green,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: C.green,
          primary: C.green,
          surface: C.pale,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: C.ink,
          ),
        ),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF052F2E),
        colorScheme: ColorScheme.fromSeed(
          seedColor: C.green,
          brightness: Brightness.dark,
          primary: C.green,
          surface: const Color(0xFF073B3A),
        ),
      ),

      home: Builder(
        builder: (context) {
          return LaunchPage(
            onDone: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => Shell(
                    onTheme: () {
                      setState(() {
                        dark = !dark;
                      });
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ============================================================
// LAUNCH PAGE
// ============================================================

class LaunchPage extends StatelessWidget {
  final VoidCallback onDone;

  const LaunchPage({
    super.key,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: C.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.stacked_line_chart_rounded,
                size: 88,
                color: Colors.white,
              ),

              const SizedBox(height: 10),

              const Text(
                'FinWise',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Finance made simple',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 60),

              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: C.pale,
                  foregroundColor: C.ink,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 56,
                    vertical: 16,
                  ),
                ),
                onPressed: onDone,
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// MAIN NAVIGATION
// ============================================================

class Shell extends StatefulWidget {
  final VoidCallback onTheme;

  const Shell({
    super.key,
    required this.onTheme,
  });

  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int index = 0;

  final pages = const [
    HomePage(),
    AnalysisPage(),
    TransactionsPage(),
    CategoriesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],

      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          margin: const EdgeInsets.fromLTRB(
            16,
            0,
            16,
            10,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(34),
          ),
          child: NavigationBar(
            height: 64,
            backgroundColor: Colors.transparent,
            indicatorColor: C.green,
            selectedIndex: index,
            labelBehavior:
                NavigationDestinationLabelBehavior.alwaysHide,
            onDestinationSelected: (value) {
              setState(() {
                index = value;
              });
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.analytics_outlined),
                label: 'Analysis',
              ),
              NavigationDestination(
                icon: Icon(Icons.swap_horiz_rounded),
                label: 'Transactions',
              ),
              NavigationDestination(
                icon: Icon(Icons.layers_outlined),
                label: 'Categories',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// TOP HEADER
// ============================================================

class Top extends StatelessWidget {
  final String title;
  final String sub;

  const Top(
    this.title,
    this.sub, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        22,
        18,
        22,
        18,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    color: C.ink,
                  ),
                ),
                Text(
                  sub,
                  style: const TextStyle(
                    fontSize: 12,
                    color: C.ink,
                  ),
                ),
              ],
            ),
          ),

          const CircleAvatar(
            backgroundColor: C.pale,
            child: Icon(
              Icons.notifications_none_rounded,
              color: C.ink,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HOME PAGE
// ============================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Top(
            'Hi, Welcome Back',
            'Good Morning',
          ),

          const Balance(),

          Expanded(
            child: Sheet(
              child: ListView(
                padding:
                    const EdgeInsets.fromLTRB(
                  20,
                  22,
                  20,
                  30,
                ),
                children: [
                  const QuickCard(),

                  const SizedBox(height: 18),

                  const Segments(),

                  const SizedBox(height: 12),

                  ...sample
                      .take(3)
                      .map((x) => TxTile(x)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// BALANCE
// ============================================================

class Balance extends StatelessWidget {
  const Balance({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(
        24,
        4,
        24,
        22,
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Expanded(
                child: Metric(
                  '▣ Total Balance',
                  '\$7,783.00',
                  Colors.white,
                ),
              ),

              SizedBox(
                height: 44,
                child: VerticalDivider(
                  color: Colors.white54,
                ),
              ),

              Expanded(
                child: Metric(
                  '▣ Total Expense',
                  '-\$1,187.40',
                  C.blue,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Container(
            height: 18,
            decoration: BoxDecoration(
              color: C.pale,
              borderRadius:
                  BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  width: 105,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: C.ink,
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '30%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),

                const Expanded(
                  child: Center(
                    child: Text(
                      '\$20,000.00',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 10,
                        color: C.ink,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '☑  30% Of Your Expenses, Looks Good.',
              style: TextStyle(
                color: C.ink,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// METRIC
// ============================================================

class Metric extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const Metric(
    this.title,
    this.value,
    this.color, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: C.ink,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// WHITE/LIGHT CONTENT SHEET
// ============================================================

class Sheet extends StatelessWidget {
  final Widget child;

  const Sheet({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color:
            Theme.of(context).colorScheme.surface,
        borderRadius:
            const BorderRadius.vertical(
          top: Radius.circular(38),
        ),
      ),
      child: child,
    );
  }
}

// ============================================================
// QUICK CARD
// ============================================================

class QuickCard extends StatelessWidget {
  const QuickCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: C.green,
        borderRadius:
            BorderRadius.circular(22),
      ),
      child: const Row(
        children: [
          Expanded(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 27,
                  backgroundColor:
                      Colors.transparent,
                  child: Icon(
                    Icons
                        .directions_car_outlined,
                    size: 36,
                    color: C.ink,
                  ),
                ),
                Text(
                  'Savings\nOn Goals',
                  textAlign:
                      TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight:
                        FontWeight.w700,
                    color: C.ink,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 76,
            child: VerticalDivider(
              color: Colors.white,
            ),
          ),

          Expanded(
            flex: 2,
            child: Column(
              children: [
                Mini(
                  Icons.layers_outlined,
                  'Revenue Last Week',
                  '\$4,000.00',
                  C.ink,
                ),

                Divider(
                  color: Colors.white70,
                ),

                Mini(
                  Icons.restaurant_outlined,
                  'Food Last Week',
                  '-\$100.00',
                  C.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// MINI ROW
// ============================================================

class Mini extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const Mini(
    this.icon,
    this.title,
    this.value,
    this.color, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: C.ink,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 9,
                  color: C.ink,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight:
                      FontWeight.w800,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================
// SEGMENTS
// ============================================================

class Segments extends StatelessWidget {
  const Segments({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      'Daily',
      'Weekly',
      'Monthly',
    ];

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: C.soft,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Row(
        children: items.map((item) {
          final selected =
              item == 'Monthly';

          return Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? C.green
                    : Colors.transparent,
                borderRadius:
                    BorderRadius.circular(18),
              ),
              child: Text(
                item,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: C.ink,
                  fontWeight:
                      FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ============================================================
// TRANSACTION MODEL
// ============================================================

class Tx {
  final IconData icon;
  final String title;
  final String time;
  final String category;
  final String amount;
  final Color color;

  const Tx(
    this.icon,
    this.title,
    this.time,
    this.category,
    this.amount,
    this.color,
  );
}

// ============================================================
// SAMPLE DATA
// ============================================================

const sample = [
  Tx(
    Icons.layers_outlined,
    'Salary',
    '18:27 - April 30',
    'Monthly',
    '\$4,000.00',
    Color(0xFF70B7FF),
  ),
  Tx(
    Icons.shopping_bag_outlined,
    'Groceries',
    '17:00 - April 24',
    'Pantry',
    '-\$100.00',
    Color(0xFF3998FF),
  ),
  Tx(
    Icons.handshake_outlined,
    'Rent',
    '8:30 - April 15',
    'Rent',
    '-\$674.40',
    Color(0xFF1477F8),
  ),
  Tx(
    Icons.directions_bus_outlined,
    'Transport',
    '9:30 - April 08',
    'Fuel',
    '-\$4.13',
    Color(0xFF60A5FA),
  ),
  Tx(
    Icons.restaurant_outlined,
    'Food',
    '19:30 - March 31',
    'Dinner',
    '-\$70.40',
    Color(0xFF60A5FA),
  ),
];

// ============================================================
// TRANSACTION TILE
// ============================================================

class TxTile extends StatelessWidget {
  final Tx transaction;

  const TxTile(
    this.transaction, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final negative =
        transaction.amount.startsWith('-');

    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical: 7,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor:
                transaction.color,
            child: Icon(
              transaction.icon,
              color: Colors.white,
              size: 21,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    fontWeight:
                        FontWeight.w700,
                    color: C.ink,
                  ),
                ),
                Text(
                  transaction.time,
                  style: const TextStyle(
                    fontSize: 9,
                    color: C.blue,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: 1,
            height: 30,
            color: C.green,
          ),

          const SizedBox(width: 12),

          SizedBox(
            width: 55,
            child: Text(
              transaction.category,
              style: const TextStyle(
                fontSize: 10,
                color: C.ink,
              ),
            ),
          ),

          Container(
            width: 1,
            height: 30,
            color: C.green,
          ),

          const SizedBox(width: 10),

          Text(
            transaction.amount,
            style: TextStyle(
              fontSize: 11,
              fontWeight:
                  FontWeight.w800,
              color:
                  negative ? C.blue : C.ink,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// TRANSACTIONS PAGE
// ============================================================

class TransactionsPage
    extends StatelessWidget {
  const TransactionsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Top(
            'Transaction',
            'Your activity',
          ),

          const Balance(),

          Expanded(
            child: Sheet(
              child: ListView(
                padding:
                    const EdgeInsets.all(20),
                children: [
                  const Text(
                    'April',
                    style: TextStyle(
                      fontWeight:
                          FontWeight.w800,
                      fontSize: 18,
                      color: C.ink,
                    ),
                  ),

                  ...sample
                      .take(4)
                      .map(
                        (e) => TxTile(e),
                      ),

                  const SizedBox(height: 10),

                  const Text(
                    'March',
                    style: TextStyle(
                      fontWeight:
                          FontWeight.w800,
                      fontSize: 18,
                      color: C.ink,
                    ),
                  ),

                  TxTile(sample.last),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// ANALYSIS PAGE
// ============================================================

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Top(
            'Quickly Analysis',
            'Monthly overview',
          ),

          Expanded(
            child: Sheet(
              child: ListView(
                padding:
                    const EdgeInsets.all(20),
                children: [
                  const QuickCard(),

                  const SizedBox(height: 22),

                  const Text(
                    'April Expenses',
                    style: TextStyle(
                      fontWeight:
                          FontWeight.w800,
                      fontSize: 18,
                      color: C.ink,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    height: 190,
                    padding:
                        const EdgeInsets.all(
                      18,
                    ),
                    decoration:
                        BoxDecoration(
                      color: C.pale,
                      borderRadius:
                          BorderRadius.circular(
                        24,
                      ),
                    ),
                    child:
                        const BarChart(),
                  ),

                  const SizedBox(height: 18),

                  ...sample
                      .take(3)
                      .map(
                        (e) => TxTile(e),
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

// ============================================================
// BAR CHART
// ============================================================

class BarChart extends StatelessWidget {
  const BarChart({super.key});

  @override
  Widget build(BuildContext context) {
    const heights = [
      35,
      60,
      90,
      55,
      120,
      80,
      110,
      65,
    ];

    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.end,
      mainAxisAlignment:
          MainAxisAlignment.spaceAround,
      children: heights.map((height) {
        return Container(
          width: 12,
          height: height.toDouble(),
          decoration: BoxDecoration(
            color: height % 2 == 0
                ? C.green
                : C.blue,
            borderRadius:
                BorderRadius.circular(5),
          ),
        );
      }).toList(),
    );
  }
}

// ============================================================
// CATEGORIES PAGE
// ============================================================

class CategoriesPage
    extends StatelessWidget {
  const CategoriesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      (Icons.restaurant, 'Food'),
      (
        Icons.shopping_bag,
        'Shopping',
      ),
      (
        Icons.directions_car,
        'Transport',
      ),
      (Icons.home, 'Housing'),
      (Icons.favorite, 'Health'),
      (
        Icons.movie,
        'Entertainment',
      ),
      (Icons.school, 'Education'),
      (
        Icons.more_horiz,
        'Others',
      ),
    ];

    return SafeArea(
      child: Column(
        children: [
          const Top(
            'Categories',
            'Manage your spending',
          ),

          Expanded(
            child: Sheet(
              child: GridView.count(
                crossAxisCount: 2,
                padding:
                    const EdgeInsets.all(
                  22,
                ),
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,

                children:
                    categories.map((category) {
                  return Container(
                    decoration:
                        BoxDecoration(
                      color: C.soft,
                      borderRadius:
                          BorderRadius.circular(
                        24,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor:
                              C.green,
                          child: Icon(
                            category.$1,
                            color: C.ink,
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Text(
                          category.$2,
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight
                                    .w700,
                            color: C.ink,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PROFILE PAGE
// ============================================================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      (
        Icons.person_outline,
        'Personal Information',
      ),
      (
        Icons.lock_outline,
        'Security',
      ),
      (
        Icons.notifications_none,
        'Notifications',
      ),
      (
        Icons.help_outline,
        'Help & Support',
      ),
    ];

    return SafeArea(
      child: Column(
        children: [
          const Top(
            'Profile',
            'Account settings',
          ),

          Expanded(
            child: Sheet(
              child: ListView(
                padding:
                    const EdgeInsets.all(24),
                children: [
                  const CircleAvatar(
                    radius: 44,
                    backgroundColor:
                        C.green,
                    child: Icon(
                      Icons.person,
                      size: 52,
                      color: C.ink,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Center(
                    child: Text(
                      'John Smith',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.w800,
                        fontSize: 20,
                        color: C.ink,
                      ),
                    ),
                  ),

                  const Center(
                    child: Text(
                      'john@finwise.app',
                      style: TextStyle(
                        color: C.ink,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  ...menuItems.map(
                    (item) => ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            C.soft,
                        child: Icon(
                          item.$1,
                          color: C.ink,
                        ),
                      ),
                      title: Text(
                        item.$2,
                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight.w600,
                          color: C.ink,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: C.ink,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) =>
                              LaunchPage(
                            onDone: () {},
                          ),
                        ),
                        (_) => false,
                      );
                    },
                    child:
                        const Text('Log Out'),
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
