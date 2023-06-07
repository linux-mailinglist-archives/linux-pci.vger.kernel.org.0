Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD2C725E6A
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 14:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240105AbjFGMPy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 08:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240508AbjFGMPu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 08:15:50 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663F91BE6;
        Wed,  7 Jun 2023 05:15:43 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so8921796e87.2;
        Wed, 07 Jun 2023 05:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686140141; x=1688732141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BhELSTA/3Pp7VxR7LhxzSs7tXAsirV2Z88ro8FL9zKw=;
        b=lLQFdYYRMLerqsIBS89jdBJy0ZN62r92vQhBjs2RS/5pM1S7cnOufTYTBttdbSkP36
         IJ0MgbPeSjrDIgxAUDq+nFGy7WWS6u0P2q3HN0GREh25P4fe+Di10Q+C2QXAbo1eUnEL
         hvcnN/yYKPHzxF29yod9G/Rgt79xWoQGfU7gsoJX7qinOsyQx/KWXiEGFJ3OsIp+FxHm
         njujuvnFWa2RJv3KPzlsXUrJuSp91koKdRnK7iXZqnj1Y0Q4gKGtPrcaWo6WJqRs4Qk5
         r99u7lKkY47Muxc9CBYWVRjSzNThaQR2Do4cXmmGoLpDrusdsxn8ZaWQjycWrSCcjexf
         Adyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686140141; x=1688732141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhELSTA/3Pp7VxR7LhxzSs7tXAsirV2Z88ro8FL9zKw=;
        b=jQalHBw8H3waLYDz7EA24SV8vM2x6iHvQrgpRTprTu48QQQ0OkPlQUic61s4cGHJaB
         FZqJa/0s11umCUCUCx/RF6ioOO8LU0qFpRHzfuflXYddf2tEOWhEB7UKl2EVlaXRzOZ7
         7r6wzOrBXxUE5XyFVn9GVQuN6etpouFzD6W3RbihmNElv8+WswHH8N+ffPUBaaNbAFOH
         /wKi/ibWtPvj2y2EjUbJUhEF2qf50+2gzNQEsIAC7W1SJ2OI28JCkYmVboRa4e8Z39fs
         GdRWp6nvIyq9zE1DMrNQf3CYqVx0jMbNMDfgRsAsdsgORU2s/HIcle8fRfFigWyxWmxl
         GaGA==
X-Gm-Message-State: AC+VfDypQjd49c4brTMBiVzFSvKPdO2qiZaKDJWrdO57cVlrob3fGS3p
        lrptykxgWJY+S54cCOalL/U=
X-Google-Smtp-Source: ACHHUZ5y0R35+emXTyCoXAyPuv5AFtHbBQqLloWn5xIca8D/pgr0B/5MPEbUt21yslWbi4xWtdgmdA==
X-Received: by 2002:a05:6512:61:b0:4f6:217a:561e with SMTP id i1-20020a056512006100b004f6217a561emr2167100lfo.37.1686140141198;
        Wed, 07 Jun 2023 05:15:41 -0700 (PDT)
Received: from mobilestation ([91.144.185.176])
        by smtp.gmail.com with ESMTPSA id w20-20020ac254b4000000b004f6393659f7sm529321lfk.245.2023.06.07.05.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:15:40 -0700 (PDT)
Date:   Wed, 7 Jun 2023 15:15:33 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v16 19/22] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Message-ID: <20230607121533.cxvidvdqat5h2tqu@mobilestation>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-20-yoshihiro.shimoda.uh@renesas.com>
 <20230605143908.fcgqzedp7oiarbyu@mobilestation>
 <TYBPR01MB5341A67CF6DFFCB396F13195D853A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB5341A67CF6DFFCB396F13195D853A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 07, 2023 at 02:59:20AM +0000, Yoshihiro Shimoda wrote:
> Hello Serge,
> 
> > From: Serge Semin, Sent: Monday, June 5, 2023 11:39 PM
> > 
> > On Wed, May 10, 2023 at 03:22:31PM +0900, Yoshihiro Shimoda wrote:
> > > Add R-Car Gen4 PCIe Host support. This controller is based on
> > > Synopsys DesignWare PCIe, but this controller has vendor-specific
> > > registers so that requires initialization code like mode setting
> > > and retraining and so on.
> > >
> > > To reduce code delta, adds some helper functions which are used by
> > > both the host driver and the endpoint driver (which is added
> > > immediately afterwards) into a separate file.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > ---
> > >  drivers/pci/controller/dwc/Kconfig            |   9 +
> > >  drivers/pci/controller/dwc/Makefile           |   2 +
> > >  .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 141 +++++++++++++
> > >  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 190 ++++++++++++++++++
> > >  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  46 +++++
> > >  5 files changed, 388 insertions(+)
> > >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> > >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h
> > >
> > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > > index ab96da43e0c2..64d4d37bc891 100644
> > > --- a/drivers/pci/controller/dwc/Kconfig
> > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > @@ -415,4 +415,13 @@ config PCIE_VISCONTI_HOST
> > >  	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
> > >  	  This driver supports TMPV7708 SoC.
> > >
> > > +config PCIE_RCAR_GEN4
> > > +	tristate "Renesas R-Car Gen4 PCIe Host controller"
> > > +	depends on ARCH_RENESAS || COMPILE_TEST
> > > +	depends on PCI_MSI
> > > +	select PCIE_DW_HOST
> > > +	help
> > > +	  Say Y here if you want PCIe host controller support on R-Car Gen4 SoCs.
> > > +	  This uses the DesignWare core.
> > > +
> > >  endmenu
> > > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> > > index bf5c311875a1..486cf706b53d 100644
> > > --- a/drivers/pci/controller/dwc/Makefile
> > > +++ b/drivers/pci/controller/dwc/Makefile
> > > @@ -26,6 +26,8 @@ obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
> > >  obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
> > >  obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
> > >  obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
> > > +pcie-rcar-gen4-host-drv-objs := pcie-rcar-gen4.o pcie-rcar-gen4-host.o
> > > +obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4-host-drv.o
> > >
> > >  # The following drivers are for devices that use the generic ACPI
> > >  # pci_root.c driver but don't support standard ECAM config access.
> > > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> > > new file mode 100644
> > > index 000000000000..df7d80f1874f
> > > --- /dev/null
> > > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> > > @@ -0,0 +1,141 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * PCIe host controller driver for Renesas R-Car Gen4 Series SoCs
> > > + * Copyright (C) 2022-2023 Renesas Electronics Corporation
> > > + */
> > > +
> > > +#include <linux/delay.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/pci.h>
> > > +#include <linux/platform_device.h>
> > > +
> > > +#include "pcie-rcar-gen4.h"
> > > +#include "pcie-designware.h"
> > > +
> > > +static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
> > > +{
> > > +	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
> > > +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> > > +	int ret;
> > > +	u32 val;
> > > +
> > > +	gpiod_set_value_cansleep(dw->pe_rst, 1);
> > > +
> > > +	ret = rcar_gen4_pcie_set_device_type(rcar, true, dw->num_lanes);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > 
> > > +	dw_pcie_dbi_ro_wr_en(dw);
> > 
> > Are you sure dw_pcie_dbi_ro_wr_en() and dw_pcie_dbi_ro_wr_dis() are
> > needed? In accordance with the DW PCIe Dual-mode HW manual the BARx
> > registers are W-only over the DBI2 map with no need in setting the
> > DBI_RO_WR_EN flag.
> > 
> > Please check that on your hardware.
> 
> You're correct. They are not needed. So, I'll drop this on v17.
> 
> > > +
> > > +	/*
> > > +	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
> > > +	 * Rev.5.20a, we should disable two BARs to avoid unnecessary memory
> > > +	 * assignment during device enumeration.
> > > +	 */
> > > +	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_0, 0x0);
> > > +	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_1, 0x0);
> > > +
> > 
> > > +	dw_pcie_dbi_ro_wr_dis(dw);
> > 
> > ditto
> 
> I'll drop this too.
> 
> > > +
> > > +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > > +		/* Enable MSI interrupt signal */
> > > +		val = readl(rcar->base + PCIEINTSTS0EN);
> > > +		val |= MSI_CTRL_INT;
> > > +		writel(val, rcar->base + PCIEINTSTS0EN);
> > > +	}
> > > +
> > > +	msleep(100);	/* pe_rst requires 100msec delay */
> > > +
> > > +	gpiod_set_value_cansleep(dw->pe_rst, 0);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops = {
> > > +	.host_init = rcar_gen4_pcie_host_init,
> > > +};
> > > +
> > > +static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar,
> > > +				   struct platform_device *pdev)
> > > +{
> > > +	struct dw_pcie *dw = &rcar->dw;
> > > +	struct dw_pcie_rp *pp = &dw->pp;
> > > +
> > > +	pp->num_vectors = MAX_MSI_IRQS;
> > > +	pp->ops = &rcar_gen4_pcie_host_ops;
> > > +	dw_pcie_cap_set(dw, REQ_RES);
> > > +
> > > +	return dw_pcie_host_init(pp);
> > > +}
> > > +
> > > +static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
> > > +{
> > > +	dw_pcie_host_deinit(&rcar->dw.pp);
> > > +	gpiod_set_value_cansleep(rcar->dw.pe_rst, 1);
> > > +}
> > > +
> > > +static int rcar_gen4_pcie_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	struct rcar_gen4_pcie *rcar;
> > > +	int err;
> > > +
> > > +	rcar = rcar_gen4_pcie_devm_alloc(dev);
> > > +	if (!rcar)
> > > +		return -ENOMEM;
> > > +
> > > +	err = rcar_gen4_pcie_get_resources(rcar, pdev);
> > > +	if (err < 0) {
> > > +		dev_err(dev, "Failed to request resource: %d\n", err);
> > > +		return err;
> > > +	}
> > > +
> > > +	platform_set_drvdata(pdev, rcar);
> > > +
> > > +	err = rcar_gen4_pcie_prepare(rcar);
> > > +	if (err < 0)
> > > +		return err;
> > > +
> > > +	rcar->needs_retrain = true;
> > > +	err = rcar_gen4_add_dw_pcie_rp(rcar, pdev);
> > > +	if (err < 0)
> > > +		goto err_add;
> > > +
> > > +	return 0;
> > > +
> > > +err_add:
> > > +	rcar_gen4_pcie_unprepare(rcar);
> > > +
> > > +	return err;
> > > +}
> > > +
> > > +static int rcar_gen4_pcie_remove(struct platform_device *pdev)
> > > +{
> > > +	struct rcar_gen4_pcie *rcar = platform_get_drvdata(pdev);
> > > +
> > > +	rcar_gen4_remove_dw_pcie_rp(rcar);
> > > +	rcar_gen4_pcie_unprepare(rcar);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct of_device_id rcar_gen4_pcie_of_match[] = {
> > > +	{ .compatible = "renesas,rcar-gen4-pcie", },
> > > +	{},
> > > +};
> > > +
> > > +static struct platform_driver rcar_gen4_pcie_driver = {
> > > +	.driver = {
> > > +		.name = "pcie-rcar-gen4",
> > > +		.of_match_table = rcar_gen4_pcie_of_match,
> > > +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> > > +	},
> > > +	.probe = rcar_gen4_pcie_probe,
> > > +	.remove = rcar_gen4_pcie_remove,
> > > +};
> > > +module_platform_driver(rcar_gen4_pcie_driver);
> > > +
> > > +MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe host controller driver");
> > > +MODULE_LICENSE("GPL");
> > > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > > new file mode 100644
> > > index 000000000000..35923fda8ed5
> > > --- /dev/null
> > > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > > @@ -0,0 +1,190 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * PCIe host/endpoint controller driver for Renesas R-Car Gen4 Series SoCs
> > > + * Copyright (C) 2022-2023 Renesas Electronics Corporation
> > > + */
> > > +
> > > +#include <linux/delay.h>
> > > +#include <linux/io.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/pci.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/reset.h>
> > > +
> > > +#include "pcie-rcar-gen4.h"
> > > +#include "pcie-designware.h"
> > > +
> > > +/* Renesas-specific */
> > > +#define PCIERSTCTRL1		0x0014
> > > +#define  APP_HOLD_PHY_RST	BIT(16)
> > > +#define  APP_LTSSM_ENABLE	BIT(0)
> > > +
> > > +#define RETRAIN_MAX_CHECK	10
> > > +#define RETRAIN_MAX_RETRIES	10
> > > +
> > > +static void rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar,
> > > +					bool enable)
> > > +{
> > > +	u32 val;
> > > +
> > > +	val = readl(rcar->base + PCIERSTCTRL1);
> > > +	if (enable) {
> > > +		val |= APP_LTSSM_ENABLE;
> > 
> > > +		val &= ~APP_HOLD_PHY_RST;
> > 
> > What about moving the APP_HOLD_PHY_RST de-assertion to the
> > rcar_gen4_pcie_set_device_type() method? In accordance with the
> > "3.1 Initialization" chapter it's supposed to be done before
> > performing the DBI programming and activating the link training.
> 

> IIUC, the "3.1 Initialization" said app_hold_phy_rst = 1 before
> performing the DBI programming. So, it is assertion. Also, the SoC
> documentation described the initializing procedure as the follows:
>  app_ltssm_enable = 1
>  app_hold_phy_rst = 0
> So, I would like to keep them in the function.

Indeed. I was wrong. Sorry for the misleading comment.

> 
> > > +	} else {
> > > +		val &= ~APP_LTSSM_ENABLE;
> > > +		val |= APP_HOLD_PHY_RST;
> > > +	}
> > > +	writel(val, rcar->base + PCIERSTCTRL1);
> > > +}
> > > +
> > > +static bool rcar_gen4_pcie_check_retrain_link(struct dw_pcie *dw)
> > > +{
> > > +	u8 offset = dw_pcie_find_capability(dw, PCI_CAP_ID_EXP);
> > > +	u32 lnkcap = dw_pcie_readl_dbi(dw, offset + PCI_EXP_LNKCAP);
> > > +	u32 lnkctl = dw_pcie_readl_dbi(dw, offset + PCI_EXP_LNKCTL);
> > > +	u16 lnksta = dw_pcie_readw_dbi(dw, offset + PCI_EXP_LNKSTA);
> > > +	int i;
> > > +
> > 
> > > +	if ((lnksta & PCI_EXP_LNKSTA_CLS) == (lnkcap & PCI_EXP_LNKCAP_SLS))
> > > +		return true;
> > > +
> > > +	lnkctl |= PCI_EXP_LNKCTL_RL;
> > > +	dw_pcie_writel_dbi(dw, offset + PCI_EXP_LNKCTL, lnkctl);
> > > +
> > > +	for (i = 0; i < RETRAIN_MAX_CHECK; i++) {
> > > +		lnksta = dw_pcie_readw_dbi(dw, offset + PCI_EXP_LNKSTA);
> > > +		if (lnksta & PCI_EXP_LNKSTA_LT)
> > > +			return true;
> > > +		usleep_range(1000, 1100);
> > > +	}
> > 
> > I'll ask one more time because you didn't respond to my previous note
> > about this.
> 
> I'm sorry. I completely overlooked the previous note.
> 
> > Are you sure that this is needed? Did you try
> > the approach described in "3.13 Gen2/3/4/5 Speed Modes" with
> > de-asserting/asserting the GEN2_CTRL_OFF.DIRECT_SPEED_CHANGE flag?
> 
> I tried this setting, but it doesn't work. I'll investigate this setting more.
> 
> > I keep asking because the same problem we used to have on our hardware
> > until we found out that the DIRECT_SPEED_CHANGE flag helped to train
> > the link right to the speed specified in the capabilities.
> > 
> > So here is what presumably you'll need to do (based on the
> > "3.1 Initialization" and "3.13 Gen2/3/4/5 Speed Modes" chapters of
> > the DW PCIe DM hw-manual):
> > 1. Make sure the controller is in the power-down/reset state.
> > 2. Select device_type (EP or RP).
> > 3. De-assert the controller reset.
> > 4. Clear PHY-reset flag in the app registers.
> > 5. Perform some controller initializations.
> > 6. Enable LTSSM to start link training.
> > 7. Set GEN2_CTRL_OFF.DIRECT_SPEED_CHANGE flag one more time.
> > 
> > 1-4 are supposed to be done in rcar_gen4_pcie_host_init().
> > 5 is performed in the framework of the DW PCIe core driver.
> > 6-7 should be done in rcar_gen4_pcie_start_link().
> > 
> > Note 1. GEN2_CTRL_OFF.DIRECT_SPEED_CHANGE flag is already set on stage
> > 5 in the framework of the dw_pcie_setup_rc() method. But in our case
> > it only caused having the Gen.2 link speed. Adding stage 7 helped to
> > get stable Gen.3 link. So please try the denoted approach. If it works
> > what about adding stage 7 twice in order to get Gen.4 speed?
> > (waiting for the DIRECT_SPEED_CHANGE flag being auto-cleared and then
> > set it up again?)
> > 
> > Note 2. GEN2_CTRL_OFF.DIRECT_SPEED_CHANGE flag is defined as
> > PCIE_LINK_WIDTH_SPEED_CONTROL.PORT_LOGIC_SPEED_CHANGE macros in the DW
> > PCIe core driver.
> > 
> > Note 3. If what is suggested above works well then you won't need to
> > have the heavy rcar_gen4_pcie_check_retrain_link() method in the way
> > you have it defined.
> 
> Thank you very much for your comments!

Please see the GEN2_CTRL_OFF.DIRECT_SPEED_CHANGE description for details
of how the flag is supposed to be de-asserted and asserted in order to
initiate the direct speed change.

> 
> > > +
> > > +	return false;
> > > +}
> > > +
> > > +static int rcar_gen4_pcie_link_up(struct dw_pcie *dw)
> > > +{
> > > +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> > > +	u32 val, mask;
> > > +
> > > +	val = readl(rcar->base + PCIEINTSTS0);
> > > +	mask = RDLH_LINK_UP | SMLH_LINK_UP;
> > > +
> > > +	return (val & mask) == mask;
> > > +}
> > > +
> > > +static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> > > +{
> > > +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> > > +	int i;
> > > +
> > > +	rcar_gen4_pcie_ltssm_enable(rcar, true);
> > > +
> > > +	/*
> > > +	 * Require retraining here. Otherwise RDLH_LINK_UP of PCIEINTSTS0 which
> > > +	 * is this controller specific register may not be set.
> > > +	 */
> > > +	if (rcar->needs_retrain) {
> > > +		for (i = 0; i < RETRAIN_MAX_RETRIES; i++) {
> > > +			if (rcar_gen4_pcie_check_retrain_link(dw))
> > > +				return 0;
> > > +			msleep(100);
> > > +		}
> > > +
> > > +		return -ETIMEDOUT;	/* Failed */
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void rcar_gen4_pcie_stop_link(struct dw_pcie *dw)
> > > +{
> > > +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> > > +
> > > +	rcar_gen4_pcie_ltssm_enable(rcar, false);
> > > +}
> > > +
> > 
> > > +int rcar_gen4_pcie_set_device_type(struct rcar_gen4_pcie *rcar, bool rc,
> > > +				   int num_lanes)
> > 
> > 1. Number of lanes is already defined in the rcar_gen4_pcie.dw.num_lanes field.
> > What about using it from there instead of passing it as an argument?
> > 2. DW PCIe core driver has a very handy enum defined:
> > dw_pcie_device_mode. It describes the controller modes (End-point,
> > Root port, etc). What about adding the mode field right to the
> > rcar_gen4_pcie structure and initializing it in someplace in probe() ?
> > 3. Based on the function semantic it's better to be named as something
> > like rcar_gen4_pcie_init_device() or even rcar_gen4_pcie_basic_init().
> 
> Thank you for your comments! I'll modify the function.
> 
> > 
> > > +{
> > > +	u32 val;
> > > +
> > 
> > > +	/* Note: Assume the rcar->rst which is Cold-reset is asserted here */
> > 
> > What about directly asserting it here then? In accordance with the DW
> > PCIe DM manual the "device_type" input must be set before the DM
> > controller is powered up (basically un-reset). What if the controller
> > reset is already de-asserted, but you are going to changes its mode?
> > In that case the mode won't be changed and you'll end up with
> > unpredictable results.
> 
> Thank you for your comment. We should add asserting it here as you mentioned.
> 
> > > +	val = readl(rcar->base + PCIEMSR0);
> > > +	if (rc)
> > > +		val |= DEVICE_TYPE_RC;
> > > +	else
> > > +		val |= DEVICE_TYPE_EP;
> > > +
> > > +	if (num_lanes < 4)
> > > +		val |= BIFUR_MOD_SET_ON;
> > > +
> > > +	writel(val, rcar->base + PCIEMSR0);
> > > +
> > > +	return reset_control_deassert(rcar->rst);
> > > +}
> > > +
> > > +int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
> > > +{
> > > +	struct device *dev = rcar->dw.dev;
> > > +	int err;
> > > +
> > > +	pm_runtime_enable(dev);
> > > +	err = pm_runtime_resume_and_get(dev);
> > > +	if (err < 0) {
> > > +		dev_err(dev, "Failed to resume/get Runtime PM\n");
> > > +		pm_runtime_disable(dev);
> > > +	}
> > > +
> > > +	return err;
> > > +}
> > > +
> > > +void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
> > > +{
> > > +	struct device *dev = rcar->dw.dev;
> > > +
> > > +	if (!reset_control_status(rcar->rst))
> > > +		reset_control_assert(rcar->rst);
> > > +	pm_runtime_put(dev);
> > > +	pm_runtime_disable(dev);
> > > +}
> > > +
> > > +int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar,
> > > +				 struct platform_device *pdev)
> > > +{
> > > +	struct device *dev = rcar->dw.dev;
> > > +
> > > +	/* Renesas-specific registers */
> > > +	rcar->base = devm_platform_ioremap_resource_byname(pdev, "app");
> > > +	if (IS_ERR(rcar->base))
> > > +		return PTR_ERR(rcar->base);
> > > +
> > 
> > > +	rcar->rst = devm_reset_control_get(dev, NULL);
> > > +	if (IS_ERR(rcar->rst)) {
> > > +		dev_err(dev, "Failed to get Cold-reset\n");
> > 
> > So AFAICS your platform is equipped with the DWC_pcie_clkrst.v module.
> > Thus all the resets are appropriately cleared by a single flag:
> > power_up_rst_n. What about using the named reset in this case with the
> > "pwr" name? Thus you'll be able to drop the manual
> > devm_reset_control_get() invocation and instead use the reset-resources
> > requested in the framework of the generic dw_pcie_get_resources()
> > method? Note you'll need to move the dw_pcie_cap_set(dw, REQ_RES);
> > statement to rcar_gen4_pcie_devm_alloc() then and drop the
> > rcar_gen4_pcie.rst field afterwords.
> 
> Thank you for your suggestion! Using "pwr" can work on my environment.
> 
> > By the way I don't see you requesting and enabling the reference
> > clock in your driver but the bindings imply the clock source. How
> > come?
> 

> For now, I used gpio-hog to enable the reference clock. But, it seem
> I should use "ref" clock for it. So, I'll fix it too.

Not sure what gpio-hog you are talking about. Do you mean the pe_rst
signal or some another gpio? I failed to see of how pe_rst is
connected to the clock source. In anyway directly handling the clock
source would be more portable choice.

-Serge(y)

> 
> > > +		return PTR_ERR(rcar->rst);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct dw_pcie_ops dw_pcie_ops = {
> > > +	.start_link = rcar_gen4_pcie_start_link,
> > > +	.stop_link = rcar_gen4_pcie_stop_link,
> > > +	.link_up = rcar_gen4_pcie_link_up,
> > > +};
> > > +
> > > +struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct device *dev)
> > > +{
> > > +	struct rcar_gen4_pcie *rcar;
> > > +
> > > +	rcar = devm_kzalloc(dev, sizeof(*rcar), GFP_KERNEL);
> > > +	if (!rcar)
> > > +		return NULL;
> > > +
> > > +	rcar->dw.dev = dev;
> > > +	rcar->dw.ops = &dw_pcie_ops;
> > > +	dw_pcie_cap_set(&rcar->dw, EDMA_UNROLL);
> > > +
> > > +	return rcar;
> > > +}
> > > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.h b/drivers/pci/controller/dwc/pcie-rcar-gen4.h
> > > new file mode 100644
> > > index 000000000000..fec3f18609f4
> > > --- /dev/null
> > > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.h
> > > @@ -0,0 +1,46 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * PCIe host/endpoint controller driver for Renesas R-Car Gen4 Series SoCs
> > > + * Copyright (C) 2022-2023 Renesas Electronics Corporation
> > > + */
> > > +
> > > +#ifndef _PCIE_RCAR_GEN4_H_
> > > +#define _PCIE_RCAR_GEN4_H_
> > > +
> > > +#include <linux/io.h>
> > > +#include <linux/pci.h>
> > > +#include <linux/reset.h>
> > > +
> > > +#include "pcie-designware.h"
> > > +
> > > +/* Renesas-specific */
> > > +#define PCIEMSR0		0x0000
> > > +#define  BIFUR_MOD_SET_ON	BIT(0)
> > > +#define  DEVICE_TYPE_EP		0
> > > +#define  DEVICE_TYPE_RC		BIT(4)
> > > +
> > > +#define PCIEINTSTS0		0x0084
> > > +#define PCIEINTSTS0EN		0x0310
> > > +#define  MSI_CTRL_INT		BIT(26)
> > > +#define  SMLH_LINK_UP		BIT(7)
> > > +#define  RDLH_LINK_UP		BIT(6)
> > > +#define PCIEDMAINTSTSEN		0x0314
> > > +#define  PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
> > > +
> > 
> > > +struct rcar_gen4_pcie {
> > 
> > As I mentioned above this structure can be extended with the enum
> > dw_pcie_device_mode field thus dropping the boolean argument from the
> > rcar_gen4_pcie_set_device_type() method.
> 
> I got it. I'll fix this.
> 
> > > +	struct dw_pcie		dw;
> > 
> > As I already mentioned above the dw.num_lanes could be used instead of
> > passing it as the rcar_gen4_pcie_set_device_type() argument.
> 
> I'll fix this too.
> 
> Best regards,
> Yoshihiro Shimoda
> 
> > -Serge(y)
> > 
> > > +	void __iomem		*base;
> > > +	struct reset_control	*rst;
> > > +	bool			needs_retrain;
> > > +};
> > > +#define to_rcar_gen4_pcie(x)	dev_get_drvdata((x)->dev)
> > > +
> > > +int rcar_gen4_pcie_set_device_type(struct rcar_gen4_pcie *rcar, bool rc,
> > > +				   int num_lanes);
> > > +int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *pcie);
> > > +void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *pcie);
> > > +int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar,
> > > +				 struct platform_device *pdev);
> > > +struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct device *dev);
> > > +
> > > +#endif /* _PCIE_RCAR_GEN4_H_ */
> > > --
> > > 2.25.1
> > >
