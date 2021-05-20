Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B573638AD27
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 13:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242442AbhETL5h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 07:57:37 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:41677 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239154AbhETLzj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 May 2021 07:55:39 -0400
Received: by mail-oi1-f180.google.com with SMTP id c3so16117300oic.8;
        Thu, 20 May 2021 04:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nBF/qZhl/lWwbVnTFRmdgbGODycrL0FmHATVCDsRyN8=;
        b=YW+RbfO0BGvViVoVELECtJxHgvMok15r49kgQFECI6jk5IUyWa5fkT0AWZvWZD3DE5
         0y0EsjWwEUnGsgfr6obBvKggpd9IjEFnjl92jnkQy0dqBJcUlpdy/5ZvfOrfVFU5aLxz
         D6Eh9kcS3/l832DM1MLDa8PZKcrSlbcMOEPZp/3FtXhkKne2lWxz95Xut4oahwpVmqKy
         2eZukNclk+TcItNBO9/fKjMLFazca/GJm6Ah5f+CsC8stOlGhohAC4sIwTr40Lammfy8
         ghn6pXJUAR9fF/tg1w5Bp0Vwgf5BddJaeiGSfTWPR7QxggHWhqhDR+mzizTpt9oA9h4m
         ovng==
X-Gm-Message-State: AOAM530ODqzCa5UuQiUdZc8gd23D7ssjoa6Pd6CHe0sSXbXFKyTr4NmQ
        xmJXBavcg7mv4F3DTatT8b7lFsUn47QvEwNDZ7w=
X-Google-Smtp-Source: ABdhPJyavlzoKKhASMIvS9v1N4TCXJ4Go9QlgEHhqwv3X/8MzoRZker3PpeNyqkFZKSchuFfsi24VBGJ7ohVTXfSbEA=
X-Received: by 2002:aca:1910:: with SMTP id l16mr2832928oii.69.1621511656630;
 Thu, 20 May 2021 04:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0ijqL0ZpdwBvwY=Y9Ubuvd-Kr2s-NfUOKX_Ev3GB+pHww@mail.gmail.com>
 <20210519194853.GA249712@bjorn-Precision-5520> <CAJZ5v0i+s7Ru5J5Um0tExMGCnK0JGTnc76BYyd58EiYkt6dghQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0i+s7Ru5J5Um0tExMGCnK0JGTnc76BYyd58EiYkt6dghQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 May 2021 13:54:05 +0200
Message-ID: <CAJZ5v0hLkEDgPstGkigMztUpiDyPzgjraaqtYs=SPzg8JWgVow@mail.gmail.com>
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

On Thu, May 20, 2021 at 1:27 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, May 19, 2021 at 9:48 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Wed, May 19, 2021 at 09:12:26PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, May 19, 2021 at 7:28 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Fri, May 07, 2021 at 05:08:42PM +0300, Konstantin Kharlamov wrote:
> > > > > On Fri, 2021-05-07 at 08:30 -0500, Bjorn Helgaas wrote:
> > > > > > On Fri, May 07, 2021 at 12:07:38AM +0200, Lukas Wunner wrote:
> > > > > > > On Thu, May 06, 2021 at 04:48:42PM -0500, Bjorn Helgaas wrote:
> > > > > > > > On Thu, May 06, 2021 at 08:38:20PM +0300, Konstantin Kharlamov wrote:
> > > > > > > > > On Macbook 2013 resuming from s2idle results in external monitor no
> > > > > > > > > longer being detected, and dmesg having errors like:
> > > > > > > > >
> > > > > > > > >     pcieport 0000:06:00.0: can't change power state from D3hot to D0
> > > > > > > > > (config space inaccessible)
> > > > > > > > >
> > > > > > > > > and a stacktrace. The reason turned out that the hw that the quirk
> > > > > > > > > powers off does not get powered on back on resume.
> > > >
> > > > > > For example, "With s2idle, the machine isn't suspended via ACPI, so
> > > > > > the AML code which powers the controller off isn't executed."  AFAICT
> > > > > > that isn't actually a required, documented property of s2idle, but
> > > > > > rather it reaches into the internal implementation.
> > > >
> > > > > > The code comment "If suspend mode is s2idle, power won't get restored
> > > > > > on resume" is similar.  !pm_suspend_via_firmware() tells us that
> > > > > > platform firmware won't be invoked.  But the connection between *that*
> > > > > > and "power won't get restored" is unexplained.
> > > > >
> > > > > Sorry, I can't comment anything regarding AML and power management
> > > > > in general since I am really new to all of this. However, regarding
> > > > > the usage of the `pm_suspend_via_firmware()`: yeah, I also think it
> > > > > is unclear what this does, and I was thinking about adding a wrapper
> > > > > function something like `is_s2idle()` to the suspend.h, which would
> > > > > simply call `pm_suspend_via_firmware` internally.
> > > >
> > > > No, that's not my point at all.  I don't really care whether the
> > > > interface is called pm_suspend_via_firmware() or is_s2idle().
> > > >
> > > > What I don't like about this is that it's all just unexplained magic,
> > > > as was the original quirk.
> > > >
> > > > IIUC, the quirk is applied by pci_pm_suspend_noirq() *after* it puts
> > > > the device in a low-power state.  Here's my uninformed speculation
> > > > about what happens:
> > > >
> > > >   - On suspend, pci_pm_suspend_noirq() puts device in low-power state.
> > >
> > > Right.
> > >
> > > >     My *guess* is this means D0 or D3hot for s2idle, and D3cold for
> > > >     everything else.
> > >
> > > This really depends on the ACPI methods involved, but as a rule (and
> > > I'm not aware of any exceptions) the target power state of the device
> > > for s2idle and "everything else" is the same.  If D3cold is possible,
> > > it will be D3cold.  If not, that will be D3hot etc.
> > >
> > > The only difference (from the individual device perspective) is that
> > > in the ACPI S3 (or S4 if this matters here) case the platform firmware
> > > (and that's not AML but something like SMM) may cut power off from it
> > > later.
> > >
> > > >  [Do we have sufficient debug to find out what these states are?]
> > >
> > > I'm not sure what you mean.  What states are supported or something else?
> >
> > I was curious about what states we actually put this device in for
> > s2idle/standby/s2ram/std because I was hoping we could decide based
> > on what state s2idle used.  But if they all use the same target state,
> > that idea won't work.
> >
> > > >   - pci_pm_suspend_noirq() does pci_fixup_suspend_late fixups,
> > > >     including quirk_apple_poweroff_thunderbolt().
> > > >
> > > >   - quirk_apple_poweroff_thunderbolt() runs the magic SXIO/SXFP/SXLF
> > > >     methods, which apparently turn off more power.
> > > >
> > > >   - On resume, pci_pm_resume_noirq() brings the device back to D0.
> > > >
> > > >     If we're resuming from standby, S2RAM, or STD, I speculate the
> > > >     device is in D3cold, so this involves running AML that seems to
> > > >     undo whatever SXIO/SXFP/SXLF did.
> > >
> > > The standby, S2RAM and STD cases are actually different in that respect.
> > >
> > > In the STD case we get the device from the restore kernel and it most
> > > likely has been enumerated by it, so it is in whatever power state the
> > > restore kernel puts it into.
> > >
> > > For standby that most likely is the state in which the device was left
> > > during suspend.
> > >
> > > For S2RAM, it most likely will be something like D0-uninitialized,
> > > because the platform firmware initiating the resume transition (which
> > > is not AML, but again something like SMM) restores power to the
> > > platform (including the majority of devices), but doesn't initialize
> > > them as a rule.
> > >
> > > The STD and S2RAM resume will undo the "magic", standby resume may not.
> > >
> > > >     If we're resuming from s2idle, I speculate the device is in D0 or
> > > >     D3hot, and we run different AML (or maybe no AML at all), and we
> > >
> > > It is in whatever power state it was left in during suspend and we run
> > > the same AML as in the other cases, modulo the possible power state
> > > difference (with respect to the other cases).
> > >
> > > >     *don't* undo the effects of SXIO/SXFP/SXLF, so the device doesn't
> > > >     work.
> > >
> > > This is correct.
> > >
> > > > If the above is anything like what's happening, we should be able to
> > > > skip SXIO/SXFP/SXLF based on the current power state of the device.
> > >
> > > Not really.
> > >
> > > > E.g., if the device is in D0 or D3hot, we should not use
> > > > SXIO/SXFP/SXLF to yank power.
> > > >
> > > > That would seem more connected to the observable state of the device
> > > > than using pm_suspend_via_firmware(), which relies on the connection
> > > > between s2idle and PM_SUSPEND_FLAG_FW_SUSPEND (which is not at all
> > > > obvious) and the power state of the device while in s2idle (also not
> > > > obvious).
> > >
> > > The problem is related to the fact that in s2idle the platform
> > > firmware does not finalize the suspend transition and, consequently,
> > > it doesn't initiate the resume transition.  Therefore whatever power
> > > state the device was left in during suspend must be dealt with during
> > > the subsequent resume.  Hence, if whatever is done by SXIO/SXFP/SXLF
> > > in the suspend path cannot be reversed in the resume path by the
> > > kernel (because there is no known method to do that), they should not
> > > be invoked.  And that's exactly because the platform firmware will not
> > > finalize the suspend transition which is indicated by
> > > PM_SUSPEND_FLAG_FW_SUSPEND being unset.
> >
> > How can we connect "if (!pm_suspend_via_firmware())" in this patch
> > with the fact that firmware doesn't finalize suspend (and consequently
> > does not reverse things in resume)?
> >
> > I don't see any use of pm_suspend_via_firmware() or
> > PM_SUSPEND_FLAG_FW_SUSPEND that looks relevant.
>
> First of all, there is a kerneldoc comment next to
> pm_suspend_via_firmware() which is relevant.  Especially the last
> paragraph of that comment applies directly to the case at hand IMV.

BTW, the problem at hand is not that s2idle in particular needs to be
treated in a special way (this appears to be the source of all
confusion here).  The problem is that the kernel cannot undo the
SXIO/SXFP/SXLF magic without passing control to the platform firmware.

And "passing contol to the platform firmware" doesn't mean "executing
some AML" here, because control remains in the kernel when AML is
executed.  "Passing control to the platform firmware" means letting
some native firmware code (like SMM code) run which happens at the end
of S2/S3/S4 suspend transitions and it does not happen during S1
(standby) and s2idle suspend transitions.

That's why using SXIO/SXFP/SXLF is only valid during S2/S3/S4 suspend
transitions and it is not valid during s2idle and S1 suspend
transitions (and yes, S1 is also affected, so s2idle is not special in
that respect at all).

IMO the changelog of the patch needs to be rewritten, but the code
change made by it is reasonable.

Cheers!
