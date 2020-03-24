Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 290451919A7
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 20:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgCXTD4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Mar 2020 15:03:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45910 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbgCXTD4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Mar 2020 15:03:56 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jGoq1-00049g-Cz; Tue, 24 Mar 2020 20:03:45 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 23137100292; Tue, 24 Mar 2020 20:03:44 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Evan Green <evgreen@chromium.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>, x86@kernel.org,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Ghorai\, Sukumar" <sukumar.ghorai@intel.com>,
        "Amara\, Madhusudanarao" <madhusudanarao.amara@intel.com>,
        "Nandamuri\, Srikanth" <srikanth.nandamuri@intel.com>
Subject: Re: MSI interrupt for xhci still lost on 5.6-rc6 after cpu hotplug
In-Reply-To: <CAE=gft6Fbibu17H+OfHZjmvHxboioFj09hAmozebc1TE_EqH5g@mail.gmail.com>
References: <806c51fa-992b-33ac-61a9-00a606f82edb@linux.intel.com> <87d0974akk.fsf@nanos.tec.linutronix.de> <b9fbd55a-7f97-088d-2cc2-4e4ea86d9440@linux.intel.com> <87r1xjp3gn.fsf@nanos.tec.linutronix.de> <f8057cbc-4814-5083-cddd-d4eb1459529f@linux.intel.com> <878sjqfvmi.fsf@nanos.tec.linutronix.de> <CAE=gft6Fbibu17H+OfHZjmvHxboioFj09hAmozebc1TE_EqH5g@mail.gmail.com>
Date:   Tue, 24 Mar 2020 20:03:44 +0100
Message-ID: <87tv2dd17z.fsf@nanos.tec.linutronix.de>
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
> On Mon, Mar 23, 2020 at 5:24 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> And of course all of this is so well documented that all of us can
>> clearly figure out what's going on...
>
> I won't pretend to know what's going on, so I'll preface this by
> labeling it all as "flailing", but:
>
> I wonder if there's some way the interrupt can get delayed between
> XHCI snapping the torn value and it finding its way into the IRR. For
> instance, if xhci read this value at the start of their interrupt
> moderation timer period, that would be awful (I hope they don't do
> this). One test patch would be to carve out 8 vectors reserved for
> xhci on all cpus. Whenever you change the affinity, the assigned
> vector is always reserved_base + cpu_number. That lets you exercise
> the affinity switching code, but in a controlled manner where torn
> interrupts could be easily seen (ie hey I got an interrupt on cpu 4's
> vector but I'm cpu 2). I might struggle to write such a change, but in
> theory it's doable.

Well, the point is that we don't see a spurious interrupt on any
CPU. We added a traceprintk into do_IRQ() and that would immediately
tell us where the thing goes off into lala land. Which it didn't.

> I was alternately trying to build a theory in my head about the write
> somehow being posted and getting out of order, but I don't think that
> can happen.

If that happens then the lost XHCI interrupt is the least of your
worries.

Thanks,

        tglx


