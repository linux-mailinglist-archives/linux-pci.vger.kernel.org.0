Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734A31C1D55
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 20:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgEASn3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 14:43:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:24774 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729721AbgEASn3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 May 2020 14:43:29 -0400
IronPort-SDR: Rui4BvMPHjAlEIl991ZCRoIDvL7v4G0XK6rPsU9o26SdNiuCEZHyovsRnzV91d5zkpkn2UT4Sd
 2iJ8in3RU9fw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 11:43:27 -0700
IronPort-SDR: Oe5DDEpUeSvJd3uJjKa707ZNYN2SDsVYGArwxpk53mO8THLmqANSgHgRvUNuK/SNsanomk6c4J
 Hw26hF4vrnrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,340,1583222400"; 
   d="scan'208";a="258688327"
Received: from araj-mobl1.jf.intel.com ([10.255.228.118])
  by orsmga003.jf.intel.com with ESMTP; 01 May 2020 11:43:27 -0700
Date:   Fri, 1 May 2020 11:43:26 -0700
From:   "Raj, Ashok" <ashok.raj@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Evan Green <evgreen@chromium.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>, x86@kernel.org,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Ghorai, Sukumar" <sukumar.ghorai@intel.com>,
        "Amara, Madhusudanarao" <madhusudanarao.amara@intel.com>,
        "Nandamuri, Srikanth" <srikanth.nandamuri@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: MSI interrupt for xhci still lost on 5.6-rc6 after cpu hotplug
Message-ID: <20200501184326.GA17961@araj-mobl1.jf.intel.com>
References: <806c51fa-992b-33ac-61a9-00a606f82edb@linux.intel.com>
 <87d0974akk.fsf@nanos.tec.linutronix.de>
 <b9fbd55a-7f97-088d-2cc2-4e4ea86d9440@linux.intel.com>
 <87r1xjp3gn.fsf@nanos.tec.linutronix.de>
 <f8057cbc-4814-5083-cddd-d4eb1459529f@linux.intel.com>
 <878sjqfvmi.fsf@nanos.tec.linutronix.de>
 <CAE=gft6Fbibu17H+OfHZjmvHxboioFj09hAmozebc1TE_EqH5g@mail.gmail.com>
 <87tv2dd17z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tv2dd17z.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas

Just started looking into it to get some idea about what could be
going on. I had some questions, that would be helpful to clarify.

On Tue, Mar 24, 2020 at 08:03:44PM +0100, Thomas Gleixner wrote:
> Evan Green <evgreen@chromium.org> writes:
> > On Mon, Mar 23, 2020 at 5:24 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> And of course all of this is so well documented that all of us can
> >> clearly figure out what's going on...
> >
> > I won't pretend to know what's going on, so I'll preface this by
> > labeling it all as "flailing", but:
> >
> > I wonder if there's some way the interrupt can get delayed between
> > XHCI snapping the torn value and it finding its way into the IRR. For
> > instance, if xhci read this value at the start of their interrupt
> > moderation timer period, that would be awful (I hope they don't do
> > this). One test patch would be to carve out 8 vectors reserved for
> > xhci on all cpus. Whenever you change the affinity, the assigned
> > vector is always reserved_base + cpu_number. That lets you exercise
> > the affinity switching code, but in a controlled manner where torn
> > interrupts could be easily seen (ie hey I got an interrupt on cpu 4's
> > vector but I'm cpu 2). I might struggle to write such a change, but in
> > theory it's doable.
> 
> Well, the point is that we don't see a spurious interrupt on any
> CPU. We added a traceprintk into do_IRQ() and that would immediately
> tell us where the thing goes off into lala land. Which it didn't.

Now that we don't have the torn write issue. We did an experiment 
with legacy MSI, and no interrupt remap support. One of the thought
process was, since we don't have a way to ensure that previous MSI writes
are globally observed, a read from the device should flush any
outstanidng writes correct? (according to PCI, not sure if we can
depend on this.. or chipsets would take their own sweet time to push to CPU)

I'm not certain if such a read happens today? So to make it simple tried
to force a retrigger. In the following case of direct update,
even though the vector isn't changing a MSI write to the previous 
destination could have been sent to the previous CPU right? 

arch/x86/kernel/apic/msi.c: msi_set_affinity()

	/*
         * Direct update is possible when:
         * - The MSI is maskable (remapped MSI does not use this code path)).
         *   The quirk bit is not set in this case.
         * - The new vector is the same as the old vector
         * - The old vector is MANAGED_IRQ_SHUTDOWN_VECTOR (interrupt starts up)
         * - The new destination CPU is the same as the old destination CPU
         */
        if (!irqd_msi_nomask_quirk(irqd) ||
            cfg->vector == old_cfg.vector ||
            old_cfg.vector == MANAGED_IRQ_SHUTDOWN_VECTOR ||
            cfg->dest_apicid == old_cfg.dest_apicid) {
                irq_msi_update_msg(irqd, cfg);
	-->>> force a retrigger

It appears that without a gaurantee of flusing MSI writes from the device
the check for lapic_vector_set_in_irr(vector) is still racy. 

With adding the forced retrigger in both places, the test didn't reveal any
lost interrupt cases.

Now the second question with Interrupt Remapping Support:


intel_ir_set_affinity->intel_ir_reconfigure_irte()-> modify_irte()

The flush of Interrupt Entry Cache (IEC) should ensure, if any interrupts
were in flight, they made it to the previous CPU, and any new interrupts
must be delivered to the new CPU.

Question is do we need a check similar to the legacy MSI handling

	if (lapic_vector_set_in_irr())
	    handle interrupt? 

Is there a reason we don't check if the interrupt delivered to previous
CPU in intel_ir_set_affinity()? Or is the send_cleanup_vector() sends
an IPI to perform the cleanup?  

It appears that maybe send_cleanup_vector() sends IPI to the old cpu
and that somehow ensures the device interrupt handler actually getting
called? I lost my track somewhere down there :)


Cheers,
Ashok
