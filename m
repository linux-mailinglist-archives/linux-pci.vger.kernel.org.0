Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 041464BF14
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 18:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfFSQzg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 12:55:36 -0400
Received: from ale.deltatee.com ([207.54.116.67]:33136 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfFSQzf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 12:55:35 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hddrx-00016M-BU; Wed, 19 Jun 2019 10:55:34 -0600
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>
References: <SL2P216MB01871948CB8CF39E354A2BCD80E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
From:   Logan Gunthorpe <logang@deltatee.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Message-ID: <15a6bb08-06ad-760d-5390-f37a72d7cbbc@deltatee.com>
Date:   Wed, 19 Jun 2019 10:55:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <SL2P216MB01871948CB8CF39E354A2BCD80E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: helgaas@kernel.org, linux-pci@vger.kernel.org, benh@kernel.crashing.org, nicholas.johnson-opensource@outlook.com.au
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [nicholas.johnson-opensource@outlook.com.au: [PATCH v6 2/4] PCI:
 Modify extend_bridge_window() to set resource size directly]
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-06-19 8:00 a.m., Nicholas Johnson wrote:
> Hi Ben and Logan,
> 
> It looks like my git send-email has been not working correctly since I
> started trying to get these patches accepted. I may have remedied this
> now, but I have seen that Logan tried to find these patches and failed.
> So as a courtesy until I post PATCH v7 (hopefully correctly, this time),
> I am forwarding you the patches. I hope you like them. I would love to 
> know of any concerns or questions you may have, and / or what happens if 
> you test them. Thanks and all the best!
> 
> ----- Forwarded message from Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au> -----
> 
> Date: Thu, 23 May 2019 06:29:26 +0800
> From: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> To: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, mika.westerberg@linux.intel.com, corbet@lwn.net, Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> Subject: [PATCH v6 2/4] PCI: Modify extend_bridge_window() to set resource size directly
> X-Mailer: git-send-email 2.19.1
> 
> Background
> ==========================================================================
> 
> In the current state, the PCI allocation could fail with Thunderbolt
> under certain unusual circumstances, because add_list resources are
> "optional". Guaranteed allocation requires guaranteed resource sizes.
> 
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

I'm having a hard time following the changes in the first two patches.

But it kind of seems like the semantics of extend_bridge_window()
changed in the first patch and that these two patches are interdependent??

Perhaps you need to consider splitting these changes up a bit
differently so that there's easy to follow reorganizations (like passing
struct resource instead of resource_size_t in
pci_bus_distribute_available_resources()) followed by changes in
functionality.

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

Best I can see dev_res->add_size is not set anywhere else so if you're
removing it you probably need to clean up a bunch of other stuff...

> +	/*
> +	 * If we have run out of bridge resources, we may end up with a
> +	 * zero-sized resource which may cause its bridge to not be enabled.
> +	 * Disabling the resource prevents any such issues.
> +	 */
> +	if (!new_size)
> +		reset_resource(res);
>  }
>  
>  static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> 
