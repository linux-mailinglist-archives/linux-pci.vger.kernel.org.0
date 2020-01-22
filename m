Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52D7C145F34
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2020 00:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgAVXhl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jan 2020 18:37:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38871 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgAVXhl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jan 2020 18:37:41 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iuPZ0-0007OT-0Q; Thu, 23 Jan 2020 00:37:34 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 3688610029B; Thu, 23 Jan 2020 00:37:33 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Evan Green <evgreen@chromium.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Rajat Jain <rajatxjain@gmail.com>
Subject: Re: [PATCH] PCI/MSI: Avoid torn updates to MSI pairs
In-Reply-To: <CAE=gft6hvO7G2OrxFGXeSDctz-21ryiu8JSBWT0g2fRFss-pxA@mail.gmail.com>
References: <20200116133102.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid> <20200122172816.GA139285@google.com> <CAE=gft6hvO7G2OrxFGXeSDctz-21ryiu8JSBWT0g2fRFss-pxA@mail.gmail.com>
Date:   Thu, 23 Jan 2020 00:37:33 +0100
Message-ID: <875zh3ukoy.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Evan Green <evgreen@chromium.org> writes:
> On Wed, Jan 22, 2020 at 9:28 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>> I suspect this *is* a problem because I think disabling MSI doesn't
>> disable interrupts; it just means the device will interrupt using INTx
>> instead of MSI.  And the driver is probably not prepared to handle
>> INTx.
>>
>> PCIe r5.0, sec 7.7.1.2, seems relevant: "If MSI and MSI-X are both
>> disabled, the Function requests servicing using INTx interrupts (if
>> supported)."

Disabling MSI is not an option. Masking yes, but MSI does not have
mandatory masking. We already attempt masking on migration, which covers
only MSI-X reliably, but not all MSI incarnations.

So I assume that problem happens on a MSI interrupt, right?

>> Maybe the IRQ guys have ideas about how to solve this?

Maybe :)

> But don't we already do this in __pci_restore_msi_state():
>         pci_intx_for_msi(dev, 0);
>         pci_msi_set_enable(dev, 0);
>         arch_restore_msi_irqs(dev);
>
> I'd think if there were a chance for a line-based interrupt to get in
> and wedge itself, it would already be happening there.

That's a completely different beast. It's used when resetting a device
and for other stuff like virt state migration. That's not a model for
affinity changes of a live device.

> One other way you could avoid torn MSI writes would be to ensure that
> if you migrate IRQs across cores, you keep the same x86 vector number.
> That way the address portion would be updated, and data doesn't
> change, so there's no window. But that may not actually be feasible.

That's not possible simply because the x86 vector space is limited. If
we would have to guarantee that then we'd end up with a max of ~220
interrupts per system. Sufficient for your notebook, but the big iron
people would be not amused.

The real critical path here is the CPU hotplug path.

For regular migration between two online CPUs we use the 'migrate when
the irq is actually serviced ' mechanism. That might have the same issue
on misdesigned devices which are firing the next interrupt before the
one on the flight is serviced, but I haven't seen any reports with that
symptom yet.

But before I dig deeper into this, please provide the output of

'lscpci -vvv' and 'cat /proc/interrupts'

Thanks,

        tglx


