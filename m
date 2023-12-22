Return-Path: <linux-pci+bounces-1299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D2281CA09
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 13:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0FD1C224E6
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 12:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148341803A;
	Fri, 22 Dec 2023 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFcOx/7N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86B621A0A;
	Fri, 22 Dec 2023 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703248226; x=1734784226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OiDZKkhIpM5IyGLuILWXJUYuEW8PKuPWXfxlEeVMsPQ=;
  b=WFcOx/7Nje4mHqlBkRjp/V3zyVwUE4XJ0e9iav94Cwxge/9JZXGjJiqr
   Uap3ls95og5Mgbp4zCPHsX+hRiJV2BoJt3l/g/zPc+6KEzVW3HVVzik6z
   c7S9RjtMYxTX7oAmTHgP1fsaE55eYbrBe2104RYlGwCTo6DmYxByHpHO0
   cgsxLBvNn3LC+9uIWGcfnRV/Jna8h9H9fIMnMusp2L6ZQVK+MfI3uDrho
   v/s4m5DHCKIMqhF3wedVq0+M642xkhAV7GfbMDt33Ra0T9FapcwS5DSg4
   ozNwxXa7ghwLy4r+nV8G0f0/3FIgS/ag1ZWe70v8jPU9Sh3BYqaz8JjVS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="2957186"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="2957186"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:30:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="19016951"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.248.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:30:20 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6/7] resource: Export find_empty_resource_slot()
Date: Fri, 22 Dec 2023 14:29:00 +0200
Message-Id: <20231222122901.49538-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231222122901.49538-1-ilpo.jarvinen@linux.intel.com>
References: <20231222122901.49538-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCI bridge window logic needs to find out in advance to the actual
allocation if there is an empty slot big enough to fit the window.

Export find_empty_resource_slot() for the purpose. Also move the struct
resource_constraint into generic header to be able to use the new
interface.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/linux/ioport.h | 22 ++++++++++++++++++++++
 kernel/resource.c      | 25 ++++---------------------
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index ce02f45e9c2c..0e911393dfb2 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -205,6 +205,24 @@ typedef resource_size_t (*resource_alignf)(void *data,
 					   resource_size_t size,
 					   resource_size_t align);
 
+/**
+ * resource_constraint - constraints to be met while searching empty resource slots
+ * @min:		The minimum address for the memory range
+ * @max:		The maximum address for the memory range
+ * @align:		Alignment for the start address of the empty slot
+ * @alignf:		Additional alignment constraints callback
+ * @alignf_data:	Data provided for @alignf callback
+ *
+ * Contains the range and alignment constraints that have to be met during
+ * find_empty_resource_slot(). @alignf can be NULL indicating no alignment
+ * beyond @align is necessary.
+ */
+struct resource_constraint {
+	resource_size_t min, max, align;
+	resource_alignf alignf;
+	void *alignf_data;
+};
+
 /* PC/ISA/whatever - the normal PC address spaces: IO and memory */
 extern struct resource ioport_resource;
 extern struct resource iomem_resource;
@@ -278,6 +296,10 @@ static inline bool resource_union(const struct resource *r1, const struct resour
 	return true;
 }
 
+int find_empty_resource_slot(struct resource *root, struct resource *new,
+			     resource_size_t size,
+			     struct resource_constraint *constraint);
+
 /* Convenience shorthand with allocation */
 #define request_region(start,n,name)		__request_region(&ioport_resource, (start), (n), (name), 0)
 #define request_muxed_region(start,n,name)	__request_region(&ioport_resource, (start), (n), (name), IORESOURCE_MUXED)
diff --git a/kernel/resource.c b/kernel/resource.c
index 80d64b6467b3..2dfe04ba24f3 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -46,24 +46,6 @@ struct resource iomem_resource = {
 };
 EXPORT_SYMBOL(iomem_resource);
 
-/**
- * resource_constraint - constraints to be met while searching empty resource slots
- * @min:		The minimum address for the memory range
- * @max:		The maximum address for the memory range
- * @align:		Alignment for the start address of the empty slot
- * @alignf:		Additional alignment constraints callback
- * @alignf_data:	Data provided for @alignf callback
- *
- * Contains the range and alignment constraints that have to be met during
- * find_empty_resource_slot(). @alignf can be NULL indicating no alignment
- * beyond @align is necessary.
- */
-struct resource_constraint {
-	resource_size_t min, max, align;
-	resource_alignf alignf;
-	void *alignf_data;
-};
-
 static DEFINE_RWLOCK(resource_lock);
 
 static struct resource *next_resource(struct resource *p, bool skip_children)
@@ -651,12 +633,13 @@ next:		if (!this || this->end == root->end)
  * * %0		- if successful, @new members start, end, and flags are altered.
  * * %-EBUSY	- if no empty slot was found.
  */
-static int find_empty_resource_slot(struct resource *root, struct resource *new,
-				    resource_size_t size,
-				    struct resource_constraint *constraint)
+int find_empty_resource_slot(struct resource *root, struct resource *new,
+			     resource_size_t size,
+			     struct resource_constraint *constraint)
 {
 	return  __find_empty_resource_slot(root, NULL, new, size, constraint);
 }
+EXPORT_SYMBOL_GPL(find_empty_resource_slot);
 
 /**
  * reallocate_resource - allocate a slot in the resource tree given range & alignment.
-- 
2.30.2


