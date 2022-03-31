Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123D14ED46D
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 09:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiCaHMY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 03:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiCaHMU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 03:12:20 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD53FA76FB;
        Thu, 31 Mar 2022 00:10:26 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 9B3B59200B4; Thu, 31 Mar 2022 09:10:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 9506F9200B3;
        Thu, 31 Mar 2022 08:10:25 +0100 (BST)
Date:   Thu, 31 Mar 2022 08:10:25 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND][PATCH v2 4/4] x86/PCI: Handle IRQ swizzling with PIRQ
 routers
In-Reply-To: <alpine.DEB.2.21.2203301527270.22465@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2203301538440.22465@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2203301527270.22465@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Similarly to MP-tables PIRQ routing tables may not list devices behind 
PCI-to-PCI bridges, leading to interrupt routing failures, e.g.:

pci 0000:00:07.0: PIIX/ICH IRQ router [8086:7000]
pci 0000:02:00.0: ignoring bogus IRQ 255
pci 0000:02:01.0: ignoring bogus IRQ 255
pci 0000:02:02.0: ignoring bogus IRQ 255
pci 0000:04:00.0: ignoring bogus IRQ 255
pci 0000:04:00.3: ignoring bogus IRQ 255
pci 0000:00:11.0: PCI INT A -> PIRQ 63, mask deb8, excl 0c20
pci 0000:00:11.0: PCI INT A -> newirq 0
PCI: setting IRQ 11 as level-triggered
pci 0000:00:11.0: found PCI INT A -> IRQ 11
pci 0000:00:11.0: sharing IRQ 11 with 0000:00:07.2
pci 0000:02:00.0: PCI INT A not found in routing table
pci 0000:02:01.0: PCI INT A not found in routing table
pci 0000:02:02.0: PCI INT A not found in routing table
pci 0000:04:00.0: PCI INT A not found in routing table
pci 0000:04:00.3: PCI INT D not found in routing table
pci 0000:06:05.0: PCI INT A not found in routing table
pci 0000:06:08.0: PCI INT A not found in routing table
pci 0000:06:08.1: PCI INT B not found in routing table
pci 0000:06:08.2: PCI INT C not found in routing table

and consequently non-working devices.  Since PCI-to-PCI bridges have a 
standardised way of routing interrupts by the means of swizzling do it 
for configurations that use a PIRQ router as well, like with APIC-based 
setups, and use the determined corresponding topmost bridge's interrupt 
pin assignment to route a given device's interrupt:

pci 0000:00:07.0: PIIX/ICH IRQ router [8086:7000]
pci 0000:02:00.0: ignoring bogus IRQ 255
pci 0000:02:01.0: ignoring bogus IRQ 255
pci 0000:02:02.0: ignoring bogus IRQ 255
pci 0000:04:00.0: ignoring bogus IRQ 255
pci 0000:04:00.3: ignoring bogus IRQ 255
pci 0000:00:11.0: PCI INT A -> PIRQ 63, mask deb8, excl 0c20
pci 0000:00:11.0: PCI INT A -> newirq 0
PCI: setting IRQ 11 as level-triggered
pci 0000:00:11.0: found PCI INT A -> IRQ 11
pci 0000:00:11.0: sharing IRQ 11 with 0000:00:07.2
pci 0000:02:00.0: using bridge 0000:00:11.0 INT A to get INT A
pci 0000:00:11.0: sharing IRQ 11 with 0000:02:00.0
pci 0000:02:01.0: using bridge 0000:00:11.0 INT B to get INT A
pci 0000:02:02.0: using bridge 0000:00:11.0 INT C to get INT A
pci 0000:04:00.0: using bridge 0000:00:11.0 INT B to get INT A
pci 0000:04:00.3: using bridge 0000:00:11.0 INT A to get INT D
pci 0000:00:11.0: sharing IRQ 11 with 0000:04:00.3
pci 0000:06:05.0: using bridge 0000:00:11.0 INT D to get INT A
pci 0000:06:08.0: using bridge 0000:00:11.0 INT C to get INT A
pci 0000:06:08.1: using bridge 0000:00:11.0 INT D to get INT B
pci 0000:06:08.2: using bridge 0000:00:11.0 INT A to get INT C
pci 0000:00:11.0: sharing IRQ 11 with 0000:06:08.2
pci 0000:02:01.0: using bridge 0000:00:11.0 INT B to get INT A
pci 0000:02:01.0: PCI INT A -> PIRQ 60, mask deb8, excl 0c20
pci 0000:02:01.0: PCI INT A -> newirq 0
PCI: setting IRQ 10 as level-triggered
pci 0000:02:01.0: found PCI INT A -> IRQ 10
pci 0000:02:01.0: sharing IRQ 10 with 0000:00:14.0
pci 0000:02:00.0: using bridge 0000:00:11.0 INT A to get INT A
pci 0000:02:01.0: using bridge 0000:00:11.0 INT B to get INT A
pci 0000:02:02.0: using bridge 0000:00:11.0 INT C to get INT A
pci 0000:04:00.0: using bridge 0000:00:11.0 INT B to get INT A
pci 0000:02:01.0: sharing IRQ 10 with 0000:04:00.0
pci 0000:04:00.3: using bridge 0000:00:11.0 INT A to get INT D
pci 0000:06:05.0: using bridge 0000:00:11.0 INT D to get INT A
pci 0000:06:08.0: using bridge 0000:00:11.0 INT C to get INT A
pci 0000:06:08.1: using bridge 0000:00:11.0 INT D to get INT B
pci 0000:06:08.2: using bridge 0000:00:11.0 INT A to get INT C
pci 0000:02:02.0: using bridge 0000:00:11.0 INT C to get INT A
pci 0000:02:02.0: PCI INT A -> PIRQ 61, mask deb8, excl 0c20
pci 0000:02:02.0: PCI INT A -> newirq 0
PCI: setting IRQ 5 as level-triggered
pci 0000:02:02.0: found PCI INT A -> IRQ 5
pci 0000:02:02.0: sharing IRQ 5 with 0000:00:13.0
pci 0000:02:00.0: using bridge 0000:00:11.0 INT A to get INT A
pci 0000:02:01.0: using bridge 0000:00:11.0 INT B to get INT A
pci 0000:02:02.0: using bridge 0000:00:11.0 INT C to get INT A
pci 0000:04:00.0: using bridge 0000:00:11.0 INT B to get INT A
pci 0000:04:00.3: using bridge 0000:00:11.0 INT A to get INT D
pci 0000:06:05.0: using bridge 0000:00:11.0 INT D to get INT A
pci 0000:06:08.0: using bridge 0000:00:11.0 INT C to get INT A
pci 0000:02:02.0: sharing IRQ 5 with 0000:06:08.0
pci 0000:06:08.1: using bridge 0000:00:11.0 INT D to get INT B
pci 0000:06:08.2: using bridge 0000:00:11.0 INT A to get INT C
pci 0000:06:05.0: using bridge 0000:00:11.0 INT D to get INT A
pci 0000:06:05.0: PCI INT A -> PIRQ 62, mask deb8, excl 0c20
pci 0000:06:05.0: PCI INT A -> newirq 0
pci 0000:06:05.0: found PCI INT A -> IRQ 5
pci 0000:06:05.0: sharing IRQ 5 with 0000:00:12.0
pci 0000:02:00.0: using bridge 0000:00:11.0 INT A to get INT A
pci 0000:02:01.0: using bridge 0000:00:11.0 INT B to get INT A
pci 0000:02:02.0: using bridge 0000:00:11.0 INT C to get INT A
pci 0000:04:00.0: using bridge 0000:00:11.0 INT B to get INT A
pci 0000:04:00.3: using bridge 0000:00:11.0 INT A to get INT D
pci 0000:06:05.0: using bridge 0000:00:11.0 INT D to get INT A
pci 0000:06:08.0: using bridge 0000:00:11.0 INT C to get INT A
pci 0000:06:08.1: using bridge 0000:00:11.0 INT D to get INT B
pci 0000:06:05.0: sharing IRQ 5 with 0000:06:08.1
pci 0000:06:08.2: using bridge 0000:00:11.0 INT A to get INT C

Adjust log messages accordingly.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
New change in v2, imported from a discrete submission.
---
 arch/x86/pci/irq.c |   60 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 13 deletions(-)

linux-x86-pirq-swizzle-irq.diff
Index: linux-macro/arch/x86/pci/irq.c
===================================================================
--- linux-macro.orig/arch/x86/pci/irq.c
+++ linux-macro/arch/x86/pci/irq.c
@@ -1138,7 +1138,7 @@ static void __init pirq_find_router(stru
  * for motherboard devices, so if a complete match is found, then give
  * it precedence over a slot match.
  */
-static struct irq_info *pirq_get_info(struct pci_dev *dev)
+static struct irq_info *pirq_get_dev_info(struct pci_dev *dev)
 {
 	struct irq_routing_table *rt = pirq_table;
 	int entries = (rt->size - sizeof(struct irq_routing_table)) /
@@ -1157,11 +1157,42 @@ static struct irq_info *pirq_get_info(st
 	return slotinfo;
 }
 
+/*
+ * Buses behind bridges are typically not listed in the PIRQ routing table.
+ * Do the usual dance then and walk the tree of bridges up adjusting the
+ * pin number accordingly on the way until the originating root bus device
+ * has been reached and then use its routing information.
+ */
+static struct irq_info *pirq_get_info(struct pci_dev *dev, u8 *pin)
+{
+	struct pci_dev *temp_dev = dev;
+	struct irq_info *info;
+	u8 temp_pin = *pin;
+	u8 dpin = temp_pin;
+
+	info = pirq_get_dev_info(dev);
+	while (!info && temp_dev->bus->parent) {
+		struct pci_dev *bridge = temp_dev->bus->self;
+
+		temp_pin = pci_swizzle_interrupt_pin(temp_dev, temp_pin);
+		info = pirq_get_dev_info(bridge);
+		if (info)
+			dev_warn(&dev->dev,
+				 "using bridge %s INT %c to get INT %c\n",
+				 pci_name(bridge),
+				 'A' + temp_pin - 1, 'A' + dpin - 1);
+
+		temp_dev = bridge;
+	}
+	*pin = temp_pin;
+	return info;
+}
+
 static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
 {
-	u8 pin;
 	struct irq_info *info;
 	int i, pirq, newirq;
+	u8 dpin, pin;
 	int irq = 0;
 	u32 mask;
 	struct irq_router *r = &pirq_router;
@@ -1169,8 +1200,8 @@ static int pcibios_lookup_irq(struct pci
 	char *msg = NULL;
 
 	/* Find IRQ pin */
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
-	if (!pin) {
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &dpin);
+	if (!dpin) {
 		dev_dbg(&dev->dev, "no interrupt pin\n");
 		return 0;
 	}
@@ -1183,20 +1214,21 @@ static int pcibios_lookup_irq(struct pci
 	if (!pirq_table)
 		return 0;
 
-	info = pirq_get_info(dev);
+	pin = dpin;
+	info = pirq_get_info(dev, &pin);
 	if (!info) {
 		dev_dbg(&dev->dev, "PCI INT %c not found in routing table\n",
-			'A' + pin - 1);
+			'A' + dpin - 1);
 		return 0;
 	}
 	pirq = info->irq[pin - 1].link;
 	mask = info->irq[pin - 1].bitmap;
 	if (!pirq) {
-		dev_dbg(&dev->dev, "PCI INT %c not routed\n", 'A' + pin - 1);
+		dev_dbg(&dev->dev, "PCI INT %c not routed\n", 'A' + dpin - 1);
 		return 0;
 	}
 	dev_dbg(&dev->dev, "PCI INT %c -> PIRQ %02x, mask %04x, excl %04x",
-		'A' + pin - 1, pirq, mask, pirq_table->exclusive_irqs);
+		'A' + dpin - 1, pirq, mask, pirq_table->exclusive_irqs);
 	mask &= pcibios_irq_mask;
 
 	/* Work around broken HP Pavilion Notebooks which assign USB to
@@ -1238,7 +1270,7 @@ static int pcibios_lookup_irq(struct pci
 				newirq = i;
 		}
 	}
-	dev_dbg(&dev->dev, "PCI INT %c -> newirq %d", 'A' + pin - 1, newirq);
+	dev_dbg(&dev->dev, "PCI INT %c -> newirq %d", 'A' + dpin - 1, newirq);
 
 	/* Check if it is hardcoded */
 	if ((pirq & 0xf0) == 0xf0) {
@@ -1272,15 +1304,17 @@ static int pcibios_lookup_irq(struct pci
 			return 0;
 		}
 	}
-	dev_info(&dev->dev, "%s PCI INT %c -> IRQ %d\n", msg, 'A' + pin - 1, irq);
+	dev_info(&dev->dev, "%s PCI INT %c -> IRQ %d\n",
+		 msg, 'A' + dpin - 1, irq);
 
 	/* Update IRQ for all devices with the same pirq value */
 	for_each_pci_dev(dev2) {
-		pci_read_config_byte(dev2, PCI_INTERRUPT_PIN, &pin);
-		if (!pin)
+		pci_read_config_byte(dev2, PCI_INTERRUPT_PIN, &dpin);
+		if (!dpin)
 			continue;
 
-		info = pirq_get_info(dev2);
+		pin = dpin;
+		info = pirq_get_info(dev2, &pin);
 		if (!info)
 			continue;
 		if (info->irq[pin - 1].link == pirq) {
