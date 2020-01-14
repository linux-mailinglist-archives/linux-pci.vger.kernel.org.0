Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA7C13B587
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 23:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgANWyg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 17:54:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45340 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbgANWyg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2020 17:54:36 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irV4v-000091-V6; Tue, 14 Jan 2020 23:54:30 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id DB273101DEE; Tue, 14 Jan 2020 23:54:28 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ramon Fried <rfried.dev@gmail.com>
Cc:     hkallweit1@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
        maz@kernel.org, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: MSI irqchip configured as IRQCHIP_ONESHOT_SAFE causes spurious IRQs
In-Reply-To: <CAGi-RUJG=SB7az5FFVTzzgefn_VXUbyQX1dtBN+9gkR7MgyC6g@mail.gmail.com>
References: <CAGi-RUJvqJoCXWN2YugRn=WYEk9yzt7m3OPfX_o++PmJWQ3woQ@mail.gmail.com> <87wo9ub5f6.fsf@nanos.tec.linutronix.de> <CAGi-RUK_TA+WWvXJSrsa=_Pwq0pV1ffUKOCBu5c1t8O5Xs+UJg@mail.gmail.com> <CAGi-RUJG=SB7az5FFVTzzgefn_VXUbyQX1dtBN+9gkR7MgyC6g@mail.gmail.com>
Date:   Tue, 14 Jan 2020 23:54:28 +0100
Message-ID: <87imldbqe3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ramon Fried <rfried.dev@gmail.com> writes:
> On Tue, Jan 14, 2020 at 11:38 PM Ramon Fried <rfried.dev@gmail.com> wrote:
>> On Tue, Jan 14, 2020 at 2:15 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> > Ramon Fried <rfried.dev@gmail.com> writes:
>> > > Besides the side effect of that, I don't really understand the logic
>> > > of not masking the MSI until the threaded handler is complete,
>> > > especially when there's no HW handler and only threaded handler.
>> >
>> > What's wrong with having another interrupt firing while the threaded
>> > handler is running? Nothing, really. It actually can be desired because
>> > the threaded handler is allowed to sleep.
>> >
>> What do you mean, isn't it the purpose IRQ masking ?  Interrupt
>> coalescing is done to mitigate these IRQ's, these HW interrupts just
>> consume CPU cycles and don't do anything useful (scheduling an
>> already scheduled thread).

Again, that depends on your POV. It's a perfectly valid scenario to have
another HW irq coming in preventing the thread to go to sleep and just
run for another cycle. So no, masking is not necessarily required and
the semantics of MSI is edge type, so the hardware should not fire
another interrupt _before_ the threaded handler actually took care of
the initial one.

> Additionally, in this case there isn't even an HW IRQ handler, it's
> passed as NULL in the request IRQ function in this scenario.

This is completely irrelevant. The primary hardware IRQ handler is
provided by the core code in this case.

Due to the semantics of MSI this is perfectly fine and aside of your
problem this has worked perfectly fine so far and it's an actual
performance win because it avoid fiddling with the MSI mask which is
slow.

You still have not told which driver/hardware is affected by this. Can
you please provide that information so we can finally look at the actual
hardware/driver combo?

Either the driver is broken or the hardware does not comply with the MSI
spec.

Thanks,

        tglx
