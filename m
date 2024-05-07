Return-Path: <linux-pci+bounces-7157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2BE8BDFAE
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 12:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935AA28749B
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 10:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2AE14F12C;
	Tue,  7 May 2024 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FLXsWMzR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87AA14F11B;
	Tue,  7 May 2024 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077604; cv=none; b=FlGoRPQK3DTgNfiqtyvea2XTfsuifSFeZiuKGYlqe9TQ5dX1ofpeT82blaUbT39LPPCxXZXrkdb9LrLQuPJoLxjbXspZsjHEBmESg9QjOumIZkyu8D4tU+O2+5iYZ/5rMAEzGV8TuYshyLHgzzM1ThPqD/pHWt64GDT24dOSEWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077604; c=relaxed/simple;
	bh=OtRBI9pR8VBzzT0laOEFtAlpEA+0KVdeY8kwVqKXTZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIQbTcL32G0iaWpzDFrSWgNkJ9KFbhl66XrNEselEbmwkczvvVNkrrs5xVpi8MultViNfXUFQbqKRhZFTAtvE1UZiHPKkpqALYbe2FuLSsaOWzq+wNrgVIO6YeNMujFlE1hZ7lsze0SWYQ1Mri5YVY2o+gGyZLQTLX5Mc3VbpDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FLXsWMzR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715077603; x=1746613603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OtRBI9pR8VBzzT0laOEFtAlpEA+0KVdeY8kwVqKXTZU=;
  b=FLXsWMzRlSxPybEqMJ6SlBJMf5MYN38R/NNqJ7kCzhA9AQPfBCS9pTJc
   v2klth8SWnnrUajdkbIpBG/JKRkx9hV9FBbwlzSFl1KpbWW0rLM59odCW
   KGUys2LL14PkcGDyKPKc8IYoGZ73zb1Na7wOSMangvo6clncL6HGVIqHk
   c+/DEiiPu4pyixp19MH8iGDOMkl6dyR4uO6CLJZwwBRKEulnPkDYs1TA/
   tjtkKhYZBv0mlon0SShvxrdxABADeMjs3g1Futjdw/rsUrcxow1bgDcVg
   JQWoQ+beAQUpuYf1lEWx4E5IcnS+ypLqu4Ul1HUnzhAjiXqI7pnGUV52K
   g==;
X-CSE-ConnectionGUID: LZHkhUcIR5CYaBswXBh2eg==
X-CSE-MsgGUID: 4/odz09lSkWz3QUk0qov5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10729844"
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="10729844"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 03:26:41 -0700
X-CSE-ConnectionGUID: KoQkCv+qQsOQ9pW7bquFig==
X-CSE-MsgGUID: d+BhI2B0Tvm4EbT1wXE6Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="33280265"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.74])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 03:26:36 -0700
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
	Lidong Wang <lidong.wang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 6/8] resource: Export find_resource_space()
Date: Tue,  7 May 2024 13:25:21 +0300
Message-Id: <20240507102523.57320-7-ilpo.jarvinen@linux.intel.com>
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

PCI bridge window logic needs to find out in advance to the actual
allocation if there is an empty space big enough to fit the window.

Export find_resource_space() for the purpose. Also move the struct
resource_constraint into generic header to be able to use the new
interface.

Tested-by: Lidong Wang <lidong.wang@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 include/linux/ioport.h | 22 ++++++++++++++++++++++
 kernel/resource.c      | 26 ++++----------------------
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 28266426e5bf..6e9fb667a1c5 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -205,6 +205,25 @@ typedef resource_size_t (*resource_alignf)(void *data,
 					   resource_size_t size,
 					   resource_size_t align);
 
+/**
+ * struct resource_constraint - constraints to be met while searching empty
+ *				resource space
+ * @min:		The minimum address for the memory range
+ * @max:		The maximum address for the memory range
+ * @align:		Alignment for the start address of the empty space
+ * @alignf:		Additional alignment constraints callback
+ * @alignf_data:	Data provided for @alignf callback
+ *
+ * Contains the range and alignment constraints that have to be met during
+ * find_resource_space(). @alignf can be NULL indicating no alignment beyond
+ * @align is necessary.
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
@@ -278,6 +297,9 @@ static inline bool resource_union(const struct resource *r1, const struct resour
 	return true;
 }
 
+int find_resource_space(struct resource *root, struct resource *new,
+			resource_size_t size, struct resource_constraint *constraint);
+
 /* Convenience shorthand with allocation */
 #define request_region(start,n,name)		__request_region(&ioport_resource, (start), (n), (name), 0)
 #define request_muxed_region(start,n,name)	__request_region(&ioport_resource, (start), (n), (name), IORESOURCE_MUXED)
diff --git a/kernel/resource.c b/kernel/resource.c
index 35c44c23b037..14777afb0a99 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -48,25 +48,6 @@ struct resource iomem_resource = {
 };
 EXPORT_SYMBOL(iomem_resource);
 
-/**
- * struct resource_constraint - constraints to be met while searching empty
- *				resource space
- * @min:		The minimum address for the memory range
- * @max:		The maximum address for the memory range
- * @align:		Alignment for the start address of the empty space
- * @alignf:		Additional alignment constraints callback
- * @alignf_data:	Data provided for @alignf callback
- *
- * Contains the range and alignment constraints that have to be met during
- * find_resource_space(). @alignf can be NULL indicating no alignment beyond
- * @align is necessary.
- */
-struct resource_constraint {
-	resource_size_t min, max, align;
-	resource_alignf alignf;
-	void *alignf_data;
-};
-
 static DEFINE_RWLOCK(resource_lock);
 
 static struct resource *next_resource(struct resource *p, bool skip_children)
@@ -708,12 +689,13 @@ next:		if (!this || this->end == root->end)
  * * %0		- if successful, @new members start, end, and flags are altered.
  * * %-EBUSY	- if no empty space was found.
  */
-static int find_resource_space(struct resource *root, struct resource *new,
-			       resource_size_t size,
-			       struct resource_constraint *constraint)
+int find_resource_space(struct resource *root, struct resource *new,
+			resource_size_t size,
+			struct resource_constraint *constraint)
 {
 	return  __find_resource_space(root, NULL, new, size, constraint);
 }
+EXPORT_SYMBOL_GPL(find_resource_space);
 
 /**
  * reallocate_resource - allocate a slot in the resource tree given range & alignment.
-- 
2.39.2


