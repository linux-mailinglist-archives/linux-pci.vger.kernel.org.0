Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478134F4722
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 01:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242412AbiDEVAF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 17:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573178AbiDESJJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 14:09:09 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEB21FA44
        for <linux-pci@vger.kernel.org>; Tue,  5 Apr 2022 11:07:09 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-de3eda6b5dso286290fac.0
        for <linux-pci@vger.kernel.org>; Tue, 05 Apr 2022 11:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p23li6dT00AJl3hRn5GLCpGGZV7Mde/F/ZC6fP/JEqE=;
        b=BADiZnSp78f9ZfxjlasetO+C2Swva/fEryHvZCHweafMOdoIX0m57hfulFwzprUsBB
         5NO3j0ERJTi0OIIihE8sjSrXI/ueYUhpzuyzUvDnj/rraSlSTYcBjV3vc+GP9NtnhzkI
         VM96wegARllDkf3644nEdixuvBQTRlgo0J5z3sG6cbiClK2MFU5FQEMNxQ3kr0ozGy8b
         H0v0wy7xBeY27WgEwcBToKdEfjz5/a8PRSTPfNS/C9WTKMFTLaYVjUzE1+aWoW7GlT8m
         l9irSkp9XsXAqCpbUokn14g9EtjANf+Eja8ATrFsehV0xTGHq1NWrkarTq4fmuMSRcMt
         X6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p23li6dT00AJl3hRn5GLCpGGZV7Mde/F/ZC6fP/JEqE=;
        b=Kq0RIHGdiha/H/noX/QjKfO64f63K/Lvf1Wh0Tr8XzGZwB3Ct5pf3iwZBEfsFvzAXM
         Y1+d/OaGS8M7dIogyAHhQ5KI4yzxVzfQk5+TdjhMZ1n9EvRoEbby5gQD+bjDNDsPv/jv
         Ff1egocbrLfJnSZ12jJjPMD6Lyd1MWUSUX+Qr+QpfhwFdAY4hX7APYRUopZvcwWVMKvJ
         kkL80GQxrp09D7PLe8U/s1wJO8H7+negd9ZRPYu5pTvQRm/omYZ65sftacr6abvECAG0
         DY2WdWQDO8Lq+qg6VKRVPECEF72kxpsfsGusd80MnpD0PS2i6Dpmd3VdC95503ei2wgP
         VY3A==
X-Gm-Message-State: AOAM531rtxCXTmIgwVGVAO78QmMxQV8oB35KyyqoGEuJuanyzajZQ8jI
        1OvNloCnroo2hFLesVZ5WJEWz7WwjlznS5IJM7eusNk4ssyf6g==
X-Google-Smtp-Source: ABdhPJwYioIcf3roWcw+7eBY8YdFqDjjHYzBDCjQs9Td/wpB5Go+w8ufPzRoqDbMsrdiR1b646s6qcFXd+sb+pgP2sE=
X-Received: by 2002:a05:6870:1709:b0:e1:ea02:2001 with SMTP id
 h9-20020a056870170900b000e1ea022001mr2164491oae.241.1649182028168; Tue, 05
 Apr 2022 11:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAE=gft4a-QL82iFJE_xRQ3JrMmz-KZKWREtz=MghhjFbJeK=8A@mail.gmail.com>
 <87a6cz39qd.ffs@tglx>
In-Reply-To: <87a6cz39qd.ffs@tglx>
From:   Evan Green <evgreen@google.com>
Date:   Tue, 5 Apr 2022 11:06:31 -0700
Message-ID: <CAE=gft521_W6uaCBovjr5RJ-RV3vVE2Ex0OV91FxpnuXThYHLA@mail.gmail.com>
Subject: Re: Lost MSIs during hibernate
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 5, 2022 at 7:06 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Evan!
>
> On Mon, Apr 04 2022 at 12:11, Evan Green wrote:
> > To my surprise, I'm back with another MSI problem, and hoping to get
> > some advice on how to approach fixing it.
>
> Why am I not surprised?

I swear I don't intersect with this stuff that often. Maybe the
reality is I always intersect with this stuff, it just usually works
perfectly :)

>
> > What worries me is those IRQ "no longer affine" messages, as well as
> > my "EVAN don't touch hw" prints, indicating that requests to change
> > the MSI are being dropped. These ignored requests are coming in when
> > we try to migrate all IRQs off of the non-boot CPU, and they get
> > ignored because all devices are "frozen" at this point, and presumably
> > not in D0.
>
> They are disabled at that point.
>
> > To further try and prove that theory, I wrote a script to do the
> > hibernate prepare image step in a loop, but messed with XHCI's IRQ
> > affinity beforehand. If I move the IRQ to core 0, so far I have never
> > seen a hang. But if I move it to another core, I can usually get a
> > hang in the first attempt. I also very occasionally see wifi splats
> > when trying this, and those "no longer affine" prints are all the wifi
> > queue IRQs. So I think a wifi packet coming in at the wrong time can
> > do the same thing.
> >
> > I wanted to see what thoughts you might have on this. Should I try to
> > make a patch that moves all IRQs to CPU 0 *before* the devices all
> > freeze? Sounds a little unpleasant. Or should PCI be doing something
> > different to avoid this combination of "you're not allowed to modify
> > my MSIs, but I might still generate interrupts that must not be lost"?
>
> PCI cannot do much here and moving interrupts around is papering over
> the underlying problem.
>
> xhci_hcd 0000:00:0d.0: EVAN Write MSI 0 fee1e000 4023
>
>   This sets up the interrupt when the driver is loaded
>
> xhci_hcd 0000:00:14.0: EVAN Write MSI 0 fee01000 4024
>
>   Ditto
>
> xhci_hcd 0000:00:0d.0: calling pci_pm_freeze+0x0/0xad @ 423, parent: pci0000:00
> xhci_hcd 0000:00:14.0: calling pci_pm_freeze+0x0/0xad @ 4644, parent: pci0000:00
> xhci_hcd 0000:00:14.0: pci_pm_freeze+0x0/0xad returned 0 after 0 usecs
> xhci_hcd 0000:00:0d.0: EVAN Write MSI 0 fee1e000 4023
> xhci_hcd 0000:00:0d.0: pci_pm_freeze+0x0/0xad returned 0 after 196000 usecs
>
> Those freeze() calls end up in xhci_suspend(), which tears down the XHCI
> and ensures that no interrupts are on flight.

Your hint here about xhci_suspend() was helpful. It turns out this is
not called in the freeze path, usb_hcd_pci_pm_ops just calls
check_root_hub_suspended(). The documentation in devices.rst is pretty
clear about this:

```
The ``->freeze`` methods should quiesce the device so that it doesn't
generate IRQs or DMA
```

So I think you're right that the PM layer is doing everything right
(though with a bit of a footgun that if you mess up and generate an
interrupt after freeze it may just be gone forever), and usb core is
at fault here. I've been testing with this patch (mangled in email),
and so far the issue seems to be gone:

@@ -614,10 +622,10 @@ const struct dev_pm_ops usb_hcd_pci_pm_ops = {
        .suspend_noirq  = hcd_pci_suspend_noirq,
        .resume_noirq   = hcd_pci_resume_noirq,
        .resume         = hcd_pci_resume,
-       .freeze         = check_root_hub_suspended,
-       .freeze_noirq   = check_root_hub_suspended,
-       .thaw_noirq     = NULL,
-       .thaw           = NULL,
+       .freeze         = hcd_pci_suspend,
+       .freeze_noirq   = hcd_pci_suspend_noirq,
+       .thaw_noirq     = hcd_pci_resume_noirq,
+       .thaw           = hcd_pci_resume,
        .poweroff       = hcd_pci_suspend,
        .poweroff_noirq = hcd_pci_suspend_noirq,
        .restore_noirq  = hcd_pci_resume_noirq,


As an aside, one might wonder "why don't we see this everywhere
then?". I think that's because Intel missed a patch enabling runtime
pm on one of these XHCI controllers (8086:51ed). See the quirks below,
that missing 2 on 00:14.0 is XHCI_DEFAULT_PM_RUNTIME_ALLOW:
# dmesg | grep quirks
[    2.804073] xhci_hcd 0000:00:0d.0: hcc params 0x20007fc1 hci
version 0x120 quirks 0x0000000200009810
[    3.108045] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci
version 0x120 quirks 0x0000000000009810

If the XHCI controller were usually in runtime suspend when freeze()
got called, it would be fully quiesced and would not lose its
interrupt. I had noticed this earlier, and it did reduce the repro
rate, but did not reduce it to zero. Now it makes sense why.

I think I have enough info to go make a USB patch now. Thank you for you help!
-Evan

>
> xhci_hcd 0000:00:0d.0: calling pci_pm_freeze_noirq+0x0/0xb2 @ 4645, parent: pci0000:00
> xhci_hcd 0000:00:0d.0: pci_pm_freeze_noirq+0x0/0xb2 returned 0 after 30 usecs
> xhci_hcd 0000:00:14.0: calling pci_pm_freeze_noirq+0x0/0xb2 @ 4644, parent: pci0000:00
> xhci_hcd 0000:00:14.0: pci_pm_freeze_noirq+0x0/0xb2 returned 0 after 3118 usecs
>
>    Now the devices are disabled and not accessible
>
> xhci_hcd 0000:00:14.0: EVAN Don't touch hw 0 fee00000 4024
> xhci_hcd 0000:00:0d.0: EVAN Don't touch hw 0 fee1e000 4045
> xhci_hcd 0000:00:0d.0: EVAN Don't touch hw 0 fee00000 4045
> xhci_hcd 0000:00:14.0: calling pci_pm_thaw_noirq+0x0/0x70 @ 9, parent: pci0000:00
> xhci_hcd 0000:00:14.0: EVAN Write MSI 0 fee00000 4024
>
>    This is the early restore _before_ the XHCI resume code is called
>    This interrupt is targeted at CPU0 (it's the one which could not be
>    written above).
>
> xhci_hcd 0000:00:14.0: pci_pm_thaw_noirq+0x0/0x70 returned 0 after 5272 usecs
> xhci_hcd 0000:00:0d.0: calling pci_pm_thaw_noirq+0x0/0x70 @ 1123, parent: pci0000:00
> xhci_hcd 0000:00:0d.0: EVAN Write MSI 0 fee00000 4045
>
>    Ditto
>
> xhci_hcd 0000:00:0d.0: pci_pm_thaw_noirq+0x0/0x70 returned 0 after 623 usecs
> xhci_hcd 0000:00:14.0: calling pci_pm_thaw+0x0/0x7c @ 3856, parent: pci0000:00
> xhci_hcd 0000:00:14.0: pci_pm_thaw+0x0/0x7c returned 0 after 0 usecs
> xhci_hcd 0000:00:0d.0: calling pci_pm_thaw+0x0/0x7c @ 4664, parent: pci0000:00
> xhci_hcd 0000:00:0d.0: pci_pm_thaw+0x0/0x7c returned 0 after 0 usecs
>
> That means the suspend/resume logic is doing the right thing.
>
> How the XHCI ends up being confused here is a mystery. Cc'ed a few more folks.
>
> Thanks,
>
>         tglx
>
>
