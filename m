Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5E23A454C
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 17:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhFKPbQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Jun 2021 11:31:16 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:36653 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbhFKPbN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jun 2021 11:31:13 -0400
Received: by mail-pg1-f182.google.com with SMTP id 27so2762095pgy.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Jun 2021 08:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xr7PRB7Hd7uTEVi/Kqqr6QruQxC5reNs5RNxGaybH98=;
        b=YSZ4LEx/9RYLf/YKEG6tawzieyj/VAOpPCm5Fm982cDV6gY8FOWSj8Iha0Cw2ygemc
         3I0c6r5KExTHw/LJYZsBJHzskVIqgxxuoNNap9FQ4XuW20PKiHcekGBx9346xteGvy0g
         PyEd4u9wNOBOko8Jf1JfFmLyPmRNUFV9L6mCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xr7PRB7Hd7uTEVi/Kqqr6QruQxC5reNs5RNxGaybH98=;
        b=WtqNA366f1NrsSmuOpnbULvCT6AMLE93ulYuYdgGSDy8612kaf/1Q1HqAJEdzOZlhK
         bBL7DXvk1gnHWVdsXCpTfpbPRmct2Ho9qxT5Q4gDlJp4MRvuPUWym0Y56r1fDMw6FcEw
         Pp8u/jATzD6nkXF6QUZqzMdwoDpzboohCT8hCh4DzhGZwIiD0NapASPKInPF18MeruZ0
         YiQfRDDLeADOBMam39csC+fGMf/AVblrwqUqorew2ho13gHM7sCIzWseh4kso05Nc24f
         Be3DqN09/Vk/Ly5N+YaayCE5Vz93W5xxQYc8lv3exbHN9rBQvwcIV/UiHE9lrDjD/Uzv
         fCXQ==
X-Gm-Message-State: AOAM532MMDseLn25WyYWIEsKLOFHnN8BgF5pqZqMIUaOKYArXE+OZhtK
        KvJ4l8FYt2PnEbJQGggMdD1CMw==
X-Google-Smtp-Source: ABdhPJxAymBN9XfurYEcX4Hnlqi/pyl7ilzdDB9Ga+mX+C72T/+t3ghcDjkBJ1DjqsKqJ9yREhHJyw==
X-Received: by 2002:a62:2682:0:b029:2f4:e1cf:9575 with SMTP id m124-20020a6226820000b02902f4e1cf9575mr8860532pfm.51.1623425295638;
        Fri, 11 Jun 2021 08:28:15 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:33c8:8e01:1161:6797])
        by smtp.gmail.com with UTF8SMTPSA id e21sm5534829pjh.55.2021.06.11.08.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 08:28:15 -0700 (PDT)
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
Subject: [PATCH v9 07/14] swiotlb: Bounce data from/to restricted DMA pool if available
Date:   Fri, 11 Jun 2021 23:26:52 +0800
Message-Id: <20210611152659.2142983-8-tientzu@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210611152659.2142983-1-tientzu@chromium.org>
References: <20210611152659.2142983-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Regardless of swiotlb setting, the restricted DMA pool is preferred if
available.

The restricted DMA pools provide a basic level of protection against the
DMA overwriting buffer contents at unexpected times. However, to protect
against general data leakage and system memory corruption, the system
needs to provide a way to lock down the memory access, e.g., MPU.

Note that is_dev_swiotlb_force doesn't check if
swiotlb_force == SWIOTLB_FORCE. Otherwise the memory allocation behavior
with default swiotlb will be changed by the following patche
("dma-direct: Allocate memory from restricted DMA pool if available").

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 include/linux/swiotlb.h | 10 +++++++++-
 kernel/dma/direct.c     |  3 ++-
 kernel/dma/direct.h     |  3 ++-
 kernel/dma/swiotlb.c    |  1 +
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 06cf17a80f5c..8200c100fe10 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -85,6 +85,7 @@ extern enum swiotlb_force swiotlb_force;
  *		unmap calls.
  * @debugfs:	The dentry to debugfs.
  * @late_alloc:	%true if allocated using the page allocator
+ * @force_swiotlb: %true if swiotlb is forced
  */
 struct io_tlb_mem {
 	phys_addr_t start;
@@ -95,6 +96,7 @@ struct io_tlb_mem {
 	spinlock_t lock;
 	struct dentry *debugfs;
 	bool late_alloc;
+	bool force_swiotlb;
 	struct io_tlb_slot {
 		phys_addr_t orig_addr;
 		size_t alloc_size;
@@ -115,6 +117,11 @@ static inline void swiotlb_set_io_tlb_default_mem(struct device *dev)
 	dev->dma_io_tlb_mem = io_tlb_default_mem;
 }
 
+static inline bool is_dev_swiotlb_force(struct device *dev)
+{
+	return dev->dma_io_tlb_mem->force_swiotlb;
+}
+
 void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
@@ -126,8 +133,9 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 {
 	return false;
 }
-static inline void swiotlb_set_io_tlb_default_mem(struct device *dev)
+static inline bool is_dev_swiotlb_force(struct device *dev)
 {
+	return false;
 }
 static inline void swiotlb_exit(void)
 {
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 7a88c34d0867..078f7087e466 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -496,7 +496,8 @@ size_t dma_direct_max_mapping_size(struct device *dev)
 {
 	/* If SWIOTLB is active, use its maximum mapping size */
 	if (is_swiotlb_active(dev) &&
-	    (dma_addressing_limited(dev) || swiotlb_force == SWIOTLB_FORCE))
+	    (dma_addressing_limited(dev) || swiotlb_force == SWIOTLB_FORCE ||
+	     is_dev_swiotlb_force(dev)))
 		return swiotlb_max_mapping_size(dev);
 	return SIZE_MAX;
 }
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 13e9e7158d94..f94813674e23 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -87,7 +87,8 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
 	phys_addr_t phys = page_to_phys(page) + offset;
 	dma_addr_t dma_addr = phys_to_dma(dev, phys);
 
-	if (unlikely(swiotlb_force == SWIOTLB_FORCE))
+	if (unlikely(swiotlb_force == SWIOTLB_FORCE) ||
+	    is_dev_swiotlb_force(dev))
 		return swiotlb_map(dev, phys, size, dir, attrs);
 
 	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 21e99907edd6..e5ccc198d0a7 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -714,6 +714,7 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 			return -ENOMEM;
 
 		swiotlb_init_io_tlb_mem(mem, rmem->base, nslabs, false, true);
+		mem->force_swiotlb = true;
 
 		rmem->priv = mem;
 
-- 
2.32.0.272.g935e593368-goog

