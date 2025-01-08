import React, { useEffect, useState } from 'react';
import './Product.scss'
const UseEffect2 = () => {

    const [data, setData] = useState([]);
    useEffect(() =>{
        fetch("https://dummyjson.com/products") // fetch data from this url
        .then(res => res.json())
        .then((data) =>{
            //console.log(data)
            setData(data.products);
        })
    }, []);
    // nếu thiếu dependency array thì sẽ bị lặp vô hạn, vì mỗi lần setState sẽ gọi lại useEffect component sẽ re-renderrender
    console.log(data);
  return (
    <>  
        <div className='product_list'>
                {data.map((item) =>(
                    <div className='product_item' key={item.id}>
                        <div className='product_image'>
                            <img src={item.images} alt=""></img>
                        </div>
                        <div className='product_title'>{item.title}</div>
                        <div className='product_price'>{item.price}</div>
                    </div> 
                ))}
            
        </div>
    </>
  )
}
export default UseEffect2