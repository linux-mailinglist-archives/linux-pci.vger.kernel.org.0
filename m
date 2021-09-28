Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C860C41B6F0
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 21:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242319AbhI1TKi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 15:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242155AbhI1TKi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 15:10:38 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828C7C06161C
        for <linux-pci@vger.kernel.org>; Tue, 28 Sep 2021 12:08:58 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id b6so184758ilv.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Sep 2021 12:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EfElY477shD06prhcbkdx9dsGqBCwQCmB0C4j8bm7NE=;
        b=T7zH3yMi0g6yEhgmUnd7mO+Ur7OBh77wHEh6ggvhef5YbyC4wX4RRbWTB44KDdyQtC
         f+qApcKyr3n5Kl16eVfFgQ9tfeyRrR6Elwq6FGHKyACe8YimAJpy7cusTx0oBV41JMIt
         0Hs8ot7T3se64OIay27dLlQhOUiTQMVr0mnUblHvHoq8r+teZ7l8U9BnX5pxcEi+Yk7z
         s5RWLMvLxN8MPYR7eAYwtVLxanwLKsVahoBd3UvKp/b3/2FYvFg85dCO3UV5z34pnkRJ
         KVDkFetoYUVS2clKM8AdqWOtNoT0d0PPUr+04NJyaKP+HVSyA1Hg4mIqDJ4dKgMV/XBl
         XsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EfElY477shD06prhcbkdx9dsGqBCwQCmB0C4j8bm7NE=;
        b=7QYVOtV6oMxZWMRCjDldvUlDIOGqfgt6Y6F0clhABufbYpFiFR3pm18JDTeXfnsGic
         oE77v3H9Wp168GlNeLEvunKo90AsG2qpMzlOPJOkpoTP6ALXd3YpYBN11sBzLjUIJwbx
         ikytLvvZjX1NhGsE9yVA1J6CI0i6cfQTSQFTwFLRPTXxIm1V/7uyoU3hExQRqb8baVqo
         cKaeOWhp1UzvkFezAAkjxahBfaWCc9jGyiYq12RLvHHRQ53l1XubY1IbKETL0cSPfM6v
         p0abTxizeB7FZYzyBPM4A2YQ9I7owNKjj7d35wUZmhTIBuxZ85uSzpCr+2b/YoD8c/ET
         CxXQ==
X-Gm-Message-State: AOAM5323IL9P7RjnxxDbEo87oqiU7Y1juMJKC1gcZ4QOkC205Dy+Do4T
        JwXWJTEErdbJzvLrgfjcmZ2oEC6JaKGuig==
X-Google-Smtp-Source: ABdhPJwirdzukaEVpQtEHLEaN9P3HDIpr/EdIl+V+c/21A4I82mQWg8qeJs2PajODuEvNoAg4jE0MQ==
X-Received: by 2002:a05:6e02:1a6b:: with SMTP id w11mr5790685ilv.21.1632856137729;
        Tue, 28 Sep 2021 12:08:57 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id r13sm12324375ilh.80.2021.09.28.12.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 12:08:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mVITI-007Fut-4V; Tue, 28 Sep 2021 16:08:56 -0300
Date:   Tue, 28 Sep 2021 16:08:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 06/20] dma-direct: support PCI P2PDMA pages in
 dma-direct map_sg
Message-ID: <20210928190856.GN3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-7-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-7-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 16, 2021 at 05:40:46PM -0600, Logan Gunthorpe wrote:
> Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
> PCI P2PDMA pages directly without a hack in the callers. This allows
> for heterogeneous SGLs that contain both P2PDMA and regular pages.
> 
> A P2PDMA page may have three possible outcomes when being mapped:
>   1) If the data path between the two devices doesn't go through the
>      root port, then it should be mapped with a PCI bus address
>   2) If the data path goes through the host bridge, it should be mapped
>      normally, as though it were a CPU physical address
>   3) It is not possible for the two devices to communicate and thus
>      the mapping operation should fail (and it will return -EREMOTEIO).
> 
> SGL segments that contain PCI bus addresses are marked with
> sg_dma_mark_pci_p2pdma() and are ignored when unmapped.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  kernel/dma/direct.c | 44 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 4c6c5e0635e3..fa8317e8ff44 100644
> +++ b/kernel/dma/direct.c
> @@ -13,6 +13,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/set_memory.h>
>  #include <linux/slab.h>
> +#include <linux/pci-p2pdma.h>
>  #include "direct.h"
>  
>  /*
> @@ -421,29 +422,60 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
>  		arch_sync_dma_for_cpu_all();
>  }
>  
> +/*
> + * Unmaps segments, except for ones marked as pci_p2pdma which do not
> + * require any further action as they contain a bus address.
> + */
>  void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>  		int nents, enum dma_data_direction dir, unsigned long attrs)
>  {
>  	struct scatterlist *sg;
>  	int i;
>  
> -	for_each_sg(sgl, sg, nents, i)
> -		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
> -			     attrs);
> +	for_each_sg(sgl, sg, nents, i) {
> +		if (sg_is_dma_pci_p2pdma(sg)) {
> +			sg_dma_unmark_pci_p2pdma(sg);
> +		} else  {
> +			dma_direct_unmap_page(dev, sg->dma_address,
> +					      sg_dma_len(sg), dir, attrs);
> +		}

If the main usage of this SGL bit is to indicate if it has been DMA
mapped, or not, I think it should be renamed to something clearer.

p2pdma is being used for lots of things now, it feels very
counter-intuitive that P2PDMA pages are not flagged with
something called sg_is_dma_pci_p2pdma().

How about sg_is_dma_unmapped_address() ?
>  
>  	for_each_sg(sgl, sg, nents, i) {
> +		if (is_pci_p2pdma_page(sg_page(sg))) {
> +			map = pci_p2pdma_map_segment(&p2pdma_state, dev, sg);
> +			switch (map) {
> +			case PCI_P2PDMA_MAP_BUS_ADDR:
> +				continue;
> +			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +				/*
> +				 * Mapping through host bridge should be
> +				 * mapped normally, thus we do nothing
> +				 * and continue below.
> +				 */
> +				break;
> +			default:
> +				ret = -EREMOTEIO;
> +				goto out_unmap;
> +			}
> +		}
> +
>  		sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
>  				sg->offset, sg->length, dir, attrs);

dma_direct_map_page() can trigger swiotlb and I didn't see this series
dealing with that?

It would probably be fine for now to fail swiotlb_map() for p2p pages?

Jason
