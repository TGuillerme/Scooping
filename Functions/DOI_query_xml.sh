#!/bin/sh
##########################
# Creates a list of DOI queries for CrossRef
##########################
# SYNTAX :
# sh DOI_query_xml.sh <list_of_DOIs> <output>
# with
# <list_of_DOIs> being a text file with a DOI on each line.
# <output> name of the output file.
##########################
#guillert@tcd.ie - 2016/07/27
##########################

# Getting the DOI list
DOI_list=$1
output=$2

# DEBUG
# DOI_list="test_doi.txt"
# output="test_out"


####
# Initialising the xml file
####
echo "<?xml version = \"1.0\" encoding=\"UTF-8\"?>" > ${output}.xml
echo "<query_batch version=\"2.0\" xmlns = \"http://www.crossref.org/qschema/2.0\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">" >> ${output}.xml
echo "  <head>" >> ${output}.xml
echo "      <email_address>support@crossref.org</email_address>" >> ${output}.xml
echo "      <doi_batch_id>Get multiple DOI</doi_batch_id>" >> ${output}.xml
echo "  </head>" >> ${output}.xml
echo "  <body>" >> ${output}.xml

####
# Looping through all the DOIs
####

# Get the number of DOIs
Number_of_DOIs=$(wc -l $DOI_list | sed 's/ '"$DOI_list"'//g') 

# Loop through the DOIs
for one_doi in $(seq 1 $Number_of_DOIs)
do
    echo "       <query key=\"doi${one_doi}\" expanded-results=\"true\" enable-multiple-hits=\"true\">" >> ${output}.xml
    echo "           <doi>$(sed -n ''"${one_doi}"'p' $DOI_list)</doi>" >> ${output}.xml
    echo "       </query> " >> ${output}.xml
done

# Closing the xml file

echo "   </body>" >> ${output}.xml
echo "</query_batch>" >> ${output}.xml