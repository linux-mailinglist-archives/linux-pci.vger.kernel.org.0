Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893C73BBB75
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 12:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhGEKsv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 06:48:51 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:60282 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhGEKsv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 06:48:51 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 82FE092009C; Mon,  5 Jul 2021 12:46:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7BD6092009B;
        Mon,  5 Jul 2021 12:46:13 +0200 (CEST)
Date:   Mon, 5 Jul 2021 12:46:13 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Nikolai Zhubr <zhubr.2@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     Arnd Bergmann <arnd@kernel.org>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/PCI: Handle PIRQ routing tables with no router device
 given
Message-ID: <alpine.DEB.2.21.2107051133010.33206@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PIRQ routing tables provided by the PCI BIOS usually specify the PCI 
vendor:device ID as well as the bus address of the device implementing 
the PIRQ router, e.g.:

PCI: Interrupt Routing Table found at 0xc00fde10
[...]
PCI: Attempting to find IRQ router for [8086:7000]
pci 0000:00:07.0: PIIX/ICH IRQ router [8086:7000]

however in some cases they do not, in which case we fail to match the 
router handler, e.g.:

PCI: Interrupt Routing Table found at 0xc00fdae0
[...]
PCI: Attempting to find IRQ router for [0000:0000]
PCI: Interrupt router not found at 00:00

This is because we always match the vendor:device ID and the bus address 
literally, even if they are all zeros.

Handle this case then and iterate over all PCI devices until we find a 
matching router handler if the vendor ID given by the routing table is 
the invalid value of zero.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 arch/x86/pci/irq.c |   63 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 20 deletions(-)

linux-x86-pirq-router-nodev.diff
Index: linux-macro-ide-tty/arch/x86/pci/irq.c
===================================================================
--- linux-macro-ide-tty.orig/arch/x86/pci/irq.c
+++ linux-macro-ide-tty/arch/x86/pci/irq.c
@@ -908,10 +908,32 @@ static struct pci_dev *pirq_router_dev;
  *	chipset" ?
  */
 
+static bool __init pirq_try_router(struct irq_router *r,
+				   struct irq_routing_table *rt,
+				   struct pci_dev *dev)
+{
+	struct irq_router_handler *h;
+
+	DBG(KERN_DEBUG "PCI: Trying IRQ router for [%04x:%04x]\n",
+	    dev->vendor, dev->device);
+
+	for (h = pirq_routers; h->vendor; h++) {
+		/* First look for a router match */
+		if (rt->rtr_vendor == h->vendor &&
+		    h->probe(r, dev, rt->rtr_device))
+			return true;
+		/* Fall back to a device match */
+		if (dev->vendor == h->vendor &&
+		    h->probe(r, dev, dev->device))
+			return true;
+	}
+	return false;
+}
+
 static void __init pirq_find_router(struct irq_router *r)
 {
 	struct irq_routing_table *rt = pirq_table;
-	struct irq_router_handler *h;
+	struct pci_dev *dev;
 
 #ifdef CONFIG_PCI_BIOS
 	if (!rt->signature) {
@@ -930,27 +952,28 @@ static void __init pirq_find_router(stru
 	DBG(KERN_DEBUG "PCI: Attempting to find IRQ router for [%04x:%04x]\n",
 	    rt->rtr_vendor, rt->rtr_device);
 
-	pirq_router_dev = pci_get_domain_bus_and_slot(0, rt->rtr_bus,
-						      rt->rtr_devfn);
-	if (!pirq_router_dev) {
-		DBG(KERN_DEBUG "PCI: Interrupt router not found at "
-			"%02x:%02x\n", rt->rtr_bus, rt->rtr_devfn);
-		return;
+	/* Use any vendor:device provided by the routing table or try all.  */
+	if (rt->rtr_vendor) {
+		dev = pci_get_domain_bus_and_slot(0, rt->rtr_bus,
+						  rt->rtr_devfn);
+		if (pirq_try_router(r, rt, dev))
+			pirq_router_dev = dev;
+	} else {
+		for_each_pci_dev(dev) {
+			if (pirq_try_router(r, rt, dev)) {
+				pirq_router_dev = dev;
+				break;
+			}
+		}
 	}
 
-	for (h = pirq_routers; h->vendor; h++) {
-		/* First look for a router match */
-		if (rt->rtr_vendor == h->vendor &&
-			h->probe(r, pirq_router_dev, rt->rtr_device))
-			break;
-		/* Fall back to a device match */
-		if (pirq_router_dev->vendor == h->vendor &&
-			h->probe(r, pirq_router_dev, pirq_router_dev->device))
-			break;
-	}
-	dev_info(&pirq_router_dev->dev, "%s IRQ router [%04x:%04x]\n",
-		 pirq_router.name,
-		 pirq_router_dev->vendor, pirq_router_dev->device);
+	if (pirq_router_dev)
+		dev_info(&pirq_router_dev->dev, "%s IRQ router [%04x:%04x]\n",
+			 pirq_router.name,
+			 pirq_router_dev->vendor, pirq_router_dev->device);
+	else
+		DBG(KERN_DEBUG "PCI: Interrupt router not found at "
+		    "%02x:%02x\n", rt->rtr_bus, rt->rtr_devfn);
 
 	/* The device remains referenced for the kernel lifetime */
 }
