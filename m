Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7382E419E9B
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 20:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbhI0SwS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 14:52:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236296AbhI0SwQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Sep 2021 14:52:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDAE961058;
        Mon, 27 Sep 2021 18:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632768638;
        bh=C5XC6h6Q1qc5Qf6BQUNRzYX2mM+5Ej8TnIc335MIf3Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sxhqG2OwJcmYiPbgyuP+0xu6/gEhxQlRDh6b0Q4SBqBqsN4nn+REtn//Bigm2XegR
         ltuanBZSrm5Dt6GJFsiwiA23f1AVvAUrGESKtat3QIvJZJcdHhUShJO+a3JDGkAcOZ
         hBm+bbjGjp1eJ3L8+BW1Hvy5k/t+DXjcmafsp4Qwiq5fz+FPcHdN7cSv1nVdS+iH5j
         4+kUSasJvEa4tLbjzHFbG61XTE6v9SW+4inMLS7Rk3O6gACDrFD9x0m5Kg3tADTBv7
         oK+UBQkgmZxlMMOwZ7wxWruTgiS8aySMoZgqahsIPVSzl9H8IY1XOu/MeIQNBzPO5O
         hg5kqidrgvEnw==
Date:   Mon, 27 Sep 2021 13:50:36 -0500
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
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 02/20] PCI/P2PDMA: attempt to set map_type if it has
 not been set
Message-ID: <20210927185036.GA668115@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-3-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 16, 2021 at 05:40:42PM -0600, Logan Gunthorpe wrote:
> Attempt to find the mapping type for P2PDMA pages on the first
> DMA map attempt if it has not been done ahead of time.
> 
> Previously, the mapping type was expected to be calculated ahead of
> time, but if pages are to come from userspace then there's no
> way to ensure the path was checked ahead of time.
> 
> With this change it's no longer invalid to call pci_p2pdma_map_sg()
> before the mapping type is calculated so drop the WARN_ON when that
> is the case.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Capitalize subject line.

> ---
>  drivers/pci/p2pdma.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 50cdde3e9a8b..1192c465ba6d 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -848,6 +848,7 @@ static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
>  	struct pci_dev *provider = to_p2p_pgmap(pgmap)->provider;
>  	struct pci_dev *client;
>  	struct pci_p2pdma *p2pdma;
> +	int dist;
>  
>  	if (!provider->p2pdma)
>  		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
> @@ -864,6 +865,10 @@ static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
>  		type = xa_to_value(xa_load(&p2pdma->map_types,
>  					   map_types_idx(client)));
>  	rcu_read_unlock();
> +
> +	if (type == PCI_P2PDMA_MAP_UNKNOWN)
> +		return calc_map_type_and_dist(provider, client, &dist, false);
> +
>  	return type;
>  }
>  
> @@ -906,7 +911,6 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>  	case PCI_P2PDMA_MAP_BUS_ADDR:
>  		return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
>  	default:
> -		WARN_ON_ONCE(1);
>  		return 0;
>  	}
>  }
> -- 
> 2.30.2
> 
