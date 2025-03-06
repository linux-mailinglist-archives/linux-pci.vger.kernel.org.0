Return-Path: <linux-pci+bounces-23039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67712A543E3
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 08:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915C016AFFF
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 07:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B2F1DB153;
	Thu,  6 Mar 2025 07:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xF1PzUKC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ENjQ+RBt"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A93184E;
	Thu,  6 Mar 2025 07:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741247090; cv=none; b=Nwo7r54tsF3ETukdERe2ZJZ6/tHlPLcS58L5mi61a+23TKL1rz0AuqyTeXaYPwa2MmFJaXBWKzh5n44hfnpgV2ugiMgKUzDPV+9oFkVBnYGrFrz22NRckA5YPJU+0KxAJFs8ucIeyoRfG7nFYoWojrVkwfz1cqKrvgttgkNLOzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741247090; c=relaxed/simple;
	bh=LnJnlzkgsQ9e3xiWL+DVUUjLDIYo2koWT7+NfZp8T6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kionqYG01RMhpkphcT4SjvRNTzSVXtQ2Iqf7HA6L6xF3HFAujj5Ei9Qdk+6onQAJTPcDkyCLhnHy3kbpvlct6P9+xJ5VCkwnKOSlbInmjStL7Raay0hC0OyCblsw9ri1ED6Lh/gcqPvtmz0zDsax6rRwTr4tDP7qiPbK9kUnJXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xF1PzUKC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ENjQ+RBt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741247084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FgqJzH/WiWSTXeHnklqbcr+j8X29K12DsKKrMK2ivQc=;
	b=xF1PzUKC19Pl9Sg2Ce8GFz62hT15MYjhWcVqpGmJlYzPBx5gipHPonnqGOKnQZBEoECnsZ
	dvlXoYVF/T60Q15OCNcmIJXRjAb2FX/0arl1W3Vuyn4jX/HTZqYDWULE7X8OGbvPc7jNU2
	z/5/GpaEQcodb7dNOTO59wuIMdNDfh/SW58VEZ32VaIp54d/CIzDgdvb3UiHw+fRfP8wcp
	rbRey1065Mzks0QwQk6A624xYhlCTRPbcNfsqBtwjuhSfuBcMthGEuHtuxYxo4AtQHZl7p
	PBGP/ZBQUl2CX393FjOvxFXdDDGP1+GpsrtBFE1dXq2zLIZCgxp7r1w9mE3CcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741247084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FgqJzH/WiWSTXeHnklqbcr+j8X29K12DsKKrMK2ivQc=;
	b=ENjQ+RBtvMT41YwHa8IGZn04QHFLYUaEJB5uu/kX6p9s6Phl02SzzsLS8qOcsek/qQKnMg
	6cCk3iVdpXNDjyDQ==
To: Tsai Sung-Fu <danielsftsai@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>, Rob Herring
 <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Chant
 <achant@google.com>, Brian Norris <briannorris@google.com>, Sajid Dalvi
 <sdalvi@google.com>, Mark Cheng <markcheng@google.com>, Ben Cheng
 <bccheng@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] PCI: dwc: Chain the set IRQ affinity request back to
 the parent
In-Reply-To: <CAK7fddAqDPw1CuvBDUsQApbs1ZSE_ruyTAdsp+c4116C0ZjvVw@mail.gmail.com>
References: <20250303070501.2740392-1-danielsftsai@google.com>
 <87a5a2cwer.ffs@tglx>
 <CAK7fddD4Y5CJ3hKQvppGB2Bof4ibYDX4mBK3N1y8qt-NVoBb7w@mail.gmail.com>
 <87eczd6scg.ffs@tglx>
 <CAK7fddAqDPw1CuvBDUsQApbs1ZSE_ruyTAdsp+c4116C0ZjvVw@mail.gmail.com>
Date: Thu, 06 Mar 2025 08:44:43 +0100
Message-ID: <878qpi61sk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05 2025 at 19:21, Tsai Sung-Fu wrote:
> On Tue, Mar 4, 2025 at 5:46=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>> >> > +     ret =3D desc_parent->irq_data.chip->irq_set_affinity(&desc_pa=
rent->irq_data,
>> >> > +                                                        mask_resul=
t, force);
>> >>
>> >> Again. Completely unserialized.
>> >>
>> >
>> > The reason why we remove the desc_parent->lock protection is because
>> > the chained IRQ structure didn't export parent IRQ to the user space, =
so we
>> > think this call path should be the only caller. And since we have &pp-=
>lock hold
>> > at the beginning, so that should help to protect against concurrent
>> > modification here ?
>>
>> "Should be the only caller" is not really a technical argument. If you
>> make assumptions like this, then you have to come up with a proper
>> explanation why this is correct under all circumstances and with all
>> possible variants of parent interrupt chips.
>>
>> Aside of that fiddling with the internals of interrupt descriptors is
>> not really justified here. What's wrong with using the existing
>> irq_set_affinity() mechanism?
>>
> Using irq_set_affinity() would give us some circular deadlock warning
> at the probe stage.
> irq_startup() flow would hold the global lock from irq_setup_affinity(), =
so
> deadlock scenario like this below might happen. The irq_set_affinity()
> would try to acquire &irq_desc_lock_class
> while the dw_pci_msi_set_affinity() already hold the &pp->lock. To
> resolve that we would like to reuse the idea to
> replace the global lock in irq_set_affinity() with PERCPU structure
> from this patch ->
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D64b6d1d7a84538de34c22a6fc92a7dcc2b196b64
> Just would like to know if this looks feasible to you ?

It won't help. See below.

>   Chain exists of:
>   &irq_desc_lock_class --> mask_lock --> &pp->lock
>   Possible unsafe locking scenario:
>         CPU0                            CPU1
>         ----                                   ----
>    lock(&pp->lock);
>                                                lock(mask_lock);
>                                                lock(&pp->lock);
>    lock(&irq_desc_lock_class);

Indeed.

Back to irq_set_affinity(). I did not think about the more problematic
issue with calling irq_set_affinity(): The per CPU mask is then used
recursive, which is a bad idea.

But looking deeper, your implementation breaks some other things, like
e.g. the affinity coupling of interrupt threads on the MSI side. They
have to be coupled to the effective affinity of the underlying hard
interrupt. Solvable problem, but not in the driver.

Aside of the fact that this hardware design is a trainwreck, which
defeats the intended flexibility of MSI, solving this at the chip driver
level ends up in a incomplete and hacky solution. Also as this is not
the only IP block, which was cobbled together mindlessly that way, we
really don't want to proliferate this horrorshow all over the place.

This really wants a generic infrastructure which handles all aspects of
this correctly once and for all of these hardware trainwrecks. That
needs some thoughts and effort, but that's definitely preferred over a
half baked driver specific hackery, which fiddles in the guts of the
interrupt descriptors as it sees fit. From a layering POV, a interrupt
chip driver should not even care about the fact that an interrupt
descriptor exists. We've spent a lot of effort to decouple these things
and just because C allows it, does not mean it's a correct or a good
idea to ignore the layering.

The approach you have taken has a massive downside:

    It forces all (32) MSI interrupts, which are demultiplexed from the
    underlying parent interrupt, to have the same affinity and the user
    space interface in /proc/irq/*/affinity becomes more than
    confusing.

    This is not what user space expects from an interface which controls
    the affinity of an individual interrupt. No user and no tool expects
    that it has to deal with conflicting settings for MSI interrupts,
    which are independent of each other.

    Tools like irqbalanced will be pretty unhappy about the behaviour
    and you have to teach them about the severe limitations of this.

I'm absolutely not convinced that this solves more problems than it
creates.

In fact, you can achieve the very same outcome with a clean and straight
forward ten line change:

   Instead of the hidden chained handlers, request regular interrupts
   for demultiplexing and give them proper names 'DWC_MSI_DEMUX-0-31',
   'DWC_MSI_DEMUX-32-63'...

   That provides exactly the same mechanism w/o all the hackery and
   creates the same (solvable) problem vs. interrupt thread affinity,
   but provides an understandable user interface.

No?


If you really want to provide a useful and flexible mechanism to steer
the affinity of the individual MSI interrupts, which are handled by each
control block, then you have to think about a completely different
approach.

The underlying interrupt per control block will always be affine to a
particular CPU. But it's not written in stone, that the demultiplexing
interrupt actually has to handle the pending interrupts in the context
of the demultiplexer, at least not for MSI interrupts, which are edge
type and from the PCI device side considered 'fire and forget'.

So right now the demultiplex handler does:

   bits =3D read_dbi(...);
   for_each_bit(bit, bits)
        generic_handle_domain_irq(domain, base + bit);

generic_handle_irq_domain() gets the interrupt mapping for the hardware
interrupt number and invokes the relevant flow handler directly from the
same context, which means that the affinity of all those interrupts is
bound to the affinity of the underlying demultiplex interrupt.

Iignoring the devil in the details, this can also be handled by
delegating the handling to a different CPU:

   bits =3D read_dbi(...);
   for_each_bit(bit, bits)
        generic_handle_irq_demux_domain(domain, base + bit);

where generic_handle_demux_domain_irq() does:

      desc =3D irq_resolve_mapping(domain, hwirq);

      if (desc->target_cpu =3D=3D smp_processor_id()) {
      	   handle_irq_desc(desc);
      } else {
          // Issue DWC ack() here? - See below
          irq_work_queue_on(&desc->irq_work, desc->target_cpu);
      }

The generic irq_work handler does:

      desc =3D container_of(work, struct irq_desc, irq_work);
      handle_irq_desc(desc);

That's obviously asynchronous, but in case of edge type MSI interrupts,
that's not a problem at all.

The real problems are:

    1) Handling the pending bit of the interrupt in the DBI, i.e. what
       dw_pci_bottom_ack() does.

    2) Life time of the interrupt descriptor

    3) Slightly increased latency of the rerouted interrupts

    4) Affinity of the demultiplex interrupt

#1 Needs some thoughts. From the top of my head I think it would require
   that dw_pci_bottom_ack() is issued in the context of the demultiplex
   handler as it would otherwise be retriggered, but that just needs
   some research in the datasheet and experimental validation.

   The actual interrupt flow handler for the MSI interrupt is then not
   longer handle_edge_irq() as it should not issue the ack() again.

   From a correctness POV vs. interrupt handling of a edge type
   interrupt, that's perfectly fine.

#2 Trivial enough to solve by flushing and invalidating the irq_work
   before shutdown/removal.

#3 That might be an issue for some extreme scenarios, but in the general
   case I claim, that it does not matter at all.

   Those scenarios where it really matters can affine the interrupt to
   the affinity of the demultiplexing interrupt, which leads to #4

#4 That's a trivial problem to solve. There is absolutely no technical
   reason to make them hidden. Demultiplexing just works fine from the
   context of regular interrupts.

There are some other minor issues like CPU hotplug, but I can't see
anything truly complex in this design right now. Famous last words :)

At the driver level this becomes really simple. Affinity changes are
just selecting a target CPU and store it for trivial comparison to avoid
a CPU mask check in the demultiplex path. No fiddling with sibling
or parent interrupts, no locking issues. Thread affinity and other
things just work as expected.

I'm really tempted to play with that. Such infrastructure would allow to
support PCI/multi-MSI on x86 without interrupt remapping, which is on
the wishlist of a lot of people for many years.

Thanks,

        tglx

