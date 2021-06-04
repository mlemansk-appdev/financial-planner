  $(document).on("turbolinks:load", function(){
      $('#adjustment_payment_occurrence').on('change', function() {
        if ( this.value == 'Between')
        {
          $("#end_adjustment").show();
        }
        else
        {
          $("#end_adjustment").hide();
        }
      });
  });
