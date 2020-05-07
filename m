Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645ED1C8B70
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 14:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgEGMx4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 08:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725947AbgEGMxz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 08:53:55 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B097EC05BD43;
        Thu,  7 May 2020 05:53:55 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jWg23-0000cQ-4P; Thu, 07 May 2020 14:53:43 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 685F5102652; Thu,  7 May 2020 14:53:41 +0200 (CEST)
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
In-Reply-To: <20200507121850.GB85463@otc-nc-03>
References: <20200501184326.GA17961@araj-mobl1.jf.intel.com> <878si6rx7f.fsf@nanos.tec.linutronix.de> <20200505201616.GA15481@otc-nc-03> <875zdarr4h.fsf@nanos.tec.linutronix.de> <20200507121850.GB85463@otc-nc-03>
Date:   Thu, 07 May 2020 14:53:41 +0200
Message-ID: <87wo5nj48a.fsf@nanos.tec.linutronix.de>
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

> We did a bit more tracing and it looks like the IRR check is actually
> not happening on the right cpu. See below.

What?

> On Tue, May 05, 2020 at 11:47:26PM +0200, Thomas Gleixner wrote:
>> >
>> > msi_set_affinit ()
>> > {
>> > ....
>> >         unlock_vector_lock();
>> >
>> >         /*
>> >          * Check whether the transition raced with a device interrupt and
>> >          * is pending in the local APICs IRR. It is safe to do this outside
>> >          * of vector lock as the irq_desc::lock of this interrupt is still
>> >          * held and interrupts are disabled: The check is not accessing the
>> >          * underlying vector store. It's just checking the local APIC's
>> >          * IRR.
>> >          */
>> >         if (lapic_vector_set_in_irr(cfg->vector))
>> >                 irq_data_get_irq_chip(irqd)->irq_retrigger(irqd);
>> 
>> No. This catches the transitional interrupt to the new vector on the
>> original CPU, i.e. the one which is running that code.
>
> Mathias added some trace to his xhci driver when the isr is called.
>
> Below is the tail of my trace with last two times xhci_irq isr is called:
>
>     <idle>-0     [003] d.h.   200.277971: xhci_irq: xhci irq
>     <idle>-0     [003] d.h.   200.278052: xhci_irq: xhci irq
>
> Just trying to follow your steps below with traces. The traces follow
> the same comments in the source.
>
>> 
>> Again the steps are:
>> 
>>  1) Allocate new vector on new CPU
>
>         /* Allocate a new target vector */
>         ret = parent->chip->irq_set_affinity(parent, mask, force);
>
> migration/3-24    [003] d..1   200.283012: msi_set_affinity: msi_set_affinity: quirk: 1: new vector allocated, new cpu = 0
>
>> 
>>  2) Set new vector on original CPU
>
>         /* Redirect it to the new vector on the local CPU temporarily */
>         old_cfg.vector = cfg->vector;
>         irq_msi_update_msg(irqd, &old_cfg);
>
> migration/3-24    [003] d..1   200.283033: msi_set_affinity: msi_set_affinity: Redirect to new vector 33 on old cpu 6

On old CPU 6? This runs on CPU 3 which is wrong to begin with.

>>  3) Set new vector on new CPU
>
>         /* Now transition it to the target CPU */
>         irq_msi_update_msg(irqd, cfg);
>
>      migration/3-24    [003] d..1   200.283044: msi_set_affinity: msi_set_affinity: Transition to new target cpu 0 vector 33
>
>
>
>      if (lapic_vector_set_in_irr(cfg->vector))
> 	irq_data_get_irq_chip(irqd)->irq_retrigger(irqd);
>
>
> migration/3-24    [003] d..1   200.283046: msi_set_affinity: msi_set_affinity: Update Done [IRR 0]: irq 123 localsw: Nvec 33 Napic 0
>
>> 
>> So we have 3 points where an interrupt can fire:
>> 
>>  A) Before #2
>> 
>>  B) After #2 and before #3
>> 
>>  C) After #3
>> 
>> #A is hitting the old vector which is still valid on the old CPU and
>>    will be handled once interrupts are enabled with the correct irq
>>    descriptor - Normal operation (same as with maskable MSI)
>> 
>> #B This must be checked in the IRR because the there is no valid vector
>>    on the old CPU.
>
> The check for IRR seems like on a random cpu3 vs checking for the new vector 33
> on old cpu 6?

The whole sequence runs on CPU 3. If old CPU was 6 then this should
never run on CPU 3.

> This is the place when we force the retrigger without the IRR check things seem to fix itself.

It's not fixing it. It's papering over the root cause.

> Did we miss something? 

Yes, you missed to analyze why this runs on CPU3 when old CPU is 6. But
the last interrupt actually was on CPU3.

>     <idle>-0     [003] d.h.   200.278052: xhci_irq: xhci irq

Can you please provide the full trace and the patch you used to generate
it?

Thanks,

        tglx
