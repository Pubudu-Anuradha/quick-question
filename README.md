# quick-question

Easy configurable problem+testing starter generation aimed at problem setting for competitive programming competitions.

## Requirements

- Bash
- ruby

## Setup

1. clone this repo
2. change the constants specified by the comments in `quick-question.sh`
3. add your own solution templates to `templates/solutions/`
4. Check whether `run.rb`'s runcase function has a case configured for eah of your languages(add if not)
5. change the `quick-question.sh`'s run.rb default configurations to your preferred language (you can change it after generation too)
6. run `quick-question.sh` and enjoy streamlined testing

## Example usage

```
$ ./quick-question.sh 
Enter Question Name : example
Enter Number of testcases : 2
Now cd into ./example/ and use ruby run.rb
$ cd example/
$ ruby run.rb 
Testcase 0 FAILED!
Testcase 1 FAILED!
$ cat solutions/example.cpp 
#include <iostream>
int main() {
  int a, b;
  std::cin >> a >> b;
  std::cout << a + b << std::endl;
}
$ echo "1 2" > testcases/input/input0.txt 
$ echo "3" > testcases/output/output0.txt 
$ ruby run.rb 
Testcase 0 PASSED!
Testcase 1 FAILED!
$ ruby run.rb 0
3
Testcase 0 PASSED!
$ tree
.
├── conf.json
├── problem-statement.md
├── run.rb
├── solutions
│   ├── example.cpp
│   └── example.py
└── testcases
    ├── input
    │   ├── input0.txt
    │   └── input1.txt
    └── output
        ├── output0.txt
        └── output1.txt

5 directories, 9 files
```
