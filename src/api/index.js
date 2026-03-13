// import axios from "axios";

/**
 * 音乐播放器
 */

// 获取音乐播放列表 (使用纯静态自闭环，彻底告别所有防盗链和跨域封禁)
export const getPlayerList = async () => {
  return [
    {
      name: "起风了",
      artist: "买辣椒也用券",
      url: "/music/qifengle.mp3",
      cover: "/images/background10.jpg",
      lrc: "[00:00.00] 歌词未内置"
    },
    {
      name: "海阔天空",
      artist: "Beyond",
      url: "/music/haikuotiankong.mp3",
      cover: "/images/background1.jpg",
      lrc: "[00:00.00] 歌词未内置"
    }
  ];
};

/**
 * 一言
 */

// 获取一言数据
export const getHitokoto = async () => {
  const res = await fetch("https://v1.hitokoto.cn");
  return await res.json();
};

/**
 * 天气
 */

// 获取高德地理位置信息
export const getAdcode = async (key) => {
  const res = await fetch(`https://restapi.amap.com/v3/ip?key=${key}`);
  return await res.json();
};

// 获取高德地理天气信息
export const getWeather = async (key, city) => {
  const res = await fetch(
    `https://restapi.amap.com/v3/weather/weatherInfo?key=${key}&city=${city}`,
  );
  return await res.json();
};

// 获取备用天气 API (api.vvhan.com)
export const getOtherWeather = async () => {
  const res = await fetch("https://api.vvhan.com/api/weather");
  return await res.json();
};
