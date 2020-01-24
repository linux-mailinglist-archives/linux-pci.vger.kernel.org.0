Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4AA4149155
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2020 23:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgAXWu2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jan 2020 17:50:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43727 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgAXWu2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jan 2020 17:50:28 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iv7mR-0002yD-VM; Fri, 24 Jan 2020 23:50:24 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E171010308A; Fri, 24 Jan 2020 23:50:22 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Evan Green <evgreen@chromium.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Subject: Re: [PATCH v2] PCI/MSI: Avoid torn updates to MSI pairs
In-Reply-To: <CAE=gft7C5HTmcTLsXqXbCtcYDeKG6bCJ0gmgwVNc0PDHLJ5y_A@mail.gmail.com>
References: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid> <CACK8Z6Ft95qj4e_fsA32r_bcz2SsHOW1xxqZJt3_DBAJw=NMGA@mail.gmail.com> <CAE=gft6fKQWExW-=xjZGzXs30XohfpA5SKggvL2WtYXAHmzMew@mail.gmail.com> <87y2tytv5i.fsf@nanos.tec.linutronix.de> <87eevqkpgn.fsf@nanos.tec.linutronix.de> <CAE=gft6YiM5S1A7iJYJTd5zmaAa8=nhLE3B94JtWa+XW-qVSqQ@mail.gmail.com> <CAE=gft5xta4XCJtctWe=R3w=kVr598JCbk9VSRue04nzKAk3CQ@mail.gmail.com> <CAE=gft7MqQ3Mej5oCT=gw6ZLMSTHoSyMGOFz=-hae-eRZvXLxA@mail.gmail.com> <87d0b82a9o.fsf@nanos.tec.linutronix.de> <CAE=gft7C5HTmcTLsXqXbCtcYDeKG6bCJ0gmgwVNc0PDHLJ5y_A@mail.gmail.com>
Date:   Fri, 24 Jan 2020 23:50:22 +0100
Message-ID: <878slwmpu9.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Evan Green <evgreen@chromium.org> writes:
> On Fri, Jan 24, 2020 at 6:34 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> Can you please apply the patch below? It enforces an IPI to the new
>> vector/target CPU when the interrupt is MSI w/o masking. It should
>> cure the issue. It goes without saying that I'm not proud of it.
>
> I'll feel just as dirty putting a tested-by on it :)

Hehehe.

> I don't think this patch is complete. As written, it creates "recovery
> interrupts" for MSIs that are not maskable, however through the
> pci_msi_domain_write_msg() path, which is the one I seem to use, we
> make no effort to mask the MSI while changing affinity. So at the very
> least it would need a follow-on patch that attempts to mask the MSI,
> for MSIs that are maskable. __pci_restore_msi_state(), called in the
> resume path, does have this masking, but for some reason not
> pci_msi_domain_write_msg().

Wrong. The core code does the masking already because that's required
for other things than MSI as well.

For regular affinity changes in the context of the serviced interrupt
it's done in __irq_move_irq() and for the hotplug case it's done in
migrate_one_irq().

You really need to look at the big picture of this and not just at
random bits and pieces of MSI code which are unrelated to this.

> I'm also a bit concerned about all the spurious interrupts we'll be
> introducing. Not just the retriggering introduced here, but the fact
> that we never dealt with the torn interrupt. So in my case, XHCI will
> be sending an interrupt on the old vector to the new CPU, which could
> be registered to anything. I'm worried that not every driver in the
> system is hardened to receiving interrupts it's not prepared for.
> Perhaps the driver misbehaves, or perhaps it's a "bad" interrupt like
> the MCE interrupt that takes the system down. (I realize the MCE
> interrupt itself is not in the device vector region, but some other
> bad interrupt then).

There are no bad or dangerous vectors in the range which can be assigned
to a device.

Drivers which cannot deal with spurious interrupts are broken already
today. Spurious interrupts can happen and do happen for various reasons.

Unhandled spurious interrupts are not a problem as long as there are not
gazillions of them within a split second, which is not the case here.

> Now that you're on board with the torn write theory, what do you think
> about my "transit vector" proposal? The idea is this:
>  - Reserve a single vector number on all CPUs for interrupts in
> transit between CPUs.
>  - Interrupts in transit between CPUs are added to some sort of list,
> or maybe the transit vector itself.

You need a list or some other form of storage for this because migration
can happen in parallel (not the hotplug one, but the regular ones).

>  - __pci_msi_write_msg() would, after proper abstractions, essentially
> be doing this:
>     pci_write(MSI_DATA, TRANSIT_VECTOR);
>     pci_write(MSI_ADDRESS, new_affinity);
>     pci_write(MSI_DATA, new_vector);

That doesn't work. You have to write in the proper order to make all
variants of MSI devices happy. So it's actually two consecutive
full __pci_msi_write_msg() invocations.

>  - The ISR for TRANSIT_VECTOR would go through and call the ISR for
> every IRQ in transit across CPUs. This does still result in a couple
> extra ISR calls, since multiple interrupts might be in transit across
> CPUs, but at least it's very rare.

That's not trivial especially from the locking POV. I thought about it
for a while before hacking up that retrigger thing and everything I came
up with resulted in nasty deadlocks at least on the drawing board.

And for the hotplug case it's even less trivial because the target CPU
sits in stop machine with interrupts disabled and waits for the outgoing
CPU to die. So it cannot handle the interrupt before the outgoing one
cleaned up in fixup_irqs() and you cannot query the APIC IRR on the
target from the outgoing one.

Even in a regular migration the same problem exists because the other
CPU might either be unable to service it or service it _before_ the CPU
which does the migration has completed the process.

> If you think it's a worthwhile idea I can try to code it up.

It's worthwhile, but that needs some deep thoughts about locking and
ordering plus the inevitable race conditions this creates. If it would
be trivial, I surely wouldn't have hacked up the retrigger mess.

Thanks,

        tglx
