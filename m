Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6315D54A0A6
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 22:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351443AbiFMU7w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 16:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351811AbiFMU6k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 16:58:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9B113D7A;
        Mon, 13 Jun 2022 13:34:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20C7C60C20;
        Mon, 13 Jun 2022 20:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36929C341C0;
        Mon, 13 Jun 2022 20:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655152448;
        bh=vKRm/MvsQosL8IY46p4F0dMgF1MozYoagOOp7nUTpWM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Sczstjqhy0aTfGg56kx9fXboLiU//WictgU9p+6Co3uej7yi96+jQ8Fg+7yKaXaL7
         ZgW1DIiCZSfL4DF3BbFQsKNOjsj7+uw7NfvVxknIHz2+LOUBjcFKO2QzvvM3DzpMXo
         B4BGYWhA5UVcC07caqoLlG+T1Br574VI/ahox4AQZn2DpMLlbbhagINtsiT+5NDwuQ
         +2GtdR5C42OqF9xfWJMmCSx3ByPkhxaVczXG0tdDMGD8Zgz3dOAF0jZ+oOqwpVD0Dx
         UdIC5/Nt1WyNRMUUPn7x5PD0AC67yNDdOKc6cGrdJxTQqD1MukBUMynBZBomtJYC0K
         hbYPBM0Y8eLRA==
Date:   Mon, 13 Jun 2022 15:34:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org, geert+renesas@glider.be,
        magnus.damm@gmail.com, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 3/7] PCI: renesas: Add R-Car Gen4 PCIe Host support
Message-ID: <20220613203406.GA714216@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613115712.2831386-4-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 13, 2022 at 08:57:08PM +0900, Yoshihiro Shimoda wrote:
> Add R-Car Gen4 PCIe Host support. This controller is based on
> Synopsys Designware PCIe.

You used "DesignWare" below, which I think is what Synopsys uses.

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/Kconfig            |   9 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 235 ++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 198 +++++++++++++++
>  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  59 +++++
>  5 files changed, 502 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 62ce3abf0f19..3ddccc9c38c5 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -384,4 +384,13 @@ config PCIE_FU740
>  	  Say Y here if you want PCIe controller support for the SiFive
>  	  FU740.
>  
> +config PCIE_RCAR_GEN4
> +	bool "Renesas R-Car Gen4 PCIe Host controller"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIE_DW_HOST
> +	help
> +	  Say Y here if you want PCIe host controller support on R-Car Gen4 SoCs.
> +	  This uses the DesignWare core.

> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host controller driver for Renesas R-Car Gen4 Series SoCs
> + * Copyright (C) 2022 Renesas Electronics Corporation
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
> +/* ASPM L1 PM Substates */
> +#define L1PSCAP(x)		(0x01bc + (x))

Looks like the stuff in pcie-rcar-gen4.h.  Should this go there?

> +	/* Set Max Link Width */

Superfluous comment, since the function name says the same thing.

> +	rcar_gen4_pcie_set_max_link_width(pci, pci->num_lanes);

> +/* Link Capabilities - Maximum Link Width */
> +#define  PCI_EXP_LNKCAP_MLW_X1	BIT(4)
> +#define  PCI_EXP_LNKCAP_MLW_X2	BIT(5)
> +#define  PCI_EXP_LNKCAP_MLW_X4	BIT(6)

I think we should define these in include/uapi/linux/pci_regs.h.
Use the same style as the other #defines there, i.e.,

  #define  PCI_EXP_LNKCAP_MLW_X1  0x00000010
  #define  PCI_EXP_LNKCAP_MLW_X2  0x00000020
  #define  PCI_EXP_LNKCAP_MLW_X4  0x00000040

> +/* Renesas-specific */
> +#define PCIEMSR0		0x0000
> +#define  BIFUR_MOD_SET_ON	(0x1 << 0)
> +#define  DEVICE_TYPE_EP		(0x0 << 2)
> +#define  DEVICE_TYPE_RC		(0x4 << 2)
> +
> +#define PCIEINTSTS0		0x0084
> +#define PCIEINTSTS0EN		0x0310
> +#define  MSI_CTRL_INT		BIT(26)
> +#define  SMLH_LINK_UP		BIT(7)
> +#define  RDLH_LINK_UP		BIT(6)

Is there a reason to mix the "(0x1 << 0)" style and the "BIT(26)"
styles?

> +extern u32 rcar_gen4_pcie_readl(struct rcar_gen4_pcie *pcie, u32 reg);
> +extern void rcar_gen4_pcie_writel(struct rcar_gen4_pcie *pcie, u32 reg, u32 val);
> +extern void rcar_gen4_pcie_set_max_link_width(struct dw_pcie *pci, int num_lanes);
> +extern int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *pcie);
> +extern void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *pcie);
> +extern int rcar_gen4_pcie_pm_runtime_enable(struct device *dev);
> +extern void rcar_gen4_pcie_pm_runtime_disable(struct device *dev);
> +extern int rcar_gen4_pcie_devm_clk_and_reset_get(struct rcar_gen4_pcie *pcie,
> +						 struct device *dev);
> +extern struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct device *dev);

Don't bother with "extern" on function declarations; this would be the
only instance in drivers/pci/.
