Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51527625C79
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiKKOHx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbiKKOHM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:07:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505496B385;
        Fri, 11 Nov 2022 06:00:01 -0800 (PST)
Message-ID: <20221111135206.064632154@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Jo+Ej5dmACRlWZx5RMiCIg5tBFJl/q1kQRy9S2DmWGI=;
        b=Ny7+vAREPPCwIb4SEAunOoc5gfpUXWhhVjVEO7akx4k3pNWK7sZ1x3o/geLljQiaWKLdiW
        2+okWO9nGxMx9cfHoXGBYSjQAHZXcrEejnoEHKy1jUo4MU57VZkOacK7GCl/IEGjU3xSjL
        8mPu/0miUdDZEBHnAgbvcqgjSdiig6UrPUBqk8d0+dcCS7cr3IOLhWGm7SsljfydJyArQD
        x5TSy4c5ua9e8Pwd9w5caKwMhJw4acUO+95MHMkSshR7n5hsnsVp3MJiqwTqQU71PRU87b
        gE1oaIMabjg7MLIPzgZmX/B0klZqefbQQKNjWzRdbvhqMsJL44/KhaeKOMxUPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Jo+Ej5dmACRlWZx5RMiCIg5tBFJl/q1kQRy9S2DmWGI=;
        b=xpFmkKIPMMhrAQdxPoIQkUj5EeO3nmajnXg0EnjnVOhP5P7p4IUZO5gKWLHXM+zcl4P8cb
        bOaoIZE9UC5FDmCg==
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
Subject: [patch 14/33] PCI/MSI: Remove unused pci_dev_has_special_msi_domain()
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:33 +0100 (CET)
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
---
 drivers/pci/msi/irqdomain.c |   21 ---------------------
 include/linux/msi.h         |    2 --
 2 files changed, 23 deletions(-)

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
@@ -599,8 +599,6 @@ struct irq_domain *pci_msi_create_irq_do
 					     struct irq_domain *parent);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
-bool pci_dev_has_special_msi_domain(struct pci_dev *pdev);
-
 #endif /* CONFIG_GENERIC_MSI_IRQ */
 
 #endif /* LINUX_MSI_H */

