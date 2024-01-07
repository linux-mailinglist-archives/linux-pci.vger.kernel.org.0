Return-Path: <linux-pci+bounces-1742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A618E8262C4
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 04:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DFDB1C212D7
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 03:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE89111A4;
	Sun,  7 Jan 2024 03:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="trsqn+69"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6631118F
	for <linux-pci@vger.kernel.org>; Sun,  7 Jan 2024 03:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36071f2181cso5319485ab.2
        for <linux-pci@vger.kernel.org>; Sat, 06 Jan 2024 19:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704596665; x=1705201465; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7sp8lR8fVruy7aXHQIvUQeGshhQgsSFVGSZnezGwNmY=;
        b=trsqn+69/KBjyv6kERwrkPT0Gwa34PZhazAJhGY/OKP2mmsVMb6TYsCNfkCugxV2EV
         8KaCDs0yBB/2s6ax5zqVhYEEq83kQ1R7o2o+t6qBTi01qi8Fz81Nu0sB5UHmiPQbnvIQ
         IkRDq9M60ZkyMw5/Ts4YMxILB5eAZ1Lx6zUcN+gfEIK1CocABD/7oYsLrc51R4vH2LJC
         pO1Hndme0VJxQf868mzVKio1PbVT/aNHLmzgsfkTO3NQs8Ys0KPNNCCyYNmfsnZ/ZI3L
         8ZpYm1svvF4U3O4KSZ6WKoSQfE0Z7uE1M4lCN58vAdD96VJjkqlkP4v9DG8nbu4YLYrL
         pCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704596665; x=1705201465;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sp8lR8fVruy7aXHQIvUQeGshhQgsSFVGSZnezGwNmY=;
        b=Pa70UKgbcaMgR6+S4HNOWYUwdvxuNT9yUsyyJdS/MzxnH2UJelfVC2Vo/KlAldcrrG
         Sb5qR8FSgV7GuzDklf/YghCNk6AhZSgAGV0UYMPClNRKVn75lwJ8zAsuM/dX3i5tBSxo
         xKGmauCesUOqLi/bBbehEu7AOz1hj7VFIeIPs0uH38dezISgop1UA6lxOUIlysB/YEqa
         HyyIvQb4d/+LgBDaobMmSz6MId7pITuxZswUWEFuOjxYqdl1QEqiEkCffI2yp1qGzPgk
         wl9PtlG6R9KNfe3QZSuVUo+tnLIMVwsdmSIHLIIs/gdmD53Q4BbyF0nDa++9Ekp6C2MZ
         5E9g==
X-Gm-Message-State: AOJu0Ywmv00KspnDBMmYKR0pQdknFtwZc6+HUOjB0aKjaG4CRd/47VvZ
	P9ZLCQvDAFRQF9KNSRvxu99/it2R2q8H
X-Google-Smtp-Source: AGHT+IHsUozNDbBUGhK/kPkGuJeGxcsOSl6NPAeIm7KmHBeMpMshWboxNlelX33jnj6MU0MpT+m+kg==
X-Received: by 2002:a05:6e02:32c3:b0:35f:ff8c:7a31 with SMTP id bl3-20020a056e0232c300b0035fff8c7a31mr3406835ilb.65.1704596665631;
        Sat, 06 Jan 2024 19:04:25 -0800 (PST)
Received: from thinkpad ([103.197.115.97])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709029a9600b001d35223d0besm3675636plp.251.2024.01.06.19.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 19:04:25 -0800 (PST)
Date: Sun, 7 Jan 2024 08:34:18 +0530
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
Subject: Re: [PATCH v7 02/16] PCI: imx6: Simplify phy handling by using by
 using IMX6_PCIE_FLAG_HAS_PHY
Message-ID: <20240107030418.GB3416@thinkpad>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-3-Frank.Li@nxp.com>
 <20240106153323.GE2512@thinkpad>
 <ZZmE1NV6ShVBm5FU@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZZmE1NV6ShVBm5FU@lizhi-Precision-Tower-5810>

On Sat, Jan 06, 2024 at 11:50:28AM -0500, Frank Li wrote:
> On Sat, Jan 06, 2024 at 09:03:23PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Dec 27, 2023 at 01:27:13PM -0500, Frank Li wrote:
> > > Refactors the phy handling logic in the imx6 PCI driver by adding
> > > IMX6_PCIE_FLAG_HAS_PHY bitmask define for drvdata::flags.
> > > 
> > > The drvdata::flags and a bitmask ensures a cleaner and more scalable
> > > switch-case structure for handling phy.
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > 
> > > Notes:
> > >     Change from v4 to v5:
> > >     - none, Keep IMX6_PCIE_FLAG_HAS_PHY to indicate dts mismatch when platform
> > >     require phy suppport.
> > >     
> > >     Change from v1 to v3:
> > >     - none
> > > 
> > >  drivers/pci/controller/dwc/pci-imx6.c | 23 ++++++++++++++++-------
> > >  1 file changed, 16 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 50d9faaa17f71..4d620249f3d52 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -60,6 +60,9 @@ enum imx6_pcie_variants {
> > >  #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
> > >  #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
> > >  #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
> > > +#define IMX6_PCIE_FLAG_HAS_PHY			BIT(3)
> > 
> > Every PCIe setup requires PHY for its operation. Perhaps you are referring to
> > external PHY? If so, please rename this to IMX6_PCIE_FLAG_HAS_EXT_PHY.
> 
> Actually, it means use phy driver. How about using IMX6_PCIE_HAS_PHYDRV?
> 

Ah, ok. Yes, this makes sense.

- Mani

> > 
> > > +
> > > +#define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
> > >  
> > >  #define IMX6_PCIE_MAX_CLKS       6
> > >  
> > > @@ -1277,6 +1280,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHY)) {
> > 
> > IMO, we would not need these kind of checks in the driver if the DT binding is
> > properly validated using schema. But folks always want to validate "broken DT"
> > in the drivers :(
> > 
> > But I'm fine with this check for now since not everyone agree with above.
> > 
> > - Mani
> > 
> > > +		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
> > > +		if (IS_ERR(imx6_pcie->phy))
> > > +			return dev_err_probe(dev, PTR_ERR(imx6_pcie->phy),
> > > +					     "failed to get pcie phy\n");
> > > +	}
> > > +
> > >  	switch (imx6_pcie->drvdata->variant) {
> > >  	case IMX7D:
> > >  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > > @@ -1306,11 +1316,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> > >  			return dev_err_probe(dev, PTR_ERR(imx6_pcie->apps_reset),
> > >  					     "failed to get pcie apps reset control\n");
> > >  
> > > -		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
> > > -		if (IS_ERR(imx6_pcie->phy))
> > > -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->phy),
> > > -					     "failed to get pcie phy\n");
> > > -
> > >  		break;
> > >  	default:
> > >  		break;
> > > @@ -1444,13 +1449,15 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> > >  	},
> > >  	[IMX8MM] = {
> > >  		.variant = IMX8MM,
> > > -		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> > > +		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
> > > +			 IMX6_PCIE_FLAG_HAS_PHY,
> > >  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> > >  		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> > >  	},
> > >  	[IMX8MP] = {
> > >  		.variant = IMX8MP,
> > > -		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> > > +		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
> > > +			 IMX6_PCIE_FLAG_HAS_PHY,
> > >  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> > >  		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> > >  	},
> > > @@ -1462,12 +1469,14 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> > >  	},
> > >  	[IMX8MM_EP] = {
> > >  		.variant = IMX8MM_EP,
> > > +		.flags = IMX6_PCIE_FLAG_HAS_PHY,
> > >  		.mode = DW_PCIE_EP_TYPE,
> > >  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> > >  		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> > >  	},
> > >  	[IMX8MP_EP] = {
> > >  		.variant = IMX8MP_EP,
> > > +		.flags = IMX6_PCIE_FLAG_HAS_PHY,
> > >  		.mode = DW_PCIE_EP_TYPE,
> > >  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> > >  		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> > > -- 
> > > 2.34.1
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

