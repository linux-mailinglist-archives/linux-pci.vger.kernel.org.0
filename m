Return-Path: <linux-pci+bounces-31072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEBDAED7CA
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 10:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9341755F7
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 08:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A59120F069;
	Mon, 30 Jun 2025 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OuUqita3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF11215F72
	for <linux-pci@vger.kernel.org>; Mon, 30 Jun 2025 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751273411; cv=none; b=B1MqBJO5mceVa1rBmP6cG4usA7fWL+uDpcwCbK/ANhfKlD0PvnKnWVz0Axoix36Uo7r5QGm6C4jv+N1W2oKhrLt7HlYcmraiC2nvtE3HWLxi5qROX9ye9cYqL9gGleXi00f/NQxIEZ6vMqpKfogrr7MSPvhRS/E54y8QPV+1YA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751273411; c=relaxed/simple;
	bh=QbJdJ30RPBStqDUxeGJhQKIlgtITYTyNv0C8Vic1KKE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jrmmX5SVkUBxKm4EfPMMo5ZyHm5OGyXAfB6oE7n3TlQttAVZ0RkD4orAlDNGd3QQF1g+qNOkD3AtYmS+HCr+r6f76oaIdPNMLKTvWs3RY1onkDisZy3cnDVn+MC+baqSpb2gD2LL3eHg/POIslwCgtxHsiCr09j4gSfwfiD8ibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OuUqita3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so28186885e9.1
        for <linux-pci@vger.kernel.org>; Mon, 30 Jun 2025 01:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751273408; x=1751878208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GB6kqlhEVlWK49BheheggyPQDPPVU2nVQPu/NkUByig=;
        b=OuUqita3fyP0TpZJjj1Ba2rd33eEGHcF+Z9FHnsO9JByerqDCQmvrfn8gKiWm+bnyQ
         79YppXU64uDgQmzBwj+qWzWTCON8A9NK3eIsZvcDrSassVGeESk4M/4HfBk84u88OaSm
         GJff7pPzS2URAYQBNgkUtEctSkI0htMsijZo12E5+6AOq5A5KAMRpMi+LIxvvT/XJEDN
         FK2e9+zbdE8Y34mFwfrfiLdIUdI3NTJ9dpPqpwdJjrr9ERrcC398sutjPwl4titgtWee
         7N2qNUb1r4KNdbnGC8YzJ2BO6YhPmEU+sA5JKFKxCo76M4g3W9XdBTRzBJjLD7hGr27w
         kNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751273408; x=1751878208;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GB6kqlhEVlWK49BheheggyPQDPPVU2nVQPu/NkUByig=;
        b=hfZj7j+7VMDNI34MpVt3yDg61z6jQZzBgcS79wrfvIwMROrdvJ4f26Z2wWLKHAJEdD
         aUpb5kqKUbr/H2y90QE+LdcfHpohJb0R0EwsfgmlgG/IKiizDCgJiLqLYebmPGv+oyG0
         faofVYtub4uM9rfOKt9ZnFoRKCFBmNcDqk5OsCU9mgEMcWeiNZep6X7nFWusxx5f56qu
         QiNq4Rnd/0AbM5MugeUxmNXcOY8VhQ/cREp7X+et99qU4XoT5/Jvs0WSnzHNyIhFscHk
         0xv3Y7seU4EotVX9M4LLWWJj/UNH7+vCXAB6iZqUfXyI+5XaMldK+1AsFl/gEOXcBbxg
         sDww==
X-Forwarded-Encrypted: i=1; AJvYcCVwa50+8+vHXQV8Gn8FmvKgw5OmasIctc+OUtBa6FgVEsiK+IuPWYqHKG1EWAmyOl8kcBg/iuwD8yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE2lIsJ54E0vOXC55lbMSkvXxJe+5NBBHD129hcaj6YTw06/PM
	A+sbpCgMhbizHH0yK9QLrt8nETapfDEpHX+GZ7LbAtuDIIN0/7+q9DlE2u2Oc0lc4Yk=
X-Gm-Gg: ASbGncsPvaClqh7BN82f3QeQHpqS+tkmxkDX5HrZw7BIzifal5+bq1+RZ8taxU5NHhG
	ez2kXjbQWlnGbrECNtwZYE+z90ZfryATY5lYHkaf9vsIkqlL+0iXXSJkdM++0hUE540kdugq7+x
	xJ8HNqRam/2LHol0hgQjuA7SNsFgAuNDbyVqOON9SZYJ5MH8SRMAR9XCFNwXvj8x2g91b1SXVrE
	DzJqHcQtMM1DM1IAW7pWByu5PEKmvWuru4yXl+PQQbinlonYf9xhpe4v2qlYkU3ezfwwWKpNj+c
	4uAbRjkDrwLqJuIWUhkKPaP7r2r/+3C6EfJLkA5aIaB3S4V/KMBwWETr8PlVNyQ7S/z6nYWilDY
	CdND865WLap9VqAob1Fvl1uxfFKu9yHvAzK5U4Hw=
X-Google-Smtp-Source: AGHT+IFQAwSBLqR1ia3wYSYaqryv4RHVS3dP8SA58uVGB0hKz2a6J2muOxRZ3XU0t7/A8x0wCssU5g==
X-Received: by 2002:a05:600c:8184:b0:453:92e:a459 with SMTP id 5b1f17b1804b1-4538ad600f0mr146846295e9.16.1751273407684;
        Mon, 30 Jun 2025 01:50:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:abe8:a49c:efe7:4dfb? ([2a01:e0a:3d9:2080:abe8:a49c:efe7:4dfb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453941c67c2sm82419835e9.5.2025.06.30.01.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 01:50:07 -0700 (PDT)
Message-ID: <a4b5fb4d-27c5-43df-8fa1-f3b92257e6d6@linaro.org>
Date: Mon, 30 Jun 2025 10:49:32 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v7 3/4] phy: rockchip-pcie: Enable all four lanes if
 required
To: Geraldo Nascimento <geraldogabriel@gmail.com>,
 linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rick wertenbroek <rick.wertenbroek@gmail.com>,
 linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1751200382.git.geraldogabriel@gmail.com>
 <b203b067e369411b029039f96cfeae300874b4c7.1751200382.git.geraldogabriel@gmail.com>
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
In-Reply-To: <b203b067e369411b029039f96cfeae300874b4c7.1751200382.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/06/2025 22:58, Geraldo Nascimento wrote:
> Current code enables only Lane 0 because pwr_cnt will be incremented on
> first call to the function. Let's reorder the enablement code to enable
> all 4 lanes through GRF.
> 
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>   drivers/phy/rockchip/phy-rockchip-pcie.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
> index bd44af36c67a..f22ffb41cdc2 100644
> --- a/drivers/phy/rockchip/phy-rockchip-pcie.c
> +++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
> @@ -160,6 +160,12 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
>   
>   	guard(mutex)(&rk_phy->pcie_mutex);
>   
> +	regmap_write(rk_phy->reg_base,
> +		     rk_phy->phy_data->pcie_laneoff,
> +		     HIWORD_UPDATE(!PHY_LANE_IDLE_OFF,
> +				   PHY_LANE_IDLE_MASK,
> +				   PHY_LANE_IDLE_A_SHIFT + inst->index));
> +
>   	if (rk_phy->pwr_cnt++) {
>   		return 0;
>   	}
> @@ -176,12 +182,6 @@ static int rockchip_pcie_phy_power_on(struct phy *phy)
>   				   PHY_CFG_ADDR_MASK,
>   				   PHY_CFG_ADDR_SHIFT));
>   
> -	regmap_write(rk_phy->reg_base,
> -		     rk_phy->phy_data->pcie_laneoff,
> -		     HIWORD_UPDATE(!PHY_LANE_IDLE_OFF,
> -				   PHY_LANE_IDLE_MASK,
> -				   PHY_LANE_IDLE_A_SHIFT + inst->index));
> -
>   	/*
>   	 * No documented timeout value for phy operation below,
>   	 * so we make it large enough here. And we use loop-break

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

