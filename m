Return-Path: <linux-pci+bounces-34592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAEEB31DAB
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 17:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0695A05C09
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 15:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3092134A305;
	Fri, 22 Aug 2025 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eDAg9NE3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B757307AEF;
	Fri, 22 Aug 2025 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874794; cv=none; b=Hk7Ow6qpMSvifWxz2gU04DbTSOdGvUreEV6IwNJdIiXkZwbts0VhaEWObgWncL7CyyE8A4SQbRCW4Y0xlYRrEhb+CGENwNW1eo3NAmqLnSmjCmwGfSHWJg8lRTFnE7gf2yI3+Tjy1S+s2akIkKMZ6ZHGTz1oOoLqRUAZ0TdVB/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874794; c=relaxed/simple;
	bh=LA/Wi//KofVB6JuAktPoP6oeJFceP9LDqmAtl8M/Pho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJviYQCVpQadi4mZmkbtniFmfIRwYqtAzOzZ7dQDYxifa3btJGgQL76eRZwtlBn1GfcXsXt1T8I1nDue+uJ44lNkxmP/UFPmcOlSKyjWsJ0IAl/lYiDBg7t37l4ifI5D66XrY9jioVrUJbMsi3d0P+qNDp1Cgt1LH8eeM5Owufg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eDAg9NE3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755874793; x=1787410793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LA/Wi//KofVB6JuAktPoP6oeJFceP9LDqmAtl8M/Pho=;
  b=eDAg9NE3S0uS146e4DRuCRMgZGo8gzaWTriStjEduHP+pv+boUfNZ4fM
   rGz/jGktYD1kKcHDE/U0GzhrCZV63gX5YortI2cQaXfi2pIT7iCMJMvvf
   LUjYAmePjzQroDbUIMHJ8sQk1d4uwCsHmFrZB65IjISCEz5lYOh7JkPjI
   XcRqhSKLI+6F2LgZXlHdaY9W6eCmqmtz91UXEJVPeTTur17Z9Tja6ivBT
   ckL0GuwncdOWxHpFQh1WZEoPu51dfXTOoI7Inxu0FuaUvCXX6cObnRoT8
   TI8ZKIJbc4J2XKk2SGiQosr2XXp99L01ppkjT5B/6yJFzpI0+DdxZp2W2
   A==;
X-CSE-ConnectionGUID: ZaCLv8SARESeW1NaUwvOfA==
X-CSE-MsgGUID: g1ytS3B2Q+O0xp8xfID2Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="75640759"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="75640759"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:59:53 -0700
X-CSE-ConnectionGUID: XUYJVNexT5mA6fsjbzP14w==
X-CSE-MsgGUID: V9nZCPRqR/aPpyAtr6/8sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="172986963"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:59:47 -0700
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
Subject: [PATCH 23/24] PCI: Pass bridge window to pci_bus_release_bridge_resources()
Date: Fri, 22 Aug 2025 17:56:04 +0300
Message-Id: <20250822145605.18172-24-ilpo.jarvinen@linux.intel.com>
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

pci_bus_release_bridge_resources() takes type, which is converted
into a bridge window resource in pci_bridge_release_resources().

Find out the correct bridge window for resource whose assignment failed.
Pass that bridge window to pci_bus_release_bridge_resources() instead of
passing the type. When recursing to subordinate, check which bridge
windows have to be released and recurse for each.

For now, use pbus_select_window_for_type() instead of
pbus_select_window() because non-bridge window resources still have
their flags reset which destroys the type information from the struct
resource. The struct pci_dev_resource holds a copy of the flags which
are used instead.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 69 ++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f5b0274bde0a..9c69a84f2b23 100644
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


