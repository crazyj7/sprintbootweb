<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>계산기</title>
    <script src="${resourceVersion.getVersionedUrl('/js/jquery-3.6.0.min.js')}"></script>
    <link rel="stylesheet" href="${resourceVersion.getVersionedUrl('/css/fonts.css')}">
    <link rel="stylesheet" href="${resourceVersion.getVersionedUrl('/css/calculate.css')}">
    <link rel="stylesheet" href="${resourceVersion.getVersionedUrl('/css/common.css')}">
</head>
<body>
    <jsp:include page="common/navigation.jsp" />
    <div class="calculator">
        <h2>계산기</h2>
        <div class="form-group">
            <label>첫번째 숫자:</label>
            <input type="number" id="num1" step="any">
        </div>
        <div class="form-group">
            <label>두번째 숫자:</label>
            <input type="number" id="num2" step="any">
        </div>
        <div class="form-group">
            <button onclick="calculate('add')">더하기</button>
            <button onclick="calculate('subtract')">빼기</button>
            <button onclick="calculate('multiply')">곱하기</button>
            <button onclick="calculate('divide')">나누기</button>
        </div>
        <div class="result" id="result"></div>
    </div>

    <script>
        function calculate(operation) {
            const num1 = parseFloat($('#num1').val());
            const num2 = parseFloat($('#num2').val());
            
            if (isNaN(num1) || isNaN(num2)) {
                alert('올바른 숫자를 입력하세요');
                return;
            }

            $.ajax({
                url: '/calculate',
                type: 'POST',
                data: {
                    num1: num1,
                    num2: num2,
                    operation: operation
                },
                success: function(result) {
                    $('#result').text('결과: ' + result);
                },
                error: function() {
                    alert('계산 중 오류가 발생했습니다.');
                }
            });
        }
    </script>
</body>
</html> 