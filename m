Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E99C1B2525
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 13:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgDULdM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Apr 2020 07:33:12 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37883 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgDULdL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Apr 2020 07:33:11 -0400
Received: by mail-oi1-f196.google.com with SMTP id r25so11723615oij.4;
        Tue, 21 Apr 2020 04:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HW9k9kfTW78ME8X5ahcJnyYNk11gvYfm0hTWpxib3PU=;
        b=kYvcoUfMP/IQ7Y6lMxW/hMoH6vfLAB8YNs0GbF86ZOQVMVLOUTKQP2lxTEekdIsDG2
         4D+YgLjQ4nG+RF0UfYG+gjNjm/bsGNoI4m3bCc/tbXsURFclaCoj1wO6QHUeCOSvnnmA
         qLYmDxVxpoOVePbkjlkZ5dlpyz0CjySv402aFuvvALMn3YqVA6QoPkR4c1Js1hdw0sVM
         dEUZCM85svc8SlKV/782qF1dR1QgAwE4ujVaM6ptsVpfERBtR5cy9OrKnxGTrIbjWYxv
         xgnh6yZn953cam1OUmga8jb+NCUd15z078f5WYFuN4KYe4TTdgJfdiKr3K8KSYyFL2rR
         vu5A==
X-Gm-Message-State: AGi0PuaHaSS7sjkPjqcZpMa9uBZWkCfVM15K1oiUEYL9356Vk1qrsFgP
        przzXsJgKtk5DyuDqqru6H3i0NW58iE8wqnbf1o=
X-Google-Smtp-Source: APiQypLN96ZexQcfh1NyKo0/zqGY6oMeGu2AGd9i5r1cD0mnDcePTx9i44H4ZpIkfqEAujnUYUtfIKys73CXfTqBwXU=
X-Received: by 2002:a05:6808:81:: with SMTP id s1mr2709126oic.68.1587468790638;
 Tue, 21 Apr 2020 04:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <1888197.j9z7NJ8yPn@kreacher> <5673945.BT02kTCndr@kreacher> <CAPDyKFoV-gMn34nghBBK91pRYy3c90D8jrA4-OP2SGxQPzxgdg@mail.gmail.com>
In-Reply-To: <CAPDyKFoV-gMn34nghBBK91pRYy3c90D8jrA4-OP2SGxQPzxgdg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 21 Apr 2020 13:32:50 +0200
Message-ID: <CAJZ5v0hsVZQpm5SFfvCQQMNURJ28RNd+i6Cyh=ZUmt+izZhvRw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] PM: sleep: core: Rearrange the handling of driver
 power management flags
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 21, 2020 at 12:30 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Sat, 18 Apr 2020 at 19:11, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > Hi,
> >
> > This is an update including some fixes and extra patches based on the
> > continuation of the discussion [1].
> >
> > On Friday, April 10, 2020 5:46:27 PM CEST Rafael J. Wysocki wrote:
> > > Hi Alan,
> > >
> > > Following our recent discussion regarding the DPM_FLAG_* family of flags [1],
> > > I have decided to follow some of your recommendations and make changes to the
> > > core code handling those flags.
> > >
> > > The purpose of this is basically to make the code more consistent internally,
> > > easier to follow and better documented.
> > >
> > > First of all, patch [1/7] changes the PM core to skip driver-level "late"
> > > and "noirq" suspend callbacks for devices with SMART_SUSPEND set if they are
> > > still runtime-suspended during the "late" system-wide suspend phase (without
> > > the patch it does that only if subsystem-level late/noirq/early suspend/resume
> > > callbacks are not present for the device, which is demonstrably inconsistent)
> > > and updates the resume part of the code accordingly (it doesn't need to check
> > > whether or not the subsystem-level callbacks are present any more).
> > >
> > > The next patch, [2/7], is purely cosmetic and its only purpose is to reduce
> > > the LOC number and move related pieces of code closer to each other.
> >
> > The first two patches have not changed.
> >
> > > Patch [3/7] changes the PM core so that it doesn't skip any subsystem-level
> > > callbacks during system-wide resume (without the patch they may be skipped in
> > > the "early resume" and "resume" phases due to LEAVE_SUSPENDED being set which
> > > may be problematic) and to always run the driver's ->resume callback if the
> > > corresponding subsystem-level callback is not present (without the patch it
> > > may be skipped if LEAVE_SUSPENDED is set) to let it reverse the changes made
> > > by the driver's ->suspend callback (which always runs too) if need be.
> >
> > The difference between this one and patch [3/9] in the v2 is the fixed
> > definition of dev_pm_may_skip_resume(), renamed to dev_pm_skip_resume() by
> > one of the next patches.
> >
> > Patch [4/9] changes the handling of the power.may_skip_resume flag to set it
> > to 'true' by default and updates the subsystems aware of it to clear it when
> > they don't want devices to stay in suspend.
> >
> > > Patches [4-6/7] rename one function in the PM core and two driver PM flags to
> > > make their names better reflect their purpose.
> >
> > These are patches [5/9] and [7-8/9] in the v2 and patch [6/9] renames
> > dev_pm_smart_suspend_and_suspended() to dev_pm_skip_suspend().
> >
> > > Finally, patch [7/7] updates the documentation of the driver PM flags to
> > > reflect the new code flows.
> >
> > This patch [9/9] now and it has been updated to reflect the new code changes.
> >
> > The pm-sleep-core branch:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >   pm-sleep-core
> >
> > contains the v2 now.
> >
> > Cheers!
>
> Rafael, apologize for taking some time to review and respond. I
> noticed you have queued this up on your next branch by now, good.
>
> In any case, I have looked through the series and I think it looks good, thanks!

Thanks for letting me know!

Cheers!
