Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6D42A9A35
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 18:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgKFRBN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 12:01:13 -0500
Received: from ale.deltatee.com ([204.191.154.188]:57964 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgKFRBH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 12:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zPFpNgiugVQ+xdbkGSN+0eJClV8q4n6t0btTMsXElBs=; b=Iz1KSxmqkSDBJvFrjXSKdYsP0w
        JoIPvPZhAvmvTc2lXaxFt1bgKacOe7+FyScP8rRK1wl72/MIYfdhmd4S8VHDuTM2a9RT80bboSZxU
        kInz2blm2LfIetmFOS+pFz2ZDumaZk+B9kKpHPAfHLHHxPop8H/AQU+J+22clDSdPbXw2xOsKL/p6
        JDjN3eygxLT19oFLKyMdyqSp6POAyRPc2QdRw/g2hPAV00HljzjTCSURL1tmZ5epJ/uxTfgIhDucM
        wm5frCa9+aQ85atixSw3Vjo1ZyL2Gdtti8z/+t0xacAhMPtnxcTiXLx33IwyE9VGqxJPdcsJBpRF3
        u5Y8wxiQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kb56j-0002PW-HZ; Fri, 06 Nov 2020 10:01:06 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kb56U-0004t5-OR; Fri, 06 Nov 2020 10:00:46 -0700
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
Date:   Fri,  6 Nov 2020 10:00:27 -0700
Message-Id: <20201106170036.18713-7-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106170036.18713-1-logang@deltatee.com>
References: <20201106170036.18713-1-logang@deltatee.com>
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
Subject: [RFC PATCH 06/15] dma-mapping: Add flags to dma_map_ops to indicate PCI P2PDMA support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a flags member to the dma_map_ops structure with one flag to
indicate support for PCI P2PDMA.

Also, add a helper to check if a device supports PCI P2PDMA.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/dma-map-ops.h | 3 +++
 include/linux/dma-mapping.h | 5 +++++
 kernel/dma/mapping.c        | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index a5f89fc4d6df..8c12dfa43ce1 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -12,6 +12,9 @@
 struct cma;
 
 struct dma_map_ops {
+	unsigned int flags;
+#define DMA_F_PCI_P2PDMA_SUPPORTED     (1 << 0)
+
 	void *(*alloc)(struct device *dev, size_t size,
 			dma_addr_t *dma_handle, gfp_t gfp,
 			unsigned long attrs);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 8d028e15b531..3646c6ba6a00 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -149,6 +149,7 @@ int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 		unsigned long attrs);
 bool dma_can_mmap(struct device *dev);
 int dma_supported(struct device *dev, u64 mask);
+int dma_pci_p2pdma_supported(struct device *dev);
 int dma_set_mask(struct device *dev, u64 mask);
 int dma_set_coherent_mask(struct device *dev, u64 mask);
 u64 dma_get_required_mask(struct device *dev);
@@ -244,6 +245,10 @@ static inline int dma_supported(struct device *dev, u64 mask)
 {
 	return 0;
 }
+static inline int dma_pci_p2pdma_supported(struct device *dev)
+{
+	return 0;
+}
 static inline int dma_set_mask(struct device *dev, u64 mask)
 {
 	return -EIO;
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 51bb8fa8eb89..192418ef43f8 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -567,6 +567,14 @@ int dma_supported(struct device *dev, u64 mask)
 }
 EXPORT_SYMBOL(dma_supported);
 
+int dma_pci_p2pdma_supported(struct device *dev)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	return !ops || ops->flags & DMA_F_PCI_P2PDMA_SUPPORTED;
+}
+EXPORT_SYMBOL(dma_pci_p2pdma_supported);
+
 #ifdef CONFIG_ARCH_HAS_DMA_SET_MASK
 void arch_dma_set_mask(struct device *dev, u64 mask);
 #else
-- 
2.20.1

