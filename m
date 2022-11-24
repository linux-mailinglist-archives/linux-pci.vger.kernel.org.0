Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352B3638169
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiKXXZQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiKXXYo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:24:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A042FA3414;
        Thu, 24 Nov 2022 15:24:29 -0800 (PST)
Message-ID: <20221124230314.103554618@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=v72U6H3iTWuz/IqCNF13LsAnXWC/DLWNYziPDjdb8uU=;
        b=hsX7yIIDcDscPyvv7tgwW07bo5cB7aYJQpayo3BFUgphQ/JJsRPnpCz/6xUa/dyWlW4gkb
        JoZc8MxWGjZFxhU1TP0ax8S1Txwu4eCn7aUqzI4/5im+oHtQvoyIIDvmB5xItWf/ieTsFk
        rHT34JohtOtrXQAunvJhU9dI94gXQTPzZ66qfdG01l18Ls2AFiljq2bu/dvcrb9L/gojHU
        WxQ0NOjSJxnwzdQLaMID9CtCEvwZr8GO5RS5pGC4BA/jPxcmCcDrrebI+PUtRq4A/azDDJ
        QMHfd/X6ZHORAavwmUDTWGiPKqrQrEloRauD1TjQIMSUB7MKfSmKdoZ6s6qjZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=v72U6H3iTWuz/IqCNF13LsAnXWC/DLWNYziPDjdb8uU=;
        b=H5tOgcaKakx7rzNPapnFxi06ZrVXE0sYORCchR+EtwVvfa/rP7sfi8aPd1QZQAXdmyQQ6B
        byEeh8HkVzelJyAA==
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
Subject: [patch V3 12/22] genirq/msi: Rename msi_add_msi_desc() to
 msi_insert_msi_desc()
References: <20221124225331.464480443@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:24:27 +0100 (CET)
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
@@ -286,7 +286,7 @@ static inline void msi_desc_set_iommu_co
 }
 #endif
 
-int msi_add_msi_desc(struct device *dev, struct msi_desc *init_desc);
+int msi_insert_msi_desc(struct device *dev, struct msi_desc *init_desc);
 void msi_free_msi_descs_range(struct device *dev, unsigned int first_index, unsigned int last_index);
 
 /**
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -77,13 +77,15 @@ static int msi_insert_desc(struct msi_de
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
 

