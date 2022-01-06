Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6F54863B0
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 12:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbiAFLYN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 06:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238430AbiAFLYM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 06:24:12 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D91FC061245;
        Thu,  6 Jan 2022 03:24:12 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id CE8FE92009C; Thu,  6 Jan 2022 12:24:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id C764292009B;
        Thu,  6 Jan 2022 11:24:11 +0000 (GMT)
Date:   Thu, 6 Jan 2022 11:24:11 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Nikolai Zhubr <zhubr.2@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     Arnd Bergmann <arnd@kernel.org>,
        Michal Necasek <mnecasek@yahoo.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] x86/PCI: Add $IRT PIRQ routing table support
In-Reply-To: <alpine.DEB.2.21.2201021821480.56863@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2201022058050.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201021821480.56863@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Handle the $IRT PCI IRQ Routing Table format used by AMI for its BCP 
(BIOS Configuration Program) external tool meant for tweaking BIOS 
structures without the need to rebuild it from sources[1].

The $IRT format has been invented by AMI before Microsoft has come up 
with its $PIR format and a $IRT table is therefore there in some systems 
that lack a $PIR table, such as the DataExpert EXP8449 mainboard based 
on the ALi FinALi 486 chipset (M1489/M1487), which predates DMI 2.0 and 
cannot therefore be easily identified at run time.

Unlike with the $PIR format there is no alignment guarantee as to the 
placement of the $IRT table, so scan the whole BIOS area bytewise.

Credit to Michal Necasek for helping me chase documentation for the 
format.

References:

[1] "What is BCP? - AMI", <https://www.ami.com/what-is-bcp/>

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: Michal Necasek <mnecasek@yahoo.com>
---
New change in v3.
---
 arch/x86/include/asm/pci_x86.h |    9 +++++
 arch/x86/pci/irq.c             |   71 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

linux-x86-pirq-irt.diff
Index: linux-macro/arch/x86/include/asm/pci_x86.h
===================================================================
--- linux-macro.orig/arch/x86/include/asm/pci_x86.h
+++ linux-macro/arch/x86/include/asm/pci_x86.h
@@ -90,6 +90,15 @@ struct irq_routing_table {
 	struct irq_info slots[0];
 } __attribute__((packed));
 
+struct irt_routing_table {
+	u32 signature;			/* IRT_SIGNATURE should be here */
+	u8 size;			/* Number of entries provided */
+	u8 used;			/* Number of entries actually used */
+	u16 exclusive_irqs;		/* IRQs devoted exclusively to
+					   PCI usage */
+	struct irq_info slots[0];
+} __attribute__((packed));
+
 extern unsigned int pcibios_irq_mask;
 
 extern raw_spinlock_t pci_config_lock;
Index: linux-macro/arch/x86/pci/irq.c
===================================================================
--- linux-macro.orig/arch/x86/pci/irq.c
+++ linux-macro/arch/x86/pci/irq.c
@@ -25,6 +25,8 @@
 #define PIRQ_SIGNATURE	(('$' << 0) + ('P' << 8) + ('I' << 16) + ('R' << 24))
 #define PIRQ_VERSION 0x0100
 
+#define IRT_SIGNATURE	(('$' << 0) + ('I' << 8) + ('R' << 16) + ('T' << 24))
+
 static int broken_hp_bios_irq9;
 static int acer_tm360_irqrouting;
 
@@ -91,7 +93,69 @@ static inline struct irq_routing_table *
 	return NULL;
 }
 
+/*
+ * Handle the $IRT PCI IRQ Routing Table format used by AMI for its BCP
+ * (BIOS Configuration Program) external tool meant for tweaking BIOS
+ * structures without the need to rebuild it from sources.  The $IRT
+ * format has been invented by AMI before Microsoft has come up with its
+ * $PIR format and a $IRT table is therefore there in some systems that
+ * lack a $PIR table.
+ *
+ * It uses the same PCI BIOS 2.1 format for interrupt routing entries
+ * themselves but has a different simpler header prepended instead,
+ * occupying 8 bytes, where a `$IRT' signature is followed by one byte
+ * specifying the total number of interrupt routing entries allocated in
+ * the table, then one byte specifying the actual number of entries used
+ * (which the BCP tool can take advantage of when modifying the table),
+ * and finally a 16-bit word giving the IRQs devoted exclusively to PCI.
+ * Unlike with the $PIR table there is no alignment guarantee.
+ *
+ * Given the similarity of the two formats the $IRT one is trivial to
+ * convert to the $PIR one, which we do here, except that obviously we
+ * have no information as to the router device to use, but we can handle
+ * it by matching PCI device IDs actually seen on the bus against ones
+ * that our individual routers recognise.
+ *
+ * Reportedly there is another $IRT table format where a 16-bit word
+ * follows the header instead that points to interrupt routing entries
+ * in a $PIR table provided elsewhere.  In that case this code will not
+ * be reached though as the $PIR table will have been chosen instead.
+ */
+static inline struct irq_routing_table *pirq_convert_irt_table(u8 *addr)
+{
+	struct irt_routing_table *ir;
+	struct irq_routing_table *rt;
+	u16 size;
+	u8 sum;
+	int i;
+
+	ir = (struct irt_routing_table *)addr;
+	if (ir->signature != IRT_SIGNATURE || !ir->used || ir->size < ir->used)
+		return NULL;
 
+	DBG(KERN_DEBUG "PCI: $IRT Interrupt Routing Table found at 0x%lx\n",
+	    __pa(ir));
+
+	size = sizeof(*rt) + ir->used * sizeof(rt->slots[0]);
+	rt = kzalloc(size, GFP_KERNEL);
+	if (!rt)
+		return NULL;
+
+	rt->signature = PIRQ_SIGNATURE;
+	rt->version = PIRQ_VERSION;
+	rt->size = size;
+	rt->exclusive_irqs = ir->exclusive_irqs;
+	for (i = 0; i < ir->used; i++)
+		rt->slots[i] = ir->slots[i];
+
+	addr = (u8 *)rt;
+	sum = 0;
+	for (i = 0; i < size; i++)
+		sum += addr[i];
+	rt->checksum = -sum;
+
+	return rt;
+}
 
 /*
  *  Search 0xf0000 -- 0xfffff for the PCI IRQ Routing Table.
@@ -113,6 +177,13 @@ static struct irq_routing_table * __init
 		if (rt)
 			return rt;
 	}
+	for (addr = (u8 *)__va(0xf0000);
+	     addr < (u8 *)__va(0x100000);
+	     addr++) {
+		rt = pirq_convert_irt_table(addr);
+		if (rt)
+			return rt;
+	}
 	return NULL;
 }
 
