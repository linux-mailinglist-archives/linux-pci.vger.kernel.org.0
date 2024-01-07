Return-Path: <linux-pci+bounces-1741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 473B18262BF
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 04:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93FC21F21B6F
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 03:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B8110A17;
	Sun,  7 Jan 2024 03:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b835g1Q5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A1910A05
	for <linux-pci@vger.kernel.org>; Sun,  7 Jan 2024 03:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28ceef21be2so372327a91.3
        for <linux-pci@vger.kernel.org>; Sat, 06 Jan 2024 19:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704596578; x=1705201378; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4snqkhUuEW8ZG394EttlpuQ67DH0d6MbBqMG4Ly3wkQ=;
        b=b835g1Q5/8DkxOxdvyY3hZXXFBor5jw2PhT6dORGIKCLB1fAczvq/IBiNVl3gd//OA
         x1rQFohR+wU1ar0L1Lxmwy7XhEx0NebKD8bUCRM2IhZffMFXSIQThcudCwzk6Vzxmf46
         06v9bxHxduDs4Qd7g//Mn8Gkvkbxx3k87uSJNy45u50HFmooLw69QKswN6/DWyxEeHXo
         9P5WEiSeHQVzYD1rc7iwCyMp7NwEehv0jWGL6Sn+0LNUX86QT+4lJqaIocbtT72xcaqN
         iE8rKr1/dsKDDCh/1/TpLKEuuQu7w8Sls0UUOx4g/jKiRIgJJgpZngoA6NILtmYKxE/G
         7DEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704596578; x=1705201378;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4snqkhUuEW8ZG394EttlpuQ67DH0d6MbBqMG4Ly3wkQ=;
        b=Du/EsfyLrs8S/1GrJA/E8Sjp7YjGQ4lWAnGnz1KLnurWV26FCuiBFJckHSjB4ZkWKv
         M9H0Wr0JlVUh90vpw7NwhLLJumKztPIc4o1n1sKQz/FjG8+9jZAxGmJ5WZ8o76lkGfkF
         gITW7Hrc3f8c7rCvgHpfuG9S6zk89llPvqIpWLyCsR74FrwcgKRmcJtX/Rtoyi5STA1C
         ko3LblexYgIo071BvIdSIwfHWdXz71gbutEbJeN4cJqRcC7Bn6FLhRQcObaZ2KDxYZSe
         7DHFXnvhj1+nKGTxdIbtCvplvqtKZ7YXdU4e1b4AyiIkMPNesFcZIgcE744pANaq0WSV
         9SjA==
X-Gm-Message-State: AOJu0YzQmJZmEfMxlhvYs2hojeFRW9o1Pb+ATVIr21VVPAEzuc4Wrpcg
	M6HLQcoytRr/kcUBUq/sK+lNAgVoRsMk
X-Google-Smtp-Source: AGHT+IFWNyeYcLOxjx7kAt+wXSssgse708DUrf3+R7FincnxfWyy3UrvW3wRM0k+wcgdhEKojCyxOg==
X-Received: by 2002:a05:6a20:a89a:b0:199:a10e:13e5 with SMTP id ca26-20020a056a20a89a00b00199a10e13e5mr5093pzb.43.1704596578093;
        Sat, 06 Jan 2024 19:02:58 -0800 (PST)
Received: from thinkpad ([103.197.115.97])
        by smtp.gmail.com with ESMTPSA id jb19-20020a170903259300b001d4bcf6cc43sm3707804plb.81.2024.01.06.19.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 19:02:57 -0800 (PST)
Date: Sun, 7 Jan 2024 08:32:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: krzysztof.kozlowski@linaro.org, bhelgaas@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev,
	kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: Re: [PATCH v7 01/16] PCI: imx6: Simplify clock handling by using
 bulk_clk_*() function
Message-ID: <20240107030247.GA3416@thinkpad>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-2-Frank.Li@nxp.com>
 <20240106152708.GD2512@thinkpad>
 <ZZmEY5d6IRcCZjl7@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZZmEY5d6IRcCZjl7@lizhi-Precision-Tower-5810>

On Sat, Jan 06, 2024 at 11:48:35AM -0500, Frank Li wrote:
> On Sat, Jan 06, 2024 at 08:57:08PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Dec 27, 2023 at 01:27:12PM -0500, Frank Li wrote:
> > 
> > Subject mentions, 'bulk_clk' APIs but there is no such thing. It should be
> > 'clk_bulk()' APIs.
> > 
> > > Refactors the clock handling logic. Adds clk_names[] define in drvdata.
> > > Using clk_bulk*() api simplifies the code.
> > > 
> > 
> > I've mentioned this many times in the past. But let me reiterate here again:
> > 
> > Commit message should be in imperative mood as per Linux Kernel rules for
> > submitting patches. Please see here:
> > Documentation/process/submitting-patches.rst
> > 
> > The relevant part is:
> > 
> > "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
> > instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
> > to do frotz", as if you are giving orders to the codebase to change
> > its behaviour."
> > 
> > Please use this same format for rest of the patches as well for future ones.
> 
> I may have not understand *imperative mode*. Asked an English native
> speaker. Do you menas
> 
> *Refector* the clock handling logic. *Add* clk_names[] define in drvdata.
> *Use* clk_bulk*() api *simplify* the code.

Yes!

> 
> > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > 
> > > Notes:
> > >     Change from v4 to v5
> > >     - update commit message
> > >     - direct using clk name list, instead of macro
> > >     - still keep caculate clk list count because sizeof return pre allocated
> > >     array size.
> > >     
> > >     Change from v3 to v4
> > >     - using clk_bulk_*() API
> > >     Change from v1 to v3
> > >     - none
> > > 
> > >  drivers/pci/controller/dwc/pci-imx6.c | 125 ++++++++------------------
> > >  1 file changed, 35 insertions(+), 90 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 74703362aeec7..50d9faaa17f71 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c

[...]

> > >  
> > > -	/* Fetch clocks */
> > > -	imx6_pcie->pcie_bus = devm_clk_get(dev, "pcie_bus");
> > > -	if (IS_ERR(imx6_pcie->pcie_bus))
> > > -		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_bus),
> > > -				     "pcie_bus clock source missing or invalid\n");
> > > +	while (imx6_pcie->drvdata->clk_names[imx6_pcie->clks_cnt]) {
> > > +		int i = imx6_pcie->clks_cnt;
> > 
> > Why can't you initialize i to 0 directly?
> 
> can't init i to 0 directly here, otherwise next loop i will not increase.
> i just reduce refer imx6_pcie->clks_cnt in 
> 
> imx6_pcie->clks[i].id = imx6_pcie->drvdata->clk_names[i];
> 

Wait... Can't you just use ARRAY_SIZE() to calculate the clks_cnt statically?

Like,

	static const char * const imx8_clk_names[] = {
		"pcie_bus", "pcie", "pcie_aux",
	};

	[...]

		.clk_names = imx8_clk_names,
		.clks_cnt = ARRAY_SIZE(imx8_clk_names),

You can use the same clk_names array for multiple SoCs if the clocks are same.
I should've mentioned this in last review itself. Sorry about that.

- Mani

> Frank
> 
> > 
> > Rest looks good to me.
> > 
> > - Mani
> > 
> > > +
> > > +		imx6_pcie->clks[i].id = imx6_pcie->drvdata->clk_names[i];
> > > +		imx6_pcie->clks_cnt++;
> > > +	}
> > >  
> > > -	imx6_pcie->pcie = devm_clk_get(dev, "pcie");
> > > -	if (IS_ERR(imx6_pcie->pcie))
> > > -		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie),
> > > -				     "pcie clock source missing or invalid\n");
> > > +	/* Fetch clocks */
> > > +	ret = devm_clk_bulk_get(dev, imx6_pcie->clks_cnt, imx6_pcie->clks);
> > > +	if (ret)
> > > +		return ret;
> > >  
> > >  	switch (imx6_pcie->drvdata->variant) {
> > > -	case IMX6SX:
> > > -		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
> > > -							   "pcie_inbound_axi");
> > > -		if (IS_ERR(imx6_pcie->pcie_inbound_axi))
> > > -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_inbound_axi),
> > > -					     "pcie_inbound_axi clock missing or invalid\n");
> > > -		break;
> > > -	case IMX8MQ:
> > > -	case IMX8MQ_EP:
> > > -		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
> > > -		if (IS_ERR(imx6_pcie->pcie_aux))
> > > -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
> > > -					     "pcie_aux clock source missing or invalid\n");
> > > -		fallthrough;
> > >  	case IMX7D:
> > >  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > >  			imx6_pcie->controller_id = 1;
> > > @@ -1353,10 +1300,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> > >  	case IMX8MM_EP:
> > >  	case IMX8MP:
> > >  	case IMX8MP_EP:
> > > -		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
> > > -		if (IS_ERR(imx6_pcie->pcie_aux))
> > > -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
> > > -					     "pcie_aux clock source missing or invalid\n");
> > >  		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
> > >  									 "apps");
> > >  		if (IS_ERR(imx6_pcie->apps_reset))
> > > @@ -1372,14 +1315,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> > >  	default:
> > >  		break;
> > >  	}
> > > -	/* Don't fetch the pcie_phy clock, if it has abstract PHY driver */
> > > -	if (imx6_pcie->phy == NULL) {
> > > -		imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");
> > > -		if (IS_ERR(imx6_pcie->pcie_phy))
> > > -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_phy),
> > > -					     "pcie_phy clock source missing or invalid\n");
> > > -	}
> > > -
> > >  
> > >  	/* Grab turnoff reset */
> > >  	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
> > > @@ -1477,6 +1412,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> > >  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
> > >  		.dbi_length = 0x200,
> > >  		.gpr = "fsl,imx6q-iomuxc-gpr",
> > > +		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
> > >  	},
> > >  	[IMX6SX] = {
> > >  		.variant = IMX6SX,
> > > @@ -1484,6 +1420,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> > >  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
> > >  			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> > >  		.gpr = "fsl,imx6q-iomuxc-gpr",
> > > +		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"},
> > >  	},
> > >  	[IMX6QP] = {
> > >  		.variant = IMX6QP,
> > > @@ -1492,40 +1429,48 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> > >  			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> > >  		.dbi_length = 0x200,
> > >  		.gpr = "fsl,imx6q-iomuxc-gpr",
> > > +		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
> > >  	},
> > >  	[IMX7D] = {
> > >  		.variant = IMX7D,
> > >  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> > >  		.gpr = "fsl,imx7d-iomuxc-gpr",
> > > +		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
> > >  	},
> > >  	[IMX8MQ] = {
> > >  		.variant = IMX8MQ,
> > >  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> > > +		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
> > >  	},
> > >  	[IMX8MM] = {
> > >  		.variant = IMX8MM,
> > >  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> > >  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> > > +		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> > >  	},
> > >  	[IMX8MP] = {
> > >  		.variant = IMX8MP,
> > >  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> > >  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> > > +		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> > >  	},
> > >  	[IMX8MQ_EP] = {
> > >  		.variant = IMX8MQ_EP,
> > >  		.mode = DW_PCIE_EP_TYPE,
> > >  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> > > +		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
> > >  	},
> > >  	[IMX8MM_EP] = {
> > >  		.variant = IMX8MM_EP,
> > >  		.mode = DW_PCIE_EP_TYPE,
> > >  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> > > +		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> > >  	},
> > >  	[IMX8MP_EP] = {
> > >  		.variant = IMX8MP_EP,
> > >  		.mode = DW_PCIE_EP_TYPE,
> > >  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> > > +		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> > >  	},
> > >  };
> > >  
> > > -- 
> > > 2.34.1
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

