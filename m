Return-Path: <linux-pci+bounces-1297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5259F81CA04
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 13:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D22EB23923
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 12:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B737C33DD;
	Fri, 22 Dec 2023 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dhQ4ZZen"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4974F18B15;
	Fri, 22 Dec 2023 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703248205; x=1734784205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PPHheHQqKFRdHphAUdQLWWFGLymh1CfDcRWQgsBvrnA=;
  b=dhQ4ZZenHgbXgJB1L3aKxB70rEJyZLXFvede+rvHLYDSfypKcPtGE+TB
   q6zAaF/8NIcqjPWZ9TeoShH/9BksuIE0rHJhXyHoXRbNmM/SQY/4mykSp
   9XYaMm4OQPYDMmi4HwCoEoAtLEIc8cOrA95IyhheGVkVSyxS+9QvdITcd
   /TrRUrLjPPgp/qbMne5FDtVW8sJQRZNL+t91OsonLZsacMIBWc8Fz+1Fb
   FXCsAY4ZhoaMDQPO0A7LWzburbH48pQOzkKkKErnpwci4h4TuBL6O4JRu
   rGdD0dWCTfbwLlie3f9TuZPkdHFlN2XKfwKnIxHpkTwqI4zxqQE1OafRk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="2957159"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="2957159"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:30:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="19016836"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.248.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:29:59 -0800
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
Subject: [PATCH 4/7] resource: Use typedef for alignf callback
Date: Fri, 22 Dec 2023 14:28:58 +0200
Message-Id: <20231222122901.49538-5-ilpo.jarvinen@linux.intel.com>
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

To make it simpler to declare resource constraint alignf callbacks, add
typedef for it and document it.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/bus.c      | 10 ++--------
 include/linux/ioport.h | 22 ++++++++++++++++++----
 include/linux/pci.h    |  5 +----
 kernel/resource.c      |  8 ++------
 4 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 9c2137dae429..be5a4bb4d2fb 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -176,10 +176,7 @@ static void pci_clip_resource_to_region(struct pci_bus *bus,
 static int pci_bus_alloc_from_region(struct pci_bus *bus, struct resource *res,
 		resource_size_t size, resource_size_t align,
 		resource_size_t min, unsigned long type_mask,
-		resource_size_t (*alignf)(void *,
-					  const struct resource *,
-					  resource_size_t,
-					  resource_size_t),
+		resource_alignf alignf,
 		void *alignf_data,
 		struct pci_bus_region *region)
 {
@@ -250,10 +247,7 @@ static int pci_bus_alloc_from_region(struct pci_bus *bus, struct resource *res,
 int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
 		resource_size_t size, resource_size_t align,
 		resource_size_t min, unsigned long type_mask,
-		resource_size_t (*alignf)(void *,
-					  const struct resource *,
-					  resource_size_t,
-					  resource_size_t),
+		resource_alignf alignf,
 		void *alignf_data)
 {
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 14f5cfabbbc8..ce02f45e9c2c 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -188,6 +188,23 @@ enum {
 #define DEFINE_RES_DMA(_dma)						\
 	DEFINE_RES_DMA_NAMED((_dma), NULL)
 
+/**
+ * resource_alignf - Resource alignment callback
+ * @data:	Private data used by the callback
+ * @res:	Resource candidate range (an empty resource slot)
+ * @size:	The minimum size of the empty slot
+ * @align:	Alignment from the constraints
+ *
+ * Callback allows calculating resource placement and alignment beyond min,
+ * max, and align fields in the struct resource_constraint.
+ *
+ * Return: Start address for the resource.
+ */
+typedef resource_size_t (*resource_alignf)(void *data,
+					   const struct resource *res,
+					   resource_size_t size,
+					   resource_size_t align);
+
 /* PC/ISA/whatever - the normal PC address spaces: IO and memory */
 extern struct resource ioport_resource;
 extern struct resource iomem_resource;
@@ -207,10 +224,7 @@ extern void arch_remove_reservations(struct resource *avail);
 extern int allocate_resource(struct resource *root, struct resource *new,
 			     resource_size_t size, resource_size_t min,
 			     resource_size_t max, resource_size_t align,
-			     resource_size_t (*alignf)(void *,
-						       const struct resource *,
-						       resource_size_t,
-						       resource_size_t),
+			     resource_alignf alignf,
 			     void *alignf_data);
 struct resource *lookup_resource(struct resource *root, resource_size_t start);
 int adjust_resource(struct resource *res, resource_size_t start,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60ca768bc867..d635e64debd9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1546,10 +1546,7 @@ int __must_check pci_bus_alloc_resource(struct pci_bus *bus,
 			struct resource *res, resource_size_t size,
 			resource_size_t align, resource_size_t min,
 			unsigned long type_mask,
-			resource_size_t (*alignf)(void *,
-						  const struct resource *,
-						  resource_size_t,
-						  resource_size_t),
+			resource_alignf alignf,
 			void *alignf_data);
 
 
diff --git a/kernel/resource.c b/kernel/resource.c
index ed4bb8ad701a..9d7920104120 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -60,8 +60,7 @@ EXPORT_SYMBOL(iomem_resource);
  */
 struct resource_constraint {
 	resource_size_t min, max, align;
-	resource_size_t (*alignf)(void *, const struct resource *,
-			resource_size_t, resource_size_t);
+	resource_alignf alignf;
 	void *alignf_data;
 };
 
@@ -725,10 +724,7 @@ static int reallocate_resource(struct resource *root, struct resource *old,
 int allocate_resource(struct resource *root, struct resource *new,
 		      resource_size_t size, resource_size_t min,
 		      resource_size_t max, resource_size_t align,
-		      resource_size_t (*alignf)(void *,
-						const struct resource *,
-						resource_size_t,
-						resource_size_t),
+		      resource_alignf alignf,
 		      void *alignf_data)
 {
 	int err;
-- 
2.30.2


