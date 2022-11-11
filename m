Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D610625BCB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbiKKN5I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiKKN4H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:56:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECECC7F553;
        Fri, 11 Nov 2022 05:55:04 -0800 (PST)
Message-ID: <20221111122015.331584998@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=17rQ88vsZDtlPmncoLd4F1WtMoDw5uG6QE6awHFzEIw=;
        b=u0MBwOKfdKIjVYsMnyfBs1VTZDXJEX6DuRpL7pKRU7BC7LYQGVWXa3TmnszJmKSgH0051K
        OtzIlEYeXodSuQoLNocXCVjSNJ+SgKfEAeXuS+64VjLc4GPurIWeeRHa/RRkj7DvlLMz63
        0E/LNoqZcMdHj7I03PLUzpPAk0nNuDtVGV0syPSnWCo1HSXjsr/Do7sHxw7mBxdBdzj41H
        zYliO7BNOl/ULvKU3DrQsE0n8X9U9rQ64Pi/Xy1uzv7lY0jO0j/y3V/2yvzS+fX30EUVaF
        iQ3hOSlA943JC+BvTCqBq/hIeuk9COv4UtayBK3AXOCrIBZBpde6Ui88XR3MVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=17rQ88vsZDtlPmncoLd4F1WtMoDw5uG6QE6awHFzEIw=;
        b=yM3dN0j6bNW9WtIT9LkNs9RYaMlN3S1D8j/YyTsQdLKC9l8Stsx3vyIB4R3Y33YnomF1gB
        ueyboCuUeHb+1ACQ==
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
Subject: [patch 30/39] PCI/MSI: Move pci_msi_restore_state() to api.c
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:55:03 +0100 (CET)
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
    
Move pci_msi_enabled() and add kernel-doc for the function.
    
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index ee9ed5ccd94d..8d1cf6db9bd7 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -308,6 +308,21 @@ void pci_free_irq_vectors(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_free_irq_vectors);
 
+/**
+ * pci_restore_msi_state() - Restore cached MSI(-X) state on device
+ * @dev: the PCI device to operate on
+ *
+ * Write the Linux-cached MSI(-X) state back on device. This is
+ * typically useful upon system resume, or after an error-recovery PCI
+ * adapter reset.
+ */
+void pci_restore_msi_state(struct pci_dev *dev)
+{
+	__pci_restore_msi_state(dev);
+	__pci_restore_msix_state(dev);
+}
+EXPORT_SYMBOL_GPL(pci_restore_msi_state);
+
 /**
  * pci_msi_enabled() - Are MSI(-X) interrupts enabled system-wide?
  *
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 59c33bc7fe81..a5d168c823ff 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -199,7 +199,7 @@ bool __weak arch_restore_msi_irqs(struct pci_dev *dev)
 	return true;
 }
 
-static void __pci_restore_msi_state(struct pci_dev *dev)
+void __pci_restore_msi_state(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
 	u16 control;
@@ -231,7 +231,7 @@ static void pci_msix_clear_and_set_ctrl(struct pci_dev *dev, u16 clear, u16 set)
 	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, ctrl);
 }
 
-static void __pci_restore_msix_state(struct pci_dev *dev)
+void __pci_restore_msix_state(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
 	bool write_msg;
@@ -257,13 +257,6 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }
 
-void pci_restore_msi_state(struct pci_dev *dev)
-{
-	__pci_restore_msi_state(dev);
-	__pci_restore_msix_state(dev);
-}
-EXPORT_SYMBOL_GPL(pci_restore_msi_state);
-
 static void pcim_msi_release(void *pcidev)
 {
 	struct pci_dev *dev = pcidev;
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index f3f4ede53171..8170ef2c5ad0 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -94,6 +94,8 @@ void pci_free_msi_irqs(struct pci_dev *dev);
 int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec, struct irq_affinity *affd);
 int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int minvec,
 			    int maxvec,  struct irq_affinity *affd, int flags);
+void __pci_restore_msi_state(struct pci_dev *dev);
+void __pci_restore_msix_state(struct pci_dev *dev);
 
 /* Legacy (!IRQDOMAIN) fallbacks */
 

