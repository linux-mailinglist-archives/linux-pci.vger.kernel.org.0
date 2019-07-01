Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5FA43DCC
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 17:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbfFMPpP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 11:45:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731804AbfFMJnu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 05:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=U+naUp6GJ2c/vfJkCwMO0IpliZVzAgQ1geAwtt/0bck=; b=QwHN3Ivc9/431JjZXwTTSF08rO
        hXrz9haLO+d9Q3IUHfpmJTWlt7YXy/NmVHDKKTD/S+hOE4Iu0sImh3ze2ah7uPgw3Ei9X4uKveyn/
        nsmcYq0LFNlYJpg+2os1UWxfhf/0nIJoqy+Sw+YSOCSsLRjhEfzfdB5pljAfNGKYcC0tMcDPRgbPE
        fc5wdASA11vbKRHWzIsWFALeW2JqScCVdyapFn6VpyWwynpkuTmK8WBHg8NlvHxlGwpmm3SGTXN+Q
        yYignYCrY/T0XlMl97q/6sfhwXRxvc26NXzsHK9MeWjhS6x6hjc2xLbTs1LjAwLCYlTdNCmJxrgk4
        fOpj7qYg==;
Received: from mpp-cp1-natpool-1-198.ethz.ch ([82.130.71.198] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbMGo-0001lZ-Cj; Thu, 13 Jun 2019 09:43:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/22] mm: factor out a devm_request_free_mem_region helper
Date:   Thu, 13 Jun 2019 11:43:09 +0200
Message-Id: <20190613094326.24093-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613094326.24093-1-hch@lst.de>
References: <20190613094326.24093-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Keep the physical address allocation that hmm_add_device does with the
rest of the resource code, and allow future reuse of it without the hmm
wrapper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/ioport.h |  2 ++
 kernel/resource.c      | 39 +++++++++++++++++++++++++++++++++++++++
 mm/hmm.c               | 33 ++++-----------------------------
 3 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index da0ebaec25f0..76a33ae3bf6c 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -286,6 +286,8 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
        return (r1->start <= r2->end && r1->end >= r2->start);
 }
 
+struct resource *devm_request_free_mem_region(struct device *dev,
+		struct resource *base, unsigned long size);
 
 #endif /* __ASSEMBLY__ */
 #endif	/* _LINUX_IOPORT_H */
diff --git a/kernel/resource.c b/kernel/resource.c
index 158f04ec1d4f..99c58134ed1c 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1628,6 +1628,45 @@ void resource_list_free(struct list_head *head)
 }
 EXPORT_SYMBOL(resource_list_free);
 
+#ifdef CONFIG_DEVICE_PRIVATE
+/**
+ * devm_request_free_mem_region - find free region for device private memory
+ *
+ * @dev: device struct to bind the resource too
+ * @size: size in bytes of the device memory to add
+ * @base: resource tree to look in
+ *
+ * This function tries to find an empty range of physical address big enough to
+ * contain the new resource, so that it can later be hotpluged as ZONE_DEVICE
+ * memory, which in turn allocates struct pages.
+ */
+struct resource *devm_request_free_mem_region(struct device *dev,
+		struct resource *base, unsigned long size)
+{
+	resource_size_t end, addr;
+	struct resource *res;
+
+	size = ALIGN(size, 1UL << PA_SECTION_SHIFT);
+	end = min_t(unsigned long, base->end, (1UL << MAX_PHYSMEM_BITS) - 1);
+	addr = end - size + 1UL;
+
+	for (; addr > size && addr >= base->start; addr -= size) {
+		if (region_intersects(addr, size, 0, IORES_DESC_NONE) !=
+				REGION_DISJOINT)
+			continue;
+
+		res = devm_request_mem_region(dev, addr, size, dev_name(dev));
+		if (!res)
+			return ERR_PTR(-ENOMEM);
+		res->desc = IORES_DESC_DEVICE_PRIVATE_MEMORY;
+		return res;
+	}
+
+	return ERR_PTR(-ERANGE);
+}
+EXPORT_SYMBOL_GPL(devm_request_free_mem_region);
+#endif /* CONFIG_DEVICE_PRIVATE */
+
 static int __init strict_iomem(char *str)
 {
 	if (strstr(str, "relaxed"))
diff --git a/mm/hmm.c b/mm/hmm.c
index e1dc98407e7b..13a16faf0a77 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -26,8 +26,6 @@
 #include <linux/mmu_notifier.h>
 #include <linux/memory_hotplug.h>
 
-#define PA_SECTION_SIZE (1UL << PA_SECTION_SHIFT)
-
 #if IS_ENABLED(CONFIG_HMM_MIRROR)
 static const struct mmu_notifier_ops hmm_mmu_notifier_ops;
 
@@ -1372,7 +1370,6 @@ struct hmm_devmem *hmm_devmem_add(const struct hmm_devmem_ops *ops,
 				  unsigned long size)
 {
 	struct hmm_devmem *devmem;
-	resource_size_t addr;
 	void *result;
 	int ret;
 
@@ -1398,32 +1395,10 @@ struct hmm_devmem *hmm_devmem_add(const struct hmm_devmem_ops *ops,
 	if (ret)
 		return ERR_PTR(ret);
 
-	size = ALIGN(size, PA_SECTION_SIZE);
-	addr = min((unsigned long)iomem_resource.end,
-		   (1UL << MAX_PHYSMEM_BITS) - 1);
-	addr = addr - size + 1UL;
-
-	/*
-	 * FIXME add a new helper to quickly walk resource tree and find free
-	 * range
-	 *
-	 * FIXME what about ioport_resource resource ?
-	 */
-	for (; addr > size && addr >= iomem_resource.start; addr -= size) {
-		ret = region_intersects(addr, size, 0, IORES_DESC_NONE);
-		if (ret != REGION_DISJOINT)
-			continue;
-
-		devmem->resource = devm_request_mem_region(device, addr, size,
-							   dev_name(device));
-		if (!devmem->resource)
-			return ERR_PTR(-ENOMEM);
-		break;
-	}
-	if (!devmem->resource)
-		return ERR_PTR(-ERANGE);
-
-	devmem->resource->desc = IORES_DESC_DEVICE_PRIVATE_MEMORY;
+	devmem->resource = devm_request_free_mem_region(device, &iomem_resource,
+			size);
+	if (IS_ERR(devmem->resource))
+		return ERR_CAST(devmem->resource);
 	devmem->pfn_first = devmem->resource->start >> PAGE_SHIFT;
 	devmem->pfn_last = devmem->pfn_first +
 			   (resource_size(devmem->resource) >> PAGE_SHIFT);
-- 
2.20.1

