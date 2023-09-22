#!/bin/bash
TEMPLATE_HOME="/home/$USER/dev/quick-question/templates/" # Change to your path
printf "Enter Question Name : "
read qname

# Set your template solution file names and the target filenames here (order is important)
originals=("test.cpp" "test.py")
newfiles=("$qname.cpp" "$qname.py")
filecount=${#originals[@]}

mkdir -p "$qname/solutions" "$qname/testcases/"{input,output}
for (( i=0; i<${filecount}; i++ ));
do
    cp "$TEMPLATE_HOME/solutions/${originals[$i]}" "$qname/solutions/${newfiles[$i]}"
done

cp "$TEMPLATE_HOME/run.rb" "$qname/"

# Default run.rb configuration
echo "{\"qname\": \"$qname\",\"lang\": \"cpp\"}" >> "$qname/conf.json"

echo "# $qname" >> "$qname/problem-statement.md"

printf "Enter Number of testcases : "
read x
for ((i=0; i < x; i++)); do
    touch "$qname/testcases/input/input$i.txt"
    touch "$qname/testcases/output/output$i.txt"
done

echo "Now cd into ./$qname/ and use ruby run.rb"