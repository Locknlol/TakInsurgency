SL_fnc_urbanAreas = {
	private ["_locations","_cityTypes","_randomLoc","_x","_i","_cities"];
	_i = 0;
	_cities = [];

	_locations = configfile >> "CfgWorlds" >> worldName >> "Names";
	_cityTypes = ["NameVillage","NameCity","NameCityCapital"];

	for "_x" from 0 to (count _locations - 1) do {
		_randomLoc = _locations select _x;
		// get city info
		private["_cityName","_cityPos","_cityRadA","_cityRadB","_cityType","_cityAngle"];
		_cityName = getText(_randomLoc >> "name");
		_cityPos = getArray(_randomLoc >> "position");
		_cityRadA = getNumber(_randomLoc >> "radiusA");
		_cityRadB = getNumber(_randomLoc >> "radiusB");
		_cityType = getText(_randomLoc >> "type");
		_cityAngle = getNumber(_randomLoc >> "angle");
		if (_cityType in _cityTypes) then {
			_cities set [_i,[_cityName, _cityPos, _cityRadA, _cityRadB, _cityType, _cityAngle]];
			_i = _i + 1;
		};
	};
	_cities;
};

SL_fnc_findBuildings = { 
    private ["_center","_radius","_buildings"]; 
    _center = _this select 0; 
    _radius = _this select 1; 
    _cacheHouses = ["Land_House_L_1_EP1","Land_House_L_3_EP1","Land_House_L_4_EP1","Land_House_L_6_EP1","Land_House_L_7_EP1","Land_House_L_8_EP1","Land_House_L_9_EP1","Land_House_K_1_EP1","Land_House_K_3_EP1","Land_House_K_5_EP1","Land_House_K_6_EP1","Land_House_K_7_EP1","Land_House_K_8_EP1","Land_House_C_1_EP1","Land_House_C_1_v2_EP1","Land_House_C_2_EP1","Land_House_C_3_EP1","Land_House_C_4_EP1","Land_House_C_5_EP1","Land_House_C_5_V1_EP1","Land_House_C_5_V2_EP1","Land_House_C_5_V3_EP1","Land_House_C_9_EP1","Land_House_C_10_EP1","Land_House_C_11_EP1","Land_House_C_12_EP1","Land_A_Villa_EP1","Land_A_Mosque_small_1_EP1","Land_A_Mosque_small_2_EP1","Land_Ind_FuelStation_Build_EP1","Land_Ind_FuelStation_Shed_EP1","Land_Ind_Garage01_EP1"]; 
    _buildings = nearestObjects [_center, _cacheHouses, _radius]; 
    _buildings; 
}; 

SL_fnc_buildingPositions = {
	private ["_cbpos"];
	_house = _this select 0;
	_cbpos = 0;
	for "_x" from 1 to 100 do {
		if (format ["%1",(_house buildingPos _x)] != "[0,0,0]") then {
			_cbpos = _cbpos + 1;
		};
	};
	_cbpos;
};

getGridPos = {
    private ["_pos","_x","_y"];

 	_pos = getPosATL _this;
 	_x = _pos select 0;
 	_y = _pos select 1;
 	_x = _x - (_x % 100);
 	_y = _y - (_y % 100);
	[_x + 50, _y + 50, 0]
};

//SL_fnc_createTriggers = {
//	private ["_markers","_pos","_trigE"];
//
//	{
//		_pos = getMarkerPos _x;
//		_trigE = createTrigger ["EmptyDetector", _pos ];
//		_trigE setTriggerActivation ["ANY", "PRESENT", false];
//		_trigE setTriggerArea [50, 50, 0, true];
//		_trigE setTriggerStatements ["{(side _x) == east} count thisList == 0 AND {(side _x) == west } count thisList >= 1", format["""%1"" setMarkerAlpha 0;",_x], ""];
//
//	} foreach _this;
//
//};

SO_fnc_randomCity = {

	private ["_randomLoc", "_cityName", "_cityPos", "_cityRadA", "_cityRadB", "_cityType", "_cityAngle", "_cityTypes","_found"];

	_cityName = "";

	// Stuff we need
	_locations = configfile >> "CfgWorlds" >> worldName >> "Names";
	//_cityTypes = ["Name","NameLocal","NameVillage","NameCity","NameCityCapital"];
	_cityTypes = ["NameVillage","NameCity","NameCityCapital"];
	_found = 0;


	while { _found == 0 } do {

			_randomLoc = _locations call BIS_fnc_selectRandom;

			// get city info
			_cityName = getText(_randomLoc >> "name");
			_cityPos = getArray(_randomLoc >> "position");
			_cityRadA = getNumber(_randomLoc >> "radiusA");
			_cityRadB = getNumber(_randomLoc >> "radiusB");
			_cityType = getText(_randomLoc >> "type");
			_cityAngle = getNumber(_randomLoc >> "angle");

		if (_cityType in _cityTypes) then { _found = 1; };
	};

	[_randomLoc, _cityName, _cityPos, _cityRadA, _cityRadB, _cityType, _cityAngle];
};

SO_fnc_findHouse = {

	private ["_found","_houses","_house","_cpos","_range","_bpos"];

	_cpos = _this select 1;
	_range = _this select 2;

	_houses = nearestObjects [_cpos, ["house"], _range];
	_houses;
};