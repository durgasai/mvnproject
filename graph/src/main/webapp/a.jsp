<%@page contentType="text/html"%>
<%@page import="org.jfree.data.*"%>
<%@page import="java.io.Serializable"%>
<%@page  import="java.io.*"%>
<%@page  import="java.io.Serializable"%>
 
<%@page  import="java.text.NumberFormat"%>
<%@page  import="java.text.SimpleDateFormat"%>
<%@page  import="java.util.ArrayList"%>
<%@page  import="java.util.HashMap"%>
<%@page  import="java.util.Iterator"%>
<%@page  import="java.util.Locale"%>
<%@page  import="java.util.Map"%>
<%@page  import="javax.servlet.http.HttpSession"%>
<%@page  import="org.jfree.chart.ChartRenderingInfo"%>
<%@page  import="org.jfree.chart.ChartUtilities"%>
<%@page  import="org.jfree.chart.JFreeChart"%>
<%@page  import="org.jfree.chart.axis.CategoryAxis"%>
<%@page  import="org.jfree.chart.axis.DateAxis"%>
<%@page  import="org.jfree.chart.axis.NumberAxis"%>
<%@page  import="org.jfree.chart.axis.ValueAxis"%>
<%@page  import="org.jfree.chart.entity.StandardEntityCollection"%>
<%@page  import="org.jfree.chart.labels.StandardCategoryToolTipGenerator"%>
<%@page  import="org.jfree.chart.labels.StandardXYToolTipGenerator"%>
<%@page  import="org.jfree.chart.plot.CategoryPlot"%>
<%@page  import="org.jfree.chart.plot.Plot"%>
<%@page  import="org.jfree.chart.plot.XYPlot"%>
<%@page  import="org.jfree.chart.renderer.category.BarRenderer"%>
<%@page  import="org.jfree.chart.renderer.xy.StandardXYItemRenderer"%>
<%@page  import="org.jfree.chart.servlet.ServletUtilities"%>
<%@page  import="org.jfree.chart.urls.StandardCategoryURLGenerator"%>
<%@page  import="org.jfree.chart.urls.TimeSeriesURLGenerator"%>
<%@page  import="org.jfree.data.category.DefaultCategoryDataset"%>
<%@page  import="org.jfree.data.xy.XYSeries"%>
<%@page  import="org.jfree.data.xy.XYSeriesCollection"%>



<%!

 public static String generateXYChart(String section, HttpSession session ,PrintWriter pw) {
		    String filename = null;
		    try {
 
 System.out.println("2");
		        //  Create and populate an XYSeries Collection
		        XYSeries dataSeries = new XYSeries("Hits");
		        HashMap hmp=new HashMap();
				
				hmp.put("1", "1");
				hmp.put("2", "51");
				hmp.put("3", "71");
		        
		         System.out.println("3");
		        //  Create and populate a CategoryDataset
		        Iterator iter = hmp.keySet().iterator();
		  
		        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		        while (iter.hasNext()) {
		           
		            dataset.addValue(new Long("1"), "Hits",(String)iter.next());
		        }
		        
		         System.out.println("4");
		        
		        XYSeriesCollection xyDataset = new XYSeriesCollection(dataSeries);

		        //  Create tooltip and URL generators
		        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy", Locale.UK);

		        StandardXYToolTipGenerator ttg = new StandardXYToolTipGenerator(
		                StandardXYToolTipGenerator.DEFAULT_TOOL_TIP_FORMAT,
		                sdf, NumberFormat.getInstance());
		        TimeSeriesURLGenerator urlg = new TimeSeriesURLGenerator(
		                sdf, "pie_chart.jsp", "series", "hitDate");
System.out.println("5");
//		      Create the chart object
		        ValueAxis timeAxis = new DateAxis("");
		        NumberAxis valueAxis = new NumberAxis("");
		        valueAxis.setAutoRangeIncludesZero(false);  // override default
		        StandardXYItemRenderer renderer = new StandardXYItemRenderer(
		                StandardXYItemRenderer.LINES + StandardXYItemRenderer.SHAPES,
		                ttg, urlg);

		        renderer.setShapesFilled(true);
		        XYPlot plot = new XYPlot(xyDataset, timeAxis, valueAxis, renderer);
		        JFreeChart chart = new JFreeChart("", JFreeChart.DEFAULT_TITLE_FONT, plot, false);
		        chart.setBackgroundPaint(java.awt.Color.white);
System.out.println("6");
		        //  Write the chart image to the temporary directory
		        ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
		        filename = ServletUtilities.saveChartAsPNG(chart, 500, 300, info, session);

		        //  Write the image map to the PrintWriter
		        ChartUtilities.writeImageMap(pw, filename, info,true);
		        pw.flush();

		    }  catch (Exception e) {
		        System.out.println("Exception - " + e.toString());
		        e.printStackTrace(System.out);
		        filename = "public_error_500x300.png";
		    }
		    System.out.println("filename" +filename);
		    return filename;
		}
		
		
		 public String plot(HttpSession session)
			 {
				 
		//	         
			        HashMap hmp=new HashMap();
					
					hmp.put("1", "1");
					hmp.put("2", "51");
					hmp.put("3", "71");
				    String filename = "";
				    		
					try
					{
			            //  Create and populate a CategoryDataset
				        Iterator iter = hmp.keySet().iterator();
				        String 	key= "";
					    String	value= "";
				        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
				        while (iter.hasNext()) {
				              	key=(String)iter.next();
   					 	value=  (String)     hmp.get(key);
				           
				            dataset.addValue(new Long(value), "Hits", key);
				        }
				        //  Create the chart object
				        CategoryAxis categoryAxis = new CategoryAxis("");
				        ValueAxis valueAxis = new NumberAxis("");
				        BarRenderer renderer = new BarRenderer();
				        renderer.setItemURLGenerator(new StandardCategoryURLGenerator("xy_chart.jsp","series","section"));
				        renderer.setToolTipGenerator(new StandardCategoryToolTipGenerator());
			
				        Plot plot = new CategoryPlot(dataset, categoryAxis, valueAxis, renderer);
				        JFreeChart chart = new JFreeChart("", JFreeChart.DEFAULT_TITLE_FONT, plot, false);
				        chart.setBackgroundPaint(java.awt.Color.white);
				        //  Write the chart image to the temporary directory
				        ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
				        filename = ServletUtilities.saveChartAsPNG(chart, 100, 200, info, session);
		 		        //  Write the image map to the PrintWriter
		 		     FileWriter fw=new FileWriter("c:/temp/"+filename);
				java.io.PrintWriter oPW = new java.io.PrintWriter( fw );
				        ChartUtilities.writeImageMap(oPW, filename, info,true);
				        oPW.flush();
					 
					    }   catch (Exception e) {
					        System.out.println("Exception - " + e.toString());
					        e.printStackTrace(System.out);
					        filename = "public_error_500x300.png";
					    }
					    System.out.println("filename" +filename);
			    return filename;
		
				 
	 }

%>

<%
System.out.println("11");
String filename= plot(session );
//String filename=generateXYChart("",session,new PrintWriter(out));


System.out.println(filename);


        if (filename == null) {
            throw new ServletException("Parameter 'filename' must be supplied");
        }

        //  Replace ".." with ""
        //  This is to prevent access to the rest of the file system
        filename = ServletUtilities.searchReplace(filename, "..", "");
        System.out.println(filename);
	System.out.println(System.getProperty("java.io.tmpdir"));
        //  Check the file exists
        File file = new File(System.getProperty("java.io.tmpdir"), filename);
        System.out.println(file.exists());
        if (!file.exists()) {
        	System.out.println("file.exis");
            throw new ServletException("File '" + file.getAbsolutePath()
                    + "' does not exist");
        }

        //  Check that the graph being served was created by the current user
        //  or that it begins with "public"
        boolean isChartInUserList = true;
       // ChartDeleter chartDeleter = (ChartDeleter) session.getAttribute(
      //          "JFreeChart_Deleter");
      //  if (chartDeleter != null) {
      //      isChartInUserList = chartDeleter.isChartAvailable(filename);
      //  }

        boolean isChartPublic = true;
        if (filename.length() >= 6) {
            if (filename.substring(0, 6).equals("public")) {
                isChartPublic = true;
            }
        }

        boolean isOneTimeChart = true;
        if (filename.startsWith(ServletUtilities.getTempOneTimeFilePrefix())) {
            isOneTimeChart = true;
        }

        if (isChartInUserList || isChartPublic || isOneTimeChart) {
            //  Serve it up
            ServletUtilities.sendTempFile(file, response);
            if (isOneTimeChart) {
                file.delete();
            }
        }

%>