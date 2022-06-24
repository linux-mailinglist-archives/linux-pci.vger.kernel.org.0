Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A5C558F92
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 06:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiFXEUP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 00:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiFXEUN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 00:20:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184354FC5E;
        Thu, 23 Jun 2022 21:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656044412; x=1687580412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VWqSrsF/8AtHIz6pbjjwt/1/bobrPOwTGS0iEZ53wBc=;
  b=g5u2xSpdrKt8bzpQdU1GFMIFuaASSgAtEFPipZ80kSJoR4BxUcrsPc+o
   Y2SxCR+/oOcMCUMmoGJkf6uv7s0soqW8NGCSFKomhRPtM8uN6uMKuAi9/
   dhOFWQMB7/1zOON2zw0KDKlhnZGJmT+wc816ZYfvasrtyqx9ggyjMzFgY
   MR83K4GeqqTy7hhU3Ww5HpV1Xqa+RdyKYGOoioE1bIC7rweUpq35XWVnX
   aXC23rJhDfkKPlAK1J7+dCENTUc3KFkGwarrWJAV/CgnBCoo7HKJ7u+xO
   Uh43N52PNKSuHR3bOa5mORVfgUafLVx2eznfLlGblICSeWenSvKIzHqSu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="367238005"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="367238005"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:12 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="645092926"
Received: from daharell-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.intel.com) ([10.209.66.176])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:11 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, linux-pci@vger.kernel.org,
        patches@lists.linux.dev, hch@lst.de,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 33/46] resource: Introduce alloc_free_mem_region()
Date:   Thu, 23 Jun 2022 21:19:37 -0700
Message-Id: <20220624041950.559155-8-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The core of devm_request_free_mem_region() is a helper that searches for
free space in iomem_resource and performs __request_region_locked() on
the result of that search. The policy choices of the implementation
conform to what CONFIG_DEVICE_PRIVATE users want which is memory that is
immediately marked busy, and a preference to search for the first-fit
free range in descending order from the top of the physical address
space.

CXL has a need for a similar allocator, but with the following tweaks:

1/ Search for free space in ascending order

2/ Search for free space relative to a given CXL window

3/ 'insert' rather than 'request' the new resource given downstream
   drivers from the CXL Region driver (like the pmem or dax drivers) are
   responsible for request_mem_region() when they activate the memory
   range.

Rework __request_free_mem_region() into get_free_mem_region() which
takes a set of GFR_* (Get Free Region) flags to control the allocation
policy (ascending vs descending), and "busy" policy (insert_resource()
vs request_region()).

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/linux-cxl/20220420143406.GY2120790@nvidia.com/
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/ioport.h |   2 +
 kernel/resource.c      | 174 ++++++++++++++++++++++++++++++++---------
 mm/Kconfig             |   5 ++
 3 files changed, 146 insertions(+), 35 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index ec5f71f7135b..ed03518347aa 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -329,6 +329,8 @@ struct resource *devm_request_free_mem_region(struct device *dev,
 		struct resource *base, unsigned long size);
 struct resource *request_free_mem_region(struct resource *base,
 		unsigned long size, const char *name);
+struct resource *alloc_free_mem_region(struct resource *base,
+		unsigned long size, unsigned long align, const char *name);
 
 static inline void irqresource_disabled(struct resource *res, u32 irq)
 {
diff --git a/kernel/resource.c b/kernel/resource.c
index 53a534db350e..9fc990274106 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -489,8 +489,9 @@ int __weak page_is_ram(unsigned long pfn)
 }
 EXPORT_SYMBOL_GPL(page_is_ram);
 
-static int __region_intersects(resource_size_t start, size_t size,
-			unsigned long flags, unsigned long desc)
+static int __region_intersects(struct resource *parent, resource_size_t start,
+			       size_t size, unsigned long flags,
+			       unsigned long desc)
 {
 	struct resource res;
 	int type = 0; int other = 0;
@@ -499,7 +500,7 @@ static int __region_intersects(resource_size_t start, size_t size,
 	res.start = start;
 	res.end = start + size - 1;
 
-	for (p = iomem_resource.child; p ; p = p->sibling) {
+	for (p = parent->child; p ; p = p->sibling) {
 		bool is_type = (((p->flags & flags) == flags) &&
 				((desc == IORES_DESC_NONE) ||
 				 (desc == p->desc)));
@@ -543,7 +544,7 @@ int region_intersects(resource_size_t start, size_t size, unsigned long flags,
 	int ret;
 
 	read_lock(&resource_lock);
-	ret = __region_intersects(start, size, flags, desc);
+	ret = __region_intersects(&iomem_resource, start, size, flags, desc);
 	read_unlock(&resource_lock);
 
 	return ret;
@@ -1780,62 +1781,135 @@ void resource_list_free(struct list_head *head)
 }
 EXPORT_SYMBOL(resource_list_free);
 
-#ifdef CONFIG_DEVICE_PRIVATE
-static struct resource *__request_free_mem_region(struct device *dev,
-		struct resource *base, unsigned long size, const char *name)
+#ifdef CONFIG_GET_FREE_REGION
+#define GFR_DESCENDING		(1UL << 0)
+#define GFR_REQUEST_REGION	(1UL << 1)
+#define GFR_DEFAULT_ALIGN (1UL << PA_SECTION_SHIFT)
+
+static resource_size_t gfr_start(struct resource *base, resource_size_t size,
+				 resource_size_t align, unsigned long flags)
+{
+	if (flags & GFR_DESCENDING) {
+		resource_size_t end;
+
+		end = min_t(resource_size_t, base->end,
+			    (1ULL << MAX_PHYSMEM_BITS) - 1);
+		return end - size + 1;
+	}
+
+	return ALIGN(base->start, align);
+}
+
+static bool gfr_continue(struct resource *base, resource_size_t addr,
+			 resource_size_t size, unsigned long flags)
+{
+	if (flags & GFR_DESCENDING)
+		return addr > size && addr >= base->start;
+	return addr > addr - size &&
+	       addr <= min_t(resource_size_t, base->end,
+			     (1ULL << MAX_PHYSMEM_BITS) - 1);
+}
+
+static resource_size_t gfr_next(resource_size_t addr, resource_size_t size,
+				unsigned long flags)
+{
+	if (flags & GFR_DESCENDING)
+		return addr - size;
+	return addr + size;
+}
+
+static void remove_free_mem_region(void *_res)
 {
-	resource_size_t end, addr;
+	struct resource *res = _res;
+
+	if (res->parent)
+		remove_resource(res);
+	free_resource(res);
+}
+
+static struct resource *
+get_free_mem_region(struct device *dev, struct resource *base,
+		    resource_size_t size, const unsigned long align,
+		    const char *name, const unsigned long desc,
+		    const unsigned long flags)
+{
+	resource_size_t addr;
 	struct resource *res;
 	struct region_devres *dr = NULL;
 
-	size = ALIGN(size, 1UL << PA_SECTION_SHIFT);
-	end = min_t(unsigned long, base->end, (1UL << MAX_PHYSMEM_BITS) - 1);
-	addr = end - size + 1UL;
+	size = ALIGN(size, align);
 
 	res = alloc_resource(GFP_KERNEL);
 	if (!res)
 		return ERR_PTR(-ENOMEM);
 
-	if (dev) {
+	if (dev && (flags & GFR_REQUEST_REGION)) {
 		dr = devres_alloc(devm_region_release,
 				sizeof(struct region_devres), GFP_KERNEL);
 		if (!dr) {
 			free_resource(res);
 			return ERR_PTR(-ENOMEM);
 		}
+	} else if (dev) {
+		if (devm_add_action_or_reset(dev, remove_free_mem_region, res))
+			return ERR_PTR(-ENOMEM);
 	}
 
 	write_lock(&resource_lock);
-	for (; addr > size && addr >= base->start; addr -= size) {
-		if (__region_intersects(addr, size, 0, IORES_DESC_NONE) !=
-				REGION_DISJOINT)
+	for (addr = gfr_start(base, size, align, flags);
+	     gfr_continue(base, addr, size, flags);
+	     addr = gfr_next(addr, size, flags)) {
+		if (__region_intersects(base, addr, size, 0, IORES_DESC_NONE) !=
+		    REGION_DISJOINT)
 			continue;
 
-		if (__request_region_locked(res, &iomem_resource, addr, size,
-						name, 0))
-			break;
+		if (flags & GFR_REQUEST_REGION) {
+			if (__request_region_locked(res, &iomem_resource, addr,
+						    size, name, 0))
+				break;
 
-		if (dev) {
-			dr->parent = &iomem_resource;
-			dr->start = addr;
-			dr->n = size;
-			devres_add(dev, dr);
-		}
+			if (dev) {
+				dr->parent = &iomem_resource;
+				dr->start = addr;
+				dr->n = size;
+				devres_add(dev, dr);
+			}
 
-		res->desc = IORES_DESC_DEVICE_PRIVATE_MEMORY;
-		write_unlock(&resource_lock);
+			res->desc = desc;
+			write_unlock(&resource_lock);
+
+
+			/*
+			 * A driver is claiming this region so revoke any
+			 * mappings.
+			 */
+			revoke_iomem(res);
+		} else {
+			res->start = addr;
+			res->end = addr + size - 1;
+			res->name = name;
+			res->desc = desc;
+			res->flags = IORESOURCE_MEM;
+
+			/*
+			 * Only succeed if the resource hosts an exclusive
+			 * range after the insert
+			 */
+			if (__insert_resource(base, res) || res->child)
+				break;
+
+			write_unlock(&resource_lock);
+		}
 
-		/*
-		 * A driver is claiming this region so revoke any mappings.
-		 */
-		revoke_iomem(res);
 		return res;
 	}
 	write_unlock(&resource_lock);
 
-	free_resource(res);
-	if (dr)
+	if (flags & GFR_REQUEST_REGION) {
+		free_resource(res);
 		devres_free(dr);
+	} else if (dev)
+		devm_release_action(dev, remove_free_mem_region, res);
 
 	return ERR_PTR(-ERANGE);
 }
@@ -1854,18 +1928,48 @@ static struct resource *__request_free_mem_region(struct device *dev,
 struct resource *devm_request_free_mem_region(struct device *dev,
 		struct resource *base, unsigned long size)
 {
-	return __request_free_mem_region(dev, base, size, dev_name(dev));
+	unsigned long flags = GFR_DESCENDING | GFR_REQUEST_REGION;
+
+	return get_free_mem_region(dev, base, size, GFR_DEFAULT_ALIGN,
+				   dev_name(dev),
+				   IORES_DESC_DEVICE_PRIVATE_MEMORY, flags);
 }
 EXPORT_SYMBOL_GPL(devm_request_free_mem_region);
 
 struct resource *request_free_mem_region(struct resource *base,
 		unsigned long size, const char *name)
 {
-	return __request_free_mem_region(NULL, base, size, name);
+	unsigned long flags = GFR_DESCENDING | GFR_REQUEST_REGION;
+
+	return get_free_mem_region(NULL, base, size, GFR_DEFAULT_ALIGN, name,
+				   IORES_DESC_DEVICE_PRIVATE_MEMORY, flags);
 }
 EXPORT_SYMBOL_GPL(request_free_mem_region);
 
-#endif /* CONFIG_DEVICE_PRIVATE */
+/**
+ * alloc_free_mem_region - find a free region relative to @base
+ * @base: resource that will parent the new resource
+ * @size: size in bytes of memory to allocate from @base
+ * @align: alignment requirements for the allocation
+ * @name: resource name
+ *
+ * Buses like CXL, that can dynamically instantiate new memory regions,
+ * need a method to allocate physical address space for those regions.
+ * Allocate and insert a new resource to cover a free, unclaimed by a
+ * descendant of @base, range in the span of @base.
+ */
+struct resource *alloc_free_mem_region(struct resource *base,
+				       unsigned long size, unsigned long align,
+				       const char *name)
+{
+	/* GFR_ASCENDING | GFR_INSERT_RESOURCE */
+	unsigned long flags = 0;
+
+	return get_free_mem_region(NULL, base, size, align, name,
+				   IORES_DESC_NONE, flags);
+}
+EXPORT_SYMBOL_NS_GPL(alloc_free_mem_region, CXL);
+#endif /* CONFIG_GET_FREE_REGION */
 
 static int __init strict_iomem(char *str)
 {
diff --git a/mm/Kconfig b/mm/Kconfig
index 169e64192e48..a5b4fee2e3fd 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -994,9 +994,14 @@ config HMM_MIRROR
 	bool
 	depends on MMU
 
+config GET_FREE_REGION
+	depends on SPARSEMEM
+	bool
+
 config DEVICE_PRIVATE
 	bool "Unaddressable device memory (GPU memory, ...)"
 	depends on ZONE_DEVICE
+	select GET_FREE_REGION
 
 	help
 	  Allows creation of struct pages to represent unaddressable device
-- 
2.36.1

