Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00C6B13D6E7
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2020 10:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgAPJcu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jan 2020 04:32:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50957 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgAPJct (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jan 2020 04:32:49 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1is1W7-0002YM-Pv; Thu, 16 Jan 2020 10:32:44 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E3797100C1E; Thu, 16 Jan 2020 10:32:42 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ramon Fried <rfried.dev@gmail.com>
Cc:     hkallweit1@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
        maz@kernel.org, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: MSI irqchip configured as IRQCHIP_ONESHOT_SAFE causes spurious IRQs
In-Reply-To: <CAGi-RUJPJ59AMZp3Wap=9zSWLmQSXVDtkbD+O6Hofizf8JWyRg@mail.gmail.com>
References: <CAGi-RUJvqJoCXWN2YugRn=WYEk9yzt7m3OPfX_o++PmJWQ3woQ@mail.gmail.com> <87wo9ub5f6.fsf@nanos.tec.linutronix.de> <CAGi-RUK_TA+WWvXJSrsa=_Pwq0pV1ffUKOCBu5c1t8O5Xs+UJg@mail.gmail.com> <CAGi-RUJG=SB7az5FFVTzzgefn_VXUbyQX1dtBN+9gkR7MgyC6g@mail.gmail.com> <87imldbqe3.fsf@nanos.tec.linutronix.de> <CAGi-RULNwpiNGYALYRG84SOUzkvNTbgctmXoS=Luh29xDHJzYw@mail.gmail.com> <87v9pcw55q.fsf@nanos.tec.linutronix.de> <CAGi-RUJPJ59AMZp3Wap=9zSWLmQSXVDtkbD+O6Hofizf8JWyRg@mail.gmail.com>
Date:   Thu, 16 Jan 2020 10:32:42 +0100
Message-ID: <87pnfjwxtx.fsf@nanos.tec.linutronix.de>
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
> On Thu, Jan 16, 2020 at 3:39 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> Ramon Fried <rfried.dev@gmail.com> writes:
>
> Basically, 32 MSI vectors are represented by a single GIC irq.
> There's a status registers which every bit correspond to an MSI vector, and
> individual MSI needs to be acked on that registers. in any case where
> there's asserted bit the GIC IRQ level is high.

Which is not that bad. 

>> > It's configured with handle_level_irq() as the GIC is level IRQ.
>>
>> Which is completely bonkers. MSI has edge semantics and sharing an
>> interrupt line for edge type interrupts is broken by design, unless the
>> hardware which handles the incoming MSIs and forwards them to the level
>> type interrupt line is designed properly and the driver does the right
>> thing.
>
> Yes, the design of the HW is sort of broken. I concur.

As you describe it, it's not that bad.

>> > The ack callback acks the GIC irq.  the mask/unmask calls
>> > pci_msi_mask_irq() / pci_msi_unmask_irq()
>>
>> What? How is that supposed to work with multiple MSIs?
> Acking is per MSI vector as I described above, so it should work.

No. This is the wrong approach. Lets look at the hardware:

| GIC   line X |------| MSI block | <--- Messages from devices

The MSI block latches the incoming message up to the point where it is
acknowledged in the MSI block. This makes sure that the level semantics
of the GIC are met.

So from a software perspective you want to do something like this:

gic_irq_handler()
{
   mask_ack(gic_irqX);

   pending = read(msi_status);
   for_each_bit(bit, pending) {
       ack(msi_status, bit);  // This clears the latch in the MSI block
       handle_irq(irqof(bit));
   }
   unmask(gic_irqX);
}

And that works perfectly correct without masking the MSI interrupt at
the PCI level for a threaded handler simply because the PCI device will
not send another interrupt until the previous one has been handled by
the driver unless the PCI device is broken.

If that's the case, then you have to work around that at the device
driver level, not at the irq chip level, by installing a primary handler
which quiesces the device (not the MSI part).

Thanks,

        tglx
