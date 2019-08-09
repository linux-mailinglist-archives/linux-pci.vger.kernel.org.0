Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4DE98844C
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 22:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfHIU4g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 16:56:36 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:40018 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfHIU4f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2019 16:56:35 -0400
Received: from penelope.horms.nl (unknown [66.60.152.14])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 74AC625AEE2;
        Sat, 10 Aug 2019 06:56:33 +1000 (AEST)
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 0DEC2E21D63; Fri,  9 Aug 2019 22:56:32 +0200 (CEST)
Date:   Fri, 9 Aug 2019 13:56:32 -0700
From:   Simon Horman <horms@verge.net.au>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org, Oza Pawandeep <oza.oza@broadcom.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] OF/PCI: Export inbound memory interface to PCI RC
 drivers.
Message-ID: <20190809205631.eru5gmv4d4yj3pfs@verge.net.au>
References: <20190809173449.20126-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809173449.20126-1-marek.vasut@gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 09, 2019 at 07:34:48PM +0200, marek.vasut@gmail.com wrote:
> From: Oza Pawandeep <oza.oza@broadcom.com>
> 
> The patch exports interface to PCIe RC drivers so that,
> Drivers can get their inbound memory configuration.
> 
> It provides basis for IOVA reservations for inbound memory
> holes, if RC is not capable of addressing all the host memory,
> Specifically when IOMMU is enabled and on ARMv8 where 64bit IOVA
> could be allocated.
> 
> It handles multiple inbound windows, and returns resources,
> and is left to the caller, how it wants to use them.
> 
> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org
> ---
>  drivers/pci/of.c       | 96 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of_pci.h |  7 +++
>  2 files changed, 103 insertions(+)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index bc7b27a28795..4018f1a26f6f 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -347,6 +347,102 @@ int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(devm_of_pci_get_host_bridge_resources);
> +
> +/**
> + * of_pci_get_dma_ranges - Parse PCI host bridge inbound resources from DT
> + * @np: device node of the host bridge having the dma-ranges property
> + * @resources: list where the range of resources will be added after DT parsing
> + *
> + * It is the caller's job to free the @resources list.
> + *
> + * This function will parse the "dma-ranges" property of a
> + * PCI host bridge device node and setup the resource mapping based
> + * on its content.
> + *
> + * It returns zero if the range parsing has been successful or a standard error
> + * value if it failed.
> + */
> +
> +int of_pci_get_dma_ranges(struct device_node *dn, struct list_head *resources)
> +{
> +	struct device_node *node = of_node_get(dn);
> +	int rlen;
> +	int pna = of_n_addr_cells(node);
> +	const int na = 3, ns = 2;
> +	int np = pna + na + ns;
> +	int ret = 0;
> +	struct resource *res;
> +	const u32 *dma_ranges;

It seems that const __be32 * would be a more appropriate type
for dma_ranges as that seems to be the expected type in
all uses below.

> +	struct of_pci_range range;
> +
> +	if (!node)
> +		return -EINVAL;
> +
> +	while (1) {
> +		dma_ranges = of_get_property(node, "dma-ranges", &rlen);
> +
> +		/* Ignore empty ranges, they imply no translation required. */
> +		if (dma_ranges && rlen > 0)
> +			break;
> +
> +		/* no dma-ranges, they imply no translation required. */
> +		if (!dma_ranges)
> +			break;
> +
> +		node = of_get_next_parent(node);
> +
> +		if (!node)
> +			break;
> +	}
> +
> +	if (!dma_ranges) {
> +		pr_debug("pcie device has no dma-ranges defined for node(%s)\n",
> +			  dn->full_name);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	while ((rlen -= np * 4) >= 0) {
> +		range.pci_space = be32_to_cpup((const __be32 *) &dma_ranges[0]);

	Can &dma_ranges[0] be more succinctly written as dma_ranges ?

> +		range.pci_addr = of_read_number(dma_ranges + 1, ns);
> +		range.cpu_addr = of_translate_dma_address(node,
> +							dma_ranges + na);
> +		range.size = of_read_number(dma_ranges + pna + na, ns);
> +		range.flags = IORESOURCE_MEM;
> +
> +		dma_ranges += np;
> +
> +		/*
> +		 * If we failed translation or got a zero-sized region
> +		 * then skip this range.
> +		 */
> +		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
> +			continue;
> +
> +		res = kzalloc(sizeof(struct resource), GFP_KERNEL);
> +		if (!res) {
> +			ret = -ENOMEM;
> +			goto parse_failed;
> +		}
> +
> +		ret = of_pci_range_to_resource(&range, dn, res);
> +		if (ret) {
> +			kfree(res);
> +			continue;
> +		}
> +
> +		pci_add_resource_offset(resources, res,
> +					res->start - range.pci_addr);
> +	}
> +	return ret;
> +
> +parse_failed:
> +	pci_free_resource_list(resources);
> +out:
> +	of_node_put(node);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(of_pci_get_dma_ranges);
>  #endif /* CONFIG_OF_ADDRESS */
>  
>  #if IS_ENABLED(CONFIG_OF_IRQ)
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index 21a89c4880fa..02bff0587dd2 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -13,6 +13,7 @@ struct device_node;
>  struct device_node *of_pci_find_child_device(struct device_node *parent,
>  					     unsigned int devfn);
>  int of_pci_get_devfn(struct device_node *np);
> +int of_pci_get_dma_ranges(struct device_node *np, struct list_head *resources);
>  void of_pci_check_probe_only(void);
>  #else
>  static inline struct device_node *of_pci_find_child_device(struct device_node *parent,
> @@ -26,6 +27,12 @@ static inline int of_pci_get_devfn(struct device_node *np)
>  	return -EINVAL;
>  }
>  
> +static inline int of_pci_get_dma_ranges(struct device_node *np,
> +					struct list_head *resources)
> +{
> +	return -EINVAL;
> +}
> +
>  static inline void of_pci_check_probe_only(void) { }
>  #endif
>  
> -- 
> 2.20.1
> 
