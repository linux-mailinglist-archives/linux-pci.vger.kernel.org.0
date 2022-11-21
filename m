Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE58C632620
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiKUOhW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiKUOgm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:36:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61EBC721C;
        Mon, 21 Nov 2022 06:36:33 -0800 (PST)
Message-ID: <20221121083326.115115268@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ZnCGeE1zb0VOfmSO6TChoSBAluSJ9ZEH47yEg4s6I+c=;
        b=oYspf330JJzfcvl+HoWtCvZqLfSJ0tQbLWEl6imwjD+Kj9As6U7lsGbGnYi5wxHu8n6Dyh
        /atf44J3Us6nQMPCijNLdTwB9/2+cZUkunHX+Bju911ldLYdO/S39/9UiurA+JCKiXjtkA
        B3rwwijzwg02IpfkuoD4FEV+W20KMtvs8UWOFOml2kxEP/W5s4HZtSGi+xb4q1x+vcnZca
        1Ax2D5oqP3HcyE/uWGibZ7SzCq6As0m/YQoJ7InOUV8T/FwtWStbt4NbPO17Gg9qInIlJh
        Z+20YRF5sNSWgoxztWyNxKfwwsQWa0LhOW4sagMpRuAzNduAofzZwJDQgQTk3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ZnCGeE1zb0VOfmSO6TChoSBAluSJ9ZEH47yEg4s6I+c=;
        b=qxpgalKrCpsi2LFTsSGZlfuUyMGezkHsnxxgRb8k9Jt+igSkegorfK5mijnvrnar1p5Dsx
        sspv3lkYuWrWIDDg==
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
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [patch V2 11/21] genirq/msi: Rename msi_add_msi_desc() to
 msi_insert_msi_desc()
References: <20221121083210.309161925@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:36:32 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reflects the functionality better. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/pci/msi/msi.c            |    4 ++--
 drivers/soc/ti/ti_sci_inta_msi.c |    4 ++--
 include/linux/msi.h              |    2 +-
 kernel/irq/msi.c                 |    6 ++++--
 4 files changed, 9 insertions(+), 7 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -308,7 +308,7 @@ static int msi_setup_msi_desc(struct pci
 	if (desc.pci.msi_attrib.can_mask)
 		pci_read_config_dword(dev, desc.pci.mask_pos, &desc.pci.msi_mask);
 
-	return msi_add_msi_desc(&dev->dev, &desc);
+	return msi_insert_msi_desc(&dev->dev, &desc);
 }
 
 static int msi_verify_entries(struct pci_dev *dev)
@@ -591,7 +591,7 @@ static int msix_setup_msi_descs(struct p
 			desc.pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 		}
 
-		ret = msi_add_msi_desc(&dev->dev, &desc);
+		ret = msi_insert_msi_desc(&dev->dev, &desc);
 		if (ret)
 			break;
 	}
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -73,13 +73,13 @@ static int ti_sci_inta_msi_alloc_descs(s
 	for (set = 0; set < res->sets; set++) {
 		for (i = 0; i < res->desc[set].num; i++, count++) {
 			msi_desc.msi_index = res->desc[set].start + i;
-			if (msi_add_msi_desc(dev, &msi_desc))
+			if (msi_insert_msi_desc(dev, &msi_desc))
 				goto fail;
 		}
 
 		for (i = 0; i < res->desc[set].num_sec; i++, count++) {
 			msi_desc.msi_index = res->desc[set].start_sec + i;
-			if (msi_add_msi_desc(dev, &msi_desc))
+			if (msi_insert_msi_desc(dev, &msi_desc))
 				goto fail;
 		}
 	}
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -278,7 +278,7 @@ static inline void msi_desc_set_iommu_co
 }
 #endif
 
-int msi_add_msi_desc(struct device *dev, struct msi_desc *init_desc);
+int msi_insert_msi_desc(struct device *dev, struct msi_desc *init_desc);
 void msi_free_msi_descs_range(struct device *dev, unsigned int first_index, unsigned int last_index);
 
 /**
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -100,13 +100,15 @@ static int msi_insert_desc(struct msi_de
 }
 
 /**
- * msi_add_msi_desc - Allocate and initialize a MSI descriptor
+ * msi_insert_msi_desc - Allocate and initialize a MSI descriptor and
+ *			 insert it at @init_desc->msi_index
+ *
  * @dev:	Pointer to the device for which the descriptor is allocated
  * @init_desc:	Pointer to an MSI descriptor to initialize the new descriptor
  *
  * Return: 0 on success or an appropriate failure code.
  */
-int msi_add_msi_desc(struct device *dev, struct msi_desc *init_desc)
+int msi_insert_msi_desc(struct device *dev, struct msi_desc *init_desc)
 {
 	struct msi_desc *desc;
 

