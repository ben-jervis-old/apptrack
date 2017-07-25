
// Lenders Vue App

var lenders = new Vue({
	el: '#manage-lenders',
	data: {
		lenders: [],
		lender: {
			name: '',
			favourite: false
		},
		errors: {},
		editMode: false
	},
	mounted: function() {
		var that;
		that = this;
		$.ajax({
			url: '/lenders.json',
			success: function(res) {
				that.lenders = res;
			}
		});
	},
	methods: {
		addLender: function(e) {
			e.preventDefault();
			var that = this;

			$.ajax({
				method: 'POST',
				data: {
					lender: that.lender,
				},
				url: '/lenders.json',
				success: function(res) {
					that.errors = {}
					that.lenders.push(res);
					that.lender.name = '';
				},
				error: function(res) {
					that.errors = res.responseJSON.errors
				}
			})
		},
	}
});

Vue.component('lender-row', {
	template: '#lender-row',
	props: {
		lender: Object
	},
	data: function() {
		return {
			editMode: false,
			errors: {}
		}
	},
	methods: {
		toggleFavouriteStatus: function(e) {
			e.preventDefault();
			var that = this;
			that.lender.favourite = !that.lender.favourite;
			that.updateLender(e);
		},
		updateLender: function(e) {
			e.preventDefault();
			var that = this;
			$.ajax({
				method: 'PUT',
				data: {
					lender: that.lender,
				},
				url: '/lenders/' + that.lender.id + '.json',
				success: function(res) {
					that.errors = {}
					that.lender = res
					that.editMode = false
				},
				error: function(res) {
					that.errors = res.responseJSON.errors
				}
			})
		},
		toggleEditMode: function(e) {
			e.preventDefault();
			this.editMode = true;
		},
		deleteLender: function() {
			var that = this;
			if(confirm('Delete ' + that.lender.name + '?')){
				$.ajax({
					method: 'DELETE',
					url: '/lenders/' + that.lender.id + '.json',
					success: function(res) {
						that.$el.remove();
					}
				})
			}
		}
	}
})

// Activities Vue App

var activities = new Vue({
	el: '#manage-activities',
	data: {
		activities: []
	},
	mounted: function() {
		var that;
		that = this;
		$.ajax({
			url: '/activities.json',
			success: function(res) {
				that.activities = res;
			}
		});
	}
});
