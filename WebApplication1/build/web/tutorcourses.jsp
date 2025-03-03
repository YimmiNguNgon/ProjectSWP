<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh Sách Khóa Học</title>
        <link rel="stylesheet" href="css/tutorcourses.css">
    </head>
    <body>

        <header>
            <div class="container">
                <nav>
                    <ul>
                        <li><a href="hometutor.jsp">Trang Chủ</a></li>
                        <li><a href="ProfileTuTorServlet">Thông Tin Cá Nhân</a></li>
                        <li><a href="tutorcoursesservlet">Khóa Học</a></li>
                        <li><a href="scheduleservlet">Lịch Dạy</a></li>
                        <li><a href="contact.jsp">Liên Hệ</a></li>
                    </ul>
                </nav>
            </div>
        </header>

        <section class="course-list">
            <div class="container">
                <h2>Khóa Học Hiện Tại Của Gia Sư</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Tên Khóa Học</th>
                            <th>Mô Tả</th>
                            <th>Cấp Độ</th>
                            <th>Giá (VNĐ)</th>
                            <th>Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="course" items="${sessionScope.tutorCourses}">
                            <tr>
                                <td>${course.courseName}</td>
                                <td>${course.description}</td>
                                <td>${course.level}</td>
                                <td>${course.price}</td>
                                <td>
                                    <a 
                                        class="edit-btn" 
                                        data-courseid="${course.courseID}" 
                                        data-coursename="${course.courseName}" 
                                        data-description="${course.description}" 
                                        data-level="${course.level}" 
                                        data-price="${course.price}" 
                                        onclick="showPopupEdit(event, this)">
                                        Chỉnh Sửa
                                    </a>

                                    <a href="deleteCourseServlet?courseID=${course.courseID}" class="delete-btn" onclick="return confirm('Bạn có chắc muốn xóa?');">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- Nút mở modal -->
                <button class="btn" id="openModal">Thêm Khóa Học</button>
            </div>
        </section>

        <!-- Modal -->
        <!-- Modal (Ẩn mặc định) -->
        <div id="addCourseModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <h2>Thêm Khóa Học Mới</h2>
                <form action="addcourseservlet" method="POST">
                    <input type="hidden" id="courseName" name="courseId" required>
                    <label for="courseName">Tên Khóa Học:</label>
                    <input type="text" id="courseName" name="courseName" required>

                    <label for="description">Mô Tả:</label>
                    <textarea id="description" name="description" required></textarea>

                    <label for="level">Cấp Độ:</label>
                    <select id="level" name="level" required>
                        <option value="Beginner">Beginner</option>
                        <option value="Intermediate">Intermediate</option>
                        <option value="Advanced">Advanced</option>
                    </select>

                    <label for="price">Giá (VNĐ):</label>
                    <input type="number" id="price" name="price" required>
                    <!--            <label for="cat">Category</label>
                                <input type="text" id="category" name="category" required>-->

                    <button type="submit" class="add-btn">Lưu Khóa Học</button>
                </form>
            </div>
        </div>


        <!-- Modal Edit Course -->
        <div id="editCourseModal" class="custom-modal">
            <div class="custom-modal-content">
                <span class="custom-close">&times;</span>
                <h2>Chỉnh Sửa Khóa Học</h2>
                <form id="editCourseForm" action="editCourseServlet" method="POST">
                    <!-- Hidden field for courseID -->
                    <input type="hidden" id="courseEditID" name="courseID">

                    <label for="courseName">Tên Khóa Học:</label>
                    <input type="text" id="courseEditName" name="courseName" required>

                    <label for="description">Mô Tả:</label>
                    <textarea id="descriptionEdit" name="description" required></textarea>

                    <label for="level">Cấp Độ:</label>
                    <select id="levelEdit" name="level" required>
                        <option value="Beginner">Beginner</option>
                        <option value="Intermediate">Intermediate</option>
                        <option value="Advanced">Advanced</option>
                    </select>

                    <label for="price">Giá (VNĐ):</label>
                    <input type="number" id="priceEdit" name="price" required>

                    <button type="submit" class="custom-btn">Lưu Khóa Học</button>
                </form>
            </div>
        </div>
        <script>
            function showPopupEdit(event, element) {
//                event.preventDefault();
                const courseID = element.getAttribute('data-courseid');
                const courseName = element.getAttribute('data-coursename');
                const description = element.getAttribute('data-description');
                const level = element.getAttribute('data-level');
                const price = element.getAttribute('data-price');

                // Populate modal fields
                document.getElementById('courseEditID').value = courseID;
                document.getElementById('courseEditName').value = courseName;
                document.getElementById('descriptionEdit').value = description;
                document.getElementById('levelEdit').value = level;
                document.getElementById('priceEdit').value = price;

                // Show the modal
                document.getElementById('editCourseModal').style.display = 'block';
            }


            // Đóng modal khi nhấn vào nút close
            document.querySelector('.custom-close').addEventListener('click', function () {
                document.getElementById('editCourseModal').style.display = 'none';
            });

            // Đóng modal nếu người dùng nhấn vào vùng bên ngoài modal
            window.onclick = function (event) {
                if (event.target == document.getElementById('editCourseModal')) {
                    document.getElementById('editCourseModal').style.display = 'none';
                }
            };

            document.getElementById("editCourseForm").addEventListener("submit", function (event) {
                event.preventDefault(); // Ngăn form submit theo cách thông thường

                // Lấy dữ liệu form
                let formData = new FormData(this);

                // Gửi dữ liệu lên server thông qua fetch
                fetch("editcourseservlet", {
                    method: "POST",
                    body: formData
                })
                        .then(response => response.json()) // Giả sử bạn nhận về kết quả dưới dạng JSON
                        .then(data => {
                            // Xử lý kết quả (ví dụ: hiển thị thông báo thành công hoặc cập nhật lại danh sách khóa học)
                            alert("Cập nhật khóa học thành công!");
                            location.reload(); // Tải lại trang (hoặc cập nhật danh sách mà không tải lại)
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert("Có lỗi xảy ra!");
                        });
            });
        </script>

        <!-- ✅ Script mở/đóng modal đúng cách -->
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var modal = document.getElementById("addCourseModal");
                var btn = document.getElementById("openModal");
                var closeBtn = document.getElementsByClassName("close")[0];

                // Ẩn modal khi tải trang
                modal.style.display = "none";

                // Hiển thị modal khi nhấn nút "Thêm Khóa Học"
                btn.addEventListener("click", function () {
                    modal.style.display = "flex";
                });

                // Đóng modal khi nhấn vào nút X
                closeBtn.addEventListener("click", function () {
                    modal.style.display = "none";
                });

                // Đóng modal khi click ra ngoài
                window.addEventListener("click", function (event) {
                    if (event.target === modal) {
                        modal.style.display = "none";
                    }
                });

                // 🟢 Gửi form bằng AJAX khi ấn "Lưu Khóa Học"
                document.querySelector("#addCourseModal form").addEventListener("submit", function (event) {
                    event.preventDefault(); // Ngăn form submit theo cách thông thường
                    console.log("Ad");
                    let formData = new FormData(this);
                    console.log(formData.get("courseName"))
                    fetch("AddCoursesServlet", {
                        method: "POST",
                        body: formData
                    })
                            .then(response => response.json()) // Chuyển đổi phản hồi thành JSON
                            .then(data => {
                                console.log(data)
                                if (data.success) {
                                    // 🟢 Thêm khóa học mới vào bảng hiển thị
                                    let newRow = document.createElement("tr");
                                    newRow.innerHTML =
                                            "<td>" + data.courseName + "</td>" +
                                            "<td>" + data.description + "</td>" +
                                            "<td>" + data.level + "</td>" +
                                            "<td>" + data.price + "</td>" +
                                            "<td>" +
                                            "<a href='editCourse.jsp?courseID=" + data.courseID + "' class='edit-btn'>Chỉnh Sửa</a>" +
                                            "<a href='deleteCourseServlet?courseID=" + data.courseID + "' class='delete-btn' onclick='return confirm(\"Bạn có chắc muốn xóa?\");'>Xóa</a>" +
                                            "</td>";


                                    document.querySelector("tbody").appendChild(newRow);

                                    // 🟢 Ẩn modal sau khi thêm thành công
                                    modal.style.display = "none";
                                    location.reload();
                                    // 🟢 Reset form
                                    document.querySelector("#addCourseModal form").reset();
                                } else {
                                    alert("Thêm khóa học thất bại!");
                                }
                            })
                            .catch(error => console.error("Lỗi khi thêm khóa học:", error));
                });
            });

        </script>

        <style>
            /* Phong cách cho Modal */
            .custom-modal {
                display: none; /* Ẩn modal mặc định */
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgb(0,0,0); /* Màu nền mờ */
                background-color: rgba(0,0,0,0.4); /* Màu nền mờ */
                padding-top: 60px;
            }

            .custom-modal-content {
                background-color: #fff;
                margin: 5% auto;
                padding: 20px;
                border: 1px solid #888;
                width: 80%; /* Chiều rộng modal */
                max-width: 500px;
            }

            .custom-close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .custom-close:hover,
            .custom-close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }

            .custom-btn {
                background-color: #4CAF50; /* Màu xanh */
                color: white;
                padding: 10px 20px;
                border: none;
                cursor: pointer;
            }

            .custom-btn:hover {
                background-color: #45a049;
            }

            /* ✅ Căn giữa modal và hiệu ứng đẹp hơn */
            /* ✅ Căn giữa modal và ẩn khi chưa mở */
            .modal {
                display: none; /* Ẩn modal khi tải trang */
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .modal-content {
                background-color: #fff;
                padding: 25px;
                border-radius: 12px;
                width: 450px;
                max-width: 90%;
                text-align: left;
                box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.2);
                position: relative;
                animation: fadeIn 0.3s ease-in-out;
            }

            .close {
                position: absolute;
                top: 15px;
                right: 20px;
                font-size: 24px;
                font-weight: bold;
                cursor: pointer;
                color: #888;
                transition: color 0.3s ease;
            }

            .close:hover {
                color: #333;
            }

            .modal-content h2 {
                margin-bottom: 15px;
                font-size: 22px;
                color: #333;
                text-align: center;
            }

            .modal-content label {
                font-weight: bold;
                display: block;
                margin: 10px 0 5px;
            }

            .modal-content input,
            .modal-content textarea,
            .modal-content select {
                width: 100%;
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 16px;
            }

            .modal-content textarea {
                resize: vertical;
                min-height: 80px;
            }

            .add-btn {
                width: 100%;
                background: linear-gradient(135deg, #28a745, #218838);
                color: white;
                padding: 12px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 16px;
                transition: background 0.3s ease;
            }

            .add-btn:hover {
                background: linear-gradient(135deg, #218838, #1e7e34);
            }

            /* Hiệu ứng mở modal */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: scale(0.95);
                }
                to {
                    opacity: 1;
                    transform: scale(1);
                }
            }
        </style>

    </body>
</html>