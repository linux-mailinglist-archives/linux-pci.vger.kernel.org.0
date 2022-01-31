Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246A14A4F02
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 19:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244303AbiAaS4p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 13:56:45 -0500
Received: from out2.migadu.com ([188.165.223.204]:24197 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232915AbiAaS4p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jan 2022 13:56:45 -0500
Message-ID: <c725798d-48da-2993-cc48-0ec0b314455f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1643655403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/Ch63bJctNf9QVTZKCEvsLX1+etquC6AF86UHoNYQM=;
        b=kWyls4uSwgafhck97EAH48F82wrfX1sG7bf2UiJGBsZ6E7Ik/quiWKTHipoo8vkphexbQV
        myDA12KzydncCp/wpMhcNWf9nJrkJDZKOviEN3jh728f3TNzuxKgFqSQdpfSMtFNotH6Lz
        jMcWyPgRMq1uWDXOiPLTxcYaTsLE3zE=
Date:   Mon, 31 Jan 2022 11:56:36 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v5 00/24] Userspace P2PDMA with O_DIRECT NVMe devices
Content-Language: en-US
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>
References: <20220128002614.6136-1-logang@deltatee.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20220128002614.6136-1-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Logan,

On 1/27/2022 5:25 PM, Logan Gunthorpe wrote:
> Hi,
> 
> This patchset continues my work to add userspace P2PDMA access using
> O_DIRECT NVMe devices. This posting fixes a lot of issues that were
> addresed in the last posting, which is here[1].
> 
> The patchset is rebased onto v5.17-rc1 as well as a rebased version of
> Ralph Campbell's patches to drop the ZONE_DEVICE page ref count offset.
> My understanding is this patch has some problems that are yet to be
> resolved but this will be the direction taken going forward and is
> included here to show that it is compatible with this patchset.
> 
> The patchset enables userspace P2PDMA by allowing userspace to mmap()
> allocated chunks of the CMB. The resulting VMA can be passed only
> to O_DIRECT IO on NVMe backed files or block devices. A flag is added
> to GUP() in Patch 16, then Patches 17 through 21 wire this flag up based
> on whether the block queue indicates P2PDMA support. Patches 22
> through 24 enable the CMB to be mapped into userspace by mmaping
> the nvme char device.
> 
> This is relatively straightforward, however the one significant
> problem is that, presently, pci_p2pdma_map_sg() requires a homogeneous
> SGL with all P2PDMA pages or all regular pages. Enhancing GUP to
> support enforcing this rule would require a huge hack that I don't
> expect would be all that pallatable. So patches 3 to 16 add
> support for P2PDMA pages to dma_map_sg[table]() to the dma-direct
> and dma-iommu implementations. Thus systems without an IOMMU plus
> Intel and AMD IOMMUs are supported. (Other IOMMU implementations would
> then be unsupported, notably ARM and PowerPC but support would be added
> when they convert to dma-iommu).
Am I understanding that an IO may use a mix of p2pdma and system pages?
Would that cause inconsistent latencies?

> 
> dma_map_sgtable() is preferred when dealing with P2PDMA memory as it
> will return -EREMOTEIO when the DMA device cannot map specific P2PDMA
> pages based on the existing rules in calc_map_type_and_dist().
> 
> The other issue is dma_unmap_sg() needs a flag to determine whether a
> given dma_addr_t was mapped regularly or as a PCI bus address. To allow
> this, a third flag is added to the page_link field in struct
> scatterlist. This effectively means support for P2PDMA will now depend
> on CONFIG_64BIT.
> 
> Feedback welcome.
> 
> This series is based on v5.17-rc1. A git branch is available here:
> 
>    https://github.com/sbates130272/linux-p2pmem/  p2pdma_user_cmb_v5
> 
> Thanks,
> 
> Logan
> 
> [1] https://lore.kernel.org/all/20211117215410.3695-1-logang@deltatee.com/T/#u
> 
> --
> 
> Changes since v4:
>    - Rebase onto v5.17-rc1.
>    - Included Ralph Cambell's patches which removes the ZONE_DEVICE page
>      reference count offset. This is just to demonstrate that this
>      series is compatible with that direction.
>    - Added a comment in pci_p2pdma_map_sg_attrs(), per Chaitanya and
>      included his Reviewed-by tags.
>    - Patch 1 in the last series which cleaned up scatterlist.h
>      has been upstreamed.
>    - Dropped NEED_SG_DMA_BUS_ADDR_FLAG seeing depends on doesn't
>      work with selected symbols, per Christoph.
>    - Switched iov_iter_get_pages_[alloc_]flags to be exported with
>      EXPORT_SYMBOL_GPL, per Christoph.
>    - Renamed zone_device_pages_are_mergeable() to
>      zone_device_pages_have_same_pgmap(), per Christoph.
>    - Renamed .mmap_file_open operation in nvme_ctrl_ops to
>      cdev_file_open(), per Christoph.
> 
> Changes since v3:
>    - Add some comment and commit message cleanups I had missed for v3,
>      also moved the prototypes for some of the p2pdma helpers to
>      dma-map-ops.h (which I missed in v3 and was suggested in v2).
>    - Add separate cleanup patch for scatterlist.h and change the macros
>      to functions. (Suggested by Chaitanya and Jason, respectively)
>    - Rename sg_dma_mark_pci_p2pdma() and sg_is_dma_pci_p2pdma() to
>      sg_dma_mark_bus_address() and sg_is_dma_bus_address() which
>      is a more generic name (As requested by Jason)
>    - Fixes to some comments and commit messages as suggested by Bjorn
>      and Jason.
>    - Ensure swiotlb is not used with P2PDMA pages. (Per Jason)
>    - The sgtable coversion in RDMA was split out and sent upstream
>      separately, the new patch is only the removal. (Per Jason)
>    - Moved the FOLL_PCI_P2PDMA check outside of get_dev_pagemap() as
>      Jason suggested this will be removed in the near term.
>    - Add two patches to ensure that zone device pages with different
>      pgmaps are never merged in the block layer or
>      sg_alloc_append_table_from_pages() (Per Jason)
>    - Ensure synchronize_rcu() or call_rcu() is used before returning
>      pages to the genalloc. (Jason pointed out that pages are not
>      gauranteed to be unused in all architectures until at least
>      after an RCU grace period, and that synchronize_rcu() was likely
>      too slow to use in the vma close operation.
>    - Collected Acks and Reviews by Bjorn, Jason and Max.
> 
> Logan Gunthorpe (22):
>    lib/scatterlist: add flag for indicating P2PDMA segments in an SGL
>    PCI/P2PDMA: Attempt to set map_type if it has not been set
>    PCI/P2PDMA: Expose pci_p2pdma_map_type()
>    PCI/P2PDMA: Introduce helpers for dma_map_sg implementations
>    dma-mapping: allow EREMOTEIO return code for P2PDMA transfers
>    dma-direct: support PCI P2PDMA pages in dma-direct map_sg
>    dma-mapping: add flags to dma_map_ops to indicate PCI P2PDMA support
>    iommu/dma: support PCI P2PDMA pages in dma-iommu map_sg
>    nvme-pci: check DMA ops when indicating support for PCI P2PDMA
>    nvme-pci: convert to using dma_map_sgtable()
>    RDMA/core: introduce ib_dma_pci_p2p_dma_supported()
>    RDMA/rw: drop pci_p2pdma_[un]map_sg()
>    PCI/P2PDMA: Remove pci_p2pdma_[un]map_sg()
>    mm: introduce FOLL_PCI_P2PDMA to gate getting PCI P2PDMA pages
>    iov_iter: introduce iov_iter_get_pages_[alloc_]flags()
>    block: add check when merging zone device pages
>    lib/scatterlist: add check when merging zone device pages
>    block: set FOLL_PCI_P2PDMA in __bio_iov_iter_get_pages()
>    block: set FOLL_PCI_P2PDMA in bio_map_user_iov()
>    mm: use custom page_free for P2PDMA pages
>    PCI/P2PDMA: Introduce pci_mmap_p2pmem()
>    nvme-pci: allow mmaping the CMB in userspace
> 
> Ralph Campbell (2):
>    ext4/xfs: add page refcount helper
>    mm: remove extra ZONE_DEVICE struct page refcount
> 
>   arch/powerpc/kvm/book3s_hv_uvmem.c     |   2 +-
>   block/bio.c                            |  10 +-
>   block/blk-map.c                        |   7 +-
>   drivers/gpu/drm/nouveau/nouveau_dmem.c |   2 +-
>   drivers/infiniband/core/rw.c           |  45 +--
>   drivers/iommu/dma-iommu.c              |  67 +++-
>   drivers/nvme/host/core.c               |  18 +-
>   drivers/nvme/host/nvme.h               |   4 +-
>   drivers/nvme/host/pci.c                |  97 +++---
>   drivers/nvme/target/rdma.c             |   2 +-
>   drivers/pci/Kconfig                    |   5 +
>   drivers/pci/p2pdma.c                   | 441 +++++++++++++++++++++----
>   fs/dax.c                               |   8 +-
>   fs/ext4/inode.c                        |   5 +-
>   fs/fuse/dax.c                          |   4 +-
>   fs/xfs/xfs_file.c                      |   4 +-
>   include/linux/dax.h                    |  10 +
>   include/linux/dma-map-ops.h            |  76 +++++
>   include/linux/dma-mapping.h            |   5 +
>   include/linux/memremap.h               |   7 +-
>   include/linux/mm.h                     |  68 ++--
>   include/linux/pci-p2pdma.h             |  38 +--
>   include/linux/scatterlist.h            |  44 ++-
>   include/linux/uio.h                    |   6 +
>   include/rdma/ib_verbs.h                |  11 +
>   include/uapi/linux/magic.h             |   1 +
>   kernel/dma/direct.c                    |  43 ++-
>   kernel/dma/direct.h                    |   7 +-
>   kernel/dma/mapping.c                   |  22 +-
>   lib/iov_iter.c                         |  25 +-
>   lib/scatterlist.c                      |  25 +-
>   lib/test_hmm.c                         |   2 +-
>   mm/gup.c                               |  22 +-
>   mm/internal.h                          |   8 +
>   mm/memcontrol.c                        |   6 +-
>   mm/memremap.c                          |  75 ++---
>   mm/migrate.c                           |   5 -
>   mm/page_alloc.c                        |   3 +
>   mm/swap.c                              |  45 +--
>   39 files changed, 904 insertions(+), 371 deletions(-)
> 
> 
> base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
> --
> 2.30.2
