#! /bin/sh
# k.lopatina@ispsystem.com
green(){
      printf "\033[32;1m$@\033[0m\n"
}
red(){
      printf "\033[31;1m$@\033[0m\n"
}
read -p "Обновить interlayer и mobile  (y, n)? " yn                                                                                
case $yn in                                                                                                             
           [Yy]* )  
echo -n "Укажите бранч interlayer: "
read bi
wget -O artifacts.zip --header "PRIVATE-TOKEN: egSoecMRs8xNf4qst1PX" "https://gitlab-dev.ispsystem.net/api/v4/projects/80/jobs/artifacts/$bi/download?job=build"
 if  [ $? -eq 0 ]; then
   rm -rf dist/
   unzip artifacts.zip
     if  [ ! $? -eq 0 ]; then
       yum -y install unzip
       green "unzip установлен"
       unzip artifacts.zip
     fi
   rm -rf artifacts.zip
   green "Проект interlayer успешно обновлен из бранча $bi "
 else
   red "Что-то пошло не так. Проект interlayer не обновлен :("
   echo "Проверьте правильность введенных данных или перейдите по ссылке: https://gitlab-dev.ispsystem.net/api/v4/projects/80/jobs/artifacts/$bi/download?job=build"
   exit;
 fi

cd dist/
echo -n "Укажите бранч mobile: "
read bm                                                                                   
wget -O artifacts.zip --header "PRIVATE-TOKEN: egSoecMRs8xNf4qst1PX" "https://gitlab-dev.ispsystem.net/api/v4/projects/82/jobs/artifacts/$bm/download?job=build"
  if  [ $? -eq 0 ]; then 
    rm -rf public/
    unzip artifacts.zip
    rm -rf artifacts.zip
    mv dist/ public
    cd public/
    mv bill-mobile/ m
    green "Проект mobile успешно обновлен из бранча $bm "
  else
    red "Что-то пошло не так. Проект mobile  не обновлен :("                                                      
    echo "Проверьте правильность введенных данных или перейдите по ссылке: https://gitlab-dev.ispsystem.net/api/v4/projects/80/jobs/artifacts/$bm/download?job=build"$
  fi
exit;
break;;

   [Nn]*)
    read -p "Обновить только mobile  (y, n)? " yn
    case $yn in                                                                                                          
      [Yy]* )
      echo -n "Укажите бранч mobile: "
      read bm
      cd dist/
        if  [ ! $? -eq 0 ]; then
          red "Директория dist не найдена."
          echo " Для корректной работы mobile необходимо выполнить обновление совместно с interlayer или запустить данный скрипт в директории внутри которой расположена папка dist проекта interlayer"
        exit;
        fi
wget -O artifacts.zip --header "PRIVATE-TOKEN: egSoecMRs8xNf4qst1PX" "https://gitlab-dev.ispsystem.net/api/v4/projects/82/jobs/artifacts/$bm/download?job=build"
    if  [ $? -eq 0 ]; then
        rm -rf public/
        unzip artifacts.zip
           if  [ ! $? -eq 0 ]; then                                                                                             
             yum -y install unzip                                                                                            
             green "unzip установлен"                                                                                           
             unzip artifacts.zip                                                                                               
            fi
rm -rf artifacts.zip
mv dist/ public
cd public/
mv bill-mobile/ m
green "Проект mobile успешно обновлен из бранча $bm "
    else
red "Что-то пошло не так. Проект mobile  не обновлен :("
echo "Проверьте правильность введенных данных или перейдите по ссылке: https://gitlab-dev.ispsystem.net/api/v4/projects/80/jobs/artifacts/$bm/download?job=build"
    fi
exit;
break;;
   [Nn]* )
    echo 
    red "Пока:)"
    exit;;
esac
esac
                                                                                                   


