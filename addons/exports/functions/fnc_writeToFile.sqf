switch (typeName _this) do {
	case "STRING" : {
		_this = _this + "|" + (missionNamespace getVariable ["__temp", ""]);
		missionNamespace setVariable ["__temp", nil];
		"make_file" callExtension _this;
	};
	case "TEXT" : {
		missionNamespace setVariable [
			"__temp",
			(missionNamespace getVariable ["__temp", ""]) + str _this + "\n"
		];
	};
};