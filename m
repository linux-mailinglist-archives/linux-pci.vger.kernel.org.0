Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FED46ADA0
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 23:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376651AbhLFW4F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 17:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376697AbhLFWzl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 17:55:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07E7C0613F8;
        Mon,  6 Dec 2021 14:51:47 -0800 (PST)
Message-ID: <20211206210749.063705667@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638831106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=9e4EOcKKPduqUhpCF4p+2UUYlWyoniP7lkjFDtpqz3Y=;
        b=Y3Zk3CvhlchISCdf8dHPj4poyVu0qDQ568VEyVaToZAlNEqQi/S1x3gDaMvyVdtKEPlDeK
        gom1c1hZJ0+1FVRsN8FfMivDuckiCDX0hSqJocL2HBHr+t7Yk7CLCWJG34R78+WM0bTybW
        EOCNKInDl7y7WUoj3SW3ApdxCAnHdCzZtMeho1tEAjRiAo+SxRcaihs82O+dYDY7PO3p/+
        XCkyrbnh37tVACqnHEPr1obQxu1CsvWACFBW84i4AJhSO3ZQXkpsI2o/SwVyuSRwP7Bw+h
        6TRWEy6ZzgFoXF8vRrbJTv5ELeNAEME6EyTykOq4Aqm8xgRDNtUCA+FwM1sxvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638831106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=9e4EOcKKPduqUhpCF4p+2UUYlWyoniP7lkjFDtpqz3Y=;
        b=AjrNQMXU7lGzUGrbWNCpXMglJn8ZwBKEcm1/D7OSmkwL48kKIquDrjBmMavN5yx36Y6jdl
        /30zlBFMrb57wTDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: [patch V2 27/31] genirq/msi: Convert to new functions
References: <20211206210600.123171746@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  6 Dec 2021 23:51:45 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use the new iterator functions and add locking where required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/msi.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -348,6 +348,7 @@ EXPORT_SYMBOL_GPL(msi_next_desc);
 unsigned int msi_get_virq(struct device *dev, unsigned int index)
 {
 	struct msi_desc *desc;
+	unsigned int ret = 0;
 	bool pcimsi;
 
 	if (!dev->msi.data)
@@ -355,11 +356,12 @@ unsigned int msi_get_virq(struct device
 
 	pcimsi = msi_device_has_property(dev, MSI_PROP_PCI_MSI);
 
-	for_each_msi_entry(desc, dev) {
+	msi_lock_descs(dev);
+	msi_for_each_desc(desc, dev, MSI_DESC_ASSOCIATED) {
 		/* PCI-MSI has only one descriptor for multiple interrupts. */
 		if (pcimsi) {
-			if (desc->irq && index < desc->nvec_used)
-				return desc->irq + index;
+			if (index < desc->nvec_used)
+				ret = desc->irq + index;
 			break;
 		}
 
@@ -367,10 +369,13 @@ unsigned int msi_get_virq(struct device
 		 * PCI-MSIX and platform MSI use a descriptor per
 		 * interrupt.
 		 */
-		if (desc->msi_index == index)
-			return desc->irq;
+		if (desc->msi_index == index) {
+			ret = desc->irq;
+			break;
+		}
 	}
-	return 0;
+	msi_unlock_descs(dev);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(msi_get_virq);
 
@@ -401,7 +406,7 @@ static const struct attribute_group **ms
 	int i;
 
 	/* Determine how many msi entries we have */
-	for_each_msi_entry(entry, dev)
+	msi_for_each_desc(entry, dev, MSI_DESC_ALL)
 		num_msi += entry->nvec_used;
 	if (!num_msi)
 		return NULL;
@@ -411,7 +416,7 @@ static const struct attribute_group **ms
 	if (!msi_attrs)
 		return ERR_PTR(-ENOMEM);
 
-	for_each_msi_entry(entry, dev) {
+	msi_for_each_desc(entry, dev, MSI_DESC_ALL) {
 		for (i = 0; i < entry->nvec_used; i++) {
 			msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
 			if (!msi_dev_attr)
@@ -831,7 +836,7 @@ static bool msi_check_reservation_mode(s
 	 * Checking the first MSI descriptor is sufficient. MSIX supports
 	 * masking and MSI does so when the can_mask attribute is set.
 	 */
-	desc = first_msi_entry(dev);
+	desc = msi_first_desc(dev, MSI_DESC_ALL);
 	return desc->pci.msi_attrib.is_msix || desc->pci.msi_attrib.can_mask;
 }
 

