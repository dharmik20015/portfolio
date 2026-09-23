import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/portfolio_data.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';
import '../widgets/glass_container.dart';
import '../widgets/section_title.dart';
import '../widgets/tilt_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 950;

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      child: Column(
        children: [
          const SectionTitle(
            tag: 'BACKGROUND & PHILOSOPHY',
            title: 'About Dharmik Rakholiya',
            subtitle:
                'Passionate about building scalable, maintainable mobile applications that provide intuitive user experiences.',
          ).animate().fadeIn(duration: 500.ms),
          const SizedBox(height: 48),

          // Main Story & Stats Grid
          isMobile
              ? Column(
                  children: [
                    _buildBioCard(isDark),
                    const SizedBox(height: 24),
                    _buildStatsGrid(isDark),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 6, child: _buildBioCard(isDark)),
                    const SizedBox(width: 32),
                    Expanded(flex: 5, child: _buildStatsGrid(isDark)),
                  ],
                ),

          const SizedBox(height: 48),

          // Core Strengths Cards
          _buildPillarsGrid(isDark, screenWidth),

          const SizedBox(height: 48),

          // Education & Languages Row
          _buildEducationAndLanguages(isDark, isMobile),
        ],
      ),
    );
  }

  Widget _buildBioCard(bool isDark) {
    return GlassContainer(
      hoverEffect: false,
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ThemeController.instance.accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.person_pin_rounded,
                  color: ThemeController.instance.accentColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Text(
                'Professional Summary',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            PortfolioData.bio,
            style: GoogleFonts.outfit(
              fontSize: 16,
              height: 1.7,
              color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ThemeController.instance.accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ThemeController.instance.accentColor.withValues(alpha: 0.35),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.verified_outlined,
                  color: ThemeController.instance.accentColor,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Senior-level developer committed to creating cutting-edge products and ensuring quality assurance.',
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(bool isDark) {
    final entries = PortfolioData.stats.entries.toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.4,
      ),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final item = entries[index];
        return TiltCard(
          borderRadius: BorderRadius.circular(16),
          child: GlassContainer(
            hoverEffect: true,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.key,
                  style: GoogleFonts.outfit(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                    color: ThemeController.instance.accentColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.value,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPillarsGrid(bool isDark, double screenWidth) {
    final pillars = [
      _PillarItem(
        icon: Icons.devices_rounded,
        title: 'Cross-Platform Native',
        description: 'Single codebase targeting iOS, Android, Web, and Desktop with zero compromise on platform feel.',
        accentColor: AppColors.poisonGreen,
      ),
      _PillarItem(
        icon: Icons.account_tree_outlined,
        title: 'Clean Architecture',
        description: 'Modular layer separation, testable business logic with Riverpod & BLoC, and robust error handling.',
        accentColor: AppColors.neonPurple,
      ),
      _PillarItem(
        icon: Icons.speed_rounded,
        title: '60/120 FPS Fluidity',
        description: 'Deep profiling with Flutter DevTools, micro-benchmark optimization, and smooth physics animations.',
        accentColor: AppColors.neonGreen,
      ),
      _PillarItem(
        icon: Icons.cloud_done_outlined,
        title: 'Cloud & Telemetry',
        description: 'Real-time sync via Supabase, Firebase, WebSockets, REST APIs, and push notification infrastructures.',
        accentColor: AppColors.neonAmber,
      ),
    ];

    int crossAxisCount = 4;
    double childAspectRatio = 0.85;
    if (screenWidth < 650) {
      crossAxisCount = 1;
      childAspectRatio = 2.4;
    } else if (screenWidth < 1100) {
      crossAxisCount = 2;
      childAspectRatio = 1.35;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: pillars.length,
      itemBuilder: (context, index) {
        final p = pillars[index];
        return TiltCard(
          borderRadius: BorderRadius.circular(16),
          glowColor: p.accentColor,
          child: GlassContainer(
            hoverEffect: true,
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: p.accentColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(p.icon, color: p.accentColor, size: 24),
                ),
                const SizedBox(height: 14),
                Text(
                  p.title,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  p.description,
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    height: 1.5,
                    color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEducationAndLanguages(bool isDark, bool isMobile) {
    return isMobile
        ? Column(
            children: [
              _buildEducationCard(isDark),
              const SizedBox(height: 24),
              _buildLanguagesCard(isDark),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 6, child: _buildEducationCard(isDark)),
              const SizedBox(width: 24),
              Expanded(flex: 4, child: _buildLanguagesCard(isDark)),
            ],
          );
  }

  Widget _buildEducationCard(bool isDark) {
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.school_rounded, color: AppColors.neonPurple, size: 22),
              const SizedBox(width: 10),
              Text(
                'Education Background',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ...PortfolioData.education.map((edu) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.neonPurple,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          edu.degree,
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
                          ),
                        ),
                        Text(
                          '${edu.institution} • ${edu.year}',
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            color: AppColors.poisonGreen,
                          ),
                        ),
                        Text(
                          edu.location,
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: isDark ? AppColors.textDarkMuted : AppColors.textLightMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildLanguagesCard(bool isDark) {
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.translate_rounded, color: AppColors.neonGreen, size: 22),
              const SizedBox(width: 10),
              Text(
                'Languages',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ...PortfolioData.spokenLanguages.map((lang) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Icon(Icons.check_circle, size: 16, color: AppColors.neonGreen),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      lang,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _PillarItem {
  final IconData icon;
  final String title;
  final String description;
  final Color accentColor;

  const _PillarItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.accentColor,
  });
}
