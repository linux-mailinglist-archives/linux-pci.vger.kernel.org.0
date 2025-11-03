Return-Path: <linux-pci+bounces-40092-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9083CC2AD6F
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 10:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D3E1893A12
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 09:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43342F9995;
	Mon,  3 Nov 2025 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u9UtxHtu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64652F3C11
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163276; cv=none; b=DREPoqMIT0acnqXKoChzXIkvQQtXpS7cCAgslUJRrZUwC4FrfEIExK2gfb5BahVnF7BT+kbqf79hPwTkFRG6w9IjGmkxj/9V3jASabnx7b1+no0gY/rYrODGX4+nsFHpIpPs40S4Ma/8l3zhmCIRutnZfwOjPUFE+eHQmwFXmEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163276; c=relaxed/simple;
	bh=Kb1X0iGx304D1har7eAe2hTc5WLIxa8ONBM1lc6ppKA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ph73ncbpuiPFLQ+wyJaGtoPf2mUOYWnnM2AcNMPhcCWb9UyDF4Q9I0PCZoeuHGPipsIRYVcBeXNko0AagqicAFI5dvHsvEs9lpq8wInqdDhZZBhdSeVcUQnIR6A83LcvzoR8roZAYs0eofSKwOgLJdi5WjOrqjwykS7u27TPax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u9UtxHtu; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429c82bf86bso1598172f8f.1
        for <linux-pci@vger.kernel.org>; Mon, 03 Nov 2025 01:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762163272; x=1762768072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjUs+9lmvxg6hFDNkzR33u3tBhhnwtURtsDnKXMgT0M=;
        b=u9UtxHtut21ljcVRDeXRKcXhyVfiux0wyyrM3iL5hWfThm1CxQggxRGtHtq5J4JW/u
         yNUzc/wNPUCtja4o9BBdqCAO8qfr1lVhtmeJ+yay4k1ScBNgOx5eFDOhxfBE/sojaYqN
         1ideC37y/BzOYUglrk42GFM+5YKk5BNtzn2Xidu9WwYgmSstVsLW3JLAGkaerA2Tdvrs
         lp4a20mgELy4raUvFrSXbarYiL0XvOaxShDwiAH79Fp13tw/NHF0Jxn7Hc8kcwUCjDQ4
         wGUgu+13NvQzIk4e+y4inQzG3J6kU9TKGOap1R92ml+5FH8CgDwvL7/zNHglqbJJyo95
         a42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762163272; x=1762768072;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rjUs+9lmvxg6hFDNkzR33u3tBhhnwtURtsDnKXMgT0M=;
        b=uqjgZjtOmNBQdOfogGbI9ve7IyY30Qv44rEt+y51q2zoz+0ECgvY2PYbidJS31U3JB
         1ZvG14MkJ4wQ/47l49YBZeD/oXQ7onkS4tUCns1E/1BfULhXcsd8e9+YL+idqqNA6EzQ
         287IJc112f/yTmtvJtpNjPUSfoophxGa999+hGEZHE6xokZfCozg3bHQ5kk16+bfav8A
         zQ3XBnsYa2pP9AfinIFcOhPOGcL+aL3dVLFNfbXCUbA/m8Sc4BGJR2M5JdLoDROu3GsB
         y9naawbvm/70cfJH051T7bRi9qAhf6FD3BgNPnF6kBziB+XVXij5OHbMb5YxFw+umuCH
         NOZQ==
X-Gm-Message-State: AOJu0Yys3ezR//X4RxWQ8Q/ThpfHaWVHXyXNkfYsY3kjZ6D2+wErMMOX
	iPahgdifzta6g8nQWrtRohdKPg7vP1P910m1jLsA1aXUDe+KJrETPsCJfd11bsgBrEs=
X-Gm-Gg: ASbGncuxhKTwQFi+bK1t681CuEA/qBcuL1u6iCkrDK1O8xL8cP7cAvYOjGgRgkqXcdq
	oKkinDgGJ/IwWETTs3Kw/27Ewq465B5FtU8hMpvw5emyCcvANk7+XqegpLbG2fMara5NmsqHEuB
	BtKIeR9PIpIep3Ku7c9QqL5jWSQXH+3tC9LAyVjWBfECZefs5wqlrSAk0rJCyi/H7imQuvbjeFF
	tH/vCZvKfguNxeh6h8jzzUn0BeXL5+fjpTLg4CEVRWwxg2SMz56S0plC/PPZfUDEOJCiCY/HJUy
	ptMoGLpV+brzRqBN0UKoTWCmyOP+qoK0cDk+IE8QVf63ZIJkqaSSAPDkcunvjVrjhqab9qJJ7Y8
	1qfwDJj/eRtWh/me5YMKmkDeuni8PmMjwYK1g/4nPGXvIRGjYkb27AHSY1BFIWuT8COLLDS7ER+
	jWr1nLLzGYH7q+jeG5ewr4pzdmhS/zveMhLw==
X-Google-Smtp-Source: AGHT+IHDfLLp21iBMkqrIfzSTyKmVftOPG60mqDFYiQNslVJnYicp91LxbC0vPtq3CNiEJa9/RFQWQ==
X-Received: by 2002:a05:6000:659:20b0:429:d1a8:3fa2 with SMTP id ffacd0b85a97d-429d1a84015mr2297058f8f.48.1762163271853;
        Mon, 03 Nov 2025 01:47:51 -0800 (PST)
Received: from [192.168.27.65] (home.rastines.starnux.net. [82.64.67.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c1125ad0sm19637181f8f.13.2025.11.03.01.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 01:47:51 -0800 (PST)
Message-ID: <2f2bc6e9-6bc6-4d1b-8cae-0ff8a7386d7c@linaro.org>
Date: Mon, 3 Nov 2025 10:47:52 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RESEND 2/3] arm64: dts: amlogic: Fix the register name of
 the 'DBI' region
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Yue Wang <yue.wang@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Andrew Murray <amurray@thegoodpenguin.co.uk>,
 Jingoo Han <jingoohan1@gmail.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, stable+noautosel@kernel.org
References: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
 <20251101-pci-meson-fix-v1-2-c50dcc56ed6a@oss.qualcomm.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20251101-pci-meson-fix-v1-2-c50dcc56ed6a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/1/25 05:29, Manivannan Sadhasivam wrote:
> DT incorrectly specifies the 'DBI' region as 'ELBI'. DBI is a must have
> region for DWC controllers as it has the Root Port and controller specific
> registers, while ELBI has optional registers.
> 
> Hence, fix the DT for both Meson platforms.
> 
> Cc: stable+noautosel@kernel.org # Driver dependency
> Fixes: 5b3a9c20926e ("arm64: dts: meson-axg: add PCIe nodes")
> Fixes: 1f8607d59763 ("arm64: dts: meson-g12a: Add PCIe node")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi        | 4 ++--
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 04fb130ac7c6a498f7e8029aeaa7e511cbfe815d..e95c91894968b2c8b3b8e96a5f5e85cd60f3e085 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -208,7 +208,7 @@ pcieA: pcie@f9800000 {
>   			reg = <0x0 0xf9800000 0x0 0x400000>,
>   			      <0x0 0xff646000 0x0 0x2000>,
>   			      <0x0 0xf9f00000 0x0 0x100000>;
> -			reg-names = "elbi", "cfg", "config";
> +			reg-names = "dbi", "cfg", "config";
>   			interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
>   			#interrupt-cells = <1>;
>   			interrupt-map-mask = <0 0 0 0>;
> @@ -234,7 +234,7 @@ pcieB: pcie@fa000000 {
>   			reg = <0x0 0xfa000000 0x0 0x400000>,
>   			      <0x0 0xff648000 0x0 0x2000>,
>   			      <0x0 0xfa400000 0x0 0x100000>;
> -			reg-names = "elbi", "cfg", "config";
> +			reg-names = "dbi", "cfg", "config";
>   			interrupts = <GIC_SPI 167 IRQ_TYPE_EDGE_RISING>;
>   			#interrupt-cells = <1>;
>   			interrupt-map-mask = <0 0 0 0>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index dcc927a9da80246da43391f9f90049c3570f10d2..ca455f634834b5a52db8ff4e6ebca35a87ea17b7 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -138,7 +138,7 @@ pcie: pcie@fc000000 {
>   			reg = <0x0 0xfc000000 0x0 0x400000>,
>   			      <0x0 0xff648000 0x0 0x2000>,
>   			      <0x0 0xfc400000 0x0 0x200000>;
> -			reg-names = "elbi", "cfg", "config";
> +			reg-names = "dbi", "cfg", "config";
>   			interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
>   			#interrupt-cells = <1>;
>   			interrupt-map-mask = <0 0 0 0>;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

