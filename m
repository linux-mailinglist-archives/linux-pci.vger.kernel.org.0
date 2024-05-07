Return-Path: <linux-pci+bounces-7155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 282BB8BDFA7
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 12:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A2C286BF4
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 10:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C382F1509A8;
	Tue,  7 May 2024 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QVZSLiQt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EC814EC6E;
	Tue,  7 May 2024 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077583; cv=none; b=Cv7ieigs0FztcuAp5NKqbddi7Z7nqNShgDYcC+PmtIcKE+CadXNP9K+40vCc6YQRbWilcgwVXdcH8o70cXlurtQHzlM1u9emIwkau0E0Y19mvEEmRZzifW3EJ75+s2lhXdRKuOG+HB96o5OrLgdifpVgTQP8EE016UIyouHcqbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077583; c=relaxed/simple;
	bh=miOeqO2HdKsG2/bDooVNLUjXiD0Q3Vj+quzbPCrosQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYcIeTv2pCRHKJfwFB+DGkacYQLeznmDJmMdGIbcCsvL8LEfDwLBY2UdiwGQ9qxujRHnDFwSgPkGiZZzynwn9i83i6+x3hediXBHk/M7GCnzmS+2dn1bAYtic0OsCGuMWE3yhUoKz1CsuTVZZH8opLVLnVCHz2o+MHSetrKxygg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVZSLiQt; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715077582; x=1746613582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=miOeqO2HdKsG2/bDooVNLUjXiD0Q3Vj+quzbPCrosQQ=;
  b=QVZSLiQtnfRn+3DjRxI4TIG1h0Bd6FGmp4N08p2JGm0i0DDo7ZWa9VMJ
   RJdByWj2bXiDNxMT5wM07+HWKNCG+RJ1qWZg054bBoOv9GzTd71YCMO4D
   oSSS9MsMnPqM+tnTlV5jnw7hbmosgrIB+Plr+jQtByWnunyvB0ORFaGUc
   bEGaeedcGhBIQkYZNX6Ed9cAhgH96MM1BDUDXF+ZPQiLqJ+bmf43U29o/
   fXNDMTZyLK9sgjx/Y4DXbLnHug4f/amz+2tn7huSozZpydPSmvTgJ1gDq
   84Zjb+5S4Nm96f0Bb5PWlp1/ga9Y5sArbIFOqrKTzIpzo7q1GZ1+d07pe
   Q==;
X-CSE-ConnectionGUID: ZoH9nZt8SB+2+wPdEPAMig==
X-CSE-MsgGUID: PKNXAghTTemAq/aRO7f+vQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10746795"
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="10746795"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 03:26:21 -0700
X-CSE-ConnectionGUID: fJg+Q2OwT+m+UgN7zVBNqg==
X-CSE-MsgGUID: lJxIxVboSdWnOBlxykGV3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="59647805"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 03:26:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lidong Wang <lidong.wang@intel.com>
Subject: [PATCH v3 4/8] resource: Use typedef for alignf callback
Date: Tue,  7 May 2024 13:25:19 +0300
Message-Id: <20240507102523.57320-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240507102523.57320-1-ilpo.jarvinen@linux.intel.com>
References: <20240507102523.57320-1-ilpo.jarvinen@linux.intel.com>
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

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Lidong Wang <lidong.wang@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/bus.c      | 10 ++--------
 include/linux/ioport.h | 22 ++++++++++++++++++----
 include/linux/pci.h    |  5 +----
 kernel/resource.c      |  8 ++------
 4 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 826b5016a101..dfc99b3cb958 100644
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
index db7fe25f3370..28266426e5bf 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -188,6 +188,23 @@ enum {
 #define DEFINE_RES_DMA(_dma)						\
 	DEFINE_RES_DMA_NAMED((_dma), NULL)
 
+/**
+ * typedef resource_alignf - Resource alignment callback
+ * @data:	Private data used by the callback
+ * @res:	Resource candidate range (an empty resource space)
+ * @size:	The minimum size of the empty space
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
index 16493426a04f..dde87db6b982 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1552,10 +1552,7 @@ int __must_check pci_bus_alloc_resource(struct pci_bus *bus,
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
index 3f15a32d9c42..26ad6f223652 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -63,8 +63,7 @@ EXPORT_SYMBOL(iomem_resource);
  */
 struct resource_constraint {
 	resource_size_t min, max, align;
-	resource_size_t (*alignf)(void *, const struct resource *,
-			resource_size_t, resource_size_t);
+	resource_alignf alignf;
 	void *alignf_data;
 };
 
@@ -783,10 +782,7 @@ static int reallocate_resource(struct resource *root, struct resource *old,
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
2.39.2


