import 'diffusion.dart';

class Emission {
  final String id;
  final String tagStream;
  final String imageStream;
  final String nomStream;
  final String chaineRadio;
  final List<Diffusion> diffusions;

  Emission({
    required this.id,
    required this.tagStream,
    required this.imageStream,
    required this.nomStream,
    required this.chaineRadio,
    required this.diffusions,
  });
}