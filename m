Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3653B4047
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 11:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhFYJZq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 05:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhFYJZp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jun 2021 05:25:45 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEDB5C061767;
        Fri, 25 Jun 2021 02:23:24 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 24D359200B3; Fri, 25 Jun 2021 11:23:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 1E3DD92009D;
        Fri, 25 Jun 2021 11:23:24 +0200 (CEST)
Date:   Fri, 25 Jun 2021 11:23:24 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] x86/PCI: Include function number in $PIR table dump
In-Reply-To: <alpine.DEB.2.21.2106240147570.37803@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2106250926160.37803@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2106240147570.37803@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Contrary to the PCI BIOS specification[1] some systems include the PCI 
function number for motherboard devices in their $PIR table, e.g. this 
is what the Tyan Tomcat IV S1564D board reports:

00:14 slot=01
 0:60/deb8
 1:61/deb8
 2:62/deb8
 3:63/deb8

00:13 slot=02
 0:61/deb8
 1:62/deb8
 2:63/deb8
 3:60/deb8

00:12 slot=03
 0:62/deb8
 1:63/deb8
 2:60/deb8
 3:61/deb8

00:11 slot=04
 0:63/deb8
 1:60/deb8
 2:61/deb8
 3:62/deb8

00:07 slot=00
 0:00/deb8
 1:00/deb8
 2:00/deb8
 3:00/deb8

00:07 slot=00
 0:00/deb8
 1:00/deb8
 2:00/deb8
 3:63/deb8

Print the function number then in the debug $PIR table dump:

00:14.0 slot=01
 0:60/deb8
 1:61/deb8
 2:62/deb8
 3:63/deb8

00:13.0 slot=02
 0:61/deb8
 1:62/deb8
 2:63/deb8
 3:60/deb8

00:12.0 slot=03
 0:62/deb8
 1:63/deb8
 2:60/deb8
 3:61/deb8

00:11.0 slot=04
 0:63/deb8
 1:60/deb8
 2:61/deb8
 3:62/deb8

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

References:

[1] "PCI BIOS Specification", Revision 2.1, PCI Special Interest Group, 
    August 26, 1994, Table 4-1 "Layout of IRQ routing table entry.", p. 
    12

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 arch/x86/pci/irq.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

linux-x86-debug-pirq-fn.diff
Index: linux-macro-ide/arch/x86/pci/irq.c
===================================================================
--- linux-macro-ide.orig/arch/x86/pci/irq.c
+++ linux-macro-ide/arch/x86/pci/irq.c
@@ -129,7 +129,8 @@ static void __init pirq_peer_trick(void)
 #ifdef DEBUG
 		{
 			int j;
-			DBG(KERN_DEBUG "%02x:%02x slot=%02x", e->bus, e->devfn/8, e->slot);
+			DBG(KERN_DEBUG "%02x:%02x.%x slot=%02x",
+			    e->bus, e->devfn / 8, e->devfn % 8, e->slot);
 			for (j = 0; j < 4; j++)
 				DBG(" %d:%02x/%04x", j, e->irq[j].link, e->irq[j].bitmap);
 			DBG("\n");
