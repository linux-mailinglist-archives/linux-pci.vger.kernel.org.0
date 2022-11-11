Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2431B625BBD
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiKKN4d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbiKKNzs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:55:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EFA79D3A;
        Fri, 11 Nov 2022 05:54:48 -0800 (PST)
Message-ID: <20221111122014.755178149@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=wQvlSyzCiWq4qPGjM0h6GVII+05+CelOP+QrbE9YOVQ=;
        b=fw5D8vTEf9OL/Hzxz50Ijd298/wbFchLIr8TMyRCskQnsWvuZwH85WDzYjyxa/PEEcm5S/
        jq140H9dPnla1HZ3agqexHNFjhhzevUEVMXErO41h9kt9fao5vPKasGbCjKy9taJBY6hzv
        yXdu189B1M6hsC3msYMEU/SeaOuNFVdBoPjU9PO6ZGO+f4orB+1BmljW6SgW5O74Z3rM4b
        QSHAkL0lksdoznJyZ5kTjUKaP+JCdBYlcsUUx2Evza+ALkmP6L3ImXtuKlCJSPLOwLVok0
        zz/njXuPPM0/spkdh7Z/3jQC9a2dfjIJeIQNNTOdDc1iR6SkzxFynpI0qJ0vhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=wQvlSyzCiWq4qPGjM0h6GVII+05+CelOP+QrbE9YOVQ=;
        b=ziGlwcK3Nj4s7gB/ueyqfSNSgD74IeHz55tHp/olK9uxKE7YDq5psk3BkZY1xDx4OMxWIZ
        CVYs5Yt0p+c5FYCw==
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
Subject: [patch 20/39] PCI/MSI: Move pci_enable_msi() API to api.c
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:54:46 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ahmed S. Darwish <darwi@linutronix.de>

To distangle the maze in msi.c all exported device-driver MSI APIs are now
to be grouped in one file, api.c.

Move pci_enable_msi() and make its kernel-doc comprehensive.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/pci/msi/api.c | 23 +++++++++++++++++++++++
 drivers/pci/msi/msi.c | 14 ++------------
 drivers/pci/msi/msi.h |  1 +
 3 files changed, 26 insertions(+), 12 deletions(-)
---
diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 7485942cbe5d..63d7f8f6a284 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -13,6 +13,29 @@
 #include "msi.h"
 
 /**
+ * pci_enable_msi() - Enable MSI interrupt mode on device
+ * @dev: the PCI device to operate on
+ *
+ * Legacy device driver API to enable MSI interrupts mode on device and
+ * allocate a single interrupt vector. On success, the allocated vector
+ * Linux IRQ will be saved at @dev->irq. The driver must invoke
+ * pci_disable_msi() on cleanup.
+ *
+ * NOTE: The newer pci_alloc_irq_vectors() / pci_free_irq_vectors() API
+ * pair should, in general, be used instead.
+ *
+ * Return: 0 on success, errno otherwise
+ */
+int pci_enable_msi(struct pci_dev *dev)
+{
+	int rc = __pci_enable_msi_range(dev, 1, 1, NULL);
+	if (rc < 0)
+		return rc;
+	return 0;
+}
+EXPORT_SYMBOL(pci_enable_msi);
+
+/**
  * pci_disable_msi() - Disable MSI interrupt mode on device
  * @dev: the PCI device to operate on
  *
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 4a1300b74518..98f07ad9af62 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -790,8 +790,8 @@ void pci_disable_msix(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_disable_msix);
 
-static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
-				  struct irq_affinity *affd)
+int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
+			   struct irq_affinity *affd)
 {
 	int nvec;
 	int rc;
@@ -844,16 +844,6 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	}
 }
 
-/* deprecated, don't use */
-int pci_enable_msi(struct pci_dev *dev)
-{
-	int rc = __pci_enable_msi_range(dev, 1, 1, NULL);
-	if (rc < 0)
-		return rc;
-	return 0;
-}
-EXPORT_SYMBOL(pci_enable_msi);
-
 static int __pci_enable_msix_range(struct pci_dev *dev,
 				   struct msix_entry *entries, int minvec,
 				   int maxvec, struct irq_affinity *affd,
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index 634879277349..00bb98d5bb0e 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -87,6 +87,7 @@ static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
 /* MSI internal functions invoked from the public APIs */
 void pci_msi_shutdown(struct pci_dev *dev);
 void pci_free_msi_irqs(struct pci_dev *dev);
+int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec, struct irq_affinity *affd);
 
 /* Legacy (!IRQDOMAIN) fallbacks */
 #ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS

