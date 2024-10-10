Return-Path: <linux-pci+bounces-14206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 260D2998D64
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 18:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED94281672
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 16:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688D21CF5FF;
	Thu, 10 Oct 2024 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmEpF+yX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2741CF5F2;
	Thu, 10 Oct 2024 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577683; cv=none; b=TSkgwwRfvVtWnxQTdBhI5aKEvnloGcBEatfxLgyPtCWLmKNwE9JgQ7S5JOafav6VM0OYMJy5O8UQuVdWp4P9GaV0ggq7dus36ZBbaOlE40bXe8eyaFrhXLy12lcWGLz5FAUtb5ZNHs9b7BHsEIfLYBDEqi+QJAsvMGVdoHNRAxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577683; c=relaxed/simple;
	bh=pxZtb5rJvO6gbVAARB+TZFYVl5ihVj1QIDUqSZVutzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uF+Yuk5a9X5T6dM8f+FiF8YIP7yzv/rT8tHdy0QwodMU2C+Q1I/EPvrAzOc6aGe/1gvs7KnJouixA1Fypx2pRnGmm31kH1K8sw0g2JoKmW8ogPZplM+OxapP7LILukz+n2U2v0yOd1C2fQRG/Jku94dZr9Ox21XyBdYIH8BL2nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmEpF+yX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7D2C4CED4;
	Thu, 10 Oct 2024 16:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728577682;
	bh=pxZtb5rJvO6gbVAARB+TZFYVl5ihVj1QIDUqSZVutzU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PmEpF+yXhmvjDxYhwiphYsnc+O9Xvqgu81dhJckTpFkhtMkeBCq7hQj+lvK+VDoHf
	 TuJhCFebJkpe5RQI8C8bSaMhx0pzrgvUcTpaaB9jiBl8H8Z/d5xglqHXuXQjQAEcFd
	 daCR2Hk/TpnP/JWmziUcAs4r3Kjx/FRInMft4xycmTBjyoEBcS7ZWApFM3IN84rHe1
	 Wn84H342YI4HfQSqtCw6KW2dYlNOIGIfh+MtX8w5saPime1cVaAp2xIHp6W+0vUebO
	 2bFtB1mU+8tTRA4jXUuAk059ujSC7l4IXj7SmilvFhfq/v0UI+8BUjO6k00Andufw3
	 w0Dk8ANxLLgOQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 10 Oct 2024 11:27:17 -0500
Subject: [PATCH 4/7] of: Constify struct property pointers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-dt-const-v1-4-87a51f558425@kernel.org>
References: <20241010-dt-const-v1-0-87a51f558425@kernel.org>
In-Reply-To: <20241010-dt-const-v1-0-87a51f558425@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.15-dev

Most accesses to struct property do not modify it, so constify struct
property pointers where ever possible in the DT core code.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/base.c       | 12 ++++++------
 drivers/of/kobj.c       |  6 +++---
 drivers/of/of_private.h | 10 +++++-----
 drivers/of/overlay.c    |  5 +++--
 drivers/of/property.c   | 10 +++++-----
 drivers/of/resolver.c   |  8 ++++----
 include/linux/of.h      | 14 +++++++-------
 7 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index d1aebb979522..d94efee4a7fc 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -270,7 +270,7 @@ EXPORT_SYMBOL(of_find_all_nodes);
 const void *__of_get_property(const struct device_node *np,
 			      const char *name, int *lenp)
 {
-	struct property *pp = __of_find_property(np, name, lenp);
+	const struct property *pp = __of_find_property(np, name, lenp);
 
 	return pp ? pp->value : NULL;
 }
@@ -282,7 +282,7 @@ const void *__of_get_property(const struct device_node *np,
 const void *of_get_property(const struct device_node *np, const char *name,
 			    int *lenp)
 {
-	struct property *pp = of_find_property(np, name, lenp);
+	const struct property *pp = of_find_property(np, name, lenp);
 
 	return pp ? pp->value : NULL;
 }
@@ -321,7 +321,7 @@ EXPORT_SYMBOL(of_get_property);
 static int __of_device_is_compatible(const struct device_node *device,
 				     const char *compat, const char *type, const char *name)
 {
-	struct property *prop;
+	const struct property *prop;
 	const char *cp;
 	int index = 0, score = 0;
 
@@ -828,7 +828,7 @@ struct device_node *__of_find_node_by_full_path(struct device_node *node,
 struct device_node *of_find_node_opts_by_path(const char *path, const char **opts)
 {
 	struct device_node *np = NULL;
-	struct property *pp;
+	const struct property *pp;
 	unsigned long flags;
 	const char *separator = strchr(path, ':');
 
@@ -974,7 +974,7 @@ struct device_node *of_find_node_with_property(struct device_node *from,
 	const char *prop_name)
 {
 	struct device_node *np;
-	struct property *pp;
+	const struct property *pp;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&devtree_lock, flags);
@@ -1769,7 +1769,7 @@ static void of_alias_add(struct alias_prop *ap, struct device_node *np,
  */
 void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 {
-	struct property *pp;
+	const struct property *pp;
 
 	of_aliases = of_find_node_by_path("/aliases");
 	of_chosen = of_find_node_by_path("/chosen");
diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
index 3dbce1e6f184..aeb1709d4e85 100644
--- a/drivers/of/kobj.c
+++ b/drivers/of/kobj.c
@@ -84,7 +84,7 @@ int __of_add_property_sysfs(struct device_node *np, struct property *pp)
 	return rc;
 }
 
-void __of_sysfs_remove_bin_file(struct device_node *np, struct property *prop)
+void __of_sysfs_remove_bin_file(struct device_node *np, const struct property *prop)
 {
 	if (!IS_ENABLED(CONFIG_SYSFS))
 		return;
@@ -93,7 +93,7 @@ void __of_sysfs_remove_bin_file(struct device_node *np, struct property *prop)
 	kfree(prop->attr.attr.name);
 }
 
-void __of_remove_property_sysfs(struct device_node *np, struct property *prop)
+void __of_remove_property_sysfs(struct device_node *np, const struct property *prop)
 {
 	/* at early boot, bail here and defer setup to of_init() */
 	if (of_kset && of_node_is_attached(np))
@@ -101,7 +101,7 @@ void __of_remove_property_sysfs(struct device_node *np, struct property *prop)
 }
 
 void __of_update_property_sysfs(struct device_node *np, struct property *newprop,
-		struct property *oldprop)
+		const struct property *oldprop)
 {
 	/* At early boot, bail out and defer setup to of_init() */
 	if (!of_kset)
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index d957cc6ce437..53a4a5be9997 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -69,9 +69,9 @@ static inline void of_platform_register_reconfig_notifier(void) { }
 #if defined(CONFIG_OF_KOBJ)
 int of_node_is_attached(const struct device_node *node);
 int __of_add_property_sysfs(struct device_node *np, struct property *pp);
-void __of_remove_property_sysfs(struct device_node *np, struct property *prop);
+void __of_remove_property_sysfs(struct device_node *np, const struct property *prop);
 void __of_update_property_sysfs(struct device_node *np, struct property *newprop,
-		struct property *oldprop);
+		const struct property *oldprop);
 int __of_attach_node_sysfs(struct device_node *np);
 void __of_detach_node_sysfs(struct device_node *np);
 #else
@@ -79,9 +79,9 @@ static inline int __of_add_property_sysfs(struct device_node *np, struct propert
 {
 	return 0;
 }
-static inline void __of_remove_property_sysfs(struct device_node *np, struct property *prop) {}
+static inline void __of_remove_property_sysfs(struct device_node *np, const struct property *prop) {}
 static inline void __of_update_property_sysfs(struct device_node *np,
-		struct property *newprop, struct property *oldprop) {}
+		struct property *newprop, const struct property *oldprop) {}
 static inline int __of_attach_node_sysfs(struct device_node *np)
 {
 	return 0;
@@ -142,7 +142,7 @@ extern int __of_update_property(struct device_node *np,
 extern void __of_detach_node(struct device_node *np);
 
 extern void __of_sysfs_remove_bin_file(struct device_node *np,
-				       struct property *prop);
+				       const struct property *prop);
 
 /* illegal phandle value (set when unresolved) */
 #define OF_PHANDLE_ILLEGAL	0xdeadbeef
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 19aaa96ee817..434f6dd6a86c 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -296,10 +296,11 @@ static struct property *dup_and_fixup_symbol_prop(
  * invalid @overlay.
  */
 static int add_changeset_property(struct overlay_changeset *ovcs,
-		struct target *target, struct property *overlay_prop,
+		struct target *target, const struct property *overlay_prop,
 		bool is_symbols_prop)
 {
-	struct property *new_prop = NULL, *prop;
+	struct property *new_prop = NULL;
+	const struct property *prop;
 	int ret = 0;
 
 	if (target->in_livetree)
diff --git a/drivers/of/property.c b/drivers/of/property.c
index 11b922fde7af..33dd72cad4ab 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -68,7 +68,7 @@ EXPORT_SYMBOL(of_graph_is_present);
 int of_property_count_elems_of_size(const struct device_node *np,
 				const char *propname, int elem_size)
 {
-	struct property *prop = of_find_property(np, propname, NULL);
+	const struct property *prop = of_find_property(np, propname, NULL);
 
 	if (!prop)
 		return -EINVAL;
@@ -104,7 +104,7 @@ EXPORT_SYMBOL_GPL(of_property_count_elems_of_size);
 static void *of_find_property_value_of_size(const struct device_node *np,
 			const char *propname, u32 min, u32 max, size_t *len)
 {
-	struct property *prop = of_find_property(np, propname, NULL);
+	const struct property *prop = of_find_property(np, propname, NULL);
 
 	if (!prop)
 		return ERR_PTR(-EINVAL);
@@ -530,7 +530,7 @@ int of_property_read_string_helper(const struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(of_property_read_string_helper);
 
-const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
+const __be32 *of_prop_next_u32(const struct property *prop, const __be32 *cur,
 			       u32 *pu)
 {
 	const void *curv = cur;
@@ -553,7 +553,7 @@ const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
 }
 EXPORT_SYMBOL_GPL(of_prop_next_u32);
 
-const char *of_prop_next_string(struct property *prop, const char *cur)
+const char *of_prop_next_string(const struct property *prop, const char *cur)
 {
 	const void *curv = cur;
 
@@ -1466,7 +1466,7 @@ static int of_fwnode_irq_get(const struct fwnode_handle *fwnode,
 
 static int of_fwnode_add_links(struct fwnode_handle *fwnode)
 {
-	struct property *p;
+	const struct property *p;
 	struct device_node *con_np = to_of_node(fwnode);
 
 	if (IS_ENABLED(CONFIG_X86))
diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
index ee7769525bb2..779db058c42f 100644
--- a/drivers/of/resolver.c
+++ b/drivers/of/resolver.c
@@ -42,7 +42,7 @@ static void adjust_overlay_phandles(struct device_node *overlay,
 		int phandle_delta)
 {
 	struct device_node *child;
-	struct property *prop;
+	const struct property *prop;
 	phandle phandle;
 
 	/* adjust node's phandle in node */
@@ -71,10 +71,10 @@ static void adjust_overlay_phandles(struct device_node *overlay,
 }
 
 static int update_usages_of_a_phandle_reference(struct device_node *overlay,
-		struct property *prop_fixup, phandle phandle)
+		const struct property *prop_fixup, phandle phandle)
 {
 	struct device_node *refnode;
-	struct property *prop;
+	const struct property *prop;
 	char *value __free(kfree) = kmemdup(prop_fixup->value, prop_fixup->length, GFP_KERNEL);
 	char *cur, *end, *node_path, *prop_name, *s;
 	int offset, len;
@@ -151,7 +151,7 @@ static int adjust_local_phandle_references(const struct device_node *local_fixup
 		const struct device_node *overlay, int phandle_delta)
 {
 	struct device_node *overlay_child;
-	struct property *prop_fix, *prop;
+	const struct property *prop_fix, *prop;
 	int err, i, count;
 	unsigned int off;
 
diff --git a/include/linux/of.h b/include/linux/of.h
index 7875b308f13c..086a60f3b8a6 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -435,7 +435,7 @@ extern int of_detach_node(struct device_node *);
  * of_property_for_each_u32(np, "propname", u)
  *         printk("U32 value: %x\n", u);
  */
-const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
+const __be32 *of_prop_next_u32(const struct property *prop, const __be32 *cur,
 			       u32 *pu);
 /*
  * struct property *prop;
@@ -444,7 +444,7 @@ const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
  * of_property_for_each_string(np, "propname", prop, s)
  *         printk("String value: %s\n", s);
  */
-const char *of_prop_next_string(struct property *prop, const char *cur);
+const char *of_prop_next_string(const struct property *prop, const char *cur);
 
 bool of_console_check(const struct device_node *dn, char *name, int index);
 
@@ -826,13 +826,13 @@ static inline bool of_console_check(const struct device_node *dn, const char *na
 	return false;
 }
 
-static inline const __be32 *of_prop_next_u32(struct property *prop,
+static inline const __be32 *of_prop_next_u32(const struct property *prop,
 		const __be32 *cur, u32 *pu)
 {
 	return NULL;
 }
 
-static inline const char *of_prop_next_string(struct property *prop,
+static inline const char *of_prop_next_string(const struct property *prop,
 		const char *cur)
 {
 	return NULL;
@@ -899,7 +899,7 @@ static inline const void *of_device_get_match_data(const struct device *dev)
 #define of_node_cmp(s1, s2)		strcasecmp((s1), (s2))
 #endif
 
-static inline int of_prop_val_eq(struct property *p1, struct property *p2)
+static inline int of_prop_val_eq(const struct property *p1, const struct property *p2)
 {
 	return p1->length == p2->length &&
 	       !memcmp(p1->value, p2->value, (size_t)p1->length);
@@ -1252,7 +1252,7 @@ static inline int of_property_read_string_index(const struct device_node *np,
 static inline bool of_property_read_bool(const struct device_node *np,
 					 const char *propname)
 {
-	struct property *prop = of_find_property(np, propname, NULL);
+	const struct property *prop = of_find_property(np, propname, NULL);
 
 	return prop ? true : false;
 }
@@ -1430,7 +1430,7 @@ static inline int of_property_read_s32(const struct device_node *np,
 	     err = of_phandle_iterator_next(it))
 
 #define of_property_for_each_u32(np, propname, u)			\
-	for (struct {struct property *prop; const __be32 *item; } _it =	\
+	for (struct {const struct property *prop; const __be32 *item; } _it =	\
 		{of_find_property(np, propname, NULL),			\
 		 of_prop_next_u32(_it.prop, NULL, &u)};			\
 	     _it.item;							\

-- 
2.45.2


