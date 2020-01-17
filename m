Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7679140E0D
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2020 16:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAQPnV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jan 2020 10:43:21 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38911 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgAQPnV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jan 2020 10:43:21 -0500
Received: by mail-oi1-f195.google.com with SMTP id l9so22531826oii.5;
        Fri, 17 Jan 2020 07:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3f+W4Xvm6P1QHWnul/IjVaVbxVFaJSRxnQJCYSx9gEI=;
        b=LOIu42vhUzF9Mu+lfoPqpOM9rxI1BC0+cdUy0nL1Gb7u3qDzLDNkVue67qKqOoK+PQ
         Zn0Z3eCYKz+sKmY1O6Mn+WxgRGFX72kZoLjIe+w86hCt3HGdyJq31rZsIXKh48QL3EdQ
         rU+KJKKMm1WS8V4qptEUaxHH1wFPLxl1H2HGSac240BD+K5g8YYI9TubdoT/efcMF6vt
         kf1pL7QgoR7QjzeHho5AWwkXQumqELeFZjbyqV0pGMF5IGIMHm4pEJhR+evgK94fj+4q
         k+FUfh61EvtqNxZiiT3x3akhV3X+lmzmWeU2tYIavKm5Ze/oHBk/AhtjmFCyAeTOwvB9
         5NFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3f+W4Xvm6P1QHWnul/IjVaVbxVFaJSRxnQJCYSx9gEI=;
        b=YLMnjYvvtd+vTQXshfiz5pYqMRuAP46rmx4N5+rhU0Y4dEIZ0ybJOrBsXloUqpa3r1
         If6ozni9c9q3A3tXj+K/TraxCXcc2//TbGPNNnL8Lyuo5UdY7hsvXjSzOq0EzawzQMyn
         NpCFCYswS+4xmwHC9wYCB4fncCGt4EW31hdIM4IfSeCDWU/6rkdhHVX0Qxr/hTzPdKMR
         0sbZ6iFwK0NVb3aSTZH5NnLL4xOfBJYRe236nmOKDcx0cUvJ513pAuCA6OTuoCnmGeWp
         1oFkV3hZhjp4rEn5s4uFhPmnx8c3LrnLvINyyCGX5q1yoO5Ue09FgVOeZt1FBkJF+JlD
         XYMQ==
X-Gm-Message-State: APjAAAV8KEdiYNbNBONlrj+GxCR3Yc/CXUm3/qH8n5VO6B8ckxeDGVOd
        2Cyh6NhDIgo7J3R2cv6O81H8D+1oPvx1s0dv6ZI=
X-Google-Smtp-Source: APXvYqwQX6C67Z5k/Olz9ErSM0kNCQ/PtxFi1i1R+R/MleSFSQsUjHJQx0I1YtYGt5q3PkOX37rRHIstPathPjducks=
X-Received: by 2002:a05:6808:24e:: with SMTP id m14mr3934910oie.168.1579275800172;
 Fri, 17 Jan 2020 07:43:20 -0800 (PST)
MIME-Version: 1.0
References: <CAGi-RUJvqJoCXWN2YugRn=WYEk9yzt7m3OPfX_o++PmJWQ3woQ@mail.gmail.com>
 <87wo9ub5f6.fsf@nanos.tec.linutronix.de> <CAGi-RUK_TA+WWvXJSrsa=_Pwq0pV1ffUKOCBu5c1t8O5Xs+UJg@mail.gmail.com>
 <CAGi-RUJG=SB7az5FFVTzzgefn_VXUbyQX1dtBN+9gkR7MgyC6g@mail.gmail.com>
 <87imldbqe3.fsf@nanos.tec.linutronix.de> <CAGi-RULNwpiNGYALYRG84SOUzkvNTbgctmXoS=Luh29xDHJzYw@mail.gmail.com>
 <87v9pcw55q.fsf@nanos.tec.linutronix.de> <CAGi-RUJPJ59AMZp3Wap=9zSWLmQSXVDtkbD+O6Hofizf8JWyRg@mail.gmail.com>
 <87pnfjwxtx.fsf@nanos.tec.linutronix.de> <CAGi-RUJtqdLtFBVMxL8TOQ3LGRqqrV4Ge7Fu9mTyDoQVYxtA5g@mail.gmail.com>
 <87zhem172r.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87zhem172r.fsf@nanos.tec.linutronix.de>
From:   Ramon Fried <rfried.dev@gmail.com>
Date:   Fri, 17 Jan 2020 17:43:08 +0200
Message-ID: <CAGi-RUJkr0gPbynYe+Gkk-JoeyCHdSvd9zdgCv4Hij5vfGVMEA@mail.gmail.com>
Subject: Re: MSI irqchip configured as IRQCHIP_ONESHOT_SAFE causes spurious IRQs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     hkallweit1@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
        maz@kernel.org, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 17, 2020 at 4:38 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Ramon,
>
> Ramon Fried <rfried.dev@gmail.com> writes:
> >> So from a software perspective you want to do something like this:
> >>
> >> gic_irq_handler()
> >> {
> >>    mask_ack(gic_irqX);
> >>
> >>    pending = read(msi_status);
> >>    for_each_bit(bit, pending) {
> >>        ack(msi_status, bit);  // This clears the latch in the MSI block
> >>        handle_irq(irqof(bit));
> >>    }
> >>    unmask(gic_irqX);
> >> }
> >>
> >> And that works perfectly correct without masking the MSI interrupt at
> >> the PCI level for a threaded handler simply because the PCI device
> >> will not send another interrupt until the previous one has been
> >> handled by the driver unless the PCI device is broken.
> >
> > I'm missing something here, isn't this implementation blocks IRQ's only during
> > the HW handler and not during the threaded handler ? (Assuming that I selected
> > handle_level_irq() as the default handler)
>
> handle_level_irq() is the proper handler for the actual GIC interrupt
> which does the demultiplexing. The MSI interrupts want to have
> handle_edge_irq().
>
> > Actually my implementation current implementation is very similar to what
> > you just described:
> >
> > static void eq_msi_isr(struct irq_desc *desc)
> > {
> >         struct irq_chip *chip = irq_desc_get_chip(desc);
> >         struct eq_msi *msi;
> >         u16 status;
> >         unsigned long bitmap;
> >         u32 bit;
> >         u32 virq;
> >
> >         chained_irq_enter(chip, desc);
> >         msi = irq_desc_get_handler_data(desc);
> >
> >         while ((status = readw(msi->gcsr_regs_base + LINK_GCSR5_OFFSET)
> >                 & MSI_IRQ_REQ) != 0) {
> >                 pr_debug("MSI: %x\n", status >> 12);
> >
> >                 bitmap = status >> 12;
> >                 for_each_set_bit(bit, &bitmap, msi->num_of_vectors) {
> >                         virq = irq_find_mapping(msi->inner_domain, bit);
> >                         if (virq) {
> >                                 generic_handle_irq(virq);
> >                         } else {
> >                                 pr_err("unexpected MSI\n");
> >                                 handle_bad_irq(desc);
>
> Now if you look at the example I gave you there is a subtle difference:
>
> >>    pending = read(msi_status);
> >>    for_each_bit(bit, pending) {
> >>        ack(msi_status, bit);  // This clears the latch in the MSI block
> >>        handle_irq(irqof(bit));
> >>    }
>
> And this clearing is important when one of the MSI interrupts is
> actually having a threaded handler.
>
>  MSI interrupt fires
>   -> sets bit in msi_status
>     -> MSI block raises GIC interrupt because msi_status != 0
>
>  CPU handles GIC interrupt
>    pending = read(msi_status);
>    for_each_bit(bit, pending)
>       handle_irq()
>         primary_handler()
>            -> WAKEUP_THREAD
>
>    RETI, but msi_status is still != 0
>
> > Additionally the domain allocation is defined like:
> > static int eq_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> >                                  unsigned int nr_irqs, void *args)
> > {
> >         struct eq_msi *msi = domain->host_data;
> >         unsigned long bit;
> >         u32 mask;
> >
> >         /* We only allow 32 MSI per device */
> >         WARN_ON(nr_irqs > 32);
> >         if (nr_irqs > 32)
> >                 return -ENOSPC;
> >
> >         bit = find_first_zero_bit(msi->used, msi->num_of_vectors);
> >         if (bit >= msi->num_of_vectors)
> >                 return -ENOSPC;
> >
> >         set_bit(bit, msi->used);
> >
> >         mask = readw(msi->gcsr_regs_base + LINK_GCSR6_OFFSET);
> >         mask |= BIT(bit) << 12;
> >         writew(mask, msi->gcsr_regs_base + LINK_GCSR6_OFFSET);
> >
> >         irq_domain_set_info(domain, virq, bit, &eq_msi_bottom_irq_chip,
> >                             domain->host_data, handle_level_irq,
>
> This is wrong. MSI is edge type, not level and you are really mixing up
> the concepts here.
>
> The fact that the MSI block raises a level interrupt on the output side
> has absolutely nothing to do with the type of the MSI interrupt itself.
>
> MSI is edge type by definition and this does not change just because
> there is a translation unit between the MSI interrupt and the CPU
> controller.
>
> The actual MSI interrupts do not even know about the existance of that
> MSI block at all. They do not care, as all they need to know is a
> message and an address. When an interrupt is raised in the device the
> MSI chip associated to the device (PCI or something else) writes this
> message to the address exactly ONCE. And this exactly ONCE defines the
> edge nature of MSI.
OK, now I understand my mistake. thanks.
>
> A proper designed MSI device should not send another message before the
> interrupt handler which is associated to the device has handled the
> interrupt at the device level.
By "MSI device" you mean the MSI controller in the SOC or the endpoint
that sends the MSI ?
>
> So you really have to understand that the GIC interrupt and the MSI
> interrupts are two different entities. They just have a 'connection'
> because the message/address which is handed to the MSI device triggers
> that GIC interrupt via the MSI translation unit. But they are still
> different and independent entities.
>
> See?
>
> Thanks,
>
>         tglx
>
>
>
>
>
>
