echo "this is a simple script for work with java spring boot"
echo "Auth: Jorge Brandon Chandomi Esponda"
echo "dont forget use spe in the root path of the project"

readonly comand=$1
readonly secondParam=$2

echo "? Enter the project name without special characters or spaces"
read -e -p "> " projectName

if [ $comand = "init" ]; then
    echo "generating work three"
    mkdir src/main/java/com/example/$projectName/controllers
    mkdir src/main/java/com/example/$projectName/controllers/dtos
    mkdir src/main/java/com/example/$projectName/controllers/dtos/request
    mkdir src/main/java/com/example/$projectName/controllers/dtos/response
    mkdir src/main/java/com/example/$projectName/entities
    mkdir src/main/java/com/example/$projectName/repositories
    mkdir src/main/java/com/example/$projectName/services
    mkdir src/main/java/com/example/$projectName/services/interfaces
    

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
            read -e -p "> " databaseName+
            echo "? user name"
            read -e -p "> " userName
            echo "? password"
            read -e -p "> " password

            echo -e "spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL8Dialect" >> src/main/resources/application.properties
            echo -e  "spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver" >> src/main/resources/application.properties
            echo -e  "spring.jpa.hibernate.ddl-auto=update" >> src/main/resources/application.properties
            echo -e  "spring.datasource.url=$databaseName" >> src/main/resources/application.properties
            echo -e  "spring.datasource.username=$userName" >> src/main/resources/application.properties
            echo -e  "spring.datasource.password=$password" >> src/main/resources/application.properties


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

if [ $comand = "g" ]; then 
    case $secondParam in 
        controller)
            nameParam=$3
            touch src/main/java/com/example/$projectName/controllers/$3Controller.java
            echo -e 'package com.example.'$projectName'.controllers; \n
            @RestController
            @RequestMapping("'$nameParam'")
            public class '$nameParam'Controller{}' | awk '{gsub(/^[ \t]+/,""); print$0, ""}' >> src/main/java/com/example/$projectName/controllers/$3Controller.java
        ;;
        entity)
            nameParam=$3
            touch src/main/java/com/example/$projectName/entities/$nameParam.java
            echo -e "package com.example.$projectName.entities; \n
            public class "$nameParam"{}" | awk '{gsub(/^[ \t]+/,""); print$0, ""}' >> entities/$nameParam.java

            read -e -p "generate repository? Y/n " YoN
            if [ YoN = "y" ]; then 
                touch src/main/java/com/example/$projectName/repositories/I$3Repository.java
                echo -e "package com.example."$projectName".repositories; \n
                import com.example.$proyectName.entities.$3; \n
                import org.springframework.data.jpa.repository.JpaRepository; \n
                import org.springframework.stereotype.Repository; \n
                public interface I$3Repository extends JpaRepository<$3, Long>{}
                " | awk '{gsub(/^[ \t]+/,""); print$0, ""}' >> repositories/I$3Repository.java
            fi
        ;;
        service)
            nameParam=$3
            touch src/main/java/com/example/$projectName/services/interfaces/I$3Service.java
            echo -e "package com.example.$projectName.services.interfaces; \n
            public interface I$3Service{}
            " | awk '{gsub(/^[ \t]+/,""); print$0, ""}' >> services/interfaces/I$3Service.java

            touch src/main/java/com/example/$projectName/services/$3ServiceImpl.java
            echo -e "package com.example.$projectName.services;
            import com.example.$projectName.services.interfaces.I$3Service;
            \npublic class $3ServiceImpl implements I$3Service{}
            " | awk '{gsub(/^[ \t]+/,""); print$0, ""}' >> services/$3ServiceImpl.java
        ;;
        -help)
            echo -e "params for spe g: 

            controller <name>       Generate rest controller
            entity <name>           Generate entity and repository
            service <name>          Generate service inteface and servide implements

            you can try: spe g controller <name>" | awk '{gsub(/^[ \t]+/,""); print$0, ""}'
        ;;
        *)
            echo "invaid option $REPLY see: spe g -help for more information"
        ;;
    esac
fi


if [ $comand = "dto" ]; then 
    case $secondParam in 
        rq)
            nameParam=$3
            if [ $nameParam = ""]; 
            then 
                echo "dto require a third param see: spe dto -help for more information"
            else
                echo "generating | request | $projectName"
                touch src/main/java/com/example/$projectName/controllers/dtos/request/Create$3Request.java
                echo -e "package com.example.$projectName.controllers.dtos.request; \n
                public class Create"$nameParam"Request{}
                " | awk '{gsub(/^[ \t]+/,""); print$0, ""}' >> src/main/java/com/example/$projectName/controllers/dtos/request/Create$3Request.java
            fi
            ;;
        rp)
            nameParam=$3
            if [ $nameParam = ""]; 
            then 
                echo "dto require a third param see: spe dto -help for more information"
            else
                echo "generating | response | $projectName"
                touch src/main/java/com/example/$projectName/controllers/dtos/response/Create$3Response.java
                echo -e "package com.example.$projectName.controllers.dtos.response; \n
                public class Create"$nameParam"Response{}
                " | awk '{gsub(/^[ \t]+/,""); print$0, ""}' >> src/main/java/com/example/$projectName/controllers/dtos/response/Create$3Response.java
            fi
            ;;
        bt)
            nameParam=$3
            if [ $nameParam = ""]; 
            then 
                echo "dto require a third param see: spe dto -help for more information"
            else
                echo "generating | request/response | $projectName"
                
                touch src/main/java/com/example/$projectName/controllers/dtos/request/Create$3Request.java
                echo -e "package com.example.$projectName.controllers.dtos.request; \n
                public class Create"$nameParam"Request{}
                " | awk '{gsub(/^[ \t]+/,""); print$0, ""}' >> src/main/java/com/example/$projectName/controllers/dtos/request/Create$3Request.java

                touch src/main/java/com/example/$projectName/controllers/dtos/response/Create$3Response.java
                echo -e "package com.example.$projectName.controllers.dtos.response; \n
                public class Create"$nameParam"Response{}
                " | awk '{gsub(/^[ \t]+/,""); print$0, ""}' >> src/main/java/com/example/$projectName/controllers/dtos/response/Create$3Response.java
            fi
            ;;
        -help)
            echo -e "params for spe dto: 

            rq <name>           Generate request
            rp <name>           Generate response
            bt <name>           Generate request and response

            you can try: spe dto rq <name>" | awk '{gsub(/^[ \t]+/,""); print$0, ""}'
            ;;
        *) 
            echo "invaid option $REPLY see: spe dto -help for more information"

            ;;
        esac
    
fi