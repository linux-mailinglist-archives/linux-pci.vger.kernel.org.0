Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEA84C4504
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 13:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240790AbiBYMyr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 07:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiBYMyq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 07:54:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52EF21CD35;
        Fri, 25 Feb 2022 04:54:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E661B8301B;
        Fri, 25 Feb 2022 12:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAC9C340E7;
        Fri, 25 Feb 2022 12:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645793650;
        bh=ZLbrKhhIauzbgxTzgNFL8Yq3g0p8hUkXG6xdxAsW3Tg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YRDX0O1+38HQ+8qTBbn75AAvS7wvKlSidQ4wDcLNGNBrQKksr7z2FYrg53ICcklji
         pKNVpkbq60AQTPGFShXJFkYffPwphpyzxsmS+2GZAxRMKlVjww76Dj5onSgy11ZBR8
         QXDB76zPocWPSEtS+L+BX4aN6843nZ/lnWD6vcZxCFzg+DZENV1KUzQzfdMTd3Pib1
         ueSwEhWezJ/GLNoYryl3W1vt4P/y+mkx4EGd1KQadkqIN9hI7RE+MZ2IS1kvB7U6IA
         mivnye1h71wFpEN2lz2q6jIkAiBOD5zRdp+ZbV+6UbKHuuGQG5wgunxYZdd6e96uxK
         2LQo+Z64ROhGQ==
Received: by pali.im (Postfix)
        id B51E77EF; Fri, 25 Feb 2022 13:54:07 +0100 (CET)
Date:   Fri, 25 Feb 2022 13:54:07 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] PCI: mvebu: Add support for sending
 Set_Slot_Power_Limit message
Message-ID: <20220225125407.wglplhyisgges3zk@pali>
References: <20220222163158.1666-6-pali@kernel.org>
 <20220224212811.GA291001@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220224212811.GA291001@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 24 February 2022 15:28:11 Bjorn Helgaas wrote:
> On Tue, Feb 22, 2022 at 05:31:57PM +0100, Pali Rohár wrote:
> > This PCIe message is sent automatically by mvebu HW when link changes
> > status from down to up.
> 
> I *think* the intent of the above is:
> 
>   If DT supplies the 'slot-power-limit-milliwatt' property, program
>   the value in the Slot Power Limit in the Slot Capabilities register
>   and program the Root Port to send a Set_Slot_Power_Limit Message
>   when the Link transitions to DL_Up.

Exactly!

> PCIe r6.0, sec 2.2.8.5 and 7.5.3.9, also say Set_Slot_Power_Limit must
> be sent on a config write to Slot Capabilities.  I don't really
> understand that, since AFAICS, everything in that register is
> read-only.  But there must be some use case for forcing a message.

I understood it in this way: Capabilities register is read-only hw-init
and so firmware / driver can write initialization values into this
register. And when firmware / driver is doing this write then Root port
should send that Set_Slot_Power_Limit message.

But this is just my interpretation which I thought that makes sense.

> > Slot power limit is read from DT property 'slot-power-limit-milliwatt' and
> > set to mvebu HW. When this DT property is not specified then driver treat
> > it as "Slot Capabilities register has not yet been initialized".
> 
> Does this last sentence mean "the Slot Power Limit is set to 0W
> (Value = 00h and Scale = 00b = 1.0x) and Auto Slot Power Limit Disable
> is set, so Set_Slot_Power_Limit Messages will never be sent"?

Yes!

> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  drivers/pci/controller/pci-mvebu.c | 85 ++++++++++++++++++++++++++++--
> >  1 file changed, 80 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > index a75d2b9196f9..c786feec4d17 100644
> > --- a/drivers/pci/controller/pci-mvebu.c
> > +++ b/drivers/pci/controller/pci-mvebu.c
> > @@ -66,6 +66,12 @@
> >  #define  PCIE_STAT_BUS                  0xff00
> >  #define  PCIE_STAT_DEV                  0x1f0000
> >  #define  PCIE_STAT_LINK_DOWN		BIT(0)
> > +#define PCIE_SSPL_OFF		0x1a0c
> > +#define  PCIE_SSPL_VALUE_SHIFT		0
> > +#define  PCIE_SSPL_VALUE_MASK		GENMASK(7, 0)
> > +#define  PCIE_SSPL_SCALE_SHIFT		8
> > +#define  PCIE_SSPL_SCALE_MASK		GENMASK(9, 8)
> > +#define  PCIE_SSPL_ENABLE		BIT(16)
> >  #define PCIE_RC_RTSTA		0x1a14
> >  #define PCIE_DEBUG_CTRL         0x1a60
> >  #define  PCIE_DEBUG_SOFT_RESET		BIT(20)
> > @@ -111,6 +117,8 @@ struct mvebu_pcie_port {
> >  	struct mvebu_pcie_window iowin;
> >  	u32 saved_pcie_stat;
> >  	struct resource regs;
> > +	u8 slot_power_limit_value;
> > +	u8 slot_power_limit_scale;
> >  	struct irq_domain *intx_irq_domain;
> >  	raw_spinlock_t irq_lock;
> >  	int intx_irq;
> > @@ -239,7 +247,7 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
> >  
> >  static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
> >  {
> > -	u32 ctrl, lnkcap, cmd, dev_rev, unmask;
> > +	u32 ctrl, lnkcap, cmd, dev_rev, unmask, sspl;
> >  
> >  	/* Setup PCIe controller to Root Complex mode. */
> >  	ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
> > @@ -292,6 +300,20 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
> >  	/* Point PCIe unit MBUS decode windows to DRAM space. */
> >  	mvebu_pcie_setup_wins(port);
> >  
> > +	/*
> > +	 * Program Root Complex to automatically sends Set Slot Power Limit
> > +	 * PCIe Message when changing status from Dl-Down to Dl-Up and valid
> > +	 * slot power limit was specified.
> 
> s/Root Complex/Root Port/, right?  AFAIK the message would be sent by
> a Downstream Port, i.e., a Root Port in this case.

Yes!

I see that on more places that names "Root Port", "Root Bridge" and
"Root Complex" used as the one thing.

It is probably because HW has only one Root Port and is integrated into
same silicon as Root Complex and shares HW registers. And Root Port has
PCI class code "PCI Bridge", hence Root Bridge.

But I agree that correct name is "Root Port".

Moreover in Armada 38x Functional Specification is this register named
"Root Complex Set Slot Power Limit" and not Root "Port".

> s/sends/send/
> s/Set Slot Power Limit/Set_Slot_Power_Limit/ to match spec usage (also
> below)
> s/Dl-Down/DL_Down/ to match spec usage
> s/Dl-Up/DL_Up/ ditto

In Armada 38x Functional Specification spec it is called like I wrote
and some people told me to use "naming" as written in SoC/HW
specification to not confuse other people who are writing / developing
drivers according to official SoC/HW specification.

I see that both has pro and cons. Usage of terminology from PCIe spec is
what PCIe people expect and terminology from vendor SoC HW spec is what
people who develop that SoC expect.

I can update and change comments without issue to any variant which you
prefer. No problem with it. Just I wanted to write why I chose those
names.

> > +	 */
> > +	sspl = mvebu_readl(port, PCIE_SSPL_OFF);
> > +	sspl &= ~(PCIE_SSPL_VALUE_MASK | PCIE_SSPL_SCALE_MASK | PCIE_SSPL_ENABLE);
> > +	if (port->slot_power_limit_value && port->slot_power_limit_scale) {
> > +		sspl |= port->slot_power_limit_value << PCIE_SSPL_VALUE_SHIFT;
> > +		sspl |= port->slot_power_limit_scale << PCIE_SSPL_SCALE_SHIFT;
> > +		sspl |= PCIE_SSPL_ENABLE;
> > +	}
> > +	mvebu_writel(port, sspl, PCIE_SSPL_OFF);
> > +
> >  	/* Mask all interrupt sources. */
> >  	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
> >  
> > @@ -628,9 +650,16 @@ mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
> >  			  (PCI_EXP_LNKSTA_DLLLA << 16) : 0);
> >  		break;
> >  
> > -	case PCI_EXP_SLTCTL:
> > -		*value = PCI_EXP_SLTSTA_PDS << 16;
> > +	case PCI_EXP_SLTCTL: {
> > +		u16 slotsta = le16_to_cpu(bridge->pcie_conf.slotsta);
> > +		u32 val = 0;
> > +		if (!(mvebu_readl(port, PCIE_SSPL_OFF) & PCIE_SSPL_ENABLE))
> > +			val |= PCI_EXP_SLTCTL_ASPL_DISABLE;
> > +		/* PCI_EXP_SLTCTL is 32-bit and contains also slot status bits */
> 
> This comment is a little bit confusing because PCI_EXP_SLTCTL is not
> actually 32 bits; it's 16 bits.

My comment refers to pci-bridge-emul.c PCI_EXP_SLTCTL register, which is
32-bit. That pci-bridge-emul.c driver has 32-bit registers and in places
where PCIe register is only 16-bit, it is concatenated to previous
16-bit.

> It's just that we "read" 32 bits,
> which includes both PCI_EXP_SLTCTL and PCI_EXP_SLTSTA.  If you use
> "PCI_EXP_SLTCTL", I think it would be helpful to also say
> "PCI_EXP_SLTSTA" instead of "slot status bits".

I agree, this is misleading and confusing. And because I'm working with
pci-bridge-emul.c pci-aardvark.c and pci-mvebu.c for more than year I
probably totally forgot about confusion here as I already catch these
things...

I will try to change comments to be less confusing.

> > +		val |= slotsta << 16;
> > +		*value = val;
> >  		break;
> > +	}
> >  
> >  	case PCI_EXP_RTSTA:
> >  		*value = mvebu_readl(port, PCIE_RC_RTSTA);
> > @@ -774,6 +803,19 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
> >  		mvebu_writel(port, new, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL);
> >  		break;
> >  
> > +	case PCI_EXP_SLTCTL:
> > +		if ((mask & PCI_EXP_SLTCTL_ASPL_DISABLE) &&
> > +		    port->slot_power_limit_value &&
> > +		    port->slot_power_limit_scale) {
> > +			u32 sspl = mvebu_readl(port, PCIE_SSPL_OFF);
> > +			if (new & PCI_EXP_SLTCTL_ASPL_DISABLE)
> > +				sspl &= ~PCIE_SSPL_ENABLE;
> > +			else
> > +				sspl |= PCIE_SSPL_ENABLE;
> > +			mvebu_writel(port, sspl, PCIE_SSPL_OFF);
> 
> IIUC, the behavior of PCI_EXP_SLTCTL_ASPL_DISABLE as observed by
> software that sets it and reads it back will depend on whether the DT
> contains "slot-power-limit-milliwatt".
> 
> If there is no DT property, port->slot_power_limit_value will be zero
> and PCIE_SSPL_ENABLE will never be set.  So if I clear
> PCI_EXP_SLTCTL_ASPL_DISABLE, then read it back, it looks like it will
> read as being set.

Yes.

> That's not what I would expect from the spec (PCIe r6.0, sec 7.5.3.10).

Ok. What you would expect here? That PCI_EXP_SLTCTL_ASPL_DISABLE is not
set even when Set_Slot_Power_Limit was never sent and would be never
sent (as it was not programmed by firmware = in DT)?

> > +		}
> > +		break;
> > +
> >  	case PCI_EXP_RTSTA:
> >  		/*
> >  		 * PME Status bit in Root Status Register (PCIE_RC_RTSTA)
> > @@ -868,8 +910,26 @@ static int mvebu_pci_bridge_emul_init(struct mvebu_pcie_port *port)
> >  	/*
> >  	 * Older mvebu hardware provides PCIe Capability structure only in
> >  	 * version 1. New hardware provides it in version 2.
> > +	 * Enable slot support which is emulated.
> >  	 */
> > -	bridge->pcie_conf.cap = cpu_to_le16(pcie_cap_ver);
> > +	bridge->pcie_conf.cap = cpu_to_le16(pcie_cap_ver | PCI_EXP_FLAGS_SLOT);
> > +
> > +	/*
> > +	 * Set Presence Detect State bit permanently as there is no support for
> > +	 * unplugging PCIe card from the slot. Assume that PCIe card is always
> > +	 * connected in slot.
> > +	 *
> > +	 * Set physical slot number to port+1 as mvebu ports are indexed from
> > +	 * zero and zero value is reserved for ports within the same silicon
> > +	 * as Root Port which is not mvebu case.
> > +	 *
> > +	 * Also set correct slot power limit.
> > +	 */
> > +	bridge->pcie_conf.slotcap = cpu_to_le32(
> > +		(port->slot_power_limit_value << PCI_EXP_SLTCAP_SPLV_SHIFT) |
> > +		(port->slot_power_limit_scale << PCI_EXP_SLTCAP_SPLS_SHIFT) |
> > +		((port->port+1) << PCI_EXP_SLTCAP_PSN_SHIFT));
> > +	bridge->pcie_conf.slotsta = cpu_to_le16(PCI_EXP_SLTSTA_PDS);
> >  
> >  	bridge->subsystem_vendor_id = ssdev_id & 0xffff;
> >  	bridge->subsystem_id = ssdev_id >> 16;
> > @@ -1191,6 +1251,7 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
> >  {
> >  	struct device *dev = &pcie->pdev->dev;
> >  	enum of_gpio_flags flags;
> > +	u32 slot_power_limit;
> >  	int reset_gpio, ret;
> >  	u32 num_lanes;
> >  
> > @@ -1291,6 +1352,15 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
> >  		port->reset_gpio = gpio_to_desc(reset_gpio);
> >  	}
> >  
> > +	slot_power_limit = of_pci_get_slot_power_limit(child,
> > +				&port->slot_power_limit_value,
> > +				&port->slot_power_limit_scale);
> > +	if (slot_power_limit)
> > +		dev_info(dev, "%s: Slot power limit %u.%uW\n",
> > +			 port->name,
> > +			 slot_power_limit / 1000,
> > +			 (slot_power_limit / 100) % 10);
> > +
> >  	port->clk = of_clk_get_by_name(child, NULL);
> >  	if (IS_ERR(port->clk)) {
> >  		dev_err(dev, "%s: cannot get clock\n", port->name);
> > @@ -1587,7 +1657,7 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
> >  {
> >  	struct mvebu_pcie *pcie = platform_get_drvdata(pdev);
> >  	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> > -	u32 cmd;
> > +	u32 cmd, sspl;
> >  	int i;
> >  
> >  	/* Remove PCI bus with all devices. */
> > @@ -1624,6 +1694,11 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
> >  		/* Free config space for emulated root bridge. */
> >  		pci_bridge_emul_cleanup(&port->bridge);
> >  
> > +		/* Disable sending Set Slot Power Limit PCIe Message. */
> > +		sspl = mvebu_readl(port, PCIE_SSPL_OFF);
> > +		sspl &= ~(PCIE_SSPL_VALUE_MASK | PCIE_SSPL_SCALE_MASK | PCIE_SSPL_ENABLE);
> > +		mvebu_writel(port, sspl, PCIE_SSPL_OFF);
> > +
> >  		/* Disable and clear BARs and windows. */
> >  		mvebu_pcie_disable_wins(port);
> >  
> > -- 
> > 2.20.1
> > 
