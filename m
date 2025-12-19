Return-Path: <linux-pci+bounces-43422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E1BCD1331
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 966FE300CE18
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34F333C52D;
	Fri, 19 Dec 2025 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4LsSNb8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7EB33C53B;
	Fri, 19 Dec 2025 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166110; cv=none; b=inYDQTSnf/tM9ethjRLoGSxA5FMsUIz+3d8j+BMOaodxj4EH6N0UMqCnTdW+WxPsH4u3nAgghh7eYSdmIaWy1ftA3J7+PKHTg9j96a+ry7ubaRDzCMc6cuReg51d7amBiS9x4r5B/NWQmLAR4Sa0xluarSiECfD51LrhEHu1S1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166110; c=relaxed/simple;
	bh=cEwYGsfjSljTBm+Y67K3qMuhLIPGBKVketKYBjW7m/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/bfA/+u3fbjGsvj5kFo7mqQRjAdvuezhqiRTlUwQ8JTLuwdRCX9c7yxmTBz9XNoAaxMqAYXmJTW5wQUUwcJiriXRgFru2yVSdMDQXMu4/w6bph7PLco4sJEbe7eswgmBqcRL9/nCfyKpTMdBp0bA1rS56bPLYGMUbEoFnUZUAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h4LsSNb8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166109; x=1797702109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cEwYGsfjSljTBm+Y67K3qMuhLIPGBKVketKYBjW7m/g=;
  b=h4LsSNb8m9ShwMd+V+yEy1fFzG5Qzc/UWPDHOhpNR3XDxQ4Fu1W2B4cB
   5FlsBMInTRTn/riZFWzMAp7N/2lHG+9U7+owWKmSX9vqt6KSOQi5Iz9r+
   8wWfwizT1d8/h6wwCRn1ptYI1VTO/KbVyfKD0rAqWZYVqWER41VWPLcFE
   V4+Mv332uEuDLdTPWVbsqb/SpDobcZGEEkYWQceMVK78AQQXT4+SkYe+4
   0XI62l5zKvYIwY4ofm8S78pTSc82f5wCmRhcW1jxGIjiZuyGXK02naici
   A3Lp6CVulJOln9lXhWOPjncbGptq1dUK/VRHZEeO8XcqTcyx9QNvkUaVy
   g==;
X-CSE-ConnectionGUID: j41yHqXYR6Gp9+jBYHRewA==
X-CSE-MsgGUID: BGbVYjvVQP+UxnIFzvCGyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="68062524"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="68062524"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:41:49 -0800
X-CSE-ConnectionGUID: jYoerd8kQAy3LNZ4W23YkQ==
X-CSE-MsgGUID: DaCg608xR/SjPdH6QzR0Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="199747983"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:41:45 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 07/23] PCI: Pass bridge window resource to pbus_size_mem()
Date: Fri, 19 Dec 2025 19:40:20 +0200
Message-Id: <20251219174036.16738-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pbus_size_mem() inputs type and calculates bridge window resource
within. Its caller (__pci_bus_size_bridges()) also has to lookup the
prefetchable window to determine if it exists or not to decide whether
to call pbus_size_mem() twice or once.

Change the interface such that the caller is responsible in providing
the bridge window resource. Passing the resource directly avoids
another lookup for the prefetchable window inside pbus_size_mem().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f85ae20dc894..90bb9baf68b9 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1262,11 +1262,11 @@ static resource_size_t calculate_head_align(resource_size_t *aligns,
  * pbus_size_mem() - Size the memory window of a given bus
  *
  * @bus:		The bus
- * @type:		The type of bridge resource
+ * @b_res:		The bridge window resource
  * @add_size:		Additional memory window
  * @realloc_head:	Track the additional memory window on this list
  *
- * Calculate the size of the bus resource for @type and minimal alignment
+ * Calculate the size of the bridge window @b_res and minimal alignment
  * which guarantees that all child resources fit in this size.
  *
  * Set the bus resource start/end to indicate the required size if there an
@@ -1275,15 +1275,14 @@ static resource_size_t calculate_head_align(resource_size_t *aligns,
  * Add optional resource requests to the @realloc_head list if it is
  * supplied.
  */
-static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
-			 resource_size_t add_size,
-			 struct list_head *realloc_head)
+static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
+			  resource_size_t add_size,
+			  struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
 	resource_size_t min_align, win_align, align, size, size0, size1 = 0;
 	resource_size_t aligns[28] = {}; /* Alignments from 1MB to 128TB */
 	int order, max_order;
-	struct resource *b_res = pbus_select_window_for_type(bus, type);
 	resource_size_t children_add_size = 0;
 	resource_size_t children_add_align = 0;
 	resource_size_t add_align = 0;
@@ -1494,7 +1493,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 	struct pci_dev *dev;
 	resource_size_t additional_io_size = 0, additional_mmio_size = 0,
 			additional_mmio_pref_size = 0;
-	struct resource *pref;
+	struct resource *b_res;
 	struct pci_host_bridge *host;
 	int hdr_type;
 
@@ -1520,12 +1519,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		host = to_pci_host_bridge(bus->bridge);
 		if (!host->size_windows)
 			return;
-		pci_bus_for_each_resource(bus, pref)
-			if (pref && (pref->flags & IORESOURCE_PREFETCH))
-				break;
 		hdr_type = -1;	/* Intentionally invalid - not a PCI device. */
 	} else {
-		pref = &bus->self->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
 		hdr_type = bus->self->hdr_type;
 	}
 
@@ -1545,15 +1540,19 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 	default:
 		pbus_size_io(bus, additional_io_size, realloc_head);
 
-		if (pref && (pref->flags & IORESOURCE_PREFETCH)) {
-			pbus_size_mem(bus,
-				      IORESOURCE_MEM | IORESOURCE_PREFETCH |
-				      (pref->flags & IORESOURCE_MEM_64),
-				      additional_mmio_pref_size, realloc_head);
+		b_res = pbus_select_window_for_type(bus, IORESOURCE_MEM |
+							 IORESOURCE_PREFETCH |
+							 IORESOURCE_MEM_64);
+		if (b_res && (b_res->flags & IORESOURCE_PREFETCH)) {
+			pbus_size_mem(bus, b_res, additional_mmio_pref_size,
+				      realloc_head);
 		}
 
-		pbus_size_mem(bus, IORESOURCE_MEM, additional_mmio_size,
-			      realloc_head);
+		b_res = pbus_select_window_for_type(bus, IORESOURCE_MEM);
+		if (b_res) {
+			pbus_size_mem(bus, b_res, additional_mmio_size,
+				      realloc_head);
+		}
 		break;
 	}
 }
-- 
2.39.5


