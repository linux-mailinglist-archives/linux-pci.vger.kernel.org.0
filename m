Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4B33398C2
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 21:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbhCLU5d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 15:57:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:39858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235131AbhCLU5J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Mar 2021 15:57:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C09564F87;
        Fri, 12 Mar 2021 20:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615582629;
        bh=mkL75zFRcvY7SDVV8rIsNBThP6Ch2Zj5Sc2UsAwvmCY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kKZvn2V5xv7vpfX93Th5HlKcyhtTFfyTOdhE+m5fKiVxM27wSYf500/9OadIahsw+
         oEGYQIHa1AwIK5CClP76fHluAH6DgvHGmwD1Kea5H0lGK94aaa2xCgbL6GQHBkCRBy
         fVCGSAVP/trm3ZEI5cH7YCoGdMP86GqMr+tM1r6Q+i+i6nEhMLbeEbyGFsvblGKgXb
         xQ672JWkV5EhfxHIkbYo60ElXUtpihbb1u6Rtm7tTANTg6lC/odVOR3a1b0iFOziBY
         eq9ls4SRmtP/ZzQ/Cqg3h/hLa//KTnib5Y9jqx7r0b4zd9zW8JIrje6QXqM4nEM/hW
         3rwqhKzBPmI7A==
Date:   Fri, 12 Mar 2021 14:57:07 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>
Subject: Re: [RFC PATCH v2 02/11] PCI/P2PDMA: Avoid pci_get_slot() which
 sleeps
Message-ID: <20210312205707.GA2288658@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311233142.7900-3-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 11, 2021 at 04:31:32PM -0700, Logan Gunthorpe wrote:
> In order to use upstream_bridge_distance_warn() from a dma_map function,
> it must not sleep. However, pci_get_slot() takes the pci_bus_sem so it
> might sleep.
> 
> In order to avoid this, try to get the host bridge's device from
> bus->self, and if that is not set just get the first element in the
> list. It should be impossible for the host bridges device to go away
> while references are held on child devices, so the first element
> should not change and this should be safe.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/p2pdma.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index bd89437faf06..2135fe69bb07 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -311,11 +311,15 @@ static const struct pci_p2pdma_whitelist_entry {
>  static bool __host_bridge_whitelist(struct pci_host_bridge *host,
>  				    bool same_host_bridge)
>  {
> -	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
>  	const struct pci_p2pdma_whitelist_entry *entry;
> +	struct pci_dev *root = host->bus->self;
>  	unsigned short vendor, device;
>  
>  	if (!root)
> +		root = list_first_entry_or_null(&host->bus->devices,
> +						struct pci_dev, bus_list);

Replacing one ugliness (assuming there is a pci_dev for the host
bridge, and that it is at 00.0) with another (still assuming a pci_dev
and that it is host->bus->self or the first entry).  I can't suggest
anything better, but maybe a little comment in the code would help
future readers.

I wish we had a real way to discover this property without the
whitelist, at least for future devices.  Was there ever any interest
in a _DSM or similar interface for this?

I *am* very glad to remove a pci_get_slot() usage.

> +
> +	if (!root || root->devfn)
>  		return false;
>  
>  	vendor = root->vendor;

Don't you need to also remove the "pci_dev_put(root)" a few lines
below?
