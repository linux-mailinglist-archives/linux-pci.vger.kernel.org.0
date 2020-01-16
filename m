Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE9A913D57B
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2020 09:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgAPH6n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jan 2020 02:58:43 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37479 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgAPH6m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jan 2020 02:58:42 -0500
Received: by mail-oi1-f195.google.com with SMTP id z64so18140812oia.4;
        Wed, 15 Jan 2020 23:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rgj+Y1rsxGjZh6gqo4IuShHKP6PJbxbrjY1J1YHcwwc=;
        b=lgSJPrUpk/tjl8R3Oz+8ILO6ZGinhJPSP4l2sZEzZvSXl6x2zCIV6AV5i7wAV4XZGI
         vSC5cY8NwhrjdzedYrBJJRKwG3T3/cE+Y0GHcJnOCmEetSey6NavjwPeBzdJwpxvB+jW
         eNtKFWwA6VW/dTxRoAn6xxBUJa1xYA6tEdZFRg1aikKuugAZEQoBUTP7itk/9DCeeMnh
         vSyDjzm8HU0luyafUuWoSmFZeWjDAqOQmkOLszXprPL89Q6dY9nCAOO3DQo328BEHP0L
         kY/UfuGoxL1Df6VQ8iQeUqUNXAnTZxCi6/3l9KfQQjeAV785rI5VuCEsFy9Pn8WbLtF7
         uZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rgj+Y1rsxGjZh6gqo4IuShHKP6PJbxbrjY1J1YHcwwc=;
        b=EsYBH+G9YAT5VOhJ+hTykfQBRYEwaSvHEiIhuPswbYvb9i1nffYmwSLC0XcwIy3W0v
         dWgmb2A5UZIoF/aynQBubujFtPhAZsHIiF2nHpzhRqwZFFaajvnvt+PMWnbBYRYi3pCB
         fjUsyXzZ2V/G4qyLPVOSNQ+TUgPg6uA9GzSV5gt47lq0aepNmwV5KeLf/HFyEsEI4VQd
         VSzQ9BXBCJx1RC57TZe9nKKdTSP2gh65TRBzahVJ3VWCF4eaGTIAwnA5tvyCOoK6pv28
         c8RfBx58pCmnle7zHVPRq+cKM8RJNqOb+SforScs/onIFIB+cCvBaYFUKSl+jqZSISca
         8ATQ==
X-Gm-Message-State: APjAAAUx+/ihDaMsyjuxQjkoICyssLJ230H/rdLrY+Hfq3A+QqgtM77r
        L1G99byFFubwe11D8vvwoUINmh4vCuq+J9m9rqoJ5AQE
X-Google-Smtp-Source: APXvYqzSiIhhsgd6wNOsNs9/blN7CIG9UHNUkqw3IsndMnW3rkviVjnD3kyXlH2gWL1mLSlvp4zHXPUwokF4hW9yqSY=
X-Received: by 2002:aca:b286:: with SMTP id b128mr3223299oif.147.1579161521647;
 Wed, 15 Jan 2020 23:58:41 -0800 (PST)
MIME-Version: 1.0
References: <CAGi-RUJvqJoCXWN2YugRn=WYEk9yzt7m3OPfX_o++PmJWQ3woQ@mail.gmail.com>
 <87wo9ub5f6.fsf@nanos.tec.linutronix.de> <CAGi-RUK_TA+WWvXJSrsa=_Pwq0pV1ffUKOCBu5c1t8O5Xs+UJg@mail.gmail.com>
 <CAGi-RUJG=SB7az5FFVTzzgefn_VXUbyQX1dtBN+9gkR7MgyC6g@mail.gmail.com>
 <87imldbqe3.fsf@nanos.tec.linutronix.de> <CAGi-RULNwpiNGYALYRG84SOUzkvNTbgctmXoS=Luh29xDHJzYw@mail.gmail.com>
 <87v9pcw55q.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87v9pcw55q.fsf@nanos.tec.linutronix.de>
From:   Ramon Fried <rfried.dev@gmail.com>
Date:   Thu, 16 Jan 2020 09:58:29 +0200
Message-ID: <CAGi-RUJPJ59AMZp3Wap=9zSWLmQSXVDtkbD+O6Hofizf8JWyRg@mail.gmail.com>
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

On Thu, Jan 16, 2020 at 3:39 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Ramon,
>
> Ramon Fried <rfried.dev@gmail.com> writes:
> > On Wed, Jan 15, 2020 at 12:54 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> Ramon Fried <rfried.dev@gmail.com> writes:
> >> Due to the semantics of MSI this is perfectly fine and aside of your
> >> problem this has worked perfectly fine so far and it's an actual
> >> performance win because it avoid fiddling with the MSI mask which is
> >> slow.
> >>
> > fiddling with MSI masks is a configuration space write, which is
> > non-posted, so it does come with a price.
> > The question is if a test was ever conducted to see the it's better
> > than spurious IRQ's.
>
> The point is that there are no spurious interrupts in the sane cases and
> the tests we did showed a real performance improvements in high
> frequency interrupt situations due to avoiding the config space access.
>
> Please stop claiming that this spurious interrupt problem is there by
> design. It's not. Read the MSI spec.
>
> Also boot your laptop/workstation with 'threadirqs' on the kernel
> command line and check how many spurious interrupts come in. On a test
> machine which has that command line parameter set I see exactly ONE with
> an uptime of several days and heavy MSI interrupt activity. The ONE is
> even there without 'threadirqs' on the command line, so I really can't
> be bothered to analyze that.
>
> >> You still have not told which driver/hardware is affected by this. Can
> >> you please provide that information so we can finally look at the actual
> >> hardware/driver combo?
> >>
> > Sure,
> > I'm writing an MSI IRQ controller, it's basically a MIPS GIC interrupt
> > line which several MSI are multiplexed on it.
>
> I assume you write the driver, not the VHDL for the actual hardware,
> right? If so, you still did not tell which hardware that is and where we
> can find information about it.
There's no official information I can share but I can explain how it works:
Basically, 32 MSI vectors are represented by a single GIC irq.
There's a status registers which every bit correspond to an MSI vector, and
individual MSI needs to be acked on that registers. in any case where
there's asserted bit
the GIC IRQ level is high.

>
> I further assume that 'multiplexed' means that the hardware is something
> like an MSI receiver on the CPU/chipset which handles multiple MSI
> messages and forwards them to a single shared interrupt line on the MIPS
> GIC. Right?
Yes.
>
> Can you please provide a pointer to the hardware documentation?
There's no official documentation for that.
>
> > It's configured with handle_level_irq() as the GIC is level IRQ.
>
> Which is completely bonkers. MSI has edge semantics and sharing an
> interrupt line for edge type interrupts is broken by design, unless the
> hardware which handles the incoming MSIs and forwards them to the level
> type interrupt line is designed properly and the driver does the right
> thing.
Yes, the design of the HW is sort of broken. I concur.
>
> > The ack callback acks the GIC irq.  the mask/unmask calls
> > pci_msi_mask_irq() / pci_msi_unmask_irq()
>
> What? How is that supposed to work with multiple MSIs?
Acking is per MSI vector as I described above, so it should work.
>
> Either the hardware is a trainwreck or the driver or both.
>
> I can't tell as I can't find my crystal ball. Maybe I should replace it
> with an Mobileye :)
:)
>
> Thanks,
>
>         tglx
