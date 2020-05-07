Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B627B1C9B42
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 21:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgEGTlp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 15:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGTlp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 15:41:45 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C22CC05BD43;
        Thu,  7 May 2020 12:41:45 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jWmOn-0004f0-9z; Thu, 07 May 2020 21:41:37 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7396E102652; Thu,  7 May 2020 21:41:36 +0200 (CEST)
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
In-Reply-To: <20200507175715.GA22426@otc-nc-03>
References: <20200501184326.GA17961@araj-mobl1.jf.intel.com> <878si6rx7f.fsf@nanos.tec.linutronix.de> <20200505201616.GA15481@otc-nc-03> <875zdarr4h.fsf@nanos.tec.linutronix.de> <20200507121850.GB85463@otc-nc-03> <87wo5nj48a.fsf@nanos.tec.linutronix.de> <20200507175715.GA22426@otc-nc-03>
Date:   Thu, 07 May 2020 21:41:36 +0200
Message-ID: <87blmzedn3.fsf@nanos.tec.linutronix.de>
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
> 
> I think i got mixed up with logical apic id and logical cpu :-(

Stuff happens.

>           <idle>-0     [000] d.h.    44.376659: msi_set_affinity: quirk[1] new vector allocated, new apic = 2 vector = 33 this apic = 0
>           <idle>-0     [000] d.h.    44.376684: msi_set_affinity: Direct Update: irq 123 Ovec=33 Oapic 0 Nvec 33 Napic 2

>           <idle>-0     [000] d.h.    44.376685: xhci_irq: xhci irq

>           <idle>-0     [001] d.h.    44.376750: msi_set_affinity: quirk[1] new vector allocated, new apic = 2 vector = 33 this apic = 2
>           <idle>-0     [001] d.h.    44.376774: msi_set_affinity: Direct Update: irq 123 Ovec=33 Oapic 2 Nvec 33 Napic 2

>           <idle>-0     [001] d.h.    44.376776: xhci_irq: xhci irq
>           <idle>-0     [001] d.h.    44.395824: xhci_irq: xhci irq

>            <...>-14    [001] d..1    44.400666: msi_set_affinity: quirk[1] new vector allocated, new apic = 6 vector = 33 this apic = 2
>            <...>-14    [001] d..1    44.400691: msi_set_affinity: Direct Update: irq 123 Ovec=33 Oapic 2 Nvec 33 Napic 6

>           <idle>-0     [003] d.h.    44.421021: xhci_irq: xhci irq
>           <idle>-0     [003] d.h.    44.421135: xhci_irq: xhci irq

>      migration/3-24    [003] d..1    44.421784: msi_set_affinity: quirk[1] new vector allocated, new apic = 0 vector = 33 this apic = 6
>      migration/3-24    [003] d..1    44.421803: msi_set_affinity: Direct Update: irq 123 Ovec=33 Oapic 6 Nvec 33 Napic 0

So this last one is a direct update. Straight forward moving it from one
to the other CPU on the same vector number.

And that's the case where we either expect the interrupt to come in on
CPU3 or on CPU0.

There is actually an example in the trace:

	<idle>-0     [000] d.h.    40.616467: msi_set_affinity: quirk[1] new vector allocated, new apic = 2 vector = 33 this apic = 0
	<idle>-0     [000] d.h.    40.616488: msi_set_affinity: Direct Update: irq 123 Ovec=33 Oapic 0 Nvec 33 Napic 2
	<idle>-0     [000] d.h.    40.616488: xhci_irq: xhci irq
	<idle>-0     [001] d.h.    40.616504: xhci_irq: xhci irq

>      migration/3-24    [003] d..1    44.421784: msi_set_affinity: quirk[1] new vector allocated, new apic = 0 vector = 33 this apic = 6
>      migration/3-24    [003] d..1    44.421803: msi_set_affinity: Direct Update: irq 123 Ovec=33 Oapic 6 Nvec 33 Napic 0

But as this last one is the migration thread, aka stomp machine, I
assume this is a hotplug operation. Which means the CPU cannot handle
interrupts anymore. In that case we check the old vector on the
unplugged CPU in fixup_irqs() and do the retrigger from there.
Can you please add tracing to that one as well?

Thanks,

        tglx




