
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"trial","title":"No. of trials (1-10000)","type":"Integer","min":1,"max":10000,"default":1000},{"name":"dice","title":"No. of dices (1-6)","type":"Integer","min":1,"max":6,"default":3},{"name":"sides","title":"No. of sides on a dice (2-10)","type":"Integer","min":2,"max":10,"default":6}];

const view = function() {
    
    this.handlers = { }

    View.extend({
        jus: "3.0",

        events: [

	]

    }).call(this);
}

view.layout = ui.extend({

    label: "Throwing Dice",
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
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "small",
			fitToGrid: true,
			controls: [
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					name: "dice",
					format: FormatDef.number
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "small",
			fitToGrid: true,
			controls: [
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					name: "sides",
					format: FormatDef.number
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
