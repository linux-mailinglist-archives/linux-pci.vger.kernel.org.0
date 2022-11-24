Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965C463818F
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiKXX2o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiKXX2a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:28:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE43D33BF;
        Thu, 24 Nov 2022 15:26:49 -0800 (PST)
Message-ID: <20221124232325.798556374@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=O52hKM/eyXA5495ofBmhJYgeFgFMKz1bKsf4ukXppYY=;
        b=dopcgaOBeuvvrVBBjM0IZ0Z4kvik/8Xxm+j9VeWrZCxYVZSjAt7u7Wu3jFdqxEDwUs6Dpe
        ZRigkklTSw5Qbi46/l+53EZbtiawpGi1awSivW/h0qEf3eKvOkyLD+9JzcvGduXRbZsEGB
        xs+n1tn5OojF8ZuNu/AJLkCszv9eTIlOAJDJJ4Nn3dJCCo9O6gaS0qRvESCs5Cgfnt9YEK
        T5yZg75EvqwFYUGAgCoP5qqPeaZgIhea5xAsHXj5ZIWpkryKhPu39X2YnTr2E7kId+rjog
        RVerFXwJ+rt+WWZzl8R8LpOv8Uy2HKj//8IxlIJWp8zyBglmainSmPymXLBx3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=O52hKM/eyXA5495ofBmhJYgeFgFMKz1bKsf4ukXppYY=;
        b=gHSz9L5yPdDRuaLfE8LQ98i2E3jVTmq3Z5/qFrAeRScCdHPL18H1Wxeq8YXUhiN2rmB9LF
        +zoMdTSXWUgufbDA==
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
Subject: [patch V3 09/33] genirq/msi: Add range checking to msi_insert_desc()
References: <20221124230505.073418677@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:25:59 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Per device domains provide the real domain size to the core code. This
allows range checking on insertion of MSI descriptors and also paves the
way for dynamic index allocations which are required e.g. for IMS. This
avoids external mechanisms like bitmaps on the device side and just
utilizes the core internal MSI descriptor storxe for it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Adopt to the new info->hwsize handling and to the new xarray split
---
 kernel/irq/msi.c |   58 ++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 11 deletions(-)

--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -40,6 +40,7 @@ struct msi_ctrl {
 #define MSI_XA_DOMAIN_SIZE	(MSI_MAX_INDEX + 1)
 
 static void msi_domain_free_locked(struct device *dev, struct msi_ctrl *ctrl);
+static unsigned int msi_domain_get_hwsize(struct device *dev, unsigned int domid);
 static inline int msi_sysfs_create_group(struct device *dev);
 
 
@@ -80,16 +81,28 @@ static void msi_free_desc(struct msi_des
 	kfree(desc);
 }
 
-static int msi_insert_desc(struct msi_device_data *md, struct msi_desc *desc,
+static int msi_insert_desc(struct device *dev, struct msi_desc *desc,
 			   unsigned int domid, unsigned int index)
 {
+	struct msi_device_data *md = dev->msi.data;
 	struct xarray *xa = &md->__domains[domid].store;
+	unsigned int hwsize;
 	int ret;
 
+	hwsize = msi_domain_get_hwsize(dev, domid);
+	if (index >= hwsize) {
+		ret = -ERANGE;
+		goto fail;
+	}
+
 	desc->msi_index = index;
 	ret = xa_insert(xa, index, desc, GFP_KERNEL);
 	if (ret)
-		msi_free_desc(desc);
+		goto fail;
+	return 0;
+
+fail:
+	msi_free_desc(desc);
 	return ret;
 }
 
@@ -117,7 +130,7 @@ int msi_domain_insert_msi_desc(struct de
 	/* Copy type specific data to the new descriptor. */
 	desc->pci = init_desc->pci;
 
-	return msi_insert_desc(dev->msi.data, desc, domid, init_desc->msi_index);
+	return msi_insert_desc(dev, desc, domid, init_desc->msi_index);
 }
 
 static bool msi_desc_match(struct msi_desc *desc, enum msi_desc_filter filter)
@@ -136,11 +149,16 @@ static bool msi_desc_match(struct msi_de
 
 static bool msi_ctrl_valid(struct device *dev, struct msi_ctrl *ctrl)
 {
+	unsigned int hwsize;
+
 	if (WARN_ON_ONCE(ctrl->domid >= MSI_MAX_DEVICE_IRQDOMAINS ||
-			 !dev->msi.data->__domains[ctrl->domid].domain ||
-			 ctrl->first > ctrl->last ||
-			 ctrl->first > MSI_MAX_INDEX ||
-			 ctrl->last > MSI_MAX_INDEX))
+			 !dev->msi.data->__domains[ctrl->domid].domain))
+		return false;
+
+	hwsize = msi_domain_get_hwsize(dev, ctrl->domid);
+	if (WARN_ON_ONCE(ctrl->first > ctrl->last ||
+			 ctrl->first >= hwsize ||
+			 ctrl->last >= hwsize))
 		return false;
 	return true;
 }
@@ -208,7 +226,7 @@ static int msi_domain_add_simple_msi_des
 		desc = msi_alloc_desc(dev, 1, NULL);
 		if (!desc)
 			goto fail_mem;
-		ret = msi_insert_desc(dev->msi.data, desc, ctrl->domid, idx);
+		ret = msi_insert_desc(dev, desc, ctrl->domid, idx);
 		if (ret)
 			goto fail;
 	}
@@ -407,7 +425,10 @@ unsigned int msi_domain_get_virq(struct
 	if (!dev->msi.data)
 		return 0;
 
-	if (WARN_ON_ONCE(index > MSI_MAX_INDEX || domid >= MSI_MAX_DEVICE_IRQDOMAINS))
+	if (WARN_ON_ONCE(domid >= MSI_MAX_DEVICE_IRQDOMAINS))
+		return 0;
+
+	if (WARN_ON_ONCE(index >= msi_domain_get_hwsize(dev, domid)))
 		return 0;
 
 	/* This check is only valid for the PCI default MSI domain */
@@ -569,6 +590,20 @@ static struct irq_domain *msi_get_device
 	return domain;
 }
 
+static unsigned int msi_domain_get_hwsize(struct device *dev, unsigned int domid)
+{
+	struct msi_domain_info *info;
+	struct irq_domain *domain;
+
+	domain = msi_get_device_domain(dev, domid);
+	if (domain) {
+		info = domain->host_data;
+		return info->hwsize;
+	}
+	/* No domain, no size... */
+	return 0;
+}
+
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
 					  struct msi_msg *msg)
 {
@@ -1359,7 +1394,7 @@ int msi_domain_alloc_irqs_all_locked(str
 	struct msi_ctrl ctrl = {
 		.domid	= domid,
 		.first	= 0,
-		.last	= MSI_MAX_INDEX,
+		.last	= msi_domain_get_hwsize(dev, domid) - 1,
 		.nirqs	= nirqs,
 	};
 
@@ -1473,7 +1508,8 @@ void msi_domain_free_irqs_range(struct d
  */
 void msi_domain_free_irqs_all_locked(struct device *dev, unsigned int domid)
 {
-	msi_domain_free_irqs_range_locked(dev, domid, 0, MSI_MAX_INDEX);
+	msi_domain_free_irqs_range_locked(dev, domid, 0,
+					  msi_domain_get_hwsize(dev, domid) - 1);
 }
 
 /**

