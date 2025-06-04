Return-Path: <linux-pci+bounces-28969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC27ACDDE5
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 14:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7711F188E989
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 12:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5551B28ECDF;
	Wed,  4 Jun 2025 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K/4E5nk3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025ED28EA69
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749040157; cv=none; b=uN6n+IEnRpuA128cLjgG4ys0xDXMuXho4use9hpDwf3uBdlKY2FbIL1iy4wnEXvSngcVyAzmAMhGu305zhInE0mS6OT/uVqHN5oA1NcdRVVU5e1pt/KG88TfF4Sox30HuOkzAFgGKRa6IJtim+LFKHyIVDNQMsH0X3fM4x+77nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749040157; c=relaxed/simple;
	bh=ULFNDPnm3+qsry1f77pFQpUZJmv8SW+h00LKUdNxlGY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ft6BtApn6OzH43zW5mtsPLREW+MAjR5cxg9Wxg0arjS2cOyxLMNufHpiATLE5xU87hjvpGSxt1ycomHCFk0Lm6tpQuWsloknHcc/DO1d+tS7EOoUkTdMNKWMXScNKocMI7YT72FTqe5OD9+aNxcQAzbl1QXLyMTDuNOekBqZOAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K/4E5nk3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4ef2c2ef3so5422993f8f.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Jun 2025 05:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749040153; x=1749644953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVfy2CpvBk3MsiLsYhxYE+mgkyJuV5n7k3uqs9AC104=;
        b=K/4E5nk3yOF0ml3ljPfRlvXWzb1u2FwfWABju3Pg4foTdGiv5wSA/NW+44bSgldlDR
         cjDMZ3Z0Mg+3LpyT709R3EZcR+X7QVnrj4EnY9tje/tvNz8MoGJjOGzu/NREJOilNREm
         YxX2UeWv7Z58OZ3QYkl0YkzTza9Y6wS8C4laJZt8nDMPN3QzGt0f2+bNMJ2FALH55bSk
         /tNKqZmbcmiGUcEVO39exdBxIRgRu7iDpw4CPXMkfUdL0/SzDSydnPwujWdKld/j1Ebf
         y6OCyfCV/pc8Zj6z5t11OLjdFMWcBBGyd4O65L4z6IG6zZr1Ql4g9vH2rjRVZ81U9Non
         kpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749040153; x=1749644953;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QVfy2CpvBk3MsiLsYhxYE+mgkyJuV5n7k3uqs9AC104=;
        b=F5qKkz9amEhhn/IgcHKbZAWuYRJakyBc+nLNUWdnFCD1TxnwBIGHntS+t2Dkn8Z1Nk
         yB4uvPdcKeiqNrYjnitRqCq0kMRZsCtJwNUlhRROzy/sU8NuvrDBeRyV7xIcSd6jxzmd
         6aKT/e2E8h7yzq+yJQ//odFVnfgDB9/QHzG2Ty4fMrw0bUgsH5uf83/IuCRrzEoC/CjR
         xS/IgdXNk8FUF3nPfVCOEbq3iEL80IdvgZwAHK+nLatMNCUr5ox7r94+sGs4Yd60CDxE
         2CJ9CFbIMLv2OmiuzdMt83Xh4dk1aNrNjH5893vHlXSPkbLR9fM36ZX0BziPkJty/fH5
         TzCg==
X-Gm-Message-State: AOJu0YxDIFKmJX62QOu0vQCMnsrI125Ro/AzlUMCzORe3Bouumgc1WB9
	VgIMpyxHgtctsyAv9Zk85pldUsxxt5yi165vvHT1K5YWwrEuY9/9UTTFWI0htxWJvL4=
X-Gm-Gg: ASbGncullhfE6MQ/32CorXIuM27bhR4Z8+NLuUlkkLT8j5bskIXuOmSl3+taRWG2Rew
	twmNuEI8GQQFOsyxw9SvMdalnFJG4atd60NKdOEO6kYiVeDfLoEWbAIbHT2FwvPbtCF87ghI83R
	9nIpe3DBnNM9uZpuAAqcmZUkt/2tsvZstJZ5sdk4JyvdQxB8wYUTldu3lLHMW1E+TTWesEAJRn7
	TSHCpY/GDL1b+AtVx45gNoFqBvwrhn9wY2b6l4tzYsOBPb3xhjo9AM5OF5smTRkm+9JZS5y361A
	D1cTpSv8DGwmQRC+rii2Wx4/Ec2rH53bsmq8cDU8djx8HRrK4PUALHevxxDAcof+8U+YSeCjqJb
	VSP/7CH/e6WvXkYRJikZws0EVQ/f+qyFaRrrY
X-Google-Smtp-Source: AGHT+IFbZzzXIZYRmNVttFy6UZkVLmONQDN5/oxjc1R4rO6jeaovt23EuVBiRT3lHV9syJ/ZBBw/dg==
X-Received: by 2002:a5d:5f54:0:b0:3a4:cb4f:ac2a with SMTP id ffacd0b85a97d-3a51d935a05mr2296824f8f.21.1749040153247;
        Wed, 04 Jun 2025 05:29:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:fef9:cf1c:18f:2ab8? ([2a01:e0a:3d9:2080:fef9:cf1c:18f:2ab8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f8ed32sm196056845e9.1.2025.06.04.05.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 05:29:12 -0700 (PDT)
Message-ID: <1f6bcfb1-80f4-4ff0-8dcc-8fc9c3b9d2fd@linaro.org>
Date: Wed, 4 Jun 2025 14:29:12 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/2] MAINTAINERS: Update the e-mail address of Manivannan
 Sadhasivam
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20250604120833.32791-1-manivannan.sadhasivam@linaro.org>
 <20250604120833.32791-2-manivannan.sadhasivam@linaro.org>
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
In-Reply-To: <20250604120833.32791-2-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/06/2025 14:08, Manivannan Sadhasivam wrote:
> My Linaro email is going to bounce soon, so switch to the kernel.org alias.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   MAINTAINERS | 38 +++++++++++++++++++-------------------
>   1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 690e48c20fb5..f39b6fca3ab8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2102,7 +2102,7 @@ F:	arch/arm/plat-*/
>   
>   ARM/ACTIONS SEMI ARCHITECTURE
>   M:	Andreas Färber <afaerber@suse.de>
> -M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +M:	Manivannan Sadhasivam <mani@kernel.org>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   L:	linux-actions@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
> @@ -2354,7 +2354,7 @@ F:	arch/arm/boot/dts/intel/axm/
>   F:	arch/arm/mach-axxia/
>   
>   ARM/BITMAIN ARCHITECTURE
> -M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +M:	Manivannan Sadhasivam <mani@kernel.org>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/arm/bitmain.yaml
> @@ -3022,7 +3022,7 @@ F:	include/linux/soc/qcom/
>   F:	include/soc/qcom/
>   
>   ARM/RDA MICRO ARCHITECTURE
> -M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +M:	Manivannan Sadhasivam <mani@kernel.org>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   L:	linux-unisoc@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
> @@ -3725,7 +3725,7 @@ F:	Documentation/admin-guide/aoe/
>   F:	drivers/block/aoe/
>   
>   ATC260X PMIC MFD DRIVER
> -M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +M:	Manivannan Sadhasivam <mani@kernel.org>
>   M:	Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
>   L:	linux-actions@lists.infradead.org
>   S:	Maintained
> @@ -6730,7 +6730,7 @@ S:	Orphan
>   F:	drivers/mtd/nand/raw/denali*
>   
>   DESIGNWARE EDMA CORE IP DRIVER
> -M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +M:	Manivannan Sadhasivam <mani@kernel.org>
>   L:	dmaengine@vger.kernel.org
>   S:	Maintained
>   F:	drivers/dma/dw-edma/
> @@ -8546,7 +8546,7 @@ S:	Maintained
>   F:	drivers/edac/pnd2_edac.[ch]
>   
>   EDAC-QCOM
> -M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +M:	Manivannan Sadhasivam <mani@kernel.org>
>   L:	linux-arm-msm@vger.kernel.org
>   L:	linux-edac@vger.kernel.org
>   S:	Maintained
> @@ -14702,7 +14702,7 @@ F:	drivers/hid/hid-mcp2221.c
>   
>   MCP251XFD SPI-CAN NETWORK DRIVER
>   M:	Marc Kleine-Budde <mkl@pengutronix.de>
> -M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +M:	Manivannan Sadhasivam <mani@kernel.org>
>   R:	Thomas Kopp <thomas.kopp@microchip.com>
>   L:	linux-can@vger.kernel.org
>   S:	Maintained
> @@ -15849,7 +15849,7 @@ F:	arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
>   F:	arch/arm64/boot/dts/marvell/armada-3720-uDPU.*
>   
>   MHI BUS
> -M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +M:	Manivannan Sadhasivam <mani@kernel.org>
>   L:	mhi@lists.linux.dev
>   L:	linux-arm-msm@vger.kernel.org
>   S:	Maintained
> @@ -18752,7 +18752,7 @@ F:	drivers/pci/controller/dwc/pci-exynos.c
>   
>   PCI DRIVER FOR SYNOPSYS DESIGNWARE
>   M:	Jingoo Han <jingoohan1@gmail.com>
> -M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +M:	Manivannan Sadhasivam <mani@kernel.org>
>   L:	linux-pci@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> @@ -18787,7 +18787,7 @@ F:	Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
>   F:	drivers/pci/controller/pcie-xilinx-cpm.c
>   
>   PCI ENDPOINT SUBSYSTEM
> -M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +M:	Manivannan Sadhasivam <mani@kernel.org>
>   M:	Krzysztof Wilczyński <kw@linux.com>
>   R:	Kishon Vijay Abraham I <kishon@kernel.org>
>   L:	linux-pci@vger.kernel.org
> @@ -18840,7 +18840,7 @@ F:	drivers/pci/controller/pci-xgene-msi.c
>   PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
>   M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
>   M:	Krzysztof Wilczyński <kw@linux.com>
> -M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +M:	Manivannan Sadhasivam <mani@kernel.org>
>   R:	Rob Herring <robh@kernel.org>
>   L:	linux-pci@vger.kernel.org
>   S:	Supported
> @@ -18997,7 +18997,7 @@ F:	Documentation/devicetree/bindings/pci/microchip*
>   F:	drivers/pci/controller/plda/*microchip*
>   
>   PCIE DRIVER FOR QUALCOMM MSM
> -M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +M:	Manivannan Sadhasivam <mani@kernel.org>
>   L:	linux-pci@vger.kernel.org
>   L:	linux-arm-msm@vger.kernel.org
>   S:	Maintained
> @@ -19033,7 +19033,7 @@ F:	Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
>   F:	drivers/pci/controller/plda/pcie-starfive.c
>   
>   PCIE ENDPOINT DRIVER FOR QUALCOMM
> -M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +M:	Manivannan Sadhasivam <mani@kernel.org>
>   L:	linux-pci@vger.kernel.org
>   L:	linux-arm-msm@vger.kernel.org
>   S:	Maintained
> @@ -20154,7 +20154,7 @@ F:	drivers/iommu/arm/arm-smmu/arm-smmu-qcom*
>   F:	drivers/iommu/msm_iommu*
>   
>   QUALCOMM IPC ROUTER (QRTR) DRIVER
> -M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +M:	Manivannan Sadhasivam <mani@kernel.org>
>   L:	linux-arm-msm@vger.kernel.org
>   S:	Maintained
>   F:	include/trace/events/qrtr.h
> @@ -20162,7 +20162,7 @@ F:	include/uapi/linux/qrtr.h
>   F:	net/qrtr/
>   
>   QUALCOMM IPCC MAILBOX DRIVER
> -M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +M:	Manivannan Sadhasivam <mani@kernel.org>
>   L:	linux-arm-msm@vger.kernel.org
>   S:	Supported
>   F:	Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> @@ -20196,7 +20196,7 @@ F:	Documentation/devicetree/bindings/media/qcom,*-iris.yaml
>   F:	drivers/media/platform/qcom/iris/
>   
>   QUALCOMM NAND CONTROLLER DRIVER
> -M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +M:	Manivannan Sadhasivam <mani@kernel.org>
>   L:	linux-mtd@lists.infradead.org
>   L:	linux-arm-msm@vger.kernel.org
>   S:	Maintained
> @@ -22731,7 +22731,7 @@ F:	Documentation/devicetree/bindings/media/i2c/sony,imx283.yaml
>   F:	drivers/media/i2c/imx283.c
>   
>   SONY IMX290 SENSOR DRIVER
> -M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +M:	Manivannan Sadhasivam <mani@kernel.org>
>   L:	linux-media@vger.kernel.org
>   S:	Maintained
>   T:	git git://linuxtv.org/media.git
> @@ -22740,7 +22740,7 @@ F:	drivers/media/i2c/imx290.c
>   
>   SONY IMX296 SENSOR DRIVER
>   M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> -M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +M:	Manivannan Sadhasivam <mani@kernel.org>
>   L:	linux-media@vger.kernel.org
>   S:	Maintained
>   T:	git git://linuxtv.org/media.git
> @@ -25041,7 +25041,7 @@ S:	Maintained
>   F:	drivers/ufs/host/ufs-mediatek*
>   
>   UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER QUALCOMM HOOKS
> -M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +M:	Manivannan Sadhasivam <mani@kernel.org>
>   L:	linux-arm-msm@vger.kernel.org
>   L:	linux-scsi@vger.kernel.org
>   S:	Maintained

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

