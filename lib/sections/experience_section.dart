import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/portfolio_data.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';
import '../widgets/glass_container.dart';
import '../widgets/section_title.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = ThemeController.instance.accentColor;

    return Container(
      constraints: const BoxConstraints(maxWidth: 1100),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      child: Column(
        children: [
          const SectionTitle(
            tag: 'CAREER JOURNEY',
            title: 'Work Experience',
            subtitle:
                '5+ years leading mobile engineering, architecting mission-critical CRM platforms, and mentoring Flutter teams.',
          ).animate().fadeIn(duration: 500.ms),
          const SizedBox(height: 48),

          // Vertical Timeline
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: PortfolioData.experiences.length,
            itemBuilder: (context, index) {
              final exp = PortfolioData.experiences[index];
              final isLast = index == PortfolioData.experiences.length - 1;

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline laser line and glowing checkpoint dot
                    SizedBox(
                      width: 44,
                      child: Column(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: index == 0
                                  ? ThemeController.instance.accentGradient
                                  : null,
                              color: index != 0
                                  ? (isDark
                                      ? AppColors.darkSurfaceLight
                                      : AppColors.lightSurfaceLight)
                                  : null,
                              border: Border.all(
                                color: accent,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: accent.withValues(alpha: 0.5),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: isDark ? Colors.white : Colors.black,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                          if (!isLast)
                            Expanded(
                              child: Container(
                                width: 2,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      accent,
                                      AppColors.neonPurple.withValues(alpha: 0.2),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Experience Card
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 32),
                        child: GlassContainer(
                          hoverEffect: true,
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Role & Period
                              Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                runSpacing: 6,
                                children: [
                                  Text(
                                    exp.role,
                                    style: GoogleFonts.outfit(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w800,
                                      color: isDark
                                          ? AppColors.textDarkPrimary
                                          : AppColors.textLightPrimary,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: accent.withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: accent.withValues(alpha: 0.3),
                                      ),
                                    ),
                                    child: Text(
                                      exp.period,
                                      style: GoogleFonts.firaCode(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: accent,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              // Company & Location
                              Row(
                                children: [
                                  Icon(Icons.business_rounded, size: 16, color: AppColors.neonPurple),
                                  const SizedBox(width: 6),
                                  Text(
                                    exp.company,
                                    style: GoogleFonts.outfit(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.neonPurple,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Icon(Icons.location_on_outlined, size: 15, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(
                                    exp.location,
                                    style: GoogleFonts.outfit(
                                      fontSize: 13,
                                      color: isDark ? AppColors.textDarkMuted : AppColors.textLightMuted,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Bullet Points
                              ...exp.points.map((pt) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Icon(
                                          Icons.arrow_right_rounded,
                                          size: 18,
                                          color: accent,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          pt,
                                          style: GoogleFonts.outfit(
                                            fontSize: 14,
                                            height: 1.5,
                                            color: isDark
                                                ? AppColors.textDarkSecondary
                                                : AppColors.textLightSecondary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              const SizedBox(height: 14),
                              // Tech Tags
                              Wrap(
                                spacing: 8,
                                runSpacing: 6,
                                children: exp.techStack.map((tech) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? AppColors.darkSurfaceLight
                                          : AppColors.lightSurfaceLight,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      tech,
                                      style: GoogleFonts.firaCode(
                                        fontSize: 11,
                                        color: accent,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate()
                  .fadeIn(duration: 400.ms, delay: (index * 120).ms)
                  .slideY(begin: 0.1, end: 0);
            },
          ),
        ],
      ),
    );
  }
}
