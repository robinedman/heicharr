require 'spec_helper'

describe "An Organisational Structure By Manager report" do
  before :each do
    DatabaseCleaner.clean
  end

  it "uses a correctly nested structure" do
    import_csv('./spec/data/well_formed_sherwood.csv')
    trees = StructureReport.send(:structure_by_manager_trees)
    robin_hood = trees.select { |node| node.value.name == 'Robin Hood' }.first
    
    expect(robin_hood.value.name).to eq('Robin Hood')
    expect(robin_hood.children
      .map(&:value)
      .map(&:name)
      .sort).to eq(['Friar Tuck', 'Little John', 'Maid Marion'])

    maid_marion = robin_hood.children.select { |node| node.value.name == 'Maid Marion' }.first
    expect(maid_marion.children
      .map(&:value)
      .map(&:name)).to eq(['Will Scarlett'])
  end
end
