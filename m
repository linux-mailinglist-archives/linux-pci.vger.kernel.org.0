Return-Path: <linux-pci+bounces-34587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DDDB31D6C
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 17:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1107E1CE76D2
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 15:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB1D7261B;
	Fri, 22 Aug 2025 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FkMyLw+5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8151D2C0262;
	Fri, 22 Aug 2025 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874747; cv=none; b=fVxL8hLBeSkH/v6QShTXX9lI5u4H9L3LkzE8n7rqxR9GtLwIvoB718+q6VqWyaowcIzYWxek2g0ecPMVH4Ja9w7sFiKWCNh8uJNDRQMFoMsfgO5wuLNiCh3Vytva+q7WtZvLWDQTN1jTlNoYbSEF2oeAyRsP9wawlLeMG0pS9P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874747; c=relaxed/simple;
	bh=zEebpfWhIu4kEBCI6/4Upo0OygKQhbBhWc3ZzCti864=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SpCIKS1EvuLxTduOrEqLW2mOTlyRPsyj+4XZOjFjoAjOX+DYy4QxFjxODHfeFOWh/ynLiR6Co8KIkPanwk9HYXbqnCZouqgwiwpm51uA9Ucye0jJTYBNBuE+UOsOdK/K3YNnYEWkbWzTqzsxycFsRyvDhR0MMUGG2CkeZmlIQs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FkMyLw+5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755874745; x=1787410745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zEebpfWhIu4kEBCI6/4Upo0OygKQhbBhWc3ZzCti864=;
  b=FkMyLw+5zCjD5Decux8++2EVPLw/YL7Cbdo5UR6PS5g8SXaXKwhUfO+C
   VtxEqDY2T2dTI9VLMxJTnYarMwyDzuIM00FeNLiJdCBnG9kW24fpYlOY9
   xASSqaNM0ehx2kiwMFbuBquLerWjWOrShltQVbYziYleDOiCmdl7UEyPT
   hbzto9R6ovkGCWXaq7Em+qRlV/x7OXX7R599Wm2+OuhzbhzwF5xgEZ+BG
   9n9En9AG29PvIfho602oYo/65/6C7GfmoEZQvPyxhu4U1bIOb5wyL/urM
   3mSu6TIy8BYy8vkQ2c7sJIblp6NWHUfafsR3t7v/sahulY0hIT/kocXBj
   g==;
X-CSE-ConnectionGUID: sl+xw+4rRzagvPUAeuL4Yg==
X-CSE-MsgGUID: pE2HYdhMR6CuY5aTlh8Ulg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57201554"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="57201554"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:59:04 -0700
X-CSE-ConnectionGUID: LJ5O817yQ/6u/ta8++jQNg==
X-CSE-MsgGUID: DLoNXUW9R/asIEjMWY+u8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="199695276"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:58:59 -0700
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
Subject: [PATCH 18/24] PCI: Use pbus_select_window() in space available checker
Date: Fri, 22 Aug 2025 17:55:59 +0300
Message-Id: <20250822145605.18172-19-ilpo.jarvinen@linux.intel.com>
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

pbus_upstream_space_available() figures out the upstream bridge window
resources on its own. Migrate it to use pbus_select_window().

Note, pbus_select_window() -> pbus_select_window_for_type() calls
find_bus_resource_of_type() for root bus, which does not do parent
check similar to what pbus_upstream_space_available() did earlier, but
the difference does not matter because pbus_upstream_space_available()
itself stops when it encounters the root bus.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 63 ++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index dac0f0f0360b..281ca5c73c97 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1221,19 +1221,20 @@ static inline resource_size_t calculate_mem_align(resource_size_t *aligns,
 /**
  * pbus_upstream_space_available - Check no upstream resource limits allocation
  * @bus:	The bus
- * @mask:	Mask the resource flag, then compare it with type
- * @type:	The type of resource from bridge
+ * @res:	The resource to help to pick the correct bridge window
  * @size:	The size required from the bridge window
  * @align:	Required alignment for the resource
  *
  * Checks that @size can fit inside the upstream bridge resources that are
- * already assigned.
+ * already assigned. @res (its type) is used to select to correct upstream
+ * bridge window.
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


