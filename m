Return-Path: <linux-pci+bounces-1512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E2E81FA1C
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 17:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B931F242F1
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 16:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0D6F9C2;
	Thu, 28 Dec 2023 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RzDCblR/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497D11094A;
	Thu, 28 Dec 2023 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703782706; x=1735318706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WYw+ej8p75zSV2PmRVDEXfp4ji6lrtgJzEwDsDP49x0=;
  b=RzDCblR/5VtUnlVh9tyGo2ztgfg7fST3j6IOU18rCVQU3gZzyKdQNqh+
   O69b9TtU02E7F1ojIHVyyUFh4Xpl0NBV5dDLpP4ep7yCDWrDkGYLCMVaS
   Jsq2bQnQpcHg6axtu45IwzLNNFCPG+7jVR1C+6EjsGowZbmlPh9/t8lOD
   sODrxH/Qc4ByrYBgPoQiW7YcjjG81OqaNs72HEO9RRgv0bnBB2vJj+VTh
   2GA9Pwfowef8wobV4Zkzu/gcBDN3ar2rITlvD3lJSlevcN5BS5Cvr18eF
   ZMCIeNXqY4eoZ+HeEOjCq2E9nv7+QwFsO7kk94iSQqvIu0JCBdLPaNEsS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="9958072"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="9958072"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 08:58:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="951847269"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="951847269"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.250.171])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 08:58:19 -0800
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
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 6/7] resource: Export find_empty_resource_slot()
Date: Thu, 28 Dec 2023 18:57:06 +0200
Message-Id: <20231228165707.3447-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>
References: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/ioport.h | 22 ++++++++++++++++++++++
 kernel/resource.c      | 25 ++++---------------------
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 26bfd9515653..b6ed244bc4b9 100644
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
index f0e4d57d0c35..c1bbb0943d9c 100644
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
@@ -650,12 +632,13 @@ next:		if (!this || this->end == root->end)
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


