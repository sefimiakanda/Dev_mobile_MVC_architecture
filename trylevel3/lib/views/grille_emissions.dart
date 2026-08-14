import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import '../models/emission.dart';
import 'carte_emission.dart';

class GrilleEmissions extends StatelessWidget {
  final List<Emission> emissions;
  final Function(Emission) onEmissionTap;

  const GrilleEmissions({
    Key? key,
    required this.emissions,
    required this.onEmissionTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsiveGridList(
        desiredItemWidth: 160,
        minSpacing: 10,
        children: emissions.map((emission) {
          return CarteEmission(
            emission: emission,
            onTap: () => onEmissionTap(emission),
          );
        }).toList(),
      ),
    );
  }
}