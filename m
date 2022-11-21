Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CCB632610
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiKUOhM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiKUOgo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:36:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43929C6BD2;
        Mon, 21 Nov 2022 06:36:36 -0800 (PST)
Message-ID: <20221121083326.228016703@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dOtgU6S/AgeNLAQ6bDFFp47i8FpSOtxAOpG1mn2gg6Q=;
        b=eANtBftpzxrc/QJI1MS1MPLfVlliOfzLA5VFooCP2oe5d999Sf94Yn1GwHLltwr/ONwfmP
        GTQHvhVgKzDcpSUUuEPiodjPaRi6PfJsDdXbECf3csavvZFIx8rkGJrqbZS2DXc8MTEyZO
        6FZNqW4qcyZpoyMu9DiGm9KyBVC7VSeMMnvQWeklNfTgRCdG/K4a9PXugtgAxknZwIk367
        0yKmOGdcAecjjzz5/m8VGQW6dCQx2pg0spOJbIfsPBrxWJti+GzhSPBxG1UKjksSBguMWB
        KtqKl1KqnISiroMZ2X93fEu5mUn+gmzb0H9Z7Aqm5UkktMO/VfH5qZlAvFIDtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dOtgU6S/AgeNLAQ6bDFFp47i8FpSOtxAOpG1mn2gg6Q=;
        b=IKIFpPt/bx0HdBkZi/rRcmDUUaF0E6lO43z9DYZ6frAcRg8uu1Q6A+Yex7RTONoeUdpJkL
        CIJSrveTDVevtwBg==
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
        Allen Hubbe <allenbh@gmail.com>
Subject: [patch V2 13/21] genirq/msi: Make descriptor freeing domain aware
References: <20221121083210.309161925@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:36:34 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change the descriptor free functions to take a domain id to prepare for the
upcoming multi MSI domain per device support.

To avoid changing and extending the interfaces over and over use an core
internal control struct and hand the pointer through the various functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h |   19 ++++++++++++++--
 kernel/irq/msi.c    |   59 ++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 67 insertions(+), 11 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -293,10 +293,25 @@ static inline int msi_insert_msi_desc(st
 	return msi_domain_insert_msi_desc(dev, MSI_DEFAULT_DOMAIN, init_desc);
 }
 
-void msi_free_msi_descs_range(struct device *dev, unsigned int first_index, unsigned int last_index);
+void msi_domain_free_msi_descs_range(struct device *dev, unsigned int domid,
+				     unsigned int first, unsigned int last);
 
 /**
- * msi_free_msi_descs - Free MSI descriptors of a device
+ * msi_free_msi_descs_range - Free a range of MSI descriptors of a device
+ *			      in the default irqdomain
+ *
+ * @dev:	Device for which to free the descriptors
+ * @first:	Index to start freeing from (inclusive)
+ * @last:	Last index to be freed (inclusive)
+ */
+static inline void msi_free_msi_descs_range(struct device *dev, unsigned int first,
+					    unsigned int last)
+{
+	msi_domain_free_msi_descs_range(dev, MSI_DEFAULT_DOMAIN, first, last);
+}
+
+/**
+ * msi_free_msi_descs - Free all MSI descriptors of a device in the default irqdomain
  * @dev:	Device to free the descriptors
  */
 static inline void msi_free_msi_descs(struct device *dev)
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -19,6 +19,18 @@
 
 #include "internals.h"
 
+/**
+ * struct msi_ctrl - MSI internal management control structure
+ * @domid:	ID of the domain on which management operations should be done
+ * @first:	First (hardware) slot index to operate on
+ * @last:	Last (hardware) slot index to operate on
+ */
+struct msi_ctrl {
+	unsigned int			domid;
+	unsigned int			first;
+	unsigned int			last;
+};
+
 static inline int msi_sysfs_create_group(struct device *dev);
 
 /* Invalid XA index which is outside of any searchable range */
@@ -186,22 +198,32 @@ static bool msi_desc_match(struct msi_de
 	return false;
 }
 
-/**
- * msi_free_msi_descs_range - Free MSI descriptors of a device
- * @dev:		Device to free the descriptors
- * @first_index:	Index to start freeing from
- * @last_index:		Last index to be freed
- */
-void msi_free_msi_descs_range(struct device *dev, unsigned int first_index,
-			      unsigned int last_index)
+static bool msi_ctrl_range_valid(struct device *dev, struct msi_ctrl *ctrl)
+{
+	if (WARN_ON_ONCE(ctrl->first > ctrl->last ||
+			 ctrl->first > MSI_MAX_INDEX ||
+			 ctrl->last > MSI_MAX_INDEX))
+		return false;
+	return true;
+}
+
+static void msi_domain_free_descs(struct device *dev, struct msi_ctrl *ctrl)
 {
 	struct xarray *xa = &dev->msi.data->__store;
 	struct msi_desc *desc;
 	unsigned long idx;
+	int base;
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
-	xa_for_each_range(xa, idx, desc, first_index, last_index) {
+	if (!msi_ctrl_range_valid(dev, ctrl))
+		return;
+
+	base = msi_get_domain_base_index(dev, ctrl->domid);
+	if (base < 0)
+		return;
+
+	xa_for_each_range(xa, idx, desc, ctrl->first + base, ctrl->last + base) {
 		xa_erase(xa, idx);
 
 		/* Leak the descriptor when it is still referenced */
@@ -211,6 +233,25 @@ void msi_free_msi_descs_range(struct dev
 	}
 }
 
+/**
+ * msi_domain_free_msi_descs_range - Free a range of MSI descriptors of a device in an irqdomain
+ * @dev:	Device for which to free the descriptors
+ * @domid:	Id of the domain to operate on
+ * @first:	Index to start freeing from (inclusive)
+ * @last:	Last index to be freed (inclusive)
+ */
+void msi_domain_free_msi_descs_range(struct device *dev, unsigned int domid,
+				     unsigned int first, unsigned int last)
+{
+	struct msi_ctrl ctrl = {
+		.domid	= domid,
+		.first	= first,
+		.last	= last,
+	};
+
+	msi_domain_free_descs(dev, &ctrl);
+}
+
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	*msg = entry->msg;

