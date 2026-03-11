import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zakatoon/constants/translations.dart';
import '../widgets/custom_widgets.dart';

class TasbeehScreen extends StatefulWidget {
  const TasbeehScreen({super.key});

  @override
  State<TasbeehScreen> createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  int _target = 33;
  int _selectedIndex = 0;

  final List<Map<String, String>> _dhikrs = [
    {
      'name': 'SubhanAllah',
      'key': 'subhanallah',
      'arabic': 'سُبْحَانَ ٱللَّٰهِ',
    },
    {
      'name': 'Alhamdulillah',
      'key': 'alhamdulillah',
      'arabic': 'ٱلْحَمْدُ لِلَّٰهِ',
    },
    {
      'name': 'Allahu Akbar',
      'key': 'allahuakbar',
      'arabic': 'ٱللَّٰهُ أَكْبَرُ',
    },
    {
      'name': 'Astaghfirullah',
      'key': 'astaghfirullah',
      'arabic': 'أَسْتَغْفِرُ ٱللَّٰهَ',
    },
  ];

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      if (_counter == _target) {
        HapticFeedback.vibrate();
        _showCompletionDialog();
      } else {
        HapticFeedback.lightImpact();
      }
    });
    _controller.forward().then((value) => _controller.reverse());
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Target Reached'),
        content: Text(
          'You have completed $_target times ${_dhikrs[_selectedIndex]['name']}.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _counter = 0);
            },
            child: const Text('Restart'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _nextDhikr();
            },
            child: const Text('Next Dhikr'),
          ),
        ],
      ),
    );
  }

  void _nextDhikr() {
    setState(() {
      _counter = 0;
      _selectedIndex = (_selectedIndex + 1) % _dhikrs.length;
    });
  }

  void _resetCounter() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Counter'),
        content: const Text(
          'Are you sure you want to reset the tasbeeh counter?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _counter = 0;
              });
              Navigator.pop(context);
            },
            child: const Text('Reset', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primaryColor = Color(0xFF1A5F2C);
    const accentColor = Color(0xFFD4AF37);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppTranslations.getText('tasbeeh'),
          style: ZakatStyles.getTextStyle(
            text: AppTranslations.getText('tasbeeh'),
            fontWeight: FontWeight.bold,
            isTitle: true,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _resetCounter,
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset',
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF121212), const Color(0xFF1A211C)]
                : [Colors.grey.shade50, Colors.white],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Dhikr Selector
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: _dhikrs.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                        _counter = 0;
                      });
                      HapticFeedback.selectionClick();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? primaryColor
                            : (isDark ? Colors.white10 : Colors.white),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: isSelected
                              ? primaryColor
                              : Colors.grey.withAlpha(50),
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: primaryColor.withAlpha(60),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : [],
                      ),
                      child: Center(
                        child: Text(
                          AppTranslations.getText(_dhikrs[index]['key']!),
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : (isDark ? Colors.white70 : Colors.black87),
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const Spacer(),

            // Arabic Text
            Text(
              _dhikrs[_selectedIndex]['arabic']!,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: primaryColor,
                fontFamily:
                    'Amiri', // Assuming you might have an Arabic font or default
              ),
            ),
            const SizedBox(height: 30),

            // Counter Circle
            GestureDetector(
              onTap: _incrementCounter,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Progress Ring
                    SizedBox(
                      width: 280,
                      height: 280,
                      child: CircularProgressIndicator(
                        value: _counter / _target,
                        strokeWidth: 8,
                        color: accentColor,
                        backgroundColor: isDark
                            ? Colors.white10
                            : Colors.grey.withAlpha(30),
                      ),
                    ),
                    // Counter Display
                    Container(
                      width: 240,
                      height: 240,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark ? const Color(0xFF252D27) : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withAlpha(isDark ? 50 : 30),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: primaryColor.withAlpha(30),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$_counter',
                            style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          if (_target != 999999)
                            Text(
                              '/ $_target',
                              style: TextStyle(
                                fontSize: 18,
                                color: isDark
                                    ? Colors.white54
                                    : Colors.grey.shade600,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Target Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _targetChip(33),
                const SizedBox(width: 15),
                _targetChip(100),
                const SizedBox(width: 15),
                _targetChip(999999, label: 'Infinite'),
              ],
            ),

            const Spacer(),

            Text(
              'Tap the circle to count',
              style: TextStyle(
                color: isDark ? Colors.white54 : Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _targetChip(int val, {String? label}) {
    final isSelected = _target == val;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primaryColor = Color(0xFF1A5F2C);

    return ActionChip(
      label: Text(label ?? val.toString()),
      labelStyle: TextStyle(
        color: isSelected
            ? Colors.white
            : (isDark ? Colors.white70 : Colors.black87),
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      backgroundColor: isSelected
          ? primaryColor
          : (isDark ? Colors.white10 : Colors.white),
      onPressed: () {
        setState(() {
          _target = val;
          _counter = 0;
        });
        HapticFeedback.selectionClick();
      },
      shape: StadiumBorder(
        side: BorderSide(
          color: isSelected ? primaryColor : Colors.grey.withAlpha(50),
        ),
      ),
    );
  }
}
