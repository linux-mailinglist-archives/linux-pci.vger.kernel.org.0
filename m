Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF1F6326B8
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiKUOsU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiKUOr6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:47:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E74D32B6;
        Mon, 21 Nov 2022 06:41:57 -0800 (PST)
Message-ID: <20221121140049.491212443@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=MqSNqTk6zSn2/CxqHu1Zk5vIICcROEec5cXqFROUsAQ=;
        b=MED9eLTLCMaP9JjgxDdnM9Qe91gAN0co/FhD3zsKDk9NXRDOHiuAGTbgsIe36YcEteUfzQ
        kEMf1EH6oY52gflGi8LX0nB7hW73PWpue4PDsBbCOM9d7zxAUlVKEizRi0OnHpkCHIEA3W
        DjMqfnm7IkBYxEA8RUfxd0BzaPZRJnplGWLPOgt/UJQTob7mWUMopMESTaZmmYnL8N1kE5
        QSFlG2iLpZxFD7IpRLOya2HausK3SPiWj7dybx49JBRRKp2ER96ARqx+UqMmYoOOGgna0M
        z/+JZPqZv+Pa0+5IdVSLPsBO7/PSMgi0qK5SQPEKmVHdlI7iI2lkwtuuqVPG6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=MqSNqTk6zSn2/CxqHu1Zk5vIICcROEec5cXqFROUsAQ=;
        b=Anqh6ewUZl0pXlAdjbqMgriIRD+DnvrtfkV6fSyBs6v4TKr+4HPdCWXH4A/aracjdB1JgF
        Ja2c16USH0yTsGDw==
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
Subject: [patch V2 19/40] genirq/msi: Split msi_domain_alloc_irq_at()
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:39:52 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation for providing a special allocation function for wired
interrupt which are connected to a wire to MSI bridge, split the inner
workings of msi_domain_alloc_irq_at() out into a helper function so the
code can be shared.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/msi.c |   76 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 33 deletions(-)

--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1465,34 +1465,10 @@ int msi_domain_alloc_irqs_all_locked(str
 	return msi_domain_alloc_locked(dev, &ctrl);
 }
 
-/**
- * msi_domain_alloc_irq_at - Allocate an interrupt from a MSI interrupt domain at
- *			     a given index - or at the next free index
- *
- * @dev:	Pointer to device struct of the device for which the interrupts
- *		are allocated
- * @domid:	Id of the interrupt domain to operate on
- * @index:	Index for allocation. If @index == %MSI_ANY_INDEX the allocation
- *		uses the next free index.
- * @affdesc:	Optional pointer to an interrupt affinity descriptor structure
- * @icookie:	Optional pointer to a domain specific per instance cookie. If
- *		non-NULL the content of the cookie is stored in msi_desc::data.
- *		Must be NULL for MSI-X allocations
- *
- * This requires a MSI interrupt domain which lets the core code manage the
- * MSI descriptors.
- *
- * Return: struct msi_map
- *
- *	On success msi_map::index contains the allocated index number and
- *	msi_map::virq the corresponding Linux interrupt number
- *
- *	On failure msi_map::index contains the error code and msi_map::virq
- *	is %0.
- */
-struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, unsigned int index,
-				       const struct irq_affinity_desc *affdesc,
-				       union msi_instance_cookie *icookie)
+static struct msi_map __msi_domain_alloc_irq_at(struct device *dev, unsigned int domid,
+						unsigned int index,
+						const struct irq_affinity_desc *affdesc,
+						union msi_instance_cookie *icookie)
 {
 	struct msi_ctrl ctrl = { .domid	= domid, .nirqs = 1, };
 	struct msi_domain_info *info;
@@ -1501,17 +1477,16 @@ struct msi_map msi_domain_alloc_irq_at(s
 	struct msi_desc *desc;
 	int ret;
 
-	msi_lock_descs(dev);
 	domain = msi_get_device_domain(dev, domid);
 	if (!domain) {
 		map.index = -ENODEV;
-		goto unlock;
+		return map;
 	}
 
 	desc = msi_alloc_desc(dev, 1, affdesc);
 	if (!desc) {
 		map.index = -ENOMEM;
-		goto unlock;
+		return map;
 	}
 
 	if (icookie)
@@ -1520,7 +1495,7 @@ struct msi_map msi_domain_alloc_irq_at(s
 	ret = msi_insert_desc(dev, desc, domid, index);
 	if (ret) {
 		map.index = ret;
-		goto unlock;
+		return map;
 	}
 
 	ctrl.first = ctrl.last = desc->msi_index;
@@ -1534,7 +1509,42 @@ struct msi_map msi_domain_alloc_irq_at(s
 		map.index = desc->msi_index;
 		map.virq = desc->irq;
 	}
-unlock:
+	return map;
+}
+
+/**
+ * msi_domain_alloc_irq_at - Allocate an interrupt from a MSI interrupt domain at
+ *			     a given index - or at the next free index
+ *
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are allocated
+ * @domid:	Id of the interrupt domain to operate on
+ * @index:	Index for allocation. If @index == %MSI_ANY_INDEX the allocation
+ *		uses the next free index.
+ * @affdesc:	Optional pointer to an interrupt affinity descriptor structure
+ * @icookie:	Optional pointer to a domain specific per instance cookie. If
+ *		non-NULL the content of the cookie is stored in msi_desc::data.
+ *		Must be NULL for MSI-X allocations
+ *
+ * This requires a MSI interrupt domain which lets the core code manage the
+ * MSI descriptors.
+ *
+ * Return: struct msi_map
+ *
+ *	On success msi_map::index contains the allocated index number and
+ *	msi_map::virq the corresponding Linux interrupt number
+ *
+ *	On failure msi_map::index contains the error code and msi_map::virq
+ *	is %0.
+ */
+struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, unsigned int index,
+				       const struct irq_affinity_desc *affdesc,
+				       union msi_instance_cookie *icookie)
+{
+	struct msi_map map;
+
+	msi_lock_descs(dev);
+	map = __msi_domain_alloc_irq_at(dev, domid, index, affdesc, icookie);
 	msi_unlock_descs(dev);
 	return map;
 }

