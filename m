Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4219A63264E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiKUOjG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiKUOiH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:38:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED46D9152D;
        Mon, 21 Nov 2022 06:38:05 -0800 (PST)
Message-ID: <20221121091327.271728371@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=pglOtQogKZeQllvETY7CSk7rnX36uaU40AecgPWhjoQ=;
        b=391M42bBt6zLla3u1QfX8pFEu7R357b3+nCAD3BmLZ5p1BBDOUjjpcKkNPe/banH7YtiUO
        q1QBbThvPTFWQ91FwQnNXhmGzZrZeuZMlhLvQ4o4vaUtnOk6lAYZmVeDwrQKy1ccpmD4fh
        qxa8waJZiHYml7mqDk/gDwdgW/UpOe6z2HFENoF2KWRm2TPwQw0PyZ6WDx0rbAn8zVfVji
        juZVSoO1N+ozdmfSEV5n+bx7AO6DoWVV7PKPHNbsUM4SPv1oM/Jnitm5lkc4/dCdI2/lMM
        qSGqNQHh/eDmMGzAXdQeWBSmTuYRDyRQlsW6/iCQx1GYcKfFXxeCpV7eFMklWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=pglOtQogKZeQllvETY7CSk7rnX36uaU40AecgPWhjoQ=;
        b=Ek5r2C0PHrpj7mIvSrtps1M2Vcl7Jw8jYkqwi3nsLAi9V2DZ1DeQflV54Jf48xz9X3aYvo
        zT7J24GKIx5wBoCg==
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
Subject: [patch V2 14/33] PCI/MSI: Remove unused pci_dev_has_special_msi_domain()
References: <20221121083657.157152924@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:38:03 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The check for special MSI domains like VMD which prevents the interrupt
remapping code to overwrite device::msi::domain is not longer required and
has been replaced by an x86 specific version which is aware of MSI parent
domains.

Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi/irqdomain.c |   21 ---------------------
 include/linux/msi.h         |    1 -
 2 files changed, 22 deletions(-)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -414,24 +414,3 @@ struct irq_domain *pci_msi_get_device_do
 					     DOMAIN_BUS_PCI_MSI);
 	return dom;
 }
-
-/**
- * pci_dev_has_special_msi_domain - Check whether the device is handled by
- *				    a non-standard PCI-MSI domain
- * @pdev:	The PCI device to check.
- *
- * Returns: True if the device irqdomain or the bus irqdomain is
- * non-standard PCI/MSI.
- */
-bool pci_dev_has_special_msi_domain(struct pci_dev *pdev)
-{
-	struct irq_domain *dom = dev_get_msi_domain(&pdev->dev);
-
-	if (!dom)
-		dom = dev_get_msi_domain(&pdev->bus->dev);
-
-	if (!dom)
-		return true;
-
-	return dom->bus_token != DOMAIN_BUS_PCI_MSI;
-}
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -606,7 +606,6 @@ struct irq_domain *pci_msi_create_irq_do
 					     struct irq_domain *parent);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
-bool pci_dev_has_special_msi_domain(struct pci_dev *pdev);
 #else /* CONFIG_PCI_MSI */
 static inline struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 {

