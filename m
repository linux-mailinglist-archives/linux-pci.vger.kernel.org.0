Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C544863B4
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 12:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiAFLYY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 06:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238430AbiAFLYW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 06:24:22 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A98EC061201;
        Thu,  6 Jan 2022 03:24:22 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id F41FE92009C; Thu,  6 Jan 2022 12:24:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id ED12192009B;
        Thu,  6 Jan 2022 11:24:21 +0000 (GMT)
Date:   Thu, 6 Jan 2022 11:24:21 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Nikolai Zhubr <zhubr.2@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     Arnd Bergmann <arnd@kernel.org>,
        Michal Necasek <mnecasek@yahoo.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] x86/PCI: Fix coding style in PIRQ table search
 functions
In-Reply-To: <alpine.DEB.2.21.2201021821480.56863@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2201022143470.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201021821480.56863@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove extraneous spaces around casts and wrap an overlong line in 
`pirq_check_routing_table' and `pirq_find_routing_table'.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
New change in v3.
---
 arch/x86/pci/irq.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

linux-x86-pirq-format.diff
Index: linux-macro/arch/x86/pci/irq.c
===================================================================
--- linux-macro.orig/arch/x86/pci/irq.c
+++ linux-macro/arch/x86/pci/irq.c
@@ -76,7 +76,7 @@ static inline struct irq_routing_table *
 	int i;
 	u8 sum;
 
-	rt = (struct irq_routing_table *) addr;
+	rt = (struct irq_routing_table *)addr;
 	if (rt->signature != PIRQ_SIGNATURE ||
 	    rt->version != PIRQ_VERSION ||
 	    rt->size % 16 ||
@@ -167,12 +167,14 @@ static struct irq_routing_table * __init
 	struct irq_routing_table *rt;
 
 	if (pirq_table_addr) {
-		rt = pirq_check_routing_table((u8 *) __va(pirq_table_addr));
+		rt = pirq_check_routing_table((u8 *)__va(pirq_table_addr));
 		if (rt)
 			return rt;
 		printk(KERN_WARNING "PCI: PIRQ table NOT found at pirqaddr\n");
 	}
-	for (addr = (u8 *) __va(0xf0000); addr < (u8 *) __va(0x100000); addr += 16) {
+	for (addr = (u8 *)__va(0xf0000);
+	     addr < (u8 *)__va(0x100000);
+	     addr += 16) {
 		rt = pirq_check_routing_table(addr);
 		if (rt)
 			return rt;
