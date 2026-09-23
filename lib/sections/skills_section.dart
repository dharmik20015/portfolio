import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/portfolio_data.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';
import '../widgets/glass_container.dart';
import '../widgets/section_title.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    final currentCategory = PortfolioData.skillCategories[_selectedCategoryIndex];

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      child: Column(
        children: [
          const SectionTitle(
            tag: 'TECH STACK & EXPERTISE',
            title: 'Skills & Proficiencies',
            subtitle:
                'Hands-on expertise across modern cross-platform engineering, state management architectures, cloud backends, and deployment tools.',
          ).animate().fadeIn(duration: 500.ms),
          const SizedBox(height: 36),

          // Category Selectors
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                PortfolioData.skillCategories.length,
                (index) {
                  final cat = PortfolioData.skillCategories[index];
                  final isSelected = _selectedCategoryIndex == index;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedCategoryIndex = index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                          decoration: BoxDecoration(
                            gradient: isSelected ? ThemeController.instance.accentGradient : null,
                            color: isSelected
                                ? null
                                : (isDark
                                    ? AppColors.darkSurface.withValues(alpha: 0.6)
                                    : AppColors.lightSurface),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.transparent
                                  : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: ThemeController.instance.accentColor.withValues(alpha: 0.3),
                                      blurRadius: 16,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : [],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                cat.icon,
                                size: 18,
                                color: isSelected
                                    ? Colors.black
                                    : ThemeController.instance.accentColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                cat.title,
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? Colors.black
                                      : (isDark
                                          ? AppColors.textDarkPrimary
                                          : AppColors.textLightPrimary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 36),

          // Skill Bars & Details Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: isMobile ? 2.4 : 2.5,
            ),
            itemCount: currentCategory.skills.length,
            itemBuilder: (context, index) {
              final skill = currentCategory.skills[index];
              return _SkillCard(
                skill: skill,
                isDark: isDark,
              ).animate(key: ValueKey('${currentCategory.title}_$index'))
                  .fadeIn(duration: 400.ms, delay: (index * 80).ms)
                  .slideY(begin: 0.1, end: 0);
            },
          ),
          const SizedBox(height: 36),

          // Tech Pill Badges Cloud
          GlassContainer(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.bolt, color: AppColors.neonAmber, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'All-Round Tech Arsenal',
                      style: GoogleFonts.outfit(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    'Flutter 3.x', 'Dart 3.x', 'Riverpod', 'BLoC Pattern', 'Provider',
                    'Clean Architecture', 'Supabase Real-Time', 'Firebase Suite', 'PostgreSQL',
                    'MongoDB', 'Python & Django API', 'RESTful Services', 'WebSockets',
                    'Git & GitHub CI/CD', 'Android Studio', 'VS Code', 'Postman',
                    'Unit & Widget Testing', 'DevTools Profiling', 'CustomPainter & Shaders',
                    'Role-Based Access Control', 'Payment Gateways', 'QR & Barcode Scanning',
                  ].map((tech) => _buildTechPill(tech, isDark)).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechPill(String text, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkSurfaceLight.withValues(alpha: 0.6)
            : AppColors.lightSurfaceLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ThemeController.instance.accentColor.withValues(alpha: 0.25),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.firaCode(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
        ),
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  final SkillItem skill;
  final bool isDark;

  const _SkillCard({required this.skill, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final pct = (skill.level * 100).toInt();
    final accent = ThemeController.instance.accentColor;

    return GlassContainer(
      hoverEffect: true,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill.name,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '$pct%',
                  style: GoogleFonts.firaCode(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            skill.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.outfit(
              fontSize: 12,
              color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
            ),
          ),
          const SizedBox(height: 12),
          // Animated Progress Bar
          Stack(
            children: [
              Container(
                height: 7,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeOutCubic,
                    height: 7,
                    width: constraints.maxWidth * skill.level,
                    decoration: BoxDecoration(
                      gradient: ThemeController.instance.accentGradient,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: accent.withValues(alpha: 0.5),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
