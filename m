Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76974ED481
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 09:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiCaHNj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 03:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbiCaHNF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 03:13:05 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B1717EB28;
        Thu, 31 Mar 2022 00:11:11 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D8F3992009C; Thu, 31 Mar 2022 09:11:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id D79EB92009B;
        Thu, 31 Mar 2022 08:11:10 +0100 (BST)
Date:   Thu, 31 Mar 2022 08:11:10 +0100 (BST)
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
Subject: [PATCH v4 4/5] x86/PCI: Fix ALi M1487 (IBC) PIRQ router link value
 interpretation
In-Reply-To: <alpine.DEB.2.21.2203301619340.22465@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2203310013270.44113@angie.orcam.me.uk>
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

Fix an issue with commit 1ce849c75534 ("x86/PCI: Add support for the ALi 
M1487 (IBC) PIRQ router") and correct ALi M1487 (IBC) PIRQ router link 
value (`pirq' cookie) interpretation according to findings in the BIOS.

Credit to Nikolai Zhubr for the detective work as to the bit layout.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: Nikolai Zhubr <zhubr.2@gmail.com>
Fixes: 1ce849c75534 ("x86/PCI: Add support for the ALi M1487 (IBC) PIRQ router")
Cc: stable@vger.kernel.org # v5.15+
---
No change from v3.

New change in v3.
---
 arch/x86/pci/irq.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

linux-x86-pirq-router-finali-link.diff
Index: linux-macro/arch/x86/pci/irq.c
===================================================================
--- linux-macro.orig/arch/x86/pci/irq.c
+++ linux-macro/arch/x86/pci/irq.c
@@ -337,6 +337,15 @@ static void write_pc_conf_nybble(u8 base
 	pc_conf_set(reg, x);
 }
 
+/*
+ * FinALi pirq rules are as follows:
+ *
+ * - bit 0 selects between INTx Routing Table Mapping Registers,
+ *
+ * - bit 3 selects the nibble within the INTx Routing Table Mapping Register,
+ *
+ * - bits 7:4 map to bits 3:0 of the PCI INTx Sensitivity Register.
+ */
 static int pirq_finali_get(struct pci_dev *router, struct pci_dev *dev,
 			   int pirq)
 {
@@ -344,11 +353,13 @@ static int pirq_finali_get(struct pci_de
 		0, 9, 3, 10, 4, 5, 7, 6, 0, 11, 0, 12, 0, 14, 0, 15
 	};
 	unsigned long flags;
+	u8 index;
 	u8 x;
 
+	index = (pirq & 1) << 1 | (pirq & 8) >> 3;
 	raw_spin_lock_irqsave(&pc_conf_lock, flags);
 	pc_conf_set(PC_CONF_FINALI_LOCK, PC_CONF_FINALI_LOCK_KEY);
-	x = irqmap[read_pc_conf_nybble(PC_CONF_FINALI_PCI_INTX_RT1, pirq - 1)];
+	x = irqmap[read_pc_conf_nybble(PC_CONF_FINALI_PCI_INTX_RT1, index)];
 	pc_conf_set(PC_CONF_FINALI_LOCK, 0);
 	raw_spin_unlock_irqrestore(&pc_conf_lock, flags);
 	return x;
@@ -362,13 +373,15 @@ static int pirq_finali_set(struct pci_de
 	};
 	u8 val = irqmap[irq];
 	unsigned long flags;
+	u8 index;
 
 	if (!val)
 		return 0;
 
+	index = (pirq & 1) << 1 | (pirq & 8) >> 3;
 	raw_spin_lock_irqsave(&pc_conf_lock, flags);
 	pc_conf_set(PC_CONF_FINALI_LOCK, PC_CONF_FINALI_LOCK_KEY);
-	write_pc_conf_nybble(PC_CONF_FINALI_PCI_INTX_RT1, pirq - 1, val);
+	write_pc_conf_nybble(PC_CONF_FINALI_PCI_INTX_RT1, index, val);
 	pc_conf_set(PC_CONF_FINALI_LOCK, 0);
 	raw_spin_unlock_irqrestore(&pc_conf_lock, flags);
 	return 1;
@@ -377,7 +390,7 @@ static int pirq_finali_set(struct pci_de
 static int pirq_finali_lvl(struct pci_dev *router, struct pci_dev *dev,
 			   int pirq, int irq)
 {
-	u8 mask = ~(1u << (pirq - 1));
+	u8 mask = ~((pirq & 0xf0u) >> 4);
 	unsigned long flags;
 	u8 trig;
 
