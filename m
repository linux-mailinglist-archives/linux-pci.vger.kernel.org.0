Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC7E3780B7
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 11:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhEJKAZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 06:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230319AbhEJKAU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 May 2021 06:00:20 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECFE0610CC;
        Mon, 10 May 2021 09:59:14 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1lg2gx-000LZK-SC; Mon, 10 May 2021 10:59:12 +0100
Date:   Mon, 10 May 2021 10:59:11 +0100
Message-ID: <87y2cmoqog.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        kvm@vger.kernel.org, linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Nianyao Tang <tangnianyao@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Question on guest enable msi fail when using GICv4/4.1
In-Reply-To: <69cd5989-f4cb-469c-f6a0-3362540e0271@redhat.com>
References: <3a2c66d6-6ca0-8478-d24b-61e8e3241b20@hisilicon.com>
        <87k0oaq5jf.wl-maz@kernel.org>
        <cf870bcf-1173-a70b-2b55-4209abcbcbc3@hisilicon.com>
        <878s4qq00u.wl-maz@kernel.org>
        <d6481eee-4318-1a56-a5a4-daf467070d22@redhat.com>
        <871rafowp2.wl-maz@kernel.org>
        <69cd5989-f4cb-469c-f6a0-3362540e0271@redhat.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: eric.auger@redhat.com, zhangshaokun@hisilicon.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org, alex.williamson@redhat.com, cohuck@redhat.com, tangnianyao@huawei.com, bhelgaas@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 10 May 2021 09:29:47 +0100,
Auger Eric <eric.auger@redhat.com> wrote:
> 
> Hi Marc,
> 
> On 5/10/21 9:49 AM, Marc Zyngier wrote:
> > Hi Eric,
> > 
> > On Sun, 09 May 2021 18:00:04 +0100,
> > Auger Eric <eric.auger@redhat.com> wrote:
> >>
> >> Hi,
> >> On 5/7/21 1:02 PM, Marc Zyngier wrote:
> >>> On Fri, 07 May 2021 10:58:23 +0100,
> >>> Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:
> >>>>
> >>>> Hi Marc,
> >>>>
> >>>> Thanks for your quick reply.
> >>>>
> >>>> On 2021/5/7 17:03, Marc Zyngier wrote:
> >>>>> On Fri, 07 May 2021 06:57:04 +0100,
> >>>>> Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:
> >>>>>>
> >>>>>> [This letter comes from Nianyao Tang]
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> Using GICv4/4.1 and msi capability, guest vf driver requires 3
> >>>>>> vectors and enable msi, will lead to guest stuck.
> >>>>>
> >>>>> Stuck how?
> >>>>
> >>>> Guest serial does not response anymore and guest network shutdown.
> >>>>
> >>>>>
> >>>>>> Qemu gets number of interrupts from Multiple Message Capable field
> >>>>>> set by guest. This field is aligned to a power of 2(if a function
> >>>>>> requires 3 vectors, it initializes it to 2).
> >>>>>
> >>>>> So I guess this is a MultiMSI device with 4 vectors, right?
> >>>>>
> >>>>
> >>>> Yes, it can support maximum of 32 msi interrupts, and vf driver only use 3 msi.
> >>>>
> >>>>>> However, guest driver just sends 3 mapi-cmd to vits and 3 ite
> >>>>>> entries is recorded in host.  Vfio initializes msi interrupts using
> >>>>>> the number of interrupts 4 provide by qemu.  When it comes to the
> >>>>>> 4th msi without ite in vits, in irq_bypass_register_producer,
> >>>>>> producer and consumer will __connect fail, due to find_ite fail, and
> >>>>>> do not resume guest.
> >>>>>
> >>>>> Let me rephrase this to check that I understand it:
> >>>>> - The device has 4 vectors
> >>>>> - The guest only create mappings for 3 of them
> >>>>> - VFIO calls kvm_vgic_v4_set_forwarding() for each vector
> >>>>> - KVM doesn't have a mapping for the 4th vector and returns an error
> >>>>> - VFIO disable this 4th vector
> >>>>>
> >>>>> Is that correct? If yes, I don't understand why that impacts the guest
> >>>>> at all. From what I can see, vfio_msi_set_vector_signal() just prints
> >>>>> a message on the console and carries on.
> >>>>>
> >>>>
> >>>> function calls:
> >>>> --> vfio_msi_set_vector_signal
> >>>>    --> irq_bypass_register_producer
> >>>>       -->__connect
> >>>>
> >>>> in __connect, add_producer finally calls kvm_vgic_v4_set_forwarding
> >>>> and fails to get the 4th mapping. When add_producer fail, it does
> >>>> not call cons->start, calls kvm_arch_irq_bypass_start and then
> >>>> kvm_arm_resume_guest.
> >>>
> >>> [+Eric, who wrote the irq_bypass infrastructure.]
> >>>
> >>> Ah, so the guest is actually paused, not in a livelock situation
> >>> (which is how I interpreted "stuck").
> >>>
> >>> I think we should handle this case gracefully, as there should be no
> >>> expectation that the guest will be using this interrupt. Given that
> >>> VFIO seems to be pretty unfazed when a producer fails, I'm temped to
> >>> do the same thing and restart the guest.
> >>>
> >>> Also, __disconnect doesn't care about errors, so why should __connect
> >>> have this odd behaviour?
> >>
> >> _disconnect() does not care as we should always succeed tearing off
> >> things. del_* ops are void functions. On the opposite we can fail
> >> setting up the bypass.
> >>
> >> Effectively
> >> a979a6aa009f ("irqbypass: do not start cons/prod when failed connect")
> >> needs to be reverted.
> >>
> >> I agree the kerneldoc comments in linux/irqbypass.h may be improved to
> >> better explain the role of stop/start cbs and warn about their potential
> >> global impact.
> > 
> > Yup. It also begs the question of why we have producer callbacks, as
> > nobody seems to use them.
> 
> At the time this was designed, I was working on VFIO platform IRQ
> forwarding using direct EOI and they were used (and useful)
> 
> +	irq->producer.stop = vfio_platform_irq_bypass_stop;
> +	irq->producer.start = vfio_platform_irq_bypass_start;
> 
> [PATCH v4 02/13] VFIO: platform: registration of a dummy IRQ bypass producer
> [PATCH v4 07/13] VFIO: platform: add irq bypass producer management
> https://lists.cs.columbia.edu/pipermail/kvmarm/2015-November/017323.html
> 
> basically the IRQ was disabled and re-enabled. This series has never
> been upstreamed but that's where it originates from.

Ah, I remember those. Something tells me we are eventually going to
need something like that with pKVM (unfortunately, PCI isn't that
popular on Android phones...).

> >> wrt the case above, "in __connect, add_producer finally calls
> >> kvm_vgic_v4_set_forwarding and fails to get the 4th mapping", shouldn't
> >> we succeed in that case?
> > 
> > From a KVM perspective, we can't return a success because there is no
> > guest LPI that matches the input signal.
> right, sorry I had in mind the set_forwarding was partially successful
> for 3 of 4 LPIs but it is a unitary operation.
> > 
> > And such failure seems to be expected by the VFIO code, which just
> > prints a message on the console and set the producer token to NULL. So
> > returning an error from the KVM code is useful, at least to an extent.
> 
> OK. So with the revert, the use case resume working, right?

Yes, Shaokun confirmed he was back in business.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
