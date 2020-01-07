Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F08413309C
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2020 21:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgAGUei (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jan 2020 15:34:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:33316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgAGUei (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Jan 2020 15:34:38 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A04120848;
        Tue,  7 Jan 2020 20:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578429277;
        bh=rOBrRkww+dpxH19H//3TaUngMuYnO8yIMvcGn9rynD4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fAu2DDQ7WnHNfP5nv3mkFSN/d3MANIITxeySpJ+jBihRLhQzCZould8MkfzvrfoiC
         wJoczFeEHm1Lz9Z7GMXvNZP5p3nk2+ECwyaG3trUJTCI3yrL2e9pjZBDrHh/xF+Bp8
         mnMvqrFtP9X4GNx/vHT19MlQL8ggaxa/rKAWpyK8=
Date:   Tue, 7 Jan 2020 14:34:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v1 4/4] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Message-ID: <20200107203435.GA137091@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB0438D3E2CFE64EBAA32AF691803C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 06, 2020 at 03:48:06PM +0000, Nicholas Johnson wrote:
> Remove checks for resource size in extend_bridge_window(). This is
> necessary to allow the pci_bus_distribute_available_resources() to
> function when the kernel parameter pci=hpmemsize=nn[KMG] is used to
> allocate resources. Because the kernel parameter sets the size of all
> hotplug bridges to be the same, there are problems when nested hotplug
> bridges are encountered. Fitting a downstream hotplug bridge with size X
> and normal bridges with non-zero size Y into parent hotplug bridge with
> size X is impossible, and hence the downstream hotplug bridge needs to
> shrink to fit into its parent.

s/extend_bridge_window()/adjust_bridge_window()/ above
s/to allow the/to allow/

If this patch allows pci_bus_distribute_available_resources() to
function when pci=hpmemsize=nn is used, what happens *before* this
patch?  The text implies that pci_bus_distribute_available_resources()
doesn't function, but what happens?  Do we try to assign a downstream
bridge requiring X+n inside an upstream window of size X and the
assignment fails, leaving the downstream bridge unusable?

> Add check for if bridge is extended or shrunken and reflect that in the
> call to pci_dbg().
> 
> Reset the resource if its new size is zero (if we have run out of a
> bridge window resource) to prevent the PCI resource assignment code from
> attempting to assign a zero-sized resource.
> 
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> ---
>  drivers/pci/setup-bus.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 0c51f4937..e7e57bf72 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1836,18 +1836,25 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
>  				 struct list_head *add_list,
>  				 resource_size_t new_size)
>  {
> -	resource_size_t add_size;
> +	resource_size_t add_size, size = resource_size(res);
>  
>  	if (res->parent)
>  		return;
>  
> -	if (resource_size(res) >= new_size)
> -		return;
> +	if (new_size > size) {
> +		add_size = new_size - size;
> +		pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
> +			&add_size);
> +	} else if (new_size < size) {
> +		add_size = size - new_size;
> +		pci_dbg(bridge, "bridge window %pR shrunken by %pa\n", res,
> +			&add_size);
> +	}

Where's the patch that changes the caller so "new_size" may be smaller
than "size"?  I guess it must be "[3/3] PCI: Consider alignment of
hot-added bridges ..." because that's the only one that makes a
non-trivial change, right?

> -	add_size = new_size - resource_size(res);
> -	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res, &add_size);
>  	res->end = res->start + new_size - 1;
>  	remove_from_list(add_list, res);
> +	if (!new_size)
> +		reset_resource(res);

I consider reset_resource() to be deprecated because it throws away
res->flags, which tells us what kind of resource it is
(mem/io/32-bit/64-bit/prefetchable).  We learn this during
enumeration, and we shouldn't forget the information until we remove
the device.

If the resource assignment code doesn't do the right thing with a
zero-sized resource, I think we should fix that code.  Clearing the
resource struct does nothing with the hardware BAR or window
registers, so the BAR/window remains enabled unless we do something
more.  If we don't need a window and we want to disable it, we can do
that, but it requires writing special values to the hardware
registers.

Bjorn
