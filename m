Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0043E45FA95
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349274AbhK0Bcn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:32:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40294 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349350AbhK0Ban (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:30:43 -0500
Message-ID: <20211126232734.888679179@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=iosGiYlhYBo//aWwbi8Bz/t2OkGIwccy2DoihzPp5zA=;
        b=NkHP56QqPI26ZkjI+rbC4TT1SdRWhhMatKpb9b0ieEBRDCkj+M9l9Lf8nd4XqfyQmkY2c2
        RZXdK4U92O7HW6bTSS5FxlccK+QrZgeTGXAKbs2Swm7Pxga8tgO+YeuLbl0HRJ8nxq4quC
        ud5ApRvAnPOblbXlzREOLWnSRQyDlnVZrffmEl5a8M8phWfuqpYdpCLwkACeieejcQKcGE
        MFTrkOau/mkIopHA6k0yg18+YNjRw9wBfWsnDmGYJz6PFWTqgCxDatnNBoTknJ/g2EA2/W
        be3Fg1e9aFUCwQyxIpal5O6nhLCsblWmfTJlCQF3HXP+2e1IDHGQpJg/Q7BmvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=iosGiYlhYBo//aWwbi8Bz/t2OkGIwccy2DoihzPp5zA=;
        b=Lq4sM7/UKcGY3YF9Q30FYqn9LvYrrTCF9Vz1/3InaSqNckIkAzIBNMnvpJK1W+2bYevHTB
        eCxzuZyZ0soSpGBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: [patch 10/32] PCI/MSI: Let core code free MSI descriptors
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:22:42 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set the domain info flag which tells the core code to free the MSI
descriptors from msi_domain_free_irqs() and add an explicit call to the
core function into the legacy code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/irqdomain.c |    3 ++-
 drivers/pci/msi/legacy.c    |    1 +
 drivers/pci/msi/msi.c       |   14 --------------
 3 files changed, 3 insertions(+), 15 deletions(-)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -171,7 +171,8 @@ struct irq_domain *pci_msi_create_irq_do
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		pci_msi_domain_update_chip_ops(info);
 
-	info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS;
+	info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS |
+		       MSI_FLAG_FREE_MSI_DESCS;
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
 		info->flags |= MSI_FLAG_MUST_REACTIVATE;
 
--- a/drivers/pci/msi/legacy.c
+++ b/drivers/pci/msi/legacy.c
@@ -81,4 +81,5 @@ void pci_msi_legacy_teardown_msi_irqs(st
 {
 	msi_device_destroy_sysfs(&dev->dev);
 	arch_teardown_msi_irqs(dev);
+	msi_free_msi_descs(&dev->dev);
 }
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -224,22 +224,8 @@ EXPORT_SYMBOL_GPL(pci_write_msi_msg);
 
 static void free_msi_irqs(struct pci_dev *dev)
 {
-	struct list_head *msi_list = dev_to_msi_list(&dev->dev);
-	struct msi_desc *entry, *tmp;
-	int i;
-
-	for_each_pci_msi_entry(entry, dev)
-		if (entry->irq)
-			for (i = 0; i < entry->nvec_used; i++)
-				BUG_ON(irq_has_action(entry->irq + i));
-
 	pci_msi_teardown_msi_irqs(dev);
 
-	list_for_each_entry_safe(entry, tmp, msi_list, list) {
-		list_del(&entry->list);
-		free_msi_entry(entry);
-	}
-
 	if (dev->msix_base) {
 		iounmap(dev->msix_base);
 		dev->msix_base = NULL;

