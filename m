Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DDB63816B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiKXXZ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiKXXYx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:24:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E193A65A1;
        Thu, 24 Nov 2022 15:24:31 -0800 (PST)
Message-ID: <20221124230314.163043028@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1/0X92agTvjRjQzuL4lsTq7huP6SoYkhEuMMwl1ZamE=;
        b=hwD5d3aqQLl2DGymQxv0DOqxN2X0T2oe+RcE6wc2WBaEjdPcVtK203DQyFSfCaPwzTPknV
        qq/xtxoYKPCexWPCPRjqetiesdM8jxRr1/jq+F3VMaT3EEys9bTY8x3OpXEmFggG889XJ2
        qV9rpXdgyWUI9neFVAOL5rx+xXcTgAi7d+8MLt8/dfCHqOR0UOhXNd/8SYAHxpDWioB931
        2iPY8empjkEDpJ3MBqLrfRGN6H4sHj/x8Lao0FE9dHylp7Y4yq6F0RJz9Jt8QuDGZ+Y8Gq
        DhPS/CwCDJsMc6sO0AgxK1Q08dlN+mbZmuATyZZ9WzEkAejnQXHH/OyoViXTEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1/0X92agTvjRjQzuL4lsTq7huP6SoYkhEuMMwl1ZamE=;
        b=+qxLZDiyXYQT2USH+0qUG2LwZo4EgBYRce9frjtPYQCJ0p7/zkLObQUhsheUPbDNlPdd5P
        aM4o74JQYSybbZBA==
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
Subject: [patch V3 13/22] genirq/msi: Make descriptor allocation device domain aware
References: <20221124225331.464480443@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:24:29 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change the descriptor allocation and insertion functions to take a domain
id to prepare for the upcoming multi MSI domain per device support.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Adopt to the domain/xarray storage change
---
 include/linux/msi.h |   16 +++++++++++++++-
 kernel/irq/msi.c    |   20 ++++++++++++--------
 2 files changed, 27 insertions(+), 9 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -286,7 +286,21 @@ static inline void msi_desc_set_iommu_co
 }
 #endif
 
-int msi_insert_msi_desc(struct device *dev, struct msi_desc *init_desc);
+int msi_domain_insert_msi_desc(struct device *dev, unsigned int domid,
+			       struct msi_desc *init_desc);
+/**
+ * msi_insert_msi_desc - Allocate and initialize a MSI descriptor in the
+ *			 default irqdomain and insert it at @init_desc->msi_index
+ * @dev:	Pointer to the device for which the descriptor is allocated
+ * @init_desc:	Pointer to an MSI descriptor to initialize the new descriptor
+ *
+ * Return: 0 on success or an appropriate failure code.
+ */
+static inline int msi_insert_msi_desc(struct device *dev, struct msi_desc *init_desc)
+{
+	return msi_domain_insert_msi_desc(dev, MSI_DEFAULT_DOMAIN, init_desc);
+}
+
 void msi_free_msi_descs_range(struct device *dev, unsigned int first_index, unsigned int last_index);
 
 /**
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -39,7 +39,7 @@ static inline int msi_sysfs_create_group
  * Return: pointer to allocated &msi_desc on success or %NULL on failure
  */
 static struct msi_desc *msi_alloc_desc(struct device *dev, int nvec,
-					const struct irq_affinity_desc *affinity)
+				       const struct irq_affinity_desc *affinity)
 {
 	struct msi_desc *desc = kzalloc(sizeof(*desc), GFP_KERNEL);
 
@@ -64,9 +64,10 @@ static void msi_free_desc(struct msi_des
 	kfree(desc);
 }
 
-static int msi_insert_desc(struct msi_device_data *md, struct msi_desc *desc, unsigned int index)
+static int msi_insert_desc(struct msi_device_data *md, struct msi_desc *desc,
+			   unsigned int domid, unsigned int index)
 {
-	struct xarray *xa = &md->__domains[MSI_DEFAULT_DOMAIN].store;
+	struct xarray *xa = &md->__domains[domid].store;
 	int ret;
 
 	desc->msi_index = index;
@@ -77,15 +78,17 @@ static int msi_insert_desc(struct msi_de
 }
 
 /**
- * msi_insert_msi_desc - Allocate and initialize a MSI descriptor and
- *			 insert it at @init_desc->msi_index
+ * msi_domain_insert_msi_desc - Allocate and initialize a MSI descriptor and
+ *				insert it at @init_desc->msi_index
  *
  * @dev:	Pointer to the device for which the descriptor is allocated
+ * @domid:	The id of the interrupt domain to which the desriptor is added
  * @init_desc:	Pointer to an MSI descriptor to initialize the new descriptor
  *
  * Return: 0 on success or an appropriate failure code.
  */
-int msi_insert_msi_desc(struct device *dev, struct msi_desc *init_desc)
+int msi_domain_insert_msi_desc(struct device *dev, unsigned int domid,
+			       struct msi_desc *init_desc)
 {
 	struct msi_desc *desc;
 
@@ -97,7 +100,8 @@ int msi_insert_msi_desc(struct device *d
 
 	/* Copy type specific data to the new descriptor. */
 	desc->pci = init_desc->pci;
-	return msi_insert_desc(dev->msi.data, desc, init_desc->msi_index);
+
+	return msi_insert_desc(dev->msi.data, desc, domid, init_desc->msi_index);
 }
 
 /**
@@ -120,7 +124,7 @@ static int msi_add_simple_msi_descs(stru
 		desc = msi_alloc_desc(dev, 1, NULL);
 		if (!desc)
 			goto fail_mem;
-		ret = msi_insert_desc(dev->msi.data, desc, idx);
+		ret = msi_insert_desc(dev->msi.data, desc, MSI_DEFAULT_DOMAIN, idx);
 		if (ret)
 			goto fail;
 	}

