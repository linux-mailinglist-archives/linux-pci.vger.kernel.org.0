Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBA630833F
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jan 2021 02:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhA2Bbl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 20:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhA2BbX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2021 20:31:23 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91146C061574;
        Thu, 28 Jan 2021 17:30:42 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id k8so7177446otr.8;
        Thu, 28 Jan 2021 17:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cGKWZfOvrSWPATU3fA4o+Sejn9j2AxeGUg6tCFIll98=;
        b=jkvuUnBsIg+7yormfly8fvT/Y+lJzqwcBvLDM0c4Dlb08Cgn/a+t5M+0++Gp4COXS1
         fElA6rU3UdMVfSHmcAX/VAlM91kz8UbvQSV/U4VwReSs+jeO8amA9aaG4ZpFkQVCekr7
         OmgzYpXxEKQVvHwwKdgPZ4s0BWhC4EMG3dwisY8IuDra6n9DRzd3B/mxMUApTZg2CQVZ
         jZMdUUwFFUi7Y3jT7MEEljzd83YeX7ar7h+eFMdMbiDzFn5wwrH9wReTOJREByRyATQB
         MHSvqxgHF+xomJaKIeTZ7Cdxh+qIPpXUmHXla8qJZh4rl7+Fgg5TFZMVpuqtxiJjto+M
         sVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cGKWZfOvrSWPATU3fA4o+Sejn9j2AxeGUg6tCFIll98=;
        b=s/BalyTKnv0W65WH93EsDfJMEkM5YetoeLgFqBVotaTGK7YuTo1AJ1YXsUWct3MGpy
         R0zIZC+VazJUWhscF9w6gyH70//sdekrA+b8KGZDNX5pbS9h2cTM0sZZGkUeOBI2uoW1
         qM9Q5h3gr9XV4u1qJcSK8WyU82bhdyMWUEf35ZjWjCBFrS6EQK6IPL6yG+OTeslxd6Fr
         8WaJ3BPkgJ8ZpX7WmR/GVdgbWTdBqo/Mln4zzOWSOde9+7EsydMtjA0tJNwb5uQrLQ9H
         8DpbrPpWydxkkruABFvozCv1R43QtD4W+nyXC/g8rxvobVGVqy9OpA+2s7cCxnyKON/c
         66cA==
X-Gm-Message-State: AOAM533bkJMwozHKXjpF2ejXcr8OcdvZsV9N+rEVU48YksIaEGAUcmNp
        +yp0KH31kz7PG3yrIeZuaU2BpYKeg0uL//N6pNM=
X-Google-Smtp-Source: ABdhPJxahw8SU4xkm8h1Lu4hXo7R8sh8LWlxy9e/S++UZwV8fzg0GTI/oiMiXsgg3YT4Kc7g/8+ryyV++gPb+LxO37s=
X-Received: by 2002:a9d:1293:: with SMTP id g19mr1487102otg.311.1611883841513;
 Thu, 28 Jan 2021 17:30:41 -0800 (PST)
MIME-Version: 1.0
References: <20200222165840.GA214760@google.com> <20210128233929.GA39660@bjorn-Precision-5520>
In-Reply-To: <20210128233929.GA39660@bjorn-Precision-5520>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 28 Jan 2021 20:30:30 -0500
Message-ID: <CADnq5_MFVwC4a=J0praBOs+yiK691oJi6V8ihgJm_5wswPPWxA@mail.gmail.com>
Subject: Re: Issues with "PCI/LINK: Report degraded links via link bandwidth notification"
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>,
        Jan Vesely <jano.vesely@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>,
        Sinan Kaya <okaya@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Dave Airlie <airlied@gmail.com>,
        Ben Skeggs <skeggsb@gmail.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        "A. Vladimirov" <vladimirov.atanas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 28, 2021 at 6:39 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Atanas -- thank you very much for the bug report!]
>
> On Sat, Feb 22, 2020 at 10:58:40AM -0600, Bjorn Helgaas wrote:
> > On Wed, Jan 15, 2020 at 04:10:08PM -0600, Bjorn Helgaas wrote:
> > > I think we have a problem with link bandwidth change notifications
> > > (see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/bw_notification.c).
> > >
> > > Here's a recent bug report where Jan reported "_tons_" of these
> > > notifications on an nvme device:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=206197
> >
> > AFAICT, this thread petered out with no resolution.
> >
> > If the bandwidth change notifications are important to somebody,
> > please speak up, preferably with a patch that makes the notifications
> > disabled by default and adds a parameter to enable them (or some other
> > strategy that makes sense).
> >
> > I think these are potentially useful, so I don't really want to just
> > revert them, but if nobody thinks these are important enough to fix,
> > that's a possibility.
>
> Atanas is also seeing this problem and went to the trouble of digging
> up this bug report:
> https://bugzilla.kernel.org/show_bug.cgi?id=206197#c8
>
> I'm actually a little surprised that we haven't seen more reports of
> this.  I don't think distros enable CONFIG_PCIE_BW, but even so, I
> would think more people running upstream kernels would trip over it.
> But maybe people just haven't turned CONFIG_PCIE_BW on.
>
> I don't have a suggestion; just adding Atanas to this old thread.
>
> > > There was similar discussion involving GPU drivers at
> > > https://lore.kernel.org/r/20190429185611.121751-2-helgaas@kernel.org
> > >
> > > The current solution is the CONFIG_PCIE_BW config option, which
> > > disables the messages completely.  That option defaults to "off" (no
> > > messages), but even so, I think it's a little problematic.
> > >
> > > Users are not really in a position to figure out whether it's safe to
> > > enable.  All they can do is experiment and see whether it works with
> > > their current mix of devices and drivers.
> > >
> > > I don't think it's currently useful for distros because it's a
> > > compile-time switch, and distros cannot predict what system configs
> > > will be used, so I don't think they can enable it.
> > >
> > > Does anybody have proposals for making it smarter about distinguishing
> > > real problems from intentional power management, or maybe interfaces
> > > drivers could use to tell us when we should ignore bandwidth changes?

There's also this recently filed bug:
https://gitlab.freedesktop.org/drm/amd/-/issues/1447
The root cause of it appears to be related to ASPM.

Alex
