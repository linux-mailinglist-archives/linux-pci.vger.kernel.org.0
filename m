Return-Path: <linux-pci+bounces-26748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2145A9C864
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 13:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E14A07A7049
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 11:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ECF224B06;
	Fri, 25 Apr 2025 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dspriB67"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F9424BC1D
	for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745582388; cv=none; b=TFrY/nUWpcsDlfkGakx1lYgXrPMvrLAt3/3FC9ajWLQNxSwROznIg/pGHc3HcS5/zcyQSI/eQk+xXz+Yf1CfU4eEoRLPOersuVTx/M7P0AQGxQbcJVOgDhQh/Ht+YvqqnbT1y593DQS4a1HZAxzn2WeGZGIKRJRJbWPOImagoiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745582388; c=relaxed/simple;
	bh=y2c3NPN00PNitlwxj+YxzIyANOEj0j+/tbSQ/t0UUiE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mIRvhA+aXBh/RuWRXwWGo0RkoGcZ0pAz+h5P+OsyUu2PoAuwx94ahW8CSoBGpAQ9PVTutRHx1P6EXv4JwjWllevvMW2t9W0uJtDw2+7oeQ2Vp2h5yw0YsZToUh/OeWOfDetcORLBEBb1hSTS3zRjCQds+BRweApGJOwKgMjhF3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dspriB67; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so14381255e9.1
        for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 04:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745582385; x=1746187185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1BMXqgQl7jfC6H77AGknLL1fmdPdkIRiy2JGqphh2TI=;
        b=dspriB670hVcqlKcTYeT0VPOovQovn+9noJNFg8Gly8fTQPA4iEehbFmdbAKeso0Yp
         VqghMOfFl0rS47xHPLiGGee4kE3AEME2zPssgwJ6Au34+LsyEpXE86BWa+XTYzKan04S
         1cvee6EVYYFPUXfJo1QR9tMhq1gnOakMybqfaGrPTEFIzYdwJYAjjjE+UzN0Q1F7PP/e
         O9QFl7hipSNBG+1+r9+Vj/qX+kXTLO+GQ36uIxbWM3Npa7E3kuB+hhVMrEc4XaS4Qd/f
         I5+K3UZM/mR/GJX0L6O1BMuVM9B6/Ei+AFake10zw0Q97NCHYeaRoVQaLhoBC5Eavq9O
         5DlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745582385; x=1746187185;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1BMXqgQl7jfC6H77AGknLL1fmdPdkIRiy2JGqphh2TI=;
        b=P8nvE0GsEQDUWXN0OUiUaC/SNf3/j9rOf0JMPmb/PuwTiyG4XhdTKCZYGsWEQboioy
         lOe9uhjYd4Ydwxp7r2FMSKKyesZYWSvKLJykZXx5K1qOloXuG2FyV35VQxGjXQMIDBKs
         1y+cv5kMY1yimAzrr6gMe1KEIRZbXirwGOw9FoZgoVPQnJDyKUhoHrZKsmj5QTZHe+xk
         8DO1HMqA8tmRHv8he3yu4lkL51HnBLk5RFZCf7+0wiK4jOQqpUReSjXl/de2z/TxRPe0
         p+MDW86l0Ykt07BaZATJjR7xZGT/+N01tuOm4VRiXqoRMMVl/fBewsKWZ7FT27bK+fWY
         Xg0g==
X-Forwarded-Encrypted: i=1; AJvYcCUb8Yq9eCSsk/yqGrCevC4DYkH6h9KEgMz/UaL0ZBmoHGOwJduaKrVXHD9K7jgPg8QH+HZ0FF/Dojs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWYdvhPM+r8NojG3GyIzQ+2vT7OU/SImcCz8WZrrDXMrXx7JXa
	cMAk/kCpOp6IAvfKODlyteS09lqtrOAbxhI0Xmkd5/6yK6sL2qPJL+fbx5/Zhzz21ZeT11n15MR
	L
X-Gm-Gg: ASbGnctzNLRfgUmEetb/wqUT8FPQ+BWc24lIwIRVPvRgDEW5tm13GpXfb5j9avDtS/X
	Y/GUpYL2OC7caXg89YDMWyaW9tWaKOjXZ1TYNaqipPBgsxtEKMd7fjY+3o3za4BP8hpEEj3JgFm
	DkC/R1bRRSuyxIZwjQvYVz40Exzt1IgetQuPf4O0ExVU0A33/Y95PX+ZmWwnlmADPNIkNnDRsfB
	hn/Bj6gKW2qaW32mqlz3D6UMX1mtaqZWE68i3G9T9pmSCNzq53vXNS5ix9wfo8s1DACcq04BhQS
	ogrKJsvVR4l7nJ9+iP8OqA78UcmZbn960OPDN29umOEhqQNjZV6RvNnSwYwQu1DxhM7HaSsstAl
	ynzbNf58RclFt3IE=
X-Google-Smtp-Source: AGHT+IFUziGPo9gQMFmCnZNYEF+uivB8dimTgfWb3U4m2/eIphhsJOITXlVU1qUIZpOSQaR9a2Vnog==
X-Received: by 2002:a05:600c:c88:b0:439:5f04:4f8d with SMTP id 5b1f17b1804b1-440a6693e9fmr16619325e9.12.1745582384889;
        Fri, 25 Apr 2025 04:59:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:d16:61ed:6880:1168? ([2a01:e0a:3d9:2080:d16:61ed:6880:1168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a530a6e9sm22682585e9.16.2025.04.25.04.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 04:59:44 -0700 (PDT)
Message-ID: <e6752451-4492-4ae2-9bad-3865c4945dbe@linaro.org>
Date: Fri, 25 Apr 2025 13:59:43 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/2] PCI: Remove redundant MPS configuration
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org, kw@linux.com,
 bhelgaas@google.com, heiko@sntech.de, thomas.petazzoni@bootlin.com,
 manivannan.sadhasivam@linaro.org, yue.wang@Amlogic.com
Cc: pali@kernel.org, robh@kernel.org, jingoohan1@gmail.com,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250425095708.32662-1-18255117159@163.com>
 <20250425095708.32662-3-18255117159@163.com>
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
In-Reply-To: <20250425095708.32662-3-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/04/2025 11:57, Hans Zhang wrote:
> With the PCI core now centrally configuring root port MPS to
> hardware-supported maximums (via 128 << pcie_mpss) during host probing,
> platform-specific MPS adjustments are redundant. This patch removes the
> custom the configuration of the max payload logic to align with the
> standardized initialization flow.
> 
> By eliminating redundant code, this change prevents conflicts with global
> PCIe hierarchy tuning policies and reduces maintenance overhead. The Meson
> driver now fully relies on the core PCI framework for MPS configuration,
> ensuring consistency across the PCIe topology while preserving
> hardware-specific MRRS handling.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>   drivers/pci/controller/dwc/pci-meson.c | 17 -----------------
>   drivers/pci/controller/pci-aardvark.c  |  2 --
>   2 files changed, 19 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index db9482a113e9..126f38ed453d 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -261,22 +261,6 @@ static int meson_size_to_payload(struct meson_pcie *mp, int size)
>   	return fls(size) - 8;
>   }
>   
> -static void meson_set_max_payload(struct meson_pcie *mp, int size)
> -{
> -	struct dw_pcie *pci = &mp->pci;
> -	u32 val;
> -	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	int max_payload_size = meson_size_to_payload(mp, size);
> -
> -	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
> -	val &= ~PCI_EXP_DEVCTL_PAYLOAD;
> -	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
> -
> -	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
> -	val |= PCIE_CAP_MAX_PAYLOAD_SIZE(max_payload_size);
> -	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
> -}
> -
>   static void meson_set_max_rd_req_size(struct meson_pcie *mp, int size)
>   {
>   	struct dw_pcie *pci = &mp->pci;
> @@ -381,7 +365,6 @@ static int meson_pcie_host_init(struct dw_pcie_rp *pp)
>   
>   	pp->bridge->ops = &meson_pci_ops;
>   
> -	meson_set_max_payload(mp, MAX_PAYLOAD_SIZE);
>   	meson_set_max_rd_req_size(mp, MAX_READ_REQ_SIZE);

Seems you can also remove meson_set_max_rd_req_size() since it's
done by pcie_write_mrrs()

Neil

>   
>   	return 0;
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index a29796cce420..d8852892994a 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -549,9 +549,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>   	reg = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
>   	reg &= ~PCI_EXP_DEVCTL_RELAX_EN;
>   	reg &= ~PCI_EXP_DEVCTL_NOSNOOP_EN;
> -	reg &= ~PCI_EXP_DEVCTL_PAYLOAD;
>   	reg &= ~PCI_EXP_DEVCTL_READRQ;
> -	reg |= PCI_EXP_DEVCTL_PAYLOAD_512B;
>   	reg |= PCI_EXP_DEVCTL_READRQ_512B;
>   	advk_writel(pcie, reg, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
>   


