
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"trial","title":"No. of trials (1-50000)","type":"Integer","min":1,"max":50000,"default":1000},{"name":"coins","title":"No. of coins (n)","type":"List","options":[{"title":"n=3","name":"n=3"},{"title":"n=5","name":"n=5"},{"title":"n=10","name":"n=10"},{"title":"n=20","name":"n=20"},{"title":"n=50","name":"n=50"},{"title":"n=100","name":"n=100"},{"title":"n=200","name":"n=200"}],"default":"n=20"},{"name":"prob","title":"Prob. of success (p)","type":"Number","min":0.01,"max":0.999,"default":0.5}];

const view = function() {
    
    this.handlers = { }

    View.extend({
        jus: "3.0",

        events: [

	]

    }).call(this);
}

view.layout = ui.extend({

    label: "Tossing Coin",
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
					name: "trial",
					format: FormatDef.number
				},
				{
					type: DefaultControls.ComboBox,
					typeName: 'ComboBox',
					name: "coins"
				},
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					name: "prob",
					format: FormatDef.number
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
