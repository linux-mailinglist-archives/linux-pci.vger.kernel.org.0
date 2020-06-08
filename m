Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED291F1EFF
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jun 2020 20:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgFHSaL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jun 2020 14:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgFHSaK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jun 2020 14:30:10 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEECBC08C5C2
        for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2020 11:30:10 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id t25so16231457oij.7
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2020 11:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ec3kpkZ5d35E7fLprwrWdXZo0aQlGC04OCG9zESdHSI=;
        b=iPe+xoXGWEKnPvYzw5Yvncyh+AiZui29tQH+gTumP7xOkEDosj37E0i1CkrEduJZv/
         KJ4Q2q91HqL4Lu3vDhrY/2bQsgHaZlIxkoGhqUCDBfWw7vC/+RZOQyAuagniiWYVlWxY
         604YN3bEzJSa0z5ISy8b1QyceG/Z5GqfnOVDmb86ISuJMOJj+H6rkBy8OgFoHb96Jj7I
         8nMwFYMGihxQDrDNA1F5Ye+suKeExuFGeeAeouZxK6nv4+/JVJ8hKPJgkHJcZ2RCOXmM
         Rs/+NahJFZIpuWJBhW0C60p7UA4J2jFH5sOm+V8bKl9m/ZGqLTwCxu0SgVR4ZN9SkWhG
         a+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ec3kpkZ5d35E7fLprwrWdXZo0aQlGC04OCG9zESdHSI=;
        b=UCqEztT0uBRWE/cEJmMTYnaYRx5YwRg6NTWQGp96vy78yHqXXak9z1N2K0lWcTNUDA
         4VT5w4K2Z6XV9kdu3LB430SYgBMXwCzXnkV/sUdS12LLk7oewZQeC7ok/GMOdIdwoEpf
         TAiyONRiFEmI3kvpI+ihX26sH40fIdFUVD2F/N06BYHnlrz8EF8m+HfUkEwvifyzBgRs
         JkHYTQBUipT5BE3O5X3EMJ62rH2n7D9LgO+a6rMF0an9pYhcmbdCZwn/Ub824neOrxQV
         ziO0POf3sAG4LDWUJ8Iti0EpyyZENNAYpCmlVE0JiNMCtoDH5PVAUNJJa48MqKjFzQow
         jCAg==
X-Gm-Message-State: AOAM530TSyJnxzG2jpqQjPxqMJyKMmrTeCermUYOPYm0ioyPcpOs99n4
        W00K5w/BhYQJfCs+7+aaqHIM7pstIdvQiclOiKc38A==
X-Google-Smtp-Source: ABdhPJzfv48oleE/RvoYCG2QJu70P4yky15Sexf+JJ0aqPG245tpZEqdVXE3LuODG8ysOiqybEroQS46mnWiHnp8LGc=
X-Received: by 2002:aca:d6d3:: with SMTP id n202mr526173oig.132.1591641009822;
 Mon, 08 Jun 2020 11:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200602050626.GA2174820@kroah.com> <CAA93t1puWzFx=1h0xkZEkpzPJJbBAF7ONL_wicSGxHjq7KL+WA@mail.gmail.com>
 <20200603060751.GA465970@kroah.com> <CACK8Z6EXDf2vUuJbKm18R6HovwUZia4y_qUrTW8ZW+8LA2+RgA@mail.gmail.com>
 <20200603121613.GA1488883@kroah.com> <CACK8Z6EOGduHX1m7eyhFgsGV7CYiVN0en4U0cM4BEWJwk2bmoA@mail.gmail.com>
 <20200605080229.GC2209311@kroah.com> <CACK8Z6GR7-wseug=TtVyRarVZX_ao2geoLDNBwjtB+5Y7VWNEQ@mail.gmail.com>
 <20200607113632.GA49147@kroah.com> <CAJmaN=m5cGc8019LocvHTo-1U6beA9-h=T-YZtQEYEb_ry=b+Q@mail.gmail.com>
 <20200608175015.GA457685@kroah.com>
In-Reply-To: <20200608175015.GA457685@kroah.com>
From:   Jesse Barnes <jsbarnes@google.com>
Date:   Mon, 8 Jun 2020 11:29:58 -0700
Message-ID: <CAJmaN=mvnrLLkJC=6ddO_Rj+1FpRHoQzWFo9W3AZmsW_qS5CYQ@mail.gmail.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rajat Jain <rajatja@google.com>, Rajat Jain <rajatxjain@gmail.com>,
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

> > I think your suggestion to disable driver binding once the initial
> > bus/slot devices have been bound will probably work for this
> > situation.  I just wanted to be clear that without some auditing,
> > fuzzing, and additional testing, we simply have to assume that drivers
> > are *not* secure and avoid using them on untrusted devices until we're
> > fairly confident they can handle them (whether just misbehaving or
> > malicious), in combination with other approaches like IOMMUs of
> > course.  And this isn't because we don't trust driver authors or
> > kernel developers to dtrt, it's just that for many devices (maybe USB
> > is an exception) I think driver authors haven't had to consider this
> > case much, and so I think it's prudent to expect bugs in this area
> > that we need to find & fix.
>
> For USB, yes, we have now had to deal with "untrusted devices" lieing
> about their ids and sending us horrible data.  That's all due to the
> fuzzing tools that have been written over the past few years, and now we
> have some of those in the kernel tree itself to help with that testing.
>
> For PCI, heh, good luck, those assumptions about "devices sending valid
> data" are everywhere, if our experience with USB is any indication.
>
> But, to take USB as an example, this is exactly what the USB
> "authorized" flag is there for, it's a "trust" setting that userspace
> has control over.  This came from the wireless USB spec, where it was
> determined that you could not trust devices.  So just use that same
> model here, move it to the driver core for all busses to use and you
> should be fine.
>
> If that doesn't meet your needs, please let me know the specifics of
> why, with patches :)

Yeah will do for sure.  I don't want to carry a big infra for this on our own!

> Now, as to you all getting some sort of "Hardware flag" to determine
> "inside" vs. "outside" devices, hah, good luck!  It took us a long time
> to get that for USB, and even then, BIOSes lie and get it wrong all the
> time.  So you will have to also deal with that in some way, for your
> userspace policy.

I think that's inherently platform specific to some extent.  We can do
it with our coreboot based firmware, but there's no guarantee other
vendors will adopt the same approach.  But I think at least for the
ChromeOS ecosystem we can come up with something that'll work, and
allow us to dtrt in userspace wrt driver binding.

Thanks,
Jesse
