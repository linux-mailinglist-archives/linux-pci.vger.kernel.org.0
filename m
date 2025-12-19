Return-Path: <linux-pci+bounces-43428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BEBCD138E
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3673C30433CE
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B742830E0FC;
	Fri, 19 Dec 2025 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCgt+8RY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5460634251B;
	Fri, 19 Dec 2025 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166158; cv=none; b=OTT/cvR/zvkc8JN6drD/1n0Q4Yx91TqZlt3qp6MttQF9aii2GhW7remv10xr5VfkopVYRrNus29rPt/IXjJaaiDvoXIjME+x0swuowOBsPrwxY9RPjM4F6Osk8zFRmkNbjXFLgCQqPGG5Je2ocFpcMs0kNdafvxoamEQbL8lT1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166158; c=relaxed/simple;
	bh=+zRgh5ZQFLZifGyslLt9xrDF6fc1aBy9CbWe2aheJPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPmSjn/lJ6/w6s4STd381ghXmMwNqcx0bWc0qy4lZzHm0YIJxOpl1TEAQ6ZzFMxODCsrHNse9jJu9jEMbQCPiAFtfAs+HWwxxLsD74wJaF0gR2zPOxt2pshIUYmX4cdT5mIWm6++gzEI/ibKzpJmNQSfvUHqDt607YlxbQW6KyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCgt+8RY; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166156; x=1797702156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+zRgh5ZQFLZifGyslLt9xrDF6fc1aBy9CbWe2aheJPc=;
  b=ZCgt+8RYiynEEioqccUQofP0s38NfTH/svHJlnF9SIj2BBuBZiMJoz3G
   boeLp5uZbNNl4xIrQK1pV6sz9POHP6GX+D7wdeThQ0Uic71P9VJi2WNdh
   83/eNqZYE9LVcvuq9isdWw23VGLh7TMhcTYxGGWdmrPYLXoHZPWQaUy1w
   IZTUymMkjJQkwFEbgQshlw9nQK1Km91F+ZcNgcMDMvS8umu4I69JS8Kro
   cMGTLeVK8PtQYOuUfeAdwX3qY8UBFY+grlMwQ6B6TPV8zKgC328A5HWOE
   ZNTJ2DbZBFjXV8G8UzZwbTGdKiB9c5NXN6T7NL6tCO4dIxukwhC4eNNlk
   Q==;
X-CSE-ConnectionGUID: N7O6vL+oR+iF7ctomD4mRA==
X-CSE-MsgGUID: Lq2qdRKmQJGwOZKUrBpHzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="67880669"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="67880669"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:42:36 -0800
X-CSE-ConnectionGUID: E0XkWynsT/C5WAR4jgcPXw==
X-CSE-MsgGUID: CkJ0vi6XTc2TygLjBb48eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="198497089"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:42:33 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 13/23] PCI: Add pbus_mem_size_optional() to handle optional sizes
Date: Fri, 19 Dec 2025 19:40:26 +0200
Message-Id: <20251219174036.16738-14-ilpo.jarvinen@linux.intel.com>
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

The resource loop in pbus_size_mem() handles optional resources that
are either fully optional (SRIOV and disabled Expansion ROMs) or bridge
windows that may be optional only for a part. The logic is little
inconsistent when it comes to a bridge window that has only optional
children resources as it would be more natural to treat it similar to
any fully optional resource. As resource size should be zero in that
case, it shouldn't cause any bugs but it still seems useful to address
the inconsistency.

Place the optional size related code of pbus_size_mem() into
pbus_mem_size_optional() and add check into pci_resource_is_optional()
for entirely optional bridge windows. Reorder the logic inside
pbus_mem_size_optional() such that fully optional resources are handled
the same irrespective to whether the resource is a bridge window or
not.

Additional motivation for this are the upcoming changes that add
complexity to the optional sizing logic due to Resizable BAR awareness.
The extra logic would exceed any reasonable indentation level if the
optional sizing code is kept within the loop body.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 77 +++++++++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 3d1d3cefcdba..3fcc7641c374 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -125,15 +125,6 @@ static resource_size_t get_res_add_size(struct list_head *head,
 	return dev_res ? dev_res->add_size : 0;
 }
 
-static resource_size_t get_res_add_align(struct list_head *head,
-					 struct resource *res)
-{
-	struct pci_dev_resource *dev_res;
-
-	dev_res = res_to_dev_res(head, res);
-	return dev_res ? dev_res->min_align : 0;
-}
-
 static void restore_dev_resource(struct pci_dev_resource *dev_res)
 {
 	struct resource *res = dev_res->res;
@@ -386,6 +377,8 @@ bool pci_resource_is_optional(const struct pci_dev *dev, int resno)
 		return true;
 	if (resno == PCI_ROM_RESOURCE && !(res->flags & IORESOURCE_ROM_ENABLE))
 		return true;
+	if (pci_resource_is_bridge_win(resno) && !resource_size(res))
+		return true;
 
 	return false;
 }
@@ -1258,6 +1251,54 @@ static resource_size_t calculate_head_align(resource_size_t *aligns,
 	return head_align;
 }
 
+/*
+ * pbus_size_mem_optional - Account optional resources in bridge window
+ *
+ * Account an optional resource or the optional part of the resource in bridge
+ * window size.
+ *
+ * Return: %true if the resource is entirely optional.
+ */
+static bool pbus_size_mem_optional(struct pci_dev *dev, int resno,
+				   resource_size_t align,
+				   struct list_head *realloc_head,
+				   resource_size_t *add_align,
+				   resource_size_t *children_add_size)
+{
+	struct resource *res = pci_resource_n(dev, resno);
+	bool optional = pci_resource_is_optional(dev, resno);
+	resource_size_t r_size = resource_size(res);
+	struct pci_dev_resource *dev_res;
+
+	if (!realloc_head)
+		return false;
+
+	if (!optional) {
+		/*
+		 * Only bridges have optional sizes in realloc_head at this
+		 * point. As res_to_dev_res() walks the entire realloc_head
+		 * list, skip calling it when known unnecessary.
+		 */
+		if (!pci_resource_is_bridge_win(resno))
+			return false;
+
+		dev_res = res_to_dev_res(realloc_head, res);
+		if (dev_res) {
+			*children_add_size += dev_res->add_size;
+			*add_align = max(*add_align, dev_res->min_align);
+		}
+
+		return false;
+	}
+
+	/* Put SRIOV requested res to the optional list */
+	add_to_list(realloc_head, dev, res, 0, align);
+	*children_add_size += r_size;
+	*add_align = max(align, *add_align);
+
+	return true;
+}
+
 /**
  * pbus_size_mem() - Size the memory window of a given bus
  *
@@ -1284,7 +1325,6 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 	resource_size_t aligns[28] = {}; /* Alignments from 1MB to 128TB */
 	int order, max_order;
 	resource_size_t children_add_size = 0;
-	resource_size_t children_add_align = 0;
 	resource_size_t add_align = 0;
 
 	if (!b_res)
@@ -1311,7 +1351,6 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 			if (b_res != pbus_select_window(bus, r))
 				continue;
 
-			r_size = resource_size(r);
 			align = pci_resource_alignment(dev, r);
 			/*
 			 * aligns[0] is for 1MB (since bridge memory
@@ -1327,25 +1366,17 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 				continue;
 			}
 
-			/* Put SRIOV requested res to the optional list */
-			if (realloc_head && pci_resource_is_optional(dev, i)) {
-				add_align = max(align, add_align);
-				add_to_list(realloc_head, dev, r, 0, 0 /* Don't care */);
-				children_add_size += r_size;
+			if (pbus_size_mem_optional(dev, i, align,
+						   realloc_head, &add_align,
+						   &children_add_size))
 				continue;
-			}
 
+			r_size = resource_size(r);
 			size += max(r_size, align);
 
 			aligns[order] += align;
 			if (order > max_order)
 				max_order = order;
-
-			if (realloc_head) {
-				children_add_size += get_res_add_size(realloc_head, r);
-				children_add_align = get_res_add_align(realloc_head, r);
-				add_align = max(add_align, children_add_align);
-			}
 		}
 	}
 
-- 
2.39.5


