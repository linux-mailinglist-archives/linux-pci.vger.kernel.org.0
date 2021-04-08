Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFF1358A73
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 19:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhDHRBq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 13:01:46 -0400
Received: from ale.deltatee.com ([204.191.154.188]:35998 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhDHRBn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 13:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
        :references:content-disposition:in-reply-to;
        bh=Yy165qiMfoD9wU7CLZMIhX0c30z5a4gBueBDk54t1c0=; b=l3U4k9Yq7Ab3rHMmVRrXGLuL9F
        KA5oYwXOoTAUBnmx584u9OeRdYiIh9OGOOdFpZhsNK0UKDaGVBt86ZgRxp2KC1bV+aK4uvzYgcG0k
        70wJ6jtR2dBxAAoqK/Ga5s3FtdLpb1TGLPgCMj2er64H0dcya5Xz/nXpJB2KLjGYL8kaMSOsDh1bf
        mJVhd4GQlUHMlNYkhRrqk0hbMG/ypOXGbOwwKnDYVCm6FK5jABHvaIInCDtj6zzPX2v6rjeN3x26S
        ahxbZgEnmAkO6giDEjzqFx5v2QNxnzLYIVeF+kN9tSUyrPZGpZABeNmdiDkW/pGr7gDCEze+wmkcw
        Q8BaL1pw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lUY26-0002Li-Kj; Thu, 08 Apr 2021 11:01:32 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lUY20-0002Ij-Vl; Thu, 08 Apr 2021 11:01:25 -0600
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
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  8 Apr 2021 11:01:07 -0600
Message-Id: <20210408170123.8788-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT autolearn=no autolearn_force=no version=3.4.2
Subject: [PATCH 00/16] Add new DMA mapping operation for P2PDMA
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This patchset continues my work to to add P2PDMA support to the common
dma map operations. This allows for creating SGLs that have both P2PDMA
and regular pages which is a necessary step to allowing P2PDMA pages in
userspace.

The earlier RFC[1] generated a lot of great feedback and I heard no show
stopping objections. Thus, I've incorporated all the feedback and have
decided to post this as a proper patch series with hopes of eventually
getting it in mainline.

I'm happy to do a few more passes if anyone has any further feedback
or better ideas.

This series is based on v5.12-rc6 and a git branch can be found here:

  https://github.com/sbates130272/linux-p2pmem/  p2pdma_map_ops_v1

Thanks,

Logan

[1] https://lore.kernel.org/linux-block/20210311233142.7900-1-logang@deltatee.com/


Changes since the RFC:
 * Added comment and fixed up the pci_get_slot patch. (per Bjorn)
 * Fixed glaring sg_phys() double offset bug. (per Robin)
 * Created a new map operation (dma_map_sg_p2pdma()) with a new calling
   convention instead of modifying the calling convention of
   dma_map_sg(). (per Robin)
 * Integrated the two similar pci_p2pdma_dma_map_type() and
   pci_p2pdma_map_type() functions into one (per Ira)
 * Reworked some of the logic in the map_sg() implementations into
   helpers in the p2pdma code. (per Christoph)
 * Dropped a bunch of unnecessary symbol exports (per Christoph)
 * Expanded the code in dma_pci_p2pdma_supported() for clarity. (per
   Ira and Christoph)
 * Finished off using the new dma_map_sg_p2pdma() call in rdma_rw
   and removed the old pci_p2pdma_[un]map_sg(). (per Jason)

--

Logan Gunthorpe (16):
  PCI/P2PDMA: Pass gfp_mask flags to upstream_bridge_distance_warn()
  PCI/P2PDMA: Avoid pci_get_slot() which sleeps
  PCI/P2PDMA: Attempt to set map_type if it has not been set
  PCI/P2PDMA: Refactor pci_p2pdma_map_type() to take pagmap and device
  dma-mapping: Introduce dma_map_sg_p2pdma()
  lib/scatterlist: Add flag for indicating P2PDMA segments in an SGL
  PCI/P2PDMA: Make pci_p2pdma_map_type() non-static
  PCI/P2PDMA: Introduce helpers for dma_map_sg implementations
  dma-direct: Support PCI P2PDMA pages in dma-direct map_sg
  dma-mapping: Add flags to dma_map_ops to indicate PCI P2PDMA support
  iommu/dma: Support PCI P2PDMA pages in dma-iommu map_sg
  nvme-pci: Check DMA ops when indicating support for PCI P2PDMA
  nvme-pci: Convert to using dma_map_sg_p2pdma for p2pdma pages
  nvme-rdma: Ensure dma support when using p2pdma
  RDMA/rw: use dma_map_sg_p2pdma()
  PCI/P2PDMA: Remove pci_p2pdma_[un]map_sg()

 drivers/infiniband/core/rw.c |  50 +++-------
 drivers/iommu/dma-iommu.c    |  66 ++++++++++--
 drivers/nvme/host/core.c     |   3 +-
 drivers/nvme/host/nvme.h     |   2 +-
 drivers/nvme/host/pci.c      |  39 ++++----
 drivers/nvme/target/rdma.c   |   3 +-
 drivers/pci/Kconfig          |   2 +-
 drivers/pci/p2pdma.c         | 188 +++++++++++++++++++----------------
 include/linux/dma-map-ops.h  |   3 +
 include/linux/dma-mapping.h  |  20 ++++
 include/linux/pci-p2pdma.h   |  53 ++++++----
 include/linux/scatterlist.h  |  49 ++++++++-
 include/rdma/ib_verbs.h      |  32 ++++++
 kernel/dma/direct.c          |  25 ++++-
 kernel/dma/mapping.c         |  70 +++++++++++--
 15 files changed, 416 insertions(+), 189 deletions(-)


base-commit: e49d033bddf5b565044e2abe4241353959bc9120
--
2.20.1
