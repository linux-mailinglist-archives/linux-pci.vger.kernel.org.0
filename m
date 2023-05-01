Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191BF6F39D0
	for <lists+linux-pci@lfdr.de>; Mon,  1 May 2023 23:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjEAVdT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 May 2023 17:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjEAVdS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2023 17:33:18 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE25E5A;
        Mon,  1 May 2023 14:33:16 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2a7ac89b82dso28866351fa.1;
        Mon, 01 May 2023 14:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682976795; x=1685568795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ukx7s8ecSpJ2JCkqnPCqhBNzCJaL9CTV/PypsI16NuU=;
        b=QD0Xoz+OXXCiY9i3GGk3IP1GYZx2ZVzEOgSgEa0lgFsKDXA+LAwPFVIrVjUaNqrVhf
         fKWVjNiRx71+Dxf9Tnx8hQWXF70u+9DFhOyJ2vvYHSq/h+iBVpJe65aYJYZH6hFEx/tk
         aVlk53Lmk3EB4ssSxWsjN7AFe1UO0vr6LxJmd/8cgTYJyvCBlYLCpz7HjCmjSxF0u89o
         DMlay1Q5aBfag3bPN2IGC9OPangW8bRWvYzYhULRcZ1o735XPppEuP0FMHvyxpCgMcwr
         3dUxUYWYtNEIry4JfFZci2Gr9kZHdvmB4xyKGew5PpjxgOtxRzKhBILoR5WLcmrNHGjP
         /new==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682976795; x=1685568795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukx7s8ecSpJ2JCkqnPCqhBNzCJaL9CTV/PypsI16NuU=;
        b=DNXhb7C5uTdLwQ+e+H2rJSSBw4cTj5klHmI1LFPuHBgjL+iUyAiUlf59QmUXxfnWyU
         sMsoWG22n+HZfjRZ6oj49zofiAqFu3IvlZ77QlNO3JrnJH54jru4hybERYyu+pvu9n2+
         LbjPiAsmaV8Y2N2+FXLDfCXRf7RM816HA2DfHXaw+nndQyLAMvqqLVC1E9qPHqCyfG7L
         YVHyniI8dBSeVd8ThHSrdO5SQveV+jJV5JTolbc61UVnCNStkNQP+VKRLGe3Fq68lb+R
         tyCCUOcd4xSx5r4IukzUYYzSVDf2v/NmWfPH+EbiAUvL0FAndXCcRpweJQTbFY7EVnX/
         UvgA==
X-Gm-Message-State: AC+VfDzbwxfmue5lg9QN28sIwjzWRIgqyCk7OOS65/qbuzZ3BaiWo4z7
        lsegcWT6cfaVi1omK6Y+GOY=
X-Google-Smtp-Source: ACHHUZ4sInDLh0+3QSbA2zJAoLWwpjQYDjZjNlyhx7fjzMBmA559egUJn23vnyloTLmlNdNwS+hVpQ==
X-Received: by 2002:a2e:740c:0:b0:2a7:73c9:4913 with SMTP id p12-20020a2e740c000000b002a773c94913mr3719750ljc.30.1682976794271;
        Mon, 01 May 2023 14:33:14 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id h18-20020a2e9012000000b002a7a5201bfdsm4868004ljg.80.2023.05.01.14.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 14:33:13 -0700 (PDT)
Date:   Tue, 2 May 2023 00:33:11 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, bhelgaas@google.com,
        kishon@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v14 18/21] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Message-ID: <20230501213311.fw62qymnxkdbbk4r@mobilestation>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
 <20230426045557.3613826-19-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426045557.3613826-19-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 26, 2023 at 01:55:54PM +0900, Yoshihiro Shimoda wrote:
> Add R-Car Gen4 PCIe Host support. This controller is based on
> Synopsys DesignWare PCIe, but this controller has vendor-specific
> registers so that requires initialization code like mode setting
> and retraining and so on.
> 
> To reduce code delta, adds some helper functions which are used by
> both the host driver and the endpoint driver (whitch is added

s/whitch/which

> immediately afterwards) into a separate file.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/Kconfig            |   9 +
>  drivers/pci/controller/dwc/Makefile           |   2 +
>  .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 141 +++++++++++++
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 187 ++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  48 +++++
>  5 files changed, 387 insertions(+)
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
> index 000000000000..df7d80f1874f
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> @@ -0,0 +1,141 @@
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
> +	ret = rcar_gen4_pcie_set_device_type(rcar, true, dw->num_lanes);
> +	if (ret < 0)
> +		return ret;
> +
> +	dw_pcie_dbi_ro_wr_en(dw);
> +
> +	/*
> +	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
> +	 * Rev.5.20a, we should disable two BARs to avoid unnecessary memory
> +	 * assignment during device enumeration.
> +	 */
> +	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_0, 0x0);
> +	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_1, 0x0);
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
> +{
> +	struct dw_pcie *dw = &rcar->dw;
> +	struct dw_pcie_rp *pp = &dw->pp;
> +
> +	pp->num_vectors = MAX_MSI_IRQS;
> +	pp->ops = &rcar_gen4_pcie_host_ops;
> +	dw_pcie_cap_set(dw, REQ_RES);
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
> +
> +	err = rcar_gen4_pcie_prepare(rcar);
> +	if (err < 0)
> +		return err;
> +
> +	rcar->needs_retrain = true;
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
> +};
> +module_platform_driver(rcar_gen4_pcie_driver);
> +
> +MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe host controller driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> new file mode 100644
> index 000000000000..ee916a149708
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

> +	/*
> +	 * Require retraining here. Otherwise RDLH_LINK_UP of PCIEINTSTS0 which
> +	 * is this controller specific register may not be set.
> +	 */
> +	if (rcar->needs_retrain && !rcar_gen4_pcie_check_retrain_link(dw))
> +		return 0;

Retraining the link on each link-up test doesn't seem right. What
about moving the PCI_EXP_LNKCTL.PCI_EXP_LNKCTL_RL field update to the
start_link() callback? Will that be enough to make sure that the link
will be established afterwards?
* Note on Baikal-T1 PCIe we also have had a problem with establishing
* the higher gen link. (It's Gen3 in our case.) But instead of
* re-training the link all over we get to set the
* GEN2_CTRL_OFF.DIRECT_SPEED_CHANGE flag which causes the higher gen
* link establishment right away. Please see
* pcie-bt1.c:bt1_pcie_start_link() function for reference.

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
> +	/* Note: Assume the rcar->rst which is Cold-reset is asserted here */
> +	val = readl(rcar->base + PCIEMSR0);
> +	if (rc)
> +		val |= DEVICE_TYPE_RC;
> +	else
> +		val |= DEVICE_TYPE_EP;
> +
> +	if (num_lanes < 4)
> +		val |= BIFUR_MOD_SET_ON;
> +
> +	writel(val, rcar->base + PCIEMSR0);
> +
> +	return reset_control_deassert(rcar->rst);
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
> +		return PTR_ERR(rcar->rst);
> +	}
> +
> +	return 0;
> +}

Since v9 this method has been no longer globally defined. What about
moving its content to rcar_gen4_pcie_get_resources()? Thus the later
will still look coherent meanwhile we'll be able to drop an
excessive function definition with no harm to the code readability.

> +
> +int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar,
> +				 struct platform_device *pdev)
> +{
> +	struct dw_pcie *dw = &rcar->dw;
> +
> +	/* Renesas-specific registers */
> +	rcar->base = devm_platform_ioremap_resource_byname(pdev, "app");
> +	if (IS_ERR(rcar->base))
> +		return PTR_ERR(rcar->base);
> +
> +	return rcar_gen4_pcie_devm_reset_get(rcar, dw->dev);
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
> index 000000000000..7c765c2d79b9
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.h
> @@ -0,0 +1,48 @@
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
> +#include <linux/reset.h>
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
> +	struct dw_pcie		dw;
> +	void __iomem		*base;
> +	struct reset_control	*rst;
> +	bool			needs_retrain;
> +};
> +#define to_rcar_gen4_pcie(x)	dev_get_drvdata((x)->dev)
> +

> +u32 rcar_gen4_pcie_readl(struct rcar_gen4_pcie *pcie, u32 reg);
> +void rcar_gen4_pcie_writel(struct rcar_gen4_pcie *pcie, u32 reg, u32 val);

I don't see these methods being defined here.

-Serge(y)

> +int rcar_gen4_pcie_set_device_type(struct rcar_gen4_pcie *rcar, bool rc,
> +				   int num_lanes);
> +int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *pcie);
> +void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *pcie);
> +int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar,
> +				 struct platform_device *pdev);
> +struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct device *dev);
> +
> +#endif /* _PCIE_RCAR_GEN4_H_ */
> -- 
> 2.25.1
> 
