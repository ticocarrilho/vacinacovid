<%-- 
    Document   : paciente
    Created on : Mar 4, 2021, 1:21:22 PM
    Author     : Arcantus
--%>

<%@page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="br.recife.edu.ifpe.model.repositorios.RepositorioPaciente"%>
<%@page import="br.recife.edu.ifpe.model.classes.Paciente"%>
<%@page import="java.util.List"%>
<%@taglib prefix="ifpe" uri="br.recife.edu.ifpe.customtags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pacientes</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js" integrity="sha384-LtrjvnR4Twt/qOuYxE721u19sVFLVSA4hf/rRt6PrZTmiPltdZcI7q7PXQBYTKyf" crossorigin="anonymous"></script>
    </head>
    <body>
        <div class="container">
            <a href="index.html">Página Inicial</a>
            <h1>Pacientes Cadastrados</h1>
            <h4><c:out value="${msg}"/></h4>
            <c:remove var="msg" scope="session"/>
            <ifpe:carregapacientes/>
            <table class="table">
                <tr>
                    <th>Codigo</th>
                    <th>Nome</th>
                    <th>Data Nascimento</th>
                    <th>Caracteristicas Individuais</th>
                    <th>Grupo</th>
                    <th>Aplicacoes</th>
                    <th>Ações</th>
                </tr>
                <c:forEach var="p" items="${pacientes}">
                    <tr>
                        <td>${p.id}</td>
                        <td>${p.nome}</td>
                        <td>${p.dataNascimento}</td>
                        <td>${p.caracteristicasIndividuais}</td>
                        <td>${p.grupo.denominacao}</td>
                        <td>${p.aplicacoes.size()}</td>
                        <td>
                            <div class="dropdown">
                                <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown">
                                </button>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="PacienteServlet?codigo=${p.id}&redirect=visualiza">Visualizar</a>
                                    <a class="dropdown-item" href="PacienteServlet?codigo=${p.id}&redirect=editar">Editar</a>
                                    <a class="dropdown-item" href="PacienteServlet?codigo=${p.id}&redirect=aplicar">Vacinar</a>
                                </div>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#cadastroModal">
                Cadastrar Paciente
            </button>
            <div class="modal fade" id="cadastroModal" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">${(param.redirect != null && param["redirect"] eq 'edita') ? 'Edição' : 'Cadastro'} de Paciente</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <jsp:include page="cadastrapaciente.jsp" />

                    </div>
                </div>
            </div>
            <div class="modal fade" id="pacienteModal" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Paciente</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <jsp:include page="visualizapaciente.jsp" />
                    </div>
                </div>
            </div>
            <div class="modal fade" id="doseModal" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Vacinar Paciente</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <jsp:include page="aplicardose.jsp" />
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script>
        var pacienteModal = document.getElementById("pacienteModal");
        $("#cadastroModal").on("hide.bs.modal", function () {
            window.location.href = 'PacienteServlet'
        });
        <%            String redirect = request.getParameter("redirect");
            if (redirect != null) {
                if (redirect.equals("visualiza")) {
        %>
        $('#pacienteModal').modal('show');
        <%
        } else if (redirect.equals("editar")) {
        %>
        $("#cadastroModal").modal('show');
        <%
        } else if (redirect.equals("aplicar")) {
        %>

        $('#doseModal').modal('show');

        <%
                }
            }
        %>
    </script>
</html>
