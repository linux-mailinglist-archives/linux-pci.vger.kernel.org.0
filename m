Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C1D24CA7C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 04:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgHUCSw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 22:18:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53032 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbgHUCRI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 22:17:08 -0400
Message-Id: <20200821002947.575838946@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597976226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Y75c2FVJJci494EIeksaRxPMjifWJ0ThOK2FH5FONAw=;
        b=f6q/sjt6MV1HcPa9lRMLdZeYQ0hfb23mVpk9n87dFWml+X/u456TXEL3KVxnI9CFXQFhko
        NC8PKb93dixQU/GT2j9PYVBmX4QBP58PDRpMuFC4/CYbogcggvjiWLxJSOdErUDyBu/KPq
        mNF4sNUNyvJO4nw/UvQN5UMiO2CDzKoZFl5XW5x92NHzAR8nfOrH9jQX7BVfAUOdrEd6je
        dzqKVyw8XfqUj24SmoG/O7U8+lTc2fC6HzmTWwTlNkkZepcZTm8tcbB5apCi5otJaCfTng
        43bCT4U4I3QqaaRWvEgj9R2MFib3qx1qOlIu9cQkS6iydE7TxRfJUyVWK2DeNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597976226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Y75c2FVJJci494EIeksaRxPMjifWJ0ThOK2FH5FONAw=;
        b=l1NNy7AGh3T+fCtBtGLpx6A7jIa/X2MlC/NaAaOl4Otuq4j1ahRTgdkoqBSQ0xIkVdF7yy
        MYAMivWyppl1DNBA==
Date:   Fri, 21 Aug 2020 02:24:47 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [patch RFC 23/38] x86/xen: Rework MSI teardown
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=x86-xen--Rework-XEN-MSI-management.patch
Content-transfer-encoding: 8-bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

X86 cannot store the irq domain pointer in struct device without breaking
XEN because the irq domain pointer takes precedence over arch_*_msi_irqs()
fallbacks.

XENs MSI teardown relies on default_teardown_msi_irqs() which invokes
arch_teardown_msi_irq(). default_teardown_msi_irqs() is a trivial iterator
over the msi entries associated to a device.

Implement this loop in xen_teardown_msi_irqs() to prepare for removal of
the fallbacks for X86.

This is a preparatory step to wrap XEN MSI alloc/free into a irq domain
which in turn allows to store the irq domain pointer in struct device and
to use the irq domain functions directly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/pci/xen.c |   23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -376,20 +376,31 @@ static void xen_initdom_restore_msi_irqs
 static void xen_teardown_msi_irqs(struct pci_dev *dev)
 {
 	struct msi_desc *msidesc;
+	int i;
+
+	for_each_pci_msi_entry(msidesc, dev) {
+		if (msidesc->irq) {
+			for (i = 0; i < msidesc->nvec_used; i++)
+				xen_destroy_irq(msidesc->irq + i);
+		}
+	}
+}
+
+static void xen_pv_teardown_msi_irqs(struct pci_dev *dev)
+{
+	struct msi_desc *msidesc = first_pci_msi_entry(dev);
 
-	msidesc = first_pci_msi_entry(dev);
 	if (msidesc->msi_attrib.is_msix)
 		xen_pci_frontend_disable_msix(dev);
 	else
 		xen_pci_frontend_disable_msi(dev);
 
-	/* Free the IRQ's and the msidesc using the generic code. */
-	default_teardown_msi_irqs(dev);
+	xen_teardown_msi_irqs(dev);
 }
 
 static void xen_teardown_msi_irq(unsigned int irq)
 {
-	xen_destroy_irq(irq);
+	WARN_ON_ONCE(1);
 }
 
 #endif
@@ -412,7 +423,7 @@ int __init pci_xen_init(void)
 #ifdef CONFIG_PCI_MSI
 	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
 	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
-	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
+	x86_msi.teardown_msi_irqs = xen_pv_teardown_msi_irqs;
 	pci_msi_ignore_mask = 1;
 #endif
 	return 0;
@@ -436,6 +447,7 @@ static void __init xen_hvm_msi_init(void
 	}
 
 	x86_msi.setup_msi_irqs = xen_hvm_setup_msi_irqs;
+	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
 	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
 }
 #endif
@@ -472,6 +484,7 @@ int __init pci_xen_initial_domain(void)
 #ifdef CONFIG_PCI_MSI
 	x86_msi.setup_msi_irqs = xen_initdom_setup_msi_irqs;
 	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
+	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
 	x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
 	pci_msi_ignore_mask = 1;
 #endif

