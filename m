Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9731CC28F7
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 23:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbfI3Vku (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 17:40:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731036AbfI3Vku (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 17:40:50 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 208D720815;
        Mon, 30 Sep 2019 21:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569879649;
        bh=s26f+4Qrh8dEz5mtj+K68gZUPj8yMT5f75zQIdkTK9k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vhQ02bfNHRsNR5IftQPMp2GRllZIMFl/wC8F6tpAOMMYTPagJkaVmrLb64NYZUYj8
         kdQuNOExxiO36eIv3FzjzfiVgwdCAl3mTjR8voUK/do+0gCDIOFMs1BACnfBIxS3Y3
         r5QHkRM2lo0zJaFZPlIQ1Zg4yfMiBBMI1NpO+bIg=
Date:   Mon, 30 Sep 2019 16:40:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org, Oza Pawandeep <oza.oza@broadcom.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] OF/PCI: Export inbound memory interface to PCI RC
 drivers.
Message-ID: <20190930214046.GA201622@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809173449.20126-1-marek.vasut@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This would follow the convention for subject lines:

  PCI: OF: Add of_pci_get_dma_ranges() for inbound DMA restrictions

On Fri, Aug 09, 2019 at 07:34:48PM +0200, marek.vasut@gmail.com wrote:
> From: Oza Pawandeep <oza.oza@broadcom.com>
> 
> The patch exports interface to PCIe RC drivers so that,
> Drivers can get their inbound memory configuration.

IIUC this interface (of_pci_get_dma_ranges()) is not used directly by
*drivers*; it is used by of_bus_pci_get_dma_ranges() in the next
patch, and it's called by the driver core via this path:

  really_probe
    pci_dma_configure                     # pci_bus_type.dma_configure
      of_dma_configure
	of_dma_get_range
	  bus->get_dma_ranges
	    of_bus_pci_get_dma_ranges     # of_busses[0].get_dma_ranges
	      of_pci_get_dma_ranges

> It provides basis for IOVA reservations for inbound memory
> holes, if RC is not capable of addressing all the host memory,
> Specifically when IOMMU is enabled and on ARMv8 where 64bit IOVA
> could be allocated.
> 
> It handles multiple inbound windows, and returns resources,
> and is left to the caller, how it wants to use them.

This should say exactly what the problem is, maybe even with a link to
a problem report.  I assume it is something like "RC <X> cannot
address all of host memory, and if we happen to allocate a buffer
that's not addressable, DMA to the buffer fails".  It'd be nice to
know what the failure looks like (SERR# asserted, panic, reboot, etc).

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

Rewrap this so it uses the whole width (75-78 columns).

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

Capitalize as you do other comments (s/no/No/).

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

This isn't PCIe-specific, so it should say "PCI".

> +			  dn->full_name);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	while ((rlen -= np * 4) >= 0) {
> +		range.pci_space = be32_to_cpup((const __be32 *) &dma_ranges[0]);
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

I don't think this needs to be exported, does it?  The only caller I
see (of_bus_pci_get_dma_ranges()) cannot be in a module.

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
