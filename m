Return-Path: <linux-pci+bounces-18549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C6D9F3859
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 19:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B6716CF79
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFB9212B2D;
	Mon, 16 Dec 2024 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/bCEmTr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F11212B17;
	Mon, 16 Dec 2024 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371933; cv=none; b=stBQJBMz1OBIukhXxBoE/CChDdjr7pBdaVftpVnLdcGU/WuPgR5qf59p4vbM0EI6cflFCvnQnCQ6/vsvOMsz+A1uufuCM5grSfoil4mNBlNLY1yES4sE6JP0+NcNCXEQU2K86337FTcffIBqOrMHLLMIgu2EdvoeYliWwsNlHiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371933; c=relaxed/simple;
	bh=GJVoSsGJMmfHipuU2GiFncTF/ThBMJDBl4ICY6KnljA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0BF2Ba7ujzj7Rn9HSM/R/g9ow2mU7OFCOyuy2+0CPntiHHBIzqrhfU8OjGZgMHfxaW90F0qmfUIA0dPRbLY1YpXLkxCqhYDpG4KFZ6uj75JCkmPEljKacO2usO5sC0wZdvc2x4zjRQPXHxNkjRkbpCh3j5+feANaf49ynu5BKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/bCEmTr; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371931; x=1765907931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GJVoSsGJMmfHipuU2GiFncTF/ThBMJDBl4ICY6KnljA=;
  b=Y/bCEmTrZJrR3bHeUL+dPFnDlGX9qAsbqcGPoI+xQfT3H0mVsvt5yEFS
   fh/nWBxBcT3Z+JqG9MVuQyca/iBymTuce4ljDuH/2KUv/z0geEPptkZdb
   FkZZgdqD0jima2nimeg0Uf73upA4CZh5q1tgALhA13MU4vYRB0df0zviY
   sExMN/Qe94qfFQKmpqWC9NeQrfX8+QM5lx102jui0gCH7czrr/EdNAJeb
   hTZwZgA0kC4hWbS6pIFzqMCEriJfGRPbjAHKB98siCf9ZzcxEXc43NZ/Y
   wC6qwPypH+33buw1DGSWIy7WzOBhN/iCck1k+AvdA+o/JCB5jjIwws+LF
   w==;
X-CSE-ConnectionGUID: eNgACQN+QnKFycq4f3QIsA==
X-CSE-MsgGUID: VCiMBUPtR7K9S0T/L49CxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="57250990"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="57250990"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:58:40 -0800
X-CSE-ConnectionGUID: VuyZKZT8RD6hocPrXKqwGw==
X-CSE-MsgGUID: frhC2yjyT1CnwIDe5IKhXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101419077"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:58:37 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 14/25] PCI: Use while loop and break instead of gotos
Date: Mon, 16 Dec 2024 19:56:21 +0200
Message-Id: <20241216175632.4175-15-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_assign_unassigned_root_bus_resources() and
pci_assign_unassigned_bridge_resources() contain ad-hoc loops using
backwards goto and gotos out of the loop. Replace them with while loops
and break statements.

While reindenting the loop bodies, do a few coding style tweaks (add
braces & remove parenthesis).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 212 ++++++++++++++++++++--------------------
 1 file changed, 106 insertions(+), 106 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ba935a050be3..bbe3472cfba9 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2162,78 +2162,79 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 			 max_depth, pci_try_num);
 	}
 
-again:
-	/*
-	 * Last try will use add_list, otherwise will try good to have as must
-	 * have, so can realloc parent bridge resource
-	 */
-	if (tried_times + 1 == pci_try_num)
-		add_list = &realloc_head;
-	/*
-	 * Depth first, calculate sizes and alignments of all subordinate buses.
-	 */
-	__pci_bus_size_bridges(bus, add_list);
+	while (1) {
+		/*
+		 * Last try will use add_list, otherwise will try good to
+		 * have as must have, so can realloc parent bridge resource
+		 */
+		if (tried_times + 1 == pci_try_num)
+			add_list = &realloc_head;
+		/*
+		 * Depth first, calculate sizes and alignments of all
+		 * subordinate buses.
+		 */
+		__pci_bus_size_bridges(bus, add_list);
 
-	pci_root_bus_distribute_available_resources(bus, add_list);
+		pci_root_bus_distribute_available_resources(bus, add_list);
 
-	/* Depth last, allocate resources and update the hardware. */
-	__pci_bus_assign_resources(bus, add_list, &fail_head);
-	if (add_list)
-		BUG_ON(!list_empty(add_list));
-	tried_times++;
+		/* Depth last, allocate resources and update the hardware. */
+		__pci_bus_assign_resources(bus, add_list, &fail_head);
+		if (add_list)
+			BUG_ON(!list_empty(add_list));
+		tried_times++;
 
-	/* Any device complain? */
-	if (list_empty(&fail_head))
-		goto dump;
+		/* Any device complain? */
+		if (list_empty(&fail_head))
+			break;
 
-	if (tried_times >= pci_try_num) {
-		if (enable_local == undefined)
-			dev_info(&bus->dev, "Some PCI device resources are unassigned, try booting with pci=realloc\n");
-		else if (enable_local == auto_enabled)
-			dev_info(&bus->dev, "Automatically enabled pci realloc, if you have problem, try booting with pci=realloc=off\n");
+		if (tried_times >= pci_try_num) {
+			if (enable_local == undefined) {
+				dev_info(&bus->dev,
+					 "Some PCI device resources are unassigned, try booting with pci=realloc\n");
+			} else if (enable_local == auto_enabled) {
+				dev_info(&bus->dev,
+					 "Automatically enabled pci realloc, if you have problem, try booting with pci=realloc=off\n");
+			}
+			free_list(&fail_head);
+			break;
+		}
 
-		free_list(&fail_head);
-		goto dump;
-	}
+		dev_info(&bus->dev, "No. %d try to assign unassigned res\n",
+			 tried_times + 1);
 
-	dev_info(&bus->dev, "No. %d try to assign unassigned res\n",
-		 tried_times + 1);
+		/* Third times and later will not check if it is leaf */
+		if (tried_times + 1 > 2)
+			rel_type = whole_subtree;
+
+		/*
+		 * Try to release leaf bridge's resources that doesn't fit
+		 * resource of child device under that bridge.
+		 */
+		list_for_each_entry(fail_res, &fail_head, list) {
+			pci_bus_release_bridge_resources(fail_res->dev->bus,
+							 fail_res->flags & PCI_RES_TYPE_MASK,
+							 rel_type);
+		}
 
-	/* Third times and later will not check if it is leaf */
-	if ((tried_times + 1) > 2)
-		rel_type = whole_subtree;
+		/* Restore size and flags */
+		list_for_each_entry(fail_res, &fail_head, list) {
+			struct resource *res = fail_res->res;
+			int idx;
 
-	/*
-	 * Try to release leaf bridge's resources that doesn't fit resource of
-	 * child device under that bridge.
-	 */
-	list_for_each_entry(fail_res, &fail_head, list)
-		pci_bus_release_bridge_resources(fail_res->dev->bus,
-						 fail_res->flags & PCI_RES_TYPE_MASK,
-						 rel_type);
+			res->start = fail_res->start;
+			res->end = fail_res->end;
+			res->flags = fail_res->flags;
 
-	/* Restore size and flags */
-	list_for_each_entry(fail_res, &fail_head, list) {
-		struct resource *res = fail_res->res;
-		int idx;
-
-		res->start = fail_res->start;
-		res->end = fail_res->end;
-		res->flags = fail_res->flags;
-
-		if (pci_is_bridge(fail_res->dev)) {
-			idx = pci_resource_num(fail_res->dev, res);
-			if (idx >= PCI_BRIDGE_RESOURCES &&
-			    idx <= PCI_BRIDGE_RESOURCE_END)
-				res->flags = 0;
+			if (pci_is_bridge(fail_res->dev)) {
+				idx = pci_resource_num(fail_res->dev, res);
+				if (idx >= PCI_BRIDGE_RESOURCES &&
+				    idx <= PCI_BRIDGE_RESOURCE_END)
+					res->flags = 0;
+			}
 		}
+		free_list(&fail_head);
 	}
-	free_list(&fail_head);
 
-	goto again;
-
-dump:
-	/* Dump the resource on buses */
 	pci_bus_dump_resources(bus);
 }
 
@@ -2261,62 +2262,61 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 	struct pci_dev_resource *fail_res;
 	int retval;
 
-again:
-	__pci_bus_size_bridges(parent, &add_list);
+	while (1) {
+		__pci_bus_size_bridges(parent, &add_list);
 
-	/*
-	 * Distribute remaining resources (if any) equally between hotplug
-	 * bridges below.  This makes it possible to extend the hierarchy
-	 * later without running out of resources.
-	 */
-	pci_bridge_distribute_available_resources(bridge, &add_list);
+		/*
+		 * Distribute remaining resources (if any) equally between
+		 * hotplug bridges below. This makes it possible to extend
+		 * the hierarchy later without running out of resources.
+		 */
+		pci_bridge_distribute_available_resources(bridge, &add_list);
 
-	__pci_bridge_assign_resources(bridge, &add_list, &fail_head);
-	BUG_ON(!list_empty(&add_list));
-	tried_times++;
+		__pci_bridge_assign_resources(bridge, &add_list, &fail_head);
+		BUG_ON(!list_empty(&add_list));
+		tried_times++;
 
-	if (list_empty(&fail_head))
-		goto enable_all;
+		if (list_empty(&fail_head))
+			break;
 
-	if (tried_times >= 2) {
-		/* Still fail, don't need to try more */
-		free_list(&fail_head);
-		goto enable_all;
-	}
+		if (tried_times >= 2) {
+			/* Still fail, don't need to try more */
+			free_list(&fail_head);
+			break;
+		}
 
-	printk(KERN_DEBUG "PCI: No. %d try to assign unassigned res\n",
-			 tried_times + 1);
+		printk(KERN_DEBUG "PCI: No. %d try to assign unassigned res\n",
+				 tried_times + 1);
 
-	/*
-	 * Try to release leaf bridge's resources that aren't big enough
-	 * to contain child device resources.
-	 */
-	list_for_each_entry(fail_res, &fail_head, list)
-		pci_bus_release_bridge_resources(fail_res->dev->bus,
-						 fail_res->flags & PCI_RES_TYPE_MASK,
-						 whole_subtree);
+		/*
+		 * Try to release leaf bridge's resources that aren't big
+		 * enough to contain child device resources.
+		 */
+		list_for_each_entry(fail_res, &fail_head, list) {
+			pci_bus_release_bridge_resources(fail_res->dev->bus,
+							 fail_res->flags & PCI_RES_TYPE_MASK,
+							 whole_subtree);
+		}
 
-	/* Restore size and flags */
-	list_for_each_entry(fail_res, &fail_head, list) {
-		struct resource *res = fail_res->res;
-		int idx;
-
-		res->start = fail_res->start;
-		res->end = fail_res->end;
-		res->flags = fail_res->flags;
-
-		if (pci_is_bridge(fail_res->dev)) {
-			idx = pci_resource_num(fail_res->dev, res);
-			if (idx >= PCI_BRIDGE_RESOURCES &&
-			    idx <= PCI_BRIDGE_RESOURCE_END)
-				res->flags = 0;
+		/* Restore size and flags */
+		list_for_each_entry(fail_res, &fail_head, list) {
+			struct resource *res = fail_res->res;
+			int idx;
+
+			res->start = fail_res->start;
+			res->end = fail_res->end;
+			res->flags = fail_res->flags;
+
+			if (pci_is_bridge(fail_res->dev)) {
+				idx = pci_resource_num(fail_res->dev, res);
+				if (idx >= PCI_BRIDGE_RESOURCES &&
+				    idx <= PCI_BRIDGE_RESOURCE_END)
+					res->flags = 0;
+			}
 		}
+		free_list(&fail_head);
 	}
-	free_list(&fail_head);
-
-	goto again;
 
-enable_all:
 	retval = pci_reenable_device(bridge);
 	if (retval)
 		pci_err(bridge, "Error reenabling bridge (%d)\n", retval);
-- 
2.39.5


