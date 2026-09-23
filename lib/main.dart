import 'package:flutter/material.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/experience_section.dart';
import 'sections/footer_section.dart';
import 'sections/hero_section.dart';
import 'sections/navbar.dart';
import 'sections/playground_section.dart';
import 'sections/projects_section.dart';
import 'sections/skills_section.dart';
import 'theme/app_colors.dart';
import 'theme/app_theme.dart';
import 'theme/theme_controller.dart';
import 'widgets/custom_cursor.dart';
import 'widgets/particle_background.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ThemeController.instance,
      builder: (context, _) {
        return MaterialApp(
          title: 'Dharmik Rakholiya | Senior Flutter Developer',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeController.instance.themeMode,
          home: const PortfolioHomePage(),
        );
      },
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Section Keys for smooth scrolling
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _playgroundKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(int index) {
    GlobalKey targetKey;
    switch (index) {
      case 0:
        targetKey = _heroKey;
        break;
      case 1:
        targetKey = _aboutKey;
        break;
      case 2:
        targetKey = _skillsKey;
        break;
      case 3:
        targetKey = _projectsKey;
        break;
      case 4:
        targetKey = _playgroundKey;
        break;
      case 5:
        targetKey = _experienceKey;
        break;
      case 6:
      default:
        targetKey = _contactKey;
        break;
    }

    final context = targetKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildMobileDrawer(isDark),
      body: CustomCursor(
        child: ParticleBackground(
          isDark: isDark,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Scrollable Page Content
              SingleChildScrollView(
                controller: _scrollController,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 90), // Space for floating navbar
                      Center(
                        child: Container(
                          key: _heroKey,
                          child: HeroSection(
                            onExploreProjects: () => _scrollToSection(3),
                            onContactMe: () => _scrollToSection(6),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Center(child: Container(key: _aboutKey, child: const AboutSection())),
                      const SizedBox(height: 40),
                      Center(child: Container(key: _skillsKey, child: const SkillsSection())),
                      const SizedBox(height: 40),
                      Center(child: Container(key: _projectsKey, child: const ProjectsSection())),
                      const SizedBox(height: 40),
                      Center(child: Container(key: _playgroundKey, child: const PlaygroundSection())),
                      const SizedBox(height: 40),
                      Center(child: Container(key: _experienceKey, child: const ExperienceSection())),
                      const SizedBox(height: 40),
                      Center(child: Container(key: _contactKey, child: const ContactSection())),
                      Center(child: FooterSection(onScrollToTop: _scrollToTop)),
                    ],
                  ),
                ),
              ),

              // Floating Frosted Glass Navbar at the top
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Navbar(
                  onNavItemSelected: _scrollToSection,
                  onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileDrawer(bool isDark) {
    return Drawer(
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: ThemeController.instance.accentGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'DR',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Dharmik Rakholiya',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            _buildDrawerTile('Home', 0, Icons.home_outlined),
            _buildDrawerTile('About', 1, Icons.person_outline),
            _buildDrawerTile('Skills', 2, Icons.code_rounded),
            _buildDrawerTile('Projects', 3, Icons.work_outline_rounded),
            _buildDrawerTile('Widget Lab', 4, Icons.science_outlined),
            _buildDrawerTile('Experience', 5, Icons.timeline_rounded),
            _buildDrawerTile('Contact', 6, Icons.mail_outline_rounded),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dark Theme',
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Switch(
                    value: ThemeController.instance.isDarkMode,
                    onChanged: (_) => ThemeController.instance.toggleTheme(),
                    activeThumbColor: ThemeController.instance.accentColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerTile(String title, int index, IconData icon) {
    final isDark = ThemeController.instance.isDarkMode;
    return ListTile(
      leading: Icon(
        icon,
        color: ThemeController.instance.accentColor,
        size: 20,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
        _scrollToSection(index);
      },
    );
  }
}
