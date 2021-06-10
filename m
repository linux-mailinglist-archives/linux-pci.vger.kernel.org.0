Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80593A36D1
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 00:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhFJWHk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 18:07:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhFJWHk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jun 2021 18:07:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38D0F613F1;
        Thu, 10 Jun 2021 22:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623362743;
        bh=1RMKsOthF8nmbzYW+O/oUW/rwdCTpBe6yg9JLjyQ8T0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lr3lkVZ4BUJbcw5jiV8LlIxBUMD1m04SiDmDqiomWiEHFD2c4VWO1wFnmqkkNJ8d5
         465rSgbip64DmlIbTLOi8tIk4N37KmWE7AQnhCYSwSlw9iQ/8aa/3ipt5Kzlq37QoX
         Km3f6pmLIfNqJcITrS5u4x0GNQmGN/UhaKFmT9aHW7UOGfjC0QVSYiB02ft+CKJfeH
         YcP9HWVXSEwvJTaCUrAZJFSagvjcdNhTHfT2j6qIHzX5Vu6Hit56QWZjs225kb5MmF
         GJMLOihlIOnFsZG3kKKSK1h2AEH6Paths5CjWCIKOX+DSX8/dyLITPXPOniFHExVod
         Equc5kSo0NJmQ==
Date:   Thu, 10 Jun 2021 17:05:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>
Subject: Re: [PATCH v1 1/6] PCI/P2PDMA: Rename upstream_bridge_distance() and
 rework documentation
Message-ID: <20210610220541.GA2779926@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610160609.28447-2-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 10, 2021 at 10:06:04AM -0600, Logan Gunthorpe wrote:
> The function upstream_bridge_distance() has evolved such that it's name
> is no longer entirely reflective of what the function does.
> 
> The function not only calculates the distance between two peers but also
> calculates how the DMA addresses for those two peers should be mapped.
> 
> Thus, rename the function to calc_map_type_and_dist() and rework the
> documentation to better describe the two pieces of information the
> function returns.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/p2pdma.c | 63 ++++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 196382630363..6f90e9812f6e 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -354,7 +354,7 @@ static bool host_bridge_whitelist(struct pci_dev *a, struct pci_dev *b)
>  }
>  
>  static enum pci_p2pdma_map_type
> -__upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
> +__calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
>  		int *dist, bool *acs_redirects, struct seq_buf *acs_list)
>  {
>  	struct pci_dev *a = provider, *b = client, *bb;
> @@ -433,17 +433,18 @@ static unsigned long map_types_idx(struct pci_dev *client)
>  }
>  
>  /*
> - * Find the distance through the nearest common upstream bridge between
> - * two PCI devices.
> + * Calculate the P2PDMA mapping type and distance between two PCI devices.
>   *
> - * If the two devices are the same device then 0 will be returned.
> + * If the two devices are the same device then PCI_P2PDMA_MAP_BUS_ADDR
> + * and a distance of 0 will be returned.
>   *
>   * If there are two virtual functions of the same device behind the same
> - * bridge port then 2 will be returned (one step down to the PCIe switch,
> - * then one step back to the same device).
> + * bridge port then PCI_P2PDMA_MAP_BUS_ADDR and a distance of 2 will be
> + * returned (one step down to the PCIe switch, then one step back to the
> + * same device).

The new text is:

  If there are two virtual functions of the same device behind the same
  bridge port then PCI_P2PDMA_MAP_BUS_ADDR and a distance of 2 will be
  returned (one step down to the PCIe switch, then one step back to the
  same device).

I *think* this includes two functions of the same multi-function
device, or two virtual functions of the same device, right?  In both
cases, the two devices are obviously behind the same bridge port.

Is this usage of "down to the PCIe switch" the common usage in P2PDMA?
I normally think of going from an endpoint to a switch as being "up"
toward the CPU.  But PCIe made it all confusing by putting downstream
ports at the upstream end of links and vice versa.

We also have a bit of a mix in terminology between "bridge," "switch,"
"bridge port."  I'd probably write something like:

  If they are two functions of the same device behind the same bridge,
  return PCI_P2PDMA_MAP_BUS_ADDR and a distance of 2 (one hop up to
  the bridge, then one hop back down to another function of the same
  device).

No need to repost for this; just let me know what you think and I can
tweak accordingly.

Bjorn
