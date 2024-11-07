<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String num = request.getParameter("upNum");
String price = request.getParameter("upPrice");
// out.print("<p>upNum : " + num + "</p>");
// out.print("<p>upPrice: " + price + "</p>");

Connection conn = null;
PreparedStatement pstmt = null;

if (num == null || price == null) {
	out.print("<p>업데이트 데이터가 전송되지 않았습니다.</p>");
} else if (!num.isEmpty() && !price.isEmpty()) {
	try {
		// DB 연결
		Class.forName("com.mysql.cj.jdbc.Driver");

		String url = "jdbc:mysql://localhost:3306/sampleData?useSSL=false&useUnicode=true&characterEncoding=UTF8&serverTimezone=UTC&allowPublicKeyRetrieval=true";
		String uid = "root";
		String pwd = "1234";

		conn = DriverManager.getConnection(url, uid, pwd);

		// SQL 업데이트 쿼리
		String sql = "UPDATE goodsList SET price=? WHERE num=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(price));
		pstmt.setInt(2, Integer.parseInt(num));

		// 업데이트 실행
		int result = pstmt.executeUpdate();
		if (result > 0) {
	// 성공 시 목록 페이지로 리다이렉트
	response.sendRedirect("list.jsp");
		} else {
	out.print("<p>상품 업데이트에 실패했습니다. 상품 번호를 확인하세요.</p>");
		}

	} catch (ClassNotFoundException e) {
		out.print("<p>DB 드라이버 로드 실패: " + e.getMessage() + "</p>");
	} catch (SQLException e) {
		out.print("<p>SQL 오류: " + e.getMessage() + "</p>");
	} catch (NumberFormatException e) {
		out.print("<p>잘못된 숫자 형식입니다. 상품 번호와 가격을 올바르게 입력하세요.</p>");
	} finally {
		if (pstmt != null)
	try {
		pstmt.close();
	} catch (SQLException e) {
	}
		if (conn != null)
	try {
		conn.close();
	} catch (SQLException e) {
	}
	}
} else {
	out.print("<p>상품 가격과 번호를 모두 입력하세요.</p>");
}
%>

<script src="/script/jquery-3.7.1.min.js"></script>
<script src="/script/script.js"></script>
</body>
</html>
