<%-- 
    Document   : visualizapaciente
    Created on : Mar 4, 2021, 1:21:39 PM
    Author     : Arcantus
--%>



<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="br.recife.edu.ifpe.model.classes.*"%>
<%@page import="br.recife.edu.ifpe.model.repositorios.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Paciente paciente = (Paciente) request.getAttribute("paciente");
            if (paciente != null) {
                request.setAttribute("aplicacoes", paciente.getAplicacoes());
                request.setAttribute("grupoPaciente", paciente.getGrupo());
                SimpleDateFormat dataNasc = new SimpleDateFormat("dd/MM/yyyy");
        %>
        <div class="modal-body">

            <table class="table">
                <tr>
                    <th>Codigo</th>
                    <td>${paciente.id}</td>
                </tr>
                <tr>
                    <th>Nome</th>
                    <td>${paciente.nome}</td>
                </tr>
                <tr>
                    <th>Data Nascimento</th>
                    <td><%= dataNasc.format(paciente.getDataNascimento())%></td>
                </tr>
                <tr>
                    <th>Caracteristicas</th>
                    <td>${paciente.caracteristicasIndividuais}</td>
                </tr>
                <tr>
                    <th>Grupo</th>
                    <td>${grupoPaciente.denominacao}</td>
                </tr>
                <tr>
                    <th>Doses</th>
                    <td>
                        <c:forEach var="ap" items="${aplicacoes}">
                            <c:set var="v" value="${ap.vacina}"/>
                            <c:set var="e" value="${ap.aplicador}"/>
                            <a href="VacinaServlet?codigo=${v.id}&redirect=visualiza">${v.nome} aplicada por ${e.nome}<br/></a>
                            </c:forEach>
                    </td>
                </tr>
            </table>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
        </div>
        <%
            }
        %>
    </body>
</html>
