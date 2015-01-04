set catalina_home=c:\JspStudy\tomcat

set currpath=.\
if "%OS%" == "Windows_NT" set currpath=%~dp0%

set src=%currpath%src
set dest=%currpath%WEB-INF\classes
set classpath=%catalina_home%\lib\servlet-api.jar;%catalina_home%\lib\jsp-api.jar

javac   -sourcepath %src%  -d %dest% %src%\mypack\DispatcherServlet.java
javac   -sourcepath %src%  -d %dest% %src%\mypack\LoginCheckerServlet.java
