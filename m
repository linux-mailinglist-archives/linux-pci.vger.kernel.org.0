Return-Path: <linux-pci+bounces-14205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D696F998D63
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 18:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047FA1C22966
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 16:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186DC1CF29E;
	Thu, 10 Oct 2024 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1iXhaW5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22001CF298;
	Thu, 10 Oct 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577682; cv=none; b=epFqavzRPwF1x8o0DGr2Wxl8W6cx+lizJpoRg2OaJNn2G2y60oQLGldGmj05jkI0GuLgTindJZ79Pb69CIogIwac+5QYl2Wq+qyJzJNXfM5Q5eK7OJuN2cd7m4CejUfJ0WVGskbPYYHTh/2+xFUshDZhDb/gXNkLz2LxtzyJrow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577682; c=relaxed/simple;
	bh=WZvhT5fTmftqx804frNdKOlCWKv78SUumi8ZT/rAffo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=szHISHjzMA3chHZJkXppcnAB49VrEN+WTiUhQ1SUXmtUfHjErwR5iNEv6EJTtCVhbwpwVcM6MdZ1WW45MwGtftEV34i6XO2+X8I9jTzKMtGsTvDsKDhL3mGn5mTrrtB1x2KMVwq4t2q+OC0DHfeDshieyBKxQFBTAW+Az2Tdrec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1iXhaW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F6CC4CEC5;
	Thu, 10 Oct 2024 16:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728577681;
	bh=WZvhT5fTmftqx804frNdKOlCWKv78SUumi8ZT/rAffo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A1iXhaW5Ud4z1mRPFg24NbYe6i3KKRTMWuG5DmYdiYmywfoK2kovzq7ZaWMCEeyNQ
	 exVlH5iojyR2eNK+Q5IwpjlK3gYeWgus6H3bHBnDRMVCs1n9QPJEejcJL5VOPGxXGO
	 SZ207Utsyx+DgQLjziDEkJEBD5y9trTBpP/bVKcxuLeE2yCx2jSNIQmexCc9QIe7+6
	 cIpc4ddvtdIecuA04BZk18CY3KafhbKWcjwjhACwRzIYLCBvd19PQN+X8Mmje2yO9u
	 9jFAMnK349PgJ8k5N2tKRxztL8uE2WA2G4NJTAUNfaafPot7WyQuyLLfzpwQxTYsh3
	 QTeMjN+eK+EEA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 10 Oct 2024 11:27:16 -0500
Subject: [PATCH 3/7] of: Constify struct device_node function arguments
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-dt-const-v1-3-87a51f558425@kernel.org>
References: <20241010-dt-const-v1-0-87a51f558425@kernel.org>
In-Reply-To: <20241010-dt-const-v1-0-87a51f558425@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.15-dev

Functions which don't change the refcount or otherwise modify struct
device_node can make struct device_node const.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/address.c       | 10 +++++-----
 drivers/of/base.c          |  8 ++++----
 drivers/of/cpu.c           |  2 +-
 drivers/of/irq.c           |  4 ++--
 drivers/of/of_private.h    |  2 +-
 drivers/of/overlay.c       | 14 +++++++-------
 drivers/of/resolver.c      |  4 ++--
 include/linux/of.h         | 14 +++++++-------
 include/linux/of_address.h |  4 ++--
 include/linux/of_irq.h     |  4 ++--
 10 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 286f0c161e33..aa1a4e381461 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -147,7 +147,7 @@ static unsigned int of_bus_pci_get_flags(const __be32 *addr)
  * PCI bus specific translator
  */
 
-static bool of_node_is_pcie(struct device_node *np)
+static bool of_node_is_pcie(const struct device_node *np)
 {
 	bool is_pcie = of_node_name_eq(np, "pcie");
 
@@ -230,8 +230,8 @@ static int __of_address_resource_bounds(struct resource *r, u64 start, u64 size)
  * To guard against that we try to register the IO range first.
  * If that fails we know that pci_address_to_pio() will do too.
  */
-int of_pci_range_to_resource(struct of_pci_range *range,
-			     struct device_node *np, struct resource *res)
+int of_pci_range_to_resource(const struct of_pci_range *range,
+			     const struct device_node *np, struct resource *res)
 {
 	u64 start;
 	int err;
@@ -399,7 +399,7 @@ static struct of_bus *of_match_bus(struct device_node *np)
 	return NULL;
 }
 
-static int of_empty_ranges_quirk(struct device_node *np)
+static int of_empty_ranges_quirk(const struct device_node *np)
 {
 	if (IS_ENABLED(CONFIG_PPC)) {
 		/* To save cycles, we cache the result for global "Mac" setting */
@@ -1030,7 +1030,7 @@ EXPORT_SYMBOL_GPL(of_dma_is_coherent);
  * This is currently only enabled on builds that support Apple ARM devices, as
  * an optimization.
  */
-static bool of_mmio_is_nonposted(struct device_node *np)
+static bool of_mmio_is_nonposted(const struct device_node *np)
 {
 	if (!IS_ENABLED(CONFIG_ARCH_APPLE))
 		return false;
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 20603d3c9931..d1aebb979522 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -771,7 +771,7 @@ struct device_node *of_get_child_by_name(const struct device_node *node,
 }
 EXPORT_SYMBOL(of_get_child_by_name);
 
-struct device_node *__of_find_node_by_path(struct device_node *parent,
+struct device_node *__of_find_node_by_path(const struct device_node *parent,
 						const char *path)
 {
 	struct device_node *child;
@@ -1840,7 +1840,7 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
  *
  * Return: The alias id if found.
  */
-int of_alias_get_id(struct device_node *np, const char *stem)
+int of_alias_get_id(const struct device_node *np, const char *stem)
 {
 	struct alias_prop *app;
 	int id = -ENODEV;
@@ -1898,7 +1898,7 @@ EXPORT_SYMBOL_GPL(of_alias_get_highest_id);
  *
  * Return: TRUE if console successfully setup. Otherwise return FALSE.
  */
-bool of_console_check(struct device_node *dn, char *name, int index)
+bool of_console_check(const struct device_node *dn, char *name, int index)
 {
 	if (!dn || dn != of_stdout || console_set_on_cmdline)
 		return false;
@@ -1986,7 +1986,7 @@ int of_find_last_cache_level(unsigned int cpu)
  *
  * Return: 0 on success or a standard error code on failure.
  */
-int of_map_id(struct device_node *np, u32 id,
+int of_map_id(const struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
 	       struct device_node **target, u32 *id_out)
 {
diff --git a/drivers/of/cpu.c b/drivers/of/cpu.c
index d17b2f851082..5214dc3d05ae 100644
--- a/drivers/of/cpu.c
+++ b/drivers/of/cpu.c
@@ -188,7 +188,7 @@ EXPORT_SYMBOL(of_cpu_node_to_id);
  * Return: An idle state node if found at @index. The refcount is incremented
  * for it, so call of_node_put() on it when done. Returns NULL if not found.
  */
-struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
+struct device_node *of_get_cpu_state_node(const struct device_node *cpu_node,
 					  int index)
 {
 	struct of_phandle_args args;
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index a494f56a0d0e..67fc0ceaa5f5 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -720,7 +720,7 @@ struct irq_domain *of_msi_map_get_device_domain(struct device *dev, u32 id,
  * Returns: the MSI domain for this device (or NULL on failure).
  */
 struct irq_domain *of_msi_get_domain(struct device *dev,
-				     struct device_node *np,
+				     const struct device_node *np,
 				     enum irq_domain_bus_token token)
 {
 	struct of_phandle_iterator it;
@@ -742,7 +742,7 @@ EXPORT_SYMBOL_GPL(of_msi_get_domain);
  * @dev: device structure to associate with an MSI irq domain
  * @np: device node for that device
  */
-void of_msi_configure(struct device *dev, struct device_node *np)
+void of_msi_configure(struct device *dev, const struct device_node *np)
 {
 	dev_set_msi_domain(dev,
 			   of_msi_get_domain(dev, np, DOMAIN_BUS_PLATFORM_MSI));
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 04aa2a91f851..d957cc6ce437 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -127,7 +127,7 @@ void __of_prop_free(struct property *prop);
 struct device_node *__of_node_dup(const struct device_node *np,
 				  const char *full_name);
 
-struct device_node *__of_find_node_by_path(struct device_node *parent,
+struct device_node *__of_find_node_by_path(const struct device_node *parent,
 						const char *path);
 struct device_node *__of_find_node_by_full_path(struct device_node *node,
 						const char *path);
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index cbdecccca097..19aaa96ee817 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -398,7 +398,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
  * invalid @overlay.
  */
 static int add_changeset_node(struct overlay_changeset *ovcs,
-		struct target *target, struct device_node *node)
+		struct target *target, const struct device_node *node)
 {
 	const char *node_kbasename;
 	const __be32 *phandle;
@@ -675,8 +675,8 @@ static int build_changeset(struct overlay_changeset *ovcs)
  * 1) "target" property containing the phandle of the target
  * 2) "target-path" property containing the path of the target
  */
-static struct device_node *find_target(struct device_node *info_node,
-				       struct device_node *target_base)
+static struct device_node *find_target(const struct device_node *info_node,
+				       const struct device_node *target_base)
 {
 	struct device_node *node;
 	char *target_path;
@@ -735,7 +735,7 @@ static struct device_node *find_target(struct device_node *info_node,
  * init_overlay_changeset() must call free_overlay_changeset().
  */
 static int init_overlay_changeset(struct overlay_changeset *ovcs,
-				  struct device_node *target_base)
+				  const struct device_node *target_base)
 {
 	struct device_node *node, *overlay_node;
 	struct fragment *fragment;
@@ -910,7 +910,7 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
  */
 
 static int of_overlay_apply(struct overlay_changeset *ovcs,
-			    struct device_node *base)
+			    const struct device_node *base)
 {
 	int ret = 0, ret_revert, ret_tmp;
 
@@ -978,7 +978,7 @@ static int of_overlay_apply(struct overlay_changeset *ovcs,
  */
 
 int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
-			 int *ret_ovcs_id, struct device_node *base)
+			 int *ret_ovcs_id, const struct device_node *base)
 {
 	void *new_fdt;
 	void *new_fdt_align;
@@ -1074,7 +1074,7 @@ EXPORT_SYMBOL_GPL(of_overlay_fdt_apply);
  *
  * Returns 1 if @np is @tree or is contained in @tree, else 0
  */
-static int find_node(struct device_node *tree, struct device_node *np)
+static int find_node(const struct device_node *tree, struct device_node *np)
 {
 	if (tree == np)
 		return 1;
diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
index 5cf96776dd7d..ee7769525bb2 100644
--- a/drivers/of/resolver.c
+++ b/drivers/of/resolver.c
@@ -147,8 +147,8 @@ static int node_name_cmp(const struct device_node *dn1,
  * of offsets of the phandle reference(s) within the respective property
  * value(s).  The values at these offsets will be fixed up.
  */
-static int adjust_local_phandle_references(struct device_node *local_fixups,
-		struct device_node *overlay, int phandle_delta)
+static int adjust_local_phandle_references(const struct device_node *local_fixups,
+		const struct device_node *overlay, int phandle_delta)
 {
 	struct device_node *overlay_child;
 	struct property *prop_fix, *prop;
diff --git a/include/linux/of.h b/include/linux/of.h
index 85b60ac9eec5..7875b308f13c 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -357,7 +357,7 @@ extern struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
 extern struct device_node *of_cpu_device_node_get(int cpu);
 extern int of_cpu_node_to_id(struct device_node *np);
 extern struct device_node *of_get_next_cpu_node(struct device_node *prev);
-extern struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
+extern struct device_node *of_get_cpu_state_node(const struct device_node *cpu_node,
 						 int index);
 extern u64 of_get_cpu_hwid(struct device_node *cpun, unsigned int thread);
 
@@ -395,7 +395,7 @@ extern int of_phandle_iterator_args(struct of_phandle_iterator *it,
 				    int size);
 
 extern void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
-extern int of_alias_get_id(struct device_node *np, const char *stem);
+extern int of_alias_get_id(const struct device_node *np, const char *stem);
 extern int of_alias_get_highest_id(const char *stem);
 
 bool of_machine_compatible_match(const char *const *compats);
@@ -446,9 +446,9 @@ const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
  */
 const char *of_prop_next_string(struct property *prop, const char *cur);
 
-bool of_console_check(struct device_node *dn, char *name, int index);
+bool of_console_check(const struct device_node *dn, char *name, int index);
 
-int of_map_id(struct device_node *np, u32 id,
+int of_map_id(const struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
 	       struct device_node **target, u32 *id_out);
 
@@ -871,7 +871,7 @@ static inline void of_property_clear_flag(struct property *p, unsigned long flag
 {
 }
 
-static inline int of_map_id(struct device_node *np, u32 id,
+static inline int of_map_id(const struct device_node *np, u32 id,
 			     const char *map_name, const char *map_mask_name,
 			     struct device_node **target, u32 *id_out)
 {
@@ -1734,7 +1734,7 @@ struct of_overlay_notify_data {
 #ifdef CONFIG_OF_OVERLAY
 
 int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
-			 int *ovcs_id, struct device_node *target_base);
+			 int *ovcs_id, const struct device_node *target_base);
 int of_overlay_remove(int *ovcs_id);
 int of_overlay_remove_all(void);
 
@@ -1744,7 +1744,7 @@ int of_overlay_notifier_unregister(struct notifier_block *nb);
 #else
 
 static inline int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
-				       int *ovcs_id, struct device_node *target_base)
+				       int *ovcs_id, const struct device_node *target_base)
 {
 	return -ENOTSUPP;
 }
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 26a19daf0d09..bd46dbcc6e88 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -83,8 +83,8 @@ extern struct of_pci_range *of_pci_range_parser_one(
 					struct of_pci_range *range);
 extern int of_pci_address_to_resource(struct device_node *dev, int bar,
 				      struct resource *r);
-extern int of_pci_range_to_resource(struct of_pci_range *range,
-				    struct device_node *np,
+extern int of_pci_range_to_resource(const struct of_pci_range *range,
+				    const struct device_node *np,
 				    struct resource *res);
 extern int of_range_to_resource(struct device_node *np, int index,
 				struct resource *res);
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index d6d3eae2f145..6337ad4e5fe8 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -48,12 +48,12 @@ extern int of_irq_to_resource_table(struct device_node *dev,
 		struct resource *res, int nr_irqs);
 extern struct device_node *of_irq_find_parent(struct device_node *child);
 extern struct irq_domain *of_msi_get_domain(struct device *dev,
-					    struct device_node *np,
+					    const struct device_node *np,
 					    enum irq_domain_bus_token token);
 extern struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
 							u32 id,
 							u32 bus_token);
-extern void of_msi_configure(struct device *dev, struct device_node *np);
+extern void of_msi_configure(struct device *dev, const struct device_node *np);
 u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in);
 #else
 static inline void of_irq_init(const struct of_device_id *matches)

-- 
2.45.2


