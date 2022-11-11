Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A49625BC6
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiKKN5D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiKKN4D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:56:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C14170196;
        Fri, 11 Nov 2022 05:54:57 -0800 (PST)
Message-ID: <20221111122015.042870570@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=P/dAsiB53NJ/9QiJ4hqH6W6Pskq4afAJG9tsk8AaX0Q=;
        b=OeXI2uBL1i4cCBWgCLDCjfWVrO+TGW/TKKoqPVlW6nRd7XuB0IylCLK2nnOS3JJqj3KGI3
        woLnfcgLSwYHZfNTtZFOEzz/OUe8qmGOn1D/90O9/tMmcrTFbaxgcOkimW4wca31nX+6fC
        rNZqtK0XNoFRelFd/wWbFk4E84e8ezV7r/WBQN9qW/AlngbQicYTjPhvAEphKERN1UITqk
        j90JU0Ss2QQmTZzYyKyHXqECZWoRbVTbL4m6uUzQvH8hti+SyK0UoTlWAK8oD9ZKR1gLpM
        Rx1OR7SPtFM+tzdG9IJzLGeX4uVZOyPbm8AegMk+Ao7r2WOjtMa2HgjIieasKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=P/dAsiB53NJ/9QiJ4hqH6W6Pskq4afAJG9tsk8AaX0Q=;
        b=9etn11z13NPR3uOdAi/jxOseLod+YzmlXXfbgUMng69yMTgPSyiR5PWQM9MtTrhncoBb0J
        HEo73bvyvg7D2UBg==
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
Subject: [patch 25/39] PCI/MSI: Move pci_free_irq_vectors() to api.c
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:54:54 +0100 (CET)
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

Move pci_free_irq_vectors() and make its kernel-doc comprehensive.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/pci/msi/api.c | 15 +++++++++++++++
 drivers/pci/msi/msi.c | 13 -------------
 2 files changed, 15 insertions(+), 13 deletions(-)
---
diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 0f1ec87e3f9f..2ff2a9ccfc47 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -205,3 +205,18 @@ int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
 	return irq ? irq : -EINVAL;
 }
 EXPORT_SYMBOL(pci_irq_vector);
+
+/**
+ * pci_free_irq_vectors() - Free previously allocated IRQs for a device
+ * @dev: the PCI device to operate on
+ *
+ * Undo the interrupt vector allocations and possible device MSI/MSI-X
+ * enablement earlier done through pci_alloc_irq_vectors_affinity() or
+ * pci_alloc_irq_vectors().
+ */
+void pci_free_irq_vectors(struct pci_dev *dev)
+{
+	pci_disable_msix(dev);
+	pci_disable_msi(dev);
+}
+EXPORT_SYMBOL(pci_free_irq_vectors);
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 38ad2fe4b85c..ed8caf5ac99f 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -887,19 +887,6 @@ int __pci_enable_msix_range(struct pci_dev *dev,
 }
 
 /**
- * pci_free_irq_vectors - free previously allocated IRQs for a device
- * @dev:		PCI device to operate on
- *
- * Undoes the allocations and enabling in pci_alloc_irq_vectors().
- */
-void pci_free_irq_vectors(struct pci_dev *dev)
-{
-	pci_disable_msix(dev);
-	pci_disable_msi(dev);
-}
-EXPORT_SYMBOL(pci_free_irq_vectors);
-
-/**
  * pci_irq_get_affinity - return the affinity of a particular MSI vector
  * @dev:	PCI device to operate on
  * @nr:		device-relative interrupt vector index (0-based).

