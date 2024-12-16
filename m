Return-Path: <linux-pci+bounces-18560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BB09F387E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 19:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9851892F1E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE07D2066DD;
	Mon, 16 Dec 2024 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KNJZK6XY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52D5207E03;
	Mon, 16 Dec 2024 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372010; cv=none; b=iWIDV2BAcpux6ypMxmTIBzqsWHaU5uOSMnPdjusRixlVGImT8XKTOJCKvw2XmyCYiPNxx3zjdKC5UKPMYg0DozVuQQWz0qeQMOP3tqjBKwT4W/6tyKOoA6ptHJORBTguQ5J+omfVHGE89sSaNG+EgLHxLpdQMf59w1TYhKpWkq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372010; c=relaxed/simple;
	bh=ZkDZKNUK/mfZmLFHCwfTJsPuuPn5Y54Qwl0JDJp0hGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4RSfdNyhEFhKdh+W390yTd3N933wug255E/87SOBguo4t2v4FRTAUVOmLCbgGywhmrneCzupb3Xz2aIs4L9qk7QVjaJ+BxOSsQqEwtiX0dFSew98kK2iDQFwbRPzgg6x0KGVpUD7EHAXzqEaIyjqP+ClUitxfCIVLYtP4VxI8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KNJZK6XY; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734372009; x=1765908009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZkDZKNUK/mfZmLFHCwfTJsPuuPn5Y54Qwl0JDJp0hGA=;
  b=KNJZK6XYKTggDKm/JAglhhvlYe3350fAIdA8FUOrl+JAYQWmZkgIh8ZP
   4DQfGzlidyxoWHrmPBFk46WNuOfDx8Iu4QLYH1lDmGhepxjAnuk7KzzXZ
   EDIo6zmWFinsd7bwG5/IQJyzGwZlUc++/JRpoekV2lcdletXGRZuoOEzl
   2lBPkmYrxUkrXdfbx/KEFO02DLgaWYbFlGx50dPXlgZjNRw3ctBokFu94
   +BE7e67sFxAvgIRlcKo1uF6mx4YyU34n3ZRK1hloZj5zAjdD0lqi9THig
   7YZlI89zU0Gu796H0lQIgISYe7A5mhFKctUW4x2zyPv8pdJrvzn4BfN5K
   g==;
X-CSE-ConnectionGUID: hUmSGz6eRHe8chsdoKD1xQ==
X-CSE-MsgGUID: dhUm+npuT16n2TBFSpOZWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="52293386"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="52293386"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 10:00:08 -0800
X-CSE-ConnectionGUID: ufQi/Xp/SGKWxgAcC0L7QQ==
X-CSE-MsgGUID: 87AdKbF1Sx6RtXaNWRGc9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120532312"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 10:00:05 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jia Yao <jia.yao@intel.com>
Subject: [PATCH 25/25] PCI: Rework optional resource handling
Date: Mon, 16 Dec 2024 19:56:32 +0200
Message-Id: <20241216175632.4175-26-ilpo.jarvinen@linux.intel.com>
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

Remove and rescan cycle can result in not failure to assign a bridge
windows if it becomes larger than before the remove. The bridge window
size will include space for disabled Expansion ROM, which can causes
the bridge window to not fit anymore into the same address space slot
on rescan if the Expansion ROM resource was not assigned before the
remove. In addition, the optional resource handling is not internally
consistent.

The resource fitting logic supports three main types of optional
resources:

- IOV BARs
- Expansion ROMs
- Bridge window size variation due to optional resources

In addition to the above, resizable BARs beyond their current size will
require handling optional variation in resource sizes within the
resource fitting algorithm (not yet done by the resource fitting code).

There are multiple inconsistencies related to optional resource
handling:

a) The allocation failure of disabled expansion ROM requires special
   case inside assign_requested_resources_sorted().

b) The optionality of disabled expansion ROM is not considered during
   bridge window sizing in pbus_size_mem().

c) Setting resource size to zero for optional resource in
   pbus_size_mem() is problematic because it makes also the alignment
   invalid, which is checked by pdev_sort_resources().

   Optional IOV resources have their size set to zero by
   pbus_size_mem() but the information about size is stored externally
   into the struct pci_sriov and complex call-chain trickery in
   pci_resource_alignment() ensures IOV resources return a valid
   alignment despite having zero resource size. A solution that is
   specific to IOV resources makes it hard to use the same solution for
   other types of resources such as expansion ROM.

Simply changing only pbus_size_mem() is not sufficient to fully address
the main issue because it would introduce disparity between bridge
window sizing and resource allocation. Due size based ordering of
resource list during assignment loop, an Expansion ROM resource could
steal space from some other resource and make the other resource not
fit if the Expansion ROM is larger than the other resource. Thus, the
resource assignment functions need to be changed as well.

Make optional resource handling more straightforwards. Use
pci_resource_is_optional() to determine if a resource is optional or
not in both bridge window sizing and assignment failure classification
to ensure they always align. Indicate with a parameter to
assign_requested_resources_sorted() whether it should attempt to
allocate optional resources or not.

Always try first to assign all resources (also when realloc_head is not
provided). This is required for calls from
pci_assign_unassigned_root_bus_resources() that provides realloc_head
only with some of its iterations.

Non-bridge-window optional resources in realloc_head now have add_size
0. This condition has to be detected in reassign_resources_sorted()
before reassigning them (which would fail as there is no size change).
Removing add_size=0 optional resources entirely from realloc_head might
eventually be doable but further rework in __assign_resources_sorted()
is needed first to support such a change.

Reported-by: Jia Yao <jia.yao@intel.com>
Tested-by: Jia Yao <jia.yao@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 89 +++++++++++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index b61f24a5cfa5..802643a4de47 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -276,13 +276,14 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 		add_size = add_res->add_size;
 		align = add_res->min_align;
 		if (!res->parent) {
-			resource_set_range(res, align, add_size);
+			resource_set_range(res, align,
+					   resource_size(res) + add_size);
 			if (pci_assign_resource(dev, idx)) {
 				pci_dbg(dev,
 					"%s %pR: ignoring failure in optional allocation\n",
 					res_name, res);
 			}
-		} else {
+		} else if (add_size > 0) {
 			res->flags |= add_res->flags &
 				 (IORESOURCE_STARTALIGN|IORESOURCE_SIZEALIGN);
 			if (pci_reassign_resource(dev, idx, add_size, align))
@@ -302,38 +303,38 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
  * @head:	Head of the list tracking requests for resources
  * @fail_head:	Head of the list tracking requests that could not be
  *		allocated
+ * @optional:	Assign also optional resources
  *
  * Satisfy resource requests of each element in the list.  Add requests that
  * could not be satisfied to the failed_list.
  */
 static void assign_requested_resources_sorted(struct list_head *head,
-				 struct list_head *fail_head)
+					      struct list_head *fail_head,
+					      bool optional)
 {
 	struct pci_dev_resource *dev_res;
 	struct resource *res;
 	struct pci_dev *dev;
+	bool optional_res;
 	int idx;
 
 	list_for_each_entry(dev_res, head, list) {
 		res = dev_res->res;
 		dev = dev_res->dev;
 		idx = pci_resource_num(dev, res);
+		optional_res = pci_resource_is_optional(dev, idx);
 
 		if (!resource_size(res))
 			continue;
 
+		if (!optional && optional_res)
+			continue;
+
 		if (pci_assign_resource(dev, idx)) {
 			if (fail_head) {
-				/*
-				 * If the failed resource is a ROM BAR and
-				 * it will be enabled later, don't add it
-				 * to the list.
-				 */
-				if (!((idx == PCI_ROM_RESOURCE) &&
-				      (!(res->flags & IORESOURCE_ROM_ENABLE))))
-					add_to_list(fail_head, dev, res,
-						    0 /* don't care */,
-						    0 /* don't care */);
+				add_to_list(fail_head, dev, res,
+					    0 /* don't care */,
+					    0 /* don't care */);
 			}
 		}
 	}
@@ -379,6 +380,20 @@ static bool pci_need_to_release(unsigned long mask, struct resource *res)
 	return false;	/* Should not get here */
 }
 
+/* Return: @true if assignment of a required resource failed. */
+static bool pci_required_resource_failed(struct list_head *fail_head)
+{
+	struct pci_dev_resource *fail_res;
+
+	list_for_each_entry(fail_res, fail_head, list) {
+		int idx = pci_resource_num(fail_res->dev, fail_res->res);
+
+		if (!pci_resource_is_optional(fail_res->dev, idx))
+			return true;
+	}
+	return false;
+}
+
 static void __assign_resources_sorted(struct list_head *head,
 				      struct list_head *realloc_head,
 				      struct list_head *fail_head)
@@ -388,9 +403,11 @@ static void __assign_resources_sorted(struct list_head *head,
 	 * adjacent, so later reassign can not reallocate them one by one in
 	 * parent resource window.
 	 *
-	 * Try to assign requested + add_size at beginning.  If could do that,
-	 * could get out early.  If could not do that, we still try to assign
-	 * requested at first, then try to reassign add_size for some resources.
+	 * Try to assign required and any optional resources at beginning
+	 * (add_size included). If all required resources were successfully
+	 * assigned, get out early. If could not do that, we still try to
+	 * assign required at first, then try to reassign some optional
+	 * resources.
 	 *
 	 * Separate three resource type checking if we need to release
 	 * assigned resource after requested + add_size try.
@@ -421,13 +438,13 @@ static void __assign_resources_sorted(struct list_head *head,
 
 	/* Check if optional add_size is there */
 	if (list_empty(realloc_head))
-		goto requested_and_reassign;
+		goto assign;
 
 	/* Save original start, end, flags etc at first */
 	list_for_each_entry(dev_res, head, list) {
 		if (add_to_list(&save_head, dev_res->dev, dev_res->res, 0, 0)) {
 			free_list(&save_head);
-			goto requested_and_reassign;
+			goto assign;
 		}
 	}
 
@@ -471,10 +488,10 @@ static void __assign_resources_sorted(struct list_head *head,
 
 	}
 
-	/* Try updated head list with add_size added */
-	assign_requested_resources_sorted(head, &local_fail_head);
+assign:
+	assign_requested_resources_sorted(head, &local_fail_head, true);
 
-	/* All assigned with add_size? */
+	/* All non-optional resources assigned? */
 	if (list_empty(&local_fail_head)) {
 		/* Remove head list from realloc_head list */
 		list_for_each_entry(dev_res, head, list)
@@ -483,6 +500,22 @@ static void __assign_resources_sorted(struct list_head *head,
 		goto out;
 	}
 
+	/* Without realloc_head and only optional fails, nothing more to do. */
+	if (!pci_required_resource_failed(&local_fail_head) &&
+	    list_empty(realloc_head)) {
+		list_for_each_entry(save_res, &save_head, list) {
+			struct resource *res = save_res->res;
+
+			if (res->parent)
+				continue;
+
+			restore_dev_resource(save_res);
+		}
+		free_list(&local_fail_head);
+		free_list(&save_head);
+		goto out;
+	}
+
 	/* Check failed type */
 	fail_type = pci_fail_res_type_mask(&local_fail_head);
 	/* Remove not need to be released assigned res from head list etc */
@@ -518,9 +551,8 @@ static void __assign_resources_sorted(struct list_head *head,
 		restore_dev_resource(save_res);
 	free_list(&save_head);
 
-requested_and_reassign:
 	/* Satisfy the must-have resource requests */
-	assign_requested_resources_sorted(head, NULL);
+	assign_requested_resources_sorted(head, NULL, false);
 
 	/* Try to satisfy any additional optional resource requests */
 	if (!list_empty(realloc_head))
@@ -535,11 +567,7 @@ static void __assign_resources_sorted(struct list_head *head,
 		if (res->parent)
 			continue;
 
-		/*
-		 * If the failed resource is a ROM BAR and it will
-		 * be enabled later, don't add it to the list.
-		 */
-		if (fail_head && !pci_resource_is_disabled_rom(res, idx)) {
+		if (fail_head) {
 			add_to_list(fail_head, dev, res,
 				    0 /* don't care */,
 				    0 /* don't care */);
@@ -1166,10 +1194,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			r_size = resource_size(r);
 
 			/* Put SRIOV requested res to the optional list */
-			if (realloc_head && pci_resource_is_iov(i)) {
+			if (realloc_head && pci_resource_is_optional(dev, i)) {
 				add_align = max(pci_resource_alignment(dev, r), add_align);
-				resource_set_size(r, 0);
-				add_to_list(realloc_head, dev, r, r_size, 0 /* Don't care */);
+				add_to_list(realloc_head, dev, r, 0, 0 /* Don't care */);
 				children_add_size += r_size;
 				continue;
 			}
-- 
2.39.5


