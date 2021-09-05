// ignore_for_file: file_names, non_constant_identifier_names, unnecessary_this

class Employee {

  final String emp_name;
  final String emp_id;
  final int warnings;

  const Employee ({

    required this.emp_name,
    required this.emp_id,
    required this.warnings,
    
  });

  Employee copy({
    String? emp_name,
    String? emp_id,
    int? warnings,
      }) =>
        Employee(
          emp_name: emp_name!,
          emp_id: emp_id!,
          warnings: warnings!,
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Employee &&
          runtimeType == other.runtimeType &&
          emp_name == other.emp_name &&
          emp_id == other.emp_id &&
          warnings == other.warnings;

  @override
  int get hashCode => emp_name.hashCode ^ emp_id.hashCode ^ warnings.hashCode;
}