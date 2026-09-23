import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';
import '../widgets/glass_container.dart';
import '../widgets/neon_button.dart';
import '../widgets/section_title.dart';
import '../widgets/tilt_card.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _selectedFilter = 'All';

  final List<String> _filters = [
    'All',
    'Enterprise CRM',
    'Mobile & Web',
    'IoT & Telemetry',
    'Scalability & Research',
  ];

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _showProjectDetails(BuildContext context, ProjectItem project, bool isDark) {
    showDialog(
      context: context,
      builder: (context) {
        final accent = ThemeController.instance.accentColor;
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 650),
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: accent.withValues(alpha: 0.5),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 35,
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          project.icon,
                          color: accent,
                          size: 26,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    project.title,
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.neonPurple.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      project.category,
                      style: GoogleFonts.firaCode(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.neonPurple,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    project.description,
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      height: 1.6,
                      color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0x3300F5A0) : const Color(0x1A00F5A0),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.neonGreen.withValues(alpha: 0.4)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.insights, color: AppColors.neonGreen, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Business Impact: ${project.impact}',
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Technologies Used:',
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.tags
                        .map(
                          (t) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.darkSurfaceLight : AppColors.lightSurfaceLight,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: accent.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              t,
                              style: GoogleFonts.firaCode(
                                fontSize: 12,
                                color: accent,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      NeonButton(
                        text: 'View GitHub',
                        icon: Icons.code,
                        isPrimary: false,
                        isSmall: true,
                        onPressed: () {
                          Navigator.of(context).pop();
                          _launchUrl(project.githubUrl ?? 'https://github.com/dharmikrakholiya');
                        },
                      ),
                      const SizedBox(width: 12),
                      NeonButton(
                        text: 'Close',
                        isSmall: true,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final accent = ThemeController.instance.accentColor;

    final filteredProjects = _selectedFilter == 'All'
        ? PortfolioData.projects
        : PortfolioData.projects
            .where((p) => p.category == _selectedFilter)
            .toList();

    int crossAxisCount = 3;
    if (screenWidth < 750) {
      crossAxisCount = 1;
    } else if (screenWidth < 1150) {
      crossAxisCount = 2;
    }

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      child: Column(
        children: [
          const SectionTitle(
            tag: 'FEATURED PORTFOLIO',
            title: 'Featured Projects & CRMs',
            subtitle:
                'Production systems engineered with Flutter, robust REST APIs, cloud databases, and high-performance cross-platform architectures.',
          ).animate().fadeIn(duration: 500.ms),
          const SizedBox(height: 36),

          // Filters Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _filters.map((filter) {
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedFilter = filter),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                        decoration: BoxDecoration(
                          color: isSelected ? accent : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                          ),
                        ),
                        child: Text(
                          filter,
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? Colors.black
                                : (isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 36),

          // Project Cards Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 22,
              mainAxisSpacing: 22,
              childAspectRatio: crossAxisCount == 1 ? 1.4 : 0.88,
            ),
            itemCount: filteredProjects.length,
            itemBuilder: (context, index) {
              final project = filteredProjects[index];
              return TiltCard(
                borderRadius: BorderRadius.circular(18),
                child: GlassContainer(
                  hoverEffect: true,
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with Icon & Category
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient: ThemeController.instance.accentGradient,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(project.icon, color: Colors.black, size: 22),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: accent.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              project.category,
                              style: GoogleFonts.firaCode(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: accent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      // Title
                      Text(
                        project.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Description
                      Expanded(
                        child: Text(
                          project.description,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            height: 1.5,
                            color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Metric highlight
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.neonGreen.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.neonGreen.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.bolt, size: 14, color: AppColors.neonGreen),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                project.impact,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.outfit(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.neonGreen,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      // Tags
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: project.tags.take(3).map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.darkSurfaceLight
                                  : AppColors.lightSurfaceLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              tag,
                              style: GoogleFonts.firaCode(
                                fontSize: 10,
                                color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      // Card Actions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(50, 30),
                            ),
                            icon: Icon(
                              Icons.arrow_forward_rounded,
                              size: 15,
                              color: accent,
                            ),
                            label: Text(
                              'Case Study',
                              style: GoogleFonts.outfit(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: accent,
                              ),
                            ),
                            onPressed: () => _showProjectDetails(context, project, isDark),
                          ),
                          IconButton(
                            icon: const Icon(Icons.open_in_new_rounded, size: 17),
                            color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
                            onPressed: () => _launchUrl(project.githubUrl ?? 'https://github.com/dharmikrakholiya'),
                            tooltip: 'Source & Details',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ).animate(key: ValueKey('${project.title}_$_selectedFilter'))
                  .fadeIn(duration: 400.ms, delay: (index * 80).ms)
                  .slideY(begin: 0.1, end: 0);
            },
          ),
        ],
      ),
    );
  }
}
