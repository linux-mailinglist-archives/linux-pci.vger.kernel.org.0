Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC1C63816D
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiKXXZb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiKXXYz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:24:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6415287555;
        Thu, 24 Nov 2022 15:24:34 -0800 (PST)
Message-ID: <20221124230314.220788011@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=01JZ04pCVGnanIjdp9eHgMGQKSfrcBXNPjV3qqO7Obo=;
        b=z3pU7RGoRRPgJeppy54pT/zSr0ya+l0FCtfGncBlf9ORM6MT/mfaqyJccbZ36bsJN1R3u4
        6bagjSANXEOIoZejSfoy59BkDGjaMqEGXYZmfANOsHOVbC6vPGyC8X9eVj8MG0UyEf8DRd
        JOEvQ6mwoP2r5W3H8Ms7C2OuFfbRl9W3FTWgoPXmhrqePEyiPQspNZqB6NVaD0nJPZ1NAk
        hJXMUWS94xkUVxJNcUkfLrfOwMfK6Hpo+Z0+U7H6moQfZZNt05aqTzGgeFh0sYa8N+vunn
        NNR0JMkUenc2zaVWlMJZiXkZRggc+AtlkQgZWsf/gn5yrKne+qEbl5EOqS100g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=01JZ04pCVGnanIjdp9eHgMGQKSfrcBXNPjV3qqO7Obo=;
        b=MjDMTJsrMbgqwTfGAYjZodRyQW/x3zG+c4Cl4Se2ECFN6ImiNiJ6IcN9btmLMxg4l44O6L
        rAJuGkLn9aRSznAw==
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
Subject: [patch V3 14/22] genirq/msi: Make descriptor freeing domain aware
References: <20221124225331.464480443@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:24:30 +0100 (CET)
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
V3: Adopt to the domain/xarray storage change
---
 include/linux/msi.h |   19 +++++++++++++++--
 kernel/irq/msi.c    |   58 +++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 65 insertions(+), 12 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -301,10 +301,25 @@ static inline int msi_insert_msi_desc(st
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
 /* Invalid Xarray index which is outside of any searchable range */
 #define MSI_XA_MAX_INDEX	(ULONG_MAX - 1)
 /* The maximum domain size */
@@ -151,22 +163,29 @@ static bool msi_desc_match(struct msi_de
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
+	if (WARN_ON_ONCE(ctrl->domid >= MSI_MAX_DEVICE_IRQDOMAINS ||
+			 ctrl->first > ctrl->last ||
+			 ctrl->first > MSI_MAX_INDEX ||
+			 ctrl->last > MSI_MAX_INDEX))
+		return false;
+	return true;
+}
+
+static void msi_domain_free_descs(struct device *dev, struct msi_ctrl *ctrl)
 {
-	struct xarray *xa = &dev->msi.data->__domains[MSI_DEFAULT_DOMAIN].store;
 	struct msi_desc *desc;
+	struct xarray *xa;
 	unsigned long idx;
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
-	xa_for_each_range(xa, idx, desc, first_index, last_index) {
+	if (!msi_ctrl_valid(dev, ctrl))
+		return;
+
+	xa = &dev->msi.data->__domains[ctrl->domid].store;
+	xa_for_each_range(xa, idx, desc, ctrl->first, ctrl->last) {
 		xa_erase(xa, idx);
 
 		/* Leak the descriptor when it is still referenced */
@@ -176,6 +195,25 @@ void msi_free_msi_descs_range(struct dev
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

