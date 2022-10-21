Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A9B607DB9
	for <lists+linux-pci@lfdr.de>; Fri, 21 Oct 2022 19:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiJURlf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Oct 2022 13:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiJURla (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Oct 2022 13:41:30 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F414324AE3C;
        Fri, 21 Oct 2022 10:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
        :references:content-disposition:in-reply-to;
        bh=nF0SVUXmUm6/1jQhAiGtVkXjqXLugkxBCw1H6lsq9qw=; b=kAAkNydFPlQ84zWbqcIf6HYHWw
        swriGADMx3GagNeM2QyZOZagVVUqkxGVMUP+thgek92nyZqj/nN+tAEQK++PGuuoctMWY7q1X57ex
        YZ2My7wYnjj8Zk0+4XR1miPNQHBm/khken5A0/4BCVp3HT02+NvGZbh5Q3SXn1r3GqjvJFNhXrphm
        28Gro+M5SHbcfCJ4skRzMSah8NQ1cVbBRqLsjR/6Jp3gMKUCuIfTtFnZyWnLBrek+WNqKAZsghIX7
        NX/kmablgeZJ2HhcxDrHbzJHJsfxJl5MKmQDtTB2kmrQWMJfF4EmYhAKFHZnzohfJy1BnP16QVC/c
        WXH1a7vA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1olw1I-00DoHx-T9; Fri, 21 Oct 2022 11:41:22 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1olw1F-0001t4-HC; Fri, 21 Oct 2022 11:41:17 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 21 Oct 2022 11:41:07 -0600
Message-Id: <20221021174116.7200-1-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, gregkh@linuxfoundation.org, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v11 0/9] Userspace P2PDMA with O_DIRECT NVMe devices
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This is the latest P2PDMA userspace patch set. This version includes
some cleanup from feedback from the last posting[1].

This patch set enables userspace P2PDMA by allowing userspace to mmap()
allocated chunks of the CMB. The resulting VMA can be passed only
to O_DIRECT IO on NVMe backed files or block devices. A flag is added
to GUP() in Patch 1, then Patches 2 through 6 wire this flag up based
on whether the block queue indicates P2PDMA support. Patches 7
creates the sysfs resource that can hand out the VMAs and Patch 8
adds brief documentation for the new interface.

Feedback welcome.

This series is based on v6.1-rc1. A git branch is available here:

  https://github.com/sbates130272/linux-p2pmem/  p2pdma_user_cmb_v11

Thanks,

Logan

[1] https://lkml.kernel.org/r/20220922163926.7077-1-logang@deltatee.com

--

Changes in v11:
  - Rebased onto v6.1-rc1, fixed minor conflict in bio_map_user_iov
  - The GUP test was moved to try_grab_page() and try_grab_folio().
    This ought to be a bit more future proof. It required adding a new
    cleanup patch to return a proper error code from try_grab_page().
    (Per Jason)

Changes in v10:
  - Rebased onto v6.0-rc6
  - Reworked iov iter changes to reuse the code better and
    name them without the _flags() prefix (per Christoph)
  - Renamed a number of flags variables to gup_flags (per John)
  - Minor fixups to the last documentation patch (from Greg and John)

Changes in v9:
  - Rebased onto v6.0-rc2, included reworking the iov_iter patch
    due to changes there
  - Drop the char device mmap implementation in favour of a sysfs
    based interface. (per Christoph)

 (v8 only included the first half of the series and was merged for v6.0)

Changes in v8:
  - Rebase onto v5.19-rc1
  - Rework how the pages are stored in the VMA per Jason's suggestion

Changes in v7:
  - Rebased onto v5.18-rc1 which includes Christophs cleanup to
    free_zone_device_page() (similar to Ralph's patch).
  - Fix bug with concurrent first calls to pci_p2pdma_vma_fault()
    that caused a double allocation and lost p2p memory. Noticed
    by Andrew Maier.
  - Collected a Reviewed-by tag from Chaitanya.
  - Numerous minor fixes to commit messages

--

Logan Gunthorpe (9):
  mm: allow multiple error returns in try_grab_page()
  mm: introduce FOLL_PCI_P2PDMA to gate getting PCI P2PDMA pages
  iov_iter: introduce iov_iter_get_pages_[alloc_]flags()
  block: add check when merging zone device pages
  lib/scatterlist: add check when merging zone device pages
  block: set FOLL_PCI_P2PDMA in __bio_iov_iter_get_pages()
  block: set FOLL_PCI_P2PDMA in bio_map_user_iov()
  PCI/P2PDMA: Allow userspace VMA allocations through sysfs
  ABI: sysfs-bus-pci: add documentation for p2pmem allocate

 Documentation/ABI/testing/sysfs-bus-pci |  10 ++
 block/bio.c                             |  11 ++-
 block/blk-map.c                         |  12 ++-
 drivers/pci/p2pdma.c                    | 124 ++++++++++++++++++++++++
 include/linux/mm.h                      |   3 +-
 include/linux/mmzone.h                  |  24 +++++
 include/linux/uio.h                     |   6 ++
 lib/iov_iter.c                          |  32 ++++--
 lib/scatterlist.c                       |  25 +++--
 mm/gup.c                                |  45 ++++++---
 mm/huge_memory.c                        |  19 ++--
 mm/hugetlb.c                            |  23 +++--
 12 files changed, 280 insertions(+), 54 deletions(-)


base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
--
2.30.2
