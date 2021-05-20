Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E0B38ABF8
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 13:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbhETLbF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 07:31:05 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:40892 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241026AbhETL25 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 May 2021 07:28:57 -0400
Received: by mail-oi1-f179.google.com with SMTP id s19so16057668oic.7;
        Thu, 20 May 2021 04:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLoQytCJZNTbKWVT/noma+z4gVb6x1ofyGWkY0jypdE=;
        b=MQTU4BHUKr2c1qcxYDJpAp3Xsd5zOEKGTmz96f7Y1cIIdQj0fglzg1tzNngAl2fYO1
         fIJgJ6+ov9L7AiovECnwliKfdJlhjn0y0QMhQIEiEsNNgRF2k5g0vqeAIGLGi7eTtkCB
         5Z42VJ4eYmigKhdMdLIlFwacLI5AXhginzrxjUh1kH0yMXlVWyINuJjjMfvcZjg5uOec
         oBTNQtWl01ZNRjrMVF+yLCtnmA9XZnwatqLIfDHS2+JLR5+6p62lH2BaHixpS+Sy43F8
         MYDEhXq/PTKYm8gYEM94QQ8QwXA/qdFY6CN2wTHRdQYNX+tONMnHRHLDdXUyPB+rGEAc
         Shgg==
X-Gm-Message-State: AOAM530QZLHdbZL6hTkHK6InRMQ1qATnClQX+5UWN2edx9V0FZMyNjFY
        zv7y+VjfbDslMeCxYM3/YbBLLcSmQvD1MasyXPE=
X-Google-Smtp-Source: ABdhPJwsK5oAALz+Yl9V0yZC1sDcs57BYz4D/QSVlWlrK7QvHg1CW1tIBSOYquLiNWztZ0YToTiur+mssnGf0r3VFgA=
X-Received: by 2002:aca:4758:: with SMTP id u85mr2920409oia.71.1621510054801;
 Thu, 20 May 2021 04:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0ijqL0ZpdwBvwY=Y9Ubuvd-Kr2s-NfUOKX_Ev3GB+pHww@mail.gmail.com>
 <20210519194853.GA249712@bjorn-Precision-5520>
In-Reply-To: <20210519194853.GA249712@bjorn-Precision-5520>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 May 2021 13:27:23 +0200
Message-ID: <CAJZ5v0i+s7Ru5J5Um0tExMGCnK0JGTnc76BYyd58EiYkt6dghQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: don't power-off apple thunderbolt controller on s2idle
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Konstantin Kharlamov <hi-angel@yandex.ru>,
        Lukas Wunner <lukas@wunner.de>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andreas Noever <andreas.noever@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 19, 2021 at 9:48 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, May 19, 2021 at 09:12:26PM +0200, Rafael J. Wysocki wrote:
> > On Wed, May 19, 2021 at 7:28 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Fri, May 07, 2021 at 05:08:42PM +0300, Konstantin Kharlamov wrote:
> > > > On Fri, 2021-05-07 at 08:30 -0500, Bjorn Helgaas wrote:
> > > > > On Fri, May 07, 2021 at 12:07:38AM +0200, Lukas Wunner wrote:
> > > > > > On Thu, May 06, 2021 at 04:48:42PM -0500, Bjorn Helgaas wrote:
> > > > > > > On Thu, May 06, 2021 at 08:38:20PM +0300, Konstantin Kharlamov wrote:
> > > > > > > > On Macbook 2013 resuming from s2idle results in external monitor no
> > > > > > > > longer being detected, and dmesg having errors like:
> > > > > > > >
> > > > > > > >     pcieport 0000:06:00.0: can't change power state from D3hot to D0
> > > > > > > > (config space inaccessible)
> > > > > > > >
> > > > > > > > and a stacktrace. The reason turned out that the hw that the quirk
> > > > > > > > powers off does not get powered on back on resume.
> > >
> > > > > For example, "With s2idle, the machine isn't suspended via ACPI, so
> > > > > the AML code which powers the controller off isn't executed."  AFAICT
> > > > > that isn't actually a required, documented property of s2idle, but
> > > > > rather it reaches into the internal implementation.
> > >
> > > > > The code comment "If suspend mode is s2idle, power won't get restored
> > > > > on resume" is similar.  !pm_suspend_via_firmware() tells us that
> > > > > platform firmware won't be invoked.  But the connection between *that*
> > > > > and "power won't get restored" is unexplained.
> > > >
> > > > Sorry, I can't comment anything regarding AML and power management
> > > > in general since I am really new to all of this. However, regarding
> > > > the usage of the `pm_suspend_via_firmware()`: yeah, I also think it
> > > > is unclear what this does, and I was thinking about adding a wrapper
> > > > function something like `is_s2idle()` to the suspend.h, which would
> > > > simply call `pm_suspend_via_firmware` internally.
> > >
> > > No, that's not my point at all.  I don't really care whether the
> > > interface is called pm_suspend_via_firmware() or is_s2idle().
> > >
> > > What I don't like about this is that it's all just unexplained magic,
> > > as was the original quirk.
> > >
> > > IIUC, the quirk is applied by pci_pm_suspend_noirq() *after* it puts
> > > the device in a low-power state.  Here's my uninformed speculation
> > > about what happens:
> > >
> > >   - On suspend, pci_pm_suspend_noirq() puts device in low-power state.
> >
> > Right.
> >
> > >     My *guess* is this means D0 or D3hot for s2idle, and D3cold for
> > >     everything else.
> >
> > This really depends on the ACPI methods involved, but as a rule (and
> > I'm not aware of any exceptions) the target power state of the device
> > for s2idle and "everything else" is the same.  If D3cold is possible,
> > it will be D3cold.  If not, that will be D3hot etc.
> >
> > The only difference (from the individual device perspective) is that
> > in the ACPI S3 (or S4 if this matters here) case the platform firmware
> > (and that's not AML but something like SMM) may cut power off from it
> > later.
> >
> > >  [Do we have sufficient debug to find out what these states are?]
> >
> > I'm not sure what you mean.  What states are supported or something else?
>
> I was curious about what states we actually put this device in for
> s2idle/standby/s2ram/std because I was hoping we could decide based
> on what state s2idle used.  But if they all use the same target state,
> that idea won't work.
>
> > >   - pci_pm_suspend_noirq() does pci_fixup_suspend_late fixups,
> > >     including quirk_apple_poweroff_thunderbolt().
> > >
> > >   - quirk_apple_poweroff_thunderbolt() runs the magic SXIO/SXFP/SXLF
> > >     methods, which apparently turn off more power.
> > >
> > >   - On resume, pci_pm_resume_noirq() brings the device back to D0.
> > >
> > >     If we're resuming from standby, S2RAM, or STD, I speculate the
> > >     device is in D3cold, so this involves running AML that seems to
> > >     undo whatever SXIO/SXFP/SXLF did.
> >
> > The standby, S2RAM and STD cases are actually different in that respect.
> >
> > In the STD case we get the device from the restore kernel and it most
> > likely has been enumerated by it, so it is in whatever power state the
> > restore kernel puts it into.
> >
> > For standby that most likely is the state in which the device was left
> > during suspend.
> >
> > For S2RAM, it most likely will be something like D0-uninitialized,
> > because the platform firmware initiating the resume transition (which
> > is not AML, but again something like SMM) restores power to the
> > platform (including the majority of devices), but doesn't initialize
> > them as a rule.
> >
> > The STD and S2RAM resume will undo the "magic", standby resume may not.
> >
> > >     If we're resuming from s2idle, I speculate the device is in D0 or
> > >     D3hot, and we run different AML (or maybe no AML at all), and we
> >
> > It is in whatever power state it was left in during suspend and we run
> > the same AML as in the other cases, modulo the possible power state
> > difference (with respect to the other cases).
> >
> > >     *don't* undo the effects of SXIO/SXFP/SXLF, so the device doesn't
> > >     work.
> >
> > This is correct.
> >
> > > If the above is anything like what's happening, we should be able to
> > > skip SXIO/SXFP/SXLF based on the current power state of the device.
> >
> > Not really.
> >
> > > E.g., if the device is in D0 or D3hot, we should not use
> > > SXIO/SXFP/SXLF to yank power.
> > >
> > > That would seem more connected to the observable state of the device
> > > than using pm_suspend_via_firmware(), which relies on the connection
> > > between s2idle and PM_SUSPEND_FLAG_FW_SUSPEND (which is not at all
> > > obvious) and the power state of the device while in s2idle (also not
> > > obvious).
> >
> > The problem is related to the fact that in s2idle the platform
> > firmware does not finalize the suspend transition and, consequently,
> > it doesn't initiate the resume transition.  Therefore whatever power
> > state the device was left in during suspend must be dealt with during
> > the subsequent resume.  Hence, if whatever is done by SXIO/SXFP/SXLF
> > in the suspend path cannot be reversed in the resume path by the
> > kernel (because there is no known method to do that), they should not
> > be invoked.  And that's exactly because the platform firmware will not
> > finalize the suspend transition which is indicated by
> > PM_SUSPEND_FLAG_FW_SUSPEND being unset.
>
> How can we connect "if (!pm_suspend_via_firmware())" in this patch
> with the fact that firmware doesn't finalize suspend (and consequently
> does not reverse things in resume)?
>
> I don't see any use of pm_suspend_via_firmware() or
> PM_SUSPEND_FLAG_FW_SUSPEND that looks relevant.

First of all, there is a kerneldoc comment next to
pm_suspend_via_firmware() which is relevant.  Especially the last
paragraph of that comment applies directly to the case at hand IMV.

Next, if you see how pm_suspend_global_flags get populated, you'll
notice that pm_suspend_clear_flags() is called early in both the
system-wide suspend and hibernation paths and then the ACPI platform
callbacks invoke pm_set_suspend_via_firmware() when the platform is
going to finalize the suspend transition.  [In particular, notice the
acpi_state > ACPI_STATE_S1 condition in acpi_suspend_begin(), which is
related to the difference between ACPI S3/S4 and standby that I was
talking about before.]  This means that, on a system with ACPI,
PM_SUSPEND_FLAG_FW_SUSPEND is set only if the target system state is
above S1 and in those cases the firmware finalizes the suspend
transition.

Of course, s2idle callbacks don't invoke pm_set_suspend_via_firmware()
at all, because the target ACPI system state for s2idle is S0 (the
working state from the ACPI perspective).

> That makes it really hard to figure out how this patch works and how to avoid breaking it
> in the future.

Well, if you don't trust kerneldoc comments, you get to figure out
things yourself which may not be straightforward ...

> Thanks for your patience in explaining all this!

YW

Cheers!
