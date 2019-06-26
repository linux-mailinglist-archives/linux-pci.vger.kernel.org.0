Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D787556926
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 14:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfFZM16 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 08:27:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42774 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfFZM1z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2019 08:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mt4+zc9IpSRPEzC4cMWHk/yq2yqrTYKLdoT+AMW6Qz8=; b=nIyI1gI2JcHVUXx+jXX71rKB3G
        /XpA3ZY5LzkiUTJN1oA3IOdt45tcLua2Uy9FyFVXuJC0c5X8BBMzJA41qG8Y99gIfd1C7GCe5DJJd
        Eh4lgGJ1X6o41RIhoOM0BBJxaETP/8Mj5RBgQ4DP+G9fpKqnG1rQdi0mwUTQbrIxb0bsPbFo13NwX
        3xAPRn8oGEMHUyvDW6xdgV80ocjOn88UacI1mjEwcsiAmQWvtKLIFqBidgTpW2fUibEQblL5U/xpS
        usb6ODdl6HifjRKkjVSSirZqtJMju39OzLvmokEvgVxm3ops4idZHit93FdxRmcFIOpreUIAMWn0V
        9GJBgs0A==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg71e-0001MX-8g; Wed, 26 Jun 2019 12:27:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 07/25] mm: factor out a devm_request_free_mem_region helper
Date:   Wed, 26 Jun 2019 14:27:06 +0200
Message-Id: <20190626122724.13313-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626122724.13313-1-hch@lst.de>
References: <20190626122724.13313-1-hch@lst.de>
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
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/ioport.h |  2 ++
 kernel/resource.c      | 39 +++++++++++++++++++++++++++++++++++++++
 mm/hmm.c               | 33 ++++-----------------------------
 3 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index dd961882bc74..a02b290ca08a 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -285,6 +285,8 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
        return (r1->start <= r2->end && r1->end >= r2->start);
 }
 
+struct resource *devm_request_free_mem_region(struct device *dev,
+		struct resource *base, unsigned long size);
 
 #endif /* __ASSEMBLY__ */
 #endif	/* _LINUX_IOPORT_H */
diff --git a/kernel/resource.c b/kernel/resource.c
index 158f04ec1d4f..d22423e85cf8 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1628,6 +1628,45 @@ void resource_list_free(struct list_head *head)
 }
 EXPORT_SYMBOL(resource_list_free);
 
+#ifdef CONFIG_DEVICE_PRIVATE
+/**
+ * devm_request_free_mem_region - find free region for device private memory
+ *
+ * @dev: device struct to bind the resource to
+ * @size: size in bytes of the device memory to add
+ * @base: resource tree to look in
+ *
+ * This function tries to find an empty range of physical address big enough to
+ * contain the new resource, so that it can later be hotplugged as ZONE_DEVICE
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
index e7dd2ab8f9ab..48574f8485bb 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -25,8 +25,6 @@
 #include <linux/mmu_notifier.h>
 #include <linux/memory_hotplug.h>
 
-#define PA_SECTION_SIZE (1UL << PA_SECTION_SHIFT)
-
 #if IS_ENABLED(CONFIG_HMM_MIRROR)
 static const struct mmu_notifier_ops hmm_mmu_notifier_ops;
 
@@ -1408,7 +1406,6 @@ struct hmm_devmem *hmm_devmem_add(const struct hmm_devmem_ops *ops,
 				  unsigned long size)
 {
 	struct hmm_devmem *devmem;
-	resource_size_t addr;
 	void *result;
 	int ret;
 
@@ -1430,32 +1427,10 @@ struct hmm_devmem *hmm_devmem_add(const struct hmm_devmem_ops *ops,
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

