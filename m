Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6B7A47E8C
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 11:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfFQJfS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 05:35:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:14033 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfFQJfS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jun 2019 05:35:18 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 02:35:17 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 17 Jun 2019 02:35:14 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 17 Jun 2019 12:35:13 +0300
Date:   Mon, 17 Jun 2019 12:35:13 +0300
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH v6 1/4] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Message-ID: <20190617093513.GN2640@lahna.fi.intel.com>
References: <20190522222928.2964-1-nicholas.johnson-opensource@outlook.com.au>
 <PS2P216MB0642C7A485649D2D787A1C6F80000@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS2P216MB0642C7A485649D2D787A1C6F80000@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 22, 2019 at 02:30:44PM +0000, Nicholas Johnson wrote:
> Rewrite pci_bus_distribute_available_resources to better handle bridges
> with different resource alignment requirements. Pass more details
> arguments recursively to track the resource start and end addresses
> relative to the initial hotplug bridge. This is especially useful for
> Thunderbolt with native PCI enumeration, enabling external graphics
> cards and other devices with bridge alignment higher than 0x100000
 
Instead of 0x100000 you could say 1MB here.

> bytes.
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
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>

The logic makes sense to me but since you probably need to spin another
revision anyway please find a couple of additional comments below.

> ---
>  drivers/pci/setup-bus.c | 169 ++++++++++++++++++++--------------------
>  1 file changed, 84 insertions(+), 85 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 0cdd5ff38..1b5b851ca 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1835,12 +1835,10 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
>  }
>  
>  static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> -					    struct list_head *add_list,
> -					    resource_size_t available_io,
> -					    resource_size_t available_mmio,
> -					    resource_size_t available_mmio_pref)
> +	struct list_head *add_list, struct resource io,
> +	struct resource mmio, struct resource mmio_pref)
>  {
> -	resource_size_t remaining_io, remaining_mmio, remaining_mmio_pref;
> +	resource_size_t io_per_hp, mmio_per_hp, mmio_pref_per_hp, align;
>  	unsigned int normal_bridges = 0, hotplug_bridges = 0;
>  	struct resource *io_res, *mmio_res, *mmio_pref_res;
>  	struct pci_dev *dev, *bridge = bus->self;
> @@ -1850,29 +1848,36 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  	mmio_pref_res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
>  
>  	/*
> -	 * Update additional resource list (add_list) to fill all the
> -	 * extra resource space available for this port except the space
> -	 * calculated in __pci_bus_size_bridges() which covers all the
> -	 * devices currently connected to the port and below.
> +	 * The alignment of this bridge is yet to be considered, hence it must
> +	 * be done now before extending its bridge window. A single bridge
> +	 * might not be able to occupy the whole parent region if the alignment
> +	 * differs - for example, an external GPU at the end of a Thunderbolt
> +	 * daisy chain.

As Bjorn also commented there is nothing Thunderbolt specific here so I
would leave it out of the comment because it is kind of confusing.

>  	 */
> -	extend_bridge_window(bridge, io_res, add_list, available_io);
> -	extend_bridge_window(bridge, mmio_res, add_list, available_mmio);
> -	extend_bridge_window(bridge, mmio_pref_res, add_list,
> -			     available_mmio_pref);
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
>  
>  	/*
> -	 * Calculate the total amount of extra resource space we can
> -	 * pass to bridges below this one.  This is basically the
> -	 * extra space reduced by the minimal required space for the
> -	 * non-hotplug bridges.
> +	 * Update the resources to fill as much remaining resource space in the
> +	 * parent bridge as possible, while considering alignment.
>  	 */
> -	remaining_io = available_io;
> -	remaining_mmio = available_mmio;
> -	remaining_mmio_pref = available_mmio_pref;
> +	extend_bridge_window(bridge, io_res, add_list, resource_size(&io));
> +	extend_bridge_window(bridge, mmio_res, add_list, resource_size(&mmio));
> +	extend_bridge_window(bridge, mmio_pref_res, add_list,
> +		resource_size(&mmio_pref));

Please write it like it was originally (e.g align the second line to the
opening bracket):

	extend_bridge_window(bridge, mmio_pref_res, add_list,
			     resource_size(&mmio_pref));

>  
>  	/*
>  	 * Calculate how many hotplug bridges and normal bridges there
> -	 * are on this bus.  We will distribute the additional available
> +	 * are on this bus. We will distribute the additional available
>  	 * resources between hotplug bridges.
>  	 */
>  	for_each_pci_bridge(dev, bus) {
> @@ -1882,104 +1887,98 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  			normal_bridges++;
>  	}
>  
> +	/*
> +	 * There is only one bridge on the bus so it gets all possible
> +	 * resources which it can then distribute to the possible
> +	 * hotplug bridges below.
> +	 */
> +	if (hotplug_bridges + normal_bridges == 1) {
> +		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> +		if (dev->subordinate)
> +			pci_bus_distribute_available_resources(dev->subordinate,
> +				add_list, io, mmio, mmio_pref);
> +		return;
> +	}
> +
> +	/*
> +	 * Reduce the available resource space by what the
> +	 * bridge and devices below it occupy.
> +	 */
>  	for_each_pci_bridge(dev, bus) {
> -		const struct resource *res;
> +		struct resource *res;
> +		resource_size_t used_size;

Here order these in "reverse christmas tree" like:

		resource_size_t used_size;
		struct resource *res;

>  
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
> +	if (!hotplug_bridges)
>  		return;
> -	}
>  
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

Here also write it like:

	mmio_pref_per_hp = div64_ul(resource_size(&mmio_pref),
				    hotplug_bridges);

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
> -		 *
> -		 * Here hotplug_bridges is always != 0.
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

Ditto.

>  
> -		pci_bus_distribute_available_resources(b, add_list, io, mmio,
> -						       mmio_pref);
> +		io.start = io.end + 1;
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
> +	struct resource io_res, mmio_res, mmio_pref_res;
>  
>  	if (!bridge->is_hotplug_bridge)
>  		return;
>  
> +	io_res = bridge->resource[PCI_BRIDGE_RESOURCES + 0];
> +	mmio_res = bridge->resource[PCI_BRIDGE_RESOURCES + 1];
> +	mmio_pref_res = bridge->resource[PCI_BRIDGE_RESOURCES + 2];
> +
>  	/* Take the initial extra resources from the hotplug port */
> -	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 0];
> -	available_io = resource_size(res);
> -	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 1];
> -	available_mmio = resource_size(res);
> -	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
> -	available_mmio_pref = resource_size(res);
>  
>  	pci_bus_distribute_available_resources(bridge->subordinate,
> -					       add_list, available_io,
> -					       available_mmio,
> -					       available_mmio_pref);
> +		add_list, io_res, mmio_res, mmio_pref_res);
>  }
>  
>  void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
> -- 
> 2.20.1
> 
