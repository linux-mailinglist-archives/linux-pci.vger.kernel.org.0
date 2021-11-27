Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF8745FC11
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 03:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350170AbhK0C2F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 21:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242917AbhK0C0E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 21:26:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CC0C0619E9;
        Fri, 26 Nov 2021 17:32:52 -0800 (PST)
Message-ID: <20211127000919.061417652@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hCvJ3RXlnaO1z2W7zc0iNOJLM+aNENiBxAWv9ZJQoBs=;
        b=o8NYvWJiQDxWXpNPxaflbtBocZCwzg6JQwTztqKiBUx1s8Eyt8inNuHUyfyUYS3PYb3J2h
        GtjvCVQiuZ9dcbibJD6A9m9xeDByAXCaqvIsoNq4vjqpuYs4lWUQAuKtOGpeWoHbTTx2tm
        BVt7U+YgAfGs0WNKegcRzL14VhZcP+9M1hRyrHXcva/rc25nyD2q703ZIdFZO19jlfaYxN
        YjXKYwcVg+3zgNa7ULIcInHsERImfsvF8MRImc7fPIqp9oeawMaHrTK9JFjBz9WXaorgfJ
        X2ers5j0B3gX9Ih84tyCeMOQ2ZzQPaXzUPZ+q3SzZpvILV9dHaMjcKKM5YK8IA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hCvJ3RXlnaO1z2W7zc0iNOJLM+aNENiBxAWv9ZJQoBs=;
        b=552puWH/+Fck0R9LjfqTBJ6G/hk4FIGJft4PCGMgUO4G7s5bYRHYh3Z+2DTpFR4KCZl6OK
        kuID/+K9LLNsx5Cw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Cooper <amc96@cam.ac.uk>,
        Juergen Gross <jgross@suse.com>, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: [patch 10/10] x86/apic/msi: Support MSI-X vector expansion
References: <20211126233124.618283684@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:25:12 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The X86 PCI/MSI irq domaim implementation supports vector expansion out of
the box. Make it available.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/msi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -178,7 +178,7 @@ static struct msi_domain_ops pci_msi_dom
 
 static struct msi_domain_info pci_msi_domain_info = {
 	.flags		= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-			  MSI_FLAG_PCI_MSIX,
+			  MSI_FLAG_PCI_MSIX | MSI_FLAG_CAN_EXPAND,
 	.ops		= &pci_msi_domain_ops,
 	.chip		= &pci_msi_controller,
 	.handler	= handle_edge_irq,
@@ -226,7 +226,7 @@ static struct irq_chip pci_msi_ir_contro
 
 static struct msi_domain_info pci_msi_ir_domain_info = {
 	.flags		= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-			  MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
+			  MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX | MSI_FLAG_CAN_EXPAND,
 	.ops		= &pci_msi_domain_ops,
 	.chip		= &pci_msi_ir_controller,
 	.handler	= handle_edge_irq,

