import React, { useEffect } from 'react'

export const UseEffect1 = () => {
    //const listItem = document.querySelectorAll('li');
    // theo tuần tự js nếu chúng ta console.log ngày đây nó sẽ trả về một mảng rỗng, vì khi
    // chúng ta gọi hàm này, component chưa được render ra ==> không có thẻ li nào cả
    console.log(listItem);
    // cách để giải quyết vấn đề này là sử dụng useEffect 
    useEffect(() => {
        const listItem = document.querySelectorAll("li");
        console.log(listItem);
    });
  return (
    <>
        <li>1</li>
        <li>2</li>
        <li>3</li>
    </>
  )
}

export default UseEffect1
