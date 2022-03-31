Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1BF4ED47F
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 09:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiCaHNi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 03:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiCaHNE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 03:13:04 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DA30C6808;
        Thu, 31 Mar 2022 00:11:06 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 007DF92009C; Thu, 31 Mar 2022 09:11:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id F125F92009B;
        Thu, 31 Mar 2022 08:11:05 +0100 (BST)
Date:   Thu, 31 Mar 2022 08:11:05 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     Arnd Bergmann <arnd@kernel.org>, Nikolai Zhubr <zhubr.2@gmail.com>,
        Michal Necasek <mnecasek@yahoo.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] x86/PCI: Add $IRT PIRQ routing table support
In-Reply-To: <alpine.DEB.2.21.2203301619340.22465@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2203302228410.9038@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2203301619340.22465@angie.orcam.me.uk>
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
Changes from v3:

- Correct the BIOS memory scan such as to verify that the PCI IRQ Routing
  Table header as well as individual slot entries are all wholly contained 
  within the BIOS memory area.

- Following commit 5224f7909617 ("treewide: Replace zero-length arrays 
  with flexible-array members") also make `slots' in `irt_routing_table' a 
  flexible-array member.

New change in v3.
---
 arch/x86/include/asm/pci_x86.h |    9 ++++
 arch/x86/pci/irq.c             |   76 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

linux-x86-pirq-irt.diff
Index: linux-macro/arch/x86/include/asm/pci_x86.h
===================================================================
--- linux-macro.orig/arch/x86/include/asm/pci_x86.h
+++ linux-macro/arch/x86/include/asm/pci_x86.h
@@ -93,6 +93,15 @@ struct irq_routing_table {
 	struct irq_info slots[];
 } __attribute__((packed));
 
+struct irt_routing_table {
+	u32 signature;			/* IRT_SIGNATURE should be here */
+	u8 size;			/* Number of entries provided */
+	u8 used;			/* Number of entries actually used */
+	u16 exclusive_irqs;		/* IRQs devoted exclusively to
+					   PCI usage */
+	struct irq_info slots[];
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
 
@@ -93,7 +95,74 @@ static inline struct irq_routing_table *
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
+static inline struct irq_routing_table *pirq_convert_irt_table(u8 *addr,
+							       u8 *limit)
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
+
+	size = sizeof(*ir) + ir->used * sizeof(ir->slots[0]);
+	if (size > limit - addr)
+		return NULL;
+
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
 
+	return rt;
+}
 
 /*
  *  Search 0xf0000 -- 0xfffff for the PCI IRQ Routing Table.
@@ -120,6 +189,13 @@ static struct irq_routing_table * __init
 		if (rt)
 			return rt;
 	}
+	for (addr = bios_start;
+	     addr < bios_end - sizeof(struct irt_routing_table);
+	     addr++) {
+		rt = pirq_convert_irt_table(addr, bios_end);
+		if (rt)
+			return rt;
+	}
 	return NULL;
 }
 
