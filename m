Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D8A33CF65
	for <lists+linux-pci@lfdr.de>; Tue, 16 Mar 2021 09:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhCPIMa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Mar 2021 04:12:30 -0400
Received: from verein.lst.de ([213.95.11.211]:58982 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234220AbhCPIME (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Mar 2021 04:12:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 68EB168C4E; Tue, 16 Mar 2021 09:11:57 +0100 (CET)
Date:   Tue, 16 Mar 2021 09:11:56 +0100
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
Subject: Re: [RFC PATCH v2 06/11] dma-direct: Support PCI P2PDMA pages in
 dma-direct map_sg
Message-ID: <20210316081156.GA16595@lst.de>
References: <20210311233142.7900-1-logang@deltatee.com> <20210311233142.7900-7-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311233142.7900-7-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 11, 2021 at 04:31:36PM -0700, Logan Gunthorpe wrote:
>  	for_each_sg(sgl, sg, nents, i) {
> +		if (is_pci_p2pdma_page(sg_page(sg))) {
> +			if (sg_page(sg)->pgmap != pgmap) {
> +				pgmap = sg_page(sg)->pgmap;
> +				map = pci_p2pdma_dma_map_type(dev, pgmap);
> +				bus_off = pci_p2pdma_bus_offset(sg_page(sg));
> +			}
> +
> +			if (map < 0) {
> +				sg->dma_address = DMA_MAPPING_ERROR;
> +				ret = -EREMOTEIO;
> +				goto out_unmap;
> +			}
> +
> +			if (map) {
> +				sg->dma_address = sg_phys(sg) + sg->offset -
> +					bus_off;
> +				sg_dma_len(sg) = sg->length;
> +				sg_mark_pci_p2pdma(sg);
> +				continue;
> +			}
> +		}

This code needs to go into a separate noinline helper to reduce the impact
on the fast path.  Also as Robin noted the offset is already
accounted for in sg_phys.  We also don't ever set the dma_address in
the scatterlist to DMA_MAPPING_ERROR, that is just a return value
for the single entry mapping routines.
