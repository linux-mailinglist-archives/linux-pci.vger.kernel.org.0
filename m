Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28371F5CF1
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 22:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgFJUSY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 16:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgFJUSH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2020 16:18:07 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D574C03E96B;
        Wed, 10 Jun 2020 13:18:07 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id j32so2838985qte.10;
        Wed, 10 Jun 2020 13:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=7CkAuH/KjURv8CG9o3SLd0fsTeaBJlmewEeCSoCm5wY=;
        b=bPiua6VblPUD0IJ3waHkiHOWs+zZiwE4eWALolbiTeVjEyl6YnjyqemPI34VUmPH4l
         DDyhYRx4vHXfOVgbg4kWDFfVQaeokJPEnAx3qR/rgl1a1TwtaFinU2IP5UEelOhsv67n
         QP0v2RikDJfJ+/AKeErXbAsuS+pxOg1iao8/ENr4RhjlWS/x5o8TUZK94/Suzx++NqKl
         ifRt4EifGGW0VsW5aHrA9tJ4kjYnqzXuR5hbyPxeJZ5YdcYxjUdb/hHIM3bUJOAgaoSr
         KiCDVkZtNqL3Xvg+yg7vf1oTg9gCrHGsoczk/f0w6gHi/dkfzKuQIhleRM7NdKDt+neD
         aQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=7CkAuH/KjURv8CG9o3SLd0fsTeaBJlmewEeCSoCm5wY=;
        b=YBQkMG3O8fcHZFPHJeXaq98UiiIBeRKQciDVysqSrO4pXhBdLDRGgp3S5IV4yja4CF
         Rpgmgv/aCcEgHxe26NDx6VcJCDKSMTfeBwoDAoOYFoGHXsmdpH2yQAIoGhu+TQ6JchMx
         0Qz9L6KR+j0fTsVzicxMFS389sEIdayjxP3JzNGyUZCctLJCPgSbZdwqBTBEP7l2hiT1
         0Aoxr2fE7TrNDglQlR3diolr4SAydqEic1oU2Y954VReCBgbIWVhfACSG+J6ORe2CKqh
         leTwjPaJc+TJTmO0CI7b/qBjdBTBErfdN5c22ArgAe4ZE+eUVof3LUYZWqwnQ4v9MApQ
         YJKg==
X-Gm-Message-State: AOAM532oqZBxboAwwHUyhHqh48QO3P+5nrh0KS1z3Ir9rgrLdMkMN0F+
        YPah4mVOETbBjVIVnAL0bvnGAVmHxiKHQJejBFg=
X-Google-Smtp-Source: ABdhPJyY3AhIfu/0DciBlS2fSciSq6ChYssUk19VEbN1X+yfNKDLG0zJvUJ3kaCMHElVQwqca5k5bwlihA/sMO2b4AE=
X-Received: by 2002:ac8:2fb0:: with SMTP id l45mr4997434qta.260.1591820286253;
 Wed, 10 Jun 2020 13:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6E0s-Y207sb-AqSHVB7KmhvDgJQFFaz6ijQ_0OS3Qjisw@mail.gmail.com>
 <20200610000400.GA1473845@bjorn-Precision-5520> <CACK8Z6G3ycsXxuNiihOXiwwAum8=5aOFOshhFa7cEF__+c-v1A@mail.gmail.com>
In-Reply-To: <CACK8Z6G3ycsXxuNiihOXiwwAum8=5aOFOshhFa7cEF__+c-v1A@mail.gmail.com>
Reply-To: rajatxjain@gmail.com
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Wed, 10 Jun 2020 13:17:54 -0700
Message-ID: <CAA93t1pFqsi2a-LGP7+eHpCmSvzoDfWEe7KSeFx6wt2caeFA1A@mail.gmail.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
To:     Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 9, 2020 at 5:30 PM Rajat Jain <rajatja@google.com> wrote:
>
> On Tue, Jun 9, 2020 at 5:04 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Tue, Jun 09, 2020 at 04:23:54PM -0700, Rajat Jain wrote:
> > > Hi Bjorn,
> > >
> > > Thanks for sending out the summary, I was about to send it out but got lazy.
> > >
> > > On Tue, Jun 9, 2020 at 2:04 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > On Sun, Jun 07, 2020 at 01:36:32PM +0200, Greg Kroah-Hartman wrote:
> > > >
> > > > > Your "problem" I think can be summed up a bit more concise:
> > > > >       - you don't trust kernel drivers to be "secure" for untrusted
> > > > >         devices
> > > > >       - you only want to bind kernel drivers to "internal" devices
> > > > >         automatically as you "trust" drivers in that situation.
> > > > >       - you want to only bind specific kernel drivers that you somehow
> > > > >         feel are "secure" to untrusted devices "outside" of a system
> > > > >         when those devices are added to the system.
> > > > >
> > > > > Is that correct?
> > > > >
> > > > > If so, fine, you can do that today with the bind/unbind ability of
> > > > > drivers, right?  After boot with your "trusted" drivers bound to
> > > > > "internal" devices, turn off autobind of drivers to devices and then
> > > > > manually bind them when you see new devices show up, as those "must" be
> > > > > from external devices (see the bind/unbind files that all drivers export
> > > > > for how to do this, and old lwn.net articles, this feature has been
> > > > > around for a very long time.)
> > > > >
> > > > > I know for USB you can do this, odds are PCI you can turn off
> > > > > autobinding as well, as I think this is a per-bus flag somewhere.  If
> > > > > that's not exported to userspace, should be trivial to do so, should be
> > > > > somewere in the driver model already...
> > > > >
> > > > > Ah, yes, look at the "drivers_autoprobe" and "drivers_probe" files in
> > > > > sysfs for all busses.  Do those not work for you?
> > > > >
> > > > > My other points are the fact that you don't want to put policy in the
> > > > > kernel, and I think that you can do everything you want in userspace
> > > > > today, except maybe the fact that trying to determine what is "inside"
> > > > > and "outside" is not always easy given that most hardware does not
> > > > > export this information properly, if at all.  Go work with the firmware
> > > > > people on that issue please, that would be most helpful for everyone
> > > > > involved to get that finally straightened out.
> > > >
> > > > To sketch this out, my understanding of how this would work is:
> > > >
> > > >   - Expose the PCI pdev->untrusted bit in sysfs.  We don't expose this
> > > >     today, but doing so would be trivial.  I think I would prefer a
> > > >     sysfs name like "external" so it's more descriptive and less of a
> > > >     judgment.
> > >
> > > Yes. I think we should probably semantically differentiate between
> > > "external" and "external facing" devices. Root ports and downstream
> > > ports can be "external facing" but are actually internal devices.
> > > Anything below an "external facing" device is "external". So the sysfs
> > > attribute "external" should be set only for devices that are truly
> > > external.
> >
> > Good point; we (maybe you? :)) should fix that edge case.
>

I realized that we may not need to distinguish between internal and
external devices if we can assume that no internal PCI devices will
show up after boot. That assumption is 99% true for our use case
(leaving 1% out because we have some corner cases i.e. PCIe rescans,
module insertions etc that may probably make some internal devices
disappear and reappear).  If I find that I can do without the need for
a UAPI to distinguish internal vs external devices, do you still want
me to fix this edge case (i.e. "break" the pdev->untrusted flag into
"external_facing" and "external" devices)?

Thanks,

Rajat

> Sure, happy to. I will start a fresh conversation about that (in a
> separate thread).
>
> >
> > > Just a suggestion: Do you think an enum attribute may be better
> > > instead, whose values could be "internal" / "external" /
> > > "external-facing" in case need arises later to distinguish between
> > > them?
> >
> > I don't see the need for an enum yet.  Maybe we should add that
> > if/when we do need it?
>
> Sure, no problems. (I just wanted to slip the thought into the
> conversation as UAPI is hard to change later).
>
> >
> > > >   - Early userspace code prevents modular drivers from automatically
> > > >     binding to PCI devices:
> > > >
> > > >       echo 0 > /sys/bus/pci/drivers_autoprobe
> > >
> > > Yes.
> > > I believe this setting will apply it equally to both modular and
> > > statically linked drivers?
> >
> > Yes.  The test is in bus_probe_device(), and it does the same for both
> > modular and statically linked drivers.
> >
> > But for statically linked drivers, it only prevents them from binding
> > to *hot-added* devices.  They will claim devices present at boot even
> > before userspace code can run.
>
> Yes, understood.
>
> >
> > > The one thing that still needs more thought is how about the
> > > "pcieport" driver that enumerates the PCI bridges. I'm unsure if it
> > > needs to be whitelisted for further enumeration downstream. What do
> > > you think?
> >
> > The pcieport driver is required for AER, PCIe native hotplug, PME,
> > etc., and it cannot be a module, so the whitelist wouldn't apply to
> > it.
>
> Not that I see the need, but slight clarification needed just to make
> sure I understand it clearly:
>
> Since pcieport driver is statically compiled in, AER, pciehp, PME, DPC
> etc will always be enabled for devices plugged in during boot. But I
> can still choose to choose to allow or deny for devices added *after
> boot* using the whitelist, right?
>
> Also, denying pcieport driver for hot-added PCIe bridges only disables
> these pcieport services on those bridges, but device enumeration
> further downstream those bridges is not an issue?
>
> > I assume you need hotplug support, so you would have pcieport
> > enabled and built in statically.
> >
> > If you're using ACPI hotplug, that doesn't require pcieport.
>
> Thank you, this was indeed a long and useful thread :-)
>
> Best Regards,
>
> Rajat
