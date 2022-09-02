Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E493B5AB6CE
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 18:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbiIBQt2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 12:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiIBQtZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 12:49:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D31F8F7F;
        Fri,  2 Sep 2022 09:49:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3151561FD0;
        Fri,  2 Sep 2022 16:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58868C433D6;
        Fri,  2 Sep 2022 16:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662137362;
        bh=58HmXJZ7cVwPGxzZXKN87EsF6m8uIuwgkC4Bpe+0XhU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hcUeydZpba6DdF+3oXTEg876gtheMWDKkhPvwDd8Z9FT9VA9ibz06Cn39ER37vNpK
         sdtaSSQK+lEr1PQsWBcrdg0cq8k/PxjlvDdslAHMHda809w/OXgJhqCNJq4AezUprM
         l7Otiy7hE7igG8+Ao9/sSiYIKR6wORwIzrV80JlEfvdMp6SYTa0xMDBT+o4coJtsVV
         5l01j351+Auo5Fv/dXL67ls7s6W4Ii9vM09MumAcpE8e4xg+vJgb4l97tLCB5KQfLH
         1xzIRd+xChEU4O7iFGgm8hQa8slilbguGya1CxLpTVOQEFm1KeiMpsioG8ofIq5/EC
         O/DsthCc06qfQ==
Date:   Fri, 2 Sep 2022 11:49:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     aou@eecs.berkeley.edu, bhelgaas@google.com,
        conor.dooley@microchip.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        lpieralisi@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org, robh@kernel.org,
        cyril.jean@microchip.com, padmarao.begari@microchip.com,
        heinrich.schuchardt@canonical.com, david.abdurachmanov@gmail.com
Subject: Re: [PATCH v1 3/4] PCI: microchip: add fabric address translation
 properties
Message-ID: <20220902164920.GA349565@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902142202.2437658-4-daire.mcnamara@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 02, 2022 at 03:22:01PM +0100, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> On PolarFire SoC both in- & out-bound address translations occur in two
> stages. The specific translations are tightly coupled to the FPGA
> designs and supplement the {dma-,}ranges properties. The first stage of
> the translation is done by the FPGA fabric & the second by the root
> port.
> Use outbound address translation information so that the translation
> tables in the root port's bridge layer can be configured to account for
> any translation done by the FPGA fabric, for example,  on Icicle Kit
> reference design.

Can you please:

  - Make your subject follow previous convention, i.e., at least
    capitalize "Add".

  - Add a blank line between paragraphs.  Patch 2/4 also lacks this
    blank line.  Without the separator, it's just confusing because I
    can't tell whether it's supposed to be a single paragraph that you
    forgot to wrap correctly, or two paragraphs.

> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> ---
>  drivers/pci/controller/pcie-microchip-host.c | 59 +++++++++++++++++---
>  1 file changed, 52 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> index 7263d175b5ad..d78745eaa4b4 100644
> --- a/drivers/pci/controller/pcie-microchip-host.c
> +++ b/drivers/pci/controller/pcie-microchip-host.c
> @@ -269,6 +269,8 @@ struct mc_pcie {
>  	struct irq_domain *event_domain;
>  	raw_spinlock_t lock;
>  	struct mc_msi msi;
> +	u32 num_outbound_ranges;
> +	u64 outbound_range_adjustments[32];
>  };
>  
>  struct cause {
> @@ -964,6 +966,37 @@ static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>  	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
>  }
>  
> +static void mc_pcie_parse_outbound_range_adjustments(struct mc_pcie *port, struct device_node *np)

Wrap to fit in 80 columns like the rest of the file.

> +{
> +	const __be32 *range;
> +	int range_len, num_ranges, range_size, i;
> +
> +	range = of_get_property(np, "microchip,outbound-fabric-translation-ranges", &range_len);
> +	if (!range)
> +		return;
> +
> +	num_ranges = of_n_addr_cells(np);
> +	range_size = range_len / sizeof(__be32) / num_ranges;
> +
> +	for (i = 0; i < num_ranges; i++, range += range_size) {
> +		u64 pcieaddr = of_read_number(range + 1, 2);
> +		u64 cpuaddr = of_read_number(range + 3, 2);
> +
> +		port->outbound_range_adjustments[i] = cpuaddr - pcieaddr;
> +		port->num_outbound_ranges++;
> +	}
> +}
> +
> +static inline u64 mc_pcie_adjust_axi(struct mc_pcie *port, int index, u64 axi_addr)

No need for this to be inline; it's not a performance path so the
"inline" annotation is just clutter and makes the line too long.

> +{
> +	u64 offset = 0;
> +
> +	if (index < port->num_outbound_ranges)
> +		offset = port->outbound_range_adjustments[index];
> +
> +	return axi_addr - offset;

  if (index < port->num_outbound_ranges)
    return axi_addr - port->outbound_range_adjustments[index];

  return axi_addr;

> +}
> +
>  static int mc_pcie_setup_windows(struct platform_device *pdev,
>  				 struct mc_pcie *port)
>  {
> @@ -971,14 +1004,28 @@ static int mc_pcie_setup_windows(struct platform_device *pdev,
>  		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
>  	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
>  	struct resource_entry *entry;
> +	u64 axi_addr;
>  	u64 pci_addr;
> -	u32 index = 1;
> +	u32 index = 0;
> +	u32 num_outbound_ranges = 0;
> +
> +	resource_list_for_each_entry(entry, &bridge->windows) {
> +		if (resource_type(entry->res) == IORESOURCE_MEM || resource_type(entry->res) == 0)

Rewrap.

> +			num_outbound_ranges++;
> +	}
> +
> +	if (port->num_outbound_ranges && port->num_outbound_ranges != num_outbound_ranges) {

Ditto.

> +		dev_err(&pdev->dev, "Mismatches in outbound range adjustment\n");
> +		return -EINVAL;
> +	}
>  
>  	resource_list_for_each_entry(entry, &bridge->windows) {
> -		if (resource_type(entry->res) == IORESOURCE_MEM) {
> +		if (resource_type(entry->res) == IORESOURCE_MEM || resource_type(entry->res) == 0) {

Ditto.

I guess "resource_type() == 0" means config space?  I assume these
entries came from devm_of_pci_get_host_bridge_resources()?  From
gen_pci_init(), I guess there's an assumption that the resource at
index 0 is ECAM space?

> +			axi_addr = entry->res->start;
> +			axi_addr = mc_pcie_adjust_axi(port, index, axi_addr);

How does this address adjustment work given that
pci_host_common_probe() has already called gen_pci_init() to map the
config space?

Hopefully you can use Rob's suggestion to just use two levels of
ranges instead.

>  			pci_addr = entry->res->start - entry->offset;
>  			mc_pcie_setup_window(bridge_base_addr, index,
> -					     entry->res->start, pci_addr,
> +					     axi_addr, pci_addr,
>  					     resource_size(entry->res));
>  			index++;
>  		}
> @@ -1005,6 +1052,8 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  		return -ENOMEM;
>  	port->dev = dev;
>  
> +	mc_pcie_parse_outbound_range_adjustments(port, dev->of_node);
> +
>  	ret = mc_pcie_init_clks(dev);
>  	if (ret) {
>  		dev_err(dev, "failed to get clock resources, error %d\n", ret);
> @@ -1099,10 +1148,6 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  	writel_relaxed(0, bridge_base_addr + IMASK_HOST);
>  	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
>  
> -	/* Configure Address Translation Table 0 for PCIe config space */
> -	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start & 0xffffffff,
> -			     cfg->res.start, resource_size(&cfg->res));
> -
>  	return mc_pcie_setup_windows(pdev, port);
>  }

Not specifically related to *this* patch, but microchip uses the
pci_ecam_ops.init() method to do a whole bunch of init completely
unrelated to ECAM, which makes things really hard to follow.

It would be more readable to have an mc_pcie_probe() that does the
mc-specific initialization and calls pci_host_common_probe() to do the
generic stuff.  This is what apple_pcie_probe() does.

Bjorn
