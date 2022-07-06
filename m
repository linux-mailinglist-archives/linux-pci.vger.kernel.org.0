Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25D45695AC
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 01:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiGFXNb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 19:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbiGFXN1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 19:13:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57885F12;
        Wed,  6 Jul 2022 16:13:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E878C61E73;
        Wed,  6 Jul 2022 23:13:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E338C341CA;
        Wed,  6 Jul 2022 23:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657149205;
        bh=t5NRaBUfMxchTeFrdnqRAu3a2uP/L9/bkoa+5umIdRc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ejH77V8VcSzb3ntMwzTqxcvBZ2lvKt5cd0HMa3isbENM9k4eLmL5UKfmu4IYSe6AR
         867ArwZ3Xm8nzQubQ3ihsDrBuf4dOzyt31b+n73r43B1XMZzSx8lZ4LovHMF+VQoEV
         WD0RpJfclOuf8NYUqdOcFE379X7iZkvxBVnW5ONX6C2dLE2iylQb/gFGmqTcTcGhKB
         yoiujjq2gI4m/Qz3eN8Mp42lC7fACdA/Llgtuu7B2MuvDTRQvFcmIKYu2v5+AfwxIn
         ksP20rXfuLhjhE9V1tSnSzYw+1ydIBOHZ4EoQqYhtfk3TvVv0LJYvfFsgX0aHbrQpu
         Sh185EFya+9hw==
Date:   Wed, 6 Jul 2022 18:13:23 -0500
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
        Philipp Zabel <p.zabel@pengutronix.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/4] PCI: brcmstb: Add control of subdevice voltage
 regulators
Message-ID: <20220706231323.GA237418@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701162726.31346-4-jim2101024@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 01, 2022 at 12:27:24PM -0400, Jim Quinlan wrote:
> This Broadcom STB PCIe RC driver has one port and connects directly to one
> device, be it a switch or an endpoint.  We want to be able to leverage the
> recently added mechanism that allocates and turns on/off subdevice
> regulators.
> 
> All that needs to be done is to put the regulator DT nodes in the bridge
> below host and to set the pci_ops methods add_bus and remove_bus.
> 
> Note that the pci_subdev_regulators_add_bus() method is wrapped for two
> reasons:
> 
>    1. To achieve link up after the voltage regulators are turned on.
> 
>    2. If, in the case of an unsuccessful link up, to redirect any PCIe
>       accesses to subdevices, e.g. the scan for DEV/ID.  This redirection
>       is needed because the Broadcom PCIe HW will issue a CPU abort if such
>       an access is made when the link is down.
> 
> [bhelgaas: fold in
> https://lore.kernel.org/r/20220112013100.48029-1-jim2101024@gmail.com]
> Link: https://lore.kernel.org/r/20220106160332.2143-7-jim2101024@gmail.com
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 86 ++++++++++++++++++++++++---
>  1 file changed, 77 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 661d3834c6da..a86bf502a265 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -196,6 +196,8 @@ static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie,
>  static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val);
>  static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val);
>  static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val);
> +static int brcm_pcie_linkup(struct brcm_pcie *pcie);
> +static int brcm_pcie_add_bus(struct pci_bus *bus);

I think the brcm_pcie_add_bus() declaration is unnecessary.

The brcm_pcie_linkup() one is probably unnecessary, too, but would
require a lot of reordering that I don't think we should do in this
series.

>  enum {
>  	RGR1_SW_INIT_1,
> @@ -329,6 +331,8 @@ struct brcm_pcie {
>  	u32			hw_rev;
>  	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
>  	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> +	bool			refusal_mode;
> +	struct subdev_regulators *sr;
>  };
>  
>  static inline bool is_bmips(const struct brcm_pcie *pcie)
> @@ -497,6 +501,33 @@ static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
>  	return 0;
>  }
>  
> +static int brcm_pcie_add_bus(struct pci_bus *bus)
> +{
> +	struct brcm_pcie *pcie = (struct brcm_pcie *) bus->sysdata;
> +	int ret;
> +
> +	if (!bus->parent || !pci_is_root_bus(bus->parent))
> +		return 0;
> +
> +	ret = pci_subdev_regulators_add_bus(bus);
> +	if (ret)
> +		return ret;
> +
> +	/* Grab the regulators for suspend/resume */
> +	pcie->sr = bus->dev.driver_data;
> +
> +	/*
> +	 * If we have failed linkup there is no point to return an error as
> +	 * currently it will cause a WARNING() from pci_alloc_child_bus().
> +	 * We return 0 and turn on the "refusal_mode" so that any further
> +	 * accesses to the pci_dev just get 0xffffffff
> +	 */
> +	if (brcm_pcie_linkup(pcie) != 0)
> +		pcie->refusal_mode = true;

Is there a bisection hole between the previous patch and this one?
The previous patch sets .add_bus() to pci_subdev_regulators_add_bus(),
so we'll turn on the regulators, but we don't know whether the link
came up.  If it didn't come up, it looks like we might get a CPU abort
when enumerating?

I think we should split out the refusal_mode patch:

  - Add refusal mode
  - Add subdev regulator mechanism
  - This patch (which would then be clearly about managing regulators
    in suspend/resume, IIUC)

> +	return 0;
> +}
> +
>  static void pci_subdev_regulators_remove_bus(struct pci_bus *bus)
>  {
>  	struct device *dev = &bus->dev;
> @@ -826,6 +857,18 @@ static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
>  	/* Accesses to the RC go right to the RC registers if slot==0 */
>  	if (pci_is_root_bus(bus))
>  		return PCI_SLOT(devfn) ? NULL : base + where;
> +	if (pcie->refusal_mode) {
> +		/*
> +		 * At this point we do not have link.  There will be a CPU
> +		 * abort -- a quirk with this controller --if Linux tries
> +		 * to read any config-space registers besides those
> +		 * targeting the host bridge.  To prevent this we hijack
> +		 * the address to point to a safe access that will return
> +		 * 0xffffffff.
> +		 */
> +		writel(0xffffffff, base + PCIE_MISC_RC_BAR2_CONFIG_HI);
> +		return base + PCIE_MISC_RC_BAR2_CONFIG_HI + (where & 0x3);
> +	}
>  
>  	/* For devices, write to the config space index register */
>  	idx = PCIE_ECAM_OFFSET(bus->number, devfn, 0);
> @@ -854,7 +897,7 @@ static struct pci_ops brcm_pcie_ops = {
>  	.map_bus = brcm_pcie_map_conf,
>  	.read = pci_generic_config_read,
>  	.write = pci_generic_config_write,
> -	.add_bus = pci_subdev_regulators_add_bus,
> +	.add_bus = brcm_pcie_add_bus,
>  	.remove_bus = pci_subdev_regulators_remove_bus,
>  };
>  
> @@ -1327,6 +1370,14 @@ static int brcm_pcie_suspend(struct device *dev)
>  		return ret;
>  	}
>  
> +	if (pcie->sr) {
> +		ret = regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
> +		if (ret) {
> +			dev_err(dev, "Could not turn off regulators\n");
> +			reset_control_reset(pcie->rescal);
> +			return ret;
> +		}
> +	}
>  	clk_disable_unprepare(pcie->clk);
>  
>  	return 0;
> @@ -1344,9 +1395,17 @@ static int brcm_pcie_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> +	if (pcie->sr) {
> +		ret = regulator_bulk_enable(pcie->sr->num_supplies, pcie->sr->supplies);
> +		if (ret) {
> +			dev_err(dev, "Could not turn on regulators\n");
> +			goto err_disable_clk;
> +		}
> +	}
> +
>  	ret = reset_control_reset(pcie->rescal);
>  	if (ret)
> -		goto err_disable_clk;
> +		goto err_regulator;
>  
>  	ret = brcm_phy_start(pcie);
>  	if (ret)
> @@ -1378,6 +1437,9 @@ static int brcm_pcie_resume(struct device *dev)
>  
>  err_reset:
>  	reset_control_rearm(pcie->rescal);
> +err_regulator:
> +	if (pcie->sr)
> +		regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
>  err_disable_clk:
>  	clk_disable_unprepare(pcie->clk);
>  	return ret;
> @@ -1488,10 +1550,6 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto fail;
>  
> -	ret = brcm_pcie_linkup(pcie);
> -	if (ret)
> -		goto fail;
> -
>  	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
>  	if (pcie->type == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
>  		dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
> @@ -1513,7 +1571,17 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pcie);
>  
> -	return pci_host_probe(bridge);
> +	ret = pci_host_probe(bridge);
> +	if (!ret && !brcm_pcie_link_up(pcie))
> +		ret = -ENODEV;
> +
> +	if (ret) {
> +		brcm_pcie_remove(pdev);
> +		return ret;
> +	}
> +
> +	return 0;
> +
>  fail:
>  	__brcm_pcie_remove(pcie);
>  	return ret;
> @@ -1522,8 +1590,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  MODULE_DEVICE_TABLE(of, brcm_pcie_match);
>  
>  static const struct dev_pm_ops brcm_pcie_pm_ops = {
> -	.suspend = brcm_pcie_suspend,
> -	.resume = brcm_pcie_resume,
> +	.suspend_noirq = brcm_pcie_suspend,
> +	.resume_noirq = brcm_pcie_resume,

Can you name these brcm_pcie_suspend_noirq() and
brcm_pcie_resume_noirq() to match the hook names?

>  };
>  
>  static struct platform_driver brcm_pcie_driver = {
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
