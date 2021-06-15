Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC363A7F83
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 15:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhFONaa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 09:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbhFONaU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jun 2021 09:30:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9828C0613A4
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 06:28:15 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s17-20020a17090a8811b029016e89654f93so1812883pjn.1
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 06:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gECPOPsCtEK5Wckt8RcLyHfozwB/E+EP94LARsjIoQM=;
        b=mPVHkLymWWoJ5FXza4lDdJkjRkkGCCIqZROcG/jPVhk85ennw8Lh8afIhfaPbKo5fw
         xPoOamL8LmyrImoT77PgcPoa1udPeAWbdwayu1G1kJioGMIeK2BCidzwj4454R/AYVbe
         p31PisuhVJxV7c4fEx4O7jr/Zump68KiUpmW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gECPOPsCtEK5Wckt8RcLyHfozwB/E+EP94LARsjIoQM=;
        b=qLYpsGe9DvkjwGlVaPP36fCC0NUwBJwbn9l86U1+s28OeOWnlZAz/2zBb4J7HJZc3L
         TcmK0Gc7zAbKKi8PrOMyc9pLyKW8YqNxgw4feKnCtmnwk9wJYFqXfpKdtSEOC8qhgsAq
         Q+rRg+4U/v/Tuv1EPhbX0bpMJVNHEtrhbvaNtzzQdUgv8i3A2tALs5FEXXxykTFzkgHN
         VO11BbcOIXjsVsHAtt6xo01QrBKZoj9zSNS7NUL1tHEevT4ZswiMcZn0FpOnnovrHtVo
         VY7MGkBzb4Chbolnlm84kkOIB/dcLqF5bUQwVw6jEAh07C/39OjvBtNWiXY7dzIYqt4A
         9SFA==
X-Gm-Message-State: AOAM532qLJ2ip9EV1tXLB34RXuyQ4vXS5BpSOWV51Zg9G3IM/dPkne3S
        8urY66O38usOuTMMsJGtoNLRRg==
X-Google-Smtp-Source: ABdhPJwap5O4zLmEMY+RUjCuo1vguR5XAd/2u88H1tpc55JUzosxwbsWkllIYJMBsZxK3z6SxqvnHg==
X-Received: by 2002:a17:90a:fe18:: with SMTP id ck24mr5167618pjb.158.1623763695284;
        Tue, 15 Jun 2021 06:28:15 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:1846:5274:e444:139e])
        by smtp.gmail.com with UTF8SMTPSA id q145sm8796577pfc.60.2021.06.15.06.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 06:28:14 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>, tfiga@chromium.org,
        bskeggs@redhat.com, bhelgaas@google.com, chris@chris-wilson.co.uk,
        tientzu@chromium.org, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, jxgao@google.com,
        joonas.lahtinen@linux.intel.com, linux-pci@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
        rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com
Subject: [PATCH v10 06/12] swiotlb: Use is_dev_swiotlb_force for swiotlb data bouncing
Date:   Tue, 15 Jun 2021 21:27:05 +0800
Message-Id: <20210615132711.553451-7-tientzu@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210615132711.553451-1-tientzu@chromium.org>
References: <20210615132711.553451-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Propagate the swiotlb_force setting into io_tlb_default_mem->force and
use it to determine whether to bounce the data or not. This will be
useful later to allow for different pools.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 include/linux/swiotlb.h | 11 +++++++++++
 kernel/dma/direct.c     |  2 +-
 kernel/dma/direct.h     |  2 +-
 kernel/dma/swiotlb.c    |  4 ++++
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index dd1c30a83058..efcd56e3a16c 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -84,6 +84,7 @@ extern enum swiotlb_force swiotlb_force;
  *		unmap calls.
  * @debugfs:	The dentry to debugfs.
  * @late_alloc:	%true if allocated using the page allocator
+ * @force:      %true if swiotlb is forced
  */
 struct io_tlb_mem {
 	phys_addr_t start;
@@ -94,6 +95,7 @@ struct io_tlb_mem {
 	spinlock_t lock;
 	struct dentry *debugfs;
 	bool late_alloc;
+	bool force;
 	struct io_tlb_slot {
 		phys_addr_t orig_addr;
 		size_t alloc_size;
@@ -109,6 +111,11 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 	return mem && paddr >= mem->start && paddr < mem->end;
 }
 
+static inline bool is_dev_swiotlb_force(struct device *dev)
+{
+	return dev->dma_io_tlb_mem->force;
+}
+
 void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
@@ -120,6 +127,10 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 {
 	return false;
 }
+static inline bool is_dev_swiotlb_force(struct device *dev)
+{
+	return false;
+}
 static inline void swiotlb_exit(void)
 {
 }
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 7a88c34d0867..3713461d6fe0 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -496,7 +496,7 @@ size_t dma_direct_max_mapping_size(struct device *dev)
 {
 	/* If SWIOTLB is active, use its maximum mapping size */
 	if (is_swiotlb_active(dev) &&
-	    (dma_addressing_limited(dev) || swiotlb_force == SWIOTLB_FORCE))
+	    (dma_addressing_limited(dev) || is_dev_swiotlb_force(dev)))
 		return swiotlb_max_mapping_size(dev);
 	return SIZE_MAX;
 }
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 13e9e7158d94..6c4d13caceb1 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -87,7 +87,7 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
 	phys_addr_t phys = page_to_phys(page) + offset;
 	dma_addr_t dma_addr = phys_to_dma(dev, phys);
 
-	if (unlikely(swiotlb_force == SWIOTLB_FORCE))
+	if (is_dev_swiotlb_force(dev))
 		return swiotlb_map(dev, phys, size, dir, attrs);
 
 	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index d07e32020edf..5af47a8f68b8 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -179,6 +179,10 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 	mem->end = mem->start + bytes;
 	mem->index = 0;
 	mem->late_alloc = late_alloc;
+
+	if (swiotlb_force == SWIOTLB_FORCE)
+		mem->force = true;
+
 	spin_lock_init(&mem->lock);
 	for (i = 0; i < mem->nslabs; i++) {
 		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
-- 
2.32.0.272.g935e593368-goog

