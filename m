Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D434ED466
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 09:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiCaHMC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 03:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiCaHMB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 03:12:01 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6625B5BE50;
        Thu, 31 Mar 2022 00:10:13 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 380D192009D; Thu, 31 Mar 2022 09:10:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 324F592009B;
        Thu, 31 Mar 2022 08:10:12 +0100 (BST)
Date:   Thu, 31 Mar 2022 08:10:12 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND][PATCH v2 1/4] x86/PCI: Show the physical address of the
 $PIR table
In-Reply-To: <alpine.DEB.2.21.2203301527270.22465@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2203301532330.22465@angie.orcam.me.uk>
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
