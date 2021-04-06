/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.recife.edu.ifpe.controller;

import br.recife.edu.ifpe.model.classes.Aplicacao;
import br.recife.edu.ifpe.model.classes.Grupo;
import br.recife.edu.ifpe.model.classes.*;
import br.recife.edu.ifpe.model.repositorios.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.time.ZoneId;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Arcantus
 */
@WebServlet(name = "PacienteServlet", urlPatterns = {"/PacienteServlet"})
public class PacienteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String codStr = request.getParameter("codigo");
        String redirect = request.getParameter("redirect");
        if (codStr != null || redirect != null) {
            int codigo = Integer.parseInt(codStr);
            Paciente f = RepositorioPaciente.getCurrentInstance().read(codigo);
            request.setAttribute("paciente", f);
        }
        getServletContext().getRequestDispatcher("/paciente/paciente.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String nome = request.getParameter("nome");
            String dataNascimento = request.getParameter("dataNascimento");
            String caracteristicasIndividuais = request.getParameter("caracteristicas");
            String descricaoVacina = request.getParameter("descricaoVacina");

            String aplicar = request.getParameter("aplicar");
            int vacinaId = Integer.parseInt(request.getParameter("vacina"));
            Vacina vacina = RepositorioVacina.getCurrentInstance().read(vacinaId);
            HttpSession session = request.getSession();

            if (vacina.getQuantidadeAplicacoes() <= 0) {
                session.setAttribute("msg", "Nao tem doses da " + vacina.getNome() + " disponiveis.");
            } else {
                int enfermeiroId = Integer.parseInt(request.getParameter("aplicador"));
                ProfissionalEnfermagem enfermeiro = RepositorioProfissionalEnfermagem.getCurrentInstance().read(enfermeiroId);

                Aplicacao aplicacao = new Aplicacao();
                aplicacao.setVacina(vacina);
                aplicacao.setAplicador(enfermeiro);
                aplicacao.setData(new Date());
                aplicacao.setDescricao(descricaoVacina);

                if (aplicar != null) {
                    vacina.setQuantidadeAplicacoes(vacina.getQuantidadeAplicacoes() - 1);
                    RepositorioVacina.getCurrentInstance().update(vacina);
                    int codigo = Integer.parseInt(request.getParameter("codigo"));
                    Paciente up = RepositorioPaciente.getCurrentInstance().read(codigo);
                    up.add(aplicacao);
                    RepositorioPaciente.getCurrentInstance().update(up);
                    session.setAttribute("msg", "Dose aplicada ao Paciente " + up.getNome() + " com sucesso.");
                } else {
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-mm-dd", Locale.US);
                    formatter.setTimeZone(TimeZone.getTimeZone("America/Recife"));
                    Date dataObj = formatter.parse(dataNascimento);

                    LocalDate nascimento = dataObj.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

                    Period idade = Period.between(nascimento, LocalDate.now());
                    formatter.setTimeZone(TimeZone.getTimeZone("America/Recife"));

                    int grupoId = Integer.parseInt(request.getParameter("grupo"));
                    Grupo grupo = RepositorioGrupo.getCurrentInstance().read(grupoId);
                    if (aplicar == null && (idade.getYears() <= grupo.getIdadeMinima() || idade.getYears() >= grupo.getIdadeMaxima())) {
                        session.setAttribute("msg", "Paciente " + nome + " nao esta no grupo de risco.");
                        response.sendRedirect("PacienteServlet");
                        return;
                    }
                    vacina.setQuantidadeAplicacoes(vacina.getQuantidadeAplicacoes() - 1);
                    RepositorioVacina.getCurrentInstance().update(vacina);
                    Paciente f = new Paciente();
                    f.setNome(nome);
                    f.setDataNascimento(dataObj);
                    f.setCaracteristicasIndividuais(caracteristicasIndividuais);
                    f.setGrupo(grupo);
                    f.getAplicacoes().add(aplicacao);
                    RepositorioPaciente.getCurrentInstance().insert(f);
                    session.setAttribute("msg", "Paciente " + f.getNome() + " criado com sucesso.");
                }
            }
            response.sendRedirect("PacienteServlet");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
