import 'package:flutter/material.dart';
import '../models/step_entry.dart';
import '../models/water_entry.dart';

class HomeScreen extends StatelessWidget {
  final List<StepEntry> stepEntries;
  final List<WaterEntry> waterEntries;

  const HomeScreen({
    super.key,
    required this.stepEntries,
    required this.waterEntries,
  });

  int get _totalSteps =>
      stepEntries.fold<int>(0, (sum, e) => sum + e.steps);

  double get _totalWater =>
      waterEntries.fold<double>(0, (sum, e) => sum + e.liters);

  double get _avgSteps =>
      stepEntries.isEmpty ? 0 : _totalSteps / stepEntries.length;

  double get _avgWater =>
      waterEntries.isEmpty ? 0 : _totalWater / waterEntries.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Tracker'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            const Text(
              '📊 Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Your fitness summary at a glance',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),

            // Steps Summary Card
            _buildSummaryCard(
              context,
              icon: Icons.directions_walk,
              title: 'Steps',
              color: Colors.blue,
              children: [
                _buildStatRow('Total Entries', '${stepEntries.length}'),
                _buildStatRow('Total Steps', _formatNumber(_totalSteps)),
                _buildStatRow(
                    'Average Steps', _formatNumber(_avgSteps.round())),
                if (stepEntries.isNotEmpty)
                  _buildStatRow(
                    'Overall Status',
                    _getStepsCategory(_avgSteps.round()),
                    valueColor: _getStepsCategoryColor(_avgSteps.round()),
                  ),
              ],
            ),

            const SizedBox(height: 16),

            // Water Summary Card
            _buildSummaryCard(
              context,
              icon: Icons.water_drop,
              title: 'Water Intake',
              color: Colors.cyan,
              children: [
                _buildStatRow('Total Entries', '${waterEntries.length}'),
                _buildStatRow(
                    'Total Water', '${_totalWater.toStringAsFixed(1)} L'),
                _buildStatRow(
                    'Average Water', '${_avgWater.toStringAsFixed(1)} L'),
                if (waterEntries.isNotEmpty)
                  _buildStatRow(
                    'Overall Status',
                    _getWaterCategory(_avgWater),
                    valueColor: _getWaterCategoryColor(_avgWater),
                  ),
              ],
            ),

            const SizedBox(height: 24),

            // Recent Steps
            if (stepEntries.isNotEmpty) ...[
              const Text(
                'Recent Steps',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ..._getRecentSteps().map((e) => _buildRecentTile(
                    icon: Icons.directions_walk,
                    title: e.formattedDate,
                    subtitle: '${_formatNumber(e.steps)} steps',
                    category: e.category,
                    categoryColor: _getStepsCategoryColor(e.steps),
                  )),
            ],

            const SizedBox(height: 16),

            // Recent Water
            if (waterEntries.isNotEmpty) ...[
              const Text(
                'Recent Water Intake',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ..._getRecentWater().map((e) => _buildRecentTile(
                    icon: Icons.water_drop,
                    title: e.formattedDate,
                    subtitle: '${e.liters.toStringAsFixed(1)} L',
                    category: e.category,
                    categoryColor: _getWaterCategoryColor(e.liters),
                  )),
            ],

            if (stepEntries.isEmpty && waterEntries.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  child: Column(
                    children: [
                      Icon(Icons.fitness_center,
                          size: 64, color: Colors.grey.shade400),
                      const SizedBox(height: 16),
                      Text(
                        'No data yet!\nStart tracking your fitness.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<StepEntry> _getRecentSteps() {
    final sorted = List<StepEntry>.from(stepEntries)
      ..sort((a, b) => b.date.compareTo(a.date));
    return sorted.take(3).toList();
  }

  List<WaterEntry> _getRecentWater() {
    final sorted = List<WaterEntry>.from(waterEntries)
      ..sort((a, b) => b.date.compareTo(a.date));
    return sorted.take(3).toList();
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 28),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String category,
    required Color categoryColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue.shade400),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: categoryColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            category,
            style: TextStyle(
              color: categoryColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(number % 1000 == 0 ? 0 : 1)}k';
    }
    return number.toString();
  }

  String _getStepsCategory(int steps) {
    if (steps < 4000) return 'Bad';
    if (steps <= 8000) return 'Average';
    return 'Good';
  }

  Color _getStepsCategoryColor(int steps) {
    if (steps < 4000) return Colors.red;
    if (steps <= 8000) return Colors.orange;
    return Colors.green;
  }

  String _getWaterCategory(double liters) {
    if (liters < 1.5) return 'Bad';
    if (liters <= 2.0) return 'Average';
    return 'Good';
  }

  Color _getWaterCategoryColor(double liters) {
    if (liters < 1.5) return Colors.red;
    if (liters <= 2.0) return Colors.orange;
    return Colors.green;
  }
}
