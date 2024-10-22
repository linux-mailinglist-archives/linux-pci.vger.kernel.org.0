Return-Path: <linux-pci+bounces-15032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0859AB4D6
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 19:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C47A1C222B2
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 17:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9370129A78;
	Tue, 22 Oct 2024 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PyMyAviB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095811A726D
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617489; cv=none; b=G4eIxzojFuRZWVqBZQzJeTkIwKg3nCrdCqGpgOIUtQB6/YK+XUjCrdam+pRcmlU1jfkRZ3nlNca+xpDN+GQArPB21eIRAXliBDaOU/bGfdCC2x7xFl29QhCBIep2fmcDJ5DC+K6VJPJfJGLt7piSZhA2SNaYuBxFO1TTqpQk3Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617489; c=relaxed/simple;
	bh=KSC5L6vhzjZFMWeXwTYwXoW7pK23HzcFd3BChjy0VW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzXKwIh1m9H1IxWRdje6bsuQVSR1HAt71QTEv9NRrzcZ1JBCGSd3Gnvz5TAaWImdPm1fXDOH/0OVlsYMWsr6tPcLLe0LVYFsFBEX8dC/vvr+cwoVLpSf6t3sgEyT2LOhb6MzQB+KE8yEXsJTTykr6vhkEKHphMVPMEJ+AIymB2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PyMyAviB; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e70c32cd7so4782218b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 10:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729617487; x=1730222287; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FO8AvzTVl7Q+hb2sVhgFlvzsJXMthOIv2P45jM3TDcY=;
        b=PyMyAviBbSlVGyBCagEjtHlBWQjSiJZDFtsVR1mshA4MxDTHgYuAgmxQQQ/jYptf7l
         IYgU+34AXqNne+97bfSyKYcbVlj3Y+jsE1WJ8UQNKLTDwiGNJ0zhCCqsjxjXDwxbRlzt
         DiN1iO76Zyl9M2xqV2/9kV8eKXr0Kof18bUHkzufeUpC1ugCXUv/O6W6XjZCS0bzQGcp
         p7PSkHQZVPx5kGKADuxXF4+gfSC343kOpgCsPlkrDasSva/vO1KRDtQNQIr3tATXui95
         hzDb5Et2EfK+mhuvxb12+9+L+5RU6JRR6dX7BlUZNywjVNzgMSo1hqChti20Vahr/8pn
         edwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729617487; x=1730222287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FO8AvzTVl7Q+hb2sVhgFlvzsJXMthOIv2P45jM3TDcY=;
        b=tdV1unu4ABSIanDhPyp6B1iKi1c+e1C1R8YamiyubYKvdctB4RUXd1mgl9N3jEkB1r
         36mrbq2PVO3cdW80qC8xJL3kQpronlpxAZnHIfNg6HUpreHH/UjnfDZAWuQG4Ee42y6V
         W8tTgIu7cXqSfyiFjewIxl8y376vwm1NQTF+vA6GipyBzjt7qA1tCaSzcFwYSShbuMGz
         sF1X73m+0lQEnSaXtHwzpMB4z8DsZNVqMdPH0hPl0phz/pdve1aevbzryRhLRpjrGkLz
         QNml3ZWI+ldxThb3DBk8K5G79oQP20OI8jAX+AjQpXOIAGk8wME5/PhHvhZ7JjSwCGqL
         7BJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCMJZFOAiL5q8OIEftHm+5BS95MpzDx7+NcshA82lxwV4dMtG4Awkil7zU5Iv0cCIF/Mmo2+WF2iU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuiy982fiRkAyO+gqyI09Lc+Bx0FAVV5l183xxm7H887Opm0db
	FOZ50B22eO9aW0m3tXkpg3orNYaUUqGrEr1Wzu1S558f/nqV1VgCposUPpHx/A==
X-Google-Smtp-Source: AGHT+IG3HaDs9ASXXfFMoqRPiXkH/fVNWOTszOyH/jfDreL4V9LL3Tz/krJsFpBbR1TrYP1MANau0Q==
X-Received: by 2002:a05:6a00:3e0b:b0:71e:4fe4:282a with SMTP id d2e1a72fcca58-71ea3118a51mr23192217b3a.2.1729617487247;
        Tue, 22 Oct 2024 10:18:07 -0700 (PDT)
Received: from thinkpad ([36.255.17.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13ea12asm4965447b3a.159.2024.10.22.10.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 10:18:06 -0700 (PDT)
Date: Tue, 22 Oct 2024 22:48:00 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: kw@linux.com, bhelgaas@google.com, lpieralisi@kernel.org,
	frank.li@nxp.com, l.stach@pengutronix.de, robh+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com,
	s.hauer@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 7/9] PCI: imx6: Use dwc common suspend resume method
Message-ID: <20241022171800.fwkdvzozw2rnzv34@thinkpad>
References: <1728981213-8771-1-git-send-email-hongxing.zhu@nxp.com>
 <1728981213-8771-8-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1728981213-8771-8-git-send-email-hongxing.zhu@nxp.com>

On Tue, Oct 15, 2024 at 04:33:31PM +0800, Richard Zhu wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Call common dwc suspend/resume function. Use dwc common iATU method to send
> out PME_TURN_OFF message. Old platform such as iMX6SX and iMX6QP, iATU
> CTRL2 bit 22 (PCIE_ATU_INHIBIT_PAYLOAD) are reserved. So can't send out MSG
> without data by dummy MMIO write. Without PCIE_ATU_INHIBIT_PAYLOAD, MSGD
> will be sent out instead of MSG. So keep old method to send PME_TURN_OFF
> MSG.
> 

This PME_Turn_Off implementation is the only difference between the DWC common
ops and the custom one here? I don't think so. Please describe all the
differences.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 97 ++++++++++-----------------
>  1 file changed, 36 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 161daad34a94..baa853d84b4d 100644
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
> @@ -82,6 +83,7 @@ enum imx_pcie_variants {
>  #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
>  #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
>  #define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
> +#define IMX_PCIE_FLAG_CUSTOM_PME_TURNOFF	BIT(9)
>  
>  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
>  
> @@ -106,19 +108,18 @@ struct imx_pcie_drvdata {
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
> @@ -898,13 +899,11 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
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
> @@ -1023,9 +1022,33 @@ static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
>  	return cpu_addr - entry->offset;
>  }
>  
> +/*
> + * Old dwc iATU ctrl2 bit 22 (PCIE_ATU_INHIBIT_PAYLOAD) are reserved. So can't
> + * send out MSG without data by dummy MMIO write. Without
> + * PCIE_ATU_INHIBIT_PAYLOAD, MSGD will be sent out. So have to keep old method
> + * to send PME_TURN_OFF MSG.

Please reword the comments:

"In Old DWC implementations, PCIE_ATU_INHIBIT_PAYLOAD bit in iATU Ctrl2 register
is reserved. So the generic DWC implementation of sending the PME_Turn_Off
message using a dummy MMIO write cannot be used."

> + */
> +static void imx_pcie_pm_turn_off(struct dw_pcie_rp *pp)

s/pm/pme

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
>  static const struct dw_pcie_host_ops imx_pcie_host_ops = {
>  	.init = imx_pcie_host_init,
>  	.deinit = imx_pcie_host_exit,
> +	.pme_turn_off = imx_pcie_pm_turn_off,
> +};
> +
> +static const struct dw_pcie_host_ops imx_pcie_host_dw_pme_ops = {
> +	.init = imx_pcie_host_init,
> +	.deinit = imx_pcie_host_exit,
>  };
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {
> @@ -1146,43 +1169,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
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
> -		goto pm_turnoff_sleep;
> -	}

What about this part of the code? Don't you need it now?

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
> @@ -1206,36 +1192,26 @@ static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
>  static int imx_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
> -	struct dw_pcie_rp *pp = &imx_pcie->pci->pp;
>  
>  	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
>  		return 0;
>  
>  	imx_pcie_msi_save_restore(imx_pcie, true);
> -	imx_pcie_pm_turnoff(imx_pcie);
> -	imx_pcie_stop_link(imx_pcie->pci);
> -	imx_pcie_host_exit(pp);
> -
> -	return 0;
> +	return dw_pcie_suspend_noirq(imx_pcie->pci);
>  }
>  
>  static int imx_pcie_resume_noirq(struct device *dev)
>  {
>  	int ret;
>  	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
> -	struct dw_pcie_rp *pp = &imx_pcie->pci->pp;
>  
>  	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
>  		return 0;
>  
> -	ret = imx_pcie_host_init(pp);
> +	ret = dw_pcie_resume_noirq(imx_pcie->pci);
>  	if (ret)
>  		return ret;
>  	imx_pcie_msi_save_restore(imx_pcie, false);
> -	dw_pcie_setup_rc(pp);
> -
> -	if (imx_pcie->link_is_up)
> -		imx_pcie_start_link(imx_pcie->pci);

So this is also not needed? Why? Please explain in the commit message.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

