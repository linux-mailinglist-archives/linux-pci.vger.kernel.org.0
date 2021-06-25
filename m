Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F343B404A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 11:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhFYJZ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 05:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbhFYJZx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jun 2021 05:25:53 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEE66C061787;
        Fri, 25 Jun 2021 02:23:29 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 337D492009E; Fri, 25 Jun 2021 11:23:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 2CCF592009D;
        Fri, 25 Jun 2021 11:23:29 +0200 (CEST)
Date:   Fri, 25 Jun 2021 11:23:29 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] x86/PCI: Also match function number in $PIR table
In-Reply-To: <alpine.DEB.2.21.2106240147570.37803@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2106251056390.37803@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2106240147570.37803@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Contrary to the PCI BIOS specification[1] some systems include the PCI 
function number for onboard devices in their $PIR table.  Consequently 
the wrong entry can be matched leading to interrupt routing failures.

For example the Tyan Tomcat IV S1564D board has:

00:07.1 slot=00
 0:00/deb8
 1:00/deb8
 2:00/deb8
 3:00/deb8

00:07.2 slot=00
 0:00/deb8
 1:00/deb8
 2:00/deb8
 3:63/deb8

for its IDE interface and USB controller functions of the 82371SB PIIX3 
southbridge.  Consequently the first entry matches causing the inability 
to route the USB interrupt in the `noapic' mode, in which case we need 
to rely on the interrupt line set by the BIOS:

uhci_hcd 0000:00:07.2: runtime IRQ mapping not provided by arch
uhci_hcd 0000:00:07.2: PCI INT D not routed
uhci_hcd 0000:00:07.2: enabling bus mastering
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 11, io base 0x00006000

Try to match the PCI device and function combined then and if that fails 
move on to PCI device matching only.  Compliant systems will only have a 
single $PIR table entry per PCI device, so this update does not change 
the semantics with them, while systems that have several entries for 
individual functions of a single PCI device each will match the correct 
entry:

uhci_hcd 0000:00:07.2: runtime IRQ mapping not provided by arch
uhci_hcd 0000:00:07.2: PCI INT D -> PIRQ 63, mask deb8, excl 0c20
uhci_hcd 0000:00:07.2: PCI INT D -> newirq 11
uhci_hcd 0000:00:07.2: found PCI INT D -> IRQ 11
uhci_hcd 0000:00:07.2: sharing IRQ 11 with 0000:00:11.0
uhci_hcd 0000:00:07.2: enabling bus mastering
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 11, io base 0x00006000

[1] "PCI BIOS Specification", Revision 2.1, PCI Special Interest Group,
    August 26, 1994, Table 4-1 "Layout of IRQ routing table entry.", p.
    12

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 arch/x86/pci/irq.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

linux-x86-pirq-fn.diff
Index: linux-macro-ide/arch/x86/pci/irq.c
===================================================================
--- linux-macro-ide.orig/arch/x86/pci/irq.c
+++ linux-macro-ide/arch/x86/pci/irq.c
@@ -948,18 +948,29 @@ static void __init pirq_find_router(stru
 	/* The device remains referenced for the kernel lifetime */
 }
 
+/*
+ * We're supposed to match on the PCI device only and not the function,
+ * but some BIOSes build their tables with the PCI function included
+ * for motherboard devices, so if a complete match is found, then give
+ * it precedence over a slot match.
+ */
 static struct irq_info *pirq_get_info(struct pci_dev *dev)
 {
 	struct irq_routing_table *rt = pirq_table;
 	int entries = (rt->size - sizeof(struct irq_routing_table)) /
 		sizeof(struct irq_info);
+	struct irq_info *slotinfo = NULL;
 	struct irq_info *info;
 
 	for (info = rt->slots; entries--; info++)
-		if (info->bus == dev->bus->number &&
-			PCI_SLOT(info->devfn) == PCI_SLOT(dev->devfn))
-			return info;
-	return NULL;
+		if (info->bus == dev->bus->number) {
+			if (info->devfn == dev->devfn)
+				return info;
+			if (!slotinfo &&
+			    PCI_SLOT(info->devfn) == PCI_SLOT(dev->devfn))
+				slotinfo = info;
+		}
+	return slotinfo;
 }
 
 static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
