Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFD36EB9B1
	for <lists+linux-pci@lfdr.de>; Sat, 22 Apr 2023 16:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjDVOiX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Apr 2023 10:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVOiW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Apr 2023 10:38:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1AE1705;
        Sat, 22 Apr 2023 07:38:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A9A760B82;
        Sat, 22 Apr 2023 14:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147F3C433D2;
        Sat, 22 Apr 2023 14:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682174299;
        bh=O2Jh+nGRed0+jm2zdMxMgp0qFQ5t4aqeOzKnXH3VKC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pKybEi8+ZyZ50riKYbiGisoNrRlMdi/nZTXv62Ri6EAxZ6YyexLcUkXr8h1gen8RI
         YG+E8Mju+xkWOk16qFB8MW8B/XprXE4tkfRCkOx4SyawW6yrhbKL7dXyKWGAGP8n7l
         PP6cVqqjxsCQxUGOtq4VY7j1zHtMPk5RudUAilKbkae5xiLowrCMeJ5DyeCylmBpRK
         ++mc90ZQK3iE+9c55SNCogCAQk2tERbc1a+veKhQ+ev2XbfUwwfTAv6uUxqenJ4jCG
         X11icMmmizlRvzrBWcEdhG5epxfsleAyrFSUG3w0+WtCvlrBOQLadp0YqbpKN76ix4
         C53SgfMef0qcg==
Date:   Sat, 22 Apr 2023 20:08:10 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        fancer.lancer@gmail.com, lpieralisi@kernel.org, robh+dt@kernel.org,
        kw@linux.com, bhelgaas@google.com, kishon@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v13 19/22] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Message-ID: <20230422143810.GP4769@thinkpad>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-20-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418122403.3178462-20-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 09:24:00PM +0900, Yoshihiro Shimoda wrote:
> Add R-Car Gen4 PCIe Host support. This controller is based on
> Synopsys DesignWare PCIe.
> 

It is good to add more details about the controller here like retraining etc...
Also, please justify why you have added some helpers in a separate file. If
those helpers are going to be used in other drivers now, then it should be
mentioned here.

NOTE: It may be used in future is not a valid justification.

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/Kconfig            |   9 +
>  drivers/pci/controller/dwc/Makefile           |   2 +
>  .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 134 +++++++++++++
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 187 ++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  49 +++++
>  5 files changed, 381 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index d29551261e80..eb90e2116e59 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -415,4 +415,13 @@ config PCIE_FU740
>  	  Say Y here if you want PCIe controller support for the SiFive
>  	  FU740.
>  
> +config PCIE_RCAR_GEN4
> +	tristate "Renesas R-Car Gen4 PCIe Host controller"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on PCI_MSI
> +	select PCIE_DW_HOST
> +	help
> +	  Say Y here if you want PCIe host controller support on R-Car Gen4 SoCs.
> +	  This uses the DesignWare core.
> +
>  endmenu
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index bf5c311875a1..486cf706b53d 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -26,6 +26,8 @@ obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
>  obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>  obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
>  obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
> +pcie-rcar-gen4-host-drv-objs := pcie-rcar-gen4.o pcie-rcar-gen4-host.o
> +obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4-host-drv.o
>  
>  # The following drivers are for devices that use the generic ACPI
>  # pci_root.c driver but don't support standard ECAM config access.
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> new file mode 100644
> index 000000000000..067fbd2a8d50
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PCIe host controller driver for Renesas R-Car Gen4 Series SoCs
> + * Copyright (C) 2022-2023 Renesas Electronics Corporation
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +
> +#include "pcie-rcar-gen4.h"
> +#include "pcie-designware.h"
> +
> +static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
> +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> +	int ret;
> +	u32 val;
> +

Don't you need to assert perst before starting controller config?

> +	ret = rcar_gen4_pcie_set_device_type(rcar, true, dw->num_lanes);
> +	if (ret < 0)
> +		return ret;
> +
> +	dw_pcie_dbi_ro_wr_en(dw);
> +
> +	/*
> +	 * According to the databook, we should disable two BARs to avoid

Which databook? Synopsys DWC?

> +	 * unnecessary memory assignment during device enumeration.
> +	 */
> +	rcar_gen4_pcie_disable_bar(dw, PCI_BASE_ADDRESS_0);
> +	rcar_gen4_pcie_disable_bar(dw, PCI_BASE_ADDRESS_1);

I don't see a need for this function. With dbi_ro_wr_{en/dis}, it's better to
directly use the dbi accessors here.

> +
> +	dw_pcie_dbi_ro_wr_dis(dw);
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		/* Enable MSI interrupt signal */
> +		val = readl(rcar->base + PCIEINTSTS0EN);
> +		val |= MSI_CTRL_INT;
> +		writel(val, rcar->base + PCIEINTSTS0EN);
> +	}
> +
> +	gpiod_set_value_cansleep(dw->pe_rst, 0);

If you end up adding perst assert above, add a 100ms delay before deassert.

> +
> +	return 0;
> +}
> +

[...]

> +
> +static struct platform_driver rcar_gen4_pcie_driver = {
> +	.driver = {
> +		.name = "pcie-rcar-gen4",
> +		.of_match_table = rcar_gen4_pcie_of_match,
> +	},
> +	.probe = rcar_gen4_pcie_probe,
> +	.remove = rcar_gen4_pcie_remove,

You should consider adding PROBE_PREFER_ASYNCHRONOUS here to avoid blocking
other drivers while waiting for link_up during boot.

> +};
> +module_platform_driver(rcar_gen4_pcie_driver);
> +
> +MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe host controller driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> new file mode 100644
> index 000000000000..89cec76a41ab
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -0,0 +1,187 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PCIe host/endpoint controller driver for Renesas R-Car Gen4 Series SoCs
> + * Copyright (C) 2022-2023 Renesas Electronics Corporation
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/of_device.h>
> +#include <linux/pci.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +
> +#include "pcie-rcar-gen4.h"
> +#include "pcie-designware.h"
> +
> +/* Renesas-specific */
> +#define PCIERSTCTRL1		0x0014
> +#define  APP_HOLD_PHY_RST	BIT(16)
> +#define  APP_LTSSM_ENABLE	BIT(0)
> +
> +#define RETRAIN_MAX_RETRY	10
> +
> +static void rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar,
> +					bool enable)
> +{
> +	u32 val;
> +
> +	val = readl(rcar->base + PCIERSTCTRL1);
> +	if (enable) {
> +		val |= APP_LTSSM_ENABLE;
> +		val &= ~APP_HOLD_PHY_RST;
> +	} else {
> +		val &= ~APP_LTSSM_ENABLE;
> +		val |= APP_HOLD_PHY_RST;
> +	}
> +	writel(val, rcar->base + PCIERSTCTRL1);
> +}
> +
> +static bool rcar_gen4_pcie_check_retrain_link(struct dw_pcie *dw)
> +{
> +	u8 offset = dw_pcie_find_capability(dw, PCI_CAP_ID_EXP);
> +	u32 lnkcap = dw_pcie_readl_dbi(dw, offset + PCI_EXP_LNKCAP);
> +	u32 lnkctl = dw_pcie_readl_dbi(dw, offset + PCI_EXP_LNKCTL);
> +	u16 lnksta = dw_pcie_readw_dbi(dw, offset + PCI_EXP_LNKSTA);
> +	int i;
> +
> +	if ((lnksta & PCI_EXP_LNKSTA_CLS) == (lnkcap & PCI_EXP_LNKCAP_SLS))
> +		return true;
> +
> +	lnkctl |= PCI_EXP_LNKCTL_RL;
> +	dw_pcie_writel_dbi(dw, offset + PCI_EXP_LNKCTL, lnkctl);
> +
> +	for (i = 0; i < RETRAIN_MAX_RETRY; i++) {
> +		lnksta = dw_pcie_readw_dbi(dw, offset + PCI_EXP_LNKSTA);
> +		if (lnksta & PCI_EXP_LNKSTA_LT)
> +			return true;
> +		usleep_range(1000, 1100);
> +	}
> +
> +	return false;
> +}
> +
> +static int rcar_gen4_pcie_link_up(struct dw_pcie *dw)
> +{
> +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> +	u32 val, mask;
> +
> +	/* Require retraining here. Otherwise RDLH_LINK_UP may not be set */

Any other platform expected to not require retrain?

> +	if (rcar->needs_retrain && !rcar_gen4_pcie_check_retrain_link(dw))
> +		return 0;
> +
> +	val = readl(rcar->base + PCIEINTSTS0);
> +	mask = RDLH_LINK_UP | SMLH_LINK_UP;
> +
> +	return (val & mask) == mask;
> +}
> +
> +static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> +{
> +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> +
> +	rcar_gen4_pcie_ltssm_enable(rcar, true);
> +
> +	return 0;
> +}
> +
> +static void rcar_gen4_pcie_stop_link(struct dw_pcie *dw)
> +{
> +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> +
> +	rcar_gen4_pcie_ltssm_enable(rcar, false);
> +}
> +
> +int rcar_gen4_pcie_set_device_type(struct rcar_gen4_pcie *rcar, bool rc,
> +				   int num_lanes)
> +{
> +	u32 val;
> +
> +	/* Note: Assume the reset is asserted here */

What about this assumption?

> +	val = readl(rcar->base + PCIEMSR0);
> +	if (rc)
> +		val |= DEVICE_TYPE_RC;
> +	else
> +		val |= DEVICE_TYPE_EP;

newline

> +	if (num_lanes < 4)
> +		val |= BIFUR_MOD_SET_ON;

newline

> +	writel(val, rcar->base + PCIEMSR0);
> +
> +	return reset_control_deassert(rcar->rst);
> +}
> +
> +void rcar_gen4_pcie_disable_bar(struct dw_pcie *dw, u32 bar_mask_reg)
> +{
> +	dw_pcie_writel_dbi2(dw, bar_mask_reg, 0x0);
> +}
> +
> +int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
> +{
> +	struct device *dev = rcar->dw.dev;
> +	int err;
> +
> +	pm_runtime_enable(dev);
> +	err = pm_runtime_resume_and_get(dev);

Why do you need do runtime_resume here? You don't have the runtime PM callbacks
implemented. Even if you did, it may end up with a crash as you have't called
dw_pcie_host_init().

Overall, I think you don't need to call any of the pm_runtime APIs now.

> +	if (err < 0) {
> +		dev_err(dev, "Failed to resume/get Runtime PM\n");
> +		pm_runtime_disable(dev);
> +	}
> +
> +	return err;
> +}
> +
> +void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
> +{
> +	struct device *dev = rcar->dw.dev;
> +
> +	if (!reset_control_status(rcar->rst))
> +		reset_control_assert(rcar->rst);
> +	pm_runtime_put(dev);
> +	pm_runtime_disable(dev);
> +}
> +
> +static int rcar_gen4_pcie_devm_reset_get(struct rcar_gen4_pcie *rcar,
> +				  struct device *dev)
> +{
> +	rcar->rst = devm_reset_control_get(dev, NULL);
> +	if (IS_ERR(rcar->rst)) {
> +		dev_err(dev, "Failed to get Cold-reset\n");

Is this cold-reset or core-reset?

- Mani
