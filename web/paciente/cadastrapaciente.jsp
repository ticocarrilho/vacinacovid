<%-- 
    Document   : cadastrapaciente
    Created on : Mar 4, 2021, 1:21:30 PM
    Author     : Arcantus
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="br.recife.edu.ifpe.model.repositorios.*"%>
<%@page import="br.recife.edu.ifpe.model.classes.*"%>
<%@page import="java.util.List"%>
<%@taglib prefix="ifpe" uri="br.recife.edu.ifpe.customtags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <c:if test="${param.redirect == null}">
            <ifpe:carregagrupos />
            <ifpe:carregaenfermeiros />
            <ifpe:carregavacinas />
        </c:if>
        <form method="post" id="formulario" action="PacienteServlet">
            <div class="modal-body">
                <div class="form-group row">
                    <label for="nome" class="col-2 col-form-label">Nome</label>
                    <div class="col-10">
                        <input class="form-control" type="text" name="nome" required id="nome" value="${(param.redirect != null && param["redirect"] eq 'editar') ? paciente.nome : ''}"/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="dataNascimento" class="col-2 col-form-label">Data Nascimento</label>
                    <div class="col-10">
                        <input class="form-control" name="dataNascimento" type="date" required id="dataNascimento"/>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="caracteristicas" class="col-3 col-form-label">Caracteristicas</label>
                    <div class="col-9">
                        <textarea class="form-control" type="text" name="caracteristicas" required id="caracteristicas">${(param.redirect != null && param["redirect"] eq 'editar') ? paciente.caracteristicasIndividuais : ''}</textarea>
                    </div>
                </div>
                <c:if test="${param.redirect == null}">
                    <div class="form-group row">
                        <label for="grupo" class="col-2 col-form-label">Grupo</label>
                        <select class="form-control col-9" name="grupo" id="grupo" required>
                            <c:choose>
                                <c:when test="${grupos.size() != 0}">
                                    <c:forEach var="g" items="${grupos}">
                                        <option value="${g.id}">${g.denominacao}</option>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <option disabled selected value hidden>Nao tem grupo cadastrado.</option>
                                </c:otherwise>
                            </c:choose>
                        </select>
                    </div>
                    <div class="form-group row">
                        <label for="aplicador" class="col-2 col-form-label">Aplicador</label>
                        <select class="form-control col-9" name="aplicador" id="aplicador" required>
                            <c:choose>
                                <c:when test="${enfermeiros.size() != 0}">
                                    <c:forEach var="e" items="${enfermeiros}">
                                        <option value="${e.id}">${e.nome}</option>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <option disabled selected value hidden>Nao tem enfermeiro cadastrado.</option>
                                </c:otherwise>
                            </c:choose>
                        </select>
                    </div>
                    <div class="form-group row">
                        <label for="vacina" class="col-2 col-form-label">Vacina</label>
                        <select class="form-control col-9" name="vacina" id="vacina" required>
                            <c:choose>
                                <c:when test="${vacinas.size() != 0}">
                                    <c:forEach var="v" items="${vacinas}">
                                        <option value="${v.id}">${v.nome}</option>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <option disabled selected value hidden>Nao tem vacina cadastrada.</option>
                                </c:otherwise>
                            </c:choose>
                        </select>
                    </div>
                    <div class="form-group row">
                        <label for="descricaoVacina" class="col-2 col-form-label">Descricao Vacina</label>
                        <div class="col-10">
                            <textarea class="form-control" type="text" name="descricaoVacina" required id="descricaoVacina"></textarea>
                        </div>
                    </div>
                </c:if>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                <button type="button" value="cadastrar" class="btn btn-primary" onclick="showConfirmationDialog()">Cadastrar Paciente</button>
            </div>
        </form>

        <div class="modal fade" id="confirmacaoModal" tabindex="-1" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        Confirmação
                    </div>
                    <div class="modal-body">
                        Tem certeza que os dados estão corretos?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-primary" onclick="submitForm()">Sim</button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function showConfirmationDialog() {
                $('#confirmacaoModal').modal('show');
            }

            function submitForm() {
                document.getElementById("formulario").submit();
            }
        </script>
    </body>
</html>
