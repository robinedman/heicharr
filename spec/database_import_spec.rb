require 'spec_helper'

describe "When importing data from a csv file" do
  before :each do
    DatabaseCleaner.clean
  end

  it "populates the database with this data" do
    expect(Employee.count).to eq(0)
    import_csv('./spec/data/well_formed_sherwood.csv')
    expect(Employee.count).to eq(8)
  end

  it "handles unexpected extra columns" do
    expect(Employee.count).to eq(0)
    import_csv('./spec/data/with_extra_columns.csv')

    employee = Employee.first
    expect(employee.name).to eq("Robin Hood")
    expect(employee.manager).to be_nil
    expect(employee.department).to be_nil
    expect(employee.salary).to eq(200.00)

    expect(Employee.count).to eq(4)
  end

  it "ignores empty lines" do
    expect(Employee.count).to eq(0)
    import_csv('./spec/data/with_extra_empty_lines.csv')
    expect(Employee.count).to eq(8)
  end

  it "requires a name to be present" do
    expect(Employee.count).to eq(0)
    expect {
      import_csv('./spec/data/without_name_column.csv')
    }.to raise_error(ActiveRecord::RecordInvalid)

  end

end
