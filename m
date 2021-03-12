Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0A9339250
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 16:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhCLPwK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 10:52:10 -0500
Received: from foss.arm.com ([217.140.110.172]:56260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232105AbhCLPvs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Mar 2021 10:51:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79DA01FB;
        Fri, 12 Mar 2021 07:51:47 -0800 (PST)
Received: from [10.57.52.136] (unknown [10.57.52.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38D593F7D7;
        Fri, 12 Mar 2021 07:51:43 -0800 (PST)
Subject: Re: [RFC PATCH v2 00/11] Add support to dma_map_sg for P2PDMA
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc:     Minturn Dave B <dave.b.minturn@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <iweiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Stephen Bates <sbates@raithlin.com>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Xiong Jianxin <jianxin.xiong@intel.com>
References: <20210311233142.7900-1-logang@deltatee.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6b9be188-1ec7-527c-ae47-3f5b4e153758@arm.com>
Date:   Fri, 12 Mar 2021 15:51:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210311233142.7900-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-03-11 23:31, Logan Gunthorpe wrote:
> Hi,
> 
> This is a rework of the first half of my RFC for doing P2PDMA in userspace
> with O_DIRECT[1].
> 
> The largest issue with that series was the gross way of flagging P2PDMA
> SGL segments. This RFC proposes a different approach, (suggested by
> Dan Williams[2]) which uses the third bit in the page_link field of the
> SGL.
> 
> This approach is a lot less hacky but comes at the cost of adding a
> CONFIG_64BIT dependency to CONFIG_PCI_P2PDMA and using up the last
> scarce bit in the page_link. For our purposes, a 64BIT restriction is
> acceptable but it's not clear if this is ok for all usecases hoping
> to make use of P2PDMA.
> 
> Matthew Wilcox has already suggested (off-list) that this is the wrong
> approach, preferring a new dma mapping operation and an SGL replacement. I
> don't disagree that something along those lines would be a better long
> term solution, but it involves overcoming a lot of challenges to get
> there. Creating a new mapping operation still means adding support to more
> than 25 dma_map_ops implementations (many of which are on obscure
> architectures) or creating a redundant path to fallback with dma_map_sg()
> for every driver that uses the new operation. This RFC is an approach
> that doesn't require overcoming these blocks.

I don't really follow that argument - you're only adding support to two 
implementations with the awkward flag, so why would using a dedicated 
operation instead be any different? Whatever callers need to do if 
dma_pci_p2pdma_supported() says no, they could equally do if 
dma_map_p2p_sg() (or whatever) returns -ENXIO, no?

We don't try to multiplex .map_resource through .map_page, so there 
doesn't seem to be any good reason to force that complexity on .map_sg 
either. And having a distinct API from the outset should make it a lot 
easier to transition to better "list of P2P memory regions" data 
structures in future without rewriting the whole world. As it is, there 
are potential benefits in a P2P interface which can define its own 
behaviour - for instance if threw out the notion of segment merging it 
could save a load of bother by just maintaining the direct correlation 
between pages and DMA addresses.

Robin.

> Any alternative ideas or feedback is welcome.
> 
> These patches are based on v5.12-rc2 and a git branch is available here:
> 
>    https://github.com/sbates130272/linux-p2pmem/  p2pdma_dma_map_ops_rfc
> 
> A branch with the patches from the previous RFC that add userspace
> O_DIRECT support is available at the same URL with the name
> "p2pdma_dma_map_ops_rfc+user" (however, none of the issues with those
> extra patches from the feedback of the last posting have been fixed).
> 
> Thanks,
> 
> Logan
> 
> [1] https://lore.kernel.org/linux-block/20201106170036.18713-1-logang@deltatee.com/
> [2] https://lore.kernel.org/linux-block/CAPcyv4ifGcrdOtUt8qr7pmFhmecGHqGVre9G0RorGczCGVECQQ@mail.gmail.com/
> 
> --
> 
> Logan Gunthorpe (11):
>    PCI/P2PDMA: Pass gfp_mask flags to upstream_bridge_distance_warn()
>    PCI/P2PDMA: Avoid pci_get_slot() which sleeps
>    PCI/P2PDMA: Attempt to set map_type if it has not been set
>    PCI/P2PDMA: Introduce pci_p2pdma_should_map_bus() and
>      pci_p2pdma_bus_offset()
>    lib/scatterlist: Add flag for indicating P2PDMA segments in an SGL
>    dma-direct: Support PCI P2PDMA pages in dma-direct map_sg
>    dma-mapping: Add flags to dma_map_ops to indicate PCI P2PDMA support
>    iommu/dma: Support PCI P2PDMA pages in dma-iommu map_sg
>    block: Add BLK_STS_P2PDMA
>    nvme-pci: Check DMA ops when indicating support for PCI P2PDMA
>    nvme-pci: Convert to using dma_map_sg for p2pdma pages
> 
>   block/blk-core.c            |  2 +
>   drivers/iommu/dma-iommu.c   | 63 +++++++++++++++++++++-----
>   drivers/nvme/host/core.c    |  3 +-
>   drivers/nvme/host/nvme.h    |  2 +-
>   drivers/nvme/host/pci.c     | 38 +++++++---------
>   drivers/pci/Kconfig         |  2 +-
>   drivers/pci/p2pdma.c        | 89 +++++++++++++++++++++++++++++++------
>   include/linux/blk_types.h   |  7 +++
>   include/linux/dma-map-ops.h |  3 ++
>   include/linux/dma-mapping.h |  5 +++
>   include/linux/pci-p2pdma.h  | 11 +++++
>   include/linux/scatterlist.h | 49 ++++++++++++++++++--
>   kernel/dma/direct.c         | 35 +++++++++++++--
>   kernel/dma/mapping.c        | 21 +++++++--
>   14 files changed, 271 insertions(+), 59 deletions(-)
> 
> 
> base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
> --
> 2.20.1
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
