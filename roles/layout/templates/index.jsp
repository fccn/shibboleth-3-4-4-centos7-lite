<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
	<head>
        <title>Fornecedor de Identidade FCT|FCCN</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<link rel="stylesheet"  href="<%= request.getContextPath()%>/FCCN/css/styles.css" type="text/css" media="screen">
		<link rel="stylesheet"  href="<%= request.getContextPath()%>/FCCN/css/bootstrap.css" type="text/css" >
	</head>
	<body>
	<div class="content-middle">
		<div class="container_idx">
		<div class="logo_header">
			<header>
				<a href="<spring:message code="idp.logo.target.url" />" </a>				
				<img class="img-responsive" src="<%= request.getContextPath() %><spring:message code="idp.logo" />" alt="<spring:message code="idp.logo.alt-text" text="Replace or remove this logo" />" ></a>
				<br><br>
			</header>
		</div>
		<div class="alert alert-info">
			<spring:message code="root.message" text="No services are available at this location." />
			<br> 
		</div>
		<div class="footer_head">
			<div class="footer_help"><a href="{{ link_suporte }}" target="_blank">Suporte</a></div>
			<div class="footer_security"><a href="{{ link_seguranca }}" >Seguran&ccedil;a</a></div>
			<div class="footer_rctsaai"><a href="{{ link_rctsaai }}" target="_blank"><img src="https://wayf.fccn.pt/FCCNds/images/rctsaai.png" alt="RCTSaai"></a></div>
		</div>
	</body>
</html>