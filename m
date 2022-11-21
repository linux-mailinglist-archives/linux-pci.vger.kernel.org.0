Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E68E632607
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiKUOgt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiKUOgh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:36:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BEBC80EF;
        Mon, 21 Nov 2022 06:36:21 -0800 (PST)
Message-ID: <20221121083325.573428885@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XzEU6xpUtYERldMqsji8DXGQ2kRnY83P6uKMpYacBXc=;
        b=dU8Pv1A3KUHAjBDxJCqRcuMbTTS80Mc9lLCZK9YTQfwuRkQG4KnB7JSpzEEgcazLqmhi+l
        GFCfaHXM2ER96zq2r0Xi+UM6H83wimW9tR1zE0vhzqSSi4NafFsz5bXbM6dGdsJjKUdiPx
        rxgIb4NqlHDYu0592wWnTFdv4mbSy03cWeWNDvBL+pvlybHGuLYmN0vhriVCH3Xs2/BNkJ
        h8wQunObOJceMdqn2Welwg5gVQdLuBmt6tqUdE4sHj1l8SVXSLRtVlvtBJyViyV7+vsfdP
        dXdBwDLc/hp01ZyPTMzJPIOV6fandAXVQhzMthGzYTDX3Cs8eh6S5AS4/cVfDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XzEU6xpUtYERldMqsji8DXGQ2kRnY83P6uKMpYacBXc=;
        b=9Rk1Rpr8yUYA05RyCHr0jXkegrQlwrh5f3aqgh5NaQ1HphRHReVuGD6lvPq8XCdKSk5c6w
        mIaWKFsPb4X/QqDA==
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
Subject: [patch V2 01/21] genirq/msi: Move IRQ_DOMAIN_MSI_NOMASK_QUIRK to MSI flags
References: <20221121083210.309161925@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:36:19 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It's truly a MSI only flag and for the upcoming per device MSI domains this
must be in the MSI flags so it can be set during domain setup without
exposing this quirk outside of x86.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 arch/x86/kernel/apic/msi.c |    5 ++---
 include/linux/irqdomain.h  |    9 +--------
 include/linux/msi.h        |    6 ++++++
 kernel/irq/msi.c           |    2 +-
 4 files changed, 10 insertions(+), 12 deletions(-)

--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -176,7 +176,8 @@ static struct msi_domain_ops pci_msi_dom
 
 static struct msi_domain_info pci_msi_domain_info = {
 	.flags		= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-			  MSI_FLAG_PCI_MSIX,
+			  MSI_FLAG_PCI_MSIX | MSI_FLAG_NOMASK_QUIRK,
+
 	.ops		= &pci_msi_domain_ops,
 	.chip		= &pci_msi_controller,
 	.handler	= handle_edge_irq,
@@ -200,8 +201,6 @@ struct irq_domain * __init native_create
 	if (!d) {
 		irq_domain_free_fwnode(fn);
 		pr_warn("Failed to initialize PCI-MSI irqdomain.\n");
-	} else {
-		d->flags |= IRQ_DOMAIN_MSI_NOMASK_QUIRK;
 	}
 	return d;
 }
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -186,15 +186,8 @@ enum {
 	/* Irq domain implements MSI remapping */
 	IRQ_DOMAIN_FLAG_MSI_REMAP	= (1 << 5),
 
-	/*
-	 * Quirk to handle MSI implementations which do not provide
-	 * masking. Currently known to affect x86, but partially
-	 * handled in core code.
-	 */
-	IRQ_DOMAIN_MSI_NOMASK_QUIRK	= (1 << 6),
-
 	/* Irq domain doesn't translate anything */
-	IRQ_DOMAIN_FLAG_NO_MAP		= (1 << 7),
+	IRQ_DOMAIN_FLAG_NO_MAP		= (1 << 6),
 
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -399,6 +399,12 @@ enum {
 	MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS	= (1 << 9),
 	/* Free MSI descriptors */
 	MSI_FLAG_FREE_MSI_DESCS		= (1 << 10),
+	/*
+	 * Quirk to handle MSI implementations which do not provide
+	 * masking. Currently known to affect x86, but has to be partially
+	 * handled in the core MSI code.
+	 */
+	MSI_FLAG_NOMASK_QUIRK		= (1 << 11),
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -875,7 +875,7 @@ static int __msi_domain_alloc_irqs(struc
 		 * MSI affinity setting requires a special quirk (X86) when
 		 * reservation mode is active.
 		 */
-		if (domain->flags & IRQ_DOMAIN_MSI_NOMASK_QUIRK)
+		if (info->flags & MSI_FLAG_NOMASK_QUIRK)
 			vflags |= VIRQ_NOMASK_QUIRK;
 	}
 

