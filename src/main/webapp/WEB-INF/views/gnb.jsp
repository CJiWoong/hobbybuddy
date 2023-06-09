<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<link rel="stylesheet" href="resources/css/css.css">
<style>
	
	#profileIcon{
		display:inline;
		border: none;
	 	border-radius: 5px;
		padding: 0.5rem 1rem;
		cursor: pointer;
		font-size: 1.2rem;
	}
	.panel{
		display: none;
		background-color: #ffffff;
 		color: #22c55e;
		border: none;
	 	border-radius: 5px;
		padding: 0.5rem 1rem;
		cursor: pointer;
		font-size: 1.2rem;
	}
	.panel2{
		display: none;
		background-color: #ffffff;
 		color: #22c55e;
		border: none;
	 	border-radius: 5px;
		padding: 0.5rem 1rem;
		cursor: pointer;
		font-size: 1.2rem;
	}
	.panel3{
		display: none;
		background-color: #ffffff;
 		color: #22c55e;
		border: none;
	 	border-radius: 5px;
		padding: 0.5rem 1rem;
		cursor: pointer;
		font-size: 1.2rem;
	}
	
	#alarmIcon{
		display:inline;
		border: none;
	 	border-radius: 5px;
		padding: 0.5rem 1rem;
		cursor: pointer;
		font-size: 1.2rem;		
	}
	
	.beforeAlarm{
		display: none;	
	}
	.alarmList{
		display: none;
		background-color: #ffffff;
 		color: #22c55e;
		border: none;
	 	border-radius: 5px;
		padding: 0.5rem 1rem;
		cursor: pointer;
		font-size: 1.2rem;	
		position: static;
	}
	
	.menu{
		display:inline;
	}
	.mImg{
		float: none;
		margin: 0;	
	}
	.alarmIcon{
		float: none;
		margin: 0;
	}

	
</style>
<head>
<meta charset="UTF-8">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />
 <title th:text="${pageTitle}">Default Page Title</title>
</head>

<body>	
	<a href="./"><img width="150" src="/photo/HBL.png"/></a>
	<b>${sessionScope.loginId} 님 안녕하세요 ? / 새 알림 : <span id="alarmCount2"> ${sessionScope.alarmCount}</span> 개</b><br/><br/>
	<br/><br/>
	
	<div class="menu">
		<div id="profileIcon"><img width="100" src="/photo/프로필.png" class="mImg"/></div>
		<input type="button" class="panel2" value="로그인" onclick="location.href='login.go'"/>
		<input type="button" class="panel" value="로그아웃" onclick="location.href='logout.go'"/>
		<input type="button" class="panel" value="마이페이지" onclick="location.href='pwChk.go'"/>
		<input type="button" class="panel" value="작성한 글/댓글" onclick="location.href='myBoardList.go'"/>
		<input type="button" class="panel" value="참여한 모임" onclick="location.href='myGroupList.go'"/>
		<input type="button" class="panel" value="쪽지방" onclick="location.href='msgList.go'"/>
		<input type="button" class="panel" value="즐겨찾기" onclick="location.href='bmarklist.go'"/>
		<input type="button" class="panel3" value="관리자" onclick="location.href='admin.go'"/>
	</div>	
	<div id="alarmIcon"><img width="100" src="/photo/알림전.png" class="alarmIcon"/></div>
		<br/><br/>
		<input type="button" value="알림 읽음 처리" class="beforeAlarm" onclick="alarmListRead()"/>
		<input type="button" value="이전 알림 보기" class="beforeAlarm" onclick="location.href='beforeAlarm.go'"/>
		<br/><br id="beforeAlarm"/>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<div class="menu">
		<input type="button" value="취미 모임" onclick="location.href='glist.go'"/>&nbsp;
		<input type="button" value="프로필" onclick="location.href='profile.go'"/>&nbsp;
		<input type="button" value="랜덤 매칭" onclick="location.href='randomList.go'"/>&nbsp;
		<input type="button" value="익명 매칭" onclick="location.href='noNameList.do'"/>&nbsp;
		<input type="button" value="자유 게시판" onclick="location.href='flist.go'"/>&nbsp;
		<input type="button" value="고객센터" onclick="location.href='qboard.go'"/>&nbsp;
		<input type="button" value="공지사항" onclick="location.href='nboard.go'"/>
	</div>
	<br/><br/><br/>

</body>

<script>
	var loginId = "${sessionScope.loginId}";
	var adminChk = "${sessionScope.adminChk}";
	var alarmCount = "${sessionScope.alarmCount}";
	
	$('#profileIcon').on('click',function(){
		if(loginId == ""){
			$('.panel2').slideToggle('slow');
		}else{
			$('.panel').slideToggle('slow');
	   }
		if(adminChk == "1" || adminChk == "true"){
			$('.panel3').slideToggle('slow');
		}		
	})
	
	$('#alarmIcon').on('click',function(){		
		$('.beforeAlarm').slideToggle('slow');
		$('.alarmList').slideToggle('slow');				
	});
	
	if(alarmCount != 0){
		$('#alarmIcon').html('<img width="100" src="/photo/알림후.png" class="alarmIcon"/>');
	}
	
	alarmList();
	function alarmList(){
		console.log("loginId : " + loginId);
		$.ajax({
			type:'get',
			url:'alarmList.ajax',			
			data:{},
			dataType:'json',
			success:function(data){
				console.log("data : " + data.alarmList);
				alarmListDraw(data.alarmList);				
			},
			cache: false,
			error:function(e){
				console.log(e);
			}
		});	
	}	
	
	function alarmListDraw(alarmList) {
		console.log("alarmList : " + alarmList);
		  var content = '';
		  if (alarmList && alarmList.length) {
		    alarmList.forEach(function(item, index) {
		    	console.log("alarmList : " + alarmList);
		      content += '<div class="alarmList">';
		      content += '<input type="checkbox" value="' + item.alarm_no + '"/>&nbsp;&nbsp;&nbsp;&nbsp;';
		      content += '<a href="alarmDetail.do?alarm_num=' + item.alarm_num + '&alarm_class=' + item.alarm_class + '&alarm_no=' + item.alarm_no + '">';
		      content += '('+ item.alarm_class+')&nbsp;&nbsp;<b>ID</b> : \" ' + item.id_send + ' \" &nbsp;&nbsp;&nbsp;<b>제목</b> : \" '
		      			+ item.alarm_title + ' \" &nbsp;&nbsp;&nbsp;<b>내용</b> : \ "' + item.alarm_content;
		      content += ' /" </a></div>';
		      console.log("alarmList : " + alarmList);
		    });
		  } else {
			console.log("alarmList : " + alarmList);
		    content = '<div class="alarmList">새로운 알림이 없습니다.</div>';
		  }
		  
		  // 이전 알림 리스트 요소 삭제
		  $('.alarmList').empty();
		  
		  // 새로운 알림 리스트 요소 생성 및 삽입
		  $(content).insertBefore($('#beforeAlarm').parent().find('#beforeAlarm').next());
		  
		}

	
	// 읽음 처리
	function alarmListRead(){
		var checkArr = [];
		$('input[type="checkbox"]:checked').each(function(idx,item){		
			//checkbox 에 value 를 지정하지 않으면 기본값을 on 으로 스스로 지정한다.
			if($(this).val()!='on'){
				console.log(idx,$(this).val());
				checkArr.push($(this).val());
			}	
		});
		console.log(checkArr);			
		$.ajax({
			type:'post',
			url:'alarmListRead.ajax',
			data:{'alarmListRead':checkArr},
			dataType:'json',
			success:function(data){
				console.log(data);
				if(data.success){
					alert(data.msg);
					alarmList();
					location.reload();
				}
			},
			error:function(e){
				console.log(e);
			}		
		});		
	}


</script>

</html>