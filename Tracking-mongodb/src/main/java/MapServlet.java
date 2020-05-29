import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.bson.Document;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;

public class MapServlet extends HttpServlet {

	String uri = "mongodb://admin:walid@tracking-shard-00-00-mwydz.mongodb.net:27017,"
			+ "tracking-shard-00-01-mwydz.mongodb.net:27017,"
			+ "tracking-shard-00-02-mwydz.mongodb.net:27017/test?ssl=true&replicaSet=Tracking-shard-0"
			+ "&authSource=admin&retryWrites=true&w=majority";
	// connection to database
	MongoClient mongoClient = MongoClients.create(uri);

	//get collection 
	MongoCollection<Document> activity_collection = mongoClient.getDatabase("Tracking").getCollection("Activity");
	



	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		//this.getServletContext().getRequestDispatcher("/View/home.jsp").forward(request, response);
		
		HttpSession session = request.getSession();

		if (session.getAttribute("full_name") == null)
			this.getServletContext().getRequestDispatcher("/View/login.jsp").forward(request, response);
		else
			this.getServletContext().getRequestDispatcher("/View/map.jsp").forward(request, response);
		
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		this.getServletContext().getRequestDispatcher("/View/map.jsp").forward(request, response);
		
	}

}
