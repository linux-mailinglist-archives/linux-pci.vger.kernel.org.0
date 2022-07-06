Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3BC5694C6
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 23:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiGFV4I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 17:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiGFV4H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 17:56:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4414286D4;
        Wed,  6 Jul 2022 14:56:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29D0C621AC;
        Wed,  6 Jul 2022 21:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3396DC3411C;
        Wed,  6 Jul 2022 21:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657144565;
        bh=ZRqMxbF7Q4qvMihxfc0X2iutaurI4qh4CNlZPZ7R7fU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JkE7Y9tdKoOob81JlwnPX+0RsZoZ6lY1rzX+lWWUqNJTplOVvwvzwnWo87GNi9aCB
         X9i+b629W9DgrTzUg1PVrE++kHOcnrFI+ZS00TCSCtEop1DwyyZDi13UpYuWuJ+T+f
         dm8iH6+tk1cyJWpcZVhufbQN9mndjJwNvo1j3IR6NXN4KGZa8hBSGXDrjSdhNnDd64
         V39mqT/qKOM3SXe8IQ/AqDfzR5u2J3Yn5/a8dd/yXq3ypf5NKHHrFaDlKxg2vqi0WW
         Z5Sn6RG4Zt0lcicm3kIriW9a9Xbwh/RIUwe4/5jn0BdjhIPVlQn4eEPnhwg69l53Q5
         hyCxM1R4VTnXg==
Date:   Wed, 6 Jul 2022 16:56:03 -0500
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
Subject: Re: [PATCH v1 1/4] PCI: brcmstb: Split brcm_pcie_setup() into two
 funcs
Message-ID: <20220706215603.GA221278@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701162726.31346-2-jim2101024@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 01, 2022 at 12:27:22PM -0400, Jim Quinlan wrote:
> We need to take some code in brcm_pcie_setup() and put it in a new function
> brcm_pcie_linkup().  In future commits the brcm_pcie_linkup() function will
> be called indirectly by pci_host_probe() as opposed to the host driver
> invoking it directly.
>
> Some code that was executed after the PCIe linkup is now placed so that it
> executes prior to linkup, since this code has to run prior to the
> invocation of pci_host_probe().

This says we need to move some code from brcm_pcie_setup() to 
brcm_pcie_linkup(), but not *why* we need to do that.

In brcm_pcie_resume(), they're called together:

  brcm_pcie_resume
    brcm_pcie_setup
    brcm_pcie_linkup

In the probe path, they're not called together, but they're in the
same order:

  brcm_pcie_probe
    brcm_pcie_setup
    pci_host_probe
      ...
        brcm_pcie_add_bus		# bus->ops->add_bus
	  brcm_pcie_linkup

Is there something that must happen *between* them in the probe path?

> Link: https://lore.kernel.org/r/20220106160332.2143-5-jim2101024@gmail.com
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 69 +++++++++++++++++----------
>  1 file changed, 43 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index e61058e13818..2bf5cc399fd0 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -926,16 +926,9 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
>  
>  static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  {
> -	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
>  	u64 rc_bar2_offset, rc_bar2_size;
>  	void __iomem *base = pcie->base;
> -	struct device *dev = pcie->dev;
> -	struct resource_entry *entry;
> -	bool ssc_good = false;
> -	struct resource *res;
> -	int num_out_wins = 0;
> -	u16 nlw, cls, lnksta;
> -	int i, ret, memc;
> +	int ret, memc;
>  	u32 tmp, burst, aspm_support;
>  
>  	/* Reset the bridge */
> @@ -1025,6 +1018,40 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	if (pcie->gen)
>  		brcm_pcie_set_gen(pcie, pcie->gen);
>  
> +	/* Don't advertise L0s capability if 'aspm-no-l0s' */
> +	aspm_support = PCIE_LINK_STATE_L1;
> +	if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
> +		aspm_support |= PCIE_LINK_STATE_L0S;
> +	tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> +	u32p_replace_bits(&tmp, aspm_support,
> +		PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
> +	writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> +
> +	/*
> +	 * For config space accesses on the RC, show the right class for
> +	 * a PCIe-PCIe bridge (the default setting is to be EP mode).
> +	 */
> +	tmp = readl(base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> +	u32p_replace_bits(&tmp, 0x060400,
> +			  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK);
> +	writel(tmp, base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> +
> +	return 0;
> +}
> +
> +static int brcm_pcie_linkup(struct brcm_pcie *pcie)
> +{
> +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> +	struct device *dev = pcie->dev;
> +	void __iomem *base = pcie->base;
> +	struct resource_entry *entry;
> +	struct resource *res;
> +	int num_out_wins = 0;
> +	u16 nlw, cls, lnksta;
> +	bool ssc_good = false;
> +	u32 tmp;
> +	int ret, i;
> +
>  	/* Unassert the fundamental reset */
>  	pcie->perst_set(pcie, 0);
>  
> @@ -1075,24 +1102,6 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  		num_out_wins++;
>  	}
>  
> -	/* Don't advertise L0s capability if 'aspm-no-l0s' */
> -	aspm_support = PCIE_LINK_STATE_L1;
> -	if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
> -		aspm_support |= PCIE_LINK_STATE_L0S;
> -	tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> -	u32p_replace_bits(&tmp, aspm_support,
> -		PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
> -	writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> -
> -	/*
> -	 * For config space accesses on the RC, show the right class for
> -	 * a PCIe-PCIe bridge (the default setting is to be EP mode).
> -	 */
> -	tmp = readl(base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> -	u32p_replace_bits(&tmp, 0x060400,
> -			  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK);
> -	writel(tmp, base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> -
>  	if (pcie->ssc) {
>  		ret = brcm_pcie_set_ssc(pcie);
>  		if (ret == 0)
> @@ -1281,6 +1290,10 @@ static int brcm_pcie_resume(struct device *dev)
>  	if (ret)
>  		goto err_reset;
>  
> +	ret = brcm_pcie_linkup(pcie);
> +	if (ret)
> +		goto err_reset;
> +
>  	if (pcie->msi)
>  		brcm_msi_set_regs(pcie->msi);
>  
> @@ -1398,6 +1411,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto fail;
>  
> +	ret = brcm_pcie_linkup(pcie);
> +	if (ret)
> +		goto fail;
> +
>  	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
>  	if (pcie->type == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
>  		dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
