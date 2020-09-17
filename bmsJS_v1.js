var name = "외부 라이브러리(bmsJS.js)";
document.write("<h1>"+name+" import 완료</h1><br>");


// 자바스크립트(javascript) 함수 정의
function test_1() {
	document.write("test_1() 함수 출력<br>");
	alert("알림창");		// 팝업 알림창 띄우기
	console.log("로그 출력");	// 웹킷 브라우저의 인스펙터 창의 콘솔 영역에 로그 출력
}


function linePrint(funName){
	document.write('<b>----------------------------------------------------</b><br>');
	document.write("<b>"+funName+"() 함수 테스트</b><br>");
}


// 자바스크립트(javascript) 다양한 변수 선언 방법
function variable_1(){
	linePrint('variable_1');

	var age = 30;	
	var name = "ddandongne";
	var Name = "ddandongne";	// 변수명 대소문자 구분함
	var name1 = "wow", age1 = 40;

	// 변하지 않는 환경 변수의 값을 담는 상수 변수는 대문자로
    var DB_NAME = "webdongne";	

    // 여러 단어가 조합되는 경우 낙타표기법(camelcase)으로 작성
    var userName = "ddandongne";
    var selectMenuIndex = 1;

    var login = true;	// 논리 데이터

    // null 값으로 데이터를 초기화하는 경우
    var data1 = 0;		// 숫자 변수 초기화
    var data2 = "";		// 문자 변수 초기화
    var data3 = false;	// 불린 변수 초기화
    var data4 = null;	// 객체 변수 초기화

	// 출력시 +랑, 결과는 차이가 없음
	document.write(age + "살 " + name, "입니다. <br>");
    document.write(age1, "살 ", name1, "입니다. <br>");	
}


// 자바스크립트 배열(array) 선언 및 사용방법
function array_1(){
	linePrint('array_1');
	var userName = ["ddandongne", "철수", "영희", "아영", "정희", "선희", "영자", "병철"];

    document.write("userName[0] = " + userName[0], "<br>");
    document.write("userName[1] = " + userName[1], "<br>");

    // 자바스크립트 for 반복문 사용하여 배열 출력
    for(var i=0;i<userName.length;i++)
		document.write("userName["+i+"] = "+userName[i],"<br>");
}


