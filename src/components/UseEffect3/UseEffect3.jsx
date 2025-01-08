import React, { useEffect, useState } from 'react';
import './Product.scss';

const UseEffect3 = () => {
  const limit = 10;
  const [data, setData] = useState([]);
  const [qualityPage, setQualityPage] = useState(0);
  const [page, setPage] = useState(0);

  useEffect(() => {
    fetch(
      `https://dummyjson.com/products?limit=${limit}&skip=${page * limit}` // fetch data from this url
    )
      .then(res => res.json())
      .then((data) => {
        setData(data.products);
        setQualityPage(Math.ceil(data.total / limit));
      });
  }, [page]); // Add `page` as a dependency
  // nếu thiếu dependency array thì sẽ bị lặp vô hạn, vì mỗi lần setState sẽ gọi lại useEffect component sẽ re-render
  const handleClick = (e) => {
    setPage(e);
  };

  return (
    <>
      <div className="product__list">
        {data.map((item) => (
          <div className="product__item" key={item.id}>
            <div className="product__image">
              <img src={item.images[0]} alt={item.title} />
            </div>
            <div className="product__title">{item.title}</div>
            <div className="product__price">${item.price}</div>
          </div>
        ))}
      </div>
      <ul>
        {[...Array(qualityPage)].map((_, index) => (
          <li
            key={index}
            onClick={() => handleClick(index)}
            style={{ cursor: "pointer", padding: "5px", display: "inline-block" }}
          >
            {index + 1}
          </li>
        ))}
      </ul>
    </>
  );
};

export default UseEffect3;
//B1 là cần tổng sản phầm 
//B2 lấy tổng sản phẩm từ API chia cho số lượng muốn hiển thị là limit
//B3 lấy dữ liệu từ API với limit và skipskip