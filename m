Return-Path: <linux-pci+bounces-1755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC3B826308
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 06:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789CE1F217CD
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 05:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E5D8BFE;
	Sun,  7 Jan 2024 05:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O3HNTsqB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222B911CBB
	for <linux-pci@vger.kernel.org>; Sun,  7 Jan 2024 05:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-204a16df055so788399fac.0
        for <linux-pci@vger.kernel.org>; Sat, 06 Jan 2024 21:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704605757; x=1705210557; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r/6veTlb3b926dnqCGkB7UbG60YqZdxmlPhte48QgzE=;
        b=O3HNTsqBVmOw17byi/3AfjELWYFYqdw3lF9jnXBnlbZkYKz2T9I2gBUZZpRk0IX65+
         MRFKgdKA+gxR/gTqjVnVs6gKec0ln3WpREZ3/BfqDtJvUo7N/A7mQ2JqfWTgzUtcB6yF
         AH71+QX72LoLvaHfiav9T1eMUlxEtQMrghB7Hhhg5KquLoPT3lAJa7LHxiQYSAVwW6f+
         do0tIJp1P974GeUd8hB6MZlZyXHpfvG17g2EkM8qqnefd+e8XMGzfUQRwbTi+DpfdgGo
         ZGVmF1rK/RXhdkKT5oqGMelcgVuhzPc3JF+G/Y3X4tZJ/znPR7pEKuQ9gogsxZpCEQwW
         /ZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704605757; x=1705210557;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/6veTlb3b926dnqCGkB7UbG60YqZdxmlPhte48QgzE=;
        b=g0MkYBNVtKtQ2QubPaGk7VRKfagXAe2pPYluWxjTzNzCbY7shOJB/EYd5785vJTbQp
         TFEj8UBP+UAeoBE59BxiAI0gH8mny6nSNu4lMFQ1KN6XqW8JyMP+J+mzXSXYVaB7pbJG
         1dSG2loJGmzWBjoj/7OSOIXxslFnVl0fom+qKR/boynYYrwG4f/iGR7Fsvw7X6mMpLXN
         zal8oNojLJPrc/QZWdxoKyJvNWRkLzI62VdqB+0gQ0OX9Uqdy3qa4erMnnq36gIA2ssG
         8/ej8I3gTOPS5IqdMU1qH0e4RFJd7ck/LPaE1+PCWv/gS//IMQW/vByh3phFCCpYi5L5
         FbMw==
X-Gm-Message-State: AOJu0YwqtXfJCaxR3rIMYhpwnwvh02kI+Ez/3YXVvKvrhp9nMkALUuxi
	sx2ZQPknJg8cHI5EKVsOgKiwlrmhkHyc
X-Google-Smtp-Source: AGHT+IFXc64B6/7sj5HFrrtDScgVdo7dG+eDO48hZml6hX469TEyYIhRL22ervoCQYA10NefWOg3rw==
X-Received: by 2002:a05:6871:7a0e:b0:203:2b71:dad5 with SMTP id pc14-20020a0568717a0e00b002032b71dad5mr2370437oac.8.1704605757126;
        Sat, 06 Jan 2024 21:35:57 -0800 (PST)
Received: from thinkpad ([103.197.115.97])
        by smtp.gmail.com with ESMTPSA id p3-20020a056a0026c300b006da19433468sm3833811pfw.61.2024.01.06.21.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 21:35:56 -0800 (PST)
Date: Sun, 7 Jan 2024 11:05:48 +0530
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
Subject: Re: [PATCH v7 07/16] PCI: imx6: Simplify configure_type() by using
 mode_off and mode_mask
Message-ID: <20240107053548.GK3416@thinkpad>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-8-Frank.Li@nxp.com>
 <20240107051655.GF3416@thinkpad>
 <ZZo3XpYkzxDolK47@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZZo3XpYkzxDolK47@lizhi-Precision-Tower-5810>

On Sun, Jan 07, 2024 at 12:32:14AM -0500, Frank Li wrote:
> On Sun, Jan 07, 2024 at 10:46:55AM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Dec 27, 2023 at 01:27:18PM -0500, Frank Li wrote:
> > > Add drvdata::mode_off and drvdata::mode_mask to simple
> > 
> > simplify
> > 
> > > imx6_pcie_configure_type() logic.
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > 
> > Couple of comments below.
> > 
> > > ---
> > > 
> > > Notes:
> > >     Change from v2 to v3
> > >     - none
> > >     Change from v1 to v2
> > >     - use ffs() to fixe build error.
> > > 
> > >  drivers/pci/controller/dwc/pci-imx6.c | 60 ++++++++++++++++++---------
> > >  1 file changed, 40 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 588bfb616260e..717e8fa030deb 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -68,6 +68,7 @@ enum imx6_pcie_variants {
> > >  
> > >  #define IMX6_PCIE_MAX_CLKS       6
> > >  
> > > +#define IMX6_PCIE_MAX_INSTANCES			2
> > >  struct imx6_pcie_drvdata {
> > >  	enum imx6_pcie_variants variant;
> > >  	enum dw_pcie_device_mode mode;
> > > @@ -77,6 +78,8 @@ struct imx6_pcie_drvdata {
> > >  	const char *clk_names[IMX6_PCIE_MAX_CLKS];
> > >  	const u32 ltssm_off;
> > >  	const u32 ltssm_mask;
> > > +	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
> > > +	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
> > >  };
> > >  
> > >  struct imx6_pcie {
> > > @@ -174,32 +177,25 @@ static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
> > >  
> > >  static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
> > >  {
> > > -	unsigned int mask, val, mode;
> > > +	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
> > > +	unsigned int mask, val, mode, id;
> > >  
> > > -	if (imx6_pcie->drvdata->mode == DW_PCIE_EP_TYPE)
> > > +	if (drvdata->mode == DW_PCIE_EP_TYPE)
> > >  		mode = PCI_EXP_TYPE_ENDPOINT;
> > >  	else
> > >  		mode = PCI_EXP_TYPE_ROOT_PORT;
> > >  
> > > -	switch (imx6_pcie->drvdata->variant) {
> > > -	case IMX8MQ:
> > > -	case IMX8MQ_EP:
> > > -		if (imx6_pcie->controller_id == 1) {
> > > -			mask = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE;
> > > -			val  = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
> > > -					  mode);
> > > -		} else {
> > > -			mask = IMX6Q_GPR12_DEVICE_TYPE;
> > > -			val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE, mode);
> > > -		}
> > > -		break;
> > > -	default:
> > > -		mask = IMX6Q_GPR12_DEVICE_TYPE;
> > > -		val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE, mode);
> > > -		break;
> > > -	}
> > > +	id = imx6_pcie->controller_id;
> > > +
> > > +	/* If mode_mask[id] is zero, means each controller have its individual gpr */
> > > +	if (!drvdata->mode_mask[id])
> > > +		id = 0;
> > > +
> > > +	mask = drvdata->mode_mask[id];
> > > +	/* FIELD_PREP mask have been constant */
> > 
> > No need of this comment.
> > 
> > > +	val = mode << (ffs(mask) - 1);
> > >  
> > > -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
> > > +	regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->mode_off[id], mask, val);
> > >  }
> > >  
> > >  static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
> > > @@ -1376,6 +1372,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> > >  		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
> > >  		.ltssm_off = IOMUXC_GPR12,
> > >  		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
> > > +		.mode_off[0] = IOMUXC_GPR12,
> > > +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > >  	},
> > >  	[IMX6SX] = {
> > >  		.variant = IMX6SX,
> > > @@ -1386,6 +1384,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> > >  		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"},
> > >  		.ltssm_off = IOMUXC_GPR12,
> > >  		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
> > > +		.mode_off[0] = IOMUXC_GPR12,
> > > +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > >  	},
> > >  	[IMX6QP] = {
> > >  		.variant = IMX6QP,
> > > @@ -1397,6 +1397,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> > >  		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
> > >  		.ltssm_off = IOMUXC_GPR12,
> > >  		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
> > > +		.mode_off[0] = IOMUXC_GPR12,
> > > +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > >  	},
> > >  	[IMX7D] = {
> > >  		.variant = IMX7D,
> > > @@ -1405,6 +1407,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> > >  			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
> > >  		.gpr = "fsl,imx7d-iomuxc-gpr",
> > >  		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
> > > +		.mode_off[0] = IOMUXC_GPR12,
> > > +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > >  	},
> > >  	[IMX8MQ] = {
> > >  		.variant = IMX8MQ,
> > > @@ -1412,6 +1416,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> > >  			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
> > >  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> > >  		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
> > > +		.mode_off[0] = IOMUXC_GPR12,
> > > +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > > +		.mode_off[1] = IOMUXC_GPR12,
> > > +		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
> > 
> > Is the mode_mask differ between SoCs or fixed based on instances? I mean, if
> > there is a guarantee that it is going to be IMX6Q_GPR12_DEVICE_TYPE for instance
> > 1 and IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE for instance 2 etc...
> > 
> > Then we can avoid these SoC specific config and simplify the code further.
> 
> No, iMX95 will change it. 
> 

Ok, fine then.

- Mani

> Frank
> 
> > 
> > - Mani
> > 
> > >  	},
> > >  	[IMX8MM] = {
> > >  		.variant = IMX8MM,
> > > @@ -1420,6 +1428,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> > >  			 IMX6_PCIE_FLAG_HAS_APP_RESET,
> > >  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> > >  		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> > > +		.mode_off[0] = IOMUXC_GPR12,
> > > +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > >  	},
> > >  	[IMX8MP] = {
> > >  		.variant = IMX8MP,
> > > @@ -1428,6 +1438,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> > >  			 IMX6_PCIE_FLAG_HAS_APP_RESET,
> > >  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> > >  		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> > > +		.mode_off[0] = IOMUXC_GPR12,
> > > +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > >  	},
> > >  	[IMX8MQ_EP] = {
> > >  		.variant = IMX8MQ_EP,
> > > @@ -1436,6 +1448,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> > >  		.mode = DW_PCIE_EP_TYPE,
> > >  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> > >  		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
> > > +		.mode_off[0] = IOMUXC_GPR12,
> > > +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > > +		.mode_off[1] = IOMUXC_GPR12,
> > > +		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
> > >  	},
> > >  	[IMX8MM_EP] = {
> > >  		.variant = IMX8MM_EP,
> > > @@ -1443,6 +1459,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> > >  		.mode = DW_PCIE_EP_TYPE,
> > >  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> > >  		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> > > +		.mode_off[0] = IOMUXC_GPR12,
> > > +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > >  	},
> > >  	[IMX8MP_EP] = {
> > >  		.variant = IMX8MP_EP,
> > > @@ -1450,6 +1468,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> > >  		.mode = DW_PCIE_EP_TYPE,
> > >  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> > >  		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> > > +		.mode_off[0] = IOMUXC_GPR12,
> > > +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
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

