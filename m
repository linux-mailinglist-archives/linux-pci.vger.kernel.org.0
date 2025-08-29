Return-Path: <linux-pci+bounces-35115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B34B3BC3B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C6E1CC2BBA
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B60731DD8C;
	Fri, 29 Aug 2025 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b+e81hNH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7314A3218CC;
	Fri, 29 Aug 2025 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473216; cv=none; b=DAw7jCslAYsZ2YYtgbBH8MFZZOMRGq+cQWgmiZqK+s3miZWUZC5P4nvhXDjWq+oEzDxtFvA37smB2AmZDRByX2nGG6wbgsK2xi/QSJufe/PJiufCzlkvizeTWY1i5q45akTSrgdKzpF6yKEg0i8r9h/pfhieux1e9WeLiHm7Msg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473216; c=relaxed/simple;
	bh=SDSewtHR+nxD1leVo6mOLTPta0wj8zrujQ9Fo3dstE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DphDBCH9zk4R+1XE4sMgQQpD+rfRpI/EiAolWm/jwI8jUWvsGM5vmDj5ruk4gy9ueQIIor9Bseh/m/yL7B9TAVARMyvIkKjKP9bYEPJE0IgKuAMVWS0WA5XOBr64k7EnC9oe/kfAAr7VoEOdqTePU77Vw1WpnE0aE2MdPXOddDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b+e81hNH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473216; x=1788009216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SDSewtHR+nxD1leVo6mOLTPta0wj8zrujQ9Fo3dstE4=;
  b=b+e81hNHbyCMaE1TmJemiim4FIyfJuN2ZAs0CEV4hdGrTzBL/PsOLaIr
   5H5tCLcvPqkn7sta/RUV8Gm07GCBZvMaXVAS2ugl+Q8nr4WleU0f2d7SO
   Zbs8VKm6mcgiWr4g45KYvEddLz4wAeTGI6H/5Jvv6y4CTDQf+FfZZToS3
   FbIAQHJD8imTm6zTGnxBMIjG/OrWCkACdKPYRnosKx/fTkyLxINyRtU7Z
   xzfnlu2aOPOgPY+nwfrcVaEvchOSjyf5ljyWQc8iR5EHIor42p4ZSvY5Z
   cv0iJcQqC8pOGCJL9/L/2ZHkFpMfGmLLmOX+Zq/KHbL+hmkDwZjj9IWS+
   g==;
X-CSE-ConnectionGUID: rYNrvgqqT96Y/gWJUDs+OA==
X-CSE-MsgGUID: 6cFBRq3ERBW/SKnse8O7hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62587498"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62587498"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:13:36 -0700
X-CSE-ConnectionGUID: vS+cP0c+TF2l+JCqiGRc0g==
X-CSE-MsgGUID: 2dounHRwSXyuInE3bETHuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="175656787"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:13:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 18/24] PCI: Use pbus_select_window() in space available checker
Date: Fri, 29 Aug 2025 16:11:07 +0300
Message-Id: <20250829131113.36754-19-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pbus_upstream_space_available() figures out the upstream bridge window
resources on its own. Migrate it to use pbus_select_window().

Note: pbus_select_window() -> pbus_select_window_for_type() calls
find_bus_resource_of_type() for root bus, which does not do parent check
similar to what pbus_upstream_space_available() did earlier, but the
difference does not matter because pbus_upstream_space_available() itself
stops when it encounters the root bus.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 65 ++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 5ec446c2b779..865bacae9cac 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1221,19 +1221,20 @@ static inline resource_size_t calculate_mem_align(resource_size_t *aligns,
 /**
  * pbus_upstream_space_available - Check no upstream resource limits allocation
  * @bus:	The bus
- * @mask:	Mask the resource flag, then compare it with type
- * @type:	The type of resource from bridge
+ * @res:	The resource to help select the correct bridge window
  * @size:	The size required from the bridge window
  * @align:	Required alignment for the resource
  *
- * Checks that @size can fit inside the upstream bridge resources that are
- * already assigned.
+ * Check that @size can fit inside the upstream bridge resources that are
+ * already assigned. Select the upstream bridge window based on the type of
+ * @res.
  *
  * Return: %true if enough space is available on all assigned upstream
  * resources.
  */
-static bool pbus_upstream_space_available(struct pci_bus *bus, unsigned long mask,
-					  unsigned long type, resource_size_t size,
+static bool pbus_upstream_space_available(struct pci_bus *bus,
+					  struct resource *res,
+					  resource_size_t size,
 					  resource_size_t align)
 {
 	struct resource_constraint constraint = {
@@ -1241,39 +1242,39 @@ static bool pbus_upstream_space_available(struct pci_bus *bus, unsigned long mas
 		.align = align,
 	};
 	struct pci_bus *downstream = bus;
-	struct resource *res;
 
 	while ((bus = bus->parent)) {
 		if (pci_is_root_bus(bus))
 			break;
 
-		pci_bus_for_each_resource(bus, res) {
-			if (!res || !res->parent || (res->flags & mask) != type)
-				continue;
-
-			if (resource_size(res) >= size) {
-				struct resource gap = {};
+		res = pbus_select_window(bus, res);
+		if (!res)
+			return false;
+		if (!res->parent)
+			continue;
 
-				if (find_resource_space(res, &gap, size, &constraint) == 0) {
-					gap.flags = type;
-					pci_dbg(bus->self,
-						"Assigned bridge window %pR to %pR free space at %pR\n",
-						res, &bus->busn_res, &gap);
-					return true;
-				}
-			}
+		if (resource_size(res) >= size) {
+			struct resource gap = {};
 
-			if (bus->self) {
-				pci_info(bus->self,
-					 "Assigned bridge window %pR to %pR cannot fit 0x%llx required for %s bridging to %pR\n",
-					 res, &bus->busn_res,
-					 (unsigned long long)size,
-					 pci_name(downstream->self),
-					 &downstream->busn_res);
+			if (find_resource_space(res, &gap, size, &constraint) == 0) {
+				gap.flags = res->flags;
+				pci_dbg(bus->self,
+					"Assigned bridge window %pR to %pR free space at %pR\n",
+					res, &bus->busn_res, &gap);
+				return true;
 			}
+		}
 
-			return false;
+		if (bus->self) {
+			pci_info(bus->self,
+				 "Assigned bridge window %pR to %pR cannot fit 0x%llx required for %s bridging to %pR\n",
+				 res, &bus->busn_res,
+				 (unsigned long long)size,
+				 pci_name(downstream->self),
+				 &downstream->busn_res);
 		}
+
+		return false;
 	}
 
 	return true;
@@ -1395,8 +1396,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 		b_res->flags &= ~IORESOURCE_DISABLED;
 
 	if (bus->self && size0 &&
-	    !pbus_upstream_space_available(bus, mask | IORESOURCE_PREFETCH, type,
-					   size0, min_align)) {
+	    !pbus_upstream_space_available(bus, b_res, size0, min_align)) {
 		relaxed_align = 1ULL << (max_order + __ffs(SZ_1M));
 		relaxed_align = max(relaxed_align, win_align);
 		min_align = min(min_align, relaxed_align);
@@ -1411,8 +1411,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 					  resource_size(b_res), add_align);
 
 		if (bus->self && size1 &&
-		    !pbus_upstream_space_available(bus, mask | IORESOURCE_PREFETCH, type,
-						   size1, add_align)) {
+		    !pbus_upstream_space_available(bus, b_res, size1, add_align)) {
 			relaxed_align = 1ULL << (max_order + __ffs(SZ_1M));
 			relaxed_align = max(relaxed_align, win_align);
 			min_align = min(min_align, relaxed_align);
-- 
2.39.5


