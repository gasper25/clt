
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"dif","title":"Population difference (0-10; sd=10)","type":"Integer","min":0,"max":10,"default":0},{"name":"sam","title":"Sample size (5-500)","type":"Integer","min":5,"max":500,"default":15},{"name":"numer","title":"No. of trials(1-2000)","type":"Integer","min":0,"max":2000,"default":20},{"name":"pval","title":"p value (type I error probability)","type":"Number","min":0,"max":0.3,"default":0.05}];

const view = function() {
    
    this.handlers = { }

    View.extend({
        jus: "3.0",

        events: [

	]

    }).call(this);
}

view.layout = ui.extend({

    label: "Testing Hypothesis",
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
					name: "dif",
					format: FormatDef.number
				},
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					name: "sam",
					format: FormatDef.number
				},
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					name: "numer",
					format: FormatDef.number
				},
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					name: "pval",
					format: FormatDef.number
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
