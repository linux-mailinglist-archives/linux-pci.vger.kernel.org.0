Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64392750620
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 13:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjGLLf2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jul 2023 07:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGLLf1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2023 07:35:27 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704DF8F;
        Wed, 12 Jul 2023 04:35:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fbcbf4375dso844602e87.0;
        Wed, 12 Jul 2023 04:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689161724; x=1691753724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/MxyB21P7uHFGh51XcBfJsgTqKz+C3t+PUjVRjU/ID4=;
        b=SR9pQA/oTXnxOn3joPRGlwPwCrwpUMGa4yekyZzY1MgOzZEbE/gyuva0K7BWKClPfq
         7Io3rvGm+IewT7eAFWUBa0ai90yIFKxSbsPG/lxUt/JYNDTbbUH8p0jzFLd7t9n1t6td
         /6ZnfgT7jIxhho9arvK1aNt5RaVqdSTbQULyfEEL3yZukPHPwX6eKfYINBATQfp/mtSe
         +qS17laABdNGoOmqzF29HNwlPTH+LACvBV0yzALvg7MmuyIwBKO4NFuydoDuFBTCCD/z
         4eENvX3IWU0ubY0PrKwzBVWIAFDoMxZCcIZZuR4I8WC8zRszuSTiKu2bXXthX/ZAqRnt
         P7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689161724; x=1691753724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MxyB21P7uHFGh51XcBfJsgTqKz+C3t+PUjVRjU/ID4=;
        b=AXlJUbGDns6q315mOgnH3jIGzE5HiYwZOOQ7DZhoH6nfB40nfO7xWkxnmV98RuUWuO
         kj0JAsu1WWN4f+eaTR33HMQWhRRKbWvDYZwJmC16UzBLp+dyxOiFsKw4PsHBNslE6Gea
         oLrlIOlyyv2k+CAvhF0rDcQ6dFXq4njztGP46n5hv0NSIHJ71gO2RyQRqvpD/4Ie4aQB
         vAJ/eX3EwKFqi3qH2u0YbGDECwd1yCCn83FJrHU7L4k7FmIUeFmdi/vxw4WJjear9Pet
         ZrVyr2mhDNKLbYvp878O984V4LylWf5F5AUrQq/UbLJmwB6qffSJsBZUD8sSwi+GQW+q
         fh4A==
X-Gm-Message-State: ABy/qLbaJySEH8hhL0s0+Kx6l+tyc+v5j5fGAflS0NZSrqqSUd9IyWjV
        7BoqCaPeSGAIiqTXs/fzTGw=
X-Google-Smtp-Source: APBJJlHt4TXa4NdBPg9f1QfGbDt4XxhaRjJ+D6IKOKpMFbfclt0AsNAkLOOzzlwiQ5AVC4jfkr6fWQ==
X-Received: by 2002:a05:6512:3051:b0:4f8:4b19:9533 with SMTP id b17-20020a056512305100b004f84b199533mr687221lfb.19.1689161723437;
        Wed, 12 Jul 2023 04:35:23 -0700 (PDT)
Received: from mobilestation ([85.249.22.88])
        by smtp.gmail.com with ESMTPSA id j14-20020a19f50e000000b004f7618c67a7sm668767lfb.76.2023.07.12.04.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 04:35:22 -0700 (PDT)
Date:   Wed, 12 Jul 2023 14:35:19 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v17 17/20] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Message-ID: <knx6kir3ulvc25u6qcxoyxwwpbtcnjfpuigjnsjhtwe47q245m@gdce3voh73k5>
References: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
 <20230705114206.3585188-18-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705114206.3585188-18-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 05, 2023 at 08:42:03PM +0900, Yoshihiro Shimoda wrote:
> Add R-Car Gen4 PCIe Host support. This controller is based on
> Synopsys DesignWare PCIe, but this controller has vendor-specific
> registers so that requires initialization code like mode setting
> and retraining and so on.
> 
> To reduce code delta, adds some helper functions which are used by
> both the host driver and the endpoint driver (which is added
> immediately afterwards) into a separate file.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/Kconfig            |   9 +
>  drivers/pci/controller/dwc/Makefile           |   2 +
>  .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 144 +++++++++++++
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 197 ++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  43 ++++
>  5 files changed, 395 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index ab96da43e0c2..64d4d37bc891 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -415,4 +415,13 @@ config PCIE_VISCONTI_HOST
>  	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
>  	  This driver supports TMPV7708 SoC.
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
> index 000000000000..e7c1eef792ec
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PCIe host controller driver for Renesas R-Car Gen4 Series SoCs
> + * Copyright (C) 2022-2023 Renesas Electronics Corporation
> + */
> +
> +#include <linux/delay.h>
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
> +	gpiod_set_value_cansleep(dw->pe_rst, 1);
> +
> +	ret = clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
> +	if (ret) {
> +		dev_err(dw->dev, "Failed to enable ref clocks\n");
> +		return ret;
> +	}
> +
> +	ret = rcar_gen4_pcie_basic_init(rcar);
> +	if (ret < 0) {
> +		clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
> +		return ret;
> +	}
> +
> +	/*
> +	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
> +	 * Rev.5.20a, we should disable two BARs to avoid unnecessary memory
> +	 * assignment during device enumeration.
> +	 */
> +	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_0, 0x0);
> +	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_1, 0x0);
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		/* Enable MSI interrupt signal */
> +		val = readl(rcar->base + PCIEINTSTS0EN);
> +		val |= MSI_CTRL_INT;
> +		writel(val, rcar->base + PCIEINTSTS0EN);
> +	}
> +
> +	msleep(100);	/* pe_rst requires 100msec delay */
> +
> +	gpiod_set_value_cansleep(dw->pe_rst, 0);
> +
> +	return 0;
> +}
> +
> +static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops = {
> +	.host_init = rcar_gen4_pcie_host_init,
> +};
> +
> +static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar,

> +				   struct platform_device *pdev)

The argument is unused. What about dropping it?

> +{
> +	struct dw_pcie *dw = &rcar->dw;
> +	struct dw_pcie_rp *pp = &dw->pp;
> +
> +	pp->num_vectors = MAX_MSI_IRQS;
> +	pp->ops = &rcar_gen4_pcie_host_ops;
> +
> +	return dw_pcie_host_init(pp);
> +}
> +
> +static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
> +{
> +	dw_pcie_host_deinit(&rcar->dw.pp);
> +	gpiod_set_value_cansleep(rcar->dw.pe_rst, 1);
> +}
> +
> +static int rcar_gen4_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct rcar_gen4_pcie *rcar;
> +	int err;
> +
> +	rcar = rcar_gen4_pcie_devm_alloc(dev);
> +	if (!rcar)
> +		return -ENOMEM;
> +
> +	err = rcar_gen4_pcie_get_resources(rcar, pdev);
> +	if (err < 0) {
> +		dev_err(dev, "Failed to request resource: %d\n", err);
> +		return err;
> +	}
> +

> +	platform_set_drvdata(pdev, rcar);

This could have been moved to rcar_gen4_pcie_devm_alloc(). But see my
last comment first.

> +
> +	err = rcar_gen4_pcie_prepare(rcar);
> +	if (err < 0)
> +		return err;
> +

> +	rcar->mode = DW_PCIE_RC_TYPE;

What about moving this to the rcar_gen4_add_dw_pcie_rp() method? Thus
it will look similar to the rcar_gen4_add_pcie_ep() method you
implemented in the Rcar Gen4 EP driver.

> +	err = rcar_gen4_add_dw_pcie_rp(rcar, pdev);
> +	if (err < 0)
> +		goto err_add;
> +
> +	return 0;
> +
> +err_add:
> +	rcar_gen4_pcie_unprepare(rcar);
> +
> +	return err;
> +}
> +

> +static int rcar_gen4_pcie_remove(struct platform_device *pdev)
> +{
> +	struct rcar_gen4_pcie *rcar = platform_get_drvdata(pdev);
> +
> +	rcar_gen4_remove_dw_pcie_rp(rcar);
> +	rcar_gen4_pcie_unprepare(rcar);
> +
> +	return 0;
> +}

Please convert this function to returning void and assign to the
platform_driver.remove_new pointer instead.

> +
> +static const struct of_device_id rcar_gen4_pcie_of_match[] = {
> +	{ .compatible = "renesas,rcar-gen4-pcie", },
> +	{},
> +};
> +
> +static struct platform_driver rcar_gen4_pcie_driver = {
> +	.driver = {
> +		.name = "pcie-rcar-gen4",
> +		.of_match_table = rcar_gen4_pcie_of_match,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.probe = rcar_gen4_pcie_probe,

> +	.remove = rcar_gen4_pcie_remove,

ditto

> +};
> +module_platform_driver(rcar_gen4_pcie_driver);
> +
> +MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe host controller driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> new file mode 100644
> index 000000000000..2cd5c17c1695
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -0,0 +1,197 @@
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
> +#define RCAR_NUM_SPEED_CHANGE_RETRIES	10
> +#define RCAR_MAX_LINK_SPEED		4
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
> +		/*
> +		 * Since the datasheet of R-Car doesn't mention how to assert
> +		 * the APP_HOLD_PHY_RST, don't assert it again. Otherwise,
> +		 * hang-up issue happened in the dw_edma_core_off() when
> +		 * the controller didn't detect a PCI device.
> +		 */
> +		val &= ~APP_LTSSM_ENABLE;
> +	}
> +	writel(val, rcar->base + PCIERSTCTRL1);
> +}
> +
> +static int rcar_gen4_pcie_link_up(struct dw_pcie *dw)
> +{
> +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> +	u32 val, mask;
> +
> +	val = readl(rcar->base + PCIEINTSTS0);
> +	mask = RDLH_LINK_UP | SMLH_LINK_UP;
> +
> +	return (val & mask) == mask;
> +}
> +
> +static bool rcar_gen4_pcie_speed_change(struct dw_pcie *dw)
> +{
> +	u32 val;
> +	int i;
> +
> +	val = dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
> +	val &= ~PORT_LOGIC_SPEED_CHANGE;
> +	dw_pcie_writel_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> +
> +	val = dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
> +	val |= PORT_LOGIC_SPEED_CHANGE;
> +	dw_pcie_writel_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> +
> +	for (i = 0; i < RCAR_NUM_SPEED_CHANGE_RETRIES; i++) {
> +		val = dw_pcie_readl_dbi(dw, PCIE_LINK_WIDTH_SPEED_CONTROL);
> +		if (!(val & PORT_LOGIC_SPEED_CHANGE))
> +			return true;
> +		usleep_range(10000, 11000);
> +	}
> +
> +	return false;
> +}
> +
> +static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> +{
> +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> +	int i, changes;
> +
> +	rcar_gen4_pcie_ltssm_enable(rcar, true);
> +
> +	/*
> +	 * Require direct speed change with retrying here if the link_gen is

> +	 * PCIe Gen2 or later.

s/later/higher

> +	 */
> +	changes = min_not_zero(dw->link_gen, RCAR_MAX_LINK_SPEED) - 1;
> +
> +	/*
> +	 * Since dw_pcie_setup_rc() sets it once, PCIe Gen2 will be trained.

> +	 * So, this needs remaining times for PCIe Gen4 if RC mode.

For "_up to_ PCIe Gen4", isn't it? Because AFAIR PCIe Gen3 will need
to have one changes-iteration for RC mode.

> +	 */
> +	if (changes && rcar->mode == DW_PCIE_RC_TYPE)
> +		changes--;
> +
> +	for (i = 0; i < changes; i++) {
> +		if (!rcar_gen4_pcie_speed_change(dw))
> +			break;	/* No error because possible disconnected here if EP mode */
> +	}
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
> +int rcar_gen4_pcie_basic_init(struct rcar_gen4_pcie *rcar)
> +{
> +	struct dw_pcie *dw = &rcar->dw;
> +	u32 val;
> +
> +	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc))
> +		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
> +
> +	val = readl(rcar->base + PCIEMSR0);
> +	if (rcar->mode == DW_PCIE_RC_TYPE)
> +		val |= DEVICE_TYPE_RC;
> +	else if (rcar->mode == DW_PCIE_EP_TYPE)
> +		val |= DEVICE_TYPE_EP;
> +	else
> +		return -EINVAL;
> +
> +	if (dw->num_lanes < 4)
> +		val |= BIFUR_MOD_SET_ON;
> +
> +	writel(val, rcar->base + PCIEMSR0);
> +
> +	return reset_control_deassert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
> +}
> +
> +int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
> +{
> +	struct device *dev = rcar->dw.dev;
> +	int err;
> +
> +	pm_runtime_enable(dev);
> +	err = pm_runtime_resume_and_get(dev);
> +	if (err < 0) {
> +		dev_err(dev, "Failed to resume/get Runtime PM\n");
> +		pm_runtime_disable(dev);
> +	}
> +

> +	dw_pcie_cap_set(&rcar->dw, REQ_RES);

Hmm, why is this here? Isn't it more appropriate to have it in
rcar_gen4_pcie_devm_alloc() together with the EDMA_UNROLL flag
setting? REQ_RES flag indicates a request for the driver core to get
the generic DW PCIe RP/EP resources. It doesn't look as being
suitable to be set in a prepare()-like method.

> +
> +	return err;
> +}
> +
> +void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
> +{
> +	struct device *dev = rcar->dw.dev;
> +	struct dw_pcie *dw = &rcar->dw;
> +

> +	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc))
> +		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);

The de-assertion is performed in rcar_gen4_pcie_basic_init() which is
called from the host_init() method. The respective antagonist is
supposed to be performed in the host_deinit() in order to revert the
changes on any error spotted in the host_init() and have a fully
cleaned up device on the remove() procedure. Having something like
rcar_gen4_pcie_basic_deinit() for it seems suitable.

BTW I would have added dw->pe_rst assertion to
dw_pcie_host_ops.host_deinit() too.

> +	pm_runtime_put(dev);
> +	pm_runtime_disable(dev);
> +}
> +
> +int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar,
> +				 struct platform_device *pdev)
> +{
> +	/* Renesas-specific registers */
> +	rcar->base = devm_platform_ioremap_resource_byname(pdev, "app");
> +	if (IS_ERR(rcar->base))
> +		return PTR_ERR(rcar->base);
> +
> +	return 0;
> +}
> +
> +static const struct dw_pcie_ops dw_pcie_ops = {
> +	.start_link = rcar_gen4_pcie_start_link,
> +	.stop_link = rcar_gen4_pcie_stop_link,
> +	.link_up = rcar_gen4_pcie_link_up,
> +};
> +
> +struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct device *dev)
> +{
> +	struct rcar_gen4_pcie *rcar;
> +
> +	rcar = devm_kzalloc(dev, sizeof(*rcar), GFP_KERNEL);
> +	if (!rcar)
> +		return NULL;
> +
> +	rcar->dw.dev = dev;
> +	rcar->dw.ops = &dw_pcie_ops;
> +	dw_pcie_cap_set(&rcar->dw, EDMA_UNROLL);
> +
> +	return rcar;
> +}
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.h b/drivers/pci/controller/dwc/pcie-rcar-gen4.h
> new file mode 100644
> index 000000000000..e9cb816b33fa
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * PCIe host/endpoint controller driver for Renesas R-Car Gen4 Series SoCs
> + * Copyright (C) 2022-2023 Renesas Electronics Corporation
> + */
> +
> +#ifndef _PCIE_RCAR_GEN4_H_
> +#define _PCIE_RCAR_GEN4_H_
> +
> +#include <linux/io.h>
> +#include <linux/pci.h>
> +
> +#include "pcie-designware.h"
> +
> +/* Renesas-specific */
> +#define PCIEMSR0		0x0000
> +#define  BIFUR_MOD_SET_ON	BIT(0)
> +#define  DEVICE_TYPE_EP		0
> +#define  DEVICE_TYPE_RC		BIT(4)
> +
> +#define PCIEINTSTS0		0x0084
> +#define PCIEINTSTS0EN		0x0310
> +#define  MSI_CTRL_INT		BIT(26)
> +#define  SMLH_LINK_UP		BIT(7)
> +#define  RDLH_LINK_UP		BIT(6)
> +#define PCIEDMAINTSTSEN		0x0314
> +#define  PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
> +
> +struct rcar_gen4_pcie {
> +	enum dw_pcie_device_mode mode;

> +	struct dw_pcie dw;

By moving this field to the head of the structure you'll have a
zero offset dw field with respect to the base-address of the
container. This will convert the container_of() macro to the just
type-cast.

> +	void __iomem *base;
> +};

> +#define to_rcar_gen4_pcie(x)	dev_get_drvdata((x)->dev)

Why? You have dw_pcie instance embedded into the rcar_gen4_pcie
structure. What about using the container_of() pattern then?
+#define to_rcar_gen4_pcie(_dw) container_of(_dw, struct rcar_gen4_pcie, dw)

> +
> +int rcar_gen4_pcie_basic_init(struct rcar_gen4_pcie *rcar);

> +int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *pcie);
> +void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *pcie);

s/pcie/rcar

> +int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar,

> +				 struct platform_device *pdev);
> +struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct device *dev);

Just a general note you may find useful. If I were you I would have
added struct platform_device *pdev field to struct rcar_gen4_pcie and
initialized it in the rcar_gen4_pcie_devm_alloc() method (it shall
accept the platform_device pointer argument instead of just device).
Thus you'll always have the {platform_}device pointer around as soon
as you have the rcar_gen4_pcie pointer available which much more
common case in the most of LLDD. This will greatly simplify any
possible driver updates in future. Moreover you won't need to pass an
additional device-pointer to the methods defined in your driver. For
instance, in that case the rcar_gen4_pcie_get_resources() will need to
accept just rcar_gen4_pcie pointer. Thus it will look unified aside
with the rest of the methods in your driver.

-Serge(y)

> +
> +#endif /* _PCIE_RCAR_GEN4_H_ */
> -- 
> 2.25.1
> 
