Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF682A9A25
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 18:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbgKFRA4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 12:00:56 -0500
Received: from ale.deltatee.com ([204.191.154.188]:57624 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbgKFRA4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 12:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QghfGn0XJlLalBYUlEV3tKSl1nQDSW7GcuVBagc2hq4=; b=oAjEwr76TG6NvxLQ6kuNQsWpFf
        Z+k+ic3yRFpJ1nQs2zquoS7aZCtAV4GbSDqKqm9B6cdICtbKyaGqJ4H6IjZPjNpdtl2v7gcLFTmPr
        i4quG8H0mgGrAlVVtdoH2v5j5VFNbOWzgFJDI49oE4OcSJtyoVg3ZQW3auqLoSfbrmkVbRCMix8RS
        OEbjP1xCjDKn3C2oFyTXmTqOtAJnJq19YJSGZEDGL6W66eBoKK1Zhfc7VJFbptWOcqM1wb0pSWeK1
        Z7srBW+/DJ9DSjWucbzDVqsWWxKifdPiAVpFF2bHQFYF98f4ljdv6zHJmh93Rbm3sJoMWrWmR8M9C
        IoAT3nFg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kb56Z-0002PV-5l; Fri, 06 Nov 2020 10:00:54 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kb56U-0004so-1K; Fri, 06 Nov 2020 10:00:46 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri,  6 Nov 2020 10:00:21 -0700
Message-Id: <20201106170036.18713-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, dan.j.williams@intel.com, iweiny@intel.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [RFC PATCH 00/15] Userspace P2PDMA with O_DIRECT NVMe devices
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This RFC enables P2PDMA transfers in userspace between NVMe drives using
existing O_DIRECT operations or the NVMe passthrough IOCTL.

This is accomplished by allowing userspace to allocate chunks of any CMB
by mmaping the NVMe ctrl device (Patches 14 and 15). The resulting memory
will be backed by P2P pages and can be passed only to O_DIRECT
operations. A flag is added to GUP() in Patch 10 and Patches 11 through 13
wire this flag up based on whether the block queue indicates P2PDMA
support.

The above is pretty straight forward and (I hope) largely uncontroversial.
However, the one significant problem in all this is that, presently,
pci_p2pdma_map_sg() requires a homogeneous SGL with all P2PDMA pages or
none. Enhancing GUP to support enforcing this rule would require a huge
hack that I don't expect would be all that pallatable. So this RFC takes
the approach of removing the requirement of having a homogeneous SGL.

With the new common dma-iommu infrastructure, this patchset adds
support for P2PDMA pages into dma_map_sg() which will support AMD,
Intel (soon) and dma-direct implementations. (Other IOMMU
implementations would then be unsupported, notably ARM and PowerPC).

The other major blocker is that in order to implement support for
P2PDMA pages in dma_map_sg(), a flag is necessary to determine if a
given dma_addr_t points to P2PDMA memory or to an IOVA so that it can
be unmapped appropriately in dma_unmap_sg(). The (ugly) approach this
RFC takes is to use the top bit in the dma_length field and ensure
callers are prepared for it using a new DMA_ATTR_P2PDMA flag.

I suspect, the ultimate solution to this blocker will be to implement
some kind of new dma_op that doesn't use the SGL. Ideas have been
thrown around in the past for one that maps some kind of novel dma_vec
directly from a bio_vec. This will become a lot easier to implement if
more dma_ops providers get converted to the new dma-iommu
implementation, but this will take time.

Alternative ideas or other feedback welcome.

This series is based on v5.10-rc2 with Lu Baolu's (and Tom Murphy's)
v4 patchset for converting the Intel IOMMU to dma-iommu[1]. A git
branch is available here:

  https://github.com/sbates130272/linux-p2pmem/  p2pdma_user_cmb_rfc

Thanks,

Logan

[1] https://lkml.kernel.org/lkml/20200927063437.13988-1-baolu.lu@linux.intel.com/T/#u.


Logan Gunthorpe (15):
  PCI/P2PDMA: Don't sleep in upstream_bridge_distance_warn()
  PCI/P2PDMA: Attempt to set map_type if it has not been set
  PCI/P2PDMA: Introduce pci_p2pdma_should_map_bus() and
    pci_p2pdma_bus_offset()
  lib/scatterlist: Add flag for indicating P2PDMA segments in an SGL
  dma-direct: Support PCI P2PDMA pages in dma-direct map_sg
  dma-mapping: Add flags to dma_map_ops to indicate PCI P2PDMA support
  iommu/dma: Support PCI P2PDMA pages in dma-iommu map_sg
  nvme-pci: Check DMA ops when indicating support for PCI P2PDMA
  nvme-pci: Convert to using dma_map_sg for p2pdma pages
  mm: Introduce FOLL_PCI_P2PDMA to gate getting PCI P2PDMA pages
  iov_iter: Introduce iov_iter_get_pages_[alloc_]flags()
  block: Set FOLL_PCI_P2PDMA in __bio_iov_iter_get_pages()
  block: Set FOLL_PCI_P2PDMA in bio_map_user_iov()
  PCI/P2PDMA: Introduce pci_mmap_p2pmem()
  nvme-pci: Allow mmaping the CMB in userspace

 block/bio.c                 |   7 +-
 block/blk-map.c             |   7 +-
 drivers/dax/super.c         |   7 +-
 drivers/iommu/dma-iommu.c   |  63 +++++++++++--
 drivers/nvme/host/core.c    |  14 ++-
 drivers/nvme/host/nvme.h    |   3 +-
 drivers/nvme/host/pci.c     |  50 ++++++----
 drivers/pci/p2pdma.c        | 178 +++++++++++++++++++++++++++++++++---
 include/linux/dma-map-ops.h |   3 +
 include/linux/dma-mapping.h |  16 ++++
 include/linux/memremap.h    |   4 +-
 include/linux/mm.h          |   1 +
 include/linux/pci-p2pdma.h  |  17 ++++
 include/linux/scatterlist.h |   4 +
 include/linux/uio.h         |  21 ++++-
 kernel/dma/direct.c         |  33 ++++++-
 kernel/dma/mapping.c        |   8 ++
 lib/iov_iter.c              |  25 ++---
 mm/gup.c                    |  28 +++---
 mm/huge_memory.c            |   8 +-
 mm/memory-failure.c         |   4 +-
 mm/memremap.c               |  14 ++-
 22 files changed, 427 insertions(+), 88 deletions(-)


base-commit: 5ba8a2512e8c5f5cf9b7309dc895612f0a77a399
--
2.20.1
