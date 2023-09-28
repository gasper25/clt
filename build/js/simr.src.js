
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"numer","title":"No. of pairs (2-5000)","type":"Integer","min":2,"max":5000,"default":50},{"name":"korel","title":"Correlation [-1,1]","type":"Number","min":-1,"max":1,"default":0.7}];

const view = function() {
    
    this.handlers = { }

    View.extend({
        jus: "3.0",

        events: [

	]

    }).call(this);
}

view.layout = ui.extend({

    label: "Correlation",
    jus: "3.0",
    type: "root",
    stage: 0, //0 - release, 1 - development, 2 - proposed
    controls: [
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "small",
			fitToGrid: true,
			controls: [
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					name: "numer",
					format: FormatDef.number
				},
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					name: "korel",
					format: FormatDef.number
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
