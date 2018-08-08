 #! /bin/sh                                                                                                              
 # k.lopatina@ispsystem.com                                                                                              
 red(){                                                                                                                  
     printf "\033[31;1m$@\033[0m\n"                                                                                    
 }
green(){

printf "\033[32;1m$@\033[0m\n"
}

blue(){
printf "\033[36;1m$@\033[0m\n"
}
cat info
read -p "Обновить интерфейс (y, n)? " yn
                                                                                
case $yn in                                                                                                             
           [Yy]* )
	echo -n "Укажите бранч из которого выполнить обновление: "                                                                                        
	read a
	echo -n "Укажите нужную версию сборки (box или my):  "
	read v                                                                                                                 
            cd skins/                                                                                                                                                                           
            wget -O artifacts.zip --header "PRIVATE-TOKEN: egSoecMRs8xNf4qst1PX" "https://gitlab-dev.ispsystem.net/api/v4/projects/22/jobs/artifacts/$a/download?job=$v"
                            
   if  [ $? -eq 0 ]; then          
             rm -rf client/
             unzip artifacts.zip 
       if  [ ! $? -eq 0 ]; then
             yum -y  install unzip
             green "unzip установлен"
             unzip artifacts.zip
             rm -rf artifacts.zip   
             killall core
             green "Интерфейс успешно обновлен из бранча $a"
             green "Версия сборки $v"
            

      else       
             rm -rf artifacts.zip 
             
             killall core 
             green "Интерфейс успешно обновлен из бранча $a" 
             green "Версия сборки $v"
             d=$(date +%Y-%m-%d)
             t=$(date +%H:%M:%S)
             dir=/usr/local/mgr5/info
blue "Текущий бранч: $a  
Версия сборки: $v
Дата обновления: $d
Время обновления: $t">"$dir"

      fi
   else
	 
      red "Что-то пошло не так. Интерфейс не обновлен:("
      echo "Проверьте правильность введенных параметров или перейдите по ссылке https://gitlab-dev.ispsystem.net/api/v4/projects/22/jobs/artifacts/$a/download?job=$v"
   fi                                                                                               
          break;;                                                                                                                 
          [Nn]*)                                                                                    
          red "Пока :)"                                                                                                                 
exit;;
esac
