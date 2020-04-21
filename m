Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4247C1B23E1
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 12:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgDUKa6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Apr 2020 06:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbgDUKa5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Apr 2020 06:30:57 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64070C061A41
        for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2020 03:30:57 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id i5so3370406uaq.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2020 03:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Nmmt4cUyHLEe6qve6WvcXD9XM2QrRLQtbhGo4+r1qY=;
        b=KycdRg1y9oQM3pZPaP3bxRnhvW1zUmoQIZW2WRzxFR2dQn/3L4nMD8XzdppM8rTkZ1
         m8aCfMmSkq/htN3OrmP7HBWGtLYHToudPjD8M8ZqZD+PW90JzYDbk0WqZP+D4YFljGJ4
         VKCkoDHOYm82W6pyaTLd5gjAuSdQnWwL5SM2tXDmCG0d2VAvVArx7zWPt9Y+Dplm9ykj
         AwnU3caAvLH/DIlTeloP07h0x+NMLq+s8LVzkPbObaHMecie8vvUYuJKAiPLGebkdG5o
         Hb5JUODBuPGnGPHLnCglQWCwG/GlsoJhEaAg3FskzyNDu3V2k1CTXv6Ahy0ruIzMoaLh
         kddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Nmmt4cUyHLEe6qve6WvcXD9XM2QrRLQtbhGo4+r1qY=;
        b=KK7qHUMZys2LwWBaMB9bbx0yfpe/v3HSpZugaXC0RySng3ynfp3A/rKJwBaxyJQcDz
         Otk1TsDZKyealphSR2gd8McSZs0vt2A59gCtU5vVVrOMOPdWdVuWnXLwAEMBP+Jkr4dz
         Beh0BVh8pu8fdH6QmpoCItbJSekCqsfKxfCBMKMzH+3TbKkZncTjmTuoRoxykBRa5qiK
         IBdR4F920erTewS4jf3vZcpZ1fjDnvfrID9rMoaiPBzFv9eu6tksvCo+WD+mt4CSNyaY
         DjULDZwZzSyorg0MaZIbIoJKXdSWK/LxLXjkIw8pCZo8gjp8mdi4LSjH+z3yQrweV0SW
         CzoA==
X-Gm-Message-State: AGi0PuZn247jA8UQCI+AOHiFoMt/oTmdF3aADFbMbjyy/TgbqHlJlfXk
        7d1iCsXLIH9mbIRtbtgd/mERM+Va5sem6qnL9zTYDA==
X-Google-Smtp-Source: APiQypJjJlGRUhECl9LUNHsivRWgdQRbBS7vnJgH8AQX+Nfndksy1VNAV4ImNERQV4t9bCWuXCZorue5jXGTrIUmCJ0=
X-Received: by 2002:a9f:25af:: with SMTP id 44mr11675574uaf.104.1587465054589;
 Tue, 21 Apr 2020 03:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <1888197.j9z7NJ8yPn@kreacher> <5673945.BT02kTCndr@kreacher>
In-Reply-To: <5673945.BT02kTCndr@kreacher>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Apr 2020 12:30:18 +0200
Message-ID: <CAPDyKFoV-gMn34nghBBK91pRYy3c90D8jrA4-OP2SGxQPzxgdg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] PM: sleep: core: Rearrange the handling of driver
 power management flags
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
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

On Sat, 18 Apr 2020 at 19:11, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi,
>
> This is an update including some fixes and extra patches based on the
> continuation of the discussion [1].
>
> On Friday, April 10, 2020 5:46:27 PM CEST Rafael J. Wysocki wrote:
> > Hi Alan,
> >
> > Following our recent discussion regarding the DPM_FLAG_* family of flags [1],
> > I have decided to follow some of your recommendations and make changes to the
> > core code handling those flags.
> >
> > The purpose of this is basically to make the code more consistent internally,
> > easier to follow and better documented.
> >
> > First of all, patch [1/7] changes the PM core to skip driver-level "late"
> > and "noirq" suspend callbacks for devices with SMART_SUSPEND set if they are
> > still runtime-suspended during the "late" system-wide suspend phase (without
> > the patch it does that only if subsystem-level late/noirq/early suspend/resume
> > callbacks are not present for the device, which is demonstrably inconsistent)
> > and updates the resume part of the code accordingly (it doesn't need to check
> > whether or not the subsystem-level callbacks are present any more).
> >
> > The next patch, [2/7], is purely cosmetic and its only purpose is to reduce
> > the LOC number and move related pieces of code closer to each other.
>
> The first two patches have not changed.
>
> > Patch [3/7] changes the PM core so that it doesn't skip any subsystem-level
> > callbacks during system-wide resume (without the patch they may be skipped in
> > the "early resume" and "resume" phases due to LEAVE_SUSPENDED being set which
> > may be problematic) and to always run the driver's ->resume callback if the
> > corresponding subsystem-level callback is not present (without the patch it
> > may be skipped if LEAVE_SUSPENDED is set) to let it reverse the changes made
> > by the driver's ->suspend callback (which always runs too) if need be.
>
> The difference between this one and patch [3/9] in the v2 is the fixed
> definition of dev_pm_may_skip_resume(), renamed to dev_pm_skip_resume() by
> one of the next patches.
>
> Patch [4/9] changes the handling of the power.may_skip_resume flag to set it
> to 'true' by default and updates the subsystems aware of it to clear it when
> they don't want devices to stay in suspend.
>
> > Patches [4-6/7] rename one function in the PM core and two driver PM flags to
> > make their names better reflect their purpose.
>
> These are patches [5/9] and [7-8/9] in the v2 and patch [6/9] renames
> dev_pm_smart_suspend_and_suspended() to dev_pm_skip_suspend().
>
> > Finally, patch [7/7] updates the documentation of the driver PM flags to
> > reflect the new code flows.
>
> This patch [9/9] now and it has been updated to reflect the new code changes.
>
> The pm-sleep-core branch:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>   pm-sleep-core
>
> contains the v2 now.
>
> Cheers!

Rafael, apologize for taking some time to review and respond. I
noticed you have queued this up on your next branch by now, good.

In any case, I have looked through the series and I think it looks good, thanks!

Kind regards
Uffe

>
>
> [1] https://lore.kernel.org/linux-pm/Pine.LNX.4.44L0.2003251631360.1724-100000@netrider.rowland.org/
>
>
>
