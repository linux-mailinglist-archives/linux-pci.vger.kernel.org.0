Return-Path: <linux-pci+bounces-40093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 077CBC2AD7E
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 10:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E82734E04F3
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 09:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD072F9C32;
	Mon,  3 Nov 2025 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nYPajexp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D625C2F9987
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163348; cv=none; b=V3LyTHt6Sj9YZ0uSzy454cbJsHWCXCSz8MuwcncwrMRFV/64rR6mwnlQQRgTIXLI5d9v+5cNv5PgVYJ+C+wFKNQNCQMs5AZmI29zma+tYV2G+NTRRSDw6/W+tpMUrEH5iSIKWlcnsyMEw3JgeoyH1UTBsfZHXziH8kWPjjV5a4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163348; c=relaxed/simple;
	bh=euNZNniqY5spJKkr8zuiCVFsRb7Eip5e9xluBi2RfY0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JeNh8UVIgasNA1VPWWa0OaBqCJulV5TFgrDdkCoJIgYKW+pogYg1s/A3NVOpE7M3MxN15ZtMGZoo0zgLNpDwErcfYjOpGEJlggkfsK6CYqZ1wERi9FyE8eP/65DqrVdirLRFVIawp1nzDGjMUJ0r9/w++hz2dtyhj4UxbKFc8Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nYPajexp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-475dbc3c9efso24417885e9.0
        for <linux-pci@vger.kernel.org>; Mon, 03 Nov 2025 01:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762163345; x=1762768145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyfgOfO5wbQrka4RaJRIQ58bY784PFhznl4lHer181M=;
        b=nYPajexpfrbBlNWoNzPIXYMX67JecI5MZ6WVbh9YQKg3SdUV0dTmK4lDFnMT0jS64d
         Ab/7Bs8UgYTHqVisKXcAiz1OIpUmlWMVXTsLVMaTtsJPSD8p2l1Hfl2d3qXXhzduMs8k
         Te9Oxt6EgMmNEHbIpblYx38COuwF6S0aEGcvHsGGEbzdfRMuEcrVee0+io/arl1FZlEe
         m+2QYa4P7CA0hhQzgFxzTaLlNtsGyYUMIMDgK8BkfFbDfltUZhETDCovjCNhYkJ+e1h6
         zZ/n3cRJojpAlFwLGQWJJsKUWUICea4MOo67kgG8DNAmn0bZZqBUSi7R8WwMx8QyyP50
         5vEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762163345; x=1762768145;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cyfgOfO5wbQrka4RaJRIQ58bY784PFhznl4lHer181M=;
        b=cOSRxVr/UgnyIRXuuSpAJJ2yRIBaO2vBEPw0ex1tpr3Xu8BLXKMqHLhACWu4iOBYty
         T5YEhPp5UJvkKRsLyRxwbZl1X4aXQNB1a16bFPd5kDL6LMuU0QLX4O7J/tagGKhKMmxC
         D40tqCbpRMiNnrSsy4XUwU/2P3BHIxUP+cPnU1+e9V4tPWEB7n78LyGcOZ48BYfMwqrq
         fo7LnMOw3S16VZf36WOH8mP5wkwn+oxklxqdBiB/+gPjAnenN3yWmsOJAIJsaO+qkac6
         tFIIbbAtHcHd2r73h2Lp8CzOEKGrQMhSGY8dDGplr0jz0NuaTJM9ggN2wiJjIqjWA1XB
         vsMg==
X-Gm-Message-State: AOJu0YzopxfNNtdquU1PMk9UeLbn0Y4zo4lpeMXPlzN4z+p75RQW9dF7
	6Dxs9vqN1ODaH1sLjg9lu7rRqEn3qpEqjS/ZZJ8rNZ/FY2rMFyInLYH1cynokbOL630=
X-Gm-Gg: ASbGncvK9PnXcxpToHS8TAu0y6oH65jefFRsmy4XAs/uTiuxlb85AXiQR0eye5vIZp5
	gNxxdjgbFWUvp/wfHoqlQte2A7kcwmJY34DCf6kj0Zex8Ll2WPKLFKQtGgLfYW/H15ikNpVzX4E
	0WD8iOBUT/Aju+fUHI8bXsS/VfMqobCNIvWHQds7N0G5osmfCb3CVEej6MPsast+YqAiQlm4T1j
	DbjhR0ikNE7tOpPevdYqI7V/Q54wOJi5XmDI16MCwmUe/+qXaSPELEgp1oG83iWXlXvxT/3ahja
	9GDSs1bq+2Kiwe1PEIael4pmpd0hkLDSNcWjSndDJDVouI08CW//c6EaZCXn2y5yTOgvC0yGQcC
	QsIsb30m5sdxksNr/jF/C4gwqz5rAy6TS3vKJpEpmujhr53dV8luKibHlLghyAGfBp16cJ71ri+
	33lfbWzBKh3LkTJ/0qKr50x3liHLaClGyQDGf/ZEqAvXEU
X-Google-Smtp-Source: AGHT+IH9c7oxZUwI4MZc+UcQYfSkmXSjNxCEXJEJzZAI5xj3Z/FVbn/Z55mp6ddo/Yu2LHLMUnh/Mg==
X-Received: by 2002:a05:600c:b8d:b0:471:803:6a26 with SMTP id 5b1f17b1804b1-477308c8bc7mr112449905e9.37.1762163344829;
        Mon, 03 Nov 2025 01:49:04 -0800 (PST)
Received: from [192.168.27.65] (home.rastines.starnux.net. [82.64.67.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c4ac18bsm144251275e9.5.2025.11.03.01.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 01:49:03 -0800 (PST)
Message-ID: <807e9f74-79ed-44bc-8a80-3d99787edc65@linaro.org>
Date: Mon, 3 Nov 2025 10:49:04 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RESEND 3/3] PCI: meson: Fix parsing the DBI register
 region
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
 linux-amlogic@lists.infradead.org, stable@vger.kernel.org,
 Linnaea Lavia <linnaea-von-lavia@live.com>
References: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
 <20251101-pci-meson-fix-v1-3-c50dcc56ed6a@oss.qualcomm.com>
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
In-Reply-To: <20251101-pci-meson-fix-v1-3-c50dcc56ed6a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/1/25 05:29, Manivannan Sadhasivam wrote:
> First of all, the driver was parsing the 'dbi' register region as 'elbi'.
> This was due to DT mistakenly passing 'dbi' as 'elbi'. Since the DT is
> now fixed to supply 'dbi' region, this driver can rely on the DWC core
> driver to parse and map it.
> 
> However, to support the old DTs, if the 'elbi' region is found in DT, parse
> and map the region as both 'dw_pcie::elbi_base' as 'dw_pcie::dbi_base'.
> This will allow the driver to work with both broken and fixed DTs.
> 
> Also, skip parsing the 'elbi' region in DWC core if 'pci->elbi_base' was
> already populated.
> 
> Cc: <stable@vger.kernel.org> # 6.2
> Reported-by: Linnaea Lavia <linnaea-von-lavia@live.com>
> Closes: https://lore.kernel.org/linux-pci/DM4PR05MB102707B8CDF84D776C39F22F2C7F0A@DM4PR05MB10270.namprd05.prod.outlook.com/
> Fixes: 9c0ef6d34fdb ("PCI: amlogic: Add the Amlogic Meson PCIe controller driver")
> Fixes: c96992a24bec ("PCI: dwc: Add support for ELBI resource mapping")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>   drivers/pci/controller/dwc/pci-meson.c       | 18 +++++++++++++++---
>   drivers/pci/controller/dwc/pcie-designware.c | 12 +++++++-----
>   2 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index 787469d1b396d4c7b3e28edfe276b7b997fb8aee..54b6a4196f1767a3c14c6c901bfee3505588134c 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -108,10 +108,22 @@ static int meson_pcie_get_mems(struct platform_device *pdev,
>   			       struct meson_pcie *mp)
>   {
>   	struct dw_pcie *pci = &mp->pci;
> +	struct resource *res;
>   
> -	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "elbi");
> -	if (IS_ERR(pci->dbi_base))
> -		return PTR_ERR(pci->dbi_base);
> +	/*
> +	 * For the broken DTs that supply 'dbi' as 'elbi', parse the 'elbi'
> +	 * region and assign it to both 'pci->elbi_base' and 'pci->dbi_space' so
> +	 * that the DWC core can skip parsing both regions.
> +	 */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
> +	if (res) {
> +		pci->elbi_base = devm_pci_remap_cfg_resource(pci->dev, res);
> +		if (IS_ERR(pci->elbi_base))
> +			return PTR_ERR(pci->elbi_base);
> +
> +		pci->dbi_base = pci->elbi_base;
> +		pci->dbi_phys_addr = res->start;
> +	}
>   
>   	mp->cfg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
>   	if (IS_ERR(mp->cfg_base))
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index c644216995f69cbf065e61a0392bf1e5e32cf56e..06eca858eb1b3c7a8a833df6616febcdbe854850 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -168,11 +168,13 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
>   	}
>   
>   	/* ELBI is an optional resource */
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
> -	if (res) {
> -		pci->elbi_base = devm_ioremap_resource(pci->dev, res);
> -		if (IS_ERR(pci->elbi_base))
> -			return PTR_ERR(pci->elbi_base);
> +	if (!pci->elbi_base) {
> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
> +		if (res) {
> +			pci->elbi_base = devm_ioremap_resource(pci->dev, res);
> +			if (IS_ERR(pci->elbi_base))
> +				return PTR_ERR(pci->elbi_base);
> +		}
>   	}
>   
>   	/* LLDD is supposed to manually switch the clocks and resets state */
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

