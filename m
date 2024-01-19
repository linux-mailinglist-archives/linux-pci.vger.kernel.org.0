Return-Path: <linux-pci+bounces-2337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6089D83258A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 09:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF520281D2B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 08:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CB41D684;
	Fri, 19 Jan 2024 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GCiUmNiH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF19DDC5
	for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705652233; cv=none; b=Unu6yD8c2bPaArL/C0bhLlr2v04C+VjPctJorrSFZmOETneAEzIAGlHuf+CyLpLd68mmJKe12raCyrK+rlZI5BCj6amgNHqZPd34wRn/gCPiUoCt6lOUnY1ulVXKeD8gi1tDAsfoPzkK0e3iJlJjGpG5gQ+B8T+wcM3J7H/xPYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705652233; c=relaxed/simple;
	bh=oKKbj+jvfOiHePyNHPvlPksDgVHym+JYEXU4x7rTGMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoMyFUQ+vYiYchBBQU3Ex59rr4QLtMGWA5tzYM8zb4g1KdJRvo2ipAl6cuJ/AjpHXc9FcqPDL6vLaMmLTD5E6N5C0H4o4aLLETnss1TT3rwbvsjU3RbXzXO5zEmt5mpcl+SdU6ABUls3DHTr5JMFrSF+uduuCgOao3+jT5BtK4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GCiUmNiH; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso359443a12.0
        for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 00:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705652231; x=1706257031; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CKeQxr74v0/RAxO8TgttZrcsw2Yx0+jcWvQmI1Qe2Zw=;
        b=GCiUmNiHqUl724sarO7rz1kosw2/m9Vmq+DUpQv/gfja+Frk0tGcgM8ybrfERKzSTL
         szei/DpG+JN6B1gTo8IitHYfHmGVRm2nA+UaGKuaE309WPj5NzuZSDK/v0QKRHBJnd4Z
         eZoo2tWQIXpRfPwwhcrAW+rM7TBz+dCkh0OaSeAhghhWQUuEaZC1X+lv4qbxRIySPV1b
         8BUH5zsjlmQX7lGPYD9TycxFNFuQ5k0mPeZF9ufiPg8Ubb4sV3vxlT8tUHDt/EqKcHTw
         kFuHacbvPO8poDCMCgzh6+/hiNay0Z6hGrAsapsRpOFaSE2gSh//zfIb37mF23+L4824
         Uc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705652231; x=1706257031;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CKeQxr74v0/RAxO8TgttZrcsw2Yx0+jcWvQmI1Qe2Zw=;
        b=Es2COxhzY5Nw2EuLiGmQdpcK6xMkd3LivrwjaadDUsaG/MF5AA+ttUbnqCH8NF8vOP
         JSbdyJi/egZKHB5g/1c7crNppFm0/mzdNcgmpr631KYDg3uKW4u4YA92fJuCvTF/Bwu3
         lRyQGHZjaCPxZDRmCUnKia7O0Jsn/wN7YL/MsIs0cONiKDrsiwafq3nvrsz0w822WnfT
         N7DntGqS48IX2z3X4gSQa9seIlkujTp1PO/ZJFAqlWmwPMhohb4y+CXRmaGZ89SQi8yl
         Y4hs/KvERfGe4m0jcePUwzU23neDjd9PZGH/68npsYwovZZU7qO/swXMbgrQxxGJ+Ou1
         v43A==
X-Gm-Message-State: AOJu0YxMOVpQbKKiDJ8QGGp9WwFZcwD4E4Fx7mJhQReNvOkTlBu1ef5O
	TWAUh7VgCpb95B7HKoB8T6y46SI6VU3Jg4IHWYX/kiJuaW+BzEDN/Q9t2Z7Q1g==
X-Google-Smtp-Source: AGHT+IGS5Ltk1U1ZHIZAH9/TpF9urtmkWgrvxjyopbIMgOLF9edEyr5g7jMcF0En2+zgNlJcEzObqA==
X-Received: by 2002:a05:6a20:7fa4:b0:19a:21b8:ab6a with SMTP id d36-20020a056a207fa400b0019a21b8ab6amr2476870pzj.27.1705652230687;
        Fri, 19 Jan 2024 00:17:10 -0800 (PST)
Received: from thinkpad ([117.248.2.56])
        by smtp.gmail.com with ESMTPSA id fb30-20020a056a002d9e00b006d9af8c25easm4506321pfb.84.2024.01.19.00.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 00:17:10 -0800 (PST)
Date: Fri, 19 Jan 2024 13:47:00 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: krzysztof.kozlowski@linaro.org, bhelgaas@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev,
	kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: Re: [PATCH v8 01/16] PCI: imx6: Simplify clock handling by using
 clk_bulk*() function
Message-ID: <20240119081700.GD2866@thinkpad>
References: <20240108232145.2116455-1-Frank.Li@nxp.com>
 <20240108232145.2116455-2-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240108232145.2116455-2-Frank.Li@nxp.com>

On Mon, Jan 08, 2024 at 06:21:30PM -0500, Frank Li wrote:
> Refector the clock handling logic. Add 'clk_names' define in drvdata. Use
> clk_bulk*() api simplify the code.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

One comment below. With that addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> 
> Notes:
>     Change from v7 to v8
>     - update comment message
>     - using ARRAY_SIZE to count clk_names.
>     Change from v6 to v7
>     - none
>     Change from v4 to v5
>     - update commit message
>     - direct using clk name list, instead of macro
>     - still keep caculate clk list count because sizeof return pre allocated
>     array size.
>     
>     Change from v3 to v4
>     - using clk_bulk_*() API
>     Change from v1 to v3
>     - none
>     
>     Change from v4 to v5
>     - update commit message
>     - direct using clk name list, instead of macro
>     - still keep caculate clk list count because sizeof return pre allocated
>     array size.
>     
>     Change from v3 to v4
>     - using clk_bulk_*() API
>     Change from v1 to v3
>     - none
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 144 ++++++++++----------------
>  1 file changed, 54 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 74703362aeec7..4912c6b08ecf8 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c

[...]

>  
> +static const char * const
> +imx6_3clks_bus_pcie_phy[] = {"pcie_bus", "pcie", "pcie_phy"};
> +static const char * const
> +imx6_3clks_bus_pcie_aux[] = {"pcie_bus", "pcie", "pcie_aux"};
> +static const char * const
> +imx6_4clks_bus_pcie_phy_aux[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
> +static const char * const
> +imx6_4clks_bus_pcie_phy_axi[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"};
> +

Use platform names for defining the array. Like,

imx6q_clks[]
imx6sx_clks[]
imx8mq_clks[]
imx8mm_clks[]

and reuse them for other platforms as well. This gives an idea of how the clocks
got inherited from some base platforms.

- Mani

>  static const struct imx6_pcie_drvdata drvdata[] = {
>  	[IMX6Q] = {
>  		.variant = IMX6Q,
> @@ -1477,6 +1421,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
>  		.dbi_length = 0x200,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
> +		.clk_names = imx6_3clks_bus_pcie_phy,
> +		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_phy),
>  	},
>  	[IMX6SX] = {
>  		.variant = IMX6SX,
> @@ -1484,6 +1430,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
>  			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
> +		.clk_names = imx6_4clks_bus_pcie_phy_axi,
> +		.clks_cnt = ARRAY_SIZE(imx6_4clks_bus_pcie_phy_axi),
>  	},
>  	[IMX6QP] = {
>  		.variant = IMX6QP,
> @@ -1492,40 +1440,56 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.dbi_length = 0x200,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
> +		.clk_names = imx6_3clks_bus_pcie_phy,
> +		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_phy),
>  	},
>  	[IMX7D] = {
>  		.variant = IMX7D,
>  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx7d-iomuxc-gpr",
> +		.clk_names = imx6_3clks_bus_pcie_phy,
> +		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_phy),
>  	},
>  	[IMX8MQ] = {
>  		.variant = IMX8MQ,
>  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> +		.clk_names = imx6_4clks_bus_pcie_phy_aux,
> +		.clks_cnt = ARRAY_SIZE(imx6_4clks_bus_pcie_phy_aux),
>  	},
>  	[IMX8MM] = {
>  		.variant = IMX8MM,
>  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> +		.clk_names = imx6_3clks_bus_pcie_aux,
> +		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_aux),
>  	},
>  	[IMX8MP] = {
>  		.variant = IMX8MP,
>  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> +		.clk_names = imx6_3clks_bus_pcie_aux,
> +		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_aux),
>  	},
>  	[IMX8MQ_EP] = {
>  		.variant = IMX8MQ_EP,
>  		.mode = DW_PCIE_EP_TYPE,
>  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> +		.clk_names = imx6_4clks_bus_pcie_phy_aux,
> +		.clks_cnt = ARRAY_SIZE(imx6_4clks_bus_pcie_phy_aux),
>  	},
>  	[IMX8MM_EP] = {
>  		.variant = IMX8MM_EP,
>  		.mode = DW_PCIE_EP_TYPE,
>  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> +		.clk_names = imx6_3clks_bus_pcie_aux,
> +		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_aux),
>  	},
>  	[IMX8MP_EP] = {
>  		.variant = IMX8MP_EP,
>  		.mode = DW_PCIE_EP_TYPE,
>  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> +		.clk_names = imx6_3clks_bus_pcie_aux,
> +		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_aux),
>  	},
>  };
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

