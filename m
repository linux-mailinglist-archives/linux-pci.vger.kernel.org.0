Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F351A1F4A63
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 02:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgFJAa5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 20:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgFJAa4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 20:30:56 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB63EC05BD1E
        for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2020 17:30:55 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id i27so263810ljb.12
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2020 17:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fufpFexVpmLTY4L8tFo3Vjk8lnR9s+NHiNpeUysolls=;
        b=Ul3Kn7oEjJ+TiA2pqfTe1kLWo8haWQ4EdIrWEOoLUcZqB1v5+Etym1PpbRykwdrFc/
         iAvZiMia8BEQtCI23nGFox9x3pJ32ft7p7v+yGJpIsZylauMYMjm1bdqrxecJ+Bh2w7L
         xqjrS5+XDVplaBXmaXgQk+n1G3DRidRN6A2ZW5mnYdD6v2M6D86Us+cjITRGrKA+fcVQ
         qTwFZt6IHzcPFiyA1cnfFWD2sNzy1192NJEDLvc4U3gj6Rphyb5WtY0cDMjUBhSoxH8D
         nZq+FsEwWFKRvGEtLNV5LwvLDS8Fi/wSy7sK5fSVwveYFysFLoQNutyCfy8hjMCQh9R9
         0eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fufpFexVpmLTY4L8tFo3Vjk8lnR9s+NHiNpeUysolls=;
        b=kCyBxycQoVeViDIMvTFsnDipmvtVB2Kpv8zqnRuvv9AwlJuX/TdXpOiyz8P+3ybYY7
         PHo0eQkWTt/wlh2Gp2og/uOHvvugfbBlL73wt6P3edK63azf/IeZ+hJMmnjBlaw1hTJO
         4/uZCgOb4BeS/Rdr7vk6yEPXuUt8iFjIc080iEj9+TnTfLtrK0SuImmmT1pBfUDCaR4S
         3jtUwjx/H0qkoCyfKxnVXGtN3fdZHMGdNdG8EaqTj9TbiQVIADFUuyQYmSsUGHdDW79K
         KGT7BpRRVjy9ZWv51TdqqCkSQDqTv/2A0CapfqYOHPC309a3pS2IbtNs4MXH725oRxdv
         SRKw==
X-Gm-Message-State: AOAM532vU4RDp5SNyBSf52XMnO1GKiLNjGjXoMMgogCE+fa7PKI0BFR7
        GRjqDfde0fXctJIjfUrqvgK8pQg8cGDfR/nH0wUYPQ==
X-Google-Smtp-Source: ABdhPJy6qIbJQYsxG/h4M6IxlW+DryqYkaC9Hj8W8gQcJx+EtUTWvi5+ZOQuks3MC2dMqcym0t+/eiVlEcv1ojBzW6c=
X-Received: by 2002:a05:651c:1199:: with SMTP id w25mr391105ljo.301.1591749052049;
 Tue, 09 Jun 2020 17:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6E0s-Y207sb-AqSHVB7KmhvDgJQFFaz6ijQ_0OS3Qjisw@mail.gmail.com>
 <20200610000400.GA1473845@bjorn-Precision-5520>
In-Reply-To: <20200610000400.GA1473845@bjorn-Precision-5520>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 9 Jun 2020 17:30:13 -0700
Message-ID: <CACK8Z6G3ycsXxuNiihOXiwwAum8=5aOFOshhFa7cEF__+c-v1A@mail.gmail.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatxjain@gmail.com>,
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

On Tue, Jun 9, 2020 at 5:04 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jun 09, 2020 at 04:23:54PM -0700, Rajat Jain wrote:
> > Hi Bjorn,
> >
> > Thanks for sending out the summary, I was about to send it out but got lazy.
> >
> > On Tue, Jun 9, 2020 at 2:04 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Sun, Jun 07, 2020 at 01:36:32PM +0200, Greg Kroah-Hartman wrote:
> > >
> > > > Your "problem" I think can be summed up a bit more concise:
> > > >       - you don't trust kernel drivers to be "secure" for untrusted
> > > >         devices
> > > >       - you only want to bind kernel drivers to "internal" devices
> > > >         automatically as you "trust" drivers in that situation.
> > > >       - you want to only bind specific kernel drivers that you somehow
> > > >         feel are "secure" to untrusted devices "outside" of a system
> > > >         when those devices are added to the system.
> > > >
> > > > Is that correct?
> > > >
> > > > If so, fine, you can do that today with the bind/unbind ability of
> > > > drivers, right?  After boot with your "trusted" drivers bound to
> > > > "internal" devices, turn off autobind of drivers to devices and then
> > > > manually bind them when you see new devices show up, as those "must" be
> > > > from external devices (see the bind/unbind files that all drivers export
> > > > for how to do this, and old lwn.net articles, this feature has been
> > > > around for a very long time.)
> > > >
> > > > I know for USB you can do this, odds are PCI you can turn off
> > > > autobinding as well, as I think this is a per-bus flag somewhere.  If
> > > > that's not exported to userspace, should be trivial to do so, should be
> > > > somewere in the driver model already...
> > > >
> > > > Ah, yes, look at the "drivers_autoprobe" and "drivers_probe" files in
> > > > sysfs for all busses.  Do those not work for you?
> > > >
> > > > My other points are the fact that you don't want to put policy in the
> > > > kernel, and I think that you can do everything you want in userspace
> > > > today, except maybe the fact that trying to determine what is "inside"
> > > > and "outside" is not always easy given that most hardware does not
> > > > export this information properly, if at all.  Go work with the firmware
> > > > people on that issue please, that would be most helpful for everyone
> > > > involved to get that finally straightened out.
> > >
> > > To sketch this out, my understanding of how this would work is:
> > >
> > >   - Expose the PCI pdev->untrusted bit in sysfs.  We don't expose this
> > >     today, but doing so would be trivial.  I think I would prefer a
> > >     sysfs name like "external" so it's more descriptive and less of a
> > >     judgment.
> >
> > Yes. I think we should probably semantically differentiate between
> > "external" and "external facing" devices. Root ports and downstream
> > ports can be "external facing" but are actually internal devices.
> > Anything below an "external facing" device is "external". So the sysfs
> > attribute "external" should be set only for devices that are truly
> > external.
>
> Good point; we (maybe you? :)) should fix that edge case.

Sure, happy to. I will start a fresh conversation about that (in a
separate thread).

>
> > Just a suggestion: Do you think an enum attribute may be better
> > instead, whose values could be "internal" / "external" /
> > "external-facing" in case need arises later to distinguish between
> > them?
>
> I don't see the need for an enum yet.  Maybe we should add that
> if/when we do need it?

Sure, no problems. (I just wanted to slip the thought into the
conversation as UAPI is hard to change later).

>
> > >   - Early userspace code prevents modular drivers from automatically
> > >     binding to PCI devices:
> > >
> > >       echo 0 > /sys/bus/pci/drivers_autoprobe
> >
> > Yes.
> > I believe this setting will apply it equally to both modular and
> > statically linked drivers?
>
> Yes.  The test is in bus_probe_device(), and it does the same for both
> modular and statically linked drivers.
>
> But for statically linked drivers, it only prevents them from binding
> to *hot-added* devices.  They will claim devices present at boot even
> before userspace code can run.

Yes, understood.

>
> > The one thing that still needs more thought is how about the
> > "pcieport" driver that enumerates the PCI bridges. I'm unsure if it
> > needs to be whitelisted for further enumeration downstream. What do
> > you think?
>
> The pcieport driver is required for AER, PCIe native hotplug, PME,
> etc., and it cannot be a module, so the whitelist wouldn't apply to
> it.

Not that I see the need, but slight clarification needed just to make
sure I understand it clearly:

Since pcieport driver is statically compiled in, AER, pciehp, PME, DPC
etc will always be enabled for devices plugged in during boot. But I
can still choose to choose to allow or deny for devices added *after
boot* using the whitelist, right?

Also, denying pcieport driver for hot-added PCIe bridges only disables
these pcieport services on those bridges, but device enumeration
further downstream those bridges is not an issue?

> I assume you need hotplug support, so you would have pcieport
> enabled and built in statically.
>
> If you're using ACPI hotplug, that doesn't require pcieport.

Thank you, this was indeed a long and useful thread :-)

Best Regards,

Rajat
