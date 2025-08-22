Return-Path: <linux-pci+bounces-34573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7054DB31CEE
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 16:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D72C4E32DB
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 14:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA98D313542;
	Fri, 22 Aug 2025 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YnyEMerB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBF827932D;
	Fri, 22 Aug 2025 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874615; cv=none; b=d0aWPrZNJHzKTtt79ooQkGAYtMm6TPCCby5OWGc3SAwNdmn6z3OQxdxv85wC7hfKNp7m/DUaFNc+GcvuGgqToFxlE5x+/tCXeACZs9S/W0pecfmTyZlPWC8o1ncAlpLbAHhlhG4yioYHI1bOlcvY1GAFnJKHpo4p7aZeys0HxEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874615; c=relaxed/simple;
	bh=qAXdsDQW9N/Uavlh8yIRORIBMsvqG965+7HiERcw2Bc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eIuGbbjmD9hiTc8oPixgXzSximDGQcNI9Oe8qXdjL+/lzEKF/1Xtio1dEOwo/EMnEh7EfyRnouJwAhhmtZNzhuTVEbVgYeiWsSz6K3X0RZI1d6Ezmzk7kkrQlze/xu9UXfSEeB2SD3VOvrZe5Vt1vWIBbDb0kTFzPFEB64CzU5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YnyEMerB; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755874614; x=1787410614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qAXdsDQW9N/Uavlh8yIRORIBMsvqG965+7HiERcw2Bc=;
  b=YnyEMerBNyD/4gckm2MVWTFOs5AMuXXv8Wau9F73CAahRlt35PDeHx9I
   Px3AM4ocW9tA/3qjyNU9bd95lhG2+Vh2jhOmHhkfhpQkrW8VgkVAcykRw
   nsxV3ILroXjzFmmkX2ZeRfGmNTNaA5sXN2oTEpY2wpgpKLk/5iVCJcBmq
   eh+VJDApefXCQUjbJddmcJJIrN8WgcGEdtPb4zwNfJEk1wHPdXAoeCVgz
   faMXYBI99DilYEojClYM9IYT/TcM6lXZtfiyk0Q8wWxO61tjdob0+mNlh
   3vMIW/RYF1agdstDSjTZGkahsftBGQRMCuA2UYmbjosJVBD+wPhqbxzX8
   A==;
X-CSE-ConnectionGUID: rIEsbMO6S62om6g/4qIuQQ==
X-CSE-MsgGUID: 5mKEKGASTRSbz241p1wslg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="62015793"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="62015793"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:56:54 -0700
X-CSE-ConnectionGUID: lzEm3K2FR72KwstWyYHG9Q==
X-CSE-MsgGUID: TakxZF6vRGWLwfxTYMc+bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="173994571"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:56:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Andreas Larsson <andreas@gaisler.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-pci@vger.kernel.org,
	sparclinux@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Igor Mammedov <imammedo@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 04/24] PCI: Move find_bus_resource_of_type() earlier
Date: Fri, 22 Aug 2025 17:55:45 +0300
Message-Id: <20250822145605.18172-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
References: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move find_bus_resource_of_type() earlier in setup-bus.c to be able to
call it in upcoming changes.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 56 ++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index def29506700e..4097d8703b8f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -140,6 +140,34 @@ static void restore_dev_resource(struct pci_dev_resource *dev_res)
 	res->flags = dev_res->flags;
 }
 
+/*
+ * Helper function for sizing routines.  Assigned resources have non-NULL
+ * parent resource.
+ *
+ * Return first unassigned resource of the correct type.  If there is none,
+ * return first assigned resource of the correct type.  If none of the
+ * above, return NULL.
+ *
+ * Returning an assigned resource of the correct type allows the caller to
+ * distinguish between already assigned and no resource of the correct type.
+ */
+static struct resource *find_bus_resource_of_type(struct pci_bus *bus,
+						  unsigned long type_mask,
+						  unsigned long type)
+{
+	struct resource *r, *r_assigned = NULL;
+
+	pci_bus_for_each_resource(bus, r) {
+		if (r == &ioport_resource || r == &iomem_resource)
+			continue;
+		if (r && (r->flags & type_mask) == type && !r->parent)
+			return r;
+		if (r && (r->flags & type_mask) == type && !r_assigned)
+			r_assigned = r;
+	}
+	return r_assigned;
+}
+
 static bool pdev_resources_assignable(struct pci_dev *dev)
 {
 	u16 class = dev->class >> 8, command;
@@ -876,34 +904,6 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 	}
 }
 
-/*
- * Helper function for sizing routines.  Assigned resources have non-NULL
- * parent resource.
- *
- * Return first unassigned resource of the correct type.  If there is none,
- * return first assigned resource of the correct type.  If none of the
- * above, return NULL.
- *
- * Returning an assigned resource of the correct type allows the caller to
- * distinguish between already assigned and no resource of the correct type.
- */
-static struct resource *find_bus_resource_of_type(struct pci_bus *bus,
-						  unsigned long type_mask,
-						  unsigned long type)
-{
-	struct resource *r, *r_assigned = NULL;
-
-	pci_bus_for_each_resource(bus, r) {
-		if (r == &ioport_resource || r == &iomem_resource)
-			continue;
-		if (r && (r->flags & type_mask) == type && !r->parent)
-			return r;
-		if (r && (r->flags & type_mask) == type && !r_assigned)
-			r_assigned = r;
-	}
-	return r_assigned;
-}
-
 static resource_size_t calculate_iosize(resource_size_t size,
 					resource_size_t min_size,
 					resource_size_t size1,
-- 
2.39.5


