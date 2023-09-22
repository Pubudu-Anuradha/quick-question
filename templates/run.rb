####
# usage: ruby run.rb [test_case_number]
# if test_case_number is not provided, all testcases will be run
# if test_case_number is provided, only that testcase will run
####

require "json"

$compiled = false

# Runs a specific test case in testcases/{input,output}/case_no
# Add your own cases for other programming languages if needed.
## Follow the example for cpp for compiled languages and py for interpreted ones
def runcase(case_no, lang = "cpp", qname = "test", pri = false)
  res = nil
  case lang
  when "cpp"
    if !$compiled
      state = `g++ solutions/"#{qname}.cpp" -o solutions/"#{qname}.exe"`
      $compiled = true
    end
    res = `timeout 2 ./solutions/"#{qname}.exe" < testcases/input/input#{case_no}.txt`
      .strip
  when "py"
    res = `timeout 2 python solutions/"#{qname}.py" < testcases/input/input#{case_no}.txt`.strip
  else
    puts "unsupported language. only cpp and py allowed as extensions"
  end
  if pri
    puts res
  end
  if res != nil
    solution = File.read "testcases/output/output#{case_no}.txt".strip
    solution = solution.split
    res = res.split
    passed = res.length == solution.length
    i = 0
    while passed && i < res.length
      passed = res[i].strip == solution[i].strip
      i += 1
    end

    puts solution == res ? "Testcase #{case_no} PASSED!" : "Testcase #{case_no} FAILED!"
  end
end

file = File.read "conf.json"
conf = JSON.parse file
lang = conf["lang"]
qname = conf["qname"]

if ARGV.length != 0
  runcase ARGV[0].to_i, lang, qname, true
else
  if ARGV[0] == "py" || ARGV[0] == "cpp"
    lang = ARGV[0]
  end
  n_input = `ls -1q testcases/input/input*.txt | wc -l`.to_i
  for i in 0..n_input - 1
    if (File.file? "testcases/input/input#{i}.txt") &&
       (File.file? "testcases/output/output#{i}.txt")
      runcase i, lang, qname
    end
  end
end

if $compiled
  state = `rm ./solutions/"#{qname}.exe"`
end
