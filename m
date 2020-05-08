Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A43E1CB45E
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 18:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgEHQKB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 12:10:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:63570 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbgEHQKA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 May 2020 12:10:00 -0400
IronPort-SDR: eODYJ66lIqbkDKoLhL0J/78k8qPl+c01vs+hn00ciYQMCqALv+I2MBjS3vnzH/cks3OzS/drN2
 IotnHPZRrEwA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 09:09:59 -0700
IronPort-SDR: kMuRVDTxyHoYaf54TerCs/bPQWfFHXQ19Pxsa4cyoq61C504anqi3UDaBHYTTvlhpwJJxvJg8A
 N/3WNncHJbBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,368,1583222400"; 
   d="scan'208";a="285516921"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by fmsmga004.fm.intel.com with ESMTP; 08 May 2020 09:09:58 -0700
Date:   Fri, 8 May 2020 09:09:58 -0700
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
Message-ID: <20200508160958.GA19631@otc-nc-03>
References: <20200508005528.GB61703@otc-nc-03>
 <87368almbm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87368almbm.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On Fri, May 08, 2020 at 01:04:29PM +0200, Thomas Gleixner wrote:
> Ashok,
> 
> "Raj, Ashok" <ashok.raj@intel.com> writes:
> >> But as this last one is the migration thread, aka stomp machine, I
> >> assume this is a hotplug operation. Which means the CPU cannot handle
> >> interrupts anymore. In that case we check the old vector on the
> >> unplugged CPU in fixup_irqs() and do the retrigger from there.
> >> Can you please add tracing to that one as well?
> >
> > New tracelog attached. It just happened once.
> 
> Correct and it worked as expected.
> 
>      migration/3-24    [003] d..1   275.665751: msi_set_affinity: quirk[1] new vector allocated, new apic = 4 vector = 36 this apic = 6
>      migration/3-24    [003] d..1   275.665776: msi_set_affinity: Redirect to new vector 36 on old apic 6
>      migration/3-24    [003] d..1   275.665789: msi_set_affinity: Transition to new target apic 4 vector 36
>      migration/3-24    [003] d..1   275.665790: msi_set_affinity: Update Done [IRR 0]: irq 123 Nvec 36 Napic 4
>      migration/3-24    [003] d..1   275.666792: fixup_irqs: retrigger vector 33 irq 123
> 
> So looking at your trace further down, the problem is not the last
> one. It dies already before that:
> 
>            <...>-14    [001] d..1   284.901587: msi_set_affinity: quirk[1] new vector allocated, new apic = 6 vector = 33 this apic = 2
>            <...>-14    [001] d..1   284.901604: msi_set_affinity: Direct Update: irq 123 Ovec=33 Oapic 2 Nvec 33 Napic 6
>            
> Here, the interrupts stop coming in and that's just a regular direct
> update, i.e. same vector, different CPU. The update below is updating a
> dead device already.

So we lost the interrupt either before or after we migrated to apic2?

In the direct update when we migrate same vector but different CPU
if there was a pending IRR on the current CPU, where is that getting cleaned up?

> 
>      migration/3-24    [003] d..1   284.924960: msi_set_affinity: quirk[1] new vector allocated, new apic = 4 vector = 36 this apic = 6
>      migration/3-24    [003] d..1   284.924987: msi_set_affinity: Redirect to new vector 36 on old apic 6
>      migration/3-24    [003] d..1   284.924999: msi_set_affinity: Transition to new target apic 4 vector 36
>      migration/3-24    [003] d..1   284.925000: msi_set_affinity: Update Done [IRR 0]: irq 123 Nvec 36 Napic 4
> 
> TBH, I can't see anything what's wrong here from the kernel side and as
> this is new silicon and you're the only ones reporting this it seems
> that this is something which is specific to that particular
> hardware. Have you talked to the hardware people about this?
> 

After chasing it, I'm also trending to think that way. We had a question
about the moderation timer and how its affecting this behavior.
Mathias tried to turn off the moderation timer, and we are still able to 
see this hang. We are reaching out to the HW folks to get a handle on this.

With legacy MSI we can have these races and kernel is trying to do the
song and dance, but we see this happening even when IR is turned on.
Which is perplexing. I think when we have IR, once we do the change vector 
and flush the interrupt entry cache, if there was an outstandng one in 
flight it should be in IRR. Possibly should be clearned up by the
send_cleanup_vector() i suppose.

Cheers,
Ashok
