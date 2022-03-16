Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24C84DB7C7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 19:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346985AbiCPSKz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Mar 2022 14:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbiCPSKz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 14:10:55 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 307D3527E0;
        Wed, 16 Mar 2022 11:09:40 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 382DE92009C; Wed, 16 Mar 2022 19:09:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 30B8992009B;
        Wed, 16 Mar 2022 18:09:38 +0000 (GMT)
Date:   Wed, 16 Mar 2022 18:09:38 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
cc:     Nikolai Zhubr <zhubr.2@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@kernel.org>,
        Michal Necasek <mnecasek@yahoo.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] x86/PCI: Add $IRT PIRQ routing table support
In-Reply-To: <a2791312-2957-27e6-43af-c805bbb90266@collabora.com>
Message-ID: <alpine.DEB.2.21.2203161740350.24248@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201021821480.56863@angie.orcam.me.uk> <alpine.DEB.2.21.2201022058050.56863@angie.orcam.me.uk> <a2791312-2957-27e6-43af-c805bbb90266@collabora.com>
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

On Tue, 15 Mar 2022, Dmitry Osipenko wrote:

> > Handle the $IRT PCI IRQ Routing Table format used by AMI for its BCP 
> > (BIOS Configuration Program) external tool meant for tweaking BIOS 
> > structures without the need to rebuild it from sources[1].
> > 
> > The $IRT format has been invented by AMI before Microsoft has come up 
> > with its $PIR format and a $IRT table is therefore there in some systems 
> > that lack a $PIR table, such as the DataExpert EXP8449 mainboard based 
> > on the ALi FinALi 486 chipset (M1489/M1487), which predates DMI 2.0 and 
> > cannot therefore be easily identified at run time.
> > 
> > Unlike with the $PIR format there is no alignment guarantee as to the 
> > placement of the $IRT table, so scan the whole BIOS area bytewise.
[...]
> This patch broke crosvm using recent linux-next. The "ir = (struct
> irt_routing_table *)addr;" contains invalid pointer. Any ideas why?

 This specific pointer refers to the BIOS area being iterated over:

	for (addr = (u8 *)__va(0xf0000);
	     addr < (u8 *)__va(0x100000);
	     addr++) {

and it is conceptually not new code in that a similar piece as below:

	for (addr = (u8 *)__va(0xf0000);
	     addr < (u8 *)__va(0x100000);
	     addr += 16) {

used to be there before my change and even now it is executed earlier on 
in `pirq_find_routing_table'.

> PCI: Probing PCI hardware
> BUG: unable to handle page fault for address: ffffed1000020000
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 12fff4067 P4D 12fff4067 PUD 12fff3067 PMD 12fff2067 PTE 0
> Oops: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc7-next-20220310+ #226
> Hardware name: ChromiumOS crosvm, BIOS 0
> RIP: 0010:kasan_check_range+0xe6/0x1a0
> Code: 00 74 ee 48 89 c2 b8 01 00 00 00 48 85 d2 75 5d 5b 41 5c 41 5d 5d
> c3 48 85 d2 74 63 4c 01 e2 eb 09 48 83 c0 01 48 39 d0 74 55 <80> 38 00
> 74 f2 eb d2 41 bd 08 00 00 00 45 29 dd 4b 8d 54 25 00 eb

 Thank you for your report and apologies for the trouble.

 I don't know what a "ChromiumOS crosvm" is, but the mention of "Chromium" 
indicates to me it is something reasonably recent that should be using 
ACPI rather than legacy PCI IRQ routing, and even then it should be using 
the standardised $PIR format rather than AMI's proprietary $IRT one.  I am 
more than surprised this code is active for x86-64 even, as this is solely 
i386 legacy.

 In any case we need to debug this and possibly work around somehow as 
this BIOS is likely giving us rubbish information.  Unfortunately without 
access to your Linux build tree along with debug information I can do very 
little.  The faulting piece of code is as follows:

  21:	48 83 c0 01          	add    $0x1,%rax
  25:	48 39 d0             	cmp    %rdx,%rax
  28:	74 55                	je     7f <foo+0x7f>
  2a:	80 38 00             	cmpb   $0x0,(%rax)
  2d:	74 f2                	je     21 <foo+0x21>

-- with the CMPB at 2a being the offender and further information required 
as to what RAX holds at the moment.

 So as the first approximation I would like to see what your BIOS actually 
tells Linux.  Would you therefore please try the following debug patch, 
boot with the `debug' kernel parameter and send me the resulting bootstrap 
log?

  Maciej

---
 arch/x86/include/asm/pci_x86.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

linux-x86-pci-debug.diff
Index: linux-macro/arch/x86/include/asm/pci_x86.h
===================================================================
--- linux-macro.orig/arch/x86/include/asm/pci_x86.h
+++ linux-macro/arch/x86/include/asm/pci_x86.h
@@ -7,7 +7,7 @@
 
 #include <linux/ioport.h>
 
-#undef DEBUG
+#define DEBUG 1
 
 #ifdef DEBUG
 #define DBG(fmt, ...) printk(fmt, ##__VA_ARGS__)
