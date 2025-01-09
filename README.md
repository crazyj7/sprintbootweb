# sprintbootweb

spring boot web sample project

## 기본적인 간단한 구조.

- mysql 연동. 간단한 CRUD 기능
- 페이징 처리. ajax 통신.
- JPA 사용.
- Awesome font 사용
- 서블릿 테스트 (jsp 데이터 전송)
- 개발자 모드. (코드 변경시 자동 재실행)

## 누락파일
- src/main/resources/application-secret.properties  (설정파일)
@Configuration 으로 설정하면 application.properties에서 이 값을 환경변수 처럼 불러 사용할 수 있다.  
또는   
위 파일 대신 OS 환경변수를 사용한다. (MYSQL_URL=jdbc:mysql://localhost:3306/MYDB, MYSQL_USERNAME=crazyj7, MYSQL_PASSWORD=mypassword)  
둘 중 한가지 방식으로 하면 된다.   
그리고 변수 설정시 항상 공백에 주의한다!!!
- src/main/resources/static/fonts/fontawesome-free-6.7.2-web/  
다운 받아 설치한다.  
https://fontawesome.com/download
 - src/main/resources/static/fonts/NotoSansKR/  
다운 받아 설치한다.
https://fonts.google.com/noto/specimen/Noto+Sans+KR

## 실행
- mvn clean install
- mvn spring-boot:run






