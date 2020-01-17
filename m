Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF235140ABA
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2020 14:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgAQNcT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jan 2020 08:32:19 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37157 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQNcT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jan 2020 08:32:19 -0500
Received: by mail-ot1-f65.google.com with SMTP id k14so22547253otn.4;
        Fri, 17 Jan 2020 05:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tK6yTRQuQj1ysf+qFmwzb4MAE8WBgbRY6Jdv8kjUY2Y=;
        b=maUgKAXXE+taK+/FHrWhtUoZX7XUCYsZw0K5IE8OZDGUiW/6pd15Jv2omxt3VtQyag
         iOl3zKq9lztaI9ZJv4xIe/pn0GhHDj9Dmn5NOHsLBxOpIrJb6ua4j3TZrSDMNNUefTnb
         z48nz9TzA8adjfzBmCz9aUDvE1TY9y1iMZywduQNmrVZLQO7UC/Ll0g+6wn1z0LXgQtu
         b0qIY51XVrgGj0N7WSgoiCe4FZ46tFDz0oGXClJ8qXYUI4t5hwI2bsrpfmxSi62GNMec
         mZDH+AgjAOBDw1gqyi3njlW3tgrcXP7IdXUKCGHB7BxlvCbKQDkXlNw7M53PtxVeVXVz
         Y7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tK6yTRQuQj1ysf+qFmwzb4MAE8WBgbRY6Jdv8kjUY2Y=;
        b=eCu8UnMC0PMzYXxG4B6v0WwK4qdfviyPdAdE8p5ldvG1mFHpNwcFgnyO0MhbutCKoW
         8zzU4TOh2rEkOCf7Nwx8E/NaDr2/9qyOwu+s8+YYoS2h8k74gGiEVFNpmZI8jnRsh4Vg
         WYW9XkdoyphlvaSj7a/VEYgtUaV93Yn9KXIqM2qN81++eis7st1QVXVXlYVkTLpV1njJ
         IVq+fYhGZJF+Ha8/JZ8YdOvdn9RuSRJVBxd+QrZb7SVW1k6HWh90py9WE4fL7u8pbxlf
         YpoqoBDKzvh6Sfcip+eR84ccCCRcjnCfw8TrDgn22dkM6PwbRlpUX+LK2KFZ6jyYrUGo
         uGYw==
X-Gm-Message-State: APjAAAVng/XC4Q/oK7FLl/DHLXMb4mS7cVVJCu6uwfh6Fo6cKyg75iHE
        NTcBdUW7Yng9cmUUVgCFiNI640ueYweADnHzzjU=
X-Google-Smtp-Source: APXvYqw6raVtIYUn0e2R2apGYNS0K5IlDIscXZnfcTgAW1uPVcThOhTQoqPbOF5LsgXFVoadJCwyWmJYirZWAA1hhSE=
X-Received: by 2002:a9d:5c8a:: with SMTP id a10mr5702494oti.95.1579267938333;
 Fri, 17 Jan 2020 05:32:18 -0800 (PST)
MIME-Version: 1.0
References: <CAGi-RUJvqJoCXWN2YugRn=WYEk9yzt7m3OPfX_o++PmJWQ3woQ@mail.gmail.com>
 <87wo9ub5f6.fsf@nanos.tec.linutronix.de> <CAGi-RUK_TA+WWvXJSrsa=_Pwq0pV1ffUKOCBu5c1t8O5Xs+UJg@mail.gmail.com>
 <CAGi-RUJG=SB7az5FFVTzzgefn_VXUbyQX1dtBN+9gkR7MgyC6g@mail.gmail.com>
 <87imldbqe3.fsf@nanos.tec.linutronix.de> <CAGi-RULNwpiNGYALYRG84SOUzkvNTbgctmXoS=Luh29xDHJzYw@mail.gmail.com>
 <87v9pcw55q.fsf@nanos.tec.linutronix.de> <CAGi-RUJPJ59AMZp3Wap=9zSWLmQSXVDtkbD+O6Hofizf8JWyRg@mail.gmail.com>
 <87pnfjwxtx.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87pnfjwxtx.fsf@nanos.tec.linutronix.de>
From:   Ramon Fried <rfried.dev@gmail.com>
Date:   Fri, 17 Jan 2020 15:32:07 +0200
Message-ID: <CAGi-RUJtqdLtFBVMxL8TOQ3LGRqqrV4Ge7Fu9mTyDoQVYxtA5g@mail.gmail.com>
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

Thomas,
Thanks a lot for the detailed answer.

> > Basically, 32 MSI vectors are represented by a single GIC irq.
> > There's a status registers which every bit correspond to an MSI vector, and
> > individual MSI needs to be acked on that registers. in any case where
> > there's asserted bit the GIC IRQ level is high.
>
> Which is not that bad.
>
> >> > It's configured with handle_level_irq() as the GIC is level IRQ.
> >>
> >> Which is completely bonkers. MSI has edge semantics and sharing an
> >> interrupt line for edge type interrupts is broken by design, unless the
> >> hardware which handles the incoming MSIs and forwards them to the level
> >> type interrupt line is designed properly and the driver does the right
> >> thing.
> >
> > Yes, the design of the HW is sort of broken. I concur.
>
> As you describe it, it's not that bad.
>
> >> > The ack callback acks the GIC irq.  the mask/unmask calls
> >> > pci_msi_mask_irq() / pci_msi_unmask_irq()
> >>
> >> What? How is that supposed to work with multiple MSIs?
> > Acking is per MSI vector as I described above, so it should work.
>
> No. This is the wrong approach. Lets look at the hardware:
>
> | GIC   line X |------| MSI block | <--- Messages from devices
>
> The MSI block latches the incoming message up to the point where it is
> acknowledged in the MSI block. This makes sure that the level semantics
> of the GIC are met.
>
> So from a software perspective you want to do something like this:
>
> gic_irq_handler()
> {
>    mask_ack(gic_irqX);
>
>    pending = read(msi_status);
>    for_each_bit(bit, pending) {
>        ack(msi_status, bit);  // This clears the latch in the MSI block
>        handle_irq(irqof(bit));
>    }
>    unmask(gic_irqX);
> }
>
> And that works perfectly correct without masking the MSI interrupt at
> the PCI level for a threaded handler simply because the PCI device will
> not send another interrupt until the previous one has been handled by
> the driver unless the PCI device is broken.
I'm missing something here, isn't this implementation blocks IRQ's only during
the HW handler and not during the threaded handler ? (Assuming that I selected
handle_level_irq() as the default handler)

Actually my implementation current implementation is very similar to what
you just described:

static void eq_msi_isr(struct irq_desc *desc)
{
        struct irq_chip *chip = irq_desc_get_chip(desc);
        struct eq_msi *msi;
        u16 status;
        unsigned long bitmap;
        u32 bit;
        u32 virq;

        chained_irq_enter(chip, desc);
        msi = irq_desc_get_handler_data(desc);

        while ((status = readw(msi->gcsr_regs_base + LINK_GCSR5_OFFSET)
                & MSI_IRQ_REQ) != 0) {
                pr_debug("MSI: %x\n", status >> 12);

                bitmap = status >> 12;
                for_each_set_bit(bit, &bitmap, msi->num_of_vectors) {
                        virq = irq_find_mapping(msi->inner_domain, bit);
                        if (virq) {
                                generic_handle_irq(virq);
                        } else {
                                pr_err("unexpected MSI\n");
                                handle_bad_irq(desc);
                        }
                }
        }
        chained_irq_exit(chip, desc);
}

Additionally the domain allocation is defined like:
static int eq_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
                                 unsigned int nr_irqs, void *args)
{
        struct eq_msi *msi = domain->host_data;
        unsigned long bit;
        u32 mask;

        /* We only allow 32 MSI per device */
        WARN_ON(nr_irqs > 32);
        if (nr_irqs > 32)
                return -ENOSPC;

        bit = find_first_zero_bit(msi->used, msi->num_of_vectors);
        if (bit >= msi->num_of_vectors)
                return -ENOSPC;

        set_bit(bit, msi->used);

        mask = readw(msi->gcsr_regs_base + LINK_GCSR6_OFFSET);
        mask |= BIT(bit) << 12;
        writew(mask, msi->gcsr_regs_base + LINK_GCSR6_OFFSET);

        irq_domain_set_info(domain, virq, bit, &eq_msi_bottom_irq_chip,
                            domain->host_data, handle_level_irq,
                            NULL, NULL);

        pr_debug("Enabling MSI irq: %lu\n", bit);

        return 0;
}

>
> If that's the case, then you have to work around that at the device
> driver level, not at the irq chip level, by installing a primary handler
> which quiesces the device (not the MSI part).
>
> Thanks,
>
>         tglx
