Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFE7632621
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiKUOhX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiKUOgn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:36:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26229C72E2;
        Mon, 21 Nov 2022 06:36:35 -0800 (PST)
Message-ID: <20221121083326.172418628@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=A5WJRb2/4teczUo5tLJ1BYRZTZjOFdwhWlgYTs4xkWo=;
        b=GqcsxI4UBE4uCcl41WHYFRRjiTlVU3Rty+qxgKvdKG2bvTdRbVKRURNgNxXS3TGRw6OyIV
        wUYQq5i4ItodyAogUXTBzcHuHa1MjHoY4Vvy3j7k/nQ1nXWD+UPs17Z5NYQ4vc8R3V+brM
        XCETZUE4KCPo8z7gsWMz7KQUMW9tyGTP8vDT69Ns+Qb/ViLa5SYzKf6HO1vcn7RXbuuW/V
        1J0ybhVeHoSA5VwIAynQUeCYYPb8kPWET5qWThLRgWFbToHJBL/bv9dEEIGv+lZWANfQgi
        l1MIEgMHavoXdPPJ9C2QJuQu6ljOv2YdFDHz44AWHMgG9yIRjwyUIqpHmxfJMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=A5WJRb2/4teczUo5tLJ1BYRZTZjOFdwhWlgYTs4xkWo=;
        b=bP6WwDkZXkBORZ2Vav6whh5bDM9I958EHSnWwhNTHSuWRimb4swaIHfet++FUEnDbiovOk
        ldRkeQ3UG39FD4DA==
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
Subject: [patch V2 12/21] genirq/msi: Make descriptor allocation device domain aware
References: <20221121083210.309161925@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:36:33 +0100 (CET)
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
 include/linux/msi.h |   16 +++++++++++++++-
 kernel/irq/msi.c    |   34 +++++++++++++++++++++++++---------
 2 files changed, 40 insertions(+), 10 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -278,7 +278,21 @@ static inline void msi_desc_set_iommu_co
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
@@ -63,7 +63,7 @@ static int msi_get_domain_base_index(str
  * Return: pointer to allocated &msi_desc on success or %NULL on failure
  */
 static struct msi_desc *msi_alloc_desc(struct device *dev, int nvec,
-					const struct irq_affinity_desc *affinity)
+				       const struct irq_affinity_desc *affinity)
 {
 	struct msi_desc *desc = kzalloc(sizeof(*desc), GFP_KERNEL);
 
@@ -88,27 +88,42 @@ static void msi_free_desc(struct msi_des
 	kfree(desc);
 }
 
-static int msi_insert_desc(struct msi_device_data *md, struct msi_desc *desc, unsigned int index)
+static int msi_insert_desc(struct device *dev, struct msi_desc *desc,
+			   unsigned int domid, unsigned int index)
 {
-	int ret;
+	struct msi_device_data *md = dev->msi.data;
+	int baseidx, ret;
+
+	baseidx = msi_get_domain_base_index(dev, domid);
+	if (baseidx < 0) {
+		ret = baseidx;
+		goto fail;
+	}
 
 	desc->msi_index = index;
+	index += baseidx;
 	ret = xa_insert(&md->__store, index, desc, GFP_KERNEL);
 	if (ret)
-		msi_free_desc(desc);
+		goto fail;
+	return 0;
+
+fail:
+	msi_free_desc(desc);
 	return ret;
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
 
@@ -120,7 +135,8 @@ int msi_insert_msi_desc(struct device *d
 
 	/* Copy type specific data to the new descriptor. */
 	desc->pci = init_desc->pci;
-	return msi_insert_desc(dev->msi.data, desc, init_desc->msi_index);
+
+	return msi_insert_desc(dev, desc, domid, init_desc->msi_index);
 }
 
 /**
@@ -143,7 +159,7 @@ static int msi_add_simple_msi_descs(stru
 		desc = msi_alloc_desc(dev, 1, NULL);
 		if (!desc)
 			goto fail_mem;
-		ret = msi_insert_desc(dev->msi.data, desc, idx);
+		ret = msi_insert_desc(dev, desc, MSI_DEFAULT_DOMAIN, idx);
 		if (ret)
 			goto fail;
 	}

