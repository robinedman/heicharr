def import_csv(filename)
  csv_employees = CSV.table(filename, skip_blanks: true)
  csv_employees.each do |e| Employee.create!(
                              name: e[:employee_name],
                              manager: e[:manager],
                              department: e[:department],
                              salary: e[:salary]) 
  end
end

