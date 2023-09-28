
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"dist","title":"Source distribution","type":"List","options":[{"title":"normal","name":"normal"},{"title":"uniform","name":"uniform"},{"title":"geometric","name":"geometric"},{"title":"lognormal","name":"lognormal"},{"title":"binomial","name":"binomial"}],"default":"normal"},{"name":"sample","title":"Sample size (1-200)","type":"Integer","min":1,"max":200,"default":25},{"name":"repeats","title":"No. of trials (1-5000)","type":"Integer","min":1,"max":5000,"default":100}];

const view = function() {
    
    this.handlers = { }

    View.extend({
        jus: "3.0",

        events: [

	]

    }).call(this);
}

view.layout = ui.extend({

    label: "Central Limit Theorem",
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
					type: DefaultControls.ComboBox,
					typeName: 'ComboBox',
					name: "dist"
				},
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					name: "sample",
					format: FormatDef.number
				},
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					name: "repeats",
					format: FormatDef.number
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
