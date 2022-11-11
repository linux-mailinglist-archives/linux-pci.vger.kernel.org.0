Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043A2625BC5
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbiKKN5C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbiKKN4D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:56:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47295B5BF;
        Fri, 11 Nov 2022 05:54:55 -0800 (PST)
Message-ID: <20221111122014.984490384@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=bxe0AjpBaoDMg06CufdaCUWamwxhkdwl4bTBiQjCzNI=;
        b=cMGjLzZLtmJIj58oYr5P3Ok8YQZLmzLoqv8TcqjtDHGQGStfIwRRz5FAYENf+XUzKGvFfS
        U1HqMwbCGOu0ahCBvnP2LQuO4FVRfi6O6k8841mBDJLItntDNq2ICHJfGF8UOnvYlFZE1u
        MX98Yle05T3N1FhK+437CoOLSQfAyuWBThsr5H67RoLT46/GqCnJG2QP2J6tNr1wDFi7CZ
        uGECO372Vzpln/6RAnJjnLmcyJnBJYPQkkFr8QpGCUaz1gFD7VWXhMt+ebnZbvAhE0jFBC
        vOwD7a/CNm1eMI6JXWXXhXxMeCiz1a0yK3djJ5QxUfmSDOqc5eODC3QC3m22Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=bxe0AjpBaoDMg06CufdaCUWamwxhkdwl4bTBiQjCzNI=;
        b=GqtozON3j5ddGqHse/b7ZFUeu9EaxdoXxaDKXGoeMNdAqhq3kEXBAFF/JTK28GaSU9IPnt
        NQvt0Gobxx0TOqBQ==
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
Subject: [patch 24/39] PCI/MSI: Move pci_irq_vector() to api.c
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:54:53 +0100 (CET)
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

Move pci_irq_vector() and let its kernel-doc match the rest of the file.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/pci/msi/api.c | 23 +++++++++++++++++++++++
 drivers/pci/msi/msi.c | 24 ------------------------
 2 files changed, 23 insertions(+), 24 deletions(-)
---
diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 8546749afa6e..0f1ec87e3f9f 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -182,3 +182,26 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 	return nvecs;
 }
 EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
+
+/**
+ * pci_irq_vector() - Get Linux IRQ number of a device interrupt vector
+ * @dev: the PCI device to operate on
+ * @nr:  device-relative interrupt vector index (0-based); has different
+ *       meanings, depending on interrupt mode
+ *         MSI-X        the index in the MSI-X vector table
+ *         MSI          the index of the enabled MSI vectors
+ *         INTx         must be 0
+ *
+ * Return: the Linux IRQ number, or -EINVAL if @nr is out of range
+ */
+int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
+{
+	unsigned int irq;
+
+	if (!dev->msi_enabled && !dev->msix_enabled)
+		return !nr ? dev->irq : -EINVAL;
+
+	irq = msi_get_virq(&dev->dev, nr);
+	return irq ? irq : -EINVAL;
+}
+EXPORT_SYMBOL(pci_irq_vector);
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index a028774f438d..38ad2fe4b85c 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -900,30 +900,6 @@ void pci_free_irq_vectors(struct pci_dev *dev)
 EXPORT_SYMBOL(pci_free_irq_vectors);
 
 /**
- * pci_irq_vector - return Linux IRQ number of a device vector
- * @dev:	PCI device to operate on
- * @nr:		Interrupt vector index (0-based)
- *
- * @nr has the following meanings depending on the interrupt mode:
- *   MSI-X:	The index in the MSI-X vector table
- *   MSI:	The index of the enabled MSI vectors
- *   INTx:	Must be 0
- *
- * Return: The Linux interrupt number or -EINVAl if @nr is out of range.
- */
-int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
-{
-	unsigned int irq;
-
-	if (!dev->msi_enabled && !dev->msix_enabled)
-		return !nr ? dev->irq : -EINVAL;
-
-	irq = msi_get_virq(&dev->dev, nr);
-	return irq ? irq : -EINVAL;
-}
-EXPORT_SYMBOL(pci_irq_vector);
-
-/**
  * pci_irq_get_affinity - return the affinity of a particular MSI vector
  * @dev:	PCI device to operate on
  * @nr:		device-relative interrupt vector index (0-based).

