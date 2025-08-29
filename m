Return-Path: <linux-pci+bounces-35101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A094B3BC16
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF35586549
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4009E303C88;
	Fri, 29 Aug 2025 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZahVKbOC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3102EBDF4;
	Fri, 29 Aug 2025 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473116; cv=none; b=Dsyx8uhiTuPmgJKsNLPPUdS9tZpNEkeBbpnj+bjZYPBdJ4n+aisT8uJFflji0BOASP9mhhROLqPs7w1/XjxPzE+DUX2nbg35DTzFBOBuP8YsXU/5zL5Z3DPUvVb62fmrj1O/3tCFcGJdMc8PtyxKQLdQfn5uc9GLxp5ofw+EV+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473116; c=relaxed/simple;
	bh=Vo+DZZCOENM75WtDHoua02f+E/MhqxxLas5XCME8WVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bYJcm64UsG2b/QJ3whuU1x9Qfddc9DD2spfaiCjxPB6M5LKOnSlvcKsiPxM7yGePYgNafRlIT8XPYJx6nPkVe5FA6CUSer1l/BaOwmEUiV6N71Pltwuty3xTqfjPTd9vaocY10TELPNH5HjeEQ8v2ycUYfPIY0/6jXdub9nVHug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZahVKbOC; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473114; x=1788009114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vo+DZZCOENM75WtDHoua02f+E/MhqxxLas5XCME8WVs=;
  b=ZahVKbOCD1HN3aXfLTLUEtxXa+Q+QTksSpvgYeiA2cjKBoOg8OJYzG64
   fQ3CfFNQouRGLkdbx7+8LsKHiuPHokc56j+8PUxqJ8HSe3xbpbnF4qMim
   YeTCW4pCg/fWabRDYDA9B6GBA1OvGs+tAjmfYGPgSEvBVk9IidgHK1b/b
   V7yCUbcxvf/yLDUXy/URRyEvarmWMF4w1jEPnaeFaJjWBygDxFvLfkFhl
   JcgMVYrOc4aBdk9O8S/Ems/yeJhoKkEuqYZ5+MEj9xsyCyfXFl2NS4dFo
   6Tvw2cztXtlPyVcwt6/IggGSP1GaRzxIXDbF2pG99gZn/kjdTQiQ5aw9P
   g==;
X-CSE-ConnectionGUID: XJgSZAexT0iGuvs2N+2gsA==
X-CSE-MsgGUID: qzcY2r0kRZiOzEbAARtKnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58687500"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58687500"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:11:53 -0700
X-CSE-ConnectionGUID: X+y6U1F6S3a0nvSvxhpVLA==
X-CSE-MsgGUID: mY00+DXoQXaduAlcgXd7Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="174550876"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:11:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 04/24] PCI: Move find_bus_resource_of_type() earlier
Date: Fri, 29 Aug 2025 16:10:53 +0300
Message-Id: <20250829131113.36754-5-ilpo.jarvinen@linux.intel.com>
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

Move find_bus_resource_of_type() earlier in setup-bus.c to be able to call
it in upcoming changes.

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


