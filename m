Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB03713B488
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 22:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgANViY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 16:38:24 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43404 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbgANViX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2020 16:38:23 -0500
Received: by mail-ot1-f67.google.com with SMTP id p8so14120680oth.10;
        Tue, 14 Jan 2020 13:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CWsnwP4GIaciUFACTvTTV9wv4l6lQ5px2rGr1iC9QYQ=;
        b=I5IqhNFAv/XIejr8sL+ZxQeuLgtDWkRE7z3Wkpi9O531Wszi1pqwwo8eQ70RarRn0K
         CYTUlqN1qXNDKtqanYseQau9icecgVJFeW8JaYXnmAv/IIHvPAsJH6Q2wOc0Rjm3IP+d
         sTKfeNnqvgOOJzo+N8QKFnEFSs0hWxzeoCsSVeYjUf5/AAsAgSXIRPH+kFWy1M+bqJ6a
         EjY5GEymiRHzdlwF0kMaVSq5syNCJGv1X4/doDjmfYEcNaTzxjgxn9wug6ynVBEk1QLf
         HAgAYUt83/3c6DtcEQaXyBVoaEx7mj5qOFGunDx1q4/KAZ/wtv41SJqlom9+kt8zlyD3
         qhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CWsnwP4GIaciUFACTvTTV9wv4l6lQ5px2rGr1iC9QYQ=;
        b=ek9fkZ6TeNWSWAAA+haVSo2UiZYObOJjRhpj1GyiZE+zC8gAgoGp1pbWC/PGXd4nKH
         CefCCoqezxKK0HWacQRM+n12idMYl9v3IIx/GNuxQT25o2l/wZ4xBS+M30dnHKg7dSP1
         IOeCDQ7iwoDIAuqGYXINlBzWZJKguMStLRbLOEliVGKfHsR9pj4xn1kbq/FGXmK8WCYs
         BsiXxVGcOTzLeJincjomz9y+BLLKpfYLcKKkN5J/+YRmGlDQmOEbhG85GLBu2ZxjpOzV
         Z3JjjPeF4g21j3fi4PJbwZJRNmPwjCcjVeQ5eu5OnrIAwl8CgzLm9+R78TOJZ8oroCrD
         nnAQ==
X-Gm-Message-State: APjAAAXmB86opFHAMWLYQDOwARJ1Zpm1mklfZwjB/34556J3sGVOfF/+
        J0i6tci5QRU4Xcat70bJ0ZUacqNaCKwQ3WjMgqQ=
X-Google-Smtp-Source: APXvYqyQPBlsSMyOPvjBz/wpDk4TcpkK1zYByT3Y1mmm2/Xy1MsxKgFybS+hQCEBy1MTxqxx/XwzcqmBJtjDn+485JY=
X-Received: by 2002:a9d:70d9:: with SMTP id w25mr334632otj.231.1579037902181;
 Tue, 14 Jan 2020 13:38:22 -0800 (PST)
MIME-Version: 1.0
References: <CAGi-RUJvqJoCXWN2YugRn=WYEk9yzt7m3OPfX_o++PmJWQ3woQ@mail.gmail.com>
 <87wo9ub5f6.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87wo9ub5f6.fsf@nanos.tec.linutronix.de>
From:   Ramon Fried <rfried.dev@gmail.com>
Date:   Tue, 14 Jan 2020 23:38:11 +0200
Message-ID: <CAGi-RUK_TA+WWvXJSrsa=_Pwq0pV1ffUKOCBu5c1t8O5Xs+UJg@mail.gmail.com>
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

On Tue, Jan 14, 2020 at 2:15 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Ramon Fried <rfried.dev@gmail.com> writes:
> > While debugging the root cause of spurious IRQ's on my PCIe MSI line it appears
> > that because of the line:
> >     info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
> > in pci_msi_create_irq_domain()
> >
> > The IRQF_ONESHOT is ignored, especially when requesting IRQ through
> > pci_request_threaded_irq() where handler is NULL.
>
> Which is perfectly fine.
>
> > The problem is that the MSI masking now only surrounds the HW handler,
> > and all additional MSI that occur before the threaded handler is
> > complete are considered by the note_interrupt() as spurious.
>
> Which is not a problem as long as the thread finishes before 100k MSIs
> arrived on that line. If that happens then there is something really
> wrong. Either the device fires MSIs like crazy or the threaded handler
> is stuck somewhere.
>
> > Besides the side effect of that, I don't really understand the logic
> > of not masking the MSI until the threaded handler is complete,
> > especially when there's no HW handler and only threaded handler.
>
> What's wrong with having another interrupt firing while the threaded
> handler is running? Nothing, really. It actually can be desired because
> the threaded handler is allowed to sleep.
What do you mean, isn't it the purpose IRQ masking ?
Interrupt coalescing is done to mitigate these IRQ's, these HW
interrupts just consume
CPU cycles and don't do anything useful (scheduling an already
scheduled thread).
Thanks,
Ramon.
>
> Thanks,
>
>         tglx
