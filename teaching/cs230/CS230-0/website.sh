#!/bin/bash
declare -i total
index=1
prev=0
next=2
cours=$1
total=$(ls Slide*.jpg | wc -l)

idx="1";
for img in $(ls Slide*.jpg)
do
	rm -rf Slide${index}.html 2>/dev/null
	if [ $index -lt 10 -a $total -ge 10 ]; then
		idx="0${index}"
	else
	  idx=$index
	fi	
	echo "<html>" >> Slide${index}.html
	echo "<body>" >> Slide${index}.html
	echo "  <img src=\"Slide${idx}.jpg\" width=\"720\" height=\"540\" alt=\"Slide${index}\" usemap=\"#slide\"/>" >> Slide${index}.html
	echo "  <map name=\"slide\">" >> Slide${index}.html	
	if ((prev==0)); then
		echo "    <area shape=\"rect\" coords=\"0,90,360,490\" href=\"../cours${cours}.html\" alt=\"precedent\"/>" >> Slide${index}.html
  else
  	echo "    <area shape=\"rect\" coords=\"0,90,360,490\" href=\"Slide${prev}.html\" alt=\"precedent\"/>" >> Slide${index}.html
  fi
  if ((next>total)); then
	 echo "    <area shape=\"rect\" coords=\"360,90,720,490\" href=\"../cours${cours}.html\" alt=\"suivant\"/>" >> Slide${index}.html
  else
  	echo "    <area shape=\"rect\" coords=\"360,90,720,490\" href=\"Slide${next}.html\" alt=\"suivant\"/>" >> Slide${index}.html
  fi
	echo "    <area shape=\"rect\" coords=\"0,490,720,540\" href=\"../cours${cours}.html\" alt=\"sommaire\"/>" >> Slide${index}.html
	echo "    <area shape=\"rect\" coords=\"0,0,720,90\" href=\"../cours${cours}.html\" alt=\"sommaire\"/>" >> Slide${index}.html
	echo "  </map>" >> Slide${index}.html
	echo "</body>" >> Slide${index}.html
	echo "</html>" >> Slide${index}.html
  ((index=index+1))
  ((prev=prev+1))
  ((next=next+1))
done
