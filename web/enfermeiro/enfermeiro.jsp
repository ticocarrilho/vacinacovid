<%-- 
    Document   : enfermeiro
    Created on : Mar 4, 2021, 12:56:19 PM
    Author     : Arcantus
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="br.recife.edu.ifpe.model.repositorios.RepositorioProfissionalEnfermagem"%>
<%@page import="br.recife.edu.ifpe.model.classes.ProfissionalEnfermagem"%>
<%@page import="java.util.List"%>
<%@taglib prefix="ifpe" uri="br.recife.edu.ifpe.customtags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Enfermeiros</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js" integrity="sha384-LtrjvnR4Twt/qOuYxE721u19sVFLVSA4hf/rRt6PrZTmiPltdZcI7q7PXQBYTKyf" crossorigin="anonymous"></script>    </head>
</head>
<body>
    <div class="container">
        <a href="index.html">Página Inicial</a>
        <h1>Enfermeiros Cadastrados</h1>
        <h4><c:out value="${msg}"/></h4>
        <c:remove var="msg" scope="session"/> 
        <ifpe:carregaenfermeiros />
        <table class="table">
            <tr>
                <th>Codigo</th>
                <th>Nome</th>
                <th>Coren</th>
                <th>Ano Formacao</th>
                <th>Contato</th>
                <th>Ações</th>
            </tr>
            <c:forEach var="p" items="${enfermeiros}">
                <tr>
                    <td>${p.id}</td>
                    <td>${p.nome}</td>
                    <td>${p.coren}</td>
                    <td>${p.anoFormacao}</td>
                    <td>${p.contato}</td>

                    <td>
                        <div class="dropdown">
                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown">
                            </button>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="EnfermeiroServlet?codigo=${p.id}&redirect=visualiza">Visualizar</a>
                                <a class="dropdown-item" href="EnfermeiroServlet?codigo=${p.id}&redirect=edita">Editar</a>
                                <a class="dropdown-item" href="EnfermeiroServlet" onclick="deleteEnfermeiro(${p.id})">Deletar</a>
                            </div>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#cadastroModal">
            Cadastrar Enfermeiros
        </button>
        <div class="modal fade" id="cadastroModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">${(param.redirect != null && param["redirect"] eq 'edita') ? 'Edição' : 'Cadastro'} de Enfermeiro</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <jsp:include page="cadastrarenfermeiro.jsp" />
                </div>
            </div>
        </div>
        <div class="modal fade" id="enfermeiroModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Enfermeiro</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <jsp:include page="visualizarenfermeiro.jsp" />
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    var enfermeiroModal = document.getElementById("enfermeiroModal");
    $("#cadastroModal").on("hide.bs.modal", function () {
        window.location.href = 'EnfermeiroServlet'
    });
    <%            String redirect = request.getParameter("redirect");
        if (redirect != null) {
            if (redirect.equals("visualiza")) {
    %>
    $('#enfermeiroModal').modal('show');
    <%
    } else if (redirect.equals("edita")) {
    %>

    $('#cadastroModal').modal('show');

    <%
            }
        }
    %>

    function deleteEnfermeiro(id) {
        fetch("EnfermeiroServlet?id=" + id, {method: 'delete'}).then((res) => {
            console.log(res)
            location.reload()
        });
    }
</script>
</html>
