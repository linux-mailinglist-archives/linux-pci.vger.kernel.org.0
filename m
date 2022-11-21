Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E5C63266C
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiKUOkO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiKUOin (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:38:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3640C900F;
        Mon, 21 Nov 2022 06:38:17 -0800 (PST)
Message-ID: <20221121091327.817612499@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=jPRMH9ANd3Y1Xl+LkBRLSL32jXRgRoZHrUPJTpoWc4w=;
        b=QAyxdW6h4sEX+AbOWBAvdjH57yGH+aQr6mTBG5rtDFmVg5qPzm94rcyOtu6n1/2NOEOjHG
        8mtB7wgZG+/SeMhngvjdMShENcu37cSHRYCbM5G/R0rsFpBujjDVARJKBZaZHXsTXVj8DR
        +w5sevvdAhMTf30QKj9KvoP3kPLfZydnyJfK4Wd9JKoeZv5LSyyuQ4931QcJqefR+tupdW
        L/gZefLOfpBgSGRyWxtN+0Krgpukyd3rsYW1Ziqu1YEMKVrb/8WPXpWM+tX2XKXB/Jf+nY
        vH1HM608y3ZHSsXhWL9pNMTqaDOxxxcaZ/+gZvQioSDHffPb2ymCbzWw5Bbqhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=jPRMH9ANd3Y1Xl+LkBRLSL32jXRgRoZHrUPJTpoWc4w=;
        b=+Aq08sUBX75c5DnBj1c1zdU+rBdYklHxGULnWz5ywt1uWk4RCag051MzVzbxyhWOitNgaJ
        64OLROZGxAURy1Bg==
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
Subject: [patch V2 24/33] PCI/MSI: Provide prepare_desc() MSI domain op
References: <20221121083657.157152924@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:38:16 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The setup of MSI descriptors for PCI/MSI-X interrupts depends partially on
the MSI index for which the descriptor is initialized.

Dynamic MSI-X vector allocation post MSI-X enablement allows to allocate
vectors at a given index or at any free index in the available table
range. The latter requires that the descriptor is initialized after the
MSI core has chosen an index.

Implement the prepare_desc() op in the PCI/MSI-X specific msi_domain_ops
which is invoked before the core interrupt descriptor and the associated
Linux interrupt number is allocated.

That callback is also provided for the upcoming PCI/IMS implementations so
the implementation specific interrupt domain can do their domain specific
initialization of the MSI descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
V2: Reworded changelog (Bjorn)
---
 drivers/pci/msi/irqdomain.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -202,6 +202,14 @@ static void pci_unmask_msix(struct irq_d
 	pci_msix_unmask(irq_data_get_msi_desc(data));
 }
 
+static void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
+				  struct msi_desc *desc)
+{
+	/* Don't fiddle with preallocated MSI descriptors */
+	if (!desc->pci.mask_base)
+		msix_prepare_msi_desc(to_pci_dev(desc->dev), desc);
+}
+
 static struct msi_domain_template pci_msix_template = {
 	.chip = {
 		.name			= "PCI-MSIX",
@@ -212,6 +220,7 @@ static struct msi_domain_template pci_ms
 	},
 
 	.ops = {
+		.prepare_desc		= pci_msix_prepare_desc,
 		.set_desc		= pci_device_domain_set_desc,
 	},
 

