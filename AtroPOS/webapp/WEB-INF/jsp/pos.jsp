<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<link rel="stylesheet" type="text/css" href='<c:out value="${pageContext.request.contextPath}"/>/css/atropos.css' />
		<link rel="stylesheet" type="text/css" href="<c:out value="${pageContext.request.contextPath}"/>/css/smoothness/jquery-ui-1.10.4.custom.css">
		<script src="<c:out value="${pageContext.request.contextPath}"/>/js/jquery-1.10.2.js"></script>
		<script src="<c:out value="${pageContext.request.contextPath}"/>/js/jquery-ui-1.10.4.custom.js"></script>
		<script src='<c:out value="${pageContext.request.contextPath}"/>/js/util.js'></script>
		<script type="text/javascript">
			
			var txtProductID;
			var txtProductName;
			var txtPrice;
			var txtQty;
			var txtCustomerID;
			var txtDiscount;
			var txtTotalPayable;
			var txtCashPayment;
			var txtChange;
			
			var spnDiscount;
			var spnSubTotal;
			var spnTotal;
			
			var btnPay;
			var btnPrintNFinish;
			var btnCancelPayment;
			
			var dlgPaymentForm;
			
			var chkWalkin;
			
			var posQuickitemsBody;
			var quickItemEntry;
			
			var subTotal;
		
			$(document).ready(function(){
				subTotal = 0;
				
				cacheSelectors();
				jqueryUIfy();
				handleEvents();			
				loadQuickItems();
				
				chkWalkin.trigger("click");
			});
			
			function cacheSelectors(){
				txtProductID = $("#txtProductID");
				txtProductName = $("#txtProductName");
				txtPrice = $("#txtPrice");
				txtQty = $("#txtQty");
				txtCustomerID = $("#txtCustomerID");
				txtTotalPayable = $("#txtTotalPayable");
				txtCashPayment = $("#txtCashPayment");
				txtChange = $("#txtChange");
				
				spnDiscount = $("#spnDiscount");
				spnSubTotal = $("#spnSubTotal");
				spnTotal = $("#spnTotal");
				
				btnPay = $("#btnPay");
				btnPrintNFinish = $("#btnPrintNFinish");
				btnCancelPayment = $("#btnCancelPayment");
				
				dlgPaymentForm = $("#dlgPaymentForm");
				
				chkWalkin = $("#chkWalkin");
				
				posQuickitemsBody = $("#pos-quickitems-body");
				quickItemEntry = $("#quick-item-entry");
			}
			
			function jqueryUIfy(){
				 
				dlgPaymentForm.dialog({
					 autoOpen: false,
					 height: 400,
					 width: 600,
					 modal: true,
					 close: function() {
						 txtTotalPayable.val("0.00");
						 txtCashPayment.val("");
						 txtChange.val("0.00");
					 }
				});
				 
				 txtTotalPayable.button();
				 txtCashPayment.button().focus(function () { // select text on focus
				        $(this).select();
				 });;
				 txtChange.button();
				 
				 btnPrintNFinish.button();
				 btnCancelPayment.button();
			}
			
			function handleEvents(){
				chkWalkin.change(function() {
				    if (this.checked) {
				    	txtCustomerID.prop('disabled', true);
				    	txtCustomerID.addClass('background-gray');
				    } else {
				    	txtCustomerID.prop('disabled', false);
				    	txtCustomerID.removeClass('background-gray');
				    }
				});
				
				btnPay.click(function() {
					txtTotalPayable.val(spnTotal.html());
					txtChange.val("0.00");
					dlgPaymentForm.dialog("open");
					
					txtCashPayment.focus();
				});
				
				txtCashPayment.keyup(function(){
					var totalPayable = parseFloat(txtTotalPayable.val());
					var payment = $.isNumeric(txtCashPayment.val()) ? parseFloat(txtCashPayment.val()) : 0;
					var change = payment - totalPayable;
					var changeDisplay = change.formatMoney(2, ",", ".");
						
					if(change < 0){
						changeDisplay = "0.00";
					}
					
					txtChange.val(changeDisplay);
					
					console.log("totalPayable : " + totalPayable);
					console.log("payment : " + payment);
					console.log("change : " + change);
					console.log("changeDisplay : " + changeDisplay);
				});
			}
			
			function loadQuickItems(){
				$.ajax({
					cache: false,
					type: 'POST',
					url: 'getQuickItems.htm',
					success : function(data){
						var itemList = JSON.parse(data);
						var count = itemList.length;
						
						for(var i = 0; i < count; i++){
							var quickItem = createQuickItemEntry(itemList[i]["id"], 
																itemList[i]["shortName"],
																itemList[i]["price"]);
							addItemToQuickItems(quickItem);
						}
					}
				}); 
			}
			
			function createQuickItemEntry(id, name, price){
				var entry = quickItemEntry.clone();
				entry.attr("id", id);
				entry.attr("onclick","quickItemOnclick('" + id + "', '" + name + "','" + price + "')");
				entry.val(name + "&#x00A;" + price);
				entry.button();
				
				return entry;
			}
			
			function addItemToQuickItems(entry){
				posQuickitemsBody.append(entry);
			}
			
			function quickItemOnclick(id, name, price){
				txtProductID.val(id);
				txtProductName.val(name);
				txtPrice.val(price);
				txtQty.val(1);
				txtQty.select();
			}
			
			function addItemToOrderList(){
				var id = txtProductID.val();
				var name = txtProductName.val();
				var price = parseFloat(txtPrice.val());
				var qty = parseInt(txtQty.val(), 10);
				var orderItemTotal = qty * price;
				
				var discount = 0;
				
				subTotal += (orderItemTotal);
				
				var grandTotal = subTotal - discount;
				
				$("#pos-order-items-table>tbody>tr:last").after("<tr>" +
						"<td>" + id + "</td>" +
						"<td>" + name + "</td>" +
						"<td class='text-align-right'>" + price.formatMoney(2, ",", ".") + "</td>" +
						"<td class='text-align-right'>" + qty + "</td>" +
						"<td class='text-align-right'>" + orderItemTotal + "</td>" +
						"</tr>");
				
				spnDiscount.html(discount.formatMoney(2, ",", "."));
				spnSubTotal.html(subTotal.formatMoney(2, ",", "."));
				spnTotal.html(grandTotal.formatMoney(2, ",", "."));
				
				txtProductID.val("");
				txtProductName.val("");
				txtPrice.val("");
				txtQty.val("");
				txtProductID.select();
			}
		</script>
	</head>
	<body>
		<div id="pos-wrap">
			<div id="pos-toolbar">
				
			</div>
			<div id="pos-body">
				<div id="pos-body-left">
					<div id="pos-product-search">
						<span class="pos-label margin-left-5">Product</span>
						<input type="text" id="txtProductID" class="input-field width-70">
						<input type="text" id="txtProductName" class="input-field width-110" readonly>
						<span class="pos-label margin-left-5">Qty</span>
						<input type="text" id="txtQty" class="input-field width-40">
						<span class="pos-label margin-left-5">Price</span>
						<input type="text" id="txtPrice" class="input-field width-60" readonly>
						<input type="button" class="button-field margin-left-5" value="Add (F2)" onclick="addItemToOrderList()">
						<!-- <input type="button" class="button-field margin-left-5" value="0-(F3)"> -->
					</div>
					<div id="pos-options">
						<input type="button" value="Search (F3)" class="float-left">
						<input type="button" value="Void (F4)" class="float-left">
						<input type="button" value="Pay (F5)" class="float-left" id="btnPay">
						<input type="button" value="Cancel Trans (F9)" class="float-left">
					</div>
					<div id="pos-ordered-items">
						<table id="pos-order-items-table" border="1" cellSpacing="0" cellPadding="0" width="100%">
							<tbody>
							<tr></tr>
							</tbody>
						</table>
					</div>
					<div id="pos-total">
						<div id="pos-customer">
							<div id="pos-customer-title">
								Customer
							</div>
							<div id="pos-customer-body">
								<p>ID : <input id="txtCustomerID" type="text" class="input-field width-110">&nbsp;<input id="chkWalkin" type="checkbox"> Walk-in</p>
								<p class="margin-top-5">Disc % : <input id="txtDiscount" type="text" class="input-field width-70"> &nbsp; <input type="button" value="View Cust Info"></p>
							</div>
						</div>
						<div id="pos-total-summary">
							<p class="margin-top-10 float-left width-280"><span class="float-left">Sub Total</span><span class="float-right" id="spnSubTotal">0.00</span></p>
							<p class="margin-top-10 float-left width-280"><span class="float-left">Discount</span><span class="float-right" id="spnDiscount">0.00</span></p>
							<p class="margin-top-10 float-left width-280"><span class="float-left">Total</span><span class="float-right" id="spnTotal">0.00</span></p>
						</div>
					</div>
				</div>
				<div id="pos-body-right">
					<div id="pos-quickitems">
						<div id="pos-quickitems-title">
							Quick Items
						</div>
						<div id="pos-quickitems-body">
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
	
	<!-- Item div in the quick items area -->
	<div class="hidden">
		<!-- <div id="quick-item-entry" class="quick-item float-left margin-right-10 margin-bottom-10">1</div> -->
		<input type="button" id="quick-item-entry" class="quick-item float-left margin-right-10 margin-bottom-10">
	</div>
	
	<!-- Payment Form -->
	<div id="dlgPaymentForm" title="Payment">
		<div id="pos-payment-form-left">
			<p class="payment-form-input-label margin-left-10">Total Payable</p>
			<p><input type="text" id="txtTotalPayable" class="payment-form-input margin-left-10" readonly></p>
			<p class="payment-form-input-label margin-left-10">Cash Payment</p>
			<p><input type="text" id="txtCashPayment" class="payment-form-input margin-left-10"></p>
			<p class="payment-form-input-label margin-left-10">Change</p>
			<p><input type="text" id="txtChange" class="payment-form-input margin-left-10 margin-bottom-20" readonly></p>
		</div>
		<div id="pos-payment-form-right">
			<p><input type="button" value="Print &&#x00A;Finish&#x00A;(F6)" id="btnPrintNFinish" class="payment-form-button">&nbsp;<input type="button" value="Cancel&#x00A;(F9)" id="btnCancelPayment" class="payment-form-button"></p>
		</div>
	</div>
</html>
