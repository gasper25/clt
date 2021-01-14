
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"dist","title":"Source distribution","type":"List","options":[{"title":"normal","name":"normal"},{"title":"uniform","name":"uniform"},{"title":"geometric","name":"geometric"},{"title":"lognormal","name":"lognormal"},{"title":"binomial","name":"binomial"}],"default":"normal"},{"name":"sample","title":"Sample size (1-200)","type":"Integer","min":1,"max":200,"default":25},{"name":"repeats","title":"No. of trials (1-5000)","type":"Integer","min":1,"max":5000,"default":100},{"name":"pic","title":"Histogram","type":"Bool","default":false}];

const view = function() {
    
    this.handlers = { }

    View.extend({
        jus: "3.0",

        events: [

	]

    }).call(this);
}

view.layout = ui.extend({

    label: "Central limit theorem",
    jus: "3.0",
    type: "root",
    stage: 0, //0 - release, 1 - development, 2 - proposed
    controls: [
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			controls: [
				{
					type: DefaultControls.ComboBox,
					typeName: 'ComboBox',
					name: "dist"
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			controls: [
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					name: "sample",
					format: FormatDef.number
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			controls: [
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					name: "repeats",
					format: FormatDef.number
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			controls: [
				{
					type: DefaultControls.CheckBox,
					typeName: 'CheckBox',
					name: "pic"
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
