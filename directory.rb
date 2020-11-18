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

def print_students_list
   cohorts = @students.map{ |student| student[:cohort]}.uniq
   if !@students.empty?
   cohorts.each { |cohort|
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
   name = gets.chomp
   cohort = gets.chomp
   while !name.empty? do
        @students << {name: name, cohort: cohort.to_sym}
        puts "Now we have #{@students.count} students"
        name = gets.chomp
        cohort = gets.chomp
   end
end

def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
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
        when "9"
            exit
        else
            puts "I don't know what you meant, try again"
    end
end

def interactive_menu
    loop do
        print_menu
        process(gets.chomp)
    end
end

interactive_menu

