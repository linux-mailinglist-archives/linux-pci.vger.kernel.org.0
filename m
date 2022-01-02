Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96460482D34
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jan 2022 00:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiABXc6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Jan 2022 18:32:58 -0500
Received: from angie.orcam.me.uk ([78.133.224.34]:38432 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiABXc4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Jan 2022 18:32:56 -0500
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id B25549200C4; Mon,  3 Jan 2022 00:24:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id A49749200C3;
        Sun,  2 Jan 2022 23:24:23 +0000 (GMT)
Date:   Sun, 2 Jan 2022 23:24:23 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] x86/PCI: Show the physical address of the $PIR
 table
In-Reply-To: <alpine.DEB.2.21.2201020142430.56863@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2201020151450.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201020142430.56863@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It makes no sense to hide the address of the $PIR table in a debug dump:

PCI: Interrupt Routing Table found at 0x(ptrval)

let alone print its virtual address, given that this is a BIOS entity at 
a fixed location in the system's memory map.  Show the physical address 
instead then, e.g.:

PCI: Interrupt Routing Table found at 0xfde10

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
No change from v1.
---
 arch/x86/pci/irq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

linux-x86-debug-pirq-addr.diff
Index: linux-macro/arch/x86/pci/irq.c
===================================================================
--- linux-macro.orig/arch/x86/pci/irq.c
+++ linux-macro/arch/x86/pci/irq.c
@@ -84,8 +84,8 @@ static inline struct irq_routing_table *
 	for (i = 0; i < rt->size; i++)
 		sum += addr[i];
 	if (!sum) {
-		DBG(KERN_DEBUG "PCI: Interrupt Routing Table found at 0x%p\n",
-			rt);
+		DBG(KERN_DEBUG "PCI: Interrupt Routing Table found at 0x%lx\n",
+		    __pa(rt));
 		return rt;
 	}
 	return NULL;
