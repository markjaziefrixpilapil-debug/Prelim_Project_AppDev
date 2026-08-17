import 'package:flutter/material.dart';

final Map<String, Map<String, dynamic>> monthlyExpenses = {
  'July': {
    'receivedAmount': {'allowance': 3200},
    'expenseAmount': {
      'chickenJoo': 350,
      'mineralWater': 280,
      'ballPointPen': 90,
      'transpoTrain': 280,
      'publicTranspo': 900,
    }
  },
  'August': {
    'receivedAmount': {'allowance': 3500},
    'expenseAmount': {
      'chickenJoo': 400,
      'mineralWater': 300,
      'ballPointPen': 100,
      'transpoTrain': 300,
      'publicTranspo': 1000,
    }
  },
  'September': {
    'receivedAmount': {'allowance': 3600},
    'expenseAmount': {
      'chickenJoo': 420,
      'mineralWater': 320,
      'ballPointPen': 110,
      'transpoTrain': 310,
      'publicTranspo': 1050,
    }
  }
};

final Map<String, Map<String, dynamic>> studentProfiles = {
  'first_member': {
    'fullName': {
      'last_name': 'Baby',
      'first_name': 'Justin',
      'middle_initial': 'R',
    },
    'course': 'BS Computer Science',
    'contact_info': {
      'email': 'justin.baby@example.com',
      'phone': '+63 912 345 6789',
    },
    'address': {
      'region': 'NCR',
      'province': 'Metro Manila',
      'city': 'Quezon City',
      'barangay': 'Central',
      'home_address': '123 Sampaguita St.'
    },
    'expenses': {
      'food': 600,
      'transport': 300,
      'supplies': 150,
      'internet': 800,
      'printing': 120,
      'snacks': 200,
      'coffee': 180,
      'tuitionMisc': 500,
      'phoneLoad': 250,
      'laundry': 200,
    }
  },
  'second_member': {
    'fullName': {
      'last_name': 'Pilapil',
      'first_name': 'Frix',
      'middle_initial': '',
    },
    'course': 'BS Information Technology',
    'contact_info': {
      'email': 'frix.pilapil@gmail.com',
      'phone': '+63 951 6845 135',
    },
    'address': {
      'region': 'NCR',
      'province': 'Metro Manila',
      'city': 'Pasig',
      'barangay': 'Sta.Lucia',
      'home_address': '35 E Main St.'
    },
    'expenses': {
      'food': 700,
      'transport': 350,
      'supplies': 120,
      'internet': 900,
      'printing': 100,
      'snacks': 220,
      'coffee': 150,
      'tuitionMisc': 400,
      'phoneLoad': 300,
      'laundry': 180,
    }
  },
  'third_member': {
    'fullName': {
      'last_name': 'Aniog',
      'first_name': 'Dayer',
      'middle_initial': 'V',
    },
    'course': 'BS Yearning',
    'contact_info': {
      'email': 'dayer.aniog@example.com',
      'phone': '+63 918 333 4444',
    },
    'address': {
      'region': 'NCR',
      'province': 'Metro Manila',
      'city': 'Pasig',
      'barangay': 'Manggahan',
      'home_address': '88 Mayon St.'
    },
    'expenses': {
      'food': 650,
      'transport': 320,
      'supplies': 130,
      'internet': 700,
      'printing': 110,
      'snacks': 210,
      'coffee': 140,
      'tuitionMisc': 450,
      'phoneLoad': 260,
      'laundry': 190,
    }
  },
  'fourth_member': {
    'fullName': {
      'last_name': 'Victorino',
      'first_name': 'Angelo',
      'middle_initial': 'M',
    },
    'course': 'BS Nursing',
    'contact_info': {
      'email': 'angelo.victorino@example.com',
      'phone': '+63 919 555 6666',
    },
    'address': {
      'region': 'NCR',
      'province': 'Metro Manila',
      'city': 'Quezon City',
      'barangay': 'Cutud',
      'home_address': '200 Clark Rd.'
    },
    'expenses': {
      'food': 720,
      'transport': 340,
      'supplies': 160,
      'internet': 850,
      'printing': 130,
      'snacks': 230,
      'coffee': 170,
      'tuitionMisc': 480,
      'phoneLoad': 280,
      'laundry': 210,
    }
  },
};

final Map<int, Map<String, dynamic>> drawerContent = {
  0: {
    'leading': Icons.home,
    'title': 'Home',
    'route': null,
  },
  1: {
    'leading': Icons.person,
    'title': 'Profile Pages',
    'route': '/profiles',
  }
};
