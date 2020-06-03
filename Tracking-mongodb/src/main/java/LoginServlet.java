
import static com.mongodb.client.model.Filters.and;
import static com.mongodb.client.model.Filters.eq;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.bson.Document;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;

public class LoginServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();

		if (session.getAttribute("full_name") == null)
			this.getServletContext().getRequestDispatcher("/View/login.jsp").forward(request, response);
		else
			this.getServletContext().getRequestDispatcher("/View/home.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String email = request.getParameter("email");
		String password = request.getParameter("pass");

		// MongoDB URI
		Logger.getLogger("org.mongodb.driver").setLevel(Level.WARNING);
		String uri = "mongodb://admin:walid@tracking-shard-00-00-mwydz.mongodb.net:27017,"
				+ "tracking-shard-00-01-mwydz.mongodb.net:27017,"
				+ "tracking-shard-00-02-mwydz.mongodb.net:27017/test?ssl=true&replicaSet=Tracking-shard-0"
				+ "&authSource=admin&retryWrites=true&w=majority";

		try {

			// connection to database
			MongoClient mongoClient = MongoClients.create(uri);

			// get collection
			MongoCollection<Document> database_collection = mongoClient.getDatabase("Tracking").getCollection("users");

			// get email if exist
			List<Document> userList = database_collection.find(and(eq("email", email), eq("password", password)))
					.into(new ArrayList<Document>());

			// verification
			if (userList.isEmpty()) {
				
				request.setAttribute("loginError", "fail");
				this.getServletContext().getRequestDispatcher("/View/login.jsp").forward(request, response);

			}else {
				
				for (Document users : userList) {
					
					
					HttpSession session = request.getSession();
					session.setAttribute("full_name", users.getString("full_name"));
					session.setAttribute("user_id", users.getString("user_id"));
					response.sendRedirect("/home");	
				}
			}

		} catch (Exception e) {
			// TODO: handle exception
		}

		

	}

}
