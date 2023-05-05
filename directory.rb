require 'csv'

@students = []

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students "
  puts "2. Show the students"
  puts "3. Save the list of students to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def process(selection)
  case selection
    when "1"
      input_students
      feedback_message
    when "2"
      show_students
    when "3"
      save_students
      feedback_message
    when "4"
      load_students
      feedback_message
    when "9"
      exit
    else
      puts "I dont't know what you mean, try again"
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end
      
def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def feedback_message
  puts "Action successful!"
end

def show_students 
  print_header
  print_student_list
  print_footer
end

def print_student_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def save_students
  CSV.open("students.csv", "w") do |file|
    @students.each do |student|
     file << student_data = [student[:name], student[:cohort]]
    end
  end
end

def load_students(filename = "students.csv")
  CSV.open(filename, "r") do |file|
    file.each do |line|
      push_to_student_list(line[0], line[1])
    end
  end
end
 
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  while !name.empty? do
    puts "What cohort are they in? (month)"
    cohort = STDIN.gets.chomp
    push_to_student_list(name, cohort)
    puts "Now we have #{@students.count} students"
    name = STDIN.gets.chomp
  end
end

def push_to_student_list(name, cohort)
@students << {name: name, cohort: cohort.to_sym}
end

def try_load_students
  filename = ARGV.first
  if filename.nil?
    load_students
  elsif File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else 
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

try_load_students
interactive_menu


