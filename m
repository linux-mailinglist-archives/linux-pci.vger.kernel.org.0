Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA02240EDEB
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 01:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241583AbhIPXme (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 19:42:34 -0400
Received: from ale.deltatee.com ([204.191.154.188]:40580 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238769AbhIPXmc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 19:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
        :references:content-disposition:in-reply-to;
        bh=2hK6AsHc/ysDKmL7f6dXUZSSeE0kBcwrFrtpZ34IiEA=; b=dv9GSoU5q89O6QAjG6UUhsk3GS
        +j/d9pDqmJ/2DTqV135u2egzDU+xfME9bSFt0gzd/BGOfamNWms6HmQznPJrqeDeQkwpLP0E2lxY/
        q+z7pSlUuxGCM5Os4UOSwxQR918zGb3Ztoh71qOF8KH70g93rPysvHpD0pONYPjpFBEC7iyolydT7
        AGMIsUK+1DL/9E5LAhIWj/PESbA3EtiPPUXe4b9zkfs8xM/0rmjpvYOvU6UGLijfJZ2BeiK4SCn5e
        Fz0SFsYdzYgf5R6I/uMXAb59wVgnOsuKJogy5Em5DV33/17yyoPYbh6HaZGTxefqWcNRE08KJMGrd
        sBI7uRAg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1mR107-0008Hz-JR; Thu, 16 Sep 2021 17:41:09 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1mR103-000Vqn-Ee; Thu, 16 Sep 2021 17:41:03 -0600
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
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 16 Sep 2021 17:40:40 -0600
Message-Id: <20210916234100.122368-1-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_FREE,MYRULES_NO_TEXT autolearn=no autolearn_force=no
        version=3.4.2
Subject: [PATCH v3 00/20] Userspace P2PDMA with O_DIRECT NVMe devices
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This patchset continues my work to add userspace P2PDMA access using
O_DIRECT NVMe devices. My last posting[1] just included the first 13
patches in this series, but the early P2PDMA cleanup and map_sg error
changes from that series have been merged into v5.15-rc1. To address
concerns that that series did not add any new functionality, I've added
back the userspcae functionality from the original RFC[2] (but improved
based on the original feedback).

The patchset enables userspace P2PDMA by allowing userspace to mmap()
allocated chunks of the CMB. The resulting VMA can be passed only
to O_DIRECT IO on NVMe backed files or block devices. A flag is added
to GUP() in Patch 14, then Patches 15 through 17 wire this flag up based
on whether the block queue indicates P2PDMA support. Patches 18
through 20 enable the CMB to be mapped into userspace by mmaping
the nvme char device.

This is relatively straightforward, however the one significant
problem is that, presently, pci_p2pdma_map_sg() requires a homogeneous
SGL with all P2PDMA pages or all regular pages. Enhancing GUP to
support enforcing this rule would require a huge hack that I don't
expect would be all that pallatable. So the first 13 patches add
support for P2PDMA pages to dma_map_sg[table]() to the dma-direct
and dma-iommu implementations. Thus systems without an IOMMU plus
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

This series is based on v5.15-rc1. A git branch is available here:

  https://github.com/sbates130272/linux-p2pmem/  p2pdma_user_cmb_v3

Thanks,

Logan

[1] https://lkml.kernel.org/r/20210513223203.5542-1-logang@deltatee.com
[2] https://lkml.kernel.org/r/20201106170036.18713-1-logang@deltatee.com

--

Logan Gunthorpe (20):
  lib/scatterlist: add flag for indicating P2PDMA segments in an SGL
  PCI/P2PDMA: attempt to set map_type if it has not been set
  PCI/P2PDMA: make pci_p2pdma_map_type() non-static
  PCI/P2PDMA: introduce helpers for dma_map_sg implementations
  dma-mapping: allow EREMOTEIO return code for P2PDMA transfers
  dma-direct: support PCI P2PDMA pages in dma-direct map_sg
  dma-mapping: add flags to dma_map_ops to indicate PCI P2PDMA support
  iommu/dma: support PCI P2PDMA pages in dma-iommu map_sg
  nvme-pci: check DMA ops when indicating support for PCI P2PDMA
  nvme-pci: convert to using dma_map_sgtable()
  RDMA/core: introduce ib_dma_pci_p2p_dma_supported()
  RDMA/rw: use dma_map_sgtable()
  PCI/P2PDMA: remove pci_p2pdma_[un]map_sg()
  mm: introduce FOLL_PCI_P2PDMA to gate getting PCI P2PDMA pages
  iov_iter: introduce iov_iter_get_pages_[alloc_]flags()
  block: set FOLL_PCI_P2PDMA in __bio_iov_iter_get_pages()
  block: set FOLL_PCI_P2PDMA in bio_map_user_iov()
  mm: use custom page_free for P2PDMA pages
  PCI/P2PDMA: introduce pci_mmap_p2pmem()
  nvme-pci: allow mmaping the CMB in userspace

 block/bio.c                  |   8 +-
 block/blk-map.c              |   7 +-
 drivers/dax/super.c          |   7 +-
 drivers/infiniband/core/rw.c |  75 +++----
 drivers/iommu/dma-iommu.c    |  68 +++++-
 drivers/nvme/host/core.c     |  18 +-
 drivers/nvme/host/nvme.h     |   4 +-
 drivers/nvme/host/pci.c      |  98 +++++----
 drivers/nvme/target/rdma.c   |   2 +-
 drivers/pci/Kconfig          |   3 +-
 drivers/pci/p2pdma.c         | 402 +++++++++++++++++++++++++++++------
 include/linux/dma-map-ops.h  |  10 +
 include/linux/dma-mapping.h  |   5 +
 include/linux/memremap.h     |   4 +-
 include/linux/mm.h           |   2 +
 include/linux/pci-p2pdma.h   |  92 ++++++--
 include/linux/scatterlist.h  |  50 ++++-
 include/linux/uio.h          |  21 +-
 include/rdma/ib_verbs.h      |  30 +++
 include/uapi/linux/magic.h   |   1 +
 kernel/dma/direct.c          |  44 +++-
 kernel/dma/mapping.c         |  34 ++-
 lib/iov_iter.c               |  28 +--
 mm/gup.c                     |  28 ++-
 mm/huge_memory.c             |   8 +-
 mm/memory-failure.c          |   4 +-
 mm/memory_hotplug.c          |   2 +-
 mm/memremap.c                |  26 ++-
 28 files changed, 834 insertions(+), 247 deletions(-)


base-commit: 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f
--
2.30.2
