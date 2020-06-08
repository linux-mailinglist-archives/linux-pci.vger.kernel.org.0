Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77861F1F29
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jun 2020 20:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgFHSmC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jun 2020 14:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgFHSmA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jun 2020 14:42:00 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF672C08C5C3
        for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2020 11:41:58 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id i27so10867663ljb.12
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2020 11:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xdYVMi4TB1AynZV/TE42S+K8GYgFVjpwEvPiHdeHwW0=;
        b=IUlTeRvUgK8FEJG+Sn6jQfueJQe1C/imU4WYRWV2PuXL0DIMXxcRLd3RBoYavNHScZ
         vX2zz4xElfE07LNxxcY2PcKOxWZWYDTr8eMWppKxcAh/KsojiLKR0rLTYeoejnobKNG2
         pZZpZMagWFDlGfMHVB9lzDhGFxuyRd9QkEU5pjXEJUfHLdAGS+6qV2MaQqpWxMcvG49q
         Iulw8WcBepoCEeFsp2tPHSSde26hUfJCgue82fduBrgy5NlOaekOMZ0Hch2/fBWLkiYF
         8BspwkgWLKWZedKJ76UM/ofI/g9mHhZeGTfF/87eYzZ17X6TjR5lB+2Y3N9AL7r9yqi1
         gSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xdYVMi4TB1AynZV/TE42S+K8GYgFVjpwEvPiHdeHwW0=;
        b=nWiQt04+VObzf+US2VDSxJcUxfQ7+sn2u2NVDDaefqL9QPlFBh5UptqMTTCg2eRDhs
         3OPx2dUtfDXla4Hy6pycGWabz1XcBS9VFH3MbjM167JeKWR4bsuTP6mlzo8Xj6XBwUD/
         c0VE182mVAgttkWDUAWm8GDcRIewY4abYWbbBdzGzM8hCVsKw9PDcfLL+XihpV0+tYea
         NJApphwVbZhfR1oathNV8lsguxEOIKYOK4tPbZr8T82kZ0r+a54R9pxpanY7xj7yEY9/
         zkR1lVQI4X1Go9fpsvMTRxTpSpivhO3f+nyf0+ggKfAcb1U+FC1+PMIhBYBslKI59pfT
         PMAQ==
X-Gm-Message-State: AOAM533UzZFek1S/X0Crv2ytGyQOEXqaQ6lQ3RQ6+y56xiDAaPkZPhRj
        2uSnbzMhAAWVlLjzXW47kg+PyMcXel7l4RQsKp9Yiw==
X-Google-Smtp-Source: ABdhPJzTbJz0aBGuHmzGA+lFFgmNz5sWB5R746ny52RgSF2CDnKe0/GyLz0cvZeq0OMLOIp+8mvZ6xdkOTsXbpZwDuA=
X-Received: by 2002:a2e:908f:: with SMTP id l15mr7160592ljg.307.1591641716733;
 Mon, 08 Jun 2020 11:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200602050626.GA2174820@kroah.com> <CAA93t1puWzFx=1h0xkZEkpzPJJbBAF7ONL_wicSGxHjq7KL+WA@mail.gmail.com>
 <20200603060751.GA465970@kroah.com> <CACK8Z6EXDf2vUuJbKm18R6HovwUZia4y_qUrTW8ZW+8LA2+RgA@mail.gmail.com>
 <20200603121613.GA1488883@kroah.com> <CACK8Z6EOGduHX1m7eyhFgsGV7CYiVN0en4U0cM4BEWJwk2bmoA@mail.gmail.com>
 <20200605080229.GC2209311@kroah.com> <CACK8Z6GR7-wseug=TtVyRarVZX_ao2geoLDNBwjtB+5Y7VWNEQ@mail.gmail.com>
 <20200607113632.GA49147@kroah.com> <CAJmaN=m5cGc8019LocvHTo-1U6beA9-h=T-YZtQEYEb_ry=b+Q@mail.gmail.com>
 <20200608175015.GA457685@kroah.com> <CAJmaN=mvnrLLkJC=6ddO_Rj+1FpRHoQzWFo9W3AZmsW_qS5CYQ@mail.gmail.com>
In-Reply-To: <CAJmaN=mvnrLLkJC=6ddO_Rj+1FpRHoQzWFo9W3AZmsW_qS5CYQ@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 8 Jun 2020 11:41:19 -0700
Message-ID: <CACK8Z6GZprVZMM=JQ-9zjosYQ6OLpifp_g8RmSTa3HwWWTB8Lw@mail.gmail.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
To:     Jesse Barnes <jsbarnes@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
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
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jesse and Greg,

On Mon, Jun 8, 2020 at 11:30 AM Jesse Barnes <jsbarnes@google.com> wrote:
>
> > > I think your suggestion to disable driver binding once the initial
> > > bus/slot devices have been bound will probably work for this
> > > situation.  I just wanted to be clear that without some auditing,
> > > fuzzing, and additional testing, we simply have to assume that drivers
> > > are *not* secure and avoid using them on untrusted devices until we're
> > > fairly confident they can handle them (whether just misbehaving or
> > > malicious), in combination with other approaches like IOMMUs of
> > > course.  And this isn't because we don't trust driver authors or
> > > kernel developers to dtrt, it's just that for many devices (maybe USB
> > > is an exception) I think driver authors haven't had to consider this
> > > case much, and so I think it's prudent to expect bugs in this area
> > > that we need to find & fix.
> >
> > For USB, yes, we have now had to deal with "untrusted devices" lieing
> > about their ids and sending us horrible data.  That's all due to the
> > fuzzing tools that have been written over the past few years, and now we
> > have some of those in the kernel tree itself to help with that testing.

This is great to hear! I tried to look up but didn't find anything
else in-kernel, except the kcov support to export coverage info for
userspace fuzzers. Can you please give us some pointers for in-kernel
fuzzing tools?

> >
> > For PCI, heh, good luck, those assumptions about "devices sending valid
> > data" are everywhere, if our experience with USB is any indication.
> >
> > But, to take USB as an example, this is exactly what the USB
> > "authorized" flag is there for, it's a "trust" setting that userspace
> > has control over.  This came from the wireless USB spec, where it was
> > determined that you could not trust devices.  So just use that same
> > model here, move it to the driver core for all busses to use and you
> > should be fine.
> >
> > If that doesn't meet your needs, please let me know the specifics of
> > why, with patches :)
>
> Yeah will do for sure.  I don't want to carry a big infra for this on our own!
>
> > Now, as to you all getting some sort of "Hardware flag" to determine
> > "inside" vs. "outside" devices, hah, good luck!  It took us a long time
> > to get that for USB, and even then, BIOSes lie and get it wrong all the
> > time.  So you will have to also deal with that in some way, for your
> > userspace policy.
>
> I think that's inherently platform specific to some extent.  We can do
> it with our coreboot based firmware, but there's no guarantee other
> vendors will adopt the same approach.  But I think at least for the
> ChromeOS ecosystem we can come up with something that'll work, and
> allow us to dtrt in userspace wrt driver binding.

Agree, we can work with our firmware teams to get that right, and then
expose it from kernel to userspace to help it implement the policy we
want.

Thanks & Best Regards,

Rajat

>
> Thanks,
> Jesse
