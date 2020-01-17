Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC17140CAF
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2020 15:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgAQOin (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jan 2020 09:38:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56418 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgAQOin (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jan 2020 09:38:43 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1isSlh-0001yv-3c; Fri, 17 Jan 2020 15:38:37 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 897E5100C19; Fri, 17 Jan 2020 15:38:36 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ramon Fried <rfried.dev@gmail.com>
Cc:     hkallweit1@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
        maz@kernel.org, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: MSI irqchip configured as IRQCHIP_ONESHOT_SAFE causes spurious IRQs
In-Reply-To: <CAGi-RUJtqdLtFBVMxL8TOQ3LGRqqrV4Ge7Fu9mTyDoQVYxtA5g@mail.gmail.com>
References: <CAGi-RUJvqJoCXWN2YugRn=WYEk9yzt7m3OPfX_o++PmJWQ3woQ@mail.gmail.com> <87wo9ub5f6.fsf@nanos.tec.linutronix.de> <CAGi-RUK_TA+WWvXJSrsa=_Pwq0pV1ffUKOCBu5c1t8O5Xs+UJg@mail.gmail.com> <CAGi-RUJG=SB7az5FFVTzzgefn_VXUbyQX1dtBN+9gkR7MgyC6g@mail.gmail.com> <87imldbqe3.fsf@nanos.tec.linutronix.de> <CAGi-RULNwpiNGYALYRG84SOUzkvNTbgctmXoS=Luh29xDHJzYw@mail.gmail.com> <87v9pcw55q.fsf@nanos.tec.linutronix.de> <CAGi-RUJPJ59AMZp3Wap=9zSWLmQSXVDtkbD+O6Hofizf8JWyRg@mail.gmail.com> <87pnfjwxtx.fsf@nanos.tec.linutronix.de> <CAGi-RUJtqdLtFBVMxL8TOQ3LGRqqrV4Ge7Fu9mTyDoQVYxtA5g@mail.gmail.com>
Date:   Fri, 17 Jan 2020 15:38:36 +0100
Message-ID: <87zhem172r.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ramon,

Ramon Fried <rfried.dev@gmail.com> writes:
>> So from a software perspective you want to do something like this:
>>
>> gic_irq_handler()
>> {
>>    mask_ack(gic_irqX);
>>
>>    pending = read(msi_status);
>>    for_each_bit(bit, pending) {
>>        ack(msi_status, bit);  // This clears the latch in the MSI block
>>        handle_irq(irqof(bit));
>>    }
>>    unmask(gic_irqX);
>> }
>>
>> And that works perfectly correct without masking the MSI interrupt at
>> the PCI level for a threaded handler simply because the PCI device
>> will not send another interrupt until the previous one has been
>> handled by the driver unless the PCI device is broken.
>
> I'm missing something here, isn't this implementation blocks IRQ's only during
> the HW handler and not during the threaded handler ? (Assuming that I selected
> handle_level_irq() as the default handler)

handle_level_irq() is the proper handler for the actual GIC interrupt
which does the demultiplexing. The MSI interrupts want to have
handle_edge_irq().

> Actually my implementation current implementation is very similar to what
> you just described:
>
> static void eq_msi_isr(struct irq_desc *desc)
> {
>         struct irq_chip *chip = irq_desc_get_chip(desc);
>         struct eq_msi *msi;
>         u16 status;
>         unsigned long bitmap;
>         u32 bit;
>         u32 virq;
>
>         chained_irq_enter(chip, desc);
>         msi = irq_desc_get_handler_data(desc);
>
>         while ((status = readw(msi->gcsr_regs_base + LINK_GCSR5_OFFSET)
>                 & MSI_IRQ_REQ) != 0) {
>                 pr_debug("MSI: %x\n", status >> 12);
>
>                 bitmap = status >> 12;
>                 for_each_set_bit(bit, &bitmap, msi->num_of_vectors) {
>                         virq = irq_find_mapping(msi->inner_domain, bit);
>                         if (virq) {
>                                 generic_handle_irq(virq);
>                         } else {
>                                 pr_err("unexpected MSI\n");
>                                 handle_bad_irq(desc);

Now if you look at the example I gave you there is a subtle difference:

>>    pending = read(msi_status);
>>    for_each_bit(bit, pending) {
>>        ack(msi_status, bit);  // This clears the latch in the MSI block
>>        handle_irq(irqof(bit));
>>    }

And this clearing is important when one of the MSI interrupts is
actually having a threaded handler.

 MSI interrupt fires
  -> sets bit in msi_status
    -> MSI block raises GIC interrupt because msi_status != 0

 CPU handles GIC interrupt
   pending = read(msi_status);
   for_each_bit(bit, pending)
      handle_irq()
        primary_handler()
           -> WAKEUP_THREAD

   RETI, but msi_status is still != 0

> Additionally the domain allocation is defined like:
> static int eq_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>                                  unsigned int nr_irqs, void *args)
> {
>         struct eq_msi *msi = domain->host_data;
>         unsigned long bit;
>         u32 mask;
>
>         /* We only allow 32 MSI per device */
>         WARN_ON(nr_irqs > 32);
>         if (nr_irqs > 32)
>                 return -ENOSPC;
>
>         bit = find_first_zero_bit(msi->used, msi->num_of_vectors);
>         if (bit >= msi->num_of_vectors)
>                 return -ENOSPC;
>
>         set_bit(bit, msi->used);
>
>         mask = readw(msi->gcsr_regs_base + LINK_GCSR6_OFFSET);
>         mask |= BIT(bit) << 12;
>         writew(mask, msi->gcsr_regs_base + LINK_GCSR6_OFFSET);
>
>         irq_domain_set_info(domain, virq, bit, &eq_msi_bottom_irq_chip,
>                             domain->host_data, handle_level_irq,

This is wrong. MSI is edge type, not level and you are really mixing up
the concepts here.

The fact that the MSI block raises a level interrupt on the output side
has absolutely nothing to do with the type of the MSI interrupt itself.

MSI is edge type by definition and this does not change just because
there is a translation unit between the MSI interrupt and the CPU
controller.

The actual MSI interrupts do not even know about the existance of that
MSI block at all. They do not care, as all they need to know is a
message and an address. When an interrupt is raised in the device the
MSI chip associated to the device (PCI or something else) writes this
message to the address exactly ONCE. And this exactly ONCE defines the
edge nature of MSI.

A proper designed MSI device should not send another message before the
interrupt handler which is associated to the device has handled the
interrupt at the device level.

So you really have to understand that the GIC interrupt and the MSI
interrupts are two different entities. They just have a 'connection'
because the message/address which is handed to the MSI device triggers
that GIC interrupt via the MSI translation unit. But they are still
different and independent entities.

See?

Thanks,

        tglx


        



