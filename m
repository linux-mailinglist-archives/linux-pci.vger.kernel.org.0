Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADEB471F8
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2019 21:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfFOT5Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Jun 2019 15:57:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbfFOT5Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 15 Jun 2019 15:57:25 -0400
Received: from localhost (rrcs-162-155-246-179.central.biz.rr.com [162.155.246.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7385321852;
        Sat, 15 Jun 2019 19:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560628643;
        bh=BZ1bICQ2iXsbykz2ihls2tiXgBXufDwr9YnTHK7bScc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qQXEyQx7QUeHHmZYxiBdQM9UPBsnahrhBW5WuxXi1KL2bB3zs5uUQBsjoafvh2erl
         yJbegDU36N3H3XCUqoSVsgiDnecxZn0/VtMi1kwHgWGj4AwjVcxlAxJXE5mY7ke742
         yWqv3RMRAA2iQD5AxdbF9FjPxz6FwKIanSPq8Azo=
Date:   Sat, 15 Jun 2019 14:57:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH v6 2/4] PCI: Modify extend_bridge_window() to set
 resource size directly
Message-ID: <20190615195719.GY13533@google.com>
References: <20190522222928.2964-1-nicholas.johnson-opensource@outlook.com.au>
 <PS2P216MB0642044F9ECF48AD0183A98380000@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS2P216MB0642044F9ECF48AD0183A98380000@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 22, 2019 at 02:30:57PM +0000, Nicholas Johnson wrote:
> Background
> ==========================================================================
> 
> In the current state, the PCI allocation could fail with Thunderbolt
> under certain unusual circumstances, because add_list resources are
> "optional". Guaranteed allocation requires guaranteed resource sizes.

I don't see anything here specific to Thunderbolt, so this boils down
to "allocation might fail in unusual cases".  That's true, of course,
but in order to fix something we have to identify a failure that could
be avoided.

Part of the reason for "add_size" is for SR-IOV devices where we can
control the amount of space they require.  The PF space is mandatory,
but we can adjust the number of VFs and the space they use.

If we don't have enough space for all the possible VFs, we'd rather
allocate space for some of them than fail completely.

We can never guarantee that there's enough space for all devices, even
if we make all the possible VF space required instead of optional.

> It is difficult to give examples of these failures - because without the
> previous patch in the series, the symptoms of the problem are hidden by
> larger problems. This patch has been split from the previous patch and
> makes little sense on its own - as it is almost impossible to see the
> effect of this patch without first fixing the problems addressed by the
> previous patch. So the evidence I put forward for making this change is
> that because add_list resources are "optional", there could be any
> number of unforeseen bugs that are yet to be encountered if the kernel
> decides not to assign all of the optional size. In kernel development,
> we should not play around with chance.
> 
> Moving away from add_size also allows for use of pci=hpmemsize to assign
> resources. Previously, when using add_size and not allowing the add_size
> to shrink, it made it impossible to distribute resources. If a hotplug
> bridge has size X, and below it is some devices with non-zero size Y and
> a nested hotplug bridge of same size X, fitting X+Y into size X is
> mathematically impossible.
> 
> This patch solves this by dropping add_size and giving each bridge the
> maximum size possible without failing resource assignment. Using
> pci=hpmemsize still works as pci_assign_unassigned_root_bus_resources()
> does not call pci_bus_distribute_available_resources(). At boot,
> pci_assign_unassigned_root_bus_resources() is used, instead of
> pci_bridge_distribute_available_resources().
> 
> By allowing to use pci=hpmemsize, it removes the reliance on the
> firmware to declare the window resources under the root port, and could
> pay off in the future with USB4 (which is backward-compatible to
> Thunderbolt devices, and not specific to Intel systems). Users of
> Thunderbolt hardware on unsupported systems will be able to specify the
> resources in the kernel parameters. Users of official systems will be
> able to override the default firmware window sizes to allocate much
> larger resource sizes, potentially enabling Thunderbolt support for
> devices with massive BARs (with a few other problems solved by later
> patches in this series).
> 
> Patch notes
> ==========================================================================
> 
> Modify extend_bridge_window() to remove the resource from add_list and
> change the resource size directly.
> 
> Modify extend_bridge_window() to reset resources that are being assigned
> zero size. This is required to prevent the bridge not being enabled due
> to resources with zero size. This is a direct requirement to prevent the
> change away from using add_list from introducing a regression - because
> before, it was not possible to end up with zero size.
> 
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> ---
>  drivers/pci/setup-bus.c | 42 ++++++++++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 1b5b851ca..5675254fa 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1810,28 +1810,40 @@ void __init pci_assign_unassigned_resources(void)
>  }
>  
>  static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
> -				 struct list_head *add_list,
> -				 resource_size_t available)
> +			struct list_head *add_list, resource_size_t new_size)

Follow parameter indentation style of the rest of the file.  It's OK if it
requires another line.

>  {
> -	struct pci_dev_resource *dev_res;
> +	resource_size_t add_size;
>  
>  	if (res->parent)
>  		return;
>  
> -	if (resource_size(res) >= available)
> -		return;
> -
> -	dev_res = res_to_dev_res(add_list, res);
> -	if (!dev_res)
> -		return;
> +	if (new_size >= resource_size(res)) {
> +		add_size = new_size - resource_size(res);
> +		pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
> +			&add_size);
> +	} else {
> +		add_size = resource_size(res) - new_size;
> +		pci_dbg(bridge, "bridge window %pR shrunken by %pa\n", res,
> +			&add_size);
> +	}
>  
> -	/* Is there room to extend the window? */
> -	if (available - resource_size(res) <= dev_res->add_size)
> -		return;
> +	/*
> +	 * Resources requested using add_size in additional resource lists are
> +	 * considered optional when allocated. Guaranteed size of allocation
> +	 * is required to guarantee successful resource distribution. Hence,
> +	 * the size of the actual resource must be adjusted, and the resource
> +	 * removed from add_list to prevent any additional size interfering.
> +	 */
> +	res->end = res->start + new_size - 1;
> +	remove_from_list(add_list, res);
>  
> -	dev_res->add_size = available - resource_size(res);
> -	pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
> -		&dev_res->add_size);
> +	/*
> +	 * If we have run out of bridge resources, we may end up with a
> +	 * zero-sized resource which may cause its bridge to not be enabled.
> +	 * Disabling the resource prevents any such issues.

I don't understand the concern about the bridge not being enabled; can
you help me out?

When you refer to the bridge not being enabled, I'm guessing you mean
the bridge PCI_COMMAND_IO and PCI_COMMAND_MEMORY bits might not be
set?

"res" refers to a bridge window (io, mmio, or mmio_pref).  Bridge
windows can be individually disabled (by setting limit < base), and
that should not cause the bridge itself to be disabled.
reset_resource() itself doesn't touch the bridge base or limit
registers; is there something later that does?

I don't like reset_resource() because it throws away the flags that
tell us what sort of resource we have (I/O, MMIO, 64-bit).  The only
way to get that back is to re-read the device's config space.  I think
the goal should be to read that *once* during enumeration and keep it.
I know we already use reset_resource() elsewhere, but I'd rather not
add new uses if we can avoid it.

> +	if (!new_size)
> +		reset_resource(res);
>  }
>  
>  static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> -- 
> 2.20.1
> 
