Return-Path: <linux-pci+bounces-25542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2813A81F59
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 10:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6CE1BC1B32
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 08:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D737C25B688;
	Wed,  9 Apr 2025 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X0HfnFIR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1492AEE1
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2025 08:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744185843; cv=none; b=bEbbAovp1Bb8xkEplnts3R/7Z9Ei/qaD0xBq7NNV45H6aePWa8954Pj+DwvQVjnFeQRbcPDeMnh91pD8u292lzz+bsY4nd3E2Ff0Y5H58/UpqRoPWT5qzW2O7+mTFCL9Gnb163ArphvO8ZGLwa4PT/oCbBxEyF1MTeEKzUmHPiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744185843; c=relaxed/simple;
	bh=ZaVw5OY/Fp/j2BL95jCBKv6mfWVHYmdtI7BWrOnSXVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lw0FkEJQPgIOlqywQ6UyexAFqPKaLmJGXc38FU0lOAzdKcDruMAloRhZG/JH9nRxoSxgiB+G7b9zosz9KgDU1zk1JEnBqp/q+MnlGMU91w+djAGhpWKqS/mCTgqjwEjaPVQAw1h8Gg1JcvOrhbwyhquYvHnEAxHIy+pMqi7dRd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X0HfnFIR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224100e9a5cso68712495ad.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Apr 2025 01:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744185841; x=1744790641; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cZkefp3SsqAWOBBxs1VEWuV1y8jA3RO3nWFxkIRrTSA=;
        b=X0HfnFIRj5VA6KsJPY1o4BRlXI9ouuU3TeMDv0VG+E1uM+ynGugnAOd7AUrmNMaAMw
         wG/PXZw1ixv65Auj+TgkA7+lUdbh0X1Qt8EdZfIeQxoNf0QO62SPO+hQUHPvOaO4KRQf
         dtreqXyh4fz+sCxV+bLXTbBQAqb9qPBvidNnsFvwCeSMSwXXohM9ZAONEedDvVFtIkDj
         7WUf2fiORiwLi3zJ4V+qJOY2oU9gJ6AP8C16dVDJKebS8t5+tDUfsCyIhzyCUaeruPOW
         iW9yXE2QEhelS4Q0nBQA9g+dKZxtXJcBjU/LpM7Qnp1jRwdxsEgT+OrKD5CktTODSHd/
         Ln1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744185841; x=1744790641;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZkefp3SsqAWOBBxs1VEWuV1y8jA3RO3nWFxkIRrTSA=;
        b=X49+8ipq8V5iBH1NB5c2+g9rnPE4XDgqv38sdZnAtcDPAYjOQvmrn8wp73hhvIfdCD
         dGr66v2oIIsqB9iZ/JRSZ9WEm0q1paZoEHsiwuFC+h+0MgH3MbqWpXzbmceFYDGDEfjD
         9bAnblrQTKZmmqOJgTT55KUIbMIkuvzhoFaGRU4QEgMzw1iBE5ZvumT9rmFUsWOwNb1X
         SUlHkRB86kAAWMx+B8vaHPCmPW8JHkphvpxyF3RxChcDxLxwhMzvhQSAZ3E+i/7E0zox
         jCrRZDtMD1Tjx/uhTeVHlouw9BD8HmqY47WlhDP0MLctinuB/TSDhrfKrhu66I6g9yEr
         hCrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkwLuZLI1hoB2GyNu5oVtkB3Zi/vkRdLCSw5MYN4Dr26U3QJq/1H0C6nh3x7kADPNi0bB59am/R1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIPgONEmFbNTvvupco0CmBsFCP6+/Z4aEG3kZMkmg4YxZfDCZ8
	vwLacLn1jR3xn6DDMNYAnmLh76L9mGXF+V3hb5iHqX7OkI9UV/gwf4ehRgtRDQ==
X-Gm-Gg: ASbGncv0urz16/rNtvkeLMm7m7lbrdlfpoiOYT9wCsCCIvZjnYgM8rMgbVKogaAAGq/
	qnoTd47VRycwqYMGz23++zwyyh0NOLiRkCTDtisRiGEaGhuqAUBvqo/kAddw2frCTYpPU9Vus8O
	pEhLHHbJcx4KVuhtrvpeQ7jsVV4nGqDYvr2sFFbgVv4ml3S9eUe+DOuoqDiJERS9zVI6HuUuiFL
	38ffQiYbTuL2GEwvaLSCjR4PkaBF2C8CZgaojaiorg+1PPCjUTsgE+N3czUbbvYygiQViyDKKvx
	v2jMB/TEWnoIhKNFmTm5vvXF5tSM311lMXZbCPugy5Vfx18wnT4=
X-Google-Smtp-Source: AGHT+IHzv+8zIVtNQ9GRK5QB/aNaohw8UHnO+WeQYD3ggOvprCdhZxsimpY14GlAS7+65p73hE+tow==
X-Received: by 2002:a17:902:ccc8:b0:224:c46:d162 with SMTP id d9443c01a7336-22ac2992075mr29880945ad.20.1744185841087;
        Wed, 09 Apr 2025 01:04:01 -0700 (PDT)
Received: from thinkpad ([120.56.198.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c9937fsm5677465ad.155.2025.04.09.01.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 01:04:00 -0700 (PDT)
Date: Wed, 9 Apr 2025 13:33:54 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, p.zabel@pengutronix.de, 
	johan+linaro@kernel.org, cassel@kernel.org, quic_schintav@quicinc.com, 
	fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/9 RESEND] PCI: stm32: Add PCIe Endpoint support for
 STM32MP25
Message-ID: <dirqsnrzjoiht7vvzzwh73gf3zuwyco6lc46k6s6pkifde2uzw@icmtn7x53swc>
References: <20250325065935.908886-1-christian.bruel@foss.st.com>
 <20250325065935.908886-5-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250325065935.908886-5-christian.bruel@foss.st.com>

On Tue, Mar 25, 2025 at 07:59:30AM +0100, Christian Bruel wrote:
> Add driver to configure the STM32MP25 SoC PCIe Gen1 2.5GT/s or Gen2 5GT/s
> controller based on the DesignWare PCIe core in endpoint mode.
> 
> Uses the common reference clock provided by the host.
> 
> The PCIe core_clk receives the pipe0_clk from the ComboPHY as input,
> and the ComboPHY PLL must be locked for pipe0_clk to be ready.
> Consequently, PCIe core registers cannot be accessed until the ComboPHY is
> fully initialised and refclk is enabled and ready.
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  drivers/pci/controller/dwc/Kconfig         |  12 +
>  drivers/pci/controller/dwc/Makefile        |   1 +
>  drivers/pci/controller/dwc/pcie-stm32-ep.c | 420 +++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-stm32.h    |   1 +
>  4 files changed, 434 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-stm32-ep.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 0c18879b604c..4a3eb838557c 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -401,6 +401,18 @@ config PCIE_STM32
>  	  This driver can also be built as a module. If so, the module
>  	  will be called pcie-stm32.
>  
> +config PCIE_STM32_EP
> +	tristate "STMicroelectronics STM32MP25 PCIe Controller (endpoint mode)"
> +	depends on ARCH_STM32 || COMPILE_TEST
> +	depends on PCI_ENDPOINT
> +	select PCIE_DW_EP
> +	help
> +	  Enables endpoint support for DesignWare core based PCIe controller
> +	  found in STM32MP25 SoC.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called pcie-stm32-ep.
> +
>  config PCI_DRA7XX
>  	tristate
>  
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index 576d99cb3bc5..caebd98f6dd3 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
>  obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
>  obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
>  obj-$(CONFIG_PCIE_STM32) += pcie-stm32.o
> +obj-$(CONFIG_PCIE_STM32_EP) += pcie-stm32-ep.o
>  
>  # The following drivers are for devices that use the generic ACPI
>  # pci_root.c driver but don't support standard ECAM config access.
> diff --git a/drivers/pci/controller/dwc/pcie-stm32-ep.c b/drivers/pci/controller/dwc/pcie-stm32-ep.c
> new file mode 100644
> index 000000000000..a8e9c5a9b127
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-stm32-ep.c
> @@ -0,0 +1,420 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * STMicroelectronics STM32MP25 PCIe endpoint driver.
> + *
> + * Copyright (C) 2025 STMicroelectronics
> + * Author: Christian Bruel <christian.bruel@foss.st.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_gpio.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include "pcie-designware.h"
> +#include "pcie-stm32.h"
> +
> +enum stm32_pcie_ep_link_status {
> +	STM32_PCIE_EP_LINK_DISABLED,
> +	STM32_PCIE_EP_LINK_ENABLED,
> +};
> +
> +struct stm32_pcie {
> +	struct dw_pcie pci;
> +	struct regmap *regmap;
> +	struct reset_control *rst;
> +	struct phy *phy;
> +	struct clk *clk;
> +	struct gpio_desc *perst_gpio;
> +	enum stm32_pcie_ep_link_status link_status;
> +	unsigned int perst_irq;
> +};
> +
> +static void stm32_pcie_ep_init(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	enum pci_barno bar;
> +
> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
> +		dw_pcie_ep_reset_bar(pci, bar);
> +}
> +
> +static int stm32_pcie_enable_link(struct dw_pcie *pci)
> +{
> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> +
> +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
> +			   STM32MP25_PCIECR_LTSSM_EN,
> +			   STM32MP25_PCIECR_LTSSM_EN);
> +
> +	return dw_pcie_wait_for_link(pci);
> +}
> +
> +static void stm32_pcie_disable_link(struct dw_pcie *pci)
> +{
> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> +
> +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR, STM32MP25_PCIECR_LTSSM_EN, 0);
> +}
> +
> +static int stm32_pcie_start_link(struct dw_pcie *pci)
> +{
> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> +	struct dw_pcie_ep *ep = &pci->ep;
> +	int ret;
> +
> +	if (stm32_pcie->link_status == STM32_PCIE_EP_LINK_ENABLED) {
> +		dev_dbg(pci->dev, "Link is already enabled\n");
> +		return 0;
> +	}
> +
> +	ret = stm32_pcie_enable_link(pci);
> +	if (ret) {
> +		dev_err(pci->dev, "PCIe cannot establish link: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dw_pcie_ep_linkup(ep);
> +

This callback should only be used when the epc_features::linkup_notifier flag is
set. That only applies to platforms supporting LINK_UP interrupt. In this case,
once the start_link() callback returns, it is assumed that the link is active.
So no need to call dw_pcie_ep_linkup().

> +	stm32_pcie->link_status = STM32_PCIE_EP_LINK_ENABLED;
> +
> +	enable_irq(stm32_pcie->perst_irq);
> +
> +	return 0;
> +}
> +
> +static void stm32_pcie_stop_link(struct dw_pcie *pci)
> +{
> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> +
> +	if (stm32_pcie->link_status == STM32_PCIE_EP_LINK_DISABLED) {
> +		dev_dbg(pci->dev, "Link is already disabled\n");
> +		return;
> +	}
> +
> +	disable_irq(stm32_pcie->perst_irq);
> +
> +	stm32_pcie_disable_link(pci);
> +
> +	stm32_pcie->link_status = STM32_PCIE_EP_LINK_DISABLED;
> +}
> +
> +static int stm32_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> +				unsigned int type, u16 interrupt_num)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +
> +	switch (type) {
> +	case PCI_IRQ_INTX:
> +		return dw_pcie_ep_raise_intx_irq(ep, func_no);
> +	case PCI_IRQ_MSI:
> +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> +	default:
> +		dev_err(pci->dev, "UNKNOWN IRQ type\n");
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct pci_epc_features stm32_pcie_epc_features = {
> +	.msi_capable = true,
> +	.align = SZ_64K,
> +};
> +
> +static const struct pci_epc_features*
> +stm32_pcie_get_features(struct dw_pcie_ep *ep)
> +{
> +	return &stm32_pcie_epc_features;
> +}
> +
> +static const struct dw_pcie_ep_ops stm32_pcie_ep_ops = {
> +	.init = stm32_pcie_ep_init,
> +	.raise_irq = stm32_pcie_raise_irq,
> +	.get_features = stm32_pcie_get_features,
> +};
> +
> +static const struct dw_pcie_ops dw_pcie_ops = {
> +	.start_link = stm32_pcie_start_link,
> +	.stop_link = stm32_pcie_stop_link,
> +};
> +
> +static int stm32_pcie_enable_resources(struct stm32_pcie *stm32_pcie)
> +{
> +	int ret;
> +
> +	ret = phy_init(stm32_pcie->phy);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(stm32_pcie->clk);
> +	if (ret)
> +		phy_exit(stm32_pcie->phy);
> +
> +	return ret;
> +}
> +
> +static void stm32_pcie_disable_resources(struct stm32_pcie *stm32_pcie)
> +{
> +	clk_disable_unprepare(stm32_pcie->clk);
> +
> +	phy_exit(stm32_pcie->phy);
> +}
> +
> +static void stm32_pcie_perst_assert(struct dw_pcie *pci)
> +{
> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> +	struct device *dev = pci->dev;
> +
> +	dev_dbg(dev, "PERST asserted by host. Shutting down the PCIe link\n");
> +
> +	/*
> +	 * Do not try to release resources if the PERST# is
> +	 * asserted before the link is started.

Make use of 80 columns.

> +	 */
> +	if (stm32_pcie->link_status == STM32_PCIE_EP_LINK_DISABLED) {
> +		dev_dbg(pci->dev, "Link is already disabled\n");
> +		return;
> +	}
> +
> +	stm32_pcie_disable_link(pci);
> +
> +	stm32_pcie_disable_resources(stm32_pcie);
> +
> +	pm_runtime_put_sync(dev);
> +
> +	stm32_pcie->link_status = STM32_PCIE_EP_LINK_DISABLED;
> +}
> +
> +static void stm32_pcie_perst_deassert(struct dw_pcie *pci)
> +{
> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> +	struct device *dev = pci->dev;
> +	struct dw_pcie_ep *ep = &pci->ep;
> +	int ret;
> +
> +	if (stm32_pcie->link_status == STM32_PCIE_EP_LINK_ENABLED) {
> +		dev_dbg(pci->dev, "Link is already enabled\n");
> +		return;
> +	}
> +
> +	dev_dbg(dev, "PERST de-asserted by host. Starting link training\n");
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "pm runtime resume failed: %d\n", ret);
> +		return;
> +	}
> +
> +	ret = stm32_pcie_enable_resources(stm32_pcie);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable resources: %d\n", ret);
> +		goto err_pm_put_sync;
> +	}
> +
> +	ret = dw_pcie_ep_init_registers(ep);
> +	if (ret) {
> +		dev_err(dev, "Failed to complete initialization: %d\n", ret);
> +		goto err_disable_resources;
> +	}
> +
> +	pci_epc_init_notify(ep->epc);
> +
> +	ret = stm32_pcie_enable_link(pci);
> +	if (ret) {
> +		dev_err(dev, "PCIe Cannot establish link: %d\n", ret);
> +		goto err_deinit_notify;
> +	}

Link is supposed to be enabled only by the start_link() callback.

> +
> +	stm32_pcie->link_status = STM32_PCIE_EP_LINK_ENABLED;
> +
> +	return;
> +
> +err_deinit_notify:
> +	pci_epc_deinit_notify(ep->epc);
> +
> +err_disable_resources:
> +	stm32_pcie_disable_resources(stm32_pcie);
> +
> +err_pm_put_sync:
> +	pm_runtime_put_sync(dev);
> +}
> +
> +static irqreturn_t stm32_pcie_ep_perst_irq_thread(int irq, void *data)
> +{
> +	struct stm32_pcie *stm32_pcie = data;
> +	struct dw_pcie *pci = &stm32_pcie->pci;
> +	u32 perst;
> +
> +	perst = gpiod_get_value(stm32_pcie->perst_gpio);
> +	if (perst)
> +		stm32_pcie_perst_assert(pci);
> +	else
> +		stm32_pcie_perst_deassert(pci);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int stm32_add_pcie_ep(struct stm32_pcie *stm32_pcie,
> +			     struct platform_device *pdev)
> +{
> +	struct dw_pcie_ep *ep = &stm32_pcie->pci.ep;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "pm runtime resume failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
> +				 STM32MP25_PCIECR_TYPE_MASK,
> +				 STM32MP25_PCIECR_EP);
> +	if (ret) {
> +		goto err_pm_put_sync;
> +		return ret;
> +	}
> +
> +	reset_control_assert(stm32_pcie->rst);
> +	reset_control_deassert(stm32_pcie->rst);
> +
> +	ep->ops = &stm32_pcie_ep_ops;
> +
> +	ret = dw_pcie_ep_init(ep);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize ep: %d\n", ret);
> +		goto err_pm_put_sync;
> +	}
> +
> +	ret = stm32_pcie_enable_resources(stm32_pcie);
> +	if (ret) {
> +		dev_err(dev, "failed to enable resources: %d\n", ret);
> +		goto err_ep_deinit;
> +	}
> +
> +	ret = dw_pcie_ep_init_registers(ep);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize DWC endpoint registers\n");
> +		goto err_disable_resources;
> +	}
> +
> +	pci_epc_init_notify(ep->epc);
> +

You are calling dw_pcie_ep_init_registers() and  pci_epc_init_notify() from 2
places. I think the one in stm32_pcie_perst_deassert() should be dropped since
the DBI registers are available at this point itself.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

