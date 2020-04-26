#!/bin/bash

folder_name=$(date +%Y-%m-%d_%H:%M)
mkdir /home/$USER/analyse_smart_contracts/$folder_name
echo "Starting visualisation diagram of  "$2" contract whith Surya"
surya_graph=$(surya graph $1 | dot -Tpng > /home/$USER/analyse_smart_contracts/$folder_name/$2_surya.png)
echo "Starting inheritance diagram of "$2" contract with Surya"
surya_Inheritance=$(surya inheritance $1 | dot -Tpng > /home/$USER/analyse_smart_contracts/$folder_name/$2_inheritance_surya.png)
echo "Starting UML diagram of "$2" contract with Sol2uml"
sol2uml=$(sol2uml $1 -f png -o /home/$USER/analyse_smart_contracts/$folder_name/$2_sol2uml.png)
echo "End of diagrams generation"
echo "Starting the analysis of "$2" contract"
echo "Starting analysis using Mythx"
mythx_analyse=$(mythos analyze $1 $2 --mythxEthAddress=$3 --mythxPassword=$4 > /home/$USER/analyse_smart_contracts/$folder_name/mythx_$2.txt 2> /dev/null)
echo "End of Mythx analysis"
echo "Starting analysis using Mythril"
mythril_analyse=$(myth analyze $1 --solv $4 --max-depth $5 > /home/$USER/analyse_smart_contracts/$folder_name/mythril_$2.txt)
echo "End of Mythril analysis"
echo "Starting analysis using SmartCheck"
smartcheck_analyse=$(smartcheck -p $1 > /home/$USER/analyse_smart_contracts/$folder_name/smartcheck_$2.txt)
echo "End of SmartCheck analysis"
echo "Finished the analysis of "$2" contract"
$(rm /home/$USER/analyse_smart_contracts/$folder_name/$2_sol2uml.svg)
echo "End of script"

