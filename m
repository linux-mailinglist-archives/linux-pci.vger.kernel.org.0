Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F091945FB38
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349352AbhK0BhN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:37:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40740 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349115AbhK0BfL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:35:11 -0500
Message-ID: <20211127000919.061417652@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hCvJ3RXlnaO1z2W7zc0iNOJLM+aNENiBxAWv9ZJQoBs=;
        b=XC2Gl2AXYUosg2kIFrKUz3oPHKElC1X9JFf4x3rxNOfcEV8Sq7ff8QkEBIiBuBsTfaHNCM
        65bhXgRy5LZ9CnQBXg7GbCNI4vggc91+DCTEERsiANj0TGuDaiFlcTbB0M47vNHEjihjSW
        8DA00mBgmlvScWnWuX/6xFMQMcL0n5mNIlPxb5zZocO3pbdWx0Ofy1wQIIEqhY38Jgc0AN
        q500czOHWsLH6192qrfut6JygO3G0UlybO6Qtx41PQKuS/ypTmzA4msGtxAX4YLtPpouxb
        /3SyS/cHVyI76sDvXyavx8EUa0STgNuiEnp8ZEVMmX/DZiNkTIl1EM8TAZq2cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hCvJ3RXlnaO1z2W7zc0iNOJLM+aNENiBxAWv9ZJQoBs=;
        b=ailFWK1MoN7Bi6dOYGgm53UBim2lp4UpqheAs+DlCTXZcPa4k+6E5dnX9FNo8gNNMKECaq
        WAcA1zeyb1QOLQAQ==
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
Date:   Sat, 27 Nov 2021 02:24:45 +0100 (CET)
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

