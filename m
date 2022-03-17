Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C206D4DC26E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 10:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiCQJRH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 05:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiCQJRH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 05:17:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7C9E11D7AF;
        Thu, 17 Mar 2022 02:15:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A277A1476;
        Thu, 17 Mar 2022 02:15:50 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.43.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 137E33F766;
        Thu, 17 Mar 2022 02:15:47 -0700 (PDT)
Date:   Thu, 17 Mar 2022 09:15:43 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <maz@kernel.org>,
        dann frazier <dann.frazier@canonical.com>, robh@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Toan Le <toan@os.amperecomputing.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        dann frazier <dann.frazier@canonical.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH] PCI: xgene: Revert "PCI: xgene: Use inbound resources
 for setup"
Message-ID: <YjL8P0zkle2foxbk@lpieralisi>
References: <20220314144429.1947610-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220314144429.1947610-1-maz@kernel.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[removed CC stable]

On Mon, Mar 14, 2022 at 02:44:29PM +0000, Marc Zyngier wrote:
> Commit 6dce5aa59e0b ("PCI: xgene: Use inbound resources for setup")
> killed PCIe on my XGene-1 box (a Mustang board). The machine itself
> is still alive, but half of its storage (over NVMe) is gone, and the
> NVMe driver just times out.
> 
> Note that this machine boots with a device tree provided by the
> UEFI firmware (2016 vintage), which could well be non conformant
> with the spec, hence the breakage.
> 
> With the patch reverted, the box boots 5.17-rc8 with flying colors.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Toan Le <toan@os.amperecomputing.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Krzysztof Wilczyński <kw@linux.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Stéphane Graber <stgraber@ubuntu.com>
> Cc: dann frazier <dann.frazier@canonical.com>
> Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> Cc: stable@vger.kernel.org>
> ---
>  drivers/pci/controller/pci-xgene.c | 33 ++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 11 deletions(-)

Dann, Rob,

does this fix the regression debated here:

https://lore.kernel.org/all/Yf2wTLjmcRj+AbDv@xps13.dannf

It is unclear in that thread what the conclusion reached was.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
> index 0d5acbfc7143..aa41ceaf031f 100644
> --- a/drivers/pci/controller/pci-xgene.c
> +++ b/drivers/pci/controller/pci-xgene.c
> @@ -479,28 +479,27 @@ static int xgene_pcie_select_ib_reg(u8 *ib_reg_mask, u64 size)
>  }
>  
>  static void xgene_pcie_setup_ib_reg(struct xgene_pcie *port,
> -				    struct resource_entry *entry,
> -				    u8 *ib_reg_mask)
> +				    struct of_pci_range *range, u8 *ib_reg_mask)
>  {
>  	void __iomem *cfg_base = port->cfg_base;
>  	struct device *dev = port->dev;
>  	void __iomem *bar_addr;
>  	u32 pim_reg;
> -	u64 cpu_addr = entry->res->start;
> -	u64 pci_addr = cpu_addr - entry->offset;
> -	u64 size = resource_size(entry->res);
> +	u64 cpu_addr = range->cpu_addr;
> +	u64 pci_addr = range->pci_addr;
> +	u64 size = range->size;
>  	u64 mask = ~(size - 1) | EN_REG;
>  	u32 flags = PCI_BASE_ADDRESS_MEM_TYPE_64;
>  	u32 bar_low;
>  	int region;
>  
> -	region = xgene_pcie_select_ib_reg(ib_reg_mask, size);
> +	region = xgene_pcie_select_ib_reg(ib_reg_mask, range->size);
>  	if (region < 0) {
>  		dev_warn(dev, "invalid pcie dma-range config\n");
>  		return;
>  	}
>  
> -	if (entry->res->flags & IORESOURCE_PREFETCH)
> +	if (range->flags & IORESOURCE_PREFETCH)
>  		flags |= PCI_BASE_ADDRESS_MEM_PREFETCH;
>  
>  	bar_low = pcie_bar_low_val((u32)cpu_addr, flags);
> @@ -531,13 +530,25 @@ static void xgene_pcie_setup_ib_reg(struct xgene_pcie *port,
>  
>  static int xgene_pcie_parse_map_dma_ranges(struct xgene_pcie *port)
>  {
> -	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(port);
> -	struct resource_entry *entry;
> +	struct device_node *np = port->node;
> +	struct of_pci_range range;
> +	struct of_pci_range_parser parser;
> +	struct device *dev = port->dev;
>  	u8 ib_reg_mask = 0;
>  
> -	resource_list_for_each_entry(entry, &bridge->dma_ranges)
> -		xgene_pcie_setup_ib_reg(port, entry, &ib_reg_mask);
> +	if (of_pci_dma_range_parser_init(&parser, np)) {
> +		dev_err(dev, "missing dma-ranges property\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Get the dma-ranges from DT */
> +	for_each_of_pci_range(&parser, &range) {
> +		u64 end = range.cpu_addr + range.size - 1;
>  
> +		dev_dbg(dev, "0x%08x 0x%016llx..0x%016llx -> 0x%016llx\n",
> +			range.flags, range.cpu_addr, end, range.pci_addr);
> +		xgene_pcie_setup_ib_reg(port, &range, &ib_reg_mask);
> +	}
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 
