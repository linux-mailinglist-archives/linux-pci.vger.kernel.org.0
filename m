Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05B72131946
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 21:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgAFUXE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 15:23:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:45198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgAFUXD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 15:23:03 -0500
Received: from localhost (unknown [64.237.17.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96A1B2072C;
        Mon,  6 Jan 2020 20:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578342182;
        bh=25PZJ3bxW9cvFKLoe04UEz+DJIDuK6tnzw3H5UoY7J4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YiVVfvruwwv191AVb8asnyueIBs27wbbAGsxJY8Gr/pHeMFRlGl5wBlofVTEPkhid
         orw+IpGondGfQoZbCnKI+KTIM35+5RgjuhF79WueafuY6uscQp7TnZFae5aiQ4clW8
         po7qZHCt56ZzjgjUoVlm6f7VbjOFLcEc4utbKaw8=
Date:   Mon, 6 Jan 2020 14:23:01 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v1 3/4] PCI: Change extend_bridge_window() to set
 resource size directly
Message-ID: <20200106202301.GA137556@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB04386BA48874B56BC5CB0292803C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks a lot for splitting these up.  It makes these dramatically
easier to read.

On Mon, Jan 06, 2020 at 03:47:46PM +0000, Nicholas Johnson wrote:
> Change extend_bridge_window() to set resource size directly instead of
> using additional resource lists.
> 
> Because additional resource lists are optional resources, any algorithm
> that requires guaranteed allocation that uses them cannot be guaranteed
> to work.

There is never a guarantee that PCI resource assignment will work.
It's always possible that we don't have enough resources to allow us
to enable a device.  So I'm not sure what this is telling me, and it
doesn't seem like a justification for setting the resource size
directly here.

Prior to this patch, I think all the assignment and changes to
dev->resource[] were in __assign_resources_sorted().  Maybe it's safe
to do some here and some in __assign_resources_sorted(), but I don't
understand it well enough to be confident.

> Remove the resource from add_list, as a zero-sized additional resource
> is redundant.
> 
> Update comment in pci_bus_distribute_available_resources() to reflect
> the above changes.
> 
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> ---
>  drivers/pci/setup-bus.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index de43815be..0c51f4937 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1836,7 +1836,7 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
>  				 struct list_head *add_list,
>  				 resource_size_t new_size)
>  {
> -	struct pci_dev_resource *dev_res;
> +	resource_size_t add_size;
>  
>  	if (res->parent)
>  		return;
> @@ -1844,17 +1844,10 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
>  	if (resource_size(res) >= new_size)
>  		return;
>  
> -	dev_res = res_to_dev_res(add_list, res);
> -	if (!dev_res)
> -		return;
> -
> -	/* Is there room to extend the window? */
> -	if (new_size - resource_size(res) <= dev_res->add_size)
> -		return;
> -
> -	dev_res->add_size = new_size - resource_size(res);
> -	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
> -		&dev_res->add_size);
> +	add_size = new_size - resource_size(res);
> +	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res, &add_size);
> +	res->end = res->start + new_size - 1;

How do we know it's safe to extend this, i.e., how do we know there's
nothing immediately after res?

> +	remove_from_list(add_list, res);
>  }
>  
>  static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> @@ -1889,11 +1882,9 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  		mmio_pref.start = min(ALIGN(mmio_pref.start, align),
>  			mmio_pref.end + 1);
>  
> -	/*
> -	 * Update additional resource list (add_list) to fill all the
> -	 * extra resource space available for this port except the space
> -	 * calculated in __pci_bus_size_bridges() which covers all the
> -	 * devices currently connected to the port and below.
> +        /*
> +	 * Now that we have adjusted for alignment, update the bridge window
> +	 * resources to fill as much remaining resource space as possible.
>  	 */
>  	adjust_bridge_window(bridge, io_res, add_list, resource_size(&io));
>  	adjust_bridge_window(bridge, mmio_res, add_list, resource_size(&mmio));
> -- 
> 2.24.1
> 
