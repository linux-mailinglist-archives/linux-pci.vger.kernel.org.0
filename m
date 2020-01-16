Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D29913D102
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2020 01:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgAPATz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 19:19:55 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35042 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgAPATz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2020 19:19:55 -0500
Received: by mail-ot1-f68.google.com with SMTP id i15so17816703oto.2;
        Wed, 15 Jan 2020 16:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZU5z0jv6vLkxXNqNasAO0rHibPY0RtWLbOjVbo8j9bM=;
        b=TiyKo5kq22lrMJu+TfM0cyJlBOcyXACcTmJNkYuhgZ6+Ej74UPkEnUpcj1QtU+iMFE
         VlOLQhgiB+TqW56ap5Fng7PYwiawZMMrV/Kkgr7T82kfs77IQq6UTORND7mzW52UTH33
         G58aS2m4xyePIcAasMj7yNJopsaKoonFKtJvjYlLCjuU4PMhE90P3CDlGiCWfzfnOc+k
         xgqAINXlRj/6yCySZCHefcEy31T32+QYxDjKCNckgyq+Dv712FD9vHVXkYJIOXwF4MG/
         ZVqD63CBkiwbKDW0Qr+HzJiDsj0RUD4PGrHQY/b9t+HWteju8J7/tDsIgVAGyDw6Y0Pz
         ip6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZU5z0jv6vLkxXNqNasAO0rHibPY0RtWLbOjVbo8j9bM=;
        b=dSuGSNwbdTAQaT82t/W7v2yYnFPPDwvwIWAUqToqd1eEIQgDwnKkzI3zTw/JODKwj6
         qfIQRnpWHJIW4k0ti7Dd4+MGbtTM4ujSOa7YGpd8PaqBhjGQkNzTcqCN1V+LbE5bmLld
         wTQWX8bKlVBCf+XGY6nj6ToG3RpQKcs+v4L98xAWqKHnwM2+frbZBWrx8ChBrTY6Lakd
         J4EPrpjRgPtJWyeNLp69Auuu+wMmiZ7j1AqX7H5gQ1H6kCwD7xjmkZakBkOgKmOiXFJU
         vWwR4xlamH14+ZORFVbAxbYEbwtzSsTArTjEgbV5q05/9Et/KWccows/mmXZI9jFHhK1
         O+oQ==
X-Gm-Message-State: APjAAAUXpFjlWkoaFTPO7u6fAcah08KWjBfsnrPZrtDpwm2Vms7vuv06
        B2Q3xzS2RhEOK1PGnbYaMw3plyxv7CyObBP8COc=
X-Google-Smtp-Source: APXvYqwEp+kpYgUagYAHFYU2YX8f9iDBexiTW7nUmnFZ6PPZk5G/o3uJkrK9AOZImf30kqPO5pYY4z5BycnOYnfOpaI=
X-Received: by 2002:a9d:7090:: with SMTP id l16mr4854274otj.187.1579133994535;
 Wed, 15 Jan 2020 16:19:54 -0800 (PST)
MIME-Version: 1.0
References: <CAGi-RUJvqJoCXWN2YugRn=WYEk9yzt7m3OPfX_o++PmJWQ3woQ@mail.gmail.com>
 <87wo9ub5f6.fsf@nanos.tec.linutronix.de> <CAGi-RUK_TA+WWvXJSrsa=_Pwq0pV1ffUKOCBu5c1t8O5Xs+UJg@mail.gmail.com>
 <CAGi-RUJG=SB7az5FFVTzzgefn_VXUbyQX1dtBN+9gkR7MgyC6g@mail.gmail.com> <87imldbqe3.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87imldbqe3.fsf@nanos.tec.linutronix.de>
From:   Ramon Fried <rfried.dev@gmail.com>
Date:   Thu, 16 Jan 2020 02:19:43 +0200
Message-ID: <CAGi-RULNwpiNGYALYRG84SOUzkvNTbgctmXoS=Luh29xDHJzYw@mail.gmail.com>
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

On Wed, Jan 15, 2020 at 12:54 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Ramon Fried <rfried.dev@gmail.com> writes:
> > On Tue, Jan 14, 2020 at 11:38 PM Ramon Fried <rfried.dev@gmail.com> wrote:
> >> On Tue, Jan 14, 2020 at 2:15 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> > Ramon Fried <rfried.dev@gmail.com> writes:
> >> > > Besides the side effect of that, I don't really understand the logic
> >> > > of not masking the MSI until the threaded handler is complete,
> >> > > especially when there's no HW handler and only threaded handler.
> >> >
> >> > What's wrong with having another interrupt firing while the threaded
> >> > handler is running? Nothing, really. It actually can be desired because
> >> > the threaded handler is allowed to sleep.
> >> >
> >> What do you mean, isn't it the purpose IRQ masking ?  Interrupt
> >> coalescing is done to mitigate these IRQ's, these HW interrupts just
> >> consume CPU cycles and don't do anything useful (scheduling an
> >> already scheduled thread).
>
> Again, that depends on your POV. It's a perfectly valid scenario to have
> another HW irq coming in preventing the thread to go to sleep and just
> run for another cycle. So no, masking is not necessarily required and
> the semantics of MSI is edge type, so the hardware should not fire
> another interrupt _before_ the threaded handler actually took care of
> the initial one.
>
> > Additionally, in this case there isn't even an HW IRQ handler, it's
> > passed as NULL in the request IRQ function in this scenario.
>
> This is completely irrelevant. The primary hardware IRQ handler is
> provided by the core code in this case.
>
You're right.

> Due to the semantics of MSI this is perfectly fine and aside of your
> problem this has worked perfectly fine so far and it's an actual
> performance win because it avoid fiddling with the MSI mask which is
> slow.
>
fiddling with MSI masks is a configuration space write, which is
non-posted, so it does come with a price.
The question is if a test was ever conducted to see the it's better
than spurious IRQ's.

> You still have not told which driver/hardware is affected by this. Can
> you please provide that information so we can finally look at the actual
> hardware/driver combo?
>
Sure,
I'm writing an MSI IRQ controller, it's basically a MIPS GIC interrupt
line which several MSI are multiplexed on it.
It's configured with handle_level_irq() as the GIC is level IRQ.

The ack callback acks the GIC irq.
the mask/unmask calls pci_msi_mask_irq() / pci_msi_unmask_irq()

Thanks,
Ramon.
> Either the driver is broken or the hardware does not comply with the MSI
> spec.
>
> Thanks,
>
>         tglx
