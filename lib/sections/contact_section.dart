import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';
import '../widgets/glass_container.dart';
import '../widgets/neon_button.dart';
import '../widgets/section_title.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSending = false;
  bool _isSuccess = false;

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isSending = true);

      // Simulate sending message
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) {
          setState(() {
            _isSending = false;
            _isSuccess = true;
          });

          // Reset form after delay
          Future.delayed(const Duration(seconds: 4), () {
            if (mounted) {
              setState(() {
                _isSuccess = false;
                _nameController.clear();
                _emailController.clear();
                _messageController.clear();
              });
            }
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      child: Column(
        children: [
          const SectionTitle(
            tag: 'GET IN TOUCH',
            title: 'Let\'s Build Something Great',
            subtitle:
                'Whether you have an upcoming Flutter app, need architectural leadership, or want to consult on mobile performance — reach out directly!',
          ).animate().fadeIn(duration: 500.ms),
          const SizedBox(height: 48),

          isMobile
              ? Column(
                  children: [
                    _buildInfoColumn(isDark),
                    const SizedBox(height: 32),
                    _buildFormCard(isDark),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: _buildInfoColumn(isDark)),
                    const SizedBox(width: 40),
                    Expanded(flex: 6, child: _buildFormCard(isDark)),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(bool isDark) {
    final accent = ThemeController.instance.accentColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: GoogleFonts.outfit(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'I am based in Surat, Gujarat and available for remote, hybrid, or on-site engineering engagements worldwide.',
          style: GoogleFonts.outfit(
            fontSize: 15,
            height: 1.6,
            color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
          ),
        ),
        const SizedBox(height: 28),

        // Contact Cards
        _buildContactCard(
          icon: FontAwesomeIcons.envelope,
          title: 'Email Address',
          value: PortfolioData.email,
          actionText: 'Send Email',
          onTap: () => _launchUrl('mailto:${PortfolioData.email}'),
          isDark: isDark,
          accentColor: accent,
        ),
        const SizedBox(height: 16),
        _buildContactCard(
          icon: FontAwesomeIcons.phone,
          title: 'Phone / Call',
          value: PortfolioData.phone,
          actionText: 'Direct Call',
          onTap: () => _launchUrl('tel:+919328045023'),
          isDark: isDark,
          accentColor: AppColors.neonGreen,
        ),
        const SizedBox(height: 16),
        _buildContactCard(
          icon: FontAwesomeIcons.whatsapp,
          title: 'WhatsApp Chat',
          value: '+91 9328045023 (Instant)',
          actionText: 'Start Chat',
          onTap: () => _launchUrl('https://wa.me/919328045023'),
          isDark: isDark,
          accentColor: const Color(0xFF25D366),
        ),
        const SizedBox(height: 16),
        _buildContactCard(
          icon: FontAwesomeIcons.locationDot,
          title: 'Location',
          value: PortfolioData.location,
          actionText: 'View on Maps',
          onTap: () => _launchUrl('https://maps.google.com/?q=${PortfolioData.location}'),
          isDark: isDark,
          accentColor: AppColors.neonPink,
        ),
      ],
    );
  }

  Widget _buildContactCard({
    required FaIconData icon,
    required String title,
    required String value,
    required String actionText,
    required VoidCallback onTap,
    required bool isDark,
    required Color accentColor,
  }) {
    return GlassContainer(
      hoverEffect: true,
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: FaIcon(icon, color: accentColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.textDarkMuted : AppColors.textLightMuted,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_outward_rounded, size: 18, color: accentColor),
        ],
      ),
    );
  }

  Widget _buildFormCard(bool isDark) {
    return GlassContainer(
      padding: const EdgeInsets.all(32),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send a Direct Message',
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Fill in your details and I\'ll get back to you within 24 hours.',
              style: GoogleFonts.outfit(
                fontSize: 14,
                color: isDark ? AppColors.textDarkSecondary : AppColors.textLightSecondary,
              ),
            ),
            const SizedBox(height: 24),

            // Name Field
            _buildTextField(
              controller: _nameController,
              label: 'Your Name',
              hint: 'John Doe',
              icon: Icons.person_outline,
              isDark: isDark,
              validator: (v) => (v == null || v.isEmpty) ? 'Please enter your name' : null,
            ),
            const SizedBox(height: 18),

            // Email Field
            _buildTextField(
              controller: _emailController,
              label: 'Your Email',
              hint: 'john@example.com',
              icon: Icons.email_outlined,
              isDark: isDark,
              validator: (v) =>
                  (v == null || !v.contains('@')) ? 'Please enter a valid email' : null,
            ),
            const SizedBox(height: 18),

            // Message Field
            _buildTextField(
              controller: _messageController,
              label: 'Project Details / Message',
              hint: 'Describe your mobile app, timeline, or requirements...',
              icon: Icons.message_outlined,
              isDark: isDark,
              maxLines: 4,
              validator: (v) => (v == null || v.isEmpty) ? 'Please write your message' : null,
            ),
            const SizedBox(height: 24),

            // Status feedback or Submit Button
            if (_isSuccess)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.neonGreen.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.neonGreen),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: AppColors.neonGreen, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Thank you! Your message has been sent. Dharmik will reply shortly.',
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn().scale()
            else
              SizedBox(
                width: double.infinity,
                child: NeonButton(
                  text: _isSending ? 'Sending...' : 'Send Message 🚀',
                  onPressed: _isSending ? null : _handleSubmit,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required bool isDark,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    final accent = ThemeController.instance.accentColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          style: GoogleFonts.outfit(
            fontSize: 14,
            color: isDark ? AppColors.textDarkPrimary : AppColors.textLightPrimary,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.outfit(
              fontSize: 13,
              color: isDark ? AppColors.textDarkMuted : AppColors.textLightMuted,
            ),
            prefixIcon: Icon(
              icon,
              size: 18,
              color: accent,
            ),
            filled: true,
            fillColor: isDark
                ? AppColors.darkSurfaceLight.withValues(alpha: 0.6)
                : AppColors.lightSurfaceLight,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: accent,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
