Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557631C8A52
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 14:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgEGMSw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 08:18:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:39815 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgEGMSv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 May 2020 08:18:51 -0400
IronPort-SDR: 41dXBmJOV9kcgTQ+bbyKhRt22aKTJ2y++QJZ//5aJGDRNf3Mnmc9iNSHtOOrFBPR5znEJNi6b6
 +TuJVpZTiTMA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 05:18:50 -0700
IronPort-SDR: 7YPBFVxB2W7VTq0T8bMYyvETuExKzSIsCjuvpzvkT0DLPLeRORYAY3lIcO/qcU+pZzokMDfPuh
 fRFvCG2IH1tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; 
   d="scan'208";a="284975859"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by fmsmga004.fm.intel.com with ESMTP; 07 May 2020 05:18:50 -0700
Date:   Thu, 7 May 2020 05:18:50 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Raj, Ashok" <ashok.raj@linux.intel.com>,
        Evan Green <evgreen@chromium.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>, x86@kernel.org,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Ghorai, Sukumar" <sukumar.ghorai@intel.com>,
        "Amara, Madhusudanarao" <madhusudanarao.amara@intel.com>,
        "Nandamuri, Srikanth" <srikanth.nandamuri@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: MSI interrupt for xhci still lost on 5.6-rc6 after cpu hotplug
Message-ID: <20200507121850.GB85463@otc-nc-03>
References: <20200501184326.GA17961@araj-mobl1.jf.intel.com>
 <878si6rx7f.fsf@nanos.tec.linutronix.de>
 <20200505201616.GA15481@otc-nc-03>
 <875zdarr4h.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zdarr4h.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas

We did a bit more tracing and it looks like the IRR check is actually
not happening on the right cpu. See below.

On Tue, May 05, 2020 at 11:47:26PM +0200, Thomas Gleixner wrote:
> >
> > msi_set_affinit ()
> > {
> > ....
> >         unlock_vector_lock();
> >
> >         /*
> >          * Check whether the transition raced with a device interrupt and
> >          * is pending in the local APICs IRR. It is safe to do this outside
> >          * of vector lock as the irq_desc::lock of this interrupt is still
> >          * held and interrupts are disabled: The check is not accessing the
> >          * underlying vector store. It's just checking the local APIC's
> >          * IRR.
> >          */
> >         if (lapic_vector_set_in_irr(cfg->vector))
> >                 irq_data_get_irq_chip(irqd)->irq_retrigger(irqd);
> 
> No. This catches the transitional interrupt to the new vector on the
> original CPU, i.e. the one which is running that code.

Mathias added some trace to his xhci driver when the isr is called.

Below is the tail of my trace with last two times xhci_irq isr is called:

    <idle>-0     [003] d.h.   200.277971: xhci_irq: xhci irq
    <idle>-0     [003] d.h.   200.278052: xhci_irq: xhci irq

Just trying to follow your steps below with traces. The traces follow
the same comments in the source.

> 
> Again the steps are:
> 
>  1) Allocate new vector on new CPU

        /* Allocate a new target vector */
        ret = parent->chip->irq_set_affinity(parent, mask, force);

migration/3-24    [003] d..1   200.283012: msi_set_affinity: msi_set_affinity: quirk: 1: new vector allocated, new cpu = 0

> 
>  2) Set new vector on original CPU

        /* Redirect it to the new vector on the local CPU temporarily */
        old_cfg.vector = cfg->vector;
        irq_msi_update_msg(irqd, &old_cfg);

migration/3-24    [003] d..1   200.283033: msi_set_affinity: msi_set_affinity: Redirect to new vector 33 on old cpu 6
> 
>  3) Set new vector on new CPU

        /* Now transition it to the target CPU */
        irq_msi_update_msg(irqd, cfg);

     migration/3-24    [003] d..1   200.283044: msi_set_affinity: msi_set_affinity: Transition to new target cpu 0 vector 33



     if (lapic_vector_set_in_irr(cfg->vector))
	irq_data_get_irq_chip(irqd)->irq_retrigger(irqd);


migration/3-24    [003] d..1   200.283046: msi_set_affinity: msi_set_affinity: Update Done [IRR 0]: irq 123 localsw: Nvec 33 Napic 0

> 
> So we have 3 points where an interrupt can fire:
> 
>  A) Before #2
> 
>  B) After #2 and before #3
> 
>  C) After #3
> 
> #A is hitting the old vector which is still valid on the old CPU and
>    will be handled once interrupts are enabled with the correct irq
>    descriptor - Normal operation (same as with maskable MSI)
> 
> #B This must be checked in the IRR because the there is no valid vector
>    on the old CPU.

The check for IRR seems like on a random cpu3 vs checking for the new vector 33
on old cpu 6?

This is the place when we force the retrigger without the IRR check things seem to fix itself.

> 
> #C is handled on the new vector on the new CPU
> 


Did we miss something? 

Cheers,
Ashok
