Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5296F6C522A
	for <lists+linux-pci@lfdr.de>; Wed, 22 Mar 2023 18:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCVRRb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Mar 2023 13:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjCVRRW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2023 13:17:22 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789F36783E;
        Wed, 22 Mar 2023 10:16:51 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s20so12511257ljp.1;
        Wed, 22 Mar 2023 10:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679505392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=95QggApeiE6UUSLBAKtgnZhmsmodKv4WyW/6u1U3Ll0=;
        b=kSmQGWFb5qZmhRcZvZibnXcFlsW7Hkg85sbdrvRfPbpeOhR5SuGOZwnw4PB8BjdTNX
         Pi3qXO/S8N+Oeoux7LqphVrUqJ1lXcsQ9QFNNlGjqPrPvy49LNO3wopUO+Rn5Evj/YMv
         u/6rtqGPJ6MAq+s8TqR6b4qLuCbcdwyIvtgKjxb61+/TnTQaTWxROIkcRHlXsnuIdtTo
         PeUjkMI2plTAdoan46lC8Ep7UHJYNku7YQCJ1bSwHXOFzXoCAN5etXCtDtY+QjGL+LlJ
         +QxR96Wqcl8WceCQAc7EM25r899dF6c8IhSEUCNoerxrG2Mw3GvEFH4aCJAuSN2oBxAJ
         HwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95QggApeiE6UUSLBAKtgnZhmsmodKv4WyW/6u1U3Ll0=;
        b=7gBUlGpXC/sPNmoh/460Dt4jIbWaiyCsvLh1e6uo3ZLdMIhQ792Do0QjzJ58AnUu3/
         nwZSN4XA5O6qoauPxp7lqmS9lmoJdJg053SOIMOl4nE7GPunXai/GxL2d1rlvQT6QKF1
         51zfNOCnQw90appPUQx3gCfh1DfBT+ng+YCzF08t3tOfW3yQWTTuwV2HBpUDA3Xl7599
         FOfRVON4b7UE6KZWsLT24/nnMFk6/SdM9b/qkOO/K9vA7RRQp6KsDnKyUvp5mYpsRlNR
         S+Y6tNkKtrECbpUFNhd4yCTFqUOY5hiUEGcYwzFZTwGm+cJSydGiYqhxrxyXCjTFwOlA
         rmFg==
X-Gm-Message-State: AO0yUKUb739V8CWqzB2mNOM/PnWY6FvusheW3Ayp1G1Bhrbio8lQiI2D
        cH8pdekfPw6agFTRgeHWG3g=
X-Google-Smtp-Source: AK7set+IbGsLyYpXpnNcw+enIUkAQsm5DJ4BCYv73dTJ6ivznv+zthuT6lxSrmLn8oCCAmOjKjJfrw==
X-Received: by 2002:a2e:9085:0:b0:293:6020:19db with SMTP id l5-20020a2e9085000000b00293602019dbmr2388362ljg.14.1679505391739;
        Wed, 22 Mar 2023 10:16:31 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id y20-20020ac24214000000b004e048852377sm2628631lfh.263.2023.03.22.10.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:16:31 -0700 (PDT)
Date:   Wed, 22 Mar 2023 20:16:28 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, Sergey.Semin@baikalelectronics.ru,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v11 10/13] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Message-ID: <20230322171628.4jniegwhln4ong2g@mobilestation>
References: <20230310123510.675685-1-yoshihiro.shimoda.uh@renesas.com>
 <20230310123510.675685-11-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310123510.675685-11-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 10, 2023 at 09:35:07PM +0900, Yoshihiro Shimoda wrote:
> Add R-Car Gen4 PCIe Host support. This controller is based on
> Synopsys DesignWare PCIe.
> 
> This controller doesn't support MSI-X interrupt. So, introduce
> no_msix flag in struct dw_pcie_host_ops to clear MSI_FLAG_PCI_MSIX
> from dw_pcie_msi_domain_info.
> 
> Note that this controller on R-Car S4-8 has an unexpected register
> value on the dbi+0x97b register. So, add a new capability flag
> which would force the unrolled eDMA mapping for the problematic
> device, as suggested by Serge Semin.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/Kconfig            |   9 +
>  drivers/pci/controller/dwc/Makefile           |   2 +
>  drivers/pci/controller/dwc/pcie-designware.c  |   8 +-
>  drivers/pci/controller/dwc/pcie-designware.h  |   5 +-
>  .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 134 +++++++++++++++
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 156 ++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  56 +++++++
>  7 files changed, 367 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 434f6a4f4041..94805ec31a8f 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -414,4 +414,13 @@ config PCIE_FU740
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
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 364926832126..6827d42fcb2c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -882,8 +882,14 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>  	 * Indirect eDMA CSRs access has been completely removed since v5.40a
>  	 * thus no space is now reserved for the eDMA channels viewport and
>  	 * former DMA CTRL register is no longer fixed to FFs.

> +	 *
> +	 * Note some devices for unknown reason may have zeros in the eDMA CTRL
> +	 * register even though the HW-manual explicitly states there must FFs
> +	 * if the unrolled mapping is enabled. For such cases the low-level
> +	 * drivers are supposed to manually activate the unrolled mapping to
> +	 * bypass the auto-detection procedure.
>  	 */
> -	if (dw_pcie_ver_is_ge(pci, 540A))
> +	if (dw_pcie_ver_is_ge(pci, 540A) || dw_pcie_cap_is(pci, EDMA_UNROLL))

Again. Please detach to a preparation patch. Even though it's related
to your driver it's still a generic separate feature and having it
applied together with your driver doesn't really make it more coherent
but more complex.

>  		val = 0xFFFFFFFF;
>  	else
>  		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 3dbadb8043ab..1be74d2c3729 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -51,8 +51,9 @@
>  
>  /* DWC PCIe controller capabilities */
>  #define DW_PCIE_CAP_REQ_RES		0
> -#define DW_PCIE_CAP_IATU_UNROLL		1
> -#define DW_PCIE_CAP_CDM_CHECK		2
> +#define DW_PCIE_CAP_EDMA_UNROLL		1
> +#define DW_PCIE_CAP_IATU_UNROLL		2
> +#define DW_PCIE_CAP_CDM_CHECK		3
>  
>  #define dw_pcie_cap_is(_pci, _cap) \
>  	test_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> new file mode 100644
> index 000000000000..4aaecc813d85
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
> +	ret = rcar_gen4_pcie_set_device_type(rcar, true, dw->num_lanes);
> +	if (ret < 0)
> +		return ret;
> +
> +	dw_pcie_dbi_ro_wr_en(dw);
> +

> +	rcar_gen4_pcie_disable_bar(dw, BAR0MASKF);
> +	rcar_gen4_pcie_disable_bar(dw, BAR1MASKF);

I'll ask it one more time. Why do you need these calls? None of the
DW PCIe RC glue-drivers perform the BARs disabling. Moreover you won't
disable them by using the methods above because there is no shadow
DBI2 CSRs behind the TYPe1.BAR{0,1} CSRs. So AFAICS you can just drop
the calls.

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
> +

> +	dw_pcie_setup_rc(pp);

This will be done shortly after this function returns. Why do you need
it here? AFAICS you can drop it.

> +
> +	dw_pcie_dbi_ro_wr_en(dw);

> +	dw_pcie_num_lanes_setup(dw, dw->num_lanes);

* Please see my note to the respective patch.

So if all my suggestions are implemented the rcar_gen4_pcie_host_init()
will contain only the true platform-specific initializations.

> +	dw_pcie_dbi_ro_wr_dis(dw);
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
> index 000000000000..4908892e413b
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PCIe host/endpoint controller driver for Renesas R-Car Gen4 Series SoCs
> + * Copyright (C) 2022-2023 Renesas Electronics Corporation
> + */
> +
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
> +	val = readl(rcar->base + PCIEMSR0);
> +	if (rc)
> +		val |= DEVICE_TYPE_RC;
> +	else
> +		val |= DEVICE_TYPE_EP;
> +	if (num_lanes < 4)
> +		val |= BIFUR_MOD_SET_ON;
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
> index 000000000000..786f80418aab
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.h
> @@ -0,0 +1,56 @@
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
> +/* BAR Mask registers */

> +#define BAR0MASKF		0x1010
> +#define BAR1MASKF		0x1014
> +#define BAR2MASKF		0x1018
> +#define BAR3MASKF		0x101c
> +#define BAR4MASKF		0x1020
> +#define BAR5MASKF		0x1024

I don't get it. You have DBI2 at the 0x1000 offset with respect to
the DBI base address. But the BARx CSRs are defined in additional
0x1000 offset. So it's 0x2000 all together. How come? This doesn't
seem right. In accordance with the DW PCIe EP manuals the shadow BARx
CSRs are defined within the DBI2 space at the normal offsets (0x10,
0x14, 0x18, 0x1c, 0x20, 0x24). So in case of the DW PCIe _EP_ you'll
only need to call dw_pcie_writel_dbi2(dw, {0x10, 0x14, 0x18, 0x1c, 0x20, 0x24}, 0x0);
in order to disable the BARs. Am I missing something? Could you double
check this for the _end-point_ part of the driver?

-Serge(y)

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
> +};
> +#define to_rcar_gen4_pcie(x)	dev_get_drvdata((x)->dev)
> +
> +u32 rcar_gen4_pcie_readl(struct rcar_gen4_pcie *pcie, u32 reg);
> +void rcar_gen4_pcie_writel(struct rcar_gen4_pcie *pcie, u32 reg, u32 val);
> +int rcar_gen4_pcie_set_device_type(struct rcar_gen4_pcie *rcar, bool rc,
> +				   int num_lanes);
> +void rcar_gen4_pcie_disable_bar(struct dw_pcie *dw, u32 bar_mask_reg);
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
> 
