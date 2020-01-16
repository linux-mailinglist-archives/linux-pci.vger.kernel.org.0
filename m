Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC23A13D19D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2020 02:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgAPBjw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 20:39:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49795 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgAPBjw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2020 20:39:52 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iru8P-0004zY-Tg; Thu, 16 Jan 2020 02:39:46 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 3CF6710121C; Thu, 16 Jan 2020 02:39:45 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ramon Fried <rfried.dev@gmail.com>
Cc:     hkallweit1@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
        maz@kernel.org, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org
Subject: Re: MSI irqchip configured as IRQCHIP_ONESHOT_SAFE causes spurious IRQs
In-Reply-To: <CAGi-RULNwpiNGYALYRG84SOUzkvNTbgctmXoS=Luh29xDHJzYw@mail.gmail.com>
References: <CAGi-RUJvqJoCXWN2YugRn=WYEk9yzt7m3OPfX_o++PmJWQ3woQ@mail.gmail.com> <87wo9ub5f6.fsf@nanos.tec.linutronix.de> <CAGi-RUK_TA+WWvXJSrsa=_Pwq0pV1ffUKOCBu5c1t8O5Xs+UJg@mail.gmail.com> <CAGi-RUJG=SB7az5FFVTzzgefn_VXUbyQX1dtBN+9gkR7MgyC6g@mail.gmail.com> <87imldbqe3.fsf@nanos.tec.linutronix.de> <CAGi-RULNwpiNGYALYRG84SOUzkvNTbgctmXoS=Luh29xDHJzYw@mail.gmail.com>
Date:   Thu, 16 Jan 2020 02:39:45 +0100
Message-ID: <87v9pcw55q.fsf@nanos.tec.linutronix.de>
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
> On Wed, Jan 15, 2020 at 12:54 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> Ramon Fried <rfried.dev@gmail.com> writes:
>> Due to the semantics of MSI this is perfectly fine and aside of your
>> problem this has worked perfectly fine so far and it's an actual
>> performance win because it avoid fiddling with the MSI mask which is
>> slow.
>>
> fiddling with MSI masks is a configuration space write, which is
> non-posted, so it does come with a price.
> The question is if a test was ever conducted to see the it's better
> than spurious IRQ's.

The point is that there are no spurious interrupts in the sane cases and
the tests we did showed a real performance improvements in high
frequency interrupt situations due to avoiding the config space access.

Please stop claiming that this spurious interrupt problem is there by
design. It's not. Read the MSI spec.

Also boot your laptop/workstation with 'threadirqs' on the kernel
command line and check how many spurious interrupts come in. On a test
machine which has that command line parameter set I see exactly ONE with
an uptime of several days and heavy MSI interrupt activity. The ONE is
even there without 'threadirqs' on the command line, so I really can't
be bothered to analyze that.

>> You still have not told which driver/hardware is affected by this. Can
>> you please provide that information so we can finally look at the actual
>> hardware/driver combo?
>>
> Sure,
> I'm writing an MSI IRQ controller, it's basically a MIPS GIC interrupt
> line which several MSI are multiplexed on it.

I assume you write the driver, not the VHDL for the actual hardware,
right? If so, you still did not tell which hardware that is and where we
can find information about it.

I further assume that 'multiplexed' means that the hardware is something
like an MSI receiver on the CPU/chipset which handles multiple MSI
messages and forwards them to a single shared interrupt line on the MIPS
GIC. Right?

Can you please provide a pointer to the hardware documentation?

> It's configured with handle_level_irq() as the GIC is level IRQ.

Which is completely bonkers. MSI has edge semantics and sharing an
interrupt line for edge type interrupts is broken by design, unless the
hardware which handles the incoming MSIs and forwards them to the level
type interrupt line is designed properly and the driver does the right
thing.

> The ack callback acks the GIC irq.  the mask/unmask calls
> pci_msi_mask_irq() / pci_msi_unmask_irq()

What? How is that supposed to work with multiple MSIs?

Either the hardware is a trainwreck or the driver or both.

I can't tell as I can't find my crystal ball. Maybe I should replace it
with an Mobileye :)

Thanks,

        tglx
