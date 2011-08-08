package org.gamina.api.logic {
	public class BaseInputCMD {
		
		// known commands enum:
		public static const DOWN : 		String = '_DOWN';
		public static const UP : 		String = '_UP';
		public static const RIGHT : 	String = '_RIGHT';
		public static const LEFT : 		String = '_LEFT';
		public static const ACTION : 	String = '_ACTION';
		
		public static const HOME : 		String = '_HOME';
		public static const BACK :		String = '_BACK';
		// end known commands
	
		public static const OTHER_CHAR : String = '_ OTHER_CHAR';
		
		public var cmdEnum : String;
		public var char : String;

		
		
	}
}