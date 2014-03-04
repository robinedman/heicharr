class StructureReport
  # Outputs a structure report of the company hierarchy, based on who
  # reports to whom.
  def self.by_manager
    recurse = -> (nodes = structure_by_manager_trees, prefix = '') do
      nodes.each do |node|
        puts "#{prefix}#{node.value}"
        recurse.call(node.children, prefix + '    ')
      end
    end

    recurse.call
    return nil
  end

  # Outputs a report of the employees' salaries.
  def self.by_salary
    puts "Salary\tName".upcase
    Employee.order(salary: :desc).each do |e|
      puts "#{e.salary}\t#{e.name}"
    end
    puts
  end


  # Private method that constructs trees representing the company hierarchy, 
  # based on who reports to whom. More than one tree may be created since
  # there may be several "top-level" managers in the database.
  def self.structure_by_manager_trees
    recurse = -> (manager = nil) do
      managers = Employee.where(manager: manager)
      
      nodes = managers.map { |manager| Node.new(manager, []) }
      nodes.each { |node| node.children = recurse.call(node.value.name) }
      
      nodes
    end
    
    recurse.call
  end
  private_class_method :structure_by_manager_trees

  # A tree node for constructing a tree data structure
  # value: any object
  # children: empty array or array of Nodes 
  Node = Struct.new(:value, :children)
  private_constant :Node
end
