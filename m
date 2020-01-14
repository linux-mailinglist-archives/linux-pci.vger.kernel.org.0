Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 146C713A90F
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 13:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgANMPP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 07:15:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42935 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANMPO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2020 07:15:14 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irL6D-0003Yw-Os; Tue, 14 Jan 2020 13:15:09 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 388A1101DEE; Tue, 14 Jan 2020 13:15:09 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ramon Fried <rfried.dev@gmail.com>, hkallweit1@gmail.com,
        bhelgaas@google.com, maz@kernel.org, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: MSI irqchip configured as IRQCHIP_ONESHOT_SAFE causes spurious IRQs
In-Reply-To: <CAGi-RUJvqJoCXWN2YugRn=WYEk9yzt7m3OPfX_o++PmJWQ3woQ@mail.gmail.com>
References: <CAGi-RUJvqJoCXWN2YugRn=WYEk9yzt7m3OPfX_o++PmJWQ3woQ@mail.gmail.com>
Date:   Tue, 14 Jan 2020 13:15:09 +0100
Message-ID: <87wo9ub5f6.fsf@nanos.tec.linutronix.de>
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
> While debugging the root cause of spurious IRQ's on my PCIe MSI line it appears
> that because of the line:
>     info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
> in pci_msi_create_irq_domain()
>
> The IRQF_ONESHOT is ignored, especially when requesting IRQ through
> pci_request_threaded_irq() where handler is NULL.

Which is perfectly fine.

> The problem is that the MSI masking now only surrounds the HW handler,
> and all additional MSI that occur before the threaded handler is
> complete are considered by the note_interrupt() as spurious.

Which is not a problem as long as the thread finishes before 100k MSIs
arrived on that line. If that happens then there is something really
wrong. Either the device fires MSIs like crazy or the threaded handler
is stuck somewhere.

> Besides the side effect of that, I don't really understand the logic
> of not masking the MSI until the threaded handler is complete,
> especially when there's no HW handler and only threaded handler.

What's wrong with having another interrupt firing while the threaded
handler is running? Nothing, really. It actually can be desired because
the threaded handler is allowed to sleep.

Thanks,

        tglx
