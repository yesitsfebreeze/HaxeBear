package engine.util;

class TypeHelper {
	static public function getFullClassNameFromInstance(instance:Dynamic):String {
		return Type.getClassName(Type.getClass(instance));
	}

	static public function getClassNameFromInstance(instance:Dynamic):String {
		var className:String = TypeHelper.getFullClassNameFromInstance(instance);
		var split:Array<String> = className.split('.');

		return split.pop();
	}
}
