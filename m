Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EF95A1597
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 17:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiHYPY6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 11:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241961AbiHYPYp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 11:24:45 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5257CB99DE;
        Thu, 25 Aug 2022 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
        :references:content-disposition:in-reply-to;
        bh=g3XDA94v59dAId+VCT21K3CqqFYOQAY4xEZRniu4BfM=; b=XCtmLgBIKjcsXvDqzCKuqQL1p0
        Kwi9VCS0IBQPYm/0K/UUyBXFORRZe1FYcoKVh84+mAB7dtCZQrSnRwRsxkrMH2tzIz+JgpM5SGlBY
        SG+BPAfLy2+Zv52MHX7Wd/phN/9eqWLxhCGu0qoZqoutEbNvF+WtZWZvLMxryxO81L+whZWQ7vWlh
        4j5At+Q3ZufRbidAw0d/DKFCe2hcx3aUee6gyfhX71tZTH+8mEO2ZAhB9UrPP9zqabfWu4n1ts4Pv
        Au7XaqgSjun1Lc1/HPMBP2WFCRpiDhoR7eBy0yWdcqWCvVjvARAewmA/sKBK/KpjEe5rxKKG9IM0O
        Wx/OOoKw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oREij-0086M8-QV; Thu, 25 Aug 2022 09:24:39 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oREid-0001eT-Pd; Thu, 25 Aug 2022 09:24:31 -0600
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
Date:   Thu, 25 Aug 2022 09:24:17 -0600
Message-Id: <20220825152425.6296-1-logang@deltatee.com>
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH v9 0/8] Userspace P2PDMA with O_DIRECT NVMe devices
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This is the latest P2PDMA userspace patch set. Since the last full
posting[1] the first half of the series[2] has made it into v6.0-rc1.

This version of the patchset also switches to using a sysfs binary
file instead of mmapping the nvme char device directly. This
removes the need for the anonymous inode as well as the numerous
hooks into the nvme driver. The file to mmap will be found in
/sys/<pci_device>/p2pmem/allocate. The latest version of this patch
set is much smaller as a result of these simplifications.

This patch set enables userspace P2PDMA by allowing userspace to mmap()
allocated chunks of the CMB. The resulting VMA can be passed only
to O_DIRECT IO on NVMe backed files or block devices. A flag is added
to GUP() in Patch 1, then Patches 2 through 6 wire this flag up based
on whether the block queue indicates P2PDMA support. Patches 7
creates the sysfs resource that can hand out the VMAs and Patch 8
adds brief documentation for the new interface.

Feedback welcome.

This series is based on v6.0-rc2. A git branch is available here:

  https://github.com/sbates130272/linux-p2pmem/  p2pdma_user_cmb_v9

Thanks,

Logan

[1] https://lkml.kernel.org/r/20220615161233.17527-1-logang@deltatee.com
[2] https://lkml.kernel.org/r/20220708165104.5005-1-logang@deltatee.com

--

Changes since v7:
  - Rebase onto v6.0-rc2, included reworking the iov_iter patch
    due to changes there
  - Drop the char device mmap implementation in favour of a sysfs
    based interface. (per Christoph)

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


--

Logan Gunthorpe (8):
  mm: introduce FOLL_PCI_P2PDMA to gate getting PCI P2PDMA pages
  iov_iter: introduce iov_iter_get_pages_[alloc_]flags()
  block: add check when merging zone device pages
  lib/scatterlist: add check when merging zone device pages
  block: set FOLL_PCI_P2PDMA in __bio_iov_iter_get_pages()
  block: set FOLL_PCI_P2PDMA in bio_map_user_iov()
  PCI/P2PDMA: Allow userspace VMA allocations through sysfs
  ABI: sysfs-bus-pci: add documentation for p2pmem allocate

 Documentation/ABI/testing/sysfs-bus-pci |  12 ++-
 block/bio.c                             |  12 ++-
 block/blk-map.c                         |   7 +-
 drivers/pci/p2pdma.c                    | 124 ++++++++++++++++++++++++
 include/linux/mm.h                      |   1 +
 include/linux/mmzone.h                  |  24 +++++
 include/linux/uio.h                     |   6 ++
 lib/iov_iter.c                          |  40 +++++++-
 lib/scatterlist.c                       |  25 +++--
 mm/gup.c                                |  22 ++++-
 10 files changed, 254 insertions(+), 19 deletions(-)


base-commit: 1c23f9e627a7b412978b4e852793c5e3c3efc555
--
2.30.2
