Return-Path: <linux-pci+bounces-44924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7C3D23B71
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 10:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AD9B3082D06
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 09:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5D333B94A;
	Thu, 15 Jan 2026 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnSOVkL4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1914435F8B6;
	Thu, 15 Jan 2026 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470673; cv=none; b=YNYLMhb80VNaV8f73YhREdFGqUVCREyM81/juR350txAa0h6JdGOg14vL26OvwuHhfYfL43GCJ/qjDgOKMyyrwL92IjTszgAtQwfJTlmb4jLqiizCyGkaR0qhTY35rc4GEDBLaAOrnI6jAAJnN7v2/sHPLfN8bvgLY9flilBg5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470673; c=relaxed/simple;
	bh=YBaXKAlozW+FYMpEzXzll2PzBijH4+E23WmpoK+kcUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NN6vLG/fEQsx+3R/6e6WUe3Dr24WOwZiOcbMzPbhyiM59NYRm4J0n5A2eRojPH1UwHCGg7a167GtgyZFrKgaOrnKG25C/DJzDyOBv0i1tYPgI0RnCnyat1bHSjIdlHg6bCc3lTyL2fGI1Jt4bZHJOG+r9Km1YUgqN8YLS31NnjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnSOVkL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B831C116D0;
	Thu, 15 Jan 2026 09:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768470672;
	bh=YBaXKAlozW+FYMpEzXzll2PzBijH4+E23WmpoK+kcUE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HnSOVkL4OrQiSP2yCQeizqnkagsNgPPwPBF66l8foQfSAlklF+e5AaEjavQA4KYyT
	 jGi7AbKnc87EgONLRTOV0dmACVXNCvrExT3uS8eae74cUZQAHcrrV3lCwBPJe/yLJY
	 6AXMry/xt41t+868fgUxf2gXhuqvi/0ds8GY3cj4gnFdO0gQX6HSBfoQ+W7F6I+Bh1
	 OO+ysDCSfnFXhILpK+OUG3oBro9Wh54u2Cvy0dzkjF6/3+X8Xwx5ODeEDErrHGJdJs
	 /31yCPOI12Jum05n0jwN6q4NACHNC4c3RGIRC/6aW7Rc+kn9zbxrDbMAfoulDWCrWc
	 BNUjVdINHiPCQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 15 Jan 2026 10:50:47 +0100
Subject: [PATCH v3 1/6] irqdomain: Add parent field to struct irqchip_fwid
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-gicv5-host-acpi-v3-1-c13a9a150388@kernel.org>
References: <20260115-gicv5-host-acpi-v3-0-c13a9a150388@kernel.org>
In-Reply-To: <20260115-gicv5-host-acpi-v3-0-c13a9a150388@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Hanjun Guo <guohanjun@huawei.com>, 
 Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.14.3

The GICv5 driver IRQ domain hierarchy requires adding a parent field to
struct irqchip_fwid so that core code can reference a fwnode_handle parent
for a given fwnode.

Add a parent field to struct irqchip_fwid and update the related kernel API
functions to initialize and handle it.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdomain.h | 30 ++++++++++++++++++++++++++----
 kernel/irq/irqdomain.c    | 14 +++++++++++++-
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 62f81bbeb490..73c25d40846c 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -257,7 +257,8 @@ static inline void irq_domain_set_pm_device(struct irq_domain *d, struct device
 
 #ifdef CONFIG_IRQ_DOMAIN
 struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
-						const char *name, phys_addr_t *pa);
+						const char *name, phys_addr_t *pa,
+						struct fwnode_handle *parent);
 
 enum {
 	IRQCHIP_FWNODE_REAL,
@@ -267,18 +268,39 @@ enum {
 
 static inline struct fwnode_handle *irq_domain_alloc_named_fwnode(const char *name)
 {
-	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_NAMED, 0, name, NULL);
+	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_NAMED, 0, name, NULL, NULL);
+}
+
+static inline
+struct fwnode_handle *irq_domain_alloc_named_parented_fwnode(const char *name,
+							     struct fwnode_handle *parent)
+{
+	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_NAMED, 0, name, NULL, parent);
 }
 
 static inline struct fwnode_handle *irq_domain_alloc_named_id_fwnode(const char *name, int id)
 {
 	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_NAMED_ID, id, name,
-					 NULL);
+					 NULL, NULL);
+}
+
+static inline
+struct fwnode_handle *irq_domain_alloc_named_id_parented_fwnode(const char *name, int id,
+								struct fwnode_handle *parent)
+{
+	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_NAMED_ID, id, name,
+					 NULL, parent);
 }
 
 static inline struct fwnode_handle *irq_domain_alloc_fwnode(phys_addr_t *pa)
 {
-	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_REAL, 0, NULL, pa);
+	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_REAL, 0, NULL, pa, NULL);
+}
+
+static inline struct fwnode_handle *irq_domain_alloc_parented_fwnode(phys_addr_t *pa,
+								     struct fwnode_handle *parent)
+{
+	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_REAL, 0, NULL, pa, parent);
 }
 
 void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 2652c4cfd877..baf77cd167c4 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -33,6 +33,7 @@ static void irq_domain_free_one_irq(struct irq_domain *domain, unsigned int virq
 
 struct irqchip_fwid {
 	struct fwnode_handle	fwnode;
+	struct fwnode_handle	*parent;
 	unsigned int		type;
 	char			*name;
 	phys_addr_t		*pa;
@@ -53,8 +54,16 @@ static const char *irqchip_fwnode_get_name(const struct fwnode_handle *fwnode)
 	return fwid->name;
 }
 
+static struct fwnode_handle *irqchip_fwnode_get_parent(const struct fwnode_handle *fwnode)
+{
+	struct irqchip_fwid *fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
+
+	return fwid->parent;
+}
+
 const struct fwnode_operations irqchip_fwnode_ops = {
 	.get_name = irqchip_fwnode_get_name,
+	.get_parent = irqchip_fwnode_get_parent,
 };
 EXPORT_SYMBOL_GPL(irqchip_fwnode_ops);
 
@@ -65,6 +74,7 @@ EXPORT_SYMBOL_GPL(irqchip_fwnode_ops);
  * @id:		Optional user provided id if name != NULL
  * @name:	Optional user provided domain name
  * @pa:		Optional user-provided physical address
+ * @parent:	Optional parent fwnode_handle
  *
  * Allocate a struct irqchip_fwid, and return a pointer to the embedded
  * fwnode_handle (or NULL on failure).
@@ -76,7 +86,8 @@ EXPORT_SYMBOL_GPL(irqchip_fwnode_ops);
  */
 struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
 						const char *name,
-						phys_addr_t *pa)
+						phys_addr_t *pa,
+						struct fwnode_handle *parent)
 {
 	struct irqchip_fwid *fwid;
 	char *n;
@@ -104,6 +115,7 @@ struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
 	fwid->type = type;
 	fwid->name = n;
 	fwid->pa = pa;
+	fwid->parent = parent;
 	fwnode_init(&fwid->fwnode, &irqchip_fwnode_ops);
 	return &fwid->fwnode;
 }

-- 
2.50.1


