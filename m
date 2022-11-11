Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7478C625BC7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiKKN5D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbiKKN4E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:56:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8016EB4E;
        Fri, 11 Nov 2022 05:54:58 -0800 (PST)
Message-ID: <20221111122015.099461602@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CkhwWSdGdGLLdzERFUfoG3NG0AhBrHuNhPbAZeB+IvI=;
        b=D/KO6ishfBlfCq11YH+Ofhy+P61hIKqceGKviXzQcvhX0F2xVoFUKMaucjWQOPHIBOtS0B
        /j/MU4IcPEAS0VdVZHkO+m3UpDZ7hTXF33/Ws3G36Ip5JRiX14aot8JnOG7L0U7Qq1Xlgj
        jjE4VymkIPiaEDau2j6yY/Sl8BqceSabP7pTCy9X4x6BTvRBxW/OT6bTntFuHWPwbPKT/V
        P1zatp5UOC1Uot6hhlrU4Qg82vOIZiBJdLZQcCmvdUdXk2TvgXRC20jIdiqB3/7836nSxW
        igL35SY8mpivrwl4VnRlxvfpssCjhZbbAJ3NJWotgixp4zcrki9BuKBYDFbLCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=CkhwWSdGdGLLdzERFUfoG3NG0AhBrHuNhPbAZeB+IvI=;
        b=agDEdkn3tqZvtSL/jqK2oB0oAy2H7vZ7hxPqegmfJc4ZGq2IGaAmYVus2CH/27QQDR0vBr
        OGs+tQD1dSzmRxCg==
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
Subject: [patch 26/39] PCI/MSI: Move pci_msix_vec_count() to api.c
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:54:56 +0100 (CET)
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

Move pci_msix_vec_count() and make its kernel-doc comprehensive.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/pci/msi/api.c | 20 ++++++++++++++++++++
 drivers/pci/msi/msi.c | 20 --------------------
 2 files changed, 20 insertions(+), 20 deletions(-)
---
diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 2ff2a9ccfc47..83ea38ffa116 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -60,6 +60,26 @@ void pci_disable_msi(struct pci_dev *dev)
 EXPORT_SYMBOL(pci_disable_msi);
 
 /**
+ * pci_msix_vec_count() - Get number of MSI-X interrupt vectors on device
+ * @dev: the PCI device to operate on
+ *
+ * Return: number of MSI-X interrupt vectors available on this device
+ * (i.e., the device's MSI-X capability structure "table size"), -EINVAL
+ * if the device is not MSI-X capable, other errnos otherwise.
+ */
+int pci_msix_vec_count(struct pci_dev *dev)
+{
+	u16 control;
+
+	if (!dev->msix_cap)
+		return -EINVAL;
+
+	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
+	return msix_table_size(control);
+}
+EXPORT_SYMBOL(pci_msix_vec_count);
+
+/**
  * pci_enable_msix_range() - Enable MSI-X interrupt mode on device
  * @dev:     the PCI device to operate on
  * @entries: input/output parameter, array of MSI-X configuration entries
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index ed8caf5ac99f..1226d66da992 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -701,26 +701,6 @@ void pci_msi_shutdown(struct pci_dev *dev)
 	pcibios_alloc_irq(dev);
 }
 
-/**
- * pci_msix_vec_count - return the number of device's MSI-X table entries
- * @dev: pointer to the pci_dev data structure of MSI-X device function
- * This function returns the number of device's MSI-X table entries and
- * therefore the number of MSI-X vectors device is capable of sending.
- * It returns a negative errno if the device is not capable of sending MSI-X
- * interrupts.
- **/
-int pci_msix_vec_count(struct pci_dev *dev)
-{
-	u16 control;
-
-	if (!dev->msix_cap)
-		return -EINVAL;
-
-	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
-	return msix_table_size(control);
-}
-EXPORT_SYMBOL(pci_msix_vec_count);
-
 static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
 			     int nvec, struct irq_affinity *affd, int flags)
 {

