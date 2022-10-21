Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82195607DB3
	for <lists+linux-pci@lfdr.de>; Fri, 21 Oct 2022 19:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiJURld (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Oct 2022 13:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJURl3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Oct 2022 13:41:29 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C1824AE32;
        Fri, 21 Oct 2022 10:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=33I13543xxl5IpRI3N6CO97FrUmYnw9CKJFJpgwPP2E=; b=bgCCyiC80LwkdXBnalAtI8yTWC
        4nCSWE1U2A1ySvyPV3WkvbtPKmCdf5mIA7Kn9LFX8StLBBLZtBnaer7mg65tIOxxPBIxYj1KvJfIL
        rWHBMfhn6BFIT2AutDopBuI2boeRuUmArJD+P8KpIHv+884xkRV8HDqdscPhcci0Ffdi6HQR+LUMe
        3fTYi/Cr1SNAX/on0Le/wYgZ+EGvo9nM+tQeNLdYZpAMIkAOBTEtQfuUKhSALmiiVnPPx/nRSZC2+
        qHzqF6KPUU4VTfcmUsz/jBWXiTnpwR40Qs+fltLB8upyLUJLFBnOw+QnXJI+tf9tvSD1VBHwJy4SU
        hSNPQy5Q==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1olw1K-00DoHz-5A; Fri, 21 Oct 2022 11:41:23 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1olw1G-0001tV-Es; Fri, 21 Oct 2022 11:41:18 -0600
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
Date:   Fri, 21 Oct 2022 11:41:16 -0600
Message-Id: <20221021174116.7200-10-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221021174116.7200-1-logang@deltatee.com>
References: <20221021174116.7200-1-logang@deltatee.com>
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
Subject: [PATCH v11 9/9] ABI: sysfs-bus-pci: add documentation for p2pmem allocate
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add documentation for the p2pmem/allocate binary file which allows
for allocating p2pmem buffers in userspace for passing to drivers
that support them. (Currently only O_DIRECT to NVMe devices.)

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/ABI/testing/sysfs-bus-pci | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 840727fc75dc..ecf47559f495 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -407,6 +407,16 @@ Description:
 	        file contains a '1' if the memory has been published for
 		use outside the driver that owns the device.
 
+What:		/sys/bus/pci/devices/.../p2pmem/allocate
+Date:		August 2022
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:
+		This file allows mapping p2pmem into userspace. For each
+		mmap() call on this file, the kernel will allocate a chunk
+		of Peer-to-Peer memory for use in Peer-to-Peer transactions.
+		This memory can be used in O_DIRECT calls to NVMe backed
+		files for Peer-to-Peer copies.
+
 What:		/sys/bus/pci/devices/.../link/clkpm
 		/sys/bus/pci/devices/.../link/l0s_aspm
 		/sys/bus/pci/devices/.../link/l1_aspm
-- 
2.30.2

