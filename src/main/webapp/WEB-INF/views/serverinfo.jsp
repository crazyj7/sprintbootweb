<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>서버 정보</title>
    <script src="${resourceVersion.getVersionedUrl('/js/jquery-3.6.0.min.js')}"></script>
    <link rel="stylesheet" href="${resourceVersion.getVersionedUrl('/css/fonts.css')}">
    <link rel="stylesheet" href="${resourceVersion.getVersionedUrl('/css/serverinfo.css')}">
    <link rel="stylesheet" href="${resourceVersion.getVersionedUrl('/css/common.css')}">
    <link rel="stylesheet" href="${resourceVersion.getVersionedUrl('/fonts/fontawesome-free-6.7.2-web/css/all.min.css')}">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: #f0f2f5;
            margin: 0;
            padding: 20px;
        }
    </style>
</head>
<body>
    <jsp:include page="common/navigation.jsp" />
    <div class="container">
        <h2><i class="fas fa-server"></i> 서버 정보 관리</h2>
        <div class="button-group">
            <button onclick="showAddPopup()">
                <i class="fas fa-plus"></i> 새 데이터 추가
            </button>
            <button onclick="showViewPopup()">
                <i class="fas fa-eye"></i> 보기
            </button>
        </div>
        <table>
            <thead>
                <tr>
                    <th><i class="fas fa-tag"></i> 이름</th>
                    <th><i class="fas fa-edit"></i> 값</th>
                    <th><i class="fas fa-cog"></i> 작업</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${dataList}" var="data">
                    <tr data-name="${data.dataName}">
                        <td>${data.dataName}</td>
                        <td class="editable" onclick="makeEditable(this)">
                            <span>${data.dataValue}</span>
                            <i class="fas fa-pencil-alt edit-icon"></i>
                        </td>
                        <td>
                            <button class="delete" onclick="deleteData('${data.dataName}')">
                                <i class="fas fa-trash-alt"></i> 삭제
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="pagination">
            <c:if test="${totalPages > 1}">
                <c:if test="${currentPageNumber > 0}">
                    <a href="?page=0" class="page-link first">
                        <i class="fas fa-angle-double-left"></i>
                    </a>
                    <a href="?page=${currentPageNumber - 1}" class="page-link prev">
                        <i class="fas fa-angle-left"></i>
                    </a>
                </c:if>
                
                <c:forEach begin="${Math.max(0, currentPageNumber - 2)}" 
                           end="${Math.min(totalPages - 1, currentPageNumber + 2)}" var="i">
                    <a href="?page=${i}" class="page-link ${i == currentPageNumber ? 'active' : ''}">
                        ${i + 1}
                    </a>
                </c:forEach>
                
                <c:if test="${currentPageNumber < totalPages - 1}">
                    <a href="?page=${currentPageNumber + 1}" class="page-link next">
                        <i class="fas fa-angle-right"></i>
                    </a>
                    <a href="?page=${totalPages - 1}" class="page-link last">
                        <i class="fas fa-angle-double-right"></i>
                    </a>
                </c:if>
            </c:if>
            <div class="page-info">
                총 ${totalElements}개 항목 중 ${currentPageNumber * pageSize + 1}-${Math.min((currentPageNumber + 1) * pageSize, totalElements)}
            </div>
        </div>
    </div>

    <div id="addPopup" class="popup">
        <h3><i class="fas fa-plus-circle"></i> 새 데이터 추가</h3>
        <div>
            <label>이름:</label>
            <input type="text" id="newDataName" placeholder="데이터 이름 입력">
        </div>
        <div>
            <label>값:</label>
            <input type="text" id="newDataValue" placeholder="데이터 값 입력">
        </div>
        <div class="button-container">
            <button onclick="addData()">추가</button>
            <button class="cancel" onclick="hideAddPopup()">취소</button>
        </div>
    </div>

    <div id="popupOverlay" class="popup-overlay"></div>

    <div id="alertModal" class="modal">
        <div class="modal-content">
            <h3><i class="fas fa-exclamation-circle"></i> 알림</h3>
            <p id="alertMessage"></p>
            <div class="button-container">
                <button onclick="closeAlertModal()">확인</button>
            </div>
        </div>
    </div>

    <div id="confirmModal" class="modal">
        <div class="modal-content">
            <h3><i class="fas fa-question-circle"></i> 확인</h3>
            <p id="confirmMessage"></p>
            <div class="button-container">
                <button onclick="handleConfirm(true)">확인</button>
                <button class="cancel" onclick="handleConfirm(false)">취소</button>
            </div>
        </div>
    </div>

    <div id="viewModal" class="modal">
        <div class="modal-content">
            <h3><i class="fas fa-eye"></i> 데이터 상세 정보</h3>
            <div class="data-view">
                <div class="data-row">
                    <label>이름:</label>
                    <span id="viewDataName"></span>
                </div>
                <div class="data-row">
                    <label>값:</label>
                    <span id="viewDataValue"></span>
                </div>
            </div>
            <div class="button-container">
                <button onclick="closeViewModal()">닫기</button>
            </div>
        </div>
    </div>

    <script>
        function showAddPopup() {
            $('#popupOverlay').show();
            $('#addPopup').show();
        }

        function hideAddPopup() {
            $('#popupOverlay').hide();
            $('#addPopup').hide();
        }

        function showAlert(message, callback) {
            $('#alertMessage').text(message);
            $('#alertModal').fadeIn(200);
            
            window.currentAlertCallback = callback;
        }

        function closeAlertModal() {
            $('#alertModal').fadeOut(200);
            if (window.currentAlertCallback) {
                window.currentAlertCallback();
                window.currentAlertCallback = null;
            }
        }

        function showConfirm(message, callback) {
            $('#confirmMessage').text(message);
            $('#confirmModal').fadeIn(200);
            window.currentConfirmCallback = callback;
        }

        function handleConfirm(result) {
            $('#confirmModal').fadeOut(200);
            if (window.currentConfirmCallback) {
                window.currentConfirmCallback(result);
                window.currentConfirmCallback = null;
            }
        }

        function addData() {
            const dataName = $('#newDataName').val().trim();
            const dataValue = $('#newDataValue').val().trim();
            
            // 입력값이 비�있으면 모달만 닫기
            if (!dataName || !dataValue) {
                hideAddPopup();
                return;
            }

            const data = {
                dataName: dataName,
                dataValue: dataValue
            };

            $.ajax({
                url: '/api/serverdata',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function() {
                    hideAddPopup();
                    $('#newDataName').val('');
                    $('#newDataValue').val('');
                    refreshTable();
                },
                error: function(xhr) {
                    showAlert(xhr.responseText || '데이터 추가 중 오류가 발생했습니다.', function() {
                        $('#newDataName').focus();
                    });
                }
            });
        }

        function deleteData(dataName) {
            showConfirm('정말 삭제하시겠습니까?', function(confirmed) {
                if (confirmed) {
                    $.ajax({
                        url: '/api/serverdata/' + dataName,
                        type: 'DELETE',
                        success: function() {
                            refreshTable();
                        }
                    });
                }
            });
        }

        function makeEditable(td) {
            if ( $(td).find('input').length>0 ) {
                // 이미 input tag 추가된 상태.
                return ;
            }
            const originalValue = $(td).find('span').text().trim();
            const input = $('<input type="text">').val(originalValue);
            
            const originalContent = $(td).html();
            $(td).html(input);
            input.focus();

            // 값 업데이트 함수
            const updateValue = () => {
                const newValue = input.val().trim();
                if (newValue === originalValue) {
                    $(td).html(originalContent);
                } else {
                    const dataName = $(td).parent().data('name');
                    updateData(dataName, newValue);
                }
            };

            input.blur(updateValue);

            input.keyup(function(e) {
                if (e.key === 'Escape') {
                    $(td).html(originalContent);
                } else if (e.key === 'Enter') {
                    updateValue();
                    input.blur(); // 포커스 제거
                }
            });
        }

        function updateData(dataName, newValue) {
            const data = {
                dataName: dataName,
                dataValue: newValue
            };

            $.ajax({
                url: '/api/serverdata/' + dataName,
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function() {
                    refreshTable();
                }
            });
        }

        function refreshTable() {
            $.get('/serverinfo?page=' + currentPageNumber, function(response) {
                const newDoc = new DOMParser().parseFromString(response, 'text/html');
                const newTable = $(newDoc).find('table').html();
                const newPagination = $(newDoc).find('.pagination').html();
                
                $('table').html(newTable);
                $('.pagination').html(newPagination);
                bindTableEvents(); // 이벤트 바인딩
            });
        }

        function bindTableEvents() {
            // 기존 행 선택 이벤트 유지
            $('table tbody tr').click(function(e) {
                if ($(e.target).is('button') || $(e.target).is('input')) {
                    return;
                }
                $('tr.selected').removeClass('selected');
                $(this).addClass('selected');
            });

            // 페이지네이션 링크 클릭 이벤트
            $('.pagination .page-link').click(function(e) {
                e.preventDefault();
                const href = $(this).attr('href');
                const pageNum = new URLSearchParams(href.split('?')[1]).get('page');
                currentPageNumber = pageNum;
                refreshTable();
                
                // URL 업데이트 (브라우저 히스토리)
                window.history.pushState({page: pageNum}, '', href);
            });
        }

        // 브라우저 뒤로가기/앞으로가기 처리
        window.onpopstate = function(event) {
            if (event.state && event.state.page !== undefined) {
                currentPageNumber = event.state.page;
                refreshTable();
            }
        };

        $(document).ready(function() {
            window.currentPageNumber = ${currentPageNumber};
            bindTableEvents();
            $('#popupOverlay').click(function() {
                hideAddPopup();
            });

            $('#addPopup').click(function(e) {
                e.stopPropagation();
            });

            // 현재 페이지 상태를 히스토리에 추가
            window.history.replaceState({page: currentPageNumber}, '', window.location.href);

            // 모달 외부 릭시 닫기
            $('#viewModal').click(function(e) {
                if ($(e.target).is('#viewModal')) {
                    closeViewModal();
                }
            });
        });

        function showViewPopup() {
            const selectedRow = $('tr.selected');
            if (selectedRow.length === 0) {
                showAlert('데이터를 선택해주세요.');
                return;
            }

            const dataName = selectedRow.data('name');
            const dataValue = selectedRow.find('td:eq(1) span').text();

            $('#viewDataName').text(dataName);
            $('#viewDataValue').text(dataValue);
            $('#viewModal').fadeIn(200);
        }

        function closeViewModal() {
            $('#viewModal').fadeOut(200);
        }
    </script>
</body>
</html> 