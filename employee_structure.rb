require_relative 'boot'

def main
  filename = ARGV.fetch(0) { raise ArgumentError, 'A filename must be provided, e.g. ./employee_structure employees.csv'}
  import_csv(filename)

  StructureReport.by_manager
end

main
