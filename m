Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315DD625C19
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbiKKOAk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbiKKOAO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:00:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F313391C5;
        Fri, 11 Nov 2022 05:56:41 -0800 (PST)
Message-ID: <20221111132706.104870257@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=AJ8ukewK1Vm9sMuQ8J9M/D1xUb59WLt5C0IKQaGN9eI=;
        b=nQh29gwWm+mp9adZ3XnFqZww6hDJZUArAFgW9DLxJ58tiv3rjxKjGS28S3LLejO0X1RYiF
        ujFOqd1MgCxdHFGOM04FZBbCC0goBivqH06V4EE8P4dFkOZPIKEP19hPgZJ9OCn25oN1rC
        tCM3GVTfL8UsM4IOIXfSvv8XMNh6AVjTpNBWx3jWcq5zMdtgNhn8NFAzoaTf5d4iZwqxns
        dYCWNQFMqkn7zvgRgvaYUxoHRVwfUgLAVaytq36O9SdC+zPnQvsZ3MX3e59xHTc4HO7lna
        2Vp3WjJCbFzt1spSfRA1RbK3Mgw6wn5gAVDXBiWZ+oobxvkXGzgphhVw/nblog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=AJ8ukewK1Vm9sMuQ8J9M/D1xUb59WLt5C0IKQaGN9eI=;
        b=HQtH4ThXuPL/qsID3YXyZfhFETiPGyK/Ea/QVJX0HE4KqZFZQsfNyTlKIEOa8bsCYJIy5r
        A3W2Mpv1WtQCl2Bw==
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
Subject: [patch 01/20] genirq/msi: Move IRQ_DOMAIN_MSI_NOMASK_QUIRK to MSI flags
References: <20221111131813.914374272@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:56:39 +0100 (CET)
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
@@ -395,6 +395,12 @@ enum {
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
 

