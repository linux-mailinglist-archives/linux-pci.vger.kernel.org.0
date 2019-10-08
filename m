Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07D24CF89F
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 13:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbfJHLiR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Oct 2019 07:38:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:23661 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730156AbfJHLiR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Oct 2019 07:38:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 04:38:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="206620992"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 08 Oct 2019 04:38:13 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 08 Oct 2019 14:38:12 +0300
Date:   Tue, 8 Oct 2019 14:38:12 +0300
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v8 1/6] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Message-ID: <20191008113812.GF2819@lahna.fi.intel.com>
References: <SL2P216MB01871E87E3A760E3AA87E27380C00@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB01871E87E3A760E3AA87E27380C00@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nicholas,

On Fri, Jul 26, 2019 at 12:53:19PM +0000, Nicholas Johnson wrote:
> Rewrite pci_bus_distribute_available_resources to better handle bridges
> with different resource alignment requirements. Pass more details
> arguments recursively to track the resource start and end addresses
> relative to the initial hotplug bridge. This is especially useful for
> Thunderbolt with native PCI enumeration, enabling external graphics
> cards and other devices with bridge alignment higher than 1MB.
> 
> Change extend_bridge_window to resize the actual resource, rather than
> using add_list and dev_res->add_size. If an additional resource entry
> exists for the given resource, zero out the add_size field to avoid it
> interfering. Because add_size is considered optional when allocating,
> using add_size could cause issues in some cases, because successful
> resource distribution requires sizes to be guaranteed. Such cases
> include hot-adding nested hotplug bridges in one enumeration, and
> potentially others which are yet to be encountered.
> 
> Solves bug report: https://bugzilla.kernel.org/show_bug.cgi?id=199581

Here better to use:

Link: https://bugzilla.kernel.org/show_bug.cgi?id=199581

> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>

This solves the issue I reported so,

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

There are a couple of comments below.

> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> ---
>  drivers/pci/setup-bus.c | 148 +++++++++++++++++++---------------------
>  1 file changed, 71 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 79b1fa651..6835fd64c 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1840,12 +1840,10 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
>  }
>  
>  static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> -					    struct list_head *add_list,
> -					    resource_size_t available_io,
> -					    resource_size_t available_mmio,
> -					    resource_size_t available_mmio_pref)
> +	struct list_head *add_list, struct resource io,
> +	struct resource mmio, struct resource mmio_pref)

You pass a copy of each resource because you modify it inplace. I wonder
if it makes more sense to explicitly take a copy here with comments?

>  {
> -	resource_size_t remaining_io, remaining_mmio, remaining_mmio_pref;
> +	resource_size_t io_per_hp, mmio_per_hp, mmio_pref_per_hp, align;
>  	unsigned int normal_bridges = 0, hotplug_bridges = 0;
>  	struct resource *io_res, *mmio_res, *mmio_pref_res;
>  	struct pci_dev *dev, *bridge = bus->self;
> @@ -1855,15 +1853,29 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  	mmio_pref_res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
>  
>  	/*
> -	 * Update additional resource list (add_list) to fill all the
> -	 * extra resource space available for this port except the space
> -	 * calculated in __pci_bus_size_bridges() which covers all the
> -	 * devices currently connected to the port and below.
> +	 * The alignment of this bridge is yet to be considered, hence it must
> +	 * be done now before extending its bridge window.
>  	 */
> -	extend_bridge_window(bridge, io_res, add_list, available_io);
> -	extend_bridge_window(bridge, mmio_res, add_list, available_mmio);
> +	align = pci_resource_alignment(bridge, io_res);
> +	if (!io_res->parent && align)
> +		io.start = ALIGN(io.start, align);
> +
> +	align = pci_resource_alignment(bridge, mmio_res);
> +	if (!mmio_res->parent && align)
> +		mmio.start = ALIGN(mmio.start, align);
> +
> +	align = pci_resource_alignment(bridge, mmio_pref_res);
> +	if (!mmio_pref_res->parent && align)
> +		mmio_pref.start = ALIGN(mmio_pref.start, align);
> +
> +	/*
> +	 * Update the resources to fill as much remaining resource space in the
> +	 * parent bridge as possible, while considering alignment.
> +	 */
> +	extend_bridge_window(bridge, io_res, add_list, resource_size(&io));
> +	extend_bridge_window(bridge, mmio_res, add_list, resource_size(&mmio));
>  	extend_bridge_window(bridge, mmio_pref_res, add_list,
> -			     available_mmio_pref);
> +		resource_size(&mmio_pref));

I think this should be aligned like:

 	extend_bridge_window(bridge, mmio_pref_res, add_list,
			     resource_size(&mmio_pref));


>  
>  	/*
>  	 * Calculate how many hotplug bridges and normal bridges there
> @@ -1884,108 +1896,90 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  	 */
>  	if (hotplug_bridges + normal_bridges == 1) {
>  		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> -		if (dev->subordinate) {
> +		if (dev->subordinate)
>  			pci_bus_distribute_available_resources(dev->subordinate,
> -				add_list, available_io, available_mmio,
> -				available_mmio_pref);
> -		}
> +				add_list, io, mmio, mmio_pref);
>  		return;
>  	}
>  
> -	if (hotplug_bridges == 0)
> -		return;
> -
>  	/*
> -	 * Calculate the total amount of extra resource space we can
> -	 * pass to bridges below this one.  This is basically the
> -	 * extra space reduced by the minimal required space for the
> -	 * non-hotplug bridges.
> +	 * Reduce the available resource space by what the
> +	 * bridge and devices below it occupy.

This can be widen:


	/*
	 * Reduce the available resource space by what the bridge and
	 * devices below it occupy.
	 */


>  	 */
> -	remaining_io = available_io;
> -	remaining_mmio = available_mmio;
> -	remaining_mmio_pref = available_mmio_pref;
> -
>  	for_each_pci_bridge(dev, bus) {
> -		const struct resource *res;
> +		struct resource *res;
> +		resource_size_t used_size;

Some people like "reverse christmas tree" format better:

		resource_size_t used_size;
		struct resource *res;

Can it be const, BTW?

>  		if (dev->is_hotplug_bridge)
>  			continue;
>  
> -		/*
> -		 * Reduce the available resource space by what the
> -		 * bridge and devices below it occupy.
> -		 */
>  		res = &dev->resource[PCI_BRIDGE_RESOURCES + 0];
> -		if (!res->parent && available_io > resource_size(res))
> -			remaining_io -= resource_size(res);
> +		align = pci_resource_alignment(dev, res);
> +		align = align ? ALIGN(io.start, align) - io.start : 0;
> +		used_size = align + resource_size(res);
> +		if (!res->parent && used_size <= resource_size(&io))
> +			io.start += used_size;
>  
>  		res = &dev->resource[PCI_BRIDGE_RESOURCES + 1];
> -		if (!res->parent && available_mmio > resource_size(res))
> -			remaining_mmio -= resource_size(res);
> +		align = pci_resource_alignment(dev, res);
> +		align = align ? ALIGN(mmio.start, align) - mmio.start : 0;
> +		used_size = align + resource_size(res);
> +		if (!res->parent && used_size <= resource_size(&mmio))
> +			mmio.start += used_size;
>  
>  		res = &dev->resource[PCI_BRIDGE_RESOURCES + 2];
> -		if (!res->parent && available_mmio_pref > resource_size(res))
> -			remaining_mmio_pref -= resource_size(res);
> +		align = pci_resource_alignment(dev, res);
> +		align = align ? ALIGN(mmio_pref.start, align) -
> +				mmio_pref.start : 0;
> +		used_size = align + resource_size(res);
> +		if (!res->parent && used_size <= resource_size(&mmio_pref))
> +			mmio_pref.start += used_size;
>  	}
>  
> +	if (!hotplug_bridges)
> +		return;
> +
>  	/*
> -	 * Go over devices on this bus and distribute the remaining
> -	 * resource space between hotplug bridges.
> +	 * Distribute any remaining resources equally between
> +	 * the hotplug-capable downstream ports.
>  	 */
> -	for_each_pci_bridge(dev, bus) {
> -		resource_size_t align, io, mmio, mmio_pref;
> -		struct pci_bus *b;
> +	io_per_hp = div64_ul(resource_size(&io), hotplug_bridges);
> +	mmio_per_hp = div64_ul(resource_size(&mmio), hotplug_bridges);
> +	mmio_pref_per_hp = div64_ul(resource_size(&mmio_pref),
> +		hotplug_bridges);
>  
> -		b = dev->subordinate;
> -		if (!b || !dev->is_hotplug_bridge)
> +	for_each_pci_bridge(dev, bus) {
> +		if (!dev->subordinate || !dev->is_hotplug_bridge)
>  			continue;
>  
> -		/*
> -		 * Distribute available extra resources equally between
> -		 * hotplug-capable downstream ports taking alignment into
> -		 * account.
> -		 */
> -		align = pci_resource_alignment(bridge, io_res);
> -		io = div64_ul(available_io, hotplug_bridges);
> -		io = min(ALIGN(io, align), remaining_io);
> -		remaining_io -= io;
> -
> -		align = pci_resource_alignment(bridge, mmio_res);
> -		mmio = div64_ul(available_mmio, hotplug_bridges);
> -		mmio = min(ALIGN(mmio, align), remaining_mmio);
> -		remaining_mmio -= mmio;
> +		io.end = io.start + io_per_hp - 1;
> +		mmio.end = mmio.start + mmio_per_hp - 1;
> +		mmio_pref.end = mmio_pref.start + mmio_pref_per_hp - 1;
>  
> -		align = pci_resource_alignment(bridge, mmio_pref_res);
> -		mmio_pref = div64_ul(available_mmio_pref, hotplug_bridges);
> -		mmio_pref = min(ALIGN(mmio_pref, align), remaining_mmio_pref);
> -		remaining_mmio_pref -= mmio_pref;
> +		pci_bus_distribute_available_resources(dev->subordinate,
> +			add_list, io, mmio, mmio_pref);
>  
> -		pci_bus_distribute_available_resources(b, add_list, io, mmio,
> -						       mmio_pref);
> +		io.start = io.end + 1;

I think you can also write it like:

		io.start += io_per_hp;

> +		mmio.start = mmio.end + 1;
> +		mmio_pref.start = mmio_pref.end + 1;
>  	}
>  }
>  
>  static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
>  						     struct list_head *add_list)
>  {
> -	resource_size_t available_io, available_mmio, available_mmio_pref;
> -	const struct resource *res;
> +	struct resource io, mmio, mmio_pref;
>  
>  	if (!bridge->is_hotplug_bridge)
>  		return;
>  
>  	/* Take the initial extra resources from the hotplug port */
> -	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 0];
> -	available_io = resource_size(res);
> -	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 1];
> -	available_mmio = resource_size(res);
> -	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
> -	available_mmio_pref = resource_size(res);
> +	io = bridge->resource[PCI_BRIDGE_RESOURCES + 0];
> +	mmio = bridge->resource[PCI_BRIDGE_RESOURCES + 1];
> +	mmio_pref = bridge->resource[PCI_BRIDGE_RESOURCES + 2];
>  
> -	pci_bus_distribute_available_resources(bridge->subordinate,
> -					       add_list, available_io,
> -					       available_mmio,
> -					       available_mmio_pref);
> +	pci_bus_distribute_available_resources(bridge->subordinate, add_list,
> +					       io, mmio, mmio_pref);
>  }
>  
>  void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
> -- 
> 2.22.0
