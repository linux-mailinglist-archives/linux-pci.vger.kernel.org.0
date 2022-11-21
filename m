Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37806326C8
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiKUOto (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbiKUOsO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:48:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AE8D33B8;
        Mon, 21 Nov 2022 06:42:09 -0800 (PST)
Message-ID: <20221121140049.679827689@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fNlJq7eUueydjyHA34mJBe9PSXy3iovJN7ArQPlOsWU=;
        b=R66Bn3oMfKbAtRRfMMszVlBS+aGiqDqLdJzWQVM7YC9/DMBe6MNJKW7bMy8QT/0z0RCDdE
        oaju4mmWCHRGR/tiMvp5qEQCni0VBKIuXN4EjHphh9slImL/oWrNgH3kKOHlRZWe0SYNi0
        13mPES8l9aOkXsyk88Uj8g4rm1aXrB8TikYqTgEZzpnjwDjjrYH6gydH4jj6Lcys5jDsUh
        ulXkLA5eyvAzwWDLYNIw59E12iqnwh9et+i8C0H83k4Qh+iN1x1Xa/r1ii8or9BoZA3XfI
        vRc7b7zghEEz9r37fw4mit2QEG0Z01Fj7DM13ie0CIZNJESChT0dT15oZPE/9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fNlJq7eUueydjyHA34mJBe9PSXy3iovJN7ArQPlOsWU=;
        b=8EZXOY4u5eB2hDqCFbU5zgotL72sPCtlKFZCE3GO3oA1y1NhwRQwlQSE32pIYk8sv8Wwx6
        Z6WW4edgQ7gcI7CQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: [patch V2 22/40] genirq/msi: Provide allocation/free functions for
 "wired" MSI interrupts
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:39:56 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To support wire to MSI bridges proper in the MSI core infrastructure it is
required to have separate allocation/free interfaces which can be invoked
from the regular irqdomain allocaton/free functions.

The mechanism for allocation is:
  - Allocate the next free MSI descriptor index in the domain
  - Store the hardware interrupt number and the trigger type
    which was extracted by the irqdomain core from the firmware spec
    in the MSI descriptor device cookie so it can be retrieved by
    the underlying interrupt domain and interrupt chip
  - Use the regular MSI allocation mechanism for the newly allocated
    index which returns a fully initialized Linux interrupt on succes

This works because:
  - the domains have a fixed size
  - each hardware interrupt is only allocated once
  - the underlying domain does not care about the MSI index it only cares
    about the hardware interrupt number and the trigger type

The free function looks up the MSI index in the MSI descriptor of the
provided Linux interrupt number and uses the regular index based free
functions of the MSI core.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irqdomain.h |   17 +++++++++++
 kernel/irq/msi.c          |   68 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -634,6 +634,23 @@ static inline bool irq_domain_is_msi_dev
 
 #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 
+#ifdef CONFIG_GENERIC_MSI_IRQ
+int msi_device_domain_alloc_wired(struct irq_domain *domain, unsigned int hwirq,
+				  unsigned int type);
+void msi_device_domain_free_wired(struct irq_domain *domain, unsigned int virq);
+#else
+static inline int msi_device_domain_alloc_wired(struct irq_domain *domain, unsigned int hwirq,
+						unsigned int type)
+{
+	WARN_ON_ONCE(1);
+	return -EINVAL;
+}
+static inline void msi_device_domain_free_wired(struct irq_domain *domain, unsigned int virq)
+{
+	WARN_ON_ONCE(1);
+}
+#endif
+
 #else /* CONFIG_IRQ_DOMAIN */
 static inline void irq_dispose_mapping(unsigned int virq) { }
 static inline struct irq_domain *irq_find_matching_fwnode(
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1561,6 +1561,50 @@ struct msi_map msi_domain_alloc_irq_at(s
 	return map;
 }
 
+/**
+ * msi_device_domain_alloc_wired - Allocate a "wired" interrupt on @domain
+ * @domain:	The domain to allocate on
+ * @hwirq:	The hardware interrupt number to allocate for
+ * @type:	The interrupt type
+ *
+ * This weirdness supports wire to MSI controllers like MBIGEN.
+ *
+ * @hwirq is the hardware interrupt number which is handed in from
+ * irq_create_fwspec_mapping(). As the wire to MSI domain is sparse, but
+ * sized in firmware, the hardware interrupt number cannot be used as MSI
+ * index. For the underlying irq chip the MSI index is irrelevant and
+ * all it needs is the hardware interrupt number.
+ *
+ * To handle this the MSI index is allocated with MSI_ANY_INDEX and the
+ * hardware interrupt number is stored along with the type information in
+ * msi_desc::cookie so the underlying interrupt chip and domain code can
+ * retrieve it.
+ *
+ * Return: The Linux interrupt number (> 0) or an error code
+ */
+int msi_device_domain_alloc_wired(struct irq_domain *domain, unsigned int hwirq,
+				  unsigned int type)
+{
+	unsigned int domid = MSI_DEFAULT_DOMAIN;
+	union msi_instance_cookie icookie = { };
+	struct device *dev = domain->dev;
+	struct msi_map map = { };
+
+	if (WARN_ON_ONCE(!dev || domain->bus_token != DOMAIN_BUS_WIRED_TO_MSI))
+		return -EINVAL;
+
+	icookie.value = ((u64)type << 32) | hwirq;
+
+	msi_lock_descs(dev);
+	if (WARN_ON_ONCE(msi_get_device_domain(dev, domid) != domain))
+		map.index = -EINVAL;
+	else
+		map = __msi_domain_alloc_irq_at(dev, domid, MSI_ANY_INDEX, NULL, &icookie);
+	msi_unlock_descs(dev);
+
+	return map.index >= 0 ? map.virq : map.index;
+}
+
 static void __msi_domain_free_irqs(struct device *dev, struct irq_domain *domain,
 				   struct msi_ctrl *ctrl)
 {
@@ -1688,6 +1732,30 @@ void msi_domain_free_irqs_all(struct dev
 	msi_unlock_descs(dev);
 }
 
+/**
+ * msi_device_domain_free_wired - Free a wired interrupt in @domain
+ * @domain:	The domain to free the interrupt on
+ * @virq:	The Linux interrupt number to free
+ *
+ * This is the counterpart of msi_device_domain_alloc_wired() for the
+ * weird wired to MSI converting domains.
+ */
+void msi_device_domain_free_wired(struct irq_domain *domain, unsigned int virq)
+{
+	struct msi_desc *desc = irq_get_msi_desc(virq);
+	struct device *dev = domain->dev;
+
+	if (WARN_ON_ONCE(!dev || !desc || domain->bus_token != DOMAIN_BUS_WIRED_TO_MSI))
+		return;
+
+	msi_lock_descs(dev);
+	if (!WARN_ON_ONCE(msi_get_device_domain(dev, MSI_DEFAULT_DOMAIN) != domain)) {
+		msi_domain_free_irqs_range_locked(dev, MSI_DEFAULT_DOMAIN, desc->msi_index,
+						  desc->msi_index);
+	}
+	msi_unlock_descs(dev);
+}
+
 /**
  * msi_get_domain_info - Get the MSI interrupt domain info for @domain
  * @domain:	The interrupt domain to retrieve data from

