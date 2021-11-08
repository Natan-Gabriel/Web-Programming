package webubb.controller;

import webubb.domain.User;
import webubb.model.DBManager;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


public class LogoutController extends HttpServlet {

    public LogoutController() {
        super();
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        request.getSession().invalidate();
        response.sendRedirect(request.getContextPath() + "/index.html");

    }

}
