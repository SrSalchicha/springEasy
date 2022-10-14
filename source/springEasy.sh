echo "this is a simple script for work with java springbook"
echo "Auth: Jorge Brandon Chandomi Esponda"
echo ""

readonly comand=$1
readonly secondParam=$2
projectName=""

if [ projectName = "" ]; then 
    echo "? Enter the project name"
    read -e -p "> " projectName
fi

if [ $comand = "init" ]; then
    echo "generating work three"
    mkdir controllers
    mkdir controllers/dtos
    mkdir controllers/dtos/request
    mkdir controllers/dtos/response
    mkdir entities
    mkdir repositories
    mkdir services
    mkdir services/interfaces
    

    echo "sugested dependencies: 
    
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jdbc</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-devtools</artifactId>
            <scope>runtime</scope>
            <optional>true</optional>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
            <version>2.6.6</version>
        </dependency>
    
    "


    echo "the database configuration only works for mysql and mariaDB"
    echo "are you using MySql or MariaDB?"
    select YoN in yes no
    do 
        if [ $YoN = "yes" ]; then
            echo "setting up database config"
            echo "? data source URL 
            example: jdbc:mysql://localhost:3306/<database name>"
            read -e -p "> " databaseName
            echo "? user name"
            read -e -p "> " userName
            echo "? password"
            read -e -p "> " password

            echo -e "
            spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL8Dialect
            spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
            spring.jpa.hibernate.ddl-auto=update
            spring.datasource.url=$databaseName
            spring.datasource.username=$userName
            spring.datasource.password=$password
            " >> src/main/resources/application.propieties

            echo "SUCCESS: please configure the maven dependencies for mysql
            <dependency>
                <groupId>mysql</groupId>
                <artifactId>mysql-connector-java</artifactId>
                <version>8.0.27</version>
            </dependency>
            "

            break
        fi
        break
    done
fi

if [ $comand == "g" ]; then 
    case $secondParam in 
        controller)
            break
        ;;
        dto)
            break
        ;;
        entity)
            break
        ;;
        repository)
            break
        ;;
        service)
            break
        ;;
        serviceI)
            break
        ;;
        *)
            break
        ;;
    esac
fi


if [ $comand == "RR" ]; then 
    case $secondParam in 
        rq)
            nameParam=$3
            if [ $nameParam == ""]; 
            then 
                echo "RR require a third param see: RR -help for more information"
            else
                echo "generating | request | $projectName"
                touch controllers/dtos/request/Create$1Request.java
                echo -e "package com.example.$projectName.controllers.dtos.request; \n
                public class Create"$name"Request{}" >> controllers/dtos/request/Create$1Request.java
            fi
            break
            ;;
        rp)
            echo "generating | response | $projectName"
            break
            ;;
        bt)
            echo "generating | request/response | $projectName"
            break
            ;;
        -help)
            echo "
            params for SPE RR:

            rq <name>           Generate request
            rp <name>           Generate response
            bt <name>           Generate request and response

            you can try: SPE RR RQ <name>
            "
            break
            ;;
        *) 
            echo "invaid option $REPLY see RR -help for more information"
            break
            ;;
        esac
    
fi