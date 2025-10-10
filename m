Return-Path: <linux-pci+bounces-37813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC764BCD96D
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 16:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FBF74FB0D0
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 14:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E762F5A3F;
	Fri, 10 Oct 2025 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCa2/y6C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933BA2F746E;
	Fri, 10 Oct 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760107387; cv=none; b=KwqI8192A9ZQRj8tbbDc4TMkVYr22KcmXpHQELHHY3Gtnm/o3kj4jG3WGiwccArCfv9CoDTeP61mYU8+fYWld9WefJtjsQrUW6alolk+QLTLZFLX+XTzMPueIM7VCaioNAW+2LIbpGNnTkjcGioNG1QS6Xl1gGR6mQkH6hvYpF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760107387; c=relaxed/simple;
	bh=Ps0eFgpKDQwj5gTo/VReISXpz7hf3pTeaFFQ3wYZhls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWIL1Qa8ZlnoX2m+gGzRRtDnYWvgwYW16lDawSEX+oB5+AIQA1MxAsg0hgEdwFJXhH8oIDbNR1FMSlzYRDACAJhlL9guNMKjpnpayVDSqhdKlT9oVUkEwg95nVybGCMRulqvpcgobrMEHHEkDhQ8QExoab3/B0ZLXJN4gA9z+FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCa2/y6C; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760107386; x=1791643386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ps0eFgpKDQwj5gTo/VReISXpz7hf3pTeaFFQ3wYZhls=;
  b=SCa2/y6CyDSH0x7ZTcTVVhusFwxLfQR8n/gSRCeYkKntiFXvpBK5FeFb
   64GryA86hJGzRVLbwoRi0YG4tzQAVG+qPgGvVklNENYyoCjPy2+H6vrmT
   jE3q1ctBMrimTzbvN9UousKaGjgHeNeBfLqF1gkqB9tIuF5mDmiXbJNbt
   yX6Nxrg41Lq0TBYDDgHfwjswMJwozBv40xZmKt9y//n1aajt7o6SaZzOg
   G21I5goaOqAm/cC2nu/FLDLGdfkeyBesJytvMlK4CpLXWcaPVezkd1AFH
   2e+bE7q70va0Oux+khwt+e7rPUiFV848ETAAOJn3obCIWQaqEOsygEDgl
   w==;
X-CSE-ConnectionGUID: p/SK3P0JTGm8Bha/ip3Eag==
X-CSE-MsgGUID: j0KGA7BqRX65GDZbogyj9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62370423"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="62370423"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 07:43:05 -0700
X-CSE-ConnectionGUID: c2y819vBRTm5pmzRWCIXQg==
X-CSE-MsgGUID: 7aZHqcs2SiyzZ2O2ZSco6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="180573932"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.127])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 07:42:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/3] PCI: Do not coalesce host bridge resource structs in place
Date: Fri, 10 Oct 2025 17:42:30 +0300
Message-Id: <20251010144231.15773-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com>
References: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The resource coalescing for host bridge windows in
pci_register_host_bridge() can alter the underlying struct resource
which is inherently dangerous as this code has no knowledge of who else
holds a pointer the same resource.

Merge the struct resource inside a newly added
resource_list_merge_entries() which uses the internal __res member of
the struct resource_entry to store the merged resource, thus preserving
the original resource structs.

Link: https://lore.kernel.org/linux-pci/CAMuHMdUjhq2ZLFyMYv9KYRW8brsvXMH5xb5NW8shsHJmx7w2QQ@mail.gmail.com/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/probe.c          |   8 +--
 include/linux/resource_ext.h |   3 +
 kernel/resource.c            | 135 ++++++++++++++++++++++++++++++++++-
 3 files changed, 140 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 04523dea7d96..053bffc17146 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1061,10 +1061,10 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 		if (prev_res->flags != res->flags || prev_offset != offset)
 			continue;
 
-		if (prev_res->end + 1 == res->start) {
-			res->start = prev_res->start;
-			prev_res->flags = prev_res->start = prev_res->end = 0;
-		}
+		if (prev_res->end + 1 != res->start)
+			continue;
+
+		resource_list_merge_entries(prev, window);
 	}
 
 	/* Add initial resources to the bus */
diff --git a/include/linux/resource_ext.h b/include/linux/resource_ext.h
index ff0339df56af..4d6f2a926e6d 100644
--- a/include/linux/resource_ext.h
+++ b/include/linux/resource_ext.h
@@ -60,6 +60,9 @@ resource_list_destroy_entry(struct resource_entry *entry)
 	resource_list_free_entry(entry);
 }
 
+struct resource_entry *resource_list_merge_entries(struct resource_entry *entry,
+						   struct resource_entry *next);
+
 #define resource_list_for_each_entry(entry, list)	\
 	list_for_each_entry((entry), (list), node)
 
diff --git a/kernel/resource.c b/kernel/resource.c
index f9bb5481501a..c6e1872abb78 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/cleanup.h>
 #include <linux/export.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
@@ -206,6 +207,13 @@ static struct resource * __request_resource(struct resource *root, struct resour
 	}
 }
 
+static void resource_clear_tree_links(struct resource *res)
+{
+	res->parent = NULL;
+	res->child = NULL;
+	res->sibling = NULL;
+}
+
 static int __release_resource(struct resource *old, bool release_child)
 {
 	struct resource *tmp, **p, *chd;
@@ -265,6 +273,101 @@ void release_child_resources(struct resource *r)
 	write_unlock(&resource_lock);
 }
 
+/**
+ * resource_mergeable - Test if resources are contiguous and can be merged
+ * @r1: first resource
+ * @r2: second resource
+ *
+ * Tests @r1 is followed by @r2 contiguously and share the metadata.
+ *
+ * Return: %true if resources are mergeable non-destructively.
+ */
+static bool resource_mergeable(struct resource *r1, struct resource *r2)
+{
+	if ((r1->flags != r2->flags) ||
+	    (r1->desc != r2->desc) ||
+	    (r1->parent != r2->parent) ||
+	    (r1->end + 1 != r2->start))
+		return false;
+
+	if (r1->name == r2->name)
+		return true;
+
+	if (r1->name && r2->name && !strcmp(r1->name, r2->name))
+		return true;
+
+	return false;
+}
+
+static int resource_coalesce(struct resource *res, struct resource *next_res,
+			     struct resource *new_res)
+{
+	struct resource *parent, *tmp;
+	struct resource **p, **c;
+
+	if (!resource_mergeable(res, next_res))
+		return -EINVAL;
+
+	guard(write_lock)(&resource_lock);
+	parent = res->parent;
+
+	if (parent != next_res->parent)
+		return -EINVAL;
+
+	if (parent && res->sibling != next_res)
+		return -EINVAL;
+
+	new_res->start = res->start;
+	new_res->end = next_res->end;
+	new_res->name = res->name;
+	new_res->flags = res->flags;
+	new_res->desc = res->desc;
+
+	if (!parent)
+		return 0;
+
+	/* prepare for step 2), find res & next_res from child/sibling chain. */
+	p = &parent->child;
+	while (1) {
+		tmp = *p;
+		if (tmp == res)
+			break;
+
+		/*  No res in child/sibling, the resource tree is corrupted! */
+		if (WARN_ON_ONCE(!tmp))
+			return -EINVAL;
+
+		p = &tmp->sibling;
+	}
+
+	/* 1) set the parent */
+	new_res->parent = parent;
+
+	/* 2) inject into parent's child/sibling chain */
+	*p = new_res;
+	new_res->sibling = next_res->sibling;
+
+	/* 3) move children over and switch them to the new parent. */
+	c = &new_res->child;
+	*c = res->child;
+	while (*c) {
+		tmp = *c;
+		tmp->parent = new_res;
+		c = &tmp->sibling;
+	}
+	*c = next_res->child;
+	while (*c) {
+		tmp = *c;
+		tmp->parent = new_res;
+		c = &tmp->sibling;
+	}
+
+	resource_clear_tree_links(res);
+	resource_clear_tree_links(next_res);
+
+	return 0;
+}
+
 /**
  * request_resource_conflict - request and reserve an I/O or memory resource
  * @root: root resource descriptor
@@ -1503,8 +1606,7 @@ static bool system_ram_resources_mergeable(struct resource *r1,
 					   struct resource *r2)
 {
 	/* We assume either r1 or r2 is IORESOURCE_SYSRAM_MERGEABLE. */
-	return r1->flags == r2->flags && r1->end + 1 == r2->start &&
-	       r1->name == r2->name && r1->desc == r2->desc &&
+	return resource_mergeable(r1, r2) &&
 	       !r1->child && !r2->child;
 }
 
@@ -1860,6 +1962,35 @@ void resource_list_free(struct list_head *head)
 }
 EXPORT_SYMBOL(resource_list_free);
 
+struct resource_entry *resource_list_merge_entries(struct resource_entry *entry,
+						   struct resource_entry *next)
+{
+	struct resource *res = entry->res, *next_res = next->res, *new_res;
+	int ret;
+
+	if ((entry->offset != next->offset) ||
+	    !resource_mergeable(res, next_res))
+		return ERR_PTR(-EINVAL);
+
+	/* Use the internal __res to not mutate the input resources. */
+	struct resource_entry __free(kfree) *new = resource_list_create_entry(NULL, 0);
+	if (!new)
+		return ERR_PTR(-ENOMEM);
+
+	new->offset = next->offset;
+	new_res = new->res;
+
+	ret = resource_coalesce(res, next_res, new_res);
+	if (ret)
+		return ERR_PTR(ret);
+
+	resource_list_add_tail(new, &entry->node);
+	resource_list_destroy_entry(entry);
+	resource_list_destroy_entry(next);
+
+	return no_free_ptr(new);
+}
+
 #ifdef CONFIG_GET_FREE_REGION
 #define GFR_DESCENDING		(1UL << 0)
 #define GFR_REQUEST_REGION	(1UL << 1)
-- 
2.39.5


