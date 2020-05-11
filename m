Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2CC1CE386
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 21:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbgEKTDv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 15:03:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:11261 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbgEKTDv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 May 2020 15:03:51 -0400
IronPort-SDR: OQLI/1yQsIY/Vcrv6DGU7Tg050zo5zEPdY/Ezd7h5OFy5F4nBa6L4p3z1soPM/YrjWKal9QLQ6
 Gmly6pxUE7wA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 12:03:47 -0700
IronPort-SDR: P0puikl7IKLENmxHcD9tPx2nAPmyP9LaL8lPpxJkIVNXit7NhCytw3wRgL6/wJ5dbXk16ombmH
 LoHM5qE1CFVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; 
   d="scan'208";a="306261928"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by FMSMGA003.fm.intel.com with ESMTP; 11 May 2020 12:03:46 -0700
Date:   Mon, 11 May 2020 12:03:41 -0700
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
Message-ID: <20200511190341.GA95413@otc-nc-03>
References: <20200508005528.GB61703@otc-nc-03>
 <87368almbm.fsf@nanos.tec.linutronix.de>
 <20200508160958.GA19631@otc-nc-03>
 <87h7wqjrsk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7wqjrsk.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas, 

On Fri, May 08, 2020 at 06:49:15PM +0200, Thomas Gleixner wrote:
> Ashok,
> 
> "Raj, Ashok" <ashok.raj@intel.com> writes:
> > With legacy MSI we can have these races and kernel is trying to do the
> > song and dance, but we see this happening even when IR is turned on.
> > Which is perplexing. I think when we have IR, once we do the change vector 
> > and flush the interrupt entry cache, if there was an outstandng one in 
> > flight it should be in IRR. Possibly should be clearned up by the
> > send_cleanup_vector() i suppose.
> 
> Ouch. With IR this really should never happen and yes the old vector
> will catch one which was raised just before the migration disabled the
> IR entry. During the change nothing can go wrong because the entry is
> disabled and only reenabled after it's flushed which will send a pending
> one to the new vector.

with IR, I'm not sure if we actually mask the interrupt except when
its a Posted Interrupt. 

We do an atomic update to IRTE, with cmpxchg_double

	ret = cmpxchg_double(&irte->low, &irte->high,
			     irte->low, irte->high,
			     irte_modified->low, irte_modified->high);

followed by flushing the interrupt entry cache. After which any 
old ones in flight before the flush should be sittig in IRR
on the outgoing cpu.

The send_cleanup_vector() sends IPI to the apic_id->old_cpu which 
would be the cpu we are running on correct? and this is a self_ipi
to IRQ_MOVE_CLEANUP_VECTOR.

smp_irq_move_cleanup_interrupt() seems to check IRR with 
apicid_prev_vector()

	irr = apic_read(APIC_IRR + (vector / 32 * 0x10));
	if (irr & (1U << (vector % 32))) {
		apic->send_IPI_self(IRQ_MOVE_CLEANUP_VECTOR);
		continue;
	}

And this would allow any pending IRR bits in the outgoing CPU to 
call the relevant ISR's before draining all vectors on the outgoing
CPU. 

Does it sound right?

I couldn't quite pin down how the device ISR's are hooked up through
this send_cleanup_vector() and what follows.

