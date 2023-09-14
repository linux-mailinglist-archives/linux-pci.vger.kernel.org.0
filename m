Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080827A0AD8
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 18:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbjINQfD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 12:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjINQfC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 12:35:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557D91FE0;
        Thu, 14 Sep 2023 09:34:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4175C433C8;
        Thu, 14 Sep 2023 16:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694709298;
        bh=Pcop7TD273jLyapBckJiXW4f2KWnB3+N7DdSODlapD0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RGVe1VTVivh4LQVw+DUfoYI+YPhJofwoFhIYXW1Fummi7rRdylmsnJx0VEo8dCLcy
         U8y1eFxz+QZ9nHj0Rw+Ar2BzPaGOaYn+ZJyijWJmVQZ0EuFeojLv9Hn/Zhdq7QG+y4
         ebY4Vxhp5LIjXHNwgw1mu/SPFrKy6bwgdCier7EA0FQ5Ud6I2J1JrhjA56AfXhUgum
         bT6MaZUSfEbEEZIuKx8aYEehz/3DzNogsde8XlvW8gWen9DEwCXFgwiTGOVVX+SpTd
         G2nMRYSMg3r4pwtMKqoIvLo2epF1kwrTEgBB/GDmz0nXP2ZMMGtAuVjwNWPAyPTD1W
         xxmPAXsaXGnRg==
Date:   Thu, 14 Sep 2023 11:34:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        fancer.lancer@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v20 16/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Message-ID: <20230914163455.GA33111@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825093219.2685912-17-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 25, 2023 at 06:32:16PM +0900, Yoshihiro Shimoda wrote:
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
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/pci/controller/dwc/Kconfig            |  10 +
>  drivers/pci/controller/dwc/Makefile           |   2 +
>  .../controller/dwc/pcie-rcar-gen4-host-drv.c  | 135 +++++++++++
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 227 ++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  44 ++++
>  5 files changed, 418 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host-drv.c

Is "pcie-rcar-gen4-host-drv.c" following some pattern?  I don't see
"-drv" in any nearby filenames.  Typical names are "-host.c" for host
driver and "-ep.c" for endpoint driver.

>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h

> +config PCIE_RCAR_GEN4

If you look through drivers/pci/controller/dwc/Kconfig, it's typical
to use a "_HOST" suffix on the symbol to enable host controller
drivers.  Similarly, "_EP" suffix for endpoint drivers.

> +	tristate "Renesas R-Car Gen4 PCIe Host controller"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on PCI_MSI
> +	select PCIE_DW_HOST

> +static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
> +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> +	int ret;
> +	u32 val;
> +
> +	gpiod_set_value_cansleep(dw->pe_rst, 1);
> +
> +	ret = rcar_gen4_pcie_common_init(rcar);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
> +	 * Rev.5.20a, we should disable two BARs to avoid unnecessary memory
> +	 * assignment during device enumeration.
> +	 */
> +	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_0, 0x0);
> +	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_1, 0x0);
> +
> +	/* Enable MSI interrupt signal */
> +	val = readl(rcar->base + PCIEINTSTS0EN);
> +	val |= MSI_CTRL_INT;
> +	writel(val, rcar->base + PCIEINTSTS0EN);
> +
> +	msleep(100);	/* pe_rst requires 100msec delay */

Can we include a spec reference for this delay?  Ideally this would be
a #define and likely shared across drivers.

> +	gpiod_set_value_cansleep(dw->pe_rst, 0);
> +
> +	return 0;
> +}

> + * Manually initiate the speed change. Return true if the change succeeded,
> + * false if the change didn't finish within certain periods.
> + */
> +static bool rcar_gen4_pcie_speed_change(struct dw_pcie *dw)

This looks like it should return int, e.g., 0 for success, negative
for failure.  Boolean functions ideally would not have side effects
and the name would be a condition that can be true or false.

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

Where did these values (num retries and sleep duration) come from?
Can we include a spec citation for them?

> +	}
> +
> +	return false;
> +}
> +
> +/*
> + * Enable LTSSM of this controller and manually initiate the speed change.
> + * Always return true.

This doesn't return "true".  It returns *0*, which is a perfectly good
"success" value, but it isn't "true", which would be a non-zero value.

> + */
> +static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
> +{
> +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> +	int i, changes;
> +
> +	rcar_gen4_pcie_ltssm_enable(rcar, true);
> +
> +	/*
> +	 * Require direct speed change with retrying here if the link_gen is
> +	 * PCIe Gen2 or higher.
> +	 */
> +	changes = min_not_zero(dw->link_gen, RCAR_MAX_LINK_SPEED) - 1;
> +
> +	/*
> +	 * Since dw_pcie_setup_rc() sets it once, PCIe Gen2 will be trained.
> +	 * So, this needs remaining times for up to PCIe Gen4 if RC mode.
> +	 */
> +	if (changes && rcar->mode == DW_PCIE_RC_TYPE)
> +		changes--;
> +
> +	for (i = 0; i < changes; i++) {
> +		if (!rcar_gen4_pcie_speed_change(dw))
> +			break;	/* No error because possible disconnected here if EP mode */

Rest of the file fits in 80 columns, it'd be nice if the comment did
too.

> +	}
> +
> +	return 0;
> +}

> +#define PCIEMSR0		0x0000
> +#define BIFUR_MOD_SET_ON	BIT(0)
> +#define DEVICE_TYPE_EP		0
> +#define DEVICE_TYPE_RC		BIT(4)
> +
> +#define PCIEINTSTS0		0x0084
> +#define PCIEINTSTS0EN		0x0310
> +#define MSI_CTRL_INT		BIT(26)
> +#define SMLH_LINK_UP		BIT(7)
> +#define RDLH_LINK_UP		BIT(6)
> +#define PCIEDMAINTSTSEN		0x0314
> +#define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)

These register offsets are hard to decode whenthey'reallruntogether.
