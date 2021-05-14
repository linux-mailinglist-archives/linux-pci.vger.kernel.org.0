Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5008B380AD0
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 15:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhENN62 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 09:58:28 -0400
Received: from verein.lst.de ([213.95.11.211]:50629 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhENN62 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 May 2021 09:58:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 176846736F; Fri, 14 May 2021 15:57:13 +0200 (CEST)
Date:   Fri, 14 May 2021 15:57:12 +0200
From:   Christoph Hellwig <hch@lst.de>
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
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 15/22] dma-direct: Support PCI P2PDMA pages in
 dma-direct map_sg
Message-ID: <20210514135712.GD4715@lst.de>
References: <20210513223203.5542-1-logang@deltatee.com> <20210513223203.5542-16-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513223203.5542-16-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +	for_each_sg(sgl, sg, nents, i) {
> +		if (sg_is_dma_pci_p2pdma(sg)) {
> +			sg_dma_unmark_pci_p2pdma(sg);
> +		} else  {

Double space here.  We also don't really need the curly braces to start
with.

> +	struct pci_p2pdma_map_state p2pdma_state = {};
> +	enum pci_p2pdma_map_type map;
>  	struct scatterlist *sg;
> +	int i, ret;
>  
>  	for_each_sg(sgl, sg, nents, i) {
> +		if (is_pci_p2pdma_page(sg_page(sg))) {
> +			map = pci_p2pdma_map_segment(&p2pdma_state, dev, sg);
> +			switch (map) {

Why not just:

			switch (pci_p2pdma_map_segment(&p2pdma_state, dev,
					sg)) {

(even better with a shorter name for p2pdma_state so that it all fits on
a single line)?

> +			case PCI_P2PDMA_MAP_BUS_ADDR:
> +				continue;
> +			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +				/*
> +				 * Mapping through host bridge should be
> +				 * mapped normally, thus we do nothing
> +				 * and continue below.
> +				 */

I have a bit of a hard time parsing this comment.

> +		if (sg->dma_address == DMA_MAPPING_ERROR) {
> +			ret = -EINVAL;
>  			goto out_unmap;
> +		}
>  		sg_dma_len(sg) = sg->length;
>  	}
>  
> @@ -411,7 +443,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>  
>  out_unmap:
>  	dma_direct_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
> -	return -EINVAL;
> +	return ret;

Maybe just initialize ret to -EINVAL at declaration time to simplify this
a bit?
