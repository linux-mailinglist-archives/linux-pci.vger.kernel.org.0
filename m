Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7321625C39
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbiKKOBy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiKKOBN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:01:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC537814E1;
        Fri, 11 Nov 2022 05:56:58 -0800 (PST)
Message-ID: <20221111132706.726275059@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=YtbDzWpnrwwWvyENpRXFEkCRkWQeuna82et5GcBOaeQ=;
        b=I8oj1tOxDQINripBgyYjlotza6hp2yQpXUO5MhuSBEr788JcnzCCG6WEV1NmYZm3AeUehZ
        51WZuuKl4kZndKjJf6HLtVGA7JvvUld4zewT+BB3HzK5qB9M6BhGj/JdZAzmEd0IlrWnyI
        nkKxjXwci2K0XFvcZOzcqGzWaHS56Y1awosMNsbmQLRDyF5wCDBkwrikiLW7KbMMpv/LPl
        X6BZnMU0TibrEtJ0FsYy9bLVLfX+D8hiQvyPPVJHSGP+VDQWZIvzyWGzsnIuXNYssEWrzU
        XucdxL20GLIAR7Wx8SXV477Tf8s2SCY6fiq/zSfVsQ1xI5Yk6IRcqSfwkvCg5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=YtbDzWpnrwwWvyENpRXFEkCRkWQeuna82et5GcBOaeQ=;
        b=KlhnSQSinKHnMC5rAQCdApjO39ut/EiYB/N16OKSyQ/HLcMYcfZfTT/9GxgxVoZTBCxXLw
        qF7dM3ZQU4byrWDw==
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
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [patch 12/20] genirq/msi: Make descriptor freeing domain aware
References: <20221111131813.914374272@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:56:56 +0100 (CET)
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
 include/linux/msi.h |   22 ++++++++++++++++---
 kernel/irq/msi.c    |   60 ++++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 68 insertions(+), 14 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -277,7 +277,8 @@ static inline void msi_desc_set_iommu_co
 int msi_domain_insert_msi_desc(struct device *dev, unsigned int domid,
 			       struct msi_desc *init_desc);
 /**
- * msi_insert_msi_desc - Allocate and initialize a MSI descriptor in the default domain
+ * msi_insert_msi_desc - Allocate and initialize a MSI descriptor in the default irqdomain
+ *
  * @dev:	Pointer to the device for which the descriptor is allocated
  * @init_desc:	Pointer to an MSI descriptor to initialize the new descriptor
  *
@@ -288,10 +289,25 @@ static inline int msi_insert_msi_desc(st
 	return msi_domain_insert_msi_desc(dev, MSI_DEFAULT_DOMAIN, init_desc);
 }
 
-void msi_free_msi_descs_range(struct device *dev, unsigned int first_index, unsigned int last_index);
+void msi_domain_free_msi_descs_range(struct device *dev, unsigned int domid,
+				     unsigned int first, unsigned int last);
+
+/**
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
 
 /**
- * msi_free_msi_descs - Free MSI descriptors of a device
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
@@ -189,25 +201,32 @@ static bool msi_desc_match(struct msi_de
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
+static bool msi_ctrl_valid(struct device *dev, struct msi_ctrl *ctrl)
+{
+	if (WARN_ON_ONCE(ctrl->first > ctrl->last ||
+			 ctrl->first >= MSI_MAX_INDEX ||
+			 ctrl->last >= MSI_MAX_INDEX))
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
+
+	lockdep_assert_held(&dev->msi.data->mutex);
 
-	if (WARN_ON_ONCE(first_index >= MSI_MAX_INDEX || last_index >= MSI_MAX_INDEX))
+	if (!msi_ctrl_valid(dev, ctrl))
 		return;
 
-	lockdep_assert_held(&dev->msi.data->mutex);
+	base = msi_get_domain_base_index(dev, ctrl->domid);
+	if (base < 0)
+		return;
 
-	xa_for_each_range(xa, idx, desc, first_index, last_index) {
+	xa_for_each_range(xa, idx, desc, ctrl->first + base, ctrl->last + base) {
 		xa_erase(xa, idx);
 
 		/* Leak the descriptor when it is still referenced */
@@ -217,6 +236,25 @@ void msi_free_msi_descs_range(struct dev
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

