Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB70D3B4045
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 11:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhFYJZm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 05:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhFYJZl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jun 2021 05:25:41 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79A10C061574;
        Fri, 25 Jun 2021 02:23:20 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id BF67992009E; Fri, 25 Jun 2021 11:23:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id BBAC592009D;
        Fri, 25 Jun 2021 11:23:19 +0200 (CEST)
Date:   Fri, 25 Jun 2021 11:23:19 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] x86/PCI: Show the physical address of the $PIR table
In-Reply-To: <alpine.DEB.2.21.2106240147570.37803@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2106250911170.37803@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2106240147570.37803@angie.orcam.me.uk>
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
 arch/x86/pci/irq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

linux-x86-debug-pirq-addr.diff
Index: linux-macro-ide/arch/x86/pci/irq.c
===================================================================
--- linux-macro-ide.orig/arch/x86/pci/irq.c
+++ linux-macro-ide/arch/x86/pci/irq.c
@@ -78,8 +78,8 @@ static inline struct irq_routing_table *
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
