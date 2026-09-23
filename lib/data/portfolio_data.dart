import 'package:flutter/material.dart';

class ProjectItem {
  final String title;
  final String category;
  final String description;
  final String impact;
  final List<String> tags;
  final IconData icon;
  final String? githubUrl;
  final String? liveUrl;

  const ProjectItem({
    required this.title,
    required this.category,
    required this.description,
    required this.impact,
    required this.tags,
    required this.icon,
    this.githubUrl,
    this.liveUrl,
  });
}

class ExperienceItem {
  final String role;
  final String company;
  final String period;
  final String location;
  final List<String> points;
  final List<String> techStack;

  const ExperienceItem({
    required this.role,
    required this.company,
    required this.period,
    required this.location,
    required this.points,
    required this.techStack,
  });
}

class EducationItem {
  final String degree;
  final String institution;
  final String year;
  final String location;

  const EducationItem({
    required this.degree,
    required this.institution,
    required this.year,
    required this.location,
  });
}

class SkillCategory {
  final String title;
  final IconData icon;
  final List<SkillItem> skills;

  const SkillCategory({
    required this.title,
    required this.icon,
    required this.skills,
  });
}

class SkillItem {
  final String name;
  final double level; // 0.0 to 1.0
  final String description;

  const SkillItem({
    required this.name,
    required this.level,
    required this.description,
  });
}

class PortfolioData {
  static const String name = 'Dharmik Rakholiya';
  static const String title = 'Senior Flutter Developer';
  static const String email = 'dharmikrakholiya200@gmail.com';
  static const String phone = '+91 9328045023';
  static const String location = 'Pasodara, Surat, Gujarat 395013';
  static const String profileImage = 'assets/images/profile.jpg';

  static const List<String> rotatingRoles = [
    'Senior Flutter Developer',
    'Cross-Platform App Specialist',
    'Mobile, Web & Desktop Engineer',
    'Clean Architecture & Riverpod/BLoC',
    'Performance & 60/120fps UI Craftsman',
  ];

  static const String bio =
      'Flutter developer with expertise in mobile app development and user experience enhancement. '
      'Skilled in troubleshooting and optimizing applications using Dart, delivering high-quality, '
      'pixel-perfect cross-platform solutions. Known for collaboration, Clean Architecture, '
      'and innovative problem-solving. Committed to engineering cutting-edge digital experiences '
      'and ensuring world-class quality assurance.';

  static const Map<String, String> stats = {
    '5+': 'Years in Flutter & Dart',
    '25+': 'Completed CRMs & Apps',
    '99.9%': 'Crash-Free Session Rate',
    '100k+': 'Users Impacted Globally',
  };

  static const List<ExperienceItem> experiences = [
    ExperienceItem(
      role: 'Independent Flutter Developer',
      company: 'Self-Employed',
      period: '02/2026 – 09/2026',
      location: 'Surat, Gujarat',
      points: [
        'Architected and deployed responsive mobile, web, and desktop applications using Flutter and Dart.',
        'Integrated complex REST APIs, Firebase services, Supabase, and PostgreSQL data backends.',
        'Built full-featured enterprise admin dashboards, role-based access control (RBAC), and integrated payment gateways.',
        'Conducted rigorous automated testing, profiling, debugging, CI/CD deployment, and ongoing maintenance.',
        'Collaborated directly with founders and product owners to deliver robust production systems on time.',
      ],
      techStack: ['Flutter', 'Dart', 'Supabase', 'Firebase', 'PostgreSQL', 'REST APIs'],
    ),
    ExperienceItem(
      role: 'Flutter Developer',
      company: 'BizTechnosys Infotech Pvt Ltd',
      period: '02/2025 – 01/2026',
      location: 'Bengaluru, Karnataka',
      points: [
        'Led end-to-end development of multiple high-traffic Flutter applications with exceptional user experiences.',
        'Delivered scalable CRM solutions, ticket management device apps, and an all-in-one automobile dealership suite.',
        'Built Infra Eye: an infrastructure monitoring application handling real-time telemetry alerts and live status dashboards.',
        'Diagnosed and eliminated performance bottlenecks and complex bugs, driving app store ratings up.',
        'Collaborated with cross-functional design and backend teams to streamline release workflows.',
      ],
      techStack: ['Flutter', 'Riverpod', 'WebSockets', 'CRM Systems', 'Real-time Telemetry'],
    ),
    ExperienceItem(
      role: 'Sr. Flutter Developer and QA',
      company: 'Bebuzee Inc',
      period: '03/2024 – 12/2024',
      location: 'Surat, Gujarat',
      points: [
        'Engineered, enhanced, and maintained high-scale mobile applications using Flutter and Dart.',
        'Spearheaded QA processes, code reviews, and visual audits to deliver flawless UI/UX transitions.',
        'Partnered closely with product designers to translate Figma designs into fluid 60fps Flutter widgets.',
      ],
      techStack: ['Flutter', 'Dart', 'Quality Assurance', 'Figma to Flutter', 'BLoC'],
    ),
    ExperienceItem(
      role: 'Sr. Flutter Developer',
      company: 'Shubh Info Tech',
      period: '03/2023 – 02/2024',
      location: 'Surat, Gujarat',
      points: [
        'Built and scaled mobile applications using Flutter, drastically improving screen render performance.',
        'Created custom animations, re-usable component libraries, and integrated enterprise cloud services.',
        'Mentored junior engineers and advocated modern state management patterns and Clean Architecture.',
      ],
      techStack: ['Flutter', 'Clean Architecture', 'REST APIs', 'Custom Painters', 'Git'],
    ),
    ExperienceItem(
      role: 'Jr. Flutter Developer',
      company: 'Inventam Tech Solution',
      period: '03/2021 – 03/2023',
      location: 'Surat, Gujarat',
      points: [
        'Gained rigorous hands-on expertise in Dart coding, profiling, debugging, and agile project delivery.',
        'Converted complex UI wireframes and client requirements into modular, functional application modules.',
        'Collaborated with designers and project managers on diverse client solutions across multiple sectors.',
      ],
      techStack: ['Flutter', 'Dart', 'SQLite', 'Provider', 'Android Studio'],
    ),
  ];

  static const List<EducationItem> education = [
    EducationItem(
      degree: 'Master of Science: Information Technology (M.Sc. IT)',
      institution: 'Swarnim Gujarat University',
      year: '2025',
      location: 'Gandhinagar, Gujarat, India',
    ),
    EducationItem(
      degree: 'Bachelor of Computer Applications (BCA)',
      institution: 'Sarvepalli Radhakrishnan University',
      year: '2023',
      location: 'Bhopal, Madhya Pradesh, India',
    ),
  ];

  static const List<SkillCategory> skillCategories = [
    SkillCategory(
      title: 'Frameworks & Languages',
      icon: Icons.code,
      skills: [
        SkillItem(name: 'Flutter', level: 0.98, description: 'Cross-platform native compilation for iOS, Android, Web & Desktop'),
        SkillItem(name: 'Dart', level: 0.95, description: 'Async programming, null safety, Isolates, streams & functional patterns'),
        SkillItem(name: 'Python & Django API', level: 0.82, description: 'Backend service APIs, automation scripts, and microservices'),
        SkillItem(name: 'REST APIs & WebSockets', level: 0.94, description: 'Secure real-time networking, serialization & token auth'),
      ],
    ),
    SkillCategory(
      title: 'Architecture & State Management',
      icon: Icons.architecture,
      skills: [
        SkillItem(name: 'Riverpod / BLoC', level: 0.96, description: 'Predictable, testable reactive state with Clean Architecture'),
        SkillItem(name: 'Provider / GetX', level: 0.90, description: 'Lightweight dependency injection and reactive observables'),
        SkillItem(name: 'Clean Architecture & Repositories', level: 0.92, description: 'Domain-driven decoupling, use cases, and modularity'),
        SkillItem(name: '60/120fps Animation & Painters', level: 0.95, description: 'Custom RenderBox, Matrix4 3D tilt, CustomPainter shaders'),
      ],
    ),
    SkillCategory(
      title: 'Database & Cloud Backends',
      icon: Icons.cloud,
      skills: [
        SkillItem(name: 'Firebase Suite', level: 0.95, description: 'Auth, Firestore, Cloud Functions, Cloud Messaging, Storage'),
        SkillItem(name: 'Supabase & PostgreSQL', level: 0.90, description: 'Row-Level Security, real-time channels, relational schema'),
        SkillItem(name: 'MongoDB', level: 0.85, description: 'Document stores, aggregations, and high-volume caching'),
        SkillItem(name: 'Local DBs (Hive / Isar / SQLite)', level: 0.92, description: 'Offline-first sync, encrypted key-value & binary storage'),
      ],
    ),
    SkillCategory(
      title: 'Tools, DevOps & Testing',
      icon: Icons.build_circle,
      skills: [
        SkillItem(name: 'Git & GitHub Workflows', level: 0.95, description: 'Branching strategies, CI/CD actions, code reviews'),
        SkillItem(name: 'Android Studio & VS Code', level: 0.95, description: 'Deep DevTools memory profiling, Inspector, linting rules'),
        SkillItem(name: 'Unit & Widget Testing', level: 0.88, description: 'Mocking, test-driven logic verification, regression prevention'),
        SkillItem(name: 'App Deployment & Stores', level: 0.92, description: 'Google Play Console, Apple App Store, Web deployment'),
      ],
    ),
  ];

  static const List<ProjectItem> projects = [
    ProjectItem(
      title: 'IIT Madras Collaborative Software Module',
      category: 'Scalability & Research',
      description:
          'High-performance collaborative software module engineered with focus on scalable software architecture, robust data pipelines, and optimized computing throughput.',
      impact: 'Achieved ultra-low latency modular processing with 99.9% uptime benchmark.',
      tags: ['Flutter', 'Dart', 'Python', 'Django API', 'Modular Arch'],
      icon: Icons.school,
      githubUrl: 'https://github.com/dharmikrakholiya',
      liveUrl: 'https://github.com/dharmikrakholiya',
    ),
    ProjectItem(
      title: 'Ticket Management Enterprise CRM',
      category: 'Enterprise CRM',
      description:
          'Comprehensive multi-tenant customer support ticket platform featuring automated ticket routing, priority algorithms, SLA breach warning timers, and real-time support chats.',
      impact: 'Reduced customer support resolution cycle by 40% across support centers.',
      tags: ['Flutter', 'REST APIs', 'WebSockets', 'Riverpod', 'Supabase'],
      icon: Icons.confirmation_number,
      githubUrl: 'https://github.com/dharmikrakholiya',
      liveUrl: 'https://github.com/dharmikrakholiya',
    ),
    ProjectItem(
      title: 'Device & Hardware Asset Management CRM',
      category: 'Enterprise CRM',
      description:
          'Centralized enterprise platform for inventory tracking, hardware lifecycle management, warranty alerting, annual maintenance contracts (AMC), and integrated QR/Barcode auditing.',
      impact: 'Actively monitors over 10,000+ hardware devices with full audit trails.',
      tags: ['Flutter', 'PostgreSQL', 'QR Scanner', 'Clean Arch', 'Supabase'],
      icon: Icons.devices,
      githubUrl: 'https://github.com/dharmikrakholiya',
      liveUrl: 'https://github.com/dharmikrakholiya',
    ),
    ProjectItem(
      title: 'All-in-One Automobile Dealership CRM',
      category: 'Mobile & Web',
      description:
          'Full-cycle automotive dealer application connecting showroom sales representatives, customer test drive bookings, service schedule automation, and recurring insurance renewals.',
      impact: 'Drove 35% higher service repeat visits and automated reminder follow-ups.',
      tags: ['Flutter', 'Firebase', 'Push Notifications', 'Payment Gateway'],
      icon: Icons.directions_car,
      githubUrl: 'https://github.com/dharmikrakholiya',
      liveUrl: 'https://github.com/dharmikrakholiya',
    ),
    ProjectItem(
      title: 'Infra Eye Mobile Infrastructure Telemetry',
      category: 'IoT & Telemetry',
      description:
          'Real-time infrastructure health monitoring mobile app featuring instant push alerts, interactive CPU/memory gauge dials, incident logging, and automated escalation triggers.',
      impact: 'Instant sub-second incident alerting for mission-critical server networks.',
      tags: ['Flutter', 'Real-time Charts', 'WebSockets', 'Alert System', 'BLoC'],
      icon: Icons.remove_red_eye,
      githubUrl: 'https://github.com/dharmikrakholiya',
      liveUrl: 'https://github.com/dharmikrakholiya',
    ),
  ];

  static const List<String> spokenLanguages = [
    'English (Fluent / Professional)',
    'Gujarati (Native)',
    'Hindi (Fluent / Conversational)',
  ];
}
