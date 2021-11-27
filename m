Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9349545FBF0
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 03:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352438AbhK0CUA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 21:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhK0CR6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 21:17:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F98EC08EB50;
        Fri, 26 Nov 2021 17:31:28 -0800 (PST)
Message-ID: <20211126232735.966439698@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gSomj3s8jo8kjsKBojGfH3Sh/kAv2I0EDD9nvx4QgIA=;
        b=qnj/Q9+Oq1YwHcL7c6j/RQVIe3/flpmQoytv3n9BDU+zIFjiHHb0N7gbBRHoHVlzO+/WwY
        x2geFfO713MgU9pVDLjLTor4JMJ5ufTdfTYiK3mHFEYRpYk7KiaaqtCJEEXTnyM2QFwdI8
        OCS3i4hgn+aFRj4EOek4FHiS2/0Xh8BWUGHGnFZuZwy7bodlCFS70rNixqCHQO0FThxmZh
        BlZv3cSCeE77n6epArD/lXMK/QOORpNuh/XtChV/UWiv8PbkuyGzbmv0jdK5aeQQdGHmYL
        CwrqvMU6UtX77YhWach/AQKslYoRkOV5UIyEJsQI/2CSxUOGo44G0VjmqeV8zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gSomj3s8jo8kjsKBojGfH3Sh/kAv2I0EDD9nvx4QgIA=;
        b=XLNIWs8bhq/CLR9L7n/qLI+lLjEm1BsN42kbOoz0vUZhYGCGgUi9dsc5VRgJY2ZIgswyOD
        ae4rvQmwRVJl2eCw==
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
Subject: [patch 28/32] genirq/msi: Convert to new functions
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:24:12 +0100 (CET)
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
@@ -354,6 +354,7 @@ struct msi_desc *msi_next_desc(struct de
 int __msi_get_virq(struct device *dev, unsigned int index)
 {
 	struct msi_desc *desc;
+	int ret = -ENOENT;
 	bool pcimsi;
 
 	if (!dev->msi.data)
@@ -361,11 +362,12 @@ int __msi_get_virq(struct device *dev, u
 
 	pcimsi = msi_device_has_property(dev, MSI_PROP_PCI_MSI);
 
-	for_each_msi_entry(desc, dev) {
+	msi_lock_descs(dev);
+	msi_for_each_desc_from(desc, dev, MSI_DESC_ASSOCIATED, index) {
 		/* PCI-MSI has only one descriptor for multiple interrupts. */
 		if (pcimsi) {
-			if (desc->irq && index < desc->nvec_used)
-				return desc->irq + index;
+			if (index < desc->nvec_used)
+				ret = desc->irq + index;
 			break;
 		}
 
@@ -373,10 +375,13 @@ int __msi_get_virq(struct device *dev, u
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
-	return -ENOENT;
+	msi_unlock_descs(dev);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(__msi_get_virq);
 
@@ -407,7 +412,7 @@ static const struct attribute_group **ms
 	int i;
 
 	/* Determine how many msi entries we have */
-	for_each_msi_entry(entry, dev)
+	msi_for_each_desc(entry, dev, MSI_DESC_ALL)
 		num_msi += entry->nvec_used;
 	if (!num_msi)
 		return NULL;
@@ -417,7 +422,7 @@ static const struct attribute_group **ms
 	if (!msi_attrs)
 		return ERR_PTR(-ENOMEM);
 
-	for_each_msi_entry(entry, dev) {
+	msi_for_each_desc(entry, dev, MSI_DESC_ALL) {
 		for (i = 0; i < entry->nvec_used; i++) {
 			msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
 			if (!msi_dev_attr)
@@ -838,7 +843,7 @@ static bool msi_check_reservation_mode(s
 	 * Checking the first MSI descriptor is sufficient. MSIX supports
 	 * masking and MSI does so when the can_mask attribute is set.
 	 */
-	desc = first_msi_entry(dev);
+	desc = msi_first_desc(dev);
 	return desc->pci.msi_attrib.is_msix || desc->pci.msi_attrib.can_mask;
 }
 

