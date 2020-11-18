# first we print the list of students
=begin
students = [
   {name: "Dr. Hannibal Lecter", cohort: :november},
   {name: "Darth Vader", cohort: :november},
   {name: "Nurse Ratched", cohort: :november},
   {name: "Michael Corleone", cohort: :november},
   {name: "Alex DeLarge", cohort: :november},
   {name: "The Wicked Witch of the West", cohort: :november},
   {name: "Terminator", cohort: :november},
   {name: "Freddy Kreuger", cohort: :november},
   {name: "The Joker", cohort: :november},
   {name: "Joffrey Baratheon", cohort: :november},
   {name: "Norman Bates", cohort: :november}
   ]
=end

=begin
def print(students)
    current_index = 0
    while current_index < students.length
        puts "#{current_index+1}. #{students[current_index][:name]} (#{students[current_index][:cohort]})"
        current_index += 1
    end
end
=end

=begin
def print(students)
  students.each_with_index { |student, index|
      if student[:name].length < 12
        puts "#{index+1}. #{student[:name]}, (#{student[:cohort]} cohort)"
      end
  }
end
=end

@students = []

def print_header
  puts "The Students of Villains Academy".center(50)
  puts "-------------".center(50)
end

def unique_cohorts
    @students.map{ |student| student[:cohort]}.uniq
end

def print_students_list
   if !@students.empty?
   unique_cohorts.each { |cohort|
    puts "From #{cohort.to_s} cohort:"
    @students.each { |student|
        if student[:cohort].to_sym == cohort
            puts student[:name]
        end
     }
    }
   end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def input_students
   puts "Please enter the names and cohorts of the students"
   puts "To finish, just hit return twice"
   name = STDIN.gets.chomp
   cohort = STDIN.gets.chomp
   while !name.empty? do
        update_hash(name, cohort)
        puts "Now we have #{@students.count} students"
        name = STDIN.gets.chomp
        cohort = STDIN.gets.chomp
   end
end

def update_hash(name, cohort)
        @students << {name: name, cohort: cohort.to_sym}
end

def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list to a csv"
    puts "4. Load the list from a csv"
    puts "9. Exit"
end

def show_students
    print_header
    print_students_list
    print_footer
end

def process(selection)
    case selection
        when "1"
            input_students
        when "2"
            show_students
        when "3"
            save_students
        when "4"
            load_students
        when "9"
            exit
        else
            puts "I don't know what you meant, try again"
    end
end

def save_students(filename = "students.csv")
    puts "What file would you like to save to?"
    filename = STDIN.gets.chomp
    File.open(filename, "w") do |file|
        @students.each { |student|
        student_data = [student[:name], student[:cohort]]
        csv_line = student_data.join(",")
        file.puts csv_line
        }
    end
    puts "Saved #{@students.count} to #{filename}"
end

def load_students(filename = "students.csv")
    puts "What file would you like to load from?"
    filename = STDIN.gets.chomp
    File.open(filename, "r") do |file|
    file.readlines.each { |line|
        name, cohort = line.chomp.split(",")
        update_hash(name, cohort)
    }
    end
    puts "Loaded #{@students.count} from #{filename}"
end

def try_load_students(filename = "students.csv")
    filename = ARGV.first if !ARGV.empty?
    if File.exists?(filename)
        load_students(filename)
        puts "Loaded #{@students.count} from #{filename}"
    else
        puts "Sorry, #{filename} doesn't exist"
        exit
    end
end

def interactive_menu
    loop do
        print_menu
        process(STDIN.gets.chomp)
    end
end

try_load_students
interactive_menu

