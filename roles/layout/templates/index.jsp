<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	    	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
		<title>Fornecedor de Identidade FCT|FCCN</title>
		<meta name="theme-color" content="#fff">
		<link rel="shortcut icon" href="<%= request.getContextPath()%>/FCCN/images/favicon.ico">
		<link rel="stylesheet" href="<%= request.getContextPath()%>/FCCN/css/style.css" type="text/css" />
		<link rel="stylesheet"  href="<%= request.getContextPath()%>/FCCN/css/bootstrap.css" type="text/css" >
		<script type="text/javascript" src="<%= request.getContextPath()%>/FCCN/js/locale.js"></script>
	</head>
	<body>
	
		<div class="logmod">
				<div class="logmod__container">
					<div class="logo_header">
						<div class="lang_container">
						</div>
						<header>
							<a href="<spring:message code='idp.logo.target.url'/>"> <img class="img-responsive" src="<%= request.getContextPath() %><spring:message code='idp.logo'/>" alt="<spring:message code='idp.logo.alt-text'/>"></a>
						</header>
					</div>
					<div id="message">
						<spring:message code='root.message' text='No services are available at this location.' />
					<br>
					</div>							
					<div class="logmod__alter">
							<div class="logmod__alter-container">
								<div class="footer_help"><a href="{{ link_suporte }}" target="_blank">Suporte</a></div>
								<div class="footer_security"><a href="{{ link_seguranca }}" >Seguran&ccedil;a</a></div>
								<div class="footer_rctsaai"><a href="{{ link_rctsaai }}" target="_blank"><img src="https://wayf.fccn.pt/FCCNds/images/rctsaai.png" alt="RCTSaai"></a></div>
							</div>
					</div>
				</div>
		</div>
	</body>
</html>