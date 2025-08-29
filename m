Return-Path: <linux-pci+bounces-35120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA06B3BC50
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0179163EC7
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD47F322C7D;
	Fri, 29 Aug 2025 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TiuWmb0l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AF033F3;
	Fri, 29 Aug 2025 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473254; cv=none; b=rwvk5x93AZADNXwp5e4aZsJYKndq7UR6v4pGPypsknIi2/5teG4XytwO+eyOqRpEpqquu8BFAK+N0JsVSqVxn/Xlsf80k5l1YfXq9QmEOVaMhAd1ewWkanr2WRlSD4nfrPnbP39BAVIm+VcCzfVPHkFrPq71039PD2RgOFnfeek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473254; c=relaxed/simple;
	bh=o7W07PDM+5+jLGoLdMSwsOn1g1d7t0qQCwHzSy4LHt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzB44UvRWGQEVy0Us7dbjULjgS2sbCbaT0cVSFtTLImhf8o6jbKVlWrb2tiH0BqgPgWR17sdSU+rOXMgBW93m0rlTRAvqtws7oPrgUZlDgHohU4onCjXd0EUvBsHznIGvaL3Dg/941TyncaaBCnaotGT4k4n7zz0yIXkiO1AFdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TiuWmb0l; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473253; x=1788009253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o7W07PDM+5+jLGoLdMSwsOn1g1d7t0qQCwHzSy4LHt0=;
  b=TiuWmb0loHxGNfUV9OUdPmq+6jPJCxxz+NK8YgIxh9atPZ9VY+qfBazA
   PhqEmnBeV3kf8vllAI7LH7QxNhl1nqKWn32n3W7KDS8IoYBy+hVJA5EF9
   f14kbrJCBn2iJJRBQz2u68HEbmNUjUk6f1ukg6Uq/n2pYwury2nQbGy1S
   tEJnITiQEO4hcXJ+1qyCvK2zPtu8YdZKonTtU02Lzqd99jYaL3oB5GWSR
   TuNEFXj3VTuoezMWUqe828gJu5wPvP4yRX104qRzy1e1p89WADA1IOKdx
   KDli4Hw7FStXbIfydXF1lrzvh4Rm+FUV8p/M8/CsQUvlEIBapiUgUMFts
   g==;
X-CSE-ConnectionGUID: WluzcgcNQlWpDHfd4Xjl0Q==
X-CSE-MsgGUID: 9DfbhK7TTr6/tkXBZVtWUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58905349"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58905349"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:14:12 -0700
X-CSE-ConnectionGUID: AiqVdBDWTZWGNaC3t5U0Jw==
X-CSE-MsgGUID: szkrN/ZdS66cxz6px9jpng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="169680084"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:14:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 23/24] PCI: Pass bridge window to pci_bus_release_bridge_resources()
Date: Fri, 29 Aug 2025 16:11:12 +0300
Message-Id: <20250829131113.36754-24-ilpo.jarvinen@linux.intel.com>
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

pci_bus_release_bridge_resources() takes type, which is converted into a
bridge window resource in pci_bridge_release_resources().

Find out the correct bridge window for resource whose assignment failed.
Pass that bridge window to pci_bus_release_bridge_resources() instead of
passing the type. When recursing to subordinate, check which bridge windows
have to be released and recurse for each.

For now, use pbus_select_window_for_type() instead of pbus_select_window()
because non-bridge window resources still have their flags reset which
destroys the type information from the struct resource. The struct
pci_dev_resource holds a copy of the flags which are used instead.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 69 ++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 031ad682aca1..4ce747b5dea3 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1800,51 +1800,24 @@ static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
 }
 
 static void pci_bridge_release_resources(struct pci_bus *bus,
-					 unsigned long type)
+					 struct resource *b_win)
 {
 	struct pci_dev *dev = bus->self;
-	struct resource *r;
-	struct resource *b_res;
 	int idx, ret;
 
-	b_res = &dev->resource[PCI_BRIDGE_RESOURCES];
-
-	/*
-	 * 1. If IO port assignment fails, release bridge IO port.
-	 * 2. If non pref MMIO assignment fails, release bridge nonpref MMIO.
-	 * 3. If 64bit pref MMIO assignment fails, and bridge pref is 64bit,
-	 *    release bridge pref MMIO.
-	 * 4. If pref MMIO assignment fails, and bridge pref is 32bit,
-	 *    release bridge pref MMIO.
-	 * 5. If pref MMIO assignment fails, and bridge pref is not
-	 *    assigned, release bridge nonpref MMIO.
-	 */
-	if (type & IORESOURCE_IO)
-		idx = 0;
-	else if (!(type & IORESOURCE_PREFETCH))
-		idx = 1;
-	else if ((type & IORESOURCE_MEM_64) &&
-		 (b_res[2].flags & IORESOURCE_MEM_64))
-		idx = 2;
-	else if (!(b_res[2].flags & IORESOURCE_MEM_64) &&
-		 (b_res[2].flags & IORESOURCE_PREFETCH))
-		idx = 2;
-	else
-		idx = 1;
-
-	r = &b_res[idx];
-
-	if (!r->parent)
+	if (!b_win->parent)
 		return;
 
+	idx = pci_resource_num(dev, b_win);
+
 	/* If there are children, release them all */
-	release_child_resources(r);
+	release_child_resources(b_win);
 
-	ret = pci_release_resource(dev, PCI_BRIDGE_RESOURCES + idx);
+	ret = pci_release_resource(dev, idx);
 	if (ret)
 		return;
 
-	pci_setup_one_bridge_window(dev, PCI_BRIDGE_RESOURCES + idx);
+	pci_setup_one_bridge_window(dev, idx);
 }
 
 enum release_type {
@@ -1857,7 +1830,7 @@ enum release_type {
  * a larger window later.
  */
 static void pci_bus_release_bridge_resources(struct pci_bus *bus,
-					     unsigned long type,
+					     struct resource *b_win,
 					     enum release_type rel_type)
 {
 	struct pci_dev *dev;
@@ -1865,6 +1838,8 @@ static void pci_bus_release_bridge_resources(struct pci_bus *bus,
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct pci_bus *b = dev->subordinate;
+		struct resource *res;
+
 		if (!b)
 			continue;
 
@@ -1873,9 +1848,15 @@ static void pci_bus_release_bridge_resources(struct pci_bus *bus,
 		if ((dev->class >> 8) != PCI_CLASS_BRIDGE_PCI)
 			continue;
 
-		if (rel_type == whole_subtree)
-			pci_bus_release_bridge_resources(b, type,
-						 whole_subtree);
+		if (rel_type != whole_subtree)
+			continue;
+
+		pci_bus_for_each_resource(b, res) {
+			if (res->parent != b_win)
+				continue;
+
+			pci_bus_release_bridge_resources(b, res, whole_subtree);
+		}
 	}
 
 	if (pci_is_root_bus(bus))
@@ -1885,7 +1866,7 @@ static void pci_bus_release_bridge_resources(struct pci_bus *bus,
 		return;
 
 	if ((rel_type == whole_subtree) || is_leaf_bridge)
-		pci_bridge_release_resources(bus, type);
+		pci_bridge_release_resources(bus, b_win);
 }
 
 static void pci_bus_dump_res(struct pci_bus *bus)
@@ -2282,9 +2263,13 @@ static void pci_prepare_next_assign_round(struct list_head *fail_head,
 	 * enough to contain child device resources.
 	 */
 	list_for_each_entry(fail_res, fail_head, list) {
-		pci_bus_release_bridge_resources(fail_res->dev->bus,
-						 fail_res->flags & PCI_RES_TYPE_MASK,
-						 rel_type);
+		struct pci_bus *bus = fail_res->dev->bus;
+		struct resource *b_win;
+
+		b_win = pbus_select_window_for_type(bus, fail_res->flags);
+		if (!b_win)
+			continue;
+		pci_bus_release_bridge_resources(bus, b_win, rel_type);
 	}
 
 	/* Restore size and flags */
-- 
2.39.5


