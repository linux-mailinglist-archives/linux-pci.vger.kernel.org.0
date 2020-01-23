Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1941D1463AC
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2020 09:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgAWImr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jan 2020 03:42:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39342 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgAWImr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2020 03:42:47 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iuY4Y-0004Fo-LO; Thu, 23 Jan 2020 09:42:42 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 0B0641008DD; Thu, 23 Jan 2020 09:42:42 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Evan Green <evgreen@chromium.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Rajat Jain <rajatxjain@gmail.com>
Subject: Re: [PATCH] PCI/MSI: Avoid torn updates to MSI pairs
In-Reply-To: <CAE=gft7ukQOxHmJT_tkWzA3u2cecmV0Jiq-ukAu-1OR+sPnTtg@mail.gmail.com>
References: <20200116133102.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid> <20200122172816.GA139285@google.com> <CAE=gft6hvO7G2OrxFGXeSDctz-21ryiu8JSBWT0g2fRFss-pxA@mail.gmail.com> <875zh3ukoy.fsf@nanos.tec.linutronix.de> <CAE=gft7ukQOxHmJT_tkWzA3u2cecmV0Jiq-ukAu-1OR+sPnTtg@mail.gmail.com>
Date:   Thu, 23 Jan 2020 09:42:42 +0100
Message-ID: <871rrqva0t.fsf@nanos.tec.linutronix.de>
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
> On Wed, Jan 22, 2020 at 3:37 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> > One other way you could avoid torn MSI writes would be to ensure that
>> > if you migrate IRQs across cores, you keep the same x86 vector number.
>> > That way the address portion would be updated, and data doesn't
>> > change, so there's no window. But that may not actually be feasible.
>>
>> That's not possible simply because the x86 vector space is limited. If
>> we would have to guarantee that then we'd end up with a max of ~220
>> interrupts per system. Sufficient for your notebook, but the big iron
>> people would be not amused.
>
> Right, that occurred to me as well. The actual requirement isn't quite
> as restrictive. What you really need is the old vector to be
> registered on both the old CPU and the new CPU. Then once the
> interrupt is confirmed to have moved we could release both the old
> vector both CPUs, leaving only the new vector on the new CPU.

Sure, and how can you guarantee that without reserving the vector on all
CPUs in the first place? If you don't do that then if the vector is not
available affinity setting would fail every so often and it would pretty
much prevent hotplug if a to be migrated vector is not available on at
least one online CPU.

> In that world some SMP affinity transitions might fail, which is a
> bummer. To avoid that, you could first migrate to a vector that's
> available on both the source and destination CPUs, keeping affinity
> the same. Then change affinity in a separate step.

Good luck with doing that at the end of the hotplug routine where the
CPU is about to vanish.

> Or alternatively, you could permanently designate a "transit" vector.
> If an interrupt fires on this vector, then we call all ISRs currently
> in transit between CPUs. You might end up calling ISRs that didn't
> actually need service, but at least that's better than missing edges.

I don't think we need that. While walking the dogs I thought about
invoking a force migrated interrupt on the target CPU, but haven't
thought it through yet.

>> 'lscpci -vvv' and 'cat /proc/interrupts'
>
> Here it is:
> https://pastebin.com/YyxBUvQ2

Hrm:

        Capabilities: [80] MSI-X: Enable+ Count=16 Masked-

So this is weird. We mask it before moving it, so the tear issue should
not happen on MSI-X. So the tearing might be just a red herring.

Let me stare into the code a bit.

Thanks,

        tglx
