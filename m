Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4B03381D6
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 00:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhCKXtD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 18:49:03 -0500
Received: from ale.deltatee.com ([204.191.154.188]:52526 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhCKXsu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 18:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
        :references:content-disposition:in-reply-to;
        bh=kE7unqHb96tgCLiqAy7oTQD9QBaPCBADwUUVoF85ezA=; b=NgonvtaxHynX26gURA+2WbVFF7
        EdmjT2rJo+H+u9pFbAy9IsACHfULVpJDenz/wZp/uIJ7n11VpJ4PmS3Bye0OakNE8a74IZjm9kiZr
        HmCO0vtzmtENVocWjr8J6ARILinTKOBgkFxrQ2/zoJCo5nIyXNy4Bnqyn7uw0M3TDFbsPJBGNThgo
        y9SPPR7K0JweAHZs5X2Ib7iIZBz6T/pQNeEPzLNj+SbWX0fVWQ2YUJ0etkvfvadDo6kE5IIEVbp8y
        R1+iSUFNpi7MQb8lTFwrflPLEtzmvEAkRYK/jnMRPh29G2joRkm0gvJhU1WPsT4owdgClS4/omxu5
        9EE77grw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lKUmZ-0003eq-Rw; Thu, 11 Mar 2021 16:32:15 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lKUmV-00024K-OI; Thu, 11 Mar 2021 16:31:51 -0700
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
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 11 Mar 2021 16:31:30 -0700
Message-Id: <20210311233142.7900-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, dan.j.williams@intel.com, iweiny@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT,MYRULES_URI_HASH autolearn=no autolearn_force=no
        version=3.4.2
Subject: [RFC PATCH v2 00/11] Add support to dma_map_sg for P2PDMA
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This is a rework of the first half of my RFC for doing P2PDMA in userspace
with O_DIRECT[1].

The largest issue with that series was the gross way of flagging P2PDMA
SGL segments. This RFC proposes a different approach, (suggested by
Dan Williams[2]) which uses the third bit in the page_link field of the
SGL.

This approach is a lot less hacky but comes at the cost of adding a
CONFIG_64BIT dependency to CONFIG_PCI_P2PDMA and using up the last
scarce bit in the page_link. For our purposes, a 64BIT restriction is
acceptable but it's not clear if this is ok for all usecases hoping
to make use of P2PDMA.

Matthew Wilcox has already suggested (off-list) that this is the wrong
approach, preferring a new dma mapping operation and an SGL replacement. I
don't disagree that something along those lines would be a better long
term solution, but it involves overcoming a lot of challenges to get
there. Creating a new mapping operation still means adding support to more
than 25 dma_map_ops implementations (many of which are on obscure
architectures) or creating a redundant path to fallback with dma_map_sg()
for every driver that uses the new operation. This RFC is an approach
that doesn't require overcoming these blocks.

Any alternative ideas or feedback is welcome.

These patches are based on v5.12-rc2 and a git branch is available here:

  https://github.com/sbates130272/linux-p2pmem/  p2pdma_dma_map_ops_rfc

A branch with the patches from the previous RFC that add userspace
O_DIRECT support is available at the same URL with the name
"p2pdma_dma_map_ops_rfc+user" (however, none of the issues with those
extra patches from the feedback of the last posting have been fixed).

Thanks,

Logan

[1] https://lore.kernel.org/linux-block/20201106170036.18713-1-logang@deltatee.com/
[2] https://lore.kernel.org/linux-block/CAPcyv4ifGcrdOtUt8qr7pmFhmecGHqGVre9G0RorGczCGVECQQ@mail.gmail.com/

--

Logan Gunthorpe (11):
  PCI/P2PDMA: Pass gfp_mask flags to upstream_bridge_distance_warn()
  PCI/P2PDMA: Avoid pci_get_slot() which sleeps
  PCI/P2PDMA: Attempt to set map_type if it has not been set
  PCI/P2PDMA: Introduce pci_p2pdma_should_map_bus() and
    pci_p2pdma_bus_offset()
  lib/scatterlist: Add flag for indicating P2PDMA segments in an SGL
  dma-direct: Support PCI P2PDMA pages in dma-direct map_sg
  dma-mapping: Add flags to dma_map_ops to indicate PCI P2PDMA support
  iommu/dma: Support PCI P2PDMA pages in dma-iommu map_sg
  block: Add BLK_STS_P2PDMA
  nvme-pci: Check DMA ops when indicating support for PCI P2PDMA
  nvme-pci: Convert to using dma_map_sg for p2pdma pages

 block/blk-core.c            |  2 +
 drivers/iommu/dma-iommu.c   | 63 +++++++++++++++++++++-----
 drivers/nvme/host/core.c    |  3 +-
 drivers/nvme/host/nvme.h    |  2 +-
 drivers/nvme/host/pci.c     | 38 +++++++---------
 drivers/pci/Kconfig         |  2 +-
 drivers/pci/p2pdma.c        | 89 +++++++++++++++++++++++++++++++------
 include/linux/blk_types.h   |  7 +++
 include/linux/dma-map-ops.h |  3 ++
 include/linux/dma-mapping.h |  5 +++
 include/linux/pci-p2pdma.h  | 11 +++++
 include/linux/scatterlist.h | 49 ++++++++++++++++++--
 kernel/dma/direct.c         | 35 +++++++++++++--
 kernel/dma/mapping.c        | 21 +++++++--
 14 files changed, 271 insertions(+), 59 deletions(-)


base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
--
2.20.1
