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
	document.write("<b>"+funName+"() 함수</b><br>");
}


// 자바스크립트(javascript) 다양한 변수 선언 방법
function variable_1(){
	linePrint('variable_1');

	var age = 30;	
	var name = "ddandongne";
	var Name = "ddandongne";	// 변수명 대소문자 구분함
	var name1 = "wow", age1 = 40;

	var str1 = "안녕하세요.";
    var result = str1+"자바스크립트입니다.";	// 문자열 연산 가능

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

	// 배열 생성 및 초기화
	var userName = ["ddandongne", "철수", "영희", "아영", "정희", "선희", "영자", "병철"];

    document.write("userName[0] = " + userName[0], "<br>");
    document.write("userName[1] = " + userName[1], "<br>");

    // 자바스크립트 for 반복문 사용하여 배열 출력
    for(var i=0;i<userName.length;i++)
		document.write("userName["+i+"] = "+userName[i],"<br>");
}


function TypeConversion_1(){
	linePrint('TypeConversion_1');

	var age = window.prompt("나이를 입력해주세요.");	// 팝업 입력창(프롬프트)
    age = parseInt(age)+30;		// 정수 형변환(문자->정수)
    alert("결과 값은? "+age);

    var test = "300.35";
    var result = Number(test) + 10;   // 정수 형변환(300.35 + 10 = 310.35)

    var test = "100.50";
    var result = parseFloat(test)	// 실수 형변환

    var test1 = 15;
    var result = String(test1);	// 문자열 형변환(숫자->문자)

    var test2 = 10;
    var result = test2.toString();		// 문자열 형변환(숫자->문자)
    var result = test2.toString(16);	// 문자열 형변환(결과를 16진수 문자로 보여줌 10=a, 11=b ...)

    var bgColor = 0xF10;
    var bgColor = bgColor.toString(16);
    document.write("bgColor = " + bgColor);


}



function jqueryForCSS_1(){
	// jqeury를 사용하여 페이지 시작시 배경색을 빨간색으로 설정
	$(document).ready(function() {
            var bgColor = 0xF00;
            $("body").css("background-color", "#" + bgColor.toString(16));
    })

	// jqeury를 사용하여 1초마다 배경색 랜덤하게 변경
    $(document).ready(function(){
        setInterval(function(){		// 시간 설정
            var color = Math.random()*0xffffff;     // 0~ffffff 사이의 랜덤 색 만들기 이때 결과는 10진수 실수
            color = parseInt(color);          // 실수를 정수로 형변환
            color = color.toString(16);    // 정수를 16진수 문자로 변경

            $("body").css("background-color", "#"+color);  // 문자로 된 색상으로 최종 배경색 변경
        },1000);
    })
}




