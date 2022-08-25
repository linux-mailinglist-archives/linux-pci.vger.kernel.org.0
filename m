Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B2D5A1592
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 17:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242076AbiHYPZE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 11:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241972AbiHYPYp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 11:24:45 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBABB95B5;
        Thu, 25 Aug 2022 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=Zco/cq2uLRvV+s+4HkHZAZF2wQKOR8FuVA8Uucgnt08=; b=ECzpmWpGfFN3FSN3MXglMySWFq
        2/AyvUP5mc5dsTnuux+42Fb10+vKI4gPCs10aAmDZbYoZBwUmNwUGysjQ2BuYBQpsvZ9MWElt96CC
        bBjlqVLRj+av4OPvi1lgmo3s95qcB+a6q7ZpddFxRXCVbyQ00iLx/6NcZwRINyXwJUl/6x3FaBCFo
        J8pPdkOHtrhU+wGWGLJdb2zwmskLsaqFcwcodC4kLN7+M30fYzYMaIm8+MCZlyrayUO/+R1Znp3oy
        EiQoV2+fW6SxljxTyfuMnJ+vpiDzNUKchWev7FIQaywEwCZgXQU09yjQLzpHaoy4OsXgKoRj5NCXN
        Esl7IF9A==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oREik-0086M9-On; Thu, 25 Aug 2022 09:24:39 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oREif-0001es-0Y; Thu, 25 Aug 2022 09:24:33 -0600
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
Date:   Thu, 25 Aug 2022 09:24:25 -0600
Message-Id: <20220825152425.6296-9-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220825152425.6296-1-logang@deltatee.com>
References: <20220825152425.6296-1-logang@deltatee.com>
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
Subject: [PATCH v9 8/8] ABI: sysfs-bus-pci: add documentation for p2pmem allocate
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add documentation for the p2pmem/allocate binary file which allows
for allocating p2pmem buffers in userspace for passing to drivers
that support them. (Currently only O_DIRECT to NVMe devices.)

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 6fc2c2efe8ab..dca5e032b4fa 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -171,7 +171,7 @@ Description:
 		binary file containing the Vital Product Data for the
 		device.  It should follow the VPD format defined in
 		PCI Specification 2.1 or 2.2, but users should consider
-		that some devices may have incorrectly formatted data.  
+		that some devices may have incorrectly formatted data.
 		If the underlying VPD has a writable section then the
 		corresponding section of this file will be writable.
 
@@ -407,6 +407,16 @@ Description:
 	        file contains a '1' if the memory has been published for
 		use outside the driver that owns the device.
 
+What:		/sys/bus/pci/devices/.../p2pmem/allocate
+Date:		August 2022
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:
+		Thes attribute allows mapping p2pmem into userspace. For
+		each mmap() call on this file, the kernel will allocate
+		a chunk of Peer-to-Peer memory for use in Peer-to-Peer
+		transactions. This memory can be used in O_DIRECT calls
+		to NVMe backed files for Peer-to-Peer copies.
+
 What:		/sys/bus/pci/devices/.../link/clkpm
 		/sys/bus/pci/devices/.../link/l0s_aspm
 		/sys/bus/pci/devices/.../link/l1_aspm
-- 
2.30.2

