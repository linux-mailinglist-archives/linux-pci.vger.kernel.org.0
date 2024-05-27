Return-Path: <linux-pci+bounces-7871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF018D0832
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 18:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BBA28B2C5
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 16:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F22216C6B6;
	Mon, 27 May 2024 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jPHjua9W"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42EC16B751;
	Mon, 27 May 2024 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826520; cv=none; b=O73C2/DIeIPdgPDRu9nVE3eV8I6ML3rNlmRIgWwQ8hVtjNHiTP+jEoTdf8dNcZ6UWHMjPNftiM5XZXiPrOx/L0si1bYgplBCOaLwrrRNLkhpnfJGYSsESJUvmfDbonmsw+VOYY7PLjuwtRRJMISOJ/zvG1USvOemBPHhBngrtr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826520; c=relaxed/simple;
	bh=C/7pxn/zvd0ZkrMu2JxCU9aLE6K8DlE8/+ktjuIqF+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otMJenDNqVYOR38B7HL+/SigtRFHpR9hy6dBxUwncXSVxcr2prrAQ3h3t6pLQeORH0ebFT5cVaUzGzJb6Eqcg4V1rQKM7kC5tWRYE9k2XYzMYof88mo+yRVK+NWxHbzqDx35Ct4Aq+MlQuiBxRRfdK09Oc95th1wn5LujwayfZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jPHjua9W; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id A25BCFF80D;
	Mon, 27 May 2024 16:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716826516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mi3oj3KqfvDzq+/15bPMcWypI2LWK0r10UEBjijnOtc=;
	b=jPHjua9WxG50yVIdqMNDLvOGQkQ6iB4QYm/1BGyxgTb8OooPHLqIJLy60UGGZXbIaxDabh
	pPwkbWZxBGOXlZV1InZfo4OhQlP68xHlK+trSLZ43n7dfRalP7Sbu0nRxGRb4Zchwpp2af
	LeGKWTAEnleyERDMXp34zfuDP8pzZDx22iB0CHstGcAwBtpK48FI1m5zkI/J4kq1c/MQmG
	kTftzwBFldi7v+VE0xn3HBxR8Jku6AQ3puEOoTRhmEHrVYtSkmYNZAx1SGktc5is99y3ii
	Mm4FGQ3Wo2H18jkER+EKHkcMdMh7L1ALa6QmzwRTfI9Jx8aiq6vdAP8rBBQmXg==
From: Herve Codina <herve.codina@bootlin.com>
To: Simon Horman <horms@kernel.org>,
	Sai Krishna Gajula <saikrishnag@marvell.com>,
	Herve Codina <herve.codina@bootlin.com>,
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
Subject: [PATCH v2 10/19] irqdomain: Introduce irq_domain_alloc() and irq_domain_publish()
Date: Mon, 27 May 2024 18:14:37 +0200
Message-ID: <20240527161450.326615-11-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240527161450.326615-1-herve.codina@bootlin.com>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
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
index 86f8b91b0d3a..06c3e1b03a1d 100644
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
 
@@ -1184,7 +1225,7 @@ struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
 		domain->parent = parent;
 		domain->flags |= flags;
 
-		__irq_domain_publish(domain);
+		irq_domain_publish(domain);
 	}
 
 	return domain;
-- 
2.45.0


