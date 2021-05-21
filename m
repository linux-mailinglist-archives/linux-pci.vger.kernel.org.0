Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F379B38C3BF
	for <lists+linux-pci@lfdr.de>; Fri, 21 May 2021 11:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhEUJtC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 May 2021 05:49:02 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:34404 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhEUJtB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 May 2021 05:49:01 -0400
Received: by mail-oo1-f49.google.com with SMTP id i8-20020a4aa1080000b0290201edd785e7so4442134ool.1;
        Fri, 21 May 2021 02:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8F85ALMx/ALzOG6W8AbyB4WWD6UFDnaExkKp/IYQypY=;
        b=JTJIrHHFbwysGoM4u1F0OxLZiEwBX1TZty4owzfkK9IsnMou1SU2zbVSdz0otmqusf
         iA3/iSveng6QsDMoxmrbxawY1SxewLFnVt4HjDlerqbany+f1b4EYeyEeQqWEXbcgxro
         H0MQzTLVeQmDXsQprPEKjcbX6AI1y31ARc9y3wqLjrnt7fSdmyp6BE3v8pX/jygnqfuo
         6ZbFDlJEFfr4uP0ZqnanDVKMSwAlxGvk+NvP+h4FldoL+2yPec+G4h90KT7aBT6B06aZ
         Ct7YGsARoEBeHYzMcgD/Xwnoss/Qk0qM6YJq46X48PK3BEyKyNHzFWmqCNOg+UQwOcNv
         rrpQ==
X-Gm-Message-State: AOAM533UJwjYUW17O5ZKmwmmU0gqmdik6AYVXjDTqwGttox0ZT4OXqad
        Jx4qBiveOLN3GLOiolOjDYgcTZrYdJKK5SQRH+w=
X-Google-Smtp-Source: ABdhPJxr7RxX1a8zQ2BlIgKJcvRVZs+Ys46A7SBQePR3Lay2jAJyLUycP9sL1K2dOnaqoWGJQRAnZQRCVg1KJvANc+c=
X-Received: by 2002:a4a:e5d5:: with SMTP id r21mr7574729oov.1.1621590457234;
 Fri, 21 May 2021 02:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0hLkEDgPstGkigMztUpiDyPzgjraaqtYs=SPzg8JWgVow@mail.gmail.com>
 <20210520194935.GA348608@bjorn-Precision-5520>
In-Reply-To: <20210520194935.GA348608@bjorn-Precision-5520>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 May 2021 11:47:25 +0200
Message-ID: <CAJZ5v0jr459rYezo6qmU+AnwT2ZWLbR0GGoM=NCTiznvpPSfzg@mail.gmail.com>
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

On Thu, May 20, 2021 at 9:49 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, May 20, 2021 at 01:54:05PM +0200, Rafael J. Wysocki wrote:
> > On Thu, May 20, 2021 at 1:27 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > On Wed, May 19, 2021 at 9:48 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Wed, May 19, 2021 at 09:12:26PM +0200, Rafael J. Wysocki wrote:
>
> > > > > The problem is related to the fact that in s2idle the platform
> > > > > firmware does not finalize the suspend transition and, consequently,
> > > > > it doesn't initiate the resume transition.  Therefore whatever power
> > > > > state the device was left in during suspend must be dealt with during
> > > > > the subsequent resume.  Hence, if whatever is done by SXIO/SXFP/SXLF
> > > > > in the suspend path cannot be reversed in the resume path by the
> > > > > kernel (because there is no known method to do that), they should not
> > > > > be invoked.  And that's exactly because the platform firmware will not
> > > > > finalize the suspend transition which is indicated by
> > > > > PM_SUSPEND_FLAG_FW_SUSPEND being unset.
> > > >
> > > > How can we connect "if (!pm_suspend_via_firmware())" in this patch
> > > > with the fact that firmware doesn't finalize suspend (and consequently
> > > > does not reverse things in resume)?
> > > >
> > > > I don't see any use of pm_suspend_via_firmware() or
> > > > PM_SUSPEND_FLAG_FW_SUSPEND that looks relevant.
> > >
> > > First of all, there is a kerneldoc comment next to
> > > pm_suspend_via_firmware() which is relevant.  Especially the last
> > > paragraph of that comment applies directly to the case at hand IMV.
>
> I do read kerneldoc, but I *rely* on the code, and it's nice when I
> can match up the kerneldoc with what the code is doing :)

Fair enough.

> Part of my confusion is that "passing control to platform firmware"
> isn't particularly useful in itself because it doesn't give a clue
> about what firmware is *doing*.  Without knowing what it does, we
> can't reason about how kernel's actions interact with firmware's
> actions.

While we don't know exactly what happens when the platform firmware is
running, we can reasonably expect that devices will get reset as a
result of that.

It's kind of like heating up things in a microwave oven: you don't
need to know exactly what happens when it is working, but nevertheless
you can predict with quite high confidence what the outcome of that
will be.

> > BTW, the problem at hand is not that s2idle in particular needs to be
> > treated in a special way (this appears to be the source of all
> > confusion here).  The problem is that the kernel cannot undo the
> > SXIO/SXFP/SXLF magic without passing control to the platform firmware.
>
> I assume this is really a case of "the kernel doesn't know *what* to
> do, but platform firmware does," so in principle the kernel *could*
> undo the SXIO/SXFP/SXLF magic if it knew what to do.

In general, that may or may not be the case.

I guess it is the case here, because Lukas seems to know how to make
this work, but the AML in question might be prepared with the
assumption that the firmware code finalizing the transition will run
after it.

> > And "passing control to the platform firmware" doesn't mean "executing
> > some AML" here, because control remains in the kernel when AML is
> > executed.  "Passing control to the platform firmware" means letting
> > some native firmware code (like SMM code) run which happens at the end
> > of S2/S3/S4 suspend transitions and it does not happen during S1
> > (standby) and s2idle suspend transitions.
> >
> > That's why using SXIO/SXFP/SXLF is only valid during S2/S3/S4 suspend
> > transitions and it is not valid during s2idle and S1 suspend
> > transitions (and yes, S1 is also affected, so s2idle is not special in
> > that respect at all).
> >
> > IMO the changelog of the patch needs to be rewritten, but the code
> > change made by it is reasonable.
>
> So IIUC the comment should say something like:
>
>   SXIO/SXFP/SXLF turns off power to the Thunderbolt controller.  We
>   don't know how to turn it back on again, but firmware does, so we
>   can only use SXIO/SXFP/SXLF if we're suspending via firmware.
>
> Actually, it sounds like the important thing is that we rely on the
> firmware *resume* path to turn on the power again.

Actually both the suspend and resume paths in it together, but the
important piece is that if the firmware runs at the end of suspend, it
will also run at the beginning of resume.

> pm_resume_via_firmware() *sounds* like it would be appropriate, but
> the kerneldoc says that's for use after resume,

That's right.

The rule of thumb is to use pm_suspend_via_firmware() in the
system-wide suspend code paths and pm_resume_via_firmware() in the
resume ones.  They are simply complementary.

And because in this particular case a decision needs to be made
whether or not to do something in a suspend path, the former is the
right one to use.

> and it tells us whether firmware has *already* handled the wakeup event.  And
> PM_SUSPEND_FLAG_FW_RESUME isn't set until after we've run these
> suspend_late fixups, so it wouldn't work here.

Right.
