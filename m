Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B71B4ED46C
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 09:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiCaHMG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 03:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiCaHME (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 03:12:04 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 304435AEDD;
        Thu, 31 Mar 2022 00:10:18 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8EBFC92009C; Thu, 31 Mar 2022 09:10:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 87E7C92009B;
        Thu, 31 Mar 2022 08:10:17 +0100 (BST)
Date:   Thu, 31 Mar 2022 08:10:17 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND][PATCH v2 2/4] x86/PCI: Include function number in $PIR
 table dump
In-Reply-To: <alpine.DEB.2.21.2203301527270.22465@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2203301534440.22465@angie.orcam.me.uk>
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
No change from v1.
---
 arch/x86/pci/irq.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

linux-x86-debug-pirq-fn.diff
Index: linux-macro/arch/x86/pci/irq.c
===================================================================
--- linux-macro.orig/arch/x86/pci/irq.c
+++ linux-macro/arch/x86/pci/irq.c
@@ -135,7 +135,8 @@ static void __init pirq_peer_trick(void)
 #ifdef DEBUG
 		{
 			int j;
-			DBG(KERN_DEBUG "%02x:%02x slot=%02x", e->bus, e->devfn/8, e->slot);
+			DBG(KERN_DEBUG "%02x:%02x.%x slot=%02x",
+			    e->bus, e->devfn / 8, e->devfn % 8, e->slot);
 			for (j = 0; j < 4; j++)
 				DBG(" %d:%02x/%04x", j, e->irq[j].link, e->irq[j].bitmap);
 			DBG("\n");
