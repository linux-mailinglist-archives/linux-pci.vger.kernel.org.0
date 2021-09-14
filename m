Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFCC40AAC2
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 11:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhINJ0H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 05:26:07 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:33316 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbhINJ0D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 05:26:03 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 05C9D92009C; Tue, 14 Sep 2021 11:24:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 0309892009B;
        Tue, 14 Sep 2021 11:24:44 +0200 (CEST)
Date:   Tue, 14 Sep 2021 11:24:44 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Nikolai Zhubr <zhubr.2@gmail.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/6] x86: PIRQ/ELCR-related fixes and updates
In-Reply-To: <61377A45.8030003@gmail.com>
Message-ID: <alpine.DEB.2.21.2109141102430.38267@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2107171813230.9461@angie.orcam.me.uk> <611993B1.4070302@gmail.com> <alpine.DEB.2.21.2108160027350.45958@angie.orcam.me.uk> <61377A45.8030003@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Nikolai,

> There is no "$PIR" signature anywhere, including all uncompressed internal ROM
> modules. Instead though, there is an "$IRT" signature and a table following
> it:
> 
> F9A90: 24 49 52 54 04 04 00 00 00 18 10 F8 DE 28 F8 DE │ $IRT
> F9AA0: 41 F8 DE 89 F8 DE 01 00 00 20 28 F8 DE 41 F8 DE │
> F9AB0: 89 F8 DE 10 F8 DE 02 00 00 28 41 F8 DE 89 F8 DE │
> F9AC0: 10 F8 DE 28 F8 DE 03 00 00 08 89 F8 DE 10 F8 DE │
> F9AD0: 28 F8 DE 41 F8 DE 04 00 00 09 03 0A 04 05 07 06 │
> F9AE0: 00 0B 00 0C 00 0E 00 0F 60 1E 0E 1F E8 98 00 8B │
> F9AF0: FA 1F 72 6B 0A C0 74 67 3C F0 73 45 8A C8 24 01 │
> 
> By stepping through some BIOS initialization code in bochs, I've determined
> that this table is being consulted just before modifying chipset registers 44
> and 42/43, so no doubt it is related to IRQs.

 IRT clearly must stand for Interrupt (or IRQ) Routing Table.

 Would you be able to share a disassembly of the piece of BIOS code in 
question?  I can read x86 assembly, so maybe the interpretation of the 
10/28/41/89 cookie can be inferred from it.  The high nibble looks 
remarkably like a bit lane selector and swizzling is clearly visible, but 
I fail to guess the algorithm from this pattern.  Given that the PIRQ 
routing handler is chipset-specific we could try interpreting just the 
high nibble, but would it work for the next system with the same chipset?

 Also who is the BIOS vendor?  Maybe they would be able to tell us 
something about the "$IRT" BIOS service.

> [    0.625911] 8139too 0000:00:03.0: runtime IRQ mapping not provided by arch
> [    0.625911] 8139too: 8139too Fast Ethernet driver 0.9.28
> [    0.625911] 8139too 0000:00:03.0: PCI INT A -> PIRQ 10, mask def8, excl
> 0000
> [    0.625911] 8139too 0000:00:03.0: PCI INT A -> newirq 11
> [    0.630068] PCI: setting IRQ 15 as level-triggered
> [    0.630068]  -> edge
> [    0.630068] 8139too 0000:00:03.0: found PCI INT A -> IRQ 15
> [    0.630068] 8139too 0000:00:03.0: IRQ routing conflict: have IRQ 11, want
> IRQ 15
> [    0.641901] 8139too 0000:00:03.0 eth0: RealTek RTL8139 at 0xc2582f00,
> 00:11:6b:32:85:74, IRQ 11
> 
> First, INTA is apparently routed to IRQ11 (and the network card works just
> fine with that), whereas pci code wants IRQ15 for some reason.

 Well, "PCI INT A -> PIRQ 10" cannot be right, the config register at 0x10 
is DRAM Configuration Register I and has nothing to do with PIRQ routing 
(you must have been lucky the system did not lock up).

> Second, dumping chipset reg 44 shows that INTA is still set to EDGE mode
> anyway, although dumping port 4D1 now shows IRQ15 was changed to LEVEL mode,
> exactly as indicated in the above output. I'm not sure, but the datasheet
> (page 77) seems to indicate that INTx mode set in reg 44 should match the
> respective IRQx mode in port 4Dx (Although the ROM BIOS seems to only have
> code to change triggering mode in the 44 register and does not care about port
> 4Dx whatsoever, which kinda contradicts the datasheet)

 Datasheets are not always right, but this one is the best source we have 
for this chipset.

  Maciej
