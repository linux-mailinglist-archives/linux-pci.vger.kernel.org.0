Return-Path: <linux-pci+bounces-43431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F157ACD13CD
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F67C30B1D7E
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACA433DEF7;
	Fri, 19 Dec 2025 17:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LQP5F8Sl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A143451BB;
	Fri, 19 Dec 2025 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166181; cv=none; b=JOFdn0FlFef3HuGt3iyTSP1Yk4M17tWd37kYNAklK/vQg0WAq1ourlFrrWs5F2JVIDgXG378DLOzRtLDHSZO2FrtMYuMWnlOjnA+TqEbAWgucUaCXFVre4PZX36yE1KewG5+gOl/hP/8rpjbxR1Hv0Rm734HgWhqhMbmhmb0t4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166181; c=relaxed/simple;
	bh=Jm3ppOxGj0iK8GAIiYOxZVVzNJ6YjdAHxuMeaEzT15A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SFm/NOKoKDC86GuipTpBixO0MepVX64KUYs0pfehU+LEmPRK4r5jxtwaGP2ycXCJotHXpalkUmZziVezf9mxE8KB0jyKpl1Vfkewa8vtRJaxF8LGZLHLmQnImixssKe1xJbI0ZTOsTKnvIyx2pdoC/sQ7ZOBB/T0No5B2KOcgWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LQP5F8Sl; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166178; x=1797702178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jm3ppOxGj0iK8GAIiYOxZVVzNJ6YjdAHxuMeaEzT15A=;
  b=LQP5F8SlYqmW1ZnJxthbzXyGWaARX6fxgjBBw0OSQHg4TV38Dy3aTOP/
   1L6lGQpaJmL2Kg91/b/eZnxGryaCFDFSVEd/jj0Gsg6Ymvcd9AN/iLofa
   99VGTWvBEc7zSLFik6jy3WQvd6pFDcJJCHv2TIyWLQxX+yiaohcxCsf4T
   zf9q2/SfnXBKy7eXfbyVzg421guYuq8de6RVP3b5zswu4H2Olm+yY4Dgv
   oc3M0nElqnxeCJJdCaN3Up+SZy078y6ryhB1chTVjR4eVzvInXAiSO6ev
   JeWZKkHj0b8MN7CswrXNevboNZB8O9GayVNaKJ4G2xXBqH9Ea6DwaeEfw
   g==;
X-CSE-ConnectionGUID: e2woBAT7TLCJfzf4T47S1Q==
X-CSE-MsgGUID: jRf/bRfrT66zso1QEiAN4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="67880700"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="67880700"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:42:58 -0800
X-CSE-ConnectionGUID: SDL0FqBqQCW/Gd2WS+a5Kg==
X-CSE-MsgGUID: JsAjfUJ0Tv+VdSUfmQqIAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="198497113"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:42:55 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 16/23] PCI: Properly prefix struct pci_dev_resource handling functions
Date: Fri, 19 Dec 2025 19:40:29 +0200
Message-Id: <20251219174036.16738-17-ilpo.jarvinen@linux.intel.com>
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

setup-bus.c has static functions for handling struct pci_dev_resource
related operation which have no prefixes. Add prefixes to those
function names as add_to_list() will be needed in another file by an
upcoming change.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

I'm open to naming these with a different prefix, as "devres" is
already used in the other context. The current name comes from the
struct pci_dev_resource that holds information during resource fitting
and assignment algorithm (mainly old resource addresses, optional
size).
---
 drivers/pci/setup-bus.c | 114 +++++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 53 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index bbc615d85c88..3cc26fede31a 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -49,7 +49,7 @@ struct pci_dev_resource {
 	unsigned long flags;
 };
 
-static void free_list(struct list_head *head)
+static void pci_dev_res_free_list(struct list_head *head)
 {
 	struct pci_dev_resource *dev_res, *tmp;
 
@@ -60,16 +60,17 @@ static void free_list(struct list_head *head)
 }
 
 /**
- * add_to_list() - Add a new resource tracker to the list
+ * pci_dev_res_add_to_list() - Add a new resource tracker to the list
  * @head:	Head of the list
  * @dev:	Device to which the resource belongs
  * @res:	Resource to be tracked
  * @add_size:	Additional size to be optionally added to the resource
  * @min_align:	Minimum memory window alignment
  */
-static int add_to_list(struct list_head *head, struct pci_dev *dev,
-		       struct resource *res, resource_size_t add_size,
-		       resource_size_t min_align)
+static int pci_dev_res_add_to_list(struct list_head *head, struct pci_dev *dev,
+				  struct resource *res,
+				  resource_size_t add_size,
+				  resource_size_t min_align)
 {
 	struct pci_dev_resource *tmp;
 
@@ -90,7 +91,8 @@ static int add_to_list(struct list_head *head, struct pci_dev *dev,
 	return 0;
 }
 
-static void remove_from_list(struct list_head *head, struct resource *res)
+static void pci_dev_res_remove_from_list(struct list_head *head,
+					 struct resource *res)
 {
 	struct pci_dev_resource *dev_res, *tmp;
 
@@ -125,7 +127,7 @@ static resource_size_t get_res_add_size(struct list_head *head,
 	return dev_res ? dev_res->add_size : 0;
 }
 
-static void restore_dev_resource(struct pci_dev_resource *dev_res)
+static void pci_dev_res_restore(struct pci_dev_resource *dev_res)
 {
 	struct resource *res = dev_res->res;
 	struct pci_dev *dev = dev_res->dev;
@@ -498,9 +500,9 @@ static void assign_requested_resources_sorted(struct list_head *head,
 
 		if (pci_assign_resource(dev, idx)) {
 			if (fail_head) {
-				add_to_list(fail_head, dev, res,
-					    0 /* don't care */,
-					    0 /* don't care */);
+				pci_dev_res_add_to_list(fail_head, dev, res,
+							0 /* don't care */,
+							0 /* don't care */);
 			}
 		}
 	}
@@ -612,8 +614,9 @@ static void __assign_resources_sorted(struct list_head *head,
 
 	/* Save original start, end, flags etc at first */
 	list_for_each_entry(dev_res, head, list) {
-		if (add_to_list(&save_head, dev_res->dev, dev_res->res, 0, 0)) {
-			free_list(&save_head);
+		if (pci_dev_res_add_to_list(&save_head, dev_res->dev,
+					    dev_res->res, 0, 0)) {
+			pci_dev_res_free_list(&save_head);
 			goto assign;
 		}
 	}
@@ -666,8 +669,9 @@ static void __assign_resources_sorted(struct list_head *head,
 	if (list_empty(&local_fail_head)) {
 		/* Remove head list from realloc_head list */
 		list_for_each_entry(dev_res, head, list)
-			remove_from_list(realloc_head, dev_res->res);
-		free_list(&save_head);
+			pci_dev_res_remove_from_list(realloc_head,
+						     dev_res->res);
+		pci_dev_res_free_list(&save_head);
 		goto out;
 	}
 
@@ -680,10 +684,10 @@ static void __assign_resources_sorted(struct list_head *head,
 			if (resource_assigned(res))
 				continue;
 
-			restore_dev_resource(save_res);
+			pci_dev_res_restore(save_res);
 		}
-		free_list(&local_fail_head);
-		free_list(&save_head);
+		pci_dev_res_free_list(&local_fail_head);
+		pci_dev_res_free_list(&save_head);
 		goto out;
 	}
 
@@ -696,26 +700,26 @@ static void __assign_resources_sorted(struct list_head *head,
 		if (resource_assigned(res) &&
 		    !pci_need_to_release(fail_type, res)) {
 			/* Remove it from realloc_head list */
-			remove_from_list(realloc_head, res);
-			remove_from_list(&save_head, res);
+			pci_dev_res_remove_from_list(realloc_head, res);
+			pci_dev_res_remove_from_list(&save_head, res);
 			list_del(&dev_res->list);
 			kfree(dev_res);
 		}
 	}
 
-	free_list(&local_fail_head);
+	pci_dev_res_free_list(&local_fail_head);
 	/* Release assigned resource */
 	list_for_each_entry(dev_res, head, list) {
 		res = dev_res->res;
 		dev = dev_res->dev;
 
 		pci_release_resource(dev, pci_resource_num(dev, res));
-		restore_dev_resource(dev_res);
+		pci_dev_res_restore(dev_res);
 	}
 	/* Restore start/end/flags from saved list */
 	list_for_each_entry(save_res, &save_head, list)
-		restore_dev_resource(save_res);
-	free_list(&save_head);
+		pci_dev_res_restore(save_res);
+	pci_dev_res_free_list(&save_head);
 
 	/* Satisfy the must-have resource requests */
 	assign_requested_resources_sorted(head, NULL, false);
@@ -734,15 +738,15 @@ static void __assign_resources_sorted(struct list_head *head,
 			continue;
 
 		if (fail_head) {
-			add_to_list(fail_head, dev, res,
-				    0 /* don't care */,
-				    0 /* don't care */);
+			pci_dev_res_add_to_list(fail_head, dev, res,
+						0 /* don't care */,
+						0 /* don't care */);
 		}
 
 		reset_resource(dev, res);
 	}
 
-	free_list(head);
+	pci_dev_res_free_list(head);
 }
 
 static void pdev_assign_resources_sorted(struct pci_dev *dev,
@@ -1183,8 +1187,8 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t add_size,
 	b_res->flags |= IORESOURCE_STARTALIGN;
 	if (bus->self && size1 > size0 && realloc_head) {
 		b_res->flags &= ~IORESOURCE_DISABLED;
-		add_to_list(realloc_head, bus->self, b_res, size1-size0,
-			    min_align);
+		pci_dev_res_add_to_list(realloc_head, bus->self, b_res,
+					size1 - size0, min_align);
 		pci_info(bus->self, "bridge window %pR to %pR add_size %llx\n",
 			 b_res, &bus->busn_res,
 			 (unsigned long long) size1 - size0);
@@ -1293,7 +1297,7 @@ static bool pbus_size_mem_optional(struct pci_dev *dev, int resno,
 	}
 
 	/* Put SRIOV requested res to the optional list */
-	add_to_list(realloc_head, dev, res, 0, align);
+	pci_dev_res_add_to_list(realloc_head, dev, res, 0, align);
 	*children_add_size += r_size;
 	*add_align = max(align, *add_align);
 
@@ -1411,7 +1415,8 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 	if (bus->self && realloc_head && (size1 > size0 || add_align > min_align)) {
 		b_res->flags &= ~IORESOURCE_DISABLED;
 		add_size = size1 > size0 ? size1 - size0 : 0;
-		add_to_list(realloc_head, bus->self, b_res, add_size, add_align);
+		pci_dev_res_add_to_list(realloc_head, bus->self, b_res,
+					add_size, add_align);
 		pci_info(bus->self, "bridge window %pR to %pR add_size %llx add_align %llx\n",
 			   b_res, &bus->busn_res,
 			   (unsigned long long) add_size,
@@ -1447,8 +1452,9 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 	b_res->flags |= IORESOURCE_IO | IORESOURCE_STARTALIGN;
 	if (realloc_head) {
 		b_res->end -= pci_cardbus_io_size;
-		add_to_list(realloc_head, bridge, b_res, pci_cardbus_io_size,
-			    pci_cardbus_io_size);
+		pci_dev_res_add_to_list(realloc_head, bridge, b_res,
+					pci_cardbus_io_size,
+					pci_cardbus_io_size);
 	}
 
 handle_b_res_1:
@@ -1459,8 +1465,9 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 	b_res->flags |= IORESOURCE_IO | IORESOURCE_STARTALIGN;
 	if (realloc_head) {
 		b_res->end -= pci_cardbus_io_size;
-		add_to_list(realloc_head, bridge, b_res, pci_cardbus_io_size,
-			    pci_cardbus_io_size);
+		pci_dev_res_add_to_list(realloc_head, bridge, b_res,
+					pci_cardbus_io_size,
+					pci_cardbus_io_size);
 	}
 
 handle_b_res_2:
@@ -1494,8 +1501,9 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 				    IORESOURCE_STARTALIGN;
 		if (realloc_head) {
 			b_res->end -= pci_cardbus_mem_size;
-			add_to_list(realloc_head, bridge, b_res,
-				    pci_cardbus_mem_size, pci_cardbus_mem_size);
+			pci_dev_res_add_to_list(realloc_head, bridge, b_res,
+						pci_cardbus_mem_size,
+						pci_cardbus_mem_size);
 		}
 
 		/* Reduce that to half */
@@ -1510,8 +1518,8 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 	b_res->flags |= IORESOURCE_MEM | IORESOURCE_STARTALIGN;
 	if (realloc_head) {
 		b_res->end -= b_res_3_size;
-		add_to_list(realloc_head, bridge, b_res, b_res_3_size,
-			    pci_cardbus_mem_size);
+		pci_dev_res_add_to_list(realloc_head, bridge, b_res,
+					b_res_3_size, pci_cardbus_mem_size);
 	}
 
 handle_done:
@@ -1997,7 +2005,7 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 
 	/* If the resource is part of the add_list, remove it now */
 	if (add_list)
-		remove_from_list(add_list, res);
+		pci_dev_res_remove_from_list(add_list, res);
 }
 
 static void remove_dev_resource(struct resource *avail, struct pci_dev *dev,
@@ -2249,9 +2257,9 @@ static void pci_prepare_next_assign_round(struct list_head *fail_head,
 
 	/* Restore size and flags */
 	list_for_each_entry(fail_res, fail_head, list)
-		restore_dev_resource(fail_res);
+		pci_dev_res_restore(fail_res);
 
-	free_list(fail_head);
+	pci_dev_res_free_list(fail_head);
 }
 
 /*
@@ -2298,7 +2306,7 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 		/* Depth last, allocate resources and update the hardware. */
 		__pci_bus_assign_resources(bus, add_list, &fail_head);
 		if (WARN_ON_ONCE(add_list && !list_empty(add_list)))
-			free_list(add_list);
+			pci_dev_res_free_list(add_list);
 		tried_times++;
 
 		/* Any device complain? */
@@ -2313,7 +2321,7 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 				dev_info(&bus->dev,
 					 "Automatically enabled pci realloc, if you have problem, try booting with pci=realloc=off\n");
 			}
-			free_list(&fail_head);
+			pci_dev_res_free_list(&fail_head);
 			break;
 		}
 
@@ -2361,7 +2369,7 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 
 		__pci_bridge_assign_resources(bridge, &add_list, &fail_head);
 		if (WARN_ON_ONCE(!list_empty(&add_list)))
-			free_list(&add_list);
+			pci_dev_res_free_list(&add_list);
 		tried_times++;
 
 		if (list_empty(&fail_head))
@@ -2369,7 +2377,7 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 
 		if (tried_times >= 2) {
 			/* Still fail, don't need to try more */
-			free_list(&fail_head);
+			pci_dev_res_free_list(&fail_head);
 			break;
 		}
 
@@ -2410,7 +2418,7 @@ static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *
 
 		/* Ignore BARs which are still in use */
 		if (!res->child) {
-			ret = add_to_list(saved, bridge, res, 0, 0);
+			ret = pci_dev_res_add_to_list(saved, bridge, res, 0, 0);
 			if (ret)
 				return ret;
 
@@ -2432,12 +2440,12 @@ static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *
 	__pci_bus_size_bridges(bridge->subordinate, &added);
 	__pci_bridge_assign_resources(bridge, &added, &failed);
 	if (WARN_ON_ONCE(!list_empty(&added)))
-		free_list(&added);
+		pci_dev_res_free_list(&added);
 
 	if (!list_empty(&failed)) {
 		if (pci_required_resource_failed(&failed, type))
 			ret = -ENOSPC;
-		free_list(&failed);
+		pci_dev_res_free_list(&failed);
 		if (ret)
 			return ret;
 
@@ -2485,7 +2493,7 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 		if (b_win != pbus_select_window(bus, r))
 			continue;
 
-		ret = add_to_list(&saved, pdev, r, 0, 0);
+		ret = pci_dev_res_add_to_list(&saved, pdev, r, 0, 0);
 		if (ret)
 			goto restore;
 		pci_release_resource(pdev, i);
@@ -2503,7 +2511,7 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 
 out:
 	up_read(&pci_bus_sem);
-	free_list(&saved);
+	pci_dev_res_free_list(&saved);
 	return ret;
 
 restore:
@@ -2519,7 +2527,7 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 			pci_release_resource(dev, i);
 		}
 
-		restore_dev_resource(dev_res);
+		pci_dev_res_restore(dev_res);
 
 		ret = pci_claim_resource(dev, i);
 		if (ret)
@@ -2551,6 +2559,6 @@ void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
 	up_read(&pci_bus_sem);
 	__pci_bus_assign_resources(bus, &add_list, NULL);
 	if (WARN_ON_ONCE(!list_empty(&add_list)))
-		free_list(&add_list);
+		pci_dev_res_free_list(&add_list);
 }
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bus_resources);
-- 
2.39.5


