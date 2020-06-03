import static com.mongodb.client.model.Filters.*;
import static com.mongodb.client.model.Updates.*;
import static java.util.Arrays.*;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.Character.Subset;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileDeleteStrategy;
import org.apache.commons.io.FileUtils;
import org.bson.Document;
import org.bson.types.ObjectId;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.XML;

import com.mongodb.DBObject;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;

@MultipartConfig
public class HomeServlet extends HttpServlet {

	String uri = "mongodb://admin:walid@tracking-shard-00-00-mwydz.mongodb.net:27017,"
			+ "tracking-shard-00-01-mwydz.mongodb.net:27017,"
			+ "tracking-shard-00-02-mwydz.mongodb.net:27017/test?ssl=true&replicaSet=Tracking-shard-0"
			+ "&authSource=admin&retryWrites=true&w=majority";
	// connection to database
	MongoClient mongoClient = MongoClients.create(uri);

	// get collection
	MongoCollection<Document> activity_collection = mongoClient.getDatabase("Tracking").getCollection("Activity");
	
	MongoCollection collection = mongoClient.getDatabase("Tracking").getCollection("Activity");


	MongoCollection<Document> users_collection = mongoClient.getDatabase("Tracking").getCollection("users");

	List<String> json = new ArrayList<String>();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		this.getServletContext().getRequestDispatcher("/View/home.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		File file = null;

		String id = request.getParameter("identifiant");
		String date = request.getParameter("date");
		String time_debut = request.getParameter("heure_debut");
		String time_fin = request.getParameter("heure_fin");
		String sport = request.getParameter("sport_list");
		// File file = getFilePath(request);
		String full_name = null;

		try {
			file = getFilePath(request);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		List<Document> userList = users_collection.find(eq("user_id", id)).into(new ArrayList<Document>());

		for (Document users : userList) {

			full_name = users.getString("full_name");
		}
		
		List<Document> position = new ArrayList<>();
		
		List<JSONObject> pos_list = getPosition(file.getAbsolutePath());
		
		for (JSONObject string : pos_list) {

			position.add(new Document("Latitude", string.getDouble("LatitudeDegrees")).append("Longitude",
					string.getDouble("LongitudeDegrees")));


		}
		
//		System.out.println("\n ----------***************************************------------------- \n");
//		
//		System.out.println("lat 0 : "+pos_list.get(0).get("LatitudeDegrees")+", lon 0 : "+pos_list.get(0).get("LongitudeDegrees"));
//		
//		System.out.println("lat last : "+pos_list.get(pos_list.size() - 1).get("LatitudeDegrees")+", lon last : "+pos_list.get(pos_list.size() - 1).get("LongitudeDegrees"));
//		
		double lat1 = (double) pos_list.get(0).get("LatitudeDegrees");
		double long1 = (double) pos_list.get(0).get("LongitudeDegrees");
		
		double lat2 = (double) pos_list.get(pos_list.size() - 1).get("LatitudeDegrees");
		double long2 = (double) pos_list.get(pos_list.size() - 1).get("LongitudeDegrees");
		
	    int dist = (int) distance(lat1, long1, lat2, long2,"K");
	    
//	    System.out.println("\ndistance = "+dist);
//
//		
//		System.out.println("\n ----------***************************************------------------- \n");
		
//	    NumberFormat nf = NumberFormat.getInstance();
//        nf.setMaximumFractionDigits(3);
        
	    
		// create Document
		Document activity = new Document("_id", new ObjectId());
		activity.append("user_id", id).append("full_name", full_name).append("date", date)
				.append("time_debut", time_debut).append("time_fin", time_fin).append("sport", sport)
				.append("position", position).append("distance", dist);

		activity_collection.insertOne(activity);

		System.out.println("***** : done!");

		// get email if exist
		String pos = null;
		

		Document doc = new Document();
		doc.append("full_name", full_name)
		   .append("user_id", id)
		   .append("date", date)
		   .append("time_debut", time_debut)
		   .append("time_fin", time_fin)
		   .append("sport", sport);
		
		String s =    activity_collection.find(doc).first().get("position").toString();
		
		System.out.println(s);
		
		

		HttpSession session = request.getSession();
		session.setAttribute("full_name", full_name);
		session.setAttribute("user_id", id);
		session.setAttribute("position", pos_list.toString());
		response.sendRedirect("/map");

		System.out.println(file.delete());

	}

	protected File getFilePath(HttpServletRequest request) throws Exception {

		String file_path = null;
		File uploadedFile = null;

		Part filePart = request.getPart("file"); // Retrieves <input type="file" name="file">
		String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
		InputStream fileContent = filePart.getInputStream();

		byte[] buffer = new byte[fileContent.available()];
		fileContent.read(buffer);

		String root = getServletContext().getRealPath("/");
		File path = new File(root + "/uploads");

		if (!path.exists()) {
			boolean status = path.mkdirs();
		}
		uploadedFile = new File(path + "/" + fileName);

		OutputStream outStream = new FileOutputStream(uploadedFile);
		outStream.write(buffer);

		fileContent.close();
		outStream.close();

		return uploadedFile;

	}

	protected List<JSONObject> getPosition(String file) throws IOException {

		Logger.getLogger("org.mongodb.driver").setLevel(Level.WARNING);

		List<Document> position = new ArrayList<>();
		JSONObject pos = new JSONObject();

		File xmlfile = new File(file);
		byte[] b = Files.readAllBytes(xmlfile.toPath());

		String xml = new String(b);

		JSONObject xmlJSONObj = XML.toJSONObject(xml);

		String jsonPrettyPrintString = xmlJSONObj.toString();

		System.out.println(jsonPrettyPrintString);

		JSONArray obj = xmlJSONObj.getJSONObject("TrainingCenterDatabase").getJSONObject("Courses")
				.getJSONObject("Course").getJSONObject("Track").getJSONArray("Trackpoint");

		List<JSONObject> listdata = new ArrayList<JSONObject>();

		for (int i = 0; i < obj.length(); i++) {
			listdata.add(obj.getJSONObject(i).getJSONObject("Position"));
		}
		
		
		for (JSONObject string : listdata) {
			

			position.add(new Document("Latitude", string.getDouble("LatitudeDegrees")).append("Longitude",
					string.getDouble("LongitudeDegrees")));

//			System.out.println("LatitudeDegrees : " + string.getDouble("LatitudeDegrees") + " LongitudeDegrees :"
//					+ string.getDouble("LongitudeDegrees"));

		}

		return listdata;

	}
	
	private static double distance(double lat1, double lon1, double lat2, double lon2, String unit) {
		if ((lat1 == lat2) && (lon1 == lon2)) {
			return 0;
		}
		else {
			double theta = lon1 - lon2;
			double dist = Math.sin(Math.toRadians(lat1)) * Math.sin(Math.toRadians(lat2)) + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) * Math.cos(Math.toRadians(theta));
			dist = Math.acos(dist);
			dist = Math.toDegrees(dist);
			dist = dist * 60 * 1.1515;
			if (unit.equals("K")) {
				dist = dist * 1.609344;
			} else if (unit.equals("N")) {
				dist = dist * 0.8684;
			}
			return (dist);
		}

}
	
}
