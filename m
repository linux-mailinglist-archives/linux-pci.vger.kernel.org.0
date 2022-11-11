Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39C9625C62
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbiKKOFz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbiKKOFl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:05:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D72877E4A;
        Fri, 11 Nov 2022 05:59:18 -0800 (PST)
Message-ID: <20221111135205.775535289@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=EEWX0fbjpip4mXWc4fSurpBy9Wsz+XqDUPDSbTVukvY=;
        b=VugTZQCcKm2vyhQ8cIixt7Lppk9UkraAxMIl07e4x+0S3mrioeGKqoxRRpo5MU0J44GBn8
        bVkn6sZ9Tq4gCMxxNqqAHmFikMJ33iCaQ4Clqy9Q+gXf92CzwA1yc+R/qF52YrAOTsFFBA
        3PyidW83A9h0Q9TyNAf5Z2A3xn/fJd7rkzsduR37j0NrMoCUagaHeu8diaXqZBm339Lt7+
        Eyi/J/naPloOoJdiVLKVEgwwAR/EhENSRoqXIqR38SO94BrOXkVmAQ3BbHjalcxIcdl7Io
        ZTssvnw85QgcFbq7iwEz5fjiCrkWYuuYoOrDNkf+0vobz1AALtX9yHCyVi5iUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=EEWX0fbjpip4mXWc4fSurpBy9Wsz+XqDUPDSbTVukvY=;
        b=s8GluLF0Wl8kSe3/ZS0ctqdVE5ewnU85knLEVp2iCmxGJHcglo9BsWpZzgWzSgNx3Ca51Z
        IlOVO5jXY5bdnfDA==
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
Subject: [patch 09/33] genirq/msi: Add range checking to msi_insert_desc()
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:25 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Per device domains provide the domain size to the core code. This allows
range checking on insertion of MSI descriptors and also paves the way for
dynamic index allocations which are required e.g. for IMS. This avoids
external mechanisms like bitmaps on the device side and just utilizes
the core internal MSI descriptor store for it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/msi.c |   38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -73,6 +73,7 @@ static int msi_get_domain_base_index(str
 	return domid * MSI_XA_DOMAIN_SIZE;
 }
 
+static unsigned int msi_domain_get_hwsize(struct device *dev, unsigned int domid);
 
 /**
  * msi_alloc_desc - Allocate an initialized msi_desc
@@ -115,6 +116,7 @@ static int msi_insert_desc(struct device
 			   unsigned int domid, unsigned int index)
 {
 	struct msi_device_data *md = dev->msi.data;
+	unsigned int hwsize;
 	int baseidx, ret;
 
 	baseidx = msi_get_domain_base_index(dev, domid);
@@ -123,6 +125,12 @@ static int msi_insert_desc(struct device
 		goto fail;
 	}
 
+	hwsize = msi_domain_get_hwsize(dev, domid);
+	if (index >= hwsize) {
+		ret = -ERANGE;
+		goto fail;
+	}
+
 	desc->msi_index = index;
 	index += baseidx;
 	ret = xa_insert(&md->__store, index, desc, GFP_KERNEL);
@@ -181,9 +189,11 @@ static bool msi_desc_match(struct msi_de
 
 static bool msi_ctrl_valid(struct device *dev, struct msi_ctrl *ctrl)
 {
+	unsigned int hwsize = msi_domain_get_hwsize(dev, ctrl->domid);
+
 	if (WARN_ON_ONCE(ctrl->first > ctrl->last ||
-			 ctrl->first >= MSI_MAX_INDEX ||
-			 ctrl->last >= MSI_MAX_INDEX))
+			 ctrl->first >= hwsize ||
+			 ctrl->last >= hwsize))
 		return false;
 	return true;
 }
@@ -613,6 +623,25 @@ static struct irq_domain *msi_get_device
 	return domain;
 }
 
+static unsigned int msi_domain_get_hwsize(struct device *dev, unsigned int domid)
+{
+	struct msi_domain_info *info;
+	struct irq_domain *domain;
+
+	/*
+	 * Retrieve the MSI domain for range checking. If there is no
+	 * domain or the domain is not a per device domain, then assume
+	 * full MSI range and pray that the calling subsystem knows what it
+	 * is doing.
+	 */
+	domain = msi_get_device_domain(dev, domid);
+	if (domain && irq_domain_is_msi_device(domain)) {
+		info = domain->host_data;
+		return info->hwsize;
+	}
+	return MSI_MAX_INDEX;
+}
+
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
 					  struct msi_msg *msg)
 {
@@ -1380,7 +1409,7 @@ int msi_domain_alloc_irqs_all_locked(str
 	struct msi_ctrl ctrl = {
 		.domid	= domid,
 		.first	= 0,
-		.last	= MSI_MAX_INDEX,
+		.last	= msi_domain_get_hwsize(dev, domid) - 1,
 		.nirqs	= nirqs,
 	};
 
@@ -1496,7 +1525,8 @@ void msi_domain_free_irqs_range(struct d
  */
 void msi_domain_free_irqs_all_locked(struct device *dev, unsigned int domid)
 {
-	msi_domain_free_irqs_range_locked(dev, domid, 0, MSI_MAX_INDEX);
+	msi_domain_free_irqs_range_locked(dev, domid, 0,
+					  msi_domain_get_hwsize(dev, domid) - 1);
 }
 
 /**

