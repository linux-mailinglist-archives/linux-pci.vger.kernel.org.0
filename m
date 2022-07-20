Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64A657BFE7
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 00:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiGTWGI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 18:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiGTWGG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 18:06:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F92422DB;
        Wed, 20 Jul 2022 15:06:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACEA7B82220;
        Wed, 20 Jul 2022 22:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F105BC341C7;
        Wed, 20 Jul 2022 22:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658354760;
        bh=qYViTxSdzdo85TRjxcG0IeVUNVFx1NYEZydO+uq4vs0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rH/cEngXsM5vG3FeARaAn+VpgiODrGvNEsYBjPBEEZsWiDRBuoUFwIbYVS2BWk41q
         p7V5o0O/kvHoiPhiCTDabYy7EJhDCWaRgmnfM9pI0jdsTV9kGU786tpttATFol5Oa2
         PqoPA44LabkGXX4G0PMMkHFJh8RFiWIijX+ywehOBSy7Khs1oFmDJoLzk+n6ffneEg
         KDEg1zCVgJjqY461V6vjaeA0ydqk89Vgf3x/2F0KnHm4G5C6AyFws8xor1z74o29KJ
         DhY1nxzPp2j4bBXjEnWNJWfkGi5kJ2pBu9f+JJqQUwtw+OEADs96/rZTi1TKbpfDoQ
         D4LQibpCeRBBQ==
Date:   Wed, 20 Jul 2022 17:05:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] PCI: brcmstb: Add "refusal mode" to preclude
 PCIe-induced CPU aborts
Message-ID: <20220720220558.GA1661469@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716222454.29914-4-jim2101024@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 16, 2022 at 06:24:50PM -0400, Jim Quinlan wrote:
> Our PCIe RC HW has an atypical behavior: if it does not have PCIe link
> established between itself and downstream, any subsequent config space
> access causes a CPU abort.  This commit sets a "refusal mode" if the PCIe
> link-up fails, and this has our pci_ops map_bus function returning a NULL
> address, which in turn precludes the access from happening.
> 
> Right now, "refusal mode" is window dressing.  It will become relevant
> in a future commit when brcm_pcie_start_link() is invoked during
> enumeration instead of before it.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index c026446d5830..72219a4f3964 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -255,6 +255,7 @@ struct brcm_pcie {
>  	u32			hw_rev;
>  	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
>  	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> +	bool			refusal_mode;
>  };
>  
>  static inline bool is_bmips(const struct brcm_pcie *pcie)
> @@ -687,6 +688,19 @@ static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
>  	if (pci_is_root_bus(bus))
>  		return PCI_SLOT(devfn) ? NULL : base + where;
>  
> +	if (pcie->refusal_mode) {
> +		/*
> +		 * At this point we do not have PCIe link-up.  If there is
> +		 * a config read or write access besides those targeting
> +		 * the host bridge, our PCIe HW throws a CPU abort.  To
> +		 * prevent this we return the NULL address.  The calling
> +		 * functions -- pci_generic_config_*() -- will notice this
> +		 * and not perform the access, and if it is a read access,
> +		 * 0xffffffff is returned.
> +		 */
> +		return NULL;
> +	}

Is this any different from all the other .map_bus() implementations
that return NULL when the link is down?

  cdns_pci_map_bus()
  dw_pcie_other_conf_map_bus()
  nwl_pcie_map_bus() (see nwl_pcie_valid_device())
  xilinx_pcie_map_bus() (see xilinx_pcie_valid_device())

If you can implement this the same way, i.e., using
brcm_pcie_link_up(), it would be nice.

>  	/* For devices, write to the config space index register */
>  	idx = PCIE_ECAM_OFFSET(bus->number, devfn, 0);
>  	writel(idx, pcie->base + PCIE_EXT_CFG_INDEX);
> @@ -704,6 +718,11 @@ static void __iomem *brcm_pcie_map_conf32(struct pci_bus *bus, unsigned int devf
>  	if (pci_is_root_bus(bus))
>  		return PCI_SLOT(devfn) ? NULL : base + (where & ~0x3);
>  
> +	if (pcie->refusal_mode) {
> +		/* See note above in brcm_pcie_map_conf() */
> +		return NULL;
> +	}
> +
>  	/* For devices, write to the config space index register */
>  	idx = PCIE_ECAM_OFFSET(bus->number, devfn, (where & ~3));
>  	writel(idx, base + IDX_ADDR(pcie));
> @@ -989,6 +1008,7 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
>  		dev_err(dev, "link down\n");
>  		return -ENODEV;
>  	}
> +	pcie->refusal_mode = false;
>  
>  	if (!brcm_pcie_rc_mode(pcie)) {
>  		dev_err(dev, "PCIe misconfigured; is in EP mode\n");
> @@ -1134,6 +1154,8 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
>  	void __iomem *base = pcie->base;
>  	int tmp;
>  
> +	pcie->refusal_mode = true;
> +
>  	if (brcm_pcie_link_up(pcie))
>  		brcm_pcie_enter_l23(pcie);
>  	/* Assert fundamental reset */
> @@ -1185,6 +1207,7 @@ static int brcm_pcie_resume(struct device *dev)
>  	u32 tmp;
>  	int ret;
>  
> +	pcie->refusal_mode = true;
>  	base = pcie->base;
>  	ret = clk_prepare_enable(pcie->clk);
>  	if (ret)
> @@ -1361,6 +1384,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	pcie->type = data->type;
>  	pcie->perst_set = data->perst_set;
>  	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
> +	pcie->refusal_mode = true;
>  
>  	pcie->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(pcie->base))
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
