Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4E754CDEC
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 18:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348719AbiFOQMx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 12:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbiFOQMw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 12:12:52 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B2521268;
        Wed, 15 Jun 2022 09:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
        :references:content-disposition:in-reply-to;
        bh=/V+gZoV8pa64RyycdnrAu6um2lziyupjf8y+KKTdgKM=; b=cfjokioABlazhih4iA9XipxnHE
        iwg+BS5/1/fJ3k9AWIPvCh6bAQRpTKMo3NE4A/lmFS5vFmyURrazVbye6G+TmxhzRhgKqIzp1U08o
        RchrvPdPNe9jbbnElipX5QofwE4pqMHfVmVmOyhccRu74uUh4VAJVXknCwZ12K7pHOtGt/qcvolpv
        nr2MVI9On5dczSTzxc9w1zqCg/vTOr8kN6NVwxAxVtxwp6NzDVM2113+Dc0W9KPnQuIqnM5SJTRpW
        ++gRhRyCus9ZOqae+RR391dFlc2XkL2RQ/c9rY5DR7q0KRbzkTI9BiG87QE3iP6qC3l8ckdXAYQxK
        H2QK7edw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1VdN-0084iP-L1; Wed, 15 Jun 2022 10:12:47 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1VdG-0004Zp-NQ; Wed, 15 Jun 2022 10:12:38 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 15 Jun 2022 10:12:12 -0600
Message-Id: <20220615161233.17527-1-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v7 00/21]  Userspace P2PDMA with O_DIRECT NVMe devices
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This patchset continues my work to add userspace P2PDMA access using
O_DIRECT NVMe devices. This posting cleans up the way the pages are
stored in the VMA and relies on proper reference counting that was
fixed up recently in the kernel. The new method uses vm_insert_page()
in pci_mmap_p2pmem() so there are no longer an faults or other ops and
the pages are just freed sensibly when the VMA is removed. This simplifies
the VMA code significantly.

The previous posting was here[1].

This patch set enables userspace P2PDMA by allowing userspace to mmap()
allocated chunks of the CMB. The resulting VMA can be passed only
to O_DIRECT IO on NVMe backed files or block devices. A flag is added
to GUP() in Patch 14, then Patches 15 through 19 wire this flag up based
on whether the block queue indicates P2PDMA support. Patches 20
through 21 enable the CMB to be mapped into userspace by mmaping
the nvme char device.

This is relatively straightforward, however the one significant
problem is that, presently, pci_p2pdma_map_sg() requires a homogeneous
SGL with all P2PDMA pages or all regular pages. Enhancing GUP to
support enforcing this rule would require a huge hack that I don't
expect would be all that pallatable. So the first 13 patches add
support for P2PDMA pages to dma_map_sg[table]() to the dma-direct
and dma-iommu implementations. Thus, systems without an IOMMU plus
Intel and AMD IOMMUs are supported. (Other IOMMU implementations would
then be unsupported, notably ARM and PowerPC but support would be added
when they convert to dma-iommu).

dma_map_sgtable() is preferred when dealing with P2PDMA memory as it
will return -EREMOTEIO when the DMA device cannot map specific P2PDMA
pages based on the existing rules in calc_map_type_and_dist().

The other issue is dma_unmap_sg() needs a flag to determine whether a
given dma_addr_t was mapped regularly or as a PCI bus address. To allow
this, a third flag is added to the page_link field in struct
scatterlist. This effectively means support for P2PDMA will now depend
on CONFIG_64BIT.

Feedback welcome.

This series is based on v5.19-rc1. A git branch is available here:

  https://github.com/sbates130272/linux-p2pmem/  p2pdma_user_cmb_v7

Thanks,

Logan

[1] https://lkml.kernel.org/r/20220407154717.7695-1-logang@deltatee.com

--

Changes since v6:
  - Rebase onto v5.19-rc1
  - Rework how the pages are stored in the VMA per Jason's suggestion

Changes since v5:
  - Rebased onto v5.18-rc1 which includes Christophs cleanup to
    free_zone_device_page() (similar to Ralph's patch).
  - Fix bug with concurrent first calls to pci_p2pdma_vma_fault()
    that caused a double allocation and lost p2p memory. Noticed
    by Andrew Maier.
  - Collected a Reviewed-by tag from Chaitanya.
  - Numerous minor fixes to commit messages

Changes since v4:
  - Rebase onto v5.17-rc1.
  - Included Ralph Cambell's patches which removes the ZONE_DEVICE page
    reference count offset. This is just to demonstrate that this
    series is compatible with that direction.
  - Added a comment in pci_p2pdma_map_sg_attrs(), per Chaitanya and
    included his Reviewed-by tags.
  - Patch 1 in the last series which cleaned up scatterlist.h
    has been upstreamed.
  - Dropped NEED_SG_DMA_BUS_ADDR_FLAG seeing depends on doesn't
    work with selected symbols, per Christoph.
  - Switched iov_iter_get_pages_[alloc_]flags to be exported with
    EXPORT_SYMBOL_GPL, per Christoph.
  - Renamed zone_device_pages_are_mergeable() to
    zone_device_pages_have_same_pgmap(), per Christoph.
  - Renamed .mmap_file_open operation in nvme_ctrl_ops to
    cdev_file_open(), per Christoph.

Changes since v3:
  - Add some comment and commit message cleanups I had missed for v3,
    also moved the prototypes for some of the p2pdma helpers to
    dma-map-ops.h (which I missed in v3 and was suggested in v2).
  - Add separate cleanup patch for scatterlist.h and change the macros
    to functions. (Suggested by Chaitanya and Jason, respectively)
  - Rename sg_dma_mark_pci_p2pdma() and sg_is_dma_pci_p2pdma() to
    sg_dma_mark_bus_address() and sg_is_dma_bus_address() which
    is a more generic name (As requested by Jason)
  - Fixes to some comments and commit messages as suggested by Bjorn
    and Jason.
  - Ensure swiotlb is not used with P2PDMA pages. (Per Jason)
  - The sgtable coversion in RDMA was split out and sent upstream
    separately, the new patch is only the removal. (Per Jason)
  - Moved the FOLL_PCI_P2PDMA check outside of get_dev_pagemap() as
    Jason suggested this will be removed in the near term.
  - Add two patches to ensure that zone device pages with different
    pgmaps are never merged in the block layer or
    sg_alloc_append_table_from_pages() (Per Jason)
  - Ensure synchronize_rcu() or call_rcu() is used before returning
    pages to the genalloc. (Jason pointed out that pages are not
    gauranteed to be unused in all architectures until at least
    after an RCU grace period, and that synchronize_rcu() was likely
    too slow to use in the vma close operation.
  - Collected Acks and Reviews by Bjorn, Jason and Max.

--

Logan Gunthorpe (21):
  lib/scatterlist: add flag for indicating P2PDMA segments in an SGL
  PCI/P2PDMA: Attempt to set map_type if it has not been set
  PCI/P2PDMA: Expose pci_p2pdma_map_type()
  PCI/P2PDMA: Introduce helpers for dma_map_sg implementations
  dma-mapping: allow EREMOTEIO return code for P2PDMA transfers
  dma-direct: support PCI P2PDMA pages in dma-direct map_sg
  dma-mapping: add flags to dma_map_ops to indicate PCI P2PDMA support
  iommu/dma: support PCI P2PDMA pages in dma-iommu map_sg
  nvme-pci: check DMA ops when indicating support for PCI P2PDMA
  nvme-pci: convert to using dma_map_sgtable()
  RDMA/core: introduce ib_dma_pci_p2p_dma_supported()
  RDMA/rw: drop pci_p2pdma_[un]map_sg()
  PCI/P2PDMA: Remove pci_p2pdma_[un]map_sg()
  mm: introduce FOLL_PCI_P2PDMA to gate getting PCI P2PDMA pages
  iov_iter: introduce iov_iter_get_pages_[alloc_]flags()
  block: add check when merging zone device pages
  lib/scatterlist: add check when merging zone device pages
  block: set FOLL_PCI_P2PDMA in __bio_iov_iter_get_pages()
  block: set FOLL_PCI_P2PDMA in bio_map_user_iov()
  PCI/P2PDMA: Introduce pci_mmap_p2pmem()
  nvme-pci: allow mmaping the CMB in userspace

 block/bio.c                  |  10 +-
 block/blk-map.c              |   7 +-
 drivers/infiniband/core/rw.c |  45 +----
 drivers/iommu/dma-iommu.c    |  68 ++++++-
 drivers/nvme/host/core.c     |  38 +++-
 drivers/nvme/host/nvme.h     |   5 +-
 drivers/nvme/host/pci.c      | 103 ++++++-----
 drivers/nvme/target/rdma.c   |   2 +-
 drivers/pci/Kconfig          |   5 +
 drivers/pci/p2pdma.c         | 337 ++++++++++++++++++++++++++++-------
 include/linux/dma-map-ops.h  |  76 ++++++++
 include/linux/dma-mapping.h  |   5 +
 include/linux/mm.h           |  24 +++
 include/linux/pci-p2pdma.h   |  43 ++---
 include/linux/scatterlist.h  |  44 ++++-
 include/linux/uio.h          |   6 +
 include/rdma/ib_verbs.h      |  11 ++
 include/uapi/linux/magic.h   |   1 +
 kernel/dma/direct.c          |  43 ++++-
 kernel/dma/direct.h          |   8 +-
 kernel/dma/mapping.c         |  22 ++-
 lib/iov_iter.c               |  25 ++-
 lib/scatterlist.c            |  25 +--
 mm/gup.c                     |  22 ++-
 24 files changed, 765 insertions(+), 210 deletions(-)


base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
--
2.30.2
