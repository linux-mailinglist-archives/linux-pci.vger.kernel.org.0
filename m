Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12814F471A
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 01:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbiDEU7T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 16:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444822AbiDEPmE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 11:42:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAE318B258;
        Tue,  5 Apr 2022 07:06:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649167611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=i81MASCCDw38dcKZylteUy/3pg50r3ulw2eAeBX1oQs=;
        b=blb33Z/hkJODAWD0H0EQS/ucph9bnmTVwHRBaB8faYgOxdQiY1v+iBJaTHaNRuekJOtKPN
        ftfSFYAe47v1dSNmihMBBH1Uu2xNTQVJdwHgnmhPTKiUEX4R9aGzzLCR0dShjccozOAAxp
        oUI31XXjZk6cepgUaDwHHR6kYrdPUEy1C/4NzSt243SIacCu3JMKAXrZWqTLmqCAfJKtyt
        Qwqz8k+Xo9itZXJ/J3gtQ2OzmHnvTghPeHmofW/8CsWy0Qp+5G+OH+2EC+BLPl1vpolf5d
        LVWC3JV9vCMAYgjfutiivuCw3TVl2I1CqCzViZal/pBka4S7ZXg5GBCAdH3Oxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649167611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=i81MASCCDw38dcKZylteUy/3pg50r3ulw2eAeBX1oQs=;
        b=6qOMCJYfbs8XtKREWwkNMmyZpa/kppvHyluNeM4S50mmbUr3N+rkt67nQ6cuHWbR+xWQR8
        crbdlICxoSpd+BDQ==
To:     Evan Green <evgreen@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: Lost MSIs during hibernate
In-Reply-To: <CAE=gft4a-QL82iFJE_xRQ3JrMmz-KZKWREtz=MghhjFbJeK=8A@mail.gmail.com>
Date:   Tue, 05 Apr 2022 16:06:50 +0200
Message-ID: <87a6cz39qd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Evan!

On Mon, Apr 04 2022 at 12:11, Evan Green wrote:
> To my surprise, I'm back with another MSI problem, and hoping to get
> some advice on how to approach fixing it.

Why am I not surprised?

> What worries me is those IRQ "no longer affine" messages, as well as
> my "EVAN don't touch hw" prints, indicating that requests to change
> the MSI are being dropped. These ignored requests are coming in when
> we try to migrate all IRQs off of the non-boot CPU, and they get
> ignored because all devices are "frozen" at this point, and presumably
> not in D0.

They are disabled at that point.

> To further try and prove that theory, I wrote a script to do the
> hibernate prepare image step in a loop, but messed with XHCI's IRQ
> affinity beforehand. If I move the IRQ to core 0, so far I have never
> seen a hang. But if I move it to another core, I can usually get a
> hang in the first attempt. I also very occasionally see wifi splats
> when trying this, and those "no longer affine" prints are all the wifi
> queue IRQs. So I think a wifi packet coming in at the wrong time can
> do the same thing.
>
> I wanted to see what thoughts you might have on this. Should I try to
> make a patch that moves all IRQs to CPU 0 *before* the devices all
> freeze? Sounds a little unpleasant. Or should PCI be doing something
> different to avoid this combination of "you're not allowed to modify
> my MSIs, but I might still generate interrupts that must not be lost"?

PCI cannot do much here and moving interrupts around is papering over
the underlying problem.

xhci_hcd 0000:00:0d.0: EVAN Write MSI 0 fee1e000 4023

  This sets up the interrupt when the driver is loaded

xhci_hcd 0000:00:14.0: EVAN Write MSI 0 fee01000 4024

  Ditto

xhci_hcd 0000:00:0d.0: calling pci_pm_freeze+0x0/0xad @ 423, parent: pci0000:00
xhci_hcd 0000:00:14.0: calling pci_pm_freeze+0x0/0xad @ 4644, parent: pci0000:00
xhci_hcd 0000:00:14.0: pci_pm_freeze+0x0/0xad returned 0 after 0 usecs
xhci_hcd 0000:00:0d.0: EVAN Write MSI 0 fee1e000 4023
xhci_hcd 0000:00:0d.0: pci_pm_freeze+0x0/0xad returned 0 after 196000 usecs

Those freeze() calls end up in xhci_suspend(), which tears down the XHCI
and ensures that no interrupts are on flight.

xhci_hcd 0000:00:0d.0: calling pci_pm_freeze_noirq+0x0/0xb2 @ 4645, parent: pci0000:00
xhci_hcd 0000:00:0d.0: pci_pm_freeze_noirq+0x0/0xb2 returned 0 after 30 usecs
xhci_hcd 0000:00:14.0: calling pci_pm_freeze_noirq+0x0/0xb2 @ 4644, parent: pci0000:00
xhci_hcd 0000:00:14.0: pci_pm_freeze_noirq+0x0/0xb2 returned 0 after 3118 usecs

   Now the devices are disabled and not accessible

xhci_hcd 0000:00:14.0: EVAN Don't touch hw 0 fee00000 4024
xhci_hcd 0000:00:0d.0: EVAN Don't touch hw 0 fee1e000 4045
xhci_hcd 0000:00:0d.0: EVAN Don't touch hw 0 fee00000 4045
xhci_hcd 0000:00:14.0: calling pci_pm_thaw_noirq+0x0/0x70 @ 9, parent: pci0000:00
xhci_hcd 0000:00:14.0: EVAN Write MSI 0 fee00000 4024

   This is the early restore _before_ the XHCI resume code is called
   This interrupt is targeted at CPU0 (it's the one which could not be
   written above).

xhci_hcd 0000:00:14.0: pci_pm_thaw_noirq+0x0/0x70 returned 0 after 5272 usecs
xhci_hcd 0000:00:0d.0: calling pci_pm_thaw_noirq+0x0/0x70 @ 1123, parent: pci0000:00
xhci_hcd 0000:00:0d.0: EVAN Write MSI 0 fee00000 4045

   Ditto

xhci_hcd 0000:00:0d.0: pci_pm_thaw_noirq+0x0/0x70 returned 0 after 623 usecs
xhci_hcd 0000:00:14.0: calling pci_pm_thaw+0x0/0x7c @ 3856, parent: pci0000:00
xhci_hcd 0000:00:14.0: pci_pm_thaw+0x0/0x7c returned 0 after 0 usecs
xhci_hcd 0000:00:0d.0: calling pci_pm_thaw+0x0/0x7c @ 4664, parent: pci0000:00
xhci_hcd 0000:00:0d.0: pci_pm_thaw+0x0/0x7c returned 0 after 0 usecs

That means the suspend/resume logic is doing the right thing.

How the XHCI ends up being confused here is a mystery. Cc'ed a few more folks.

Thanks,

        tglx


