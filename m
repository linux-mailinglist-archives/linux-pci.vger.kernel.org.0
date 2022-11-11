Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9D0625BED
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiKKN65 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiKKN4G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:56:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D7D657FF;
        Fri, 11 Nov 2022 05:55:01 -0800 (PST)
Message-ID: <20221111122015.214792769@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gj8+JLvsSB7JkfjvtAibAPolzK16OEvGxNAST4u+PB8=;
        b=XKPL2kgfTpBrkdRq/Zqnr5TZtcoLiZS8HUTfm0kQkuYgegQYsqUwtY5csl9/CyJkrPrCEz
        A9uxOuIvrfntnY2DKbdKMXmf4ksC0QTVqS9OdMAlOAOQgCdzLXVMmX1JcCPAEBhdSB5mBf
        nhdD2+t2116iU5IqwotSXCD6AhM6aj2Y0RdnX73ut/xTahJDDpijcYHst0UpgmkbhE6eFJ
        UPSG4e0XWUziwhZY+cmfTYsgkNtc8sB9PEd/1aKnPYelYUCQtxFzSfMjWN7EeHPb0ht7Ss
        04ZIAgydyt5L4gwlXCajkYRprDuhpS7NFJtkyRCbyY3urky7Pc8pU8t+6DhEDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gj8+JLvsSB7JkfjvtAibAPolzK16OEvGxNAST4u+PB8=;
        b=U39CZCreXp6akmR3rKYVXRdbqs3XmuPdImd4hF/P0sSdCshaJKWtTXiiq6gHDDA3yj+rKA
        b2RkkjTtCy75QgDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: [patch 28/39] PCI/MSI: Move pci_irq_get_affinity() to api.c
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:54:59 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ahmed S. Darwish <darwi@linutronix.de>

To distangle the maze in msi.c, all exported device-driver MSI APIs are
now to be grouped in one file, api.c.

Move pci_irq_get_affinity() and let its kernel-doc match rest of the
file.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/pci/msi/api.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/msi/msi.c | 38 --------------------------------------
 2 files changed, 43 insertions(+), 38 deletions(-)
---
diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 653a61868ae6..473df7ba0584 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/irq.h>
 
 #include "msi.h"
 
@@ -251,6 +252,48 @@ int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
 EXPORT_SYMBOL(pci_irq_vector);
 
 /**
+ * pci_irq_get_affinity() - Get a device interrupt vector affinity
+ * @dev: the PCI device to operate on
+ * @nr:  device-relative interrupt vector index (0-based); has different
+ *       meanings, depending on interrupt mode
+ *         MSI-X        the index in the MSI-X vector table
+ *         MSI          the index of the enabled MSI vectors
+ *         INTx         must be 0
+ *
+ * Return: MSI/MSI-X vector affinity, NULL if @nr is out of range or if
+ * the MSI(-X) vector was allocated without explicit affinity
+ * requirements (e.g., by pci_enable_msi(), pci_enable_msix_range(), or
+ * pci_alloc_irq_vectors() without the %PCI_IRQ_AFFINITY flag). Return a
+ * generic set of CPU ids representing all possible CPUs available
+ * during system boot if the device is in legacy INTx mode.
+ */
+const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
+{
+	int idx, irq = pci_irq_vector(dev, nr);
+	struct msi_desc *desc;
+
+	if (WARN_ON_ONCE(irq <= 0))
+		return NULL;
+
+	desc = irq_get_msi_desc(irq);
+	/* Non-MSI does not have the information handy */
+	if (!desc)
+		return cpu_possible_mask;
+
+	/* MSI[X] interrupts can be allocated without affinity descriptor */
+	if (!desc->affinity)
+		return NULL;
+
+	/*
+	 * MSI has a mask array in the descriptor.
+	 * MSI-X has a single mask.
+	 */
+	idx = dev->msi_enabled ? nr : 0;
+	return &desc->affinity[idx].mask;
+}
+EXPORT_SYMBOL(pci_irq_get_affinity);
+
+/**
  * pci_free_irq_vectors() - Free previously allocated IRQs for a device
  * @dev: the PCI device to operate on
  *
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 6fa90d07d2e4..d78646d1c116 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -854,44 +854,6 @@ int __pci_enable_msix_range(struct pci_dev *dev,
 	}
 }
 
-/**
- * pci_irq_get_affinity - return the affinity of a particular MSI vector
- * @dev:	PCI device to operate on
- * @nr:		device-relative interrupt vector index (0-based).
- *
- * @nr has the following meanings depending on the interrupt mode:
- *   MSI-X:	The index in the MSI-X vector table
- *   MSI:	The index of the enabled MSI vectors
- *   INTx:	Must be 0
- *
- * Return: A cpumask pointer or NULL if @nr is out of range
- */
-const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
-{
-	int idx, irq = pci_irq_vector(dev, nr);
-	struct msi_desc *desc;
-
-	if (WARN_ON_ONCE(irq <= 0))
-		return NULL;
-
-	desc = irq_get_msi_desc(irq);
-	/* Non-MSI does not have the information handy */
-	if (!desc)
-		return cpu_possible_mask;
-
-	/* MSI[X] interrupts can be allocated without affinity descriptor */
-	if (!desc->affinity)
-		return NULL;
-
-	/*
-	 * MSI has a mask array in the descriptor.
-	 * MSI-X has a single mask.
-	 */
-	idx = dev->msi_enabled ? nr : 0;
-	return &desc->affinity[idx].mask;
-}
-EXPORT_SYMBOL(pci_irq_get_affinity);
-
 struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
 {
 	return to_pci_dev(desc->dev);

