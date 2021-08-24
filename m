Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548B53F621E
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 17:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238501AbhHXP7V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 11:59:21 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:44690 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbhHXP7S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Aug 2021 11:59:18 -0400
Received: by mail-ot1-f51.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so38839932otg.11;
        Tue, 24 Aug 2021 08:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7d23cF8iEMsusuAd6FA5Lm2qtl2Bb0UY8HSFch355Qo=;
        b=nciOrv9Ffgx7TmTMphGcjTfNXrzwJskhIiy8i2NDlprf6qlPwBkaaryhDMmvhM6hlU
         lKG+FZUUgBF4unexK7e6xuhWYC6RCTBKDGHUxhygXhLxSyZswyM4BkKcuDEotRgtMuny
         sWrtNReqcBNcLyK8DKej+ncYAo+9NmmDf+Qw01vdDRhQ6qktX+xluU9Q/xfwvWgPj1kT
         f1ACDPdKpPIo1rXIUqTEvzVyQ8BYaTKYXcc0uoCN+cmp0q70k+9kgX5CtKaxsG0fx1nr
         DpHmfFtcCvpaKjleMvbX52qDpxO+U5HSkA8t86BAA4p9x/l94OvHys+mtSwJT8cTUg07
         uEnQ==
X-Gm-Message-State: AOAM532Dl/w8ZQNi1achuA2qzlsD+KDzAjgGkMzr5yooX8u6YU5i/wki
        bcXsGB+2kHqt1MFE1NgU2A==
X-Google-Smtp-Source: ABdhPJyKhTV0NYlriAi61spEDGrjlELUBbPawUuek4yNFV7ebGKVsteLEdgwd6wzdzA/v/+akk/big==
X-Received: by 2002:a9d:655a:: with SMTP id q26mr6598367otl.130.1629820713550;
        Tue, 24 Aug 2021 08:58:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v29sm4169313ooe.31.2021.08.24.08.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 08:58:32 -0700 (PDT)
Received: (nullmailer pid 531842 invoked by uid 1000);
        Tue, 24 Aug 2021 15:58:31 -0000
Date:   Tue, 24 Aug 2021 10:58:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] PCI: aardvark: Add support for sending
 Set_Slot_Power_Limit message
Message-ID: <YSUXJwrpLpzzjgvO@robh.at.kernel.org>
References: <20210820160023.3243-1-pali@kernel.org>
 <20210820160023.3243-3-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210820160023.3243-3-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 20, 2021 at 06:00:22PM +0200, Pali Rohár wrote:
> According to PCIe Base specification 3.0, when transitioning from a
> non-DL_Up Status to a DL_Up Status, the Port must initiate the
> transmission of a Set_Slot_Power_Limit Message to the other component
> on the Link to convey the value programmed in the Slot Power Limit
> Scale and Value fields of the Slot Capabilities register. This
> Transmission is optional if the Slot Capabilities register has not
> yet been initialized.
> 
> As PCIe Root Bridge is emulated by kernel emulate readback of Slot Power
> Limit Scale and Value bits in Slot Capabilities register.
> 
> Also send that Set_Slot_Power_Limit message via Message Generation Control
> Register in Link Up handler when link changes from down to up state and
> slot power limit value was defined.
> 
> Slot power limit value is read from DT property 'slot-power-limit' which
> value is in mW unit. When this DT property is not specified then it is
> treated as "Slot Capabilities register has not yet been initialized".
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  .../devicetree/bindings/pci/aardvark-pci.txt  |  2 +
>  drivers/pci/controller/pci-aardvark.c         | 66 ++++++++++++++++++-
>  2 files changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/aardvark-pci.txt b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
> index 2b8ca920a7fa..bb658f261db0 100644
> --- a/Documentation/devicetree/bindings/pci/aardvark-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/aardvark-pci.txt
> @@ -20,6 +20,7 @@ contain the following properties:
>     define the mapping of the PCIe interface to interrupt numbers.
>   - bus-range: PCI bus numbers covered
>   - phys: the PCIe PHY handle
> + - slot-power-limit: see pci.txt
>   - max-link-speed: see pci.txt
>   - reset-gpios: see pci.txt
>  
> @@ -52,6 +53,7 @@ Example:
>  				<0 0 0 3 &pcie_intc 2>,
>  				<0 0 0 4 &pcie_intc 3>;
>  		phys = <&comphy1 0>;
> +		slot-power-limit: <10000>;
>  		pcie_intc: interrupt-controller {
>  			interrupt-controller;
>  			#interrupt-cells = <1>;
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index f94898f6072f..cf704c199c15 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -166,6 +166,11 @@
>  #define VENDOR_ID_REG				(LMI_BASE_ADDR + 0x44)
>  #define DEBUG_MUX_CTRL_REG			(LMI_BASE_ADDR + 0x208)
>  #define     DIS_ORD_CHK				BIT(30)
> +#define PME_MSG_GEN_CTRL			(LMI_BASE_ADDR + 0x220)
> +#define     SEND_SET_SLOT_POWER_LIMIT		BIT(13)
> +#define     SEND_PME_TURN_OFF			BIT(14)
> +#define     SLOT_POWER_LIMIT_DATA_SHIFT		16
> +#define     SLOT_POWER_LIMIT_DATA_MASK		GENMASK(25, 16)
>  
>  /* PCIe core controller registers */
>  #define CTRL_CORE_BASE_ADDR			0x18000
> @@ -267,6 +272,7 @@ static bool advk_pcie_link_up(struct advk_pcie *pcie)
>  {
>  	u32 val, ltssm_state;
>  	u16 slotsta, slotctl;
> +	u32 slotpwr;
>  	bool link_up;
>  
>  	val = advk_readl(pcie, CFG_REG);
> @@ -277,7 +283,25 @@ static bool advk_pcie_link_up(struct advk_pcie *pcie)
>  		pcie->link_up = true;
>  		slotsta = le16_to_cpu(pcie->bridge.pcie_conf.slotsta);
>  		slotctl = le16_to_cpu(pcie->bridge.pcie_conf.slotctl);
> +		slotpwr = (le32_to_cpu(pcie->bridge.pcie_conf.slotcap) &
> +			   (PCI_EXP_SLTCAP_SPLV | PCI_EXP_SLTCAP_SPLS)) >> 7;
>  		pcie->bridge.pcie_conf.slotsta = cpu_to_le16(slotsta | PCI_EXP_SLTSTA_DLLSC);
> +		if (!(slotctl & PCI_EXP_SLTCTL_ASPL_DISABLE) && slotpwr) {
> +			/*
> +			 * According to PCIe Base specification 3.0, when transitioning from a
> +			 * non-DL_Up Status to a DL_Up Status, the Port must initiate the
> +			 * transmission of a Set_Slot_Power_Limit Message to the other component
> +			 * on the Link to convey the value programmed in the Slot Power Limit
> +			 * Scale and Value fields of the Slot Capabilities register. This
> +			 * Transmission is optional if the Slot Capabilities register has not
> +			 * yet been initialized.
> +			 */
> +			val = advk_readl(pcie, PME_MSG_GEN_CTRL);
> +			val &= ~SLOT_POWER_LIMIT_DATA_MASK;
> +			val |= slotpwr << SLOT_POWER_LIMIT_DATA_SHIFT;
> +			val |= SEND_SET_SLOT_POWER_LIMIT;
> +			advk_writel(pcie, val, PME_MSG_GEN_CTRL);
> +		}
>  		if ((slotctl & PCI_EXP_SLTCTL_DLLSCE) && (slotctl & PCI_EXP_SLTCTL_HPIE))
>  			mod_timer(&pcie->link_up_irq_timer, jiffies + 1);
>  	}
> @@ -956,6 +980,9 @@ static struct pci_bridge_emul_ops advk_pci_bridge_emul_ops = {
>  static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
>  {
>  	struct pci_bridge_emul *bridge = &pcie->bridge;
> +	struct device *dev = &pcie->pdev->dev;
> +	u8 slot_power_limit_scale, slot_power_limit_value;
> +	u32 slot_power_limit;
>  	int ret;
>  
>  	bridge->conf.vendor =
> @@ -988,6 +1015,40 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
>  	/* Indicates supports for Completion Retry Status */
>  	bridge->pcie_conf.rootcap = cpu_to_le16(PCI_EXP_RTCAP_CRSVIS);
>  

> +	if (of_property_read_u32(dev->of_node, "slot-power-limit", &slot_power_limit))
> +		slot_power_limit = 0;
> +
> +	if (slot_power_limit)
> +		dev_info(dev, "Slot power limit %u.%uW\n", slot_power_limit / 1000,
> +			 (slot_power_limit / 100) % 10);

Add a wrapper function for this.

> +
> +	/* Calculate Slot Power Limit Value and Slot Power Limit Scale */
> +	if (slot_power_limit == 0) {
> +		slot_power_limit_scale = 0;
> +		slot_power_limit_value = 0x00;
> +	} else if (slot_power_limit <= 255) {
> +		slot_power_limit_scale = 3;
> +		slot_power_limit_value = slot_power_limit;
> +	} else if (slot_power_limit <= 255*10) {
> +		slot_power_limit_scale = 2;
> +		slot_power_limit_value = slot_power_limit / 10;
> +	} else if (slot_power_limit <= 255*100) {
> +		slot_power_limit_scale = 1;
> +		slot_power_limit_value = slot_power_limit / 100;
> +	} else if (slot_power_limit <= 239*1000) {
> +		slot_power_limit_scale = 0;
> +		slot_power_limit_value = slot_power_limit / 1000;
> +	} else if (slot_power_limit <= 250*1000) {
> +		slot_power_limit_scale = 0;
> +		slot_power_limit_value = 0xF0;
> +	} else if (slot_power_limit <= 275*1000) {
> +		slot_power_limit_scale = 0;
> +		slot_power_limit_value = 0xF1;
> +	} else {
> +		slot_power_limit_scale = 0;
> +		slot_power_limit_value = 0xF2;
> +	}

This all looks like it should be common code.

> +
>  	/*
>  	 * Mark bridge as Hot-Plug Capable to allow delivering Data Link Layer
>  	 * State Changed interrupt. No Command Completed Support is set because
> @@ -996,7 +1057,10 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
>  	 * bit permanently as there is no support for unplugging PCIe card from
>  	 * the slot. Assume that PCIe card is always connected in slot.
>  	 */
> -	bridge->pcie_conf.slotcap = cpu_to_le32(PCI_EXP_SLTCAP_NCCS | PCI_EXP_SLTCAP_HPC);
> +	bridge->pcie_conf.slotcap = cpu_to_le32(PCI_EXP_SLTCAP_NCCS |
> +						PCI_EXP_SLTCAP_HPC |

While not new, how does the driver know the board is hotplug capable. 
IIRC, we have a property for that.

> +						slot_power_limit_value << 7 |
> +						slot_power_limit_scale << 15);
>  	bridge->pcie_conf.slotsta = cpu_to_le16(PCI_EXP_SLTSTA_PDS);
>  
>  	return 0;
> -- 
> 2.20.1
> 
> 
