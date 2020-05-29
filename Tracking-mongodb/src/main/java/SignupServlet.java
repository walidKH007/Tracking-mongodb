import static com.mongodb.client.model.Filters.eq;
import static java.util.Arrays.asList;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.bson.Document;
import org.bson.types.ObjectId;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;

public class SignupServlet extends HttpServlet {

	// private Connection connection;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.getServletContext().getRequestDispatcher("/View/signup.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		// parameter POST request
		String full_name = request.getParameter("full_name");
		String email = request.getParameter("email");
		String password = request.getParameter("pass");
		String repeate_password = request.getParameter("rep_pass");

		// MongoDB URI
		Logger.getLogger("org.mongodb.driver").setLevel(Level.WARNING);
		String uri = "mongodb://admin:walid@tracking-shard-00-00-mwydz.mongodb.net:27017,"
				+ "tracking-shard-00-01-mwydz.mongodb.net:27017,"
				+ "tracking-shard-00-02-mwydz.mongodb.net:27017/test?ssl=true&replicaSet=Tracking-shard-0"
				+ "&authSource=admin&retryWrites=true&w=majority";

		try {
			
			// connection to database
			MongoClient mongoClient = MongoClients.create(uri);

			//get collection 
			MongoCollection<Document> database_collection = mongoClient.getDatabase("Tracking").getCollection("users");

			
			// create Document
			String uniqueID = UUID.randomUUID().toString();
			Document user = new Document("_id", new ObjectId());
			user.append("user_id", uniqueID)
				.append("full_name", full_name)
				.append("email", email)
				.append("password",password);

			// get email if exist 
			List<Document> userList = database_collection.find(eq("email", email)).into(new ArrayList<Document>());

			// verification 
			if (userList.isEmpty()) {

				// verification of password
				if (password.equals(repeate_password)) {

					// insert data
					database_collection.insertOne(user);
					System.out.println("done !");

					// create session and redirect to Home page
					HttpSession session = request.getSession();
					session.setAttribute("full_name", full_name);
					session.setAttribute("user_id", uniqueID);
					response.sendRedirect("/home");

				} else {

					// password not match
					request.setAttribute("pass_no_match", "fail");
					this.getServletContext().getRequestDispatcher("/View/signup.jsp").forward(request, response);

				}

			} else {

				// email already exist
				request.setAttribute("emailError", "fail");
				this.getServletContext().getRequestDispatcher("/View/signup.jsp").forward(request, response);

			}

		} catch (Exception e) {
			// TODO: handle exception
			e.getMessage();
			System.out.println(e.getMessage());
		}

	}

}
