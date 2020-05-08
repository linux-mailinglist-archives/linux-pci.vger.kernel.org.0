Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCC61CA8EF
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 13:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEHLEr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 07:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726598AbgEHLEr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 May 2020 07:04:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59BAC05BD43;
        Fri,  8 May 2020 04:04:46 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jX0nt-0003Gx-Pc; Fri, 08 May 2020 13:04:29 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 18DC8101175; Fri,  8 May 2020 13:04:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Raj\, Ashok" <ashok.raj@intel.com>
Cc:     "Raj\, Ashok" <ashok.raj@linux.intel.com>,
        Evan Green <evgreen@chromium.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>, x86@kernel.org,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Ghorai\, Sukumar" <sukumar.ghorai@intel.com>,
        "Amara\, Madhusudanarao" <madhusudanarao.amara@intel.com>,
        "Nandamuri\, Srikanth" <srikanth.nandamuri@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: MSI interrupt for xhci still lost on 5.6-rc6 after cpu hotplug
In-Reply-To: <20200508005528.GB61703@otc-nc-03>
Date:   Fri, 08 May 2020 13:04:29 +0200
Message-ID: <87368almbm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ashok,

"Raj, Ashok" <ashok.raj@intel.com> writes:
>> But as this last one is the migration thread, aka stomp machine, I
>> assume this is a hotplug operation. Which means the CPU cannot handle
>> interrupts anymore. In that case we check the old vector on the
>> unplugged CPU in fixup_irqs() and do the retrigger from there.
>> Can you please add tracing to that one as well?
>
> New tracelog attached. It just happened once.

Correct and it worked as expected.

     migration/3-24    [003] d..1   275.665751: msi_set_affinity: quirk[1] new vector allocated, new apic = 4 vector = 36 this apic = 6
     migration/3-24    [003] d..1   275.665776: msi_set_affinity: Redirect to new vector 36 on old apic 6
     migration/3-24    [003] d..1   275.665789: msi_set_affinity: Transition to new target apic 4 vector 36
     migration/3-24    [003] d..1   275.665790: msi_set_affinity: Update Done [IRR 0]: irq 123 Nvec 36 Napic 4
     migration/3-24    [003] d..1   275.666792: fixup_irqs: retrigger vector 33 irq 123

So looking at your trace further down, the problem is not the last
one. It dies already before that:

           <...>-14    [001] d..1   284.901587: msi_set_affinity: quirk[1] new vector allocated, new apic = 6 vector = 33 this apic = 2
           <...>-14    [001] d..1   284.901604: msi_set_affinity: Direct Update: irq 123 Ovec=33 Oapic 2 Nvec 33 Napic 6
           
Here, the interrupts stop coming in and that's just a regular direct
update, i.e. same vector, different CPU. The update below is updating a
dead device already.

     migration/3-24    [003] d..1   284.924960: msi_set_affinity: quirk[1] new vector allocated, new apic = 4 vector = 36 this apic = 6
     migration/3-24    [003] d..1   284.924987: msi_set_affinity: Redirect to new vector 36 on old apic 6
     migration/3-24    [003] d..1   284.924999: msi_set_affinity: Transition to new target apic 4 vector 36
     migration/3-24    [003] d..1   284.925000: msi_set_affinity: Update Done [IRR 0]: irq 123 Nvec 36 Napic 4

TBH, I can't see anything what's wrong here from the kernel side and as
this is new silicon and you're the only ones reporting this it seems
that this is something which is specific to that particular
hardware. Have you talked to the hardware people about this?

Thanks,

        tglx
