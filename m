Return-Path: <linux-pci+bounces-16824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FFE9CD9AF
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 08:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76821F2320B
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 07:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1CF188015;
	Fri, 15 Nov 2024 07:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hIrxaeLW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CA4185B67
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 07:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731654583; cv=none; b=X4n59ITcF94BdHvkGXl1JVEHWFx7LrkNK3U9mhycxyfi9xbg8KcO10KK+nd6iKI9LONni/bUauLnsyDMmaSkjljZt+EV1oKhQnnzBYWz4YCu8HeKg6a+vzV3ZCLf5uBjAWBNe2cA6MCwjVF1ZDYmWSr4f8Wunjrkng5ovnT91cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731654583; c=relaxed/simple;
	bh=w3PrKmE9mTpUkvWX+kcBjSJKDUDsbEtJClwu/MmAArI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8C4+Pd50JDtDy09wfnTaKjvezlKOVrJZTSDB9G/RZu+gMxsuHjDTT8xlbf+cqYXtf7BQJNRJFavVBsVa1IJGAmeOs/tqoyR4jpGf3rXfbd/CekO5S7BRfT5nqug9twfEgD319s02knHvxFkrtWD4ebXJNvxWX5BiL+Mj1wkD2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hIrxaeLW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-210e5369b7dso16656235ad.3
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 23:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731654581; x=1732259381; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RTASYuonIXYMTO8w/VZwrdh/t3+ZJlTDy7BrROeihwk=;
        b=hIrxaeLW4ACRMm0RKZ+xWFEsCHvtP+sVtQ/sQqFRGA1Ty7nVsOFDrz9+V2HFy29Os9
         i+6Ak38J1a1XPfnPi0wGQtmG1eHD/jAcxhe3uovcPpq+BVIeeH6Xb2Hln7dI5ENcX2Pe
         9N0qPjkW4esGUv2ofiWpuutyxT3QqFsrM1g8XiFnc3YGtjdVWzkKDvRdfWUeF0+zhK+s
         uLhyt/cWGWcYEF6tf8+7REf1KTCCZZ3Mt6fAB7alfybebp6w40QagTq+wJRl1bElqJCh
         kEEAhP5DbJd9UHmMhIjCyy8S2kEWJcZ8plaYDLstdHCVB2IXUrZWfIK5F6H0ooq87w+o
         wKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731654581; x=1732259381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTASYuonIXYMTO8w/VZwrdh/t3+ZJlTDy7BrROeihwk=;
        b=b/LRW3SxPm0a2hA0uatfiH8mIebGBGHfOasp9RJ1oeQbCidoHXYkxGzehB7tfrWGdd
         tD92NKo/TBSrGGRm2G4QoDyc9+c3/8AatEJgEiimU2rDSXmPeIhJ3FiXCd8eq3rIczxc
         I8B4mCZca/p/nP0OHKUP4jvrG/hZvEachmB0UcVDbnbUhm97CNK78Lc0W1kEEhiQTQPq
         N7j8eSc0pvmznBNXdD9KFg0DN/xZlayO0i0GEi0F7hXNZfmqyrWUNDozKFkS4JOpmBNA
         0SSwGk2kP6p72LvI1FdYolITRbQCt+NgmHcLqPajUxuGOVS4owdxQ3dELDns/XrsNpLf
         j7nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlufx3s2/1EClVJ0xoRqtRFELI8ONnbAdBUWXOrE6gXdv6s1aiM+7vv+P6GCS2YCfecs+OWCGMS8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl61Nw5XzK+EkgiuXP+39bEMkv1NWfjbBF+WMJqYB36V8Lw26W
	rguQ8o9KrCBhi0stjcj6yZkUXC1Rg45Mw0H+OcSI5g6s/vR0jk73X7/lobFR1w==
X-Google-Smtp-Source: AGHT+IHUGaSyHNaY2FS9i6/28XCjc24z31PJ7w4sRO9cHLwWOZ3a8XWx37MHhGc5NlK7FThFBIxSVg==
X-Received: by 2002:a17:902:ce84:b0:20b:5ea2:e06 with SMTP id d9443c01a7336-211d0edcc0dmr23998425ad.56.1731654581319;
        Thu, 14 Nov 2024 23:09:41 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0ec7c3asm6508005ad.65.2024.11.14.23.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 23:09:40 -0800 (PST)
Date: Fri, 15 Nov 2024 12:39:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, frank.li@nxp.com,
	s.hauer@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/10] PCI: imx6: Use dwc common suspend resume method
Message-ID: <20241115070932.vt4cqshyjtks2hq4@thinkpad>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-9-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241101070610.1267391-9-hongxing.zhu@nxp.com>

On Fri, Nov 01, 2024 at 03:06:08PM +0800, Richard Zhu wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Call common dwc suspend/resume function. Use dwc common iATU method to
> send out PME_TURN_OFF message. In Old DWC implementations,
> PCIE_ATU_INHIBIT_PAYLOAD bit in iATU Ctrl2 register is reserved. So the
> generic DWC implementation of sending the PME_Turn_Off message using a
> dummy MMIO write cannot be used. Use previouse method to kick off
> PME_TURN_OFF MSG for these platforms.
> 
> Replace the imx_pcie_stop_link() and imx_pcie_host_exit() by
> dw_pcie_suspend_noirq() in imx_pcie_suspend_noirq().
> 
> Since dw_pcie_suspend_noirq() already does these, see below call stack:
> dw_pcie_suspend_noirq()
>   dw_pcie_stop_link();
>     imx_pcie_stop_link();
>   pci->pp.ops->deinit();
>     imx_pcie_host_exit();
> 
> Replace the imx_pcie_host_init(), dw_pcie_setup_rc() and
> imx_pcie_start_link() by dw_pcie_resume_noirq() in
> imx_pcie_resume_noirq().
> 
> Since dw_pcie_resume_noirq() already does these, see below call stack:
> dw_pcie_resume_noirq()
>   pci->pp.ops->init();
>     imx_pcie_host_init();
>   dw_pcie_setup_rc();
>   dw_pcie_start_link();
>     imx_pcie_start_link();
> 

Are these two changes (dw_pcie_suspend_noirq(), dw_pcie_resume_noirq()) related
to this patch? If not, these should be in a separate patch.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 95 ++++++++++-----------------
>  1 file changed, 34 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index fde2f4eaf804..3c074cc2605f 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -33,6 +33,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  
> +#include "../../pci.h"
>  #include "pcie-designware.h"
>  
>  #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
> @@ -108,19 +109,18 @@ struct imx_pcie_drvdata {
>  	int (*init_phy)(struct imx_pcie *pcie);
>  	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
>  	int (*core_reset)(struct imx_pcie *pcie, bool assert);
> +	const struct dw_pcie_host_ops *ops;
>  };
>  
>  struct imx_pcie {
>  	struct dw_pcie		*pci;
>  	struct gpio_desc	*reset_gpiod;
> -	bool			link_is_up;
>  	struct clk_bulk_data	clks[IMX_PCIE_MAX_CLKS];
>  	struct regmap		*iomuxc_gpr;
>  	u16			msi_ctrl;
>  	u32			controller_id;
>  	struct reset_control	*pciephy_reset;
>  	struct reset_control	*apps_reset;
> -	struct reset_control	*turnoff_reset;
>  	u32			tx_deemph_gen1;
>  	u32			tx_deemph_gen2_3p5db;
>  	u32			tx_deemph_gen2_6db;
> @@ -899,13 +899,11 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  		dev_info(dev, "Link: Only Gen1 is enabled\n");
>  	}
>  
> -	imx_pcie->link_is_up = true;
>  	tmp = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
>  	dev_info(dev, "Link up, Gen%i\n", tmp & PCI_EXP_LNKSTA_CLS);
>  	return 0;
>  
>  err_reset_phy:
> -	imx_pcie->link_is_up = false;
>  	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
> @@ -1024,9 +1022,32 @@ static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
>  	return cpu_addr - entry->offset;
>  }
>  
> +/*
> + * In Old DWC implementations, PCIE_ATU_INHIBIT_PAYLOAD bit in iATU Ctrl2
> + * register is reserved. So the generic DWC implementation of sending the
> + * PME_Turn_Off message using a dummy MMIO write cannot be used.
> + */
> +static void imx_pcie_pme_turn_off(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
> +
> +	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_PM_TURN_OFF);
> +	regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_PM_TURN_OFF);
> +
> +	usleep_range(PCIE_PME_TO_L2_TIMEOUT_US/10, PCIE_PME_TO_L2_TIMEOUT_US);
> +}
> +
> +

Stray newline.

>  static const struct dw_pcie_host_ops imx_pcie_host_ops = {
>  	.init = imx_pcie_host_init,
>  	.deinit = imx_pcie_host_exit,
> +	.pme_turn_off = imx_pcie_pme_turn_off,
> +};
> +
> +static const struct dw_pcie_host_ops imx_pcie_host_dw_pme_ops = {
> +	.init = imx_pcie_host_init,
> +	.deinit = imx_pcie_host_exit,
>  };
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {
> @@ -1147,43 +1168,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
>  	return 0;
>  }
>  
> -static void imx_pcie_pm_turnoff(struct imx_pcie *imx_pcie)
> -{
> -	struct device *dev = imx_pcie->pci->dev;
> -
> -	/* Some variants have a turnoff reset in DT */
> -	if (imx_pcie->turnoff_reset) {
> -		reset_control_assert(imx_pcie->turnoff_reset);
> -		reset_control_deassert(imx_pcie->turnoff_reset);

Where these are handled in imx_pcie_pme_turn_off()? If you removed them
intentionally for a reason, it should be mentioned in commit message. 

> -		goto pm_turnoff_sleep;
> -	}
> -
> -	/* Others poke directly at IOMUXC registers */
> -	switch (imx_pcie->drvdata->variant) {
> -	case IMX6SX:
> -	case IMX6QP:
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
> -				IMX6SX_GPR12_PCIE_PM_TURN_OFF);
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				IMX6SX_GPR12_PCIE_PM_TURN_OFF, 0);
> -		break;
> -	default:
> -		dev_err(dev, "PME_Turn_Off not implemented\n");
> -		return;
> -	}
> -
> -	/*
> -	 * Components with an upstream port must respond to
> -	 * PME_Turn_Off with PME_TO_Ack but we can't check.
> -	 *
> -	 * The standard recommends a 1-10ms timeout after which to
> -	 * proceed anyway as if acks were received.
> -	 */
> -pm_turnoff_sleep:
> -	usleep_range(1000, 10000);
> -}
> -
>  static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
>  {
>  	u8 offset;
> @@ -1207,36 +1191,26 @@ static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)

[...]

> @@ -1267,11 +1241,14 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
> -	pci->pp.ops = &imx_pcie_host_ops;
>  
>  	imx_pcie->pci = pci;
>  	imx_pcie->drvdata = of_device_get_match_data(dev);
>  
> +	pci->pp.ops = &imx_pcie_host_dw_pme_ops;
> +	if (imx_pcie->drvdata->ops)
> +		pci->pp.ops = imx_pcie->drvdata->ops;

Use if..else pattern

> +
>  	/* Find the PHY if one is defined, only imx7d uses it */
>  	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
>  	if (np) {
> @@ -1343,13 +1320,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  		break;
>  	}
>  
> -	/* Grab turnoff reset */
> -	imx_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
> -	if (IS_ERR(imx_pcie->turnoff_reset)) {
> -		dev_err(dev, "Failed to get TURNOFF reset control\n");
> -		return PTR_ERR(imx_pcie->turnoff_reset);
> -	}
> -

Same here. Reason not explained.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

