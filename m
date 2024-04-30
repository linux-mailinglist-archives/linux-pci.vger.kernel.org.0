Return-Path: <linux-pci+bounces-6855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FB28B6D1C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 10:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BC32851C4
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 08:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E581A38EB;
	Tue, 30 Apr 2024 08:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U62vzJuf"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94698127E35;
	Tue, 30 Apr 2024 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466371; cv=none; b=t7YjBrRuo9HfFvQPQb4vWuFbw+zDB8vul3WQRKz4UmlU/vp49/d7ouINI8Kj19pSF3SZ/wo6X2ROvVJfofDwnJFAoyq5B+56cK9+lF7ZBFfVcdpzofL6xiFGsVojLAUfYFyGY36HMHpj3NIy9U0VfeuXBnjs8PBkU5bpbzHBJsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466371; c=relaxed/simple;
	bh=NoL4OsVvqpKm00ZYuqi9aHk+H0OpcxEikfIBhK7gWqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2++W+o0WJdyfGOgX4g+Q6pFudg3p2fwH2Ic3sldzsBctQ/yKey2xbK7in8H5dJcmWFNOTGgT+Hc8G9YVRoOB8mnHZ39W2bwnZ4qyvZXG1pTYXPnsjkv26VxA8bBWkttmo7FsSPU9eAdmCAys2z/S5NCHkNFm8FpktrCDxyes5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U62vzJuf; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 936B920019;
	Tue, 30 Apr 2024 08:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714466367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FR4QwoKXFxJ43DqRB1RdYBgvIbxpWMAKeBkjAclMBCo=;
	b=U62vzJufh3VZTyqvmwaW+57SPJP2V4ICvdNaqZ+5lqYH+O0xOu+63mFkBD58xH9Ebq7yNn
	aALbjX6NKcTzaihIuNMyPWUwLkLcKSaYA0aquJT7lZ296Ib55VV3WV6zzH4mdeLqlTXLv8
	iKsR/Lwob8gebssiMxGWJYMSBgijo8fpVmhYDQHNgXEnY3L1yvWjmJ7/KOKAA8/v2IAvme
	LriSoGCL39T8pjYtMRJ37R7icA8pcBsNpnvKj6cYa9XXKTwNMxhMaPpu3iYzy3YM6Yw8ju
	Bp1CnZQ+ToiX1bRTXxRkY2y6tCP0KCGM92Irfu1yhWBIqmksvFd++nxX5zrpnA==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 11/17] irqdomain: Introduce irq_domain_alloc() and irq_domain_publish()
Date: Tue, 30 Apr 2024 10:37:20 +0200
Message-ID: <20240430083730.134918-12-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430083730.134918-1-herve.codina@bootlin.com>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The irq_domain_add_*() family functions create an irq_domain and also
publish this newly created to domain. Once an irq_domain is published,
consumers can request IRQ in order to use them.

Some interrupt controller drivers have to perform some more operations
with the created irq_domain in order to have it ready to be used.
For instance:
  - Allocate generic irq chips with irq_alloc_domain_generic_chips()
  - Retrieve the generic irq chips with irq_get_domain_generic_chip()
  - Initialize retrieved chips: set register base address and offsets,
    set several hooks such as irq_mask, irq_unmask, ...

To avoid a window where the domain is published but not yet ready to be
used, introduce irq_domain_alloc_*() family functions to create the
irq_domain and irq_domain_publish() to publish the irq_domain.
With this new functions, any additional initialisation can then be done
between the call creating the irq_domain and the call publishing it.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irqdomain.h | 16 +++++++
 kernel/irq/irqdomain.c    | 91 ++++++++++++++++++++++++++++-----------
 2 files changed, 82 insertions(+), 25 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 21ecf582a0fe..86203e7e6659 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -257,6 +257,22 @@ static inline struct fwnode_handle *irq_domain_alloc_fwnode(phys_addr_t *pa)
 }
 
 void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
+struct irq_domain *irq_domain_alloc(struct fwnode_handle *fwnode, unsigned int size,
+				    irq_hw_number_t hwirq_max, int direct_max,
+				    const struct irq_domain_ops *ops,
+				    void *host_data);
+
+static inline struct irq_domain *irq_domain_alloc_linear(struct fwnode_handle *fwnode,
+							 unsigned int size,
+							 const struct irq_domain_ops *ops,
+							 void *host_data)
+{
+	return irq_domain_alloc(fwnode, size, size, 0, ops, host_data);
+}
+
+void irq_domain_free(struct irq_domain *domain);
+void irq_domain_publish(struct irq_domain *domain);
+void irq_domain_unpublish(struct irq_domain *domain);
 struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int size,
 				    irq_hw_number_t hwirq_max, int direct_max,
 				    const struct irq_domain_ops *ops,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 1ed8c4d3cf2e..ed353789fb27 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -231,7 +231,38 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 	return domain;
 }
 
-static void __irq_domain_publish(struct irq_domain *domain)
+struct irq_domain *irq_domain_alloc(struct fwnode_handle *fwnode, unsigned int size,
+				    irq_hw_number_t hwirq_max, int direct_max,
+				    const struct irq_domain_ops *ops,
+				    void *host_data)
+{
+	return __irq_domain_create(fwnode, size, hwirq_max, direct_max, ops,
+				   host_data);
+}
+EXPORT_SYMBOL_GPL(irq_domain_alloc);
+
+/**
+ * irq_domain_free() - Free an irq domain.
+ * @domain: domain to free
+ *
+ * This routine is used to free an irq domain. The caller must ensure
+ * that the domain is not published.
+ */
+void irq_domain_free(struct irq_domain *domain)
+{
+	fwnode_dev_initialized(domain->fwnode, false);
+	fwnode_handle_put(domain->fwnode);
+	if (domain->flags & IRQ_DOMAIN_NAME_ALLOCATED)
+		kfree(domain->name);
+	kfree(domain);
+}
+EXPORT_SYMBOL_GPL(irq_domain_free);
+
+/**
+ * irq_domain_publish() - Publish an irq domain.
+ * @domain: domain to publish
+ */
+void irq_domain_publish(struct irq_domain *domain)
 {
 	mutex_lock(&irq_domain_mutex);
 	debugfs_add_domain_dir(domain);
@@ -240,6 +271,36 @@ static void __irq_domain_publish(struct irq_domain *domain)
 
 	pr_debug("Added domain %s\n", domain->name);
 }
+EXPORT_SYMBOL_GPL(irq_domain_publish);
+
+/**
+ * irq_domain_unpublish() - Unpublish an irq domain.
+ * @domain: domain to unpublish
+ *
+ * This routine is used to unpublish an irq domain. The caller must ensure
+ * that all mappings within the domain have been disposed of prior to
+ * use, depending on the revmap type.
+ */
+void irq_domain_unpublish(struct irq_domain *domain)
+{
+	mutex_lock(&irq_domain_mutex);
+	debugfs_remove_domain_dir(domain);
+
+	WARN_ON(!radix_tree_empty(&domain->revmap_tree));
+
+	list_del(&domain->link);
+
+	/*
+	 * If the going away domain is the default one, reset it.
+	 */
+	if (unlikely(irq_default_domain == domain))
+		irq_set_default_host(NULL);
+
+	mutex_unlock(&irq_domain_mutex);
+
+	pr_debug("Removed domain %s\n", domain->name);
+}
+EXPORT_SYMBOL_GPL(irq_domain_unpublish);
 
 /**
  * __irq_domain_add() - Allocate a new irq_domain data structure
@@ -264,7 +325,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int s
 	domain = __irq_domain_create(fwnode, size, hwirq_max, direct_max,
 				     ops, host_data);
 	if (domain)
-		__irq_domain_publish(domain);
+		irq_domain_publish(domain);
 
 	return domain;
 }
@@ -280,28 +341,8 @@ EXPORT_SYMBOL_GPL(__irq_domain_add);
  */
 void irq_domain_remove(struct irq_domain *domain)
 {
-	mutex_lock(&irq_domain_mutex);
-	debugfs_remove_domain_dir(domain);
-
-	WARN_ON(!radix_tree_empty(&domain->revmap_tree));
-
-	list_del(&domain->link);
-
-	/*
-	 * If the going away domain is the default one, reset it.
-	 */
-	if (unlikely(irq_default_domain == domain))
-		irq_set_default_host(NULL);
-
-	mutex_unlock(&irq_domain_mutex);
-
-	pr_debug("Removed domain %s\n", domain->name);
-
-	fwnode_dev_initialized(domain->fwnode, false);
-	fwnode_handle_put(domain->fwnode);
-	if (domain->flags & IRQ_DOMAIN_NAME_ALLOCATED)
-		kfree(domain->name);
-	kfree(domain);
+	irq_domain_unpublish(domain);
+	irq_domain_free(domain);
 }
 EXPORT_SYMBOL_GPL(irq_domain_remove);
 
@@ -1183,7 +1224,7 @@ struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
 		domain->parent = parent;
 		domain->flags |= flags;
 
-		__irq_domain_publish(domain);
+		irq_domain_publish(domain);
 	}
 
 	return domain;
-- 
2.44.0


