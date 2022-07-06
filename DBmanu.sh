#!/bin/bash            
PS3=' "Press 1 to CREATE DATABASE"
 "Press 2 to SHOW DATABASES"		
 "Press 3 Connect To Databases "
 "Press 4 DROP DATABASE "
 "Press exit to exit menu" 
 ?'                                                           
select cmd in ""
do
        case $REPLY in
               1) echo "Please enter root user MySQL password!"
		read -s rootpasswd
		echo "Enter database name!"
		read DBname;
		mysql -uroot  -p${rootpasswd} -e "CREATE DATABASE  ${DBname};"
		echo "Database successfully created!"
                      ;;
               2) mysql -uroot -p${rootpasswd} -e "SHOW DATABASES \G"| tee project/database
                      ;;
               3) echo "Enter database name!"
               PS3='"Press 1 to CREATE Table"			"Press 2 to SHOW Table"
"Press 3 To insert inTable"			"Press 4 To Select Table"
"Press 5 To Drop Table"			        "Press 6 To delete from Table"  
"Press 7 To Update Table"		        "Press exit to exit menu" 
?'  
                  read DBname;
                 select cmd in ""
			do
        			case $REPLY in
				1) echo "Enter Table name"
					read Tablename
					ARRAY=()
						dataarr=()
						read -p "Enter number of column you want to create : " n
						echo "enter primary key name"
						read name
						echo "enter int primary key"
						read datatype
						if [[ "$datatype" =~ 'int primary key' ]]; then
						    
						ARRAY+=($name $datatype",")
						num=$(($n - 1))
						for i in $(seq  $num); do
						   echo "enter name of column $i"
						  read name 
						  echo "enter data type"
						  read datatype

						 if [ $i == $num ]
						then
						    ARRAY+=($name $datatype )
						    dataarr+=($datatype)
						else
						ARRAY+=($name $datatype",")
						dataarr+=($datatype)
						fi
						done
						echo "$tablename(${ARRAY[@]})"
						#echo "$tablename(${ARRAY[@]})">> pattern

						else
						echo "please enter primary key"


						fi
						data="${ARRAY[@]}"

					mysql -uroot  -p${rootpasswd} -D${DBname} -e "CREATE TABLE  ${Tablename}($data) ;"
					echo "table created!"
				       	;;
				       	
				       	
				2) mysql -uroot -p${rootpasswd} -D${DBname}  -e "SHOW TABLES \G"| tee project/tables
				      ;;
				      
				      
				3) echo "Enter Table name!"
					read Tablename
					echo  "insert data between ()"
					read DataInsert
					mysql -uroot -p${rootpasswd} -D${DBname}  -e"INSERT INTO ${Tablename} VALUE${DataInsert};"
				      ;;
				      
				      
				4) echo  "insert Table Name to select data"
					read Tablename      
					mysql -uroot -p${rootpasswd} -D${DBname}  -e"SELECT * FROM ${Tablename}\G"| tee project/tabledata
					echo "select is  successfully"
						;;
						
						
						
				5) echo  "insert Table Name to drop table"
					read Tablename      
					mysql -uroot -p${rootpasswd} -D${DBname}  -e "DROP TABLE IF EXISTS ${Tablename};"
						;;
						
						
						
				6)  echo  "enter tablename  you want to delete"
					read Tablename
					 echo  "enter  condition row you want to delete"
					read rowdelete
					mysql -uroot -p${rootpasswd} -D${DBname}  -e "DELETE FROM ${Tablename} WHERE ${rowdelete} ;"        
					
						;;
						
						
						
				7)  echo  "insert tablename"
					read Tablename
				echo  "enter columnname"
					read columnname
				echo "new value"
					read newValue
				echo "condition"
					read condition
					
					mysql -uroot -p${rootpasswd} -D${DBname}  -e "UPDATE ${Tablename} SET ${columnname} =${newValue}  where ${condition};"
					echo "Update successfully"
					
						;;
						
						
				'exit')
					break
				      ;;

				*)echo $REPLY are not found
				      ;;

				esac
				done
				;;

		4)echo "Enter database want to drop !" 
		  read DBname;
		  mysql -uroot -p${rootpasswd}  -e "DROP DATABASE ${DBname};"
		  echo "Database successfully droppped!"
		      ;;
		'exit')
			break
		        ;;
               *)echo $REPLY are not found
                      ;;
               
         esac
done


