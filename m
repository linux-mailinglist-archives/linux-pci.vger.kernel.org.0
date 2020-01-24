Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED6591475B9
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2020 01:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgAXAuk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jan 2020 19:50:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41242 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729425AbgAXAuk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2020 19:50:40 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iunBF-00026p-5F; Fri, 24 Jan 2020 01:50:37 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 4A553100490; Fri, 24 Jan 2020 01:50:36 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Evan Green <evgreen@chromium.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI/MSI: Avoid torn updates to MSI pairs
In-Reply-To: <CAE=gft5xta4XCJtctWe=R3w=kVr598JCbk9VSRue04nzKAk3CQ@mail.gmail.com>
References: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid> <CACK8Z6Ft95qj4e_fsA32r_bcz2SsHOW1xxqZJt3_DBAJw=NMGA@mail.gmail.com> <CAE=gft6fKQWExW-=xjZGzXs30XohfpA5SKggvL2WtYXAHmzMew@mail.gmail.com> <87y2tytv5i.fsf@nanos.tec.linutronix.de> <87eevqkpgn.fsf@nanos.tec.linutronix.de> <CAE=gft6YiM5S1A7iJYJTd5zmaAa8=nhLE3B94JtWa+XW-qVSqQ@mail.gmail.com> <CAE=gft5xta4XCJtctWe=R3w=kVr598JCbk9VSRue04nzKAk3CQ@mail.gmail.com>
Date:   Fri, 24 Jan 2020 01:50:36 +0100
Message-ID: <87pnf91xur.fsf@nanos.tec.linutronix.de>
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
> On Thu, Jan 23, 2020 at 12:59 PM Evan Green <evgreen@chromium.org> wrote:
>>
>> On Thu, Jan 23, 2020 at 10:17 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> >
>> > Evan,
>> >
>> > Thomas Gleixner <tglx@linutronix.de> writes:
>> > > This is not yet debugged fully and as this is happening on MSI-X I'm not
>> > > really convinced yet that your 'torn write' theory holds.

As you pointed out that this is not on MSI-X I'm considering the torn
write theory to be more likely. :)

>> > can you please apply the debug patch below and run your test. When the
>> > failure happens, stop the tracer and collect the trace.
>> >
>> > Another question. Did you ever try to change the affinity of that
>> > interrupt without hotplug rapidly while the device makes traffic? If
>> > not, it would be interesting whether this leads to a failure as well.
>>
>> Thanks for the patch. Looks pretty familiar :)
>> I ran into issues where trace_printks on offlined cores seem to
>> disappear. I even made sure the cores were back online when I
>> collected the trace. So your logs might not be useful. Known issue
>> with the tracer?

No. I tried the patch myself to verify that it does what I want.

The only information I'm missing right now is the interrupt number to
look for. But I'll stare at it with brain awake tomorrow morning again.

>> I also tried changing the affinity rapidly without CPU hotplug, but
>> didn't see the issue, at least not in the few minutes I waited
>> (normally repros easily within 1 minute). An interesting datapoint.

That's what I expected. The main difference is that the vector
modification happens at a point where a device is not supposed to send
an interrupt. They happen when the interrupt of the device is serviced
before the driver handler is invoked and at that point the device should
not send another one.

> One additional datapoint. The intel guys suggested enabling
> CONFIG_IRQ_REMAP, which does seem to eliminate the issue for me. I'm
> still hoping there's a smaller fix so I don't have to add all that in.

Right, I wanted to ask you that as well and forgot. With interrupt
remapping the migration happens at the remapping unit which does not
have the horrible 'move it while servicing' requirement and it suppports
proper masking.

Thanks,

        tglx

