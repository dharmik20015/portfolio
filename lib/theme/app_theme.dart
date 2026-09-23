import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBg,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.poisonGreen,
      secondary: AppColors.neonPurple,
      surface: AppColors.darkSurface,
      error: AppColors.neonPink,
    ),
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge: GoogleFonts.outfit(
        color: AppColors.textDarkPrimary,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.0,
      ),
      displayMedium: GoogleFonts.outfit(
        color: AppColors.textDarkPrimary,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      headlineMedium: GoogleFonts.outfit(
        color: AppColors.textDarkPrimary,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: GoogleFonts.outfit(
        color: AppColors.textDarkPrimary,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.outfit(
        color: AppColors.textDarkSecondary,
        fontSize: 16,
        height: 1.6,
      ),
      bodyMedium: GoogleFonts.outfit(
        color: AppColors.textDarkSecondary,
        fontSize: 14,
        height: 1.5,
      ),
    ),
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBg,
    colorScheme: const ColorScheme.light(
      primary: AppColors.poisonGreen,
      secondary: AppColors.neonPurple,
      surface: AppColors.lightSurface,
      error: AppColors.neonPink,
    ),
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.light().textTheme).copyWith(
      displayLarge: GoogleFonts.outfit(
        color: AppColors.textLightPrimary,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.0,
      ),
      displayMedium: GoogleFonts.outfit(
        color: AppColors.textLightPrimary,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      headlineMedium: GoogleFonts.outfit(
        color: AppColors.textLightPrimary,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: GoogleFonts.outfit(
        color: AppColors.textLightPrimary,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.outfit(
        color: AppColors.textLightSecondary,
        fontSize: 16,
        height: 1.6,
      ),
      bodyMedium: GoogleFonts.outfit(
        color: AppColors.textLightSecondary,
        fontSize: 14,
        height: 1.5,
      ),
    ),
  );
}
