Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8251389653
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 21:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhESTN7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 15:13:59 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:35741 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhESTN7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 15:13:59 -0400
Received: by mail-oi1-f178.google.com with SMTP id v22so14125919oic.2;
        Wed, 19 May 2021 12:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vxp4TmkO45aYEHrqImPELz6FkJTQhQx7YrbNzy8hatQ=;
        b=NAzZNKayBU8V1mB7adPZs5PYv+a3NxEM9hogVZC2EQ1W3SByOyYzCRoOa0pBh/XCgC
         DDfJpw3wDEMxBOXAg81wHd2Smrom6X7koQ4rfdenOuuuAXJGihQ/3Gr0KiBP/nKfvdX4
         8hPDrMhmPXfnZxJGOfS3JtYwO6fumoUlkDXQHM5FxzwKlo61XwyD1NZyqYnh8E/zKW8V
         MWL09i3ZQB1D/AjAXTec93+gt7Jvkj9F17FxZODeOHxA3/JhOa41MWUZ2f07KOIqCt+a
         pN26DJ+0+jivLH95zUBvQ+LmVDooTMb1G6LXyVv1QH5jS79O6bQnwuBj3mDnoDuaXOtq
         D/hg==
X-Gm-Message-State: AOAM530BZzuszr+oY8UQN1Fu1FyXCeD+gcYXxZI2DYYXc5pxyJVdFWeB
        Au5nuxTuTSnKHuEyfjyVTLORRlPC7vIXnGj0S8o=
X-Google-Smtp-Source: ABdhPJyJWyMllfUR0/7cQsmfmSdjgHqDfwxn+/tLAgk6efQ/X4BJ4cEX/mOwyESO6zF+MIBr+DDKmseqh5fEjR4lojc=
X-Received: by 2002:aca:380a:: with SMTP id f10mr665215oia.157.1621451557943;
 Wed, 19 May 2021 12:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <8ddea02fc6d37f7c444a1e90c9f03d7656ffe957.camel@yandex.ru> <20210519172818.GA46184@bjorn-Precision-5520>
In-Reply-To: <20210519172818.GA46184@bjorn-Precision-5520>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 May 2021 21:12:26 +0200
Message-ID: <CAJZ5v0ijqL0ZpdwBvwY=Y9Ubuvd-Kr2s-NfUOKX_Ev3GB+pHww@mail.gmail.com>
Subject: Re: [PATCH] PCI: don't power-off apple thunderbolt controller on s2idle
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Konstantin Kharlamov <hi-angel@yandex.ru>,
        Lukas Wunner <lukas@wunner.de>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andreas Noever <andreas.noever@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 19, 2021 at 7:28 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, May 07, 2021 at 05:08:42PM +0300, Konstantin Kharlamov wrote:
> > On Fri, 2021-05-07 at 08:30 -0500, Bjorn Helgaas wrote:
> > > On Fri, May 07, 2021 at 12:07:38AM +0200, Lukas Wunner wrote:
> > > > On Thu, May 06, 2021 at 04:48:42PM -0500, Bjorn Helgaas wrote:
> > > > > On Thu, May 06, 2021 at 08:38:20PM +0300, Konstantin Kharlamov wrote:
> > > > > > On Macbook 2013 resuming from s2idle results in external monitor no
> > > > > > longer being detected, and dmesg having errors like:
> > > > > >
> > > > > >     pcieport 0000:06:00.0: can't change power state from D3hot to D0
> > > > > > (config space inaccessible)
> > > > > >
> > > > > > and a stacktrace. The reason turned out that the hw that the quirk
> > > > > > powers off does not get powered on back on resume.
>
> > > For example, "With s2idle, the machine isn't suspended via ACPI, so
> > > the AML code which powers the controller off isn't executed."  AFAICT
> > > that isn't actually a required, documented property of s2idle, but
> > > rather it reaches into the internal implementation.
>
> > > The code comment "If suspend mode is s2idle, power won't get restored
> > > on resume" is similar.  !pm_suspend_via_firmware() tells us that
> > > platform firmware won't be invoked.  But the connection between *that*
> > > and "power won't get restored" is unexplained.
> >
> > Sorry, I can't comment anything regarding AML and power management
> > in general since I am really new to all of this. However, regarding
> > the usage of the `pm_suspend_via_firmware()`: yeah, I also think it
> > is unclear what this does, and I was thinking about adding a wrapper
> > function something like `is_s2idle()` to the suspend.h, which would
> > simply call `pm_suspend_via_firmware` internally.
>
> No, that's not my point at all.  I don't really care whether the
> interface is called pm_suspend_via_firmware() or is_s2idle().
>
> What I don't like about this is that it's all just unexplained magic,
> as was the original quirk.
>
> IIUC, the quirk is applied by pci_pm_suspend_noirq() *after* it puts
> the device in a low-power state.  Here's my uninformed speculation
> about what happens:
>
>   - On suspend, pci_pm_suspend_noirq() puts device in low-power state.

Right.

>     My *guess* is this means D0 or D3hot for s2idle, and D3cold for
>     everything else.

This really depends on the ACPI methods involved, but as a rule (and
I'm not aware of any exceptions) the target power state of the device
for s2idle and "everything else" is the same.  If D3cold is possible,
it will be D3cold.  If not, that will be D3hot etc.

The only difference (from the individual device perspective) is that
in the ACPI S3 (or S4 if this matters here) case the platform firmware
(and that's not AML but something like SMM) may cut power off from it
later.

>  [Do we have sufficient debug to find out what these states are?]

I'm not sure what you mean.  What states are supported or something else?

>   - pci_pm_suspend_noirq() does pci_fixup_suspend_late fixups,
>     including quirk_apple_poweroff_thunderbolt().
>
>   - quirk_apple_poweroff_thunderbolt() runs the magic SXIO/SXFP/SXLF
>     methods, which apparently turn off more power.
>
>   - On resume, pci_pm_resume_noirq() brings the device back to D0.
>
>     If we're resuming from standby, S2RAM, or STD, I speculate the
>     device is in D3cold, so this involves running AML that seems to
>     undo whatever SXIO/SXFP/SXLF did.

The standby, S2RAM and STD cases are actually different in that respect.

In the STD case we get the device from the restore kernel and it most
likely has been enumerated by it, so it is in whatever power state the
restore kernel puts it into.

For standby that most likely is the state in which the device was left
during suspend.

For S2RAM, it most likely will be something like D0-uninitialized,
because the platform firmware initiating the resume transition (which
is not AML, but again something like SMM) restores power to the
platform (including the majority of devices), but doesn't initialize
them as a rule.

The STD and S2RAM resume will undo the "magic", standby resume may not.

>
>     If we're resuming from s2idle, I speculate the device is in D0 or
>     D3hot, and we run different AML (or maybe no AML at all), and we

It is in whatever power state it was left in during suspend and we run
the same AML as in the other cases, modulo the possible power state
difference (with respect to the other cases).

>     *don't* undo the effects of SXIO/SXFP/SXLF, so the device doesn't
>     work.

This is correct.

> If the above is anything like what's happening, we should be able to
> skip SXIO/SXFP/SXLF based on the current power state of the device.

Not really.

> E.g., if the device is in D0 or D3hot, we should not use
> SXIO/SXFP/SXLF to yank power.
>
> That would seem more connected to the observable state of the device
> than using pm_suspend_via_firmware(), which relies on the connection
> between s2idle and PM_SUSPEND_FLAG_FW_SUSPEND (which is not at all
> obvious) and the power state of the device while in s2idle (also not
> obvious).

The problem is related to the fact that in s2idle the platform
firmware does not finalize the suspend transition and, consequently,
it doesn't initiate the resume transition.  Therefore whatever power
state the device was left in during suspend must be dealt with during
the subsequent resume.  Hence, if whatever is done by SXIO/SXFP/SXLF
in the suspend path cannot be reversed in the resume path by the
kernel (because there is no known method to do that), they should not
be invoked.  And that's exactly because the platform firmware will not
finalize the suspend transition which is indicated by
PM_SUSPEND_FLAG_FW_SUSPEND being unset.

Cheers!
