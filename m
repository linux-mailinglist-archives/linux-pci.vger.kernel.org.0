Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3786326D4
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiKUOuc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiKUOtr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:49:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13A0C847F;
        Mon, 21 Nov 2022 06:42:24 -0800 (PST)
Message-ID: <20221121140049.743020502@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=npOaMCiYsoks0F7mHssoAU+zRn6o9Ysh3VW0SdHACSU=;
        b=3TXaiHo6uW/aaxhnn2KG2Uzs838Y0pUbjSbvGJnh1pBFM2qh0vmz1R1CYFhvBn/V+bBa+P
        qwqWNnGpZd1K7XNyAJNSF/r8d0eQhQKK2KrWIQcgxFdQV3gJ4j9EGNka2wfvb9+pEC2NWE
        pUT3CD6XMUO23n406SnSgCqYEEaLypzPm/EI8vzvarXHuJQSZM8qfFKN71TRhILFXcokWs
        3m8TcmB+bIaUxk5/fU1lmgPgs9UYAq/aWa4Lrvw7upCGZKXiC6pcPn/vWdkMw+oPDE0qK3
        mBY52Bdx0MYXhRgDTIQp8Pi2+l3VhW1IlOhtunxsXWhyA/QRkaBNRVESDO0VkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=npOaMCiYsoks0F7mHssoAU+zRn6o9Ysh3VW0SdHACSU=;
        b=AwJHQdeqKACcGONTrz7Gd3yQY8ESpH15ZOH7wfsX2lcP4RybVMRkXhywwStrFS9S/RZXKw
        5KwEx0d+A7/tCxDg==
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
Subject: [patch V2 23/40] genirq/irqdomain: Reroute device MSI create_mapping
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:39:57 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reroute interrupt allocation in irq_create_fwspec_mapping() if the domain
is a MSI device domain. This is required to convert the support for wire
to MSI bridges to per device MSI domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/irqdomain.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -26,6 +26,7 @@ static DEFINE_MUTEX(irq_domain_mutex);
 static struct irq_domain *irq_default_domain;
 
 static void irq_domain_check_hierarchy(struct irq_domain *domain);
+static void irq_domain_free_one_irq(struct irq_domain *domain, unsigned int virq);
 
 struct irqchip_fwid {
 	struct fwnode_handle	fwnode;
@@ -822,7 +823,10 @@ unsigned int irq_create_fwspec_mapping(s
 	}
 
 	if (irq_domain_is_hierarchy(domain)) {
-		virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, fwspec);
+		if (irq_domain_is_msi_device(domain))
+			virq = msi_device_domain_alloc_wired(domain, hwirq, type);
+		else
+			virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, fwspec);
 		if (virq <= 0)
 			return 0;
 	} else {
@@ -835,7 +839,7 @@ unsigned int irq_create_fwspec_mapping(s
 	irq_data = irq_get_irq_data(virq);
 	if (!irq_data) {
 		if (irq_domain_is_hierarchy(domain))
-			irq_domain_free_irqs(virq, 1);
+			irq_domain_free_one_irq(domain, virq);
 		else
 			irq_dispose_mapping(virq);
 		return 0;
@@ -876,7 +880,7 @@ void irq_dispose_mapping(unsigned int vi
 		return;
 
 	if (irq_domain_is_hierarchy(domain)) {
-		irq_domain_free_irqs(virq, 1);
+		irq_domain_free_one_irq(domain, virq);
 	} else {
 		irq_domain_disassociate(domain, virq);
 		irq_free_desc(virq);
@@ -1706,6 +1710,14 @@ void irq_domain_free_irqs(unsigned int v
 	irq_free_descs(virq, nr_irqs);
 }
 
+static void irq_domain_free_one_irq(struct irq_domain *domain, unsigned int virq)
+{
+	if (irq_domain_is_msi_device(domain))
+		msi_device_domain_free_wired(domain, virq);
+	else
+		irq_domain_free_irqs(virq, 1);
+}
+
 /**
  * irq_domain_alloc_irqs_parent - Allocate interrupts from parent domain
  * @domain:	Domain below which interrupts must be allocated
@@ -1865,9 +1877,9 @@ void irq_domain_set_info(struct irq_doma
 	irq_set_handler_data(virq, handler_data);
 }
 
-static void irq_domain_check_hierarchy(struct irq_domain *domain)
-{
-}
+static void irq_domain_check_hierarchy(struct irq_domain *domain) { }
+static void irq_domain_free_one_irq(struct irq_domain *domain, unsigned int virq) { }
+
 #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS

