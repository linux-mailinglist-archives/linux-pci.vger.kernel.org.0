Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85B21CE532
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 22:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgEKUOQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 16:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEKUOQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 May 2020 16:14:16 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166A7C061A0C;
        Mon, 11 May 2020 13:14:16 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYEoP-0004s2-DW; Mon, 11 May 2020 22:14:05 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 9C713FFBF8; Mon, 11 May 2020 22:14:04 +0200 (CEST)
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
In-Reply-To: <20200511190341.GA95413@otc-nc-03>
References: <20200508005528.GB61703@otc-nc-03> <87368almbm.fsf@nanos.tec.linutronix.de> <20200508160958.GA19631@otc-nc-03> <87h7wqjrsk.fsf@nanos.tec.linutronix.de> <20200511190341.GA95413@otc-nc-03>
Date:   Mon, 11 May 2020 22:14:04 +0200
Message-ID: <87h7wm5iwj.fsf@nanos.tec.linutronix.de>
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
> On Fri, May 08, 2020 at 06:49:15PM +0200, Thomas Gleixner wrote:
>> "Raj, Ashok" <ashok.raj@intel.com> writes:
>> > With legacy MSI we can have these races and kernel is trying to do the
>> > song and dance, but we see this happening even when IR is turned on.
>> > Which is perplexing. I think when we have IR, once we do the change vector 
>> > and flush the interrupt entry cache, if there was an outstandng one in 
>> > flight it should be in IRR. Possibly should be clearned up by the
>> > send_cleanup_vector() i suppose.
>> 
>> Ouch. With IR this really should never happen and yes the old vector
>> will catch one which was raised just before the migration disabled the
>> IR entry. During the change nothing can go wrong because the entry is
>> disabled and only reenabled after it's flushed which will send a pending
>> one to the new vector.
>
> with IR, I'm not sure if we actually mask the interrupt except when
> its a Posted Interrupt.

Indeed. Memory tricked me.

> We do an atomic update to IRTE, with cmpxchg_double
>
> 	ret = cmpxchg_double(&irte->low, &irte->high,
> 			     irte->low, irte->high,
> 			     irte_modified->low, irte_modified->high);

We only do this if:

        if ((irte->pst == 1) || (irte_modified->pst == 1))

i.e. the irte entry was or is going to be used for posted interrupts.

In the non-posted remapping case we do:

       set_64bit(&irte->low, irte_modified->low);
       set_64bit(&irte->high, irte_modified->high);

> followed by flushing the interrupt entry cache. After which any 
> old ones in flight before the flush should be sittig in IRR
> on the outgoing cpu.

Correct.

> The send_cleanup_vector() sends IPI to the apic_id->old_cpu which 
> would be the cpu we are running on correct? and this is a self_ipi
> to IRQ_MOVE_CLEANUP_VECTOR.

Yes, for the IR case the cleanup vector IPI is sent right away because
the IR logic allegedly guarantees that after flushing the IRTE cache no
interrupt can be sent to the old vector. IOW, after the flush a vector
sent to the previous CPU must be already in the IRR of that CPU.

> smp_irq_move_cleanup_interrupt() seems to check IRR with 
> apicid_prev_vector()
>
> 	irr = apic_read(APIC_IRR + (vector / 32 * 0x10));
> 	if (irr & (1U << (vector % 32))) {
> 		apic->send_IPI_self(IRQ_MOVE_CLEANUP_VECTOR);
> 		continue;
> 	}
>
> And this would allow any pending IRR bits in the outgoing CPU to 
> call the relevant ISR's before draining all vectors on the outgoing
> CPU.

No. When the CPU goes offline it does not handle anything after moving
the interrupts away. The pending bits are handled in fixup_irq() after
the forced migration. If the vector is set in the IRR it sends an IPI to
the new target CPU.

That IRR check is paranoia for the following case where interrupt
migration happens between live CPUs:

    Old CPU

    set affinity                <- device sends to old vector/cpu
    ...                 
    irte_...()
    send_cleanup_vector();

    handle_cleanup_vector()     <- Would remove the vector
                                   without that IRR check and
                                   then result in a spurious interrupt

This should actually never happen because the cleanup vector is the
lowest priority vector.

> I couldn't quite pin down how the device ISR's are hooked up through
> this send_cleanup_vector() and what follows.

Device ISRs don't know anything about the underlying irq machinery.

The non IR migration does:

    Old CPU          New CPU

    set affinity
    ...                 
                                <- device sends to new vector/cpu
                     handle_irq
                       ack()
                        apic_ack_irq()
                          irq_complete_move()
                            send_cleanup_vector()

    handle_cleanup_vector()

In case that an interrupt still hits the old CPU:

    set affinity                <- device sends to old vector/cpu
    ...
    handle_irq
     ack()
      apic_ack_irq()
       irq_complete_move()      (Does not send cleanup vector because wrong CPU)

                                <- device sends to new vector/cpu
                     handle_irq
                       ack()
                        apic_ack_irq()
                          irq_complete_move()
                            send_cleanup_vector()

    handle_cleanup_vector()

Thanks,

        tglx
