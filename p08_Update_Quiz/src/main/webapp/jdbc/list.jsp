<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>

<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>JDBC 조회</title>
<link rel="stylesheet" href="/style/style.css?v">
</head>
<body>
	<form action="updateProc.jsp">
		<div id="wrap">
			<h1>상품목록</h1>

			<div id="goodsListArea">
				<div id="listHeader" class="listCol dFlex">

					<span>번호</span> <span>상품코드</span> <span>상품명</span> <span>가격</span>
					<span>재고</span> <span>삭제</span>

				</div>
				<!-- div#listHeader, 게시판 목록의 열제목 -->
				<%
				Connection conn = null;
				Statement stmt = null;
				ResultSet rs = null;

				try {
					Class.forName("com.mysql.cj.jdbc.Driver");

					String url = "jdbc:mysql://localhost:3306/sampleData?";
					url += "useSSL=false&";
					url += "useUnicode=true&";
					url += "characterEncoding=UTF8&";
					url += "serverTimezone=UTC&";
					url += "allowPublicKeyRetrieval=true";
					//DB 접속 설정

					String uid = "root";
					String pwd = "1234";

					conn = DriverManager.getConnection(url, uid, pwd);

					stmt = conn.createStatement();
					String sql = "select num, goodsCode, goodsName, price,  cnt ";
					sql += "from goodsList ";
					sql += "order by num desc";
					rs = stmt.executeQuery(sql);

					while (rs.next()) {
				%>
				<div class="listRow listCol dFlex">
					<span><%=rs.getInt("num")%></span> <span><%=rs.getString("goodsCode")%></span>
					<span><%=rs.getString("goodsName")%></span> <span><%=rs.getInt("price")%></span>
					<span><%=rs.getInt("cnt")%></span> <span id="Xbtn">X</span>

				</div>
				<!-- div#"listCol", 게시판 목록의 열제목 -->
				<%
				}
				} catch (ClassNotFoundException e) {
				out.print(e.getMessage());
				} catch (SQLException e) {
				out.print(e.getMessage());
				}
				%>
			</div>
			<!-- div#goodsListArea -->
			<div id="updateArea" class="dFlex">
				<div id="inputA">
					<span>수정할 상품번호</span> <input type="text" name="upNum" id="upNum">

					<span>수정할 상품가격</span> <input type="text" name="upPrice"
						id="upPrice">
				</div>
			</div>
			<div id="btn">
				<button>수정하기</button>
			</div>

		</div>
		<!-- div#wrap -->
	</form>


	<script src="/script/jquery-3.7.1.min.js"></script>
	<script>
		function validateForm() {
			const num = document.getElementById("upNum").value;
			const price = document.getElementById("upPrice").value;

			if (!num || isNaN(num)) {
				alert("상품번호를 적으시오");
				return false;
			}
			if (!price || isNaN(price)) {
				alert("가격을 입력하세요");
				return false;
			}
			return true;
		}

		
	</script>
</body>
</html>
