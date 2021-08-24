Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03633F6290
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 18:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhHXQSk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 12:18:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231346AbhHXQSh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Aug 2021 12:18:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 420F261212;
        Tue, 24 Aug 2021 16:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629821873;
        bh=GUXwIYc6FaOdmgtM2ZwBXAD1QvNFWgpSegPQtCdnS40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JToGNrqle6gG5bOMSybTxYIdm57OwDmTLOh3Tz2Kam/6dCW0SkWUsSMoKan9h4Qc5
         QacXgcF+QWFx6ulG3dQc/bOAp98GOx10W8ik6FfJVqmP/M9D/K1f0RrI9Y4U7cPrnX
         xK+P/U8T14IkNsqPTl2S4rAXfLHec+XD06oKnPq9cIBvzn/ZsveCo6C4OSz5ED2Bt3
         e5DrqAGe5gSRZZVdvbfp0fdrp+IP6SvsjkCaNqYrPc7h2ZFhETQF4xG/iXGzmktW26
         IQNX2f6JEcNndMAJeuzd1RUTb1hb2gXZPQTktNO2Llj5uFBVg7Zd1cldH0dh7OKJwf
         SwluuioxepARg==
Received: by pali.im (Postfix)
        id D5CC17A5; Tue, 24 Aug 2021 18:17:50 +0200 (CEST)
Date:   Tue, 24 Aug 2021 18:17:50 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] PCI: aardvark: Add support for sending
 Set_Slot_Power_Limit message
Message-ID: <20210824161750.lfkovha2jmymr4om@pali>
References: <20210820160023.3243-1-pali@kernel.org>
 <20210820160023.3243-3-pali@kernel.org>
 <YSUXJwrpLpzzjgvO@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YSUXJwrpLpzzjgvO@robh.at.kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 24 August 2021 10:58:31 Rob Herring wrote:
> On Fri, Aug 20, 2021 at 06:00:22PM +0200, Pali Rohár wrote:
> > According to PCIe Base specification 3.0, when transitioning from a
> > non-DL_Up Status to a DL_Up Status, the Port must initiate the
> > transmission of a Set_Slot_Power_Limit Message to the other component
> > on the Link to convey the value programmed in the Slot Power Limit
> > Scale and Value fields of the Slot Capabilities register. This
> > Transmission is optional if the Slot Capabilities register has not
> > yet been initialized.
> > 
> > As PCIe Root Bridge is emulated by kernel emulate readback of Slot Power
> > Limit Scale and Value bits in Slot Capabilities register.
> > 
> > Also send that Set_Slot_Power_Limit message via Message Generation Control
> > Register in Link Up handler when link changes from down to up state and
> > slot power limit value was defined.
> > 
> > Slot power limit value is read from DT property 'slot-power-limit' which
> > value is in mW unit. When this DT property is not specified then it is
> > treated as "Slot Capabilities register has not yet been initialized".
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  .../devicetree/bindings/pci/aardvark-pci.txt  |  2 +
> >  drivers/pci/controller/pci-aardvark.c         | 66 ++++++++++++++++++-
> >  2 files changed, 67 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/aardvark-pci.txt b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
> > index 2b8ca920a7fa..bb658f261db0 100644
> > --- a/Documentation/devicetree/bindings/pci/aardvark-pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
> > @@ -20,6 +20,7 @@ contain the following properties:
> >     define the mapping of the PCIe interface to interrupt numbers.
> >   - bus-range: PCI bus numbers covered
> >   - phys: the PCIe PHY handle
> > + - slot-power-limit: see pci.txt
> >   - max-link-speed: see pci.txt
> >   - reset-gpios: see pci.txt
> >  
> > @@ -52,6 +53,7 @@ Example:
> >  				<0 0 0 3 &pcie_intc 2>,
> >  				<0 0 0 4 &pcie_intc 3>;
> >  		phys = <&comphy1 0>;
> > +		slot-power-limit: <10000>;
> >  		pcie_intc: interrupt-controller {
> >  			interrupt-controller;
> >  			#interrupt-cells = <1>;
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index f94898f6072f..cf704c199c15 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -166,6 +166,11 @@
> >  #define VENDOR_ID_REG				(LMI_BASE_ADDR + 0x44)
> >  #define DEBUG_MUX_CTRL_REG			(LMI_BASE_ADDR + 0x208)
> >  #define     DIS_ORD_CHK				BIT(30)
> > +#define PME_MSG_GEN_CTRL			(LMI_BASE_ADDR + 0x220)
> > +#define     SEND_SET_SLOT_POWER_LIMIT		BIT(13)
> > +#define     SEND_PME_TURN_OFF			BIT(14)
> > +#define     SLOT_POWER_LIMIT_DATA_SHIFT		16
> > +#define     SLOT_POWER_LIMIT_DATA_MASK		GENMASK(25, 16)
> >  
> >  /* PCIe core controller registers */
> >  #define CTRL_CORE_BASE_ADDR			0x18000
> > @@ -267,6 +272,7 @@ static bool advk_pcie_link_up(struct advk_pcie *pcie)
> >  {
> >  	u32 val, ltssm_state;
> >  	u16 slotsta, slotctl;
> > +	u32 slotpwr;
> >  	bool link_up;
> >  
> >  	val = advk_readl(pcie, CFG_REG);
> > @@ -277,7 +283,25 @@ static bool advk_pcie_link_up(struct advk_pcie *pcie)
> >  		pcie->link_up = true;
> >  		slotsta = le16_to_cpu(pcie->bridge.pcie_conf.slotsta);
> >  		slotctl = le16_to_cpu(pcie->bridge.pcie_conf.slotctl);
> > +		slotpwr = (le32_to_cpu(pcie->bridge.pcie_conf.slotcap) &
> > +			   (PCI_EXP_SLTCAP_SPLV | PCI_EXP_SLTCAP_SPLS)) >> 7;
> >  		pcie->bridge.pcie_conf.slotsta = cpu_to_le16(slotsta | PCI_EXP_SLTSTA_DLLSC);
> > +		if (!(slotctl & PCI_EXP_SLTCTL_ASPL_DISABLE) && slotpwr) {
> > +			/*
> > +			 * According to PCIe Base specification 3.0, when transitioning from a
> > +			 * non-DL_Up Status to a DL_Up Status, the Port must initiate the
> > +			 * transmission of a Set_Slot_Power_Limit Message to the other component
> > +			 * on the Link to convey the value programmed in the Slot Power Limit
> > +			 * Scale and Value fields of the Slot Capabilities register. This
> > +			 * Transmission is optional if the Slot Capabilities register has not
> > +			 * yet been initialized.
> > +			 */
> > +			val = advk_readl(pcie, PME_MSG_GEN_CTRL);
> > +			val &= ~SLOT_POWER_LIMIT_DATA_MASK;
> > +			val |= slotpwr << SLOT_POWER_LIMIT_DATA_SHIFT;
> > +			val |= SEND_SET_SLOT_POWER_LIMIT;
> > +			advk_writel(pcie, val, PME_MSG_GEN_CTRL);
> > +		}
> >  		if ((slotctl & PCI_EXP_SLTCTL_DLLSCE) && (slotctl & PCI_EXP_SLTCTL_HPIE))
> >  			mod_timer(&pcie->link_up_irq_timer, jiffies + 1);
> >  	}
> > @@ -956,6 +980,9 @@ static struct pci_bridge_emul_ops advk_pci_bridge_emul_ops = {
> >  static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
> >  {
> >  	struct pci_bridge_emul *bridge = &pcie->bridge;
> > +	struct device *dev = &pcie->pdev->dev;
> > +	u8 slot_power_limit_scale, slot_power_limit_value;
> > +	u32 slot_power_limit;
> >  	int ret;
> >  
> >  	bridge->conf.vendor =
> > @@ -988,6 +1015,40 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
> >  	/* Indicates supports for Completion Retry Status */
> >  	bridge->pcie_conf.rootcap = cpu_to_le16(PCI_EXP_RTCAP_CRSVIS);
> >  
> 
> > +	if (of_property_read_u32(dev->of_node, "slot-power-limit", &slot_power_limit))
> > +		slot_power_limit = 0;
> > +
> > +	if (slot_power_limit)
> > +		dev_info(dev, "Slot power limit %u.%uW\n", slot_power_limit / 1000,
> > +			 (slot_power_limit / 100) % 10);
> 
> Add a wrapper function for this.
> 
> > +
> > +	/* Calculate Slot Power Limit Value and Slot Power Limit Scale */
> > +	if (slot_power_limit == 0) {
> > +		slot_power_limit_scale = 0;
> > +		slot_power_limit_value = 0x00;
> > +	} else if (slot_power_limit <= 255) {
> > +		slot_power_limit_scale = 3;
> > +		slot_power_limit_value = slot_power_limit;
> > +	} else if (slot_power_limit <= 255*10) {
> > +		slot_power_limit_scale = 2;
> > +		slot_power_limit_value = slot_power_limit / 10;
> > +	} else if (slot_power_limit <= 255*100) {
> > +		slot_power_limit_scale = 1;
> > +		slot_power_limit_value = slot_power_limit / 100;
> > +	} else if (slot_power_limit <= 239*1000) {
> > +		slot_power_limit_scale = 0;
> > +		slot_power_limit_value = slot_power_limit / 1000;
> > +	} else if (slot_power_limit <= 250*1000) {
> > +		slot_power_limit_scale = 0;
> > +		slot_power_limit_value = 0xF0;
> > +	} else if (slot_power_limit <= 275*1000) {
> > +		slot_power_limit_scale = 0;
> > +		slot_power_limit_value = 0xF1;
> > +	} else {
> > +		slot_power_limit_scale = 0;
> > +		slot_power_limit_value = 0xF2;
> > +	}
> 
> This all looks like it should be common code.

Yes, this is common code. I will put it into some common function.

> > +
> >  	/*
> >  	 * Mark bridge as Hot-Plug Capable to allow delivering Data Link Layer
> >  	 * State Changed interrupt. No Command Completed Support is set because
> > @@ -996,7 +1057,10 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
> >  	 * bit permanently as there is no support for unplugging PCIe card from
> >  	 * the slot. Assume that PCIe card is always connected in slot.
> >  	 */
> > -	bridge->pcie_conf.slotcap = cpu_to_le32(PCI_EXP_SLTCAP_NCCS | PCI_EXP_SLTCAP_HPC);
> > +	bridge->pcie_conf.slotcap = cpu_to_le32(PCI_EXP_SLTCAP_NCCS |
> > +						PCI_EXP_SLTCAP_HPC |
> 
> While not new, how does the driver know the board is hotplug capable. 
> IIRC, we have a property for that.

Just ignore it for now. It is part of unfinished patches. I sent it to
show how slot_power_limit would be configured via emulated root bridge.

> > +						slot_power_limit_value << 7 |
> > +						slot_power_limit_scale << 15);
> >  	bridge->pcie_conf.slotsta = cpu_to_le16(PCI_EXP_SLTSTA_PDS);
> >  
> >  	return 0;
> > -- 
> > 2.20.1
> > 
> > 
