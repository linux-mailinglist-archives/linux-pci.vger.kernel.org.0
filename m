Return-Path: <linux-pci+bounces-35105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9244CB3BC1B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5585A1CC18D1
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED8D31A566;
	Fri, 29 Aug 2025 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HWpll4n9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ACF2F83B7;
	Fri, 29 Aug 2025 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473144; cv=none; b=VAK0V6tB68TayjgqD5ryN8hUD/QZUXx/G4S+aX/VhDVNXtp0jrHz/AMLRii+1qmzpMGBN0iPr6wjaUvNhyVGlssgoiC9qfOrAWRo7ITf6DvKP8UNej16mXek55fMGCfcqtGw0rggLvj3Uh5iF1/rOWNi/GzwjWFiQ9aSTzihvCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473144; c=relaxed/simple;
	bh=PKlYta7LPmqYljZrS3LTFevHfNNYHfyRIo0kOhZW0Ik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iM/MTwzrzLrVDVAO1bZYmZ2xql7ErSObqGHhfBosvWF0XEH7IVGlA8aJAUvzHdroNC/VZKm+3xAUs2LDJY9WZBYPWWEjegKZhanKXQ2hJ7rsLFZQdGgiHE1luAGOd7qni6IuaCsfCxr4Is3BeszgJeE2nYh/Q+XA+ytZCGuEYmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HWpll4n9; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473143; x=1788009143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PKlYta7LPmqYljZrS3LTFevHfNNYHfyRIo0kOhZW0Ik=;
  b=HWpll4n973Znwy8Uc6p79ZDTZixvL0RZgWyWhGgsAtOwc4770U5fSEun
   to4l8JamDE2WFeMWrDOyjp+Gl7Ou+8/KEcfAJZAx+oDCyHoCg3yGCJNOv
   SPrUMoAasC/kY0P44JNzNzzwQj5VRFh+LXn7DuvJm3L7kVcUX097d2Kjg
   z0pHFI7tcfSFaWI9UENI/TImKd91dRk8ZIIlXd45U/933mlds+TvvdxEO
   tbyNU/cAJ1ZqGCDvFL7p515XonmDI3LzOwti1ka+03wAe6LioaQKUPqvn
   rDua+9kka6McCM18aqWoTGVp570BqZR3ZsWetU7OfyaOFrLAbv3knY/9s
   A==;
X-CSE-ConnectionGUID: E9RDQISpQ6eCXUZ2keFpIg==
X-CSE-MsgGUID: Tz07TQGJSvmMG76PTY1m7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="62402942"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="62402942"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:12:23 -0700
X-CSE-ConnectionGUID: gsmww7FNQYaqAeh/lNoqzw==
X-CSE-MsgGUID: DsXhnaoSQgGCfeKPIVYyOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="169946736"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:12:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 08/24] PCI: Use pci_release_resource() instead of release_resource()
Date: Fri, 29 Aug 2025 16:10:57 +0300
Message-Id: <20250829131113.36754-9-ilpo.jarvinen@linux.intel.com>
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

A few places in setup-bus.c call release_resource() directly and end up
duplicating functionality from pci_release_resource() such as parent check,
logging, and clearing the resource. Worse yet, the way the resource is
cleared is inconsistent between different sites.

Convert release_resource() calls into pci_release_resource() to remove code
duplication. This will also make the resource start, end, and flags
behavior consistent, i.e., start address is cleared, and only
IORESOURCE_UNSET is asserted for the resource.

While at it, eliminate the unnecessary initialization of idx variable in
pci_bridge_release_resources().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 46 +++++++++++++----------------------------
 drivers/pci/setup-res.c | 11 +++++++---
 include/linux/pci.h     |  2 +-
 3 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6bdc1af887da..b62465665abc 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -473,8 +473,6 @@ static void __assign_resources_sorted(struct list_head *head,
 	struct pci_dev_resource *dev_res, *tmp_res, *dev_res2;
 	struct resource *res;
 	struct pci_dev *dev;
-	const char *res_name;
-	int idx;
 	unsigned long fail_type;
 	resource_size_t add_align, align;
 
@@ -582,14 +580,7 @@ static void __assign_resources_sorted(struct list_head *head,
 		res = dev_res->res;
 		dev = dev_res->dev;
 
-		if (!res->parent)
-			continue;
-
-		idx = pci_resource_num(dev, res);
-		res_name = pci_resource_name(dev, idx);
-		pci_dbg(dev, "%s %pR: releasing\n", res_name, res);
-
-		release_resource(res);
+		pci_release_resource(dev, pci_resource_num(dev, res));
 		restore_dev_resource(dev_res);
 	}
 	/* Restore start/end/flags from saved list */
@@ -1732,7 +1723,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 	struct resource *r;
 	unsigned int old_flags;
 	struct resource *b_res;
-	int idx = 1;
+	int idx, ret;
 
 	b_res = &dev->resource[PCI_BRIDGE_RESOURCES];
 
@@ -1766,21 +1757,18 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 
 	/* If there are children, release them all */
 	release_child_resources(r);
-	if (!release_resource(r)) {
-		type = old_flags = r->flags & PCI_RES_TYPE_MASK;
-		pci_info(dev, "resource %d %pR released\n",
-			 PCI_BRIDGE_RESOURCES + idx, r);
-		/* Keep the old size */
-		resource_set_range(r, 0, resource_size(r));
-		r->flags = 0;
 
-		/* Avoiding touch the one without PREF */
-		if (type & IORESOURCE_PREFETCH)
-			type = IORESOURCE_PREFETCH;
-		__pci_setup_bridge(bus, type);
-		/* For next child res under same bridge */
-		r->flags = old_flags;
-	}
+	type = old_flags = r->flags & PCI_RES_TYPE_MASK;
+	ret = pci_release_resource(dev, PCI_BRIDGE_RESOURCES + idx);
+	if (ret)
+		return;
+
+	/* Avoiding touch the one without PREF */
+	if (type & IORESOURCE_PREFETCH)
+		type = IORESOURCE_PREFETCH;
+	__pci_setup_bridge(bus, type);
+	/* For next child res under same bridge */
+	r->flags = old_flags;
 }
 
 enum release_type {
@@ -2425,7 +2413,6 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 		for (i = PCI_BRIDGE_RESOURCES; i < PCI_BRIDGE_RESOURCE_END;
 		     i++) {
 			struct resource *res = &bridge->resource[i];
-			const char *res_name = pci_resource_name(bridge, i);
 
 			if ((res->flags ^ type) & PCI_RES_TYPE_MASK)
 				continue;
@@ -2438,12 +2425,7 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 			if (ret)
 				goto cleanup;
 
-			pci_info(bridge, "%s %pR: releasing\n", res_name, res);
-
-			if (res->parent)
-				release_resource(res);
-			res->start = 0;
-			res->end = 0;
+			pci_release_resource(bridge, i);
 			break;
 		}
 		if (i == PCI_BRIDGE_RESOURCE_END)
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index d2b3ed51e880..0468c058b598 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -406,20 +406,25 @@ int pci_reassign_resource(struct pci_dev *dev, int resno,
 	return 0;
 }
 
-void pci_release_resource(struct pci_dev *dev, int resno)
+int pci_release_resource(struct pci_dev *dev, int resno)
 {
 	struct resource *res = pci_resource_n(dev, resno);
 	const char *res_name = pci_resource_name(dev, resno);
+	int ret;
 
 	if (!res->parent)
-		return;
+		return 0;
 
 	pci_info(dev, "%s %pR: releasing\n", res_name, res);
 
-	release_resource(res);
+	ret = release_resource(res);
+	if (ret)
+		return ret;
 	res->end = resource_size(res) - 1;
 	res->start = 0;
 	res->flags |= IORESOURCE_UNSET;
+
+	return 0;
 }
 EXPORT_SYMBOL(pci_release_resource);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 59876de13860..275df4058767 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1417,7 +1417,7 @@ void pci_reset_secondary_bus(struct pci_dev *dev);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
-void pci_release_resource(struct pci_dev *dev, int resno);
+int pci_release_resource(struct pci_dev *dev, int resno);
 static inline int pci_rebar_bytes_to_size(u64 bytes)
 {
 	bytes = roundup_pow_of_two(bytes);
-- 
2.39.5


