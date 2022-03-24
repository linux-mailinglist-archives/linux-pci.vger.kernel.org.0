Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D854E6793
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 18:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352170AbiCXRQj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 13:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240788AbiCXRQi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 13:16:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A60633B;
        Thu, 24 Mar 2022 10:15:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3C4EB82331;
        Thu, 24 Mar 2022 17:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CE7C340EC;
        Thu, 24 Mar 2022 17:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648142103;
        bh=dbFxjA3fmX6GItpv2KyqqK1dciNTwAKoNTj92pNTJuw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SSASOwTudJjrUxjmbBSXiLg7nKXxcBDILsLNKp1FNKKAr4rBinRROn4jVa+4mnOdW
         6kE9nkbN9mVfqueVOU5fAwPatYiDKuC9UL7RtvjrpbORQp73WmGgzLohiAS5pyTEYl
         k6iVxpJl3QQB/WpFHxQEixnyh4MgvLyeG4fCqgsME9/FhDubOI5H9nbWaeRsjHHWlf
         UuL9zJ+gJmHLpqYzFYIdGgAX40+b7OiFjFfaR0UT+VZHlSt5vvFlhAoEBLr1+p4Xip
         qpSnuCx9l3mO+CC6yvuOM0Wx+3M6GBHP14USmqr/Zdy7VXC9TXnF/optAjd5/u7tXQ
         pCGVAXcDSG5Mg==
Date:   Thu, 24 Mar 2022 12:15:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] PCI: mvebu: Add support for sending
 Set_Slot_Power_Limit message
Message-ID: <20220324171501.GA1460207@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220302145733.12606-5-pali@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 02, 2022 at 03:57:33PM +0100, Pali Rohár wrote:
> If DT supplies the 'slot-power-limit-milliwatt' property, program
> the value in the Slot Power Limit in the Slot Capabilities register
> and program the Root Port to send a Set_Slot_Power_Limit Message
> when the Link transitions to DL_Up.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>

I didn't review this carefully but have no objection.

> ---
> Changes in v2:
> * Fix handling of slot power limit with scale x1.0 (0x00 value)
> * Use FIELD_PREP instead of _SHIFT macros
> * Changed commit message to Bjorn's suggestion
> * Changed comments in the code to match PCIe spec
> * Preserve user settings of PCI_EXP_SLTCTL_ASPL_DISABLE bit
> ---
>  drivers/pci/controller/pci-mvebu.c | 96 ++++++++++++++++++++++++++++--
>  1 file changed, 91 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index a75d2b9196f9..26ae7c29fece 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -8,6 +8,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/gpio.h>
> @@ -66,6 +67,12 @@
>  #define  PCIE_STAT_BUS                  0xff00
>  #define  PCIE_STAT_DEV                  0x1f0000
>  #define  PCIE_STAT_LINK_DOWN		BIT(0)
> +#define PCIE_SSPL_OFF		0x1a0c
> +#define  PCIE_SSPL_VALUE_SHIFT		0
> +#define  PCIE_SSPL_VALUE_MASK		GENMASK(7, 0)
> +#define  PCIE_SSPL_SCALE_SHIFT		8
> +#define  PCIE_SSPL_SCALE_MASK		GENMASK(9, 8)
> +#define  PCIE_SSPL_ENABLE		BIT(16)
>  #define PCIE_RC_RTSTA		0x1a14
>  #define PCIE_DEBUG_CTRL         0x1a60
>  #define  PCIE_DEBUG_SOFT_RESET		BIT(20)
> @@ -111,6 +118,8 @@ struct mvebu_pcie_port {
>  	struct mvebu_pcie_window iowin;
>  	u32 saved_pcie_stat;
>  	struct resource regs;
> +	u8 slot_power_limit_value;
> +	u8 slot_power_limit_scale;
>  	struct irq_domain *intx_irq_domain;
>  	raw_spinlock_t irq_lock;
>  	int intx_irq;
> @@ -239,7 +248,7 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
>  
>  static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
>  {
> -	u32 ctrl, lnkcap, cmd, dev_rev, unmask;
> +	u32 ctrl, lnkcap, cmd, dev_rev, unmask, sspl;
>  
>  	/* Setup PCIe controller to Root Complex mode. */
>  	ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
> @@ -292,6 +301,20 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
>  	/* Point PCIe unit MBUS decode windows to DRAM space. */
>  	mvebu_pcie_setup_wins(port);
>  
> +	/*
> +	 * Program Root Port to automatically send Set_Slot_Power_Limit
> +	 * PCIe Message when changing status from Dl_Down to Dl_Up and valid
> +	 * slot power limit was specified.
> +	 */
> +	sspl = mvebu_readl(port, PCIE_SSPL_OFF);
> +	sspl &= ~(PCIE_SSPL_VALUE_MASK | PCIE_SSPL_SCALE_MASK | PCIE_SSPL_ENABLE);
> +	if (port->slot_power_limit_value) {
> +		sspl |= port->slot_power_limit_value << PCIE_SSPL_VALUE_SHIFT;
> +		sspl |= port->slot_power_limit_scale << PCIE_SSPL_SCALE_SHIFT;
> +		sspl |= PCIE_SSPL_ENABLE;
> +	}
> +	mvebu_writel(port, sspl, PCIE_SSPL_OFF);
> +
>  	/* Mask all interrupt sources. */
>  	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
>  
> @@ -628,9 +651,23 @@ mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
>  			  (PCI_EXP_LNKSTA_DLLLA << 16) : 0);
>  		break;
>  
> -	case PCI_EXP_SLTCTL:
> -		*value = PCI_EXP_SLTSTA_PDS << 16;
> +	case PCI_EXP_SLTCTL: {
> +		u16 slotsta = le16_to_cpu(bridge->pcie_conf.slotsta);
> +		u32 val = 0;
> +		/*
> +		 * When slot power limit was not specified in DT then
> +		 * ASPL_DISABLE bit is stored only in emulated config space.
> +		 * Otherwise reflect status of PCIE_SSPL_ENABLE bit in HW.
> +		 */
> +		if (!port->slot_power_limit_value)
> +			val |= slotctl & PCI_EXP_SLTCTL_ASPL_DISABLE;
> +		else if (!(mvebu_readl(port, PCIE_SSPL_OFF) & PCIE_SSPL_ENABLE))
> +			val |= PCI_EXP_SLTCTL_ASPL_DISABLE;
> +		/* This callback is 32-bit and in high bits is slot status. */
> +		val |= slotsta << 16;
> +		*value = val;
>  		break;
> +	}
>  
>  	case PCI_EXP_RTSTA:
>  		*value = mvebu_readl(port, PCIE_RC_RTSTA);
> @@ -774,6 +811,22 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
>  		mvebu_writel(port, new, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL);
>  		break;
>  
> +	case PCI_EXP_SLTCTL:
> +		/*
> +		 * Allow to change PCIE_SSPL_ENABLE bit only when slot power
> +		 * limit was specified in DT and configured into HW.
> +		 */
> +		if ((mask & PCI_EXP_SLTCTL_ASPL_DISABLE) &&
> +		    port->slot_power_limit_value) {
> +			u32 sspl = mvebu_readl(port, PCIE_SSPL_OFF);
> +			if (new & PCI_EXP_SLTCTL_ASPL_DISABLE)
> +				sspl &= ~PCIE_SSPL_ENABLE;
> +			else
> +				sspl |= PCIE_SSPL_ENABLE;
> +			mvebu_writel(port, sspl, PCIE_SSPL_OFF);
> +		}
> +		break;
> +
>  	case PCI_EXP_RTSTA:
>  		/*
>  		 * PME Status bit in Root Status Register (PCIE_RC_RTSTA)
> @@ -868,8 +921,26 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
>  	/*
>  	 * Older mvebu hardware provides PCIe Capability structure only in
>  	 * version 1. New hardware provides it in version 2.
> +	 * Enable slot support which is emulated.
>  	 */
> -	bridge->pcie_conf.cap = cpu_to_le16(pcie_cap_ver);
> +	bridge->pcie_conf.cap = cpu_to_le16(pcie_cap_ver | PCI_EXP_FLAGS_SLOT);
> +
> +	/*
> +	 * Set Presence Detect State bit permanently as there is no support for
> +	 * unplugging PCIe card from the slot. Assume that PCIe card is always
> +	 * connected in slot.
> +	 *
> +	 * Set physical slot number to port+1 as mvebu ports are indexed from
> +	 * zero and zero value is reserved for ports within the same silicon
> +	 * as Root Port which is not mvebu case.
> +	 *
> +	 * Also set correct slot power limit.
> +	 */
> +	bridge->pcie_conf.slotcap = cpu_to_le32(
> +		FIELD_PREP(PCI_EXP_SLTCAP_SPLV, port->slot_power_limit_value) |
> +		FIELD_PREP(PCI_EXP_SLTCAP_SPLS, port->slot_power_limit_scale) |
> +		FIELD_PREP(PCI_EXP_SLTCAP_PSN, port->port+1));
> +	bridge->pcie_conf.slotsta = cpu_to_le16(PCI_EXP_SLTSTA_PDS);
>  
>  	bridge->subsystem_vendor_id = ssdev_id & 0xffff;
>  	bridge->subsystem_id = ssdev_id >> 16;
> @@ -1191,6 +1262,7 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
>  {
>  	struct device *dev = &pcie->pdev->dev;
>  	enum of_gpio_flags flags;
> +	u32 slot_power_limit;
>  	int reset_gpio, ret;
>  	u32 num_lanes;
>  
> @@ -1291,6 +1363,15 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
>  		port->reset_gpio = gpio_to_desc(reset_gpio);
>  	}
>  
> +	slot_power_limit = of_pci_get_slot_power_limit(child,
> +				&port->slot_power_limit_value,
> +				&port->slot_power_limit_scale);
> +	if (slot_power_limit)
> +		dev_info(dev, "%s: Slot power limit %u.%uW\n",
> +			 port->name,
> +			 slot_power_limit / 1000,
> +			 (slot_power_limit / 100) % 10);
> +
>  	port->clk = of_clk_get_by_name(child, NULL);
>  	if (IS_ERR(port->clk)) {
>  		dev_err(dev, "%s: cannot get clock\n", port->name);
> @@ -1587,7 +1668,7 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
>  {
>  	struct mvebu_pcie *pcie = platform_get_drvdata(pdev);
>  	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> -	u32 cmd;
> +	u32 cmd, sspl;
>  	int i;
>  
>  	/* Remove PCI bus with all devices. */
> @@ -1624,6 +1705,11 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
>  		/* Free config space for emulated root bridge. */
>  		pci_bridge_emul_cleanup(&port->bridge);
>  
> +		/* Disable sending Set_Slot_Power_Limit PCIe Message. */
> +		sspl = mvebu_readl(port, PCIE_SSPL_OFF);
> +		sspl &= ~(PCIE_SSPL_VALUE_MASK | PCIE_SSPL_SCALE_MASK | PCIE_SSPL_ENABLE);
> +		mvebu_writel(port, sspl, PCIE_SSPL_OFF);
> +
>  		/* Disable and clear BARs and windows. */
>  		mvebu_pcie_disable_wins(port);
>  
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
