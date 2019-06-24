Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 559565185A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 18:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732032AbfFXQVo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 12:21:44 -0400
Received: from ale.deltatee.com ([207.54.116.67]:37236 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732017AbfFXQVo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jun 2019 12:21:44 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hfRir-0007qh-AI; Mon, 24 Jun 2019 10:21:38 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20190622210310.180905-1-helgaas@kernel.org>
 <20190622210310.180905-2-helgaas@kernel.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1f4450c7-bf52-4818-fe5b-a66c49de31ad@deltatee.com>
Date:   Mon, 24 Jun 2019 10:21:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190622210310.180905-2-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: bhelgaas@google.com, linux-pci@vger.kernel.org, benh@kernel.crashing.org, nicholas.johnson-opensource@outlook.com.au, mika.westerberg@linux.intel.com, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 1/2] PCI: Simplify
 pci_bus_distribute_available_resources()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-06-22 3:03 p.m., Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Reorder pci_bus_distribute_available_resources() to group related code
> together.  No functional change intended.
> 
> Link: https://lore.kernel.org/r/PS2P216MB0642C7A485649D2D787A1C6F80000@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
> Based-on-patch-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> [bhelgaas: extracted from larger patch]
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Looks correct to me:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
> 
> The original order was:
> 
>   1) remaining_io = available_io
> 
>   2) for_each_pci_bridge(dev, bus)
>        # count hotplug_bridges, normal_bridges
> 
>   3) for_each_pci_bridge(dev, bus)
>        if (!dev->is_hotplug_bridge)
> 	 # reduce remaining_io by dev window
> 
>   4) if (hotplug_bridges + normal_bridges == 1)
>        # distribute available_io to the single bridge
>        # return
> 
>   5) for_each_pci_bridge(dev, bus)
>        # distribute remaining_io to hotplug bridges
> 
> Blocks 2 and 4 don't require remaining_io, so do them first.  Blocks 1, 3,
> 5 deal with remaining_io, so group them together.
> ---
>  drivers/pci/setup-bus.c | 50 ++++++++++++++++++++---------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 0cdd5ff389de..af28af898e42 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1860,16 +1860,6 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  	extend_bridge_window(bridge, mmio_pref_res, add_list,
>  			     available_mmio_pref);
>  
> -	/*
> -	 * Calculate the total amount of extra resource space we can
> -	 * pass to bridges below this one.  This is basically the
> -	 * extra space reduced by the minimal required space for the
> -	 * non-hotplug bridges.
> -	 */
> -	remaining_io = available_io;
> -	remaining_mmio = available_mmio;
> -	remaining_mmio_pref = available_mmio_pref;
> -
>  	/*
>  	 * Calculate how many hotplug bridges and normal bridges there
>  	 * are on this bus.  We will distribute the additional available
> @@ -1882,6 +1872,31 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  			normal_bridges++;
>  	}
>  
> +	/*
> +	 * There is only one bridge on the bus so it gets all available
> +	 * resources which it can then distribute to the possible hotplug
> +	 * bridges below.
> +	 */
> +	if (hotplug_bridges + normal_bridges == 1) {
> +		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> +		if (dev->subordinate) {
> +			pci_bus_distribute_available_resources(dev->subordinate,
> +				add_list, available_io, available_mmio,
> +				available_mmio_pref);
> +		}
> +		return;
> +	}
> +
> +	/*
> +	 * Calculate the total amount of extra resource space we can
> +	 * pass to bridges below this one.  This is basically the
> +	 * extra space reduced by the minimal required space for the
> +	 * non-hotplug bridges.
> +	 */
> +	remaining_io = available_io;
> +	remaining_mmio = available_mmio;
> +	remaining_mmio_pref = available_mmio_pref;
> +
>  	for_each_pci_bridge(dev, bus) {
>  		const struct resource *res;
>  
> @@ -1905,21 +1920,6 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  			remaining_mmio_pref -= resource_size(res);
>  	}
>  
> -	/*
> -	 * There is only one bridge on the bus so it gets all available
> -	 * resources which it can then distribute to the possible hotplug
> -	 * bridges below.
> -	 */
> -	if (hotplug_bridges + normal_bridges == 1) {
> -		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> -		if (dev->subordinate) {
> -			pci_bus_distribute_available_resources(dev->subordinate,
> -				add_list, available_io, available_mmio,
> -				available_mmio_pref);
> -		}
> -		return;
> -	}
> -
>  	/*
>  	 * Go over devices on this bus and distribute the remaining
>  	 * resource space between hotplug bridges.
> 
