Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB7D27B423
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 20:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgI1SLH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 14:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgI1SLH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 14:11:07 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0487DC061755
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2020 11:11:06 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id z25so2094445iol.10
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2020 11:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xq2IDxkKp0XeWZXnLMbFGou5K1qTkzRIbnj2klhRbOw=;
        b=NgNmXF9phYvMyXQuQNFrNyJqZIrFNg2rtMm+NEXo9qU7YYy68znrg8JABVWVzICL6b
         BdKnTGYJLNYXwl9o6j2tPK+2FwoIuWI4Ic72Jfh0W8n93DD5kN+OqLVxgSwDnOHuRsr2
         4W219lGHuSEy66P5CS2ymCVTLDrNMNGVJqx0cvsJtvd4AgN6DgZPgbCsSBPCDitYnhnz
         wnUIuywgiBYgX/bzJKLayDWtRWc+8g4ohdcJ9NI3TW26T6njXb/9b9xXSqxumuJlUkQK
         JQHmgK5uqQwsb1Dm1WSXqz0kcEW+DRZa9JmN+rB0nljvvALf+KYp0qyOBUnBnI5FJbCV
         HUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xq2IDxkKp0XeWZXnLMbFGou5K1qTkzRIbnj2klhRbOw=;
        b=FfILel+vyNqq539+PFdFn8xKT9byWy7tNJMLvrYhe6d2TF6llbrPpa0R02QN+hG+TP
         v4xNlCkWtHGhV6/t2SBJRjIatP/CHF8GIEarwVC2UviwTtsbOMrQyGUYOad8YYGIFG91
         dj6QjKzgdeOchp24YVMuWAadr7I+Y4iQ5r9p3AwgVPOXGCEljnRs+d3fuIjIh7e53L/p
         0b2DwVTf1w8XIQ6um3rnXGcseHAq5+xJrqAxyQb3DdE0Iu1zEGmfMYRh3VrrI+QidNuY
         xJut3ZbTpw7Kc02gh2ZUwMUsAOtykCuB4KLKjDRvq8CbcqNR0s3aZaCdzKUn2iMMV9A3
         9npA==
X-Gm-Message-State: AOAM5314WfV4hX1+QWqPPiIv+HFB/rLu1d448RmwzuX5JDbgPzlgYSPv
        GLVGLHbabwNP7sZmoeqW5FoOjpLve1VzTZHUtus=
X-Google-Smtp-Source: ABdhPJwyXJa57eIhG67uW3vHWwGsOvmk10Q4RRZmRVDaqaXBgCY+Oz1KNc7e8QKv77el57Ehu0qCNpdbiuk/tOK68K0=
X-Received: by 2002:a05:6602:22ca:: with SMTP id e10mr7535846ioe.88.1601316664018;
 Mon, 28 Sep 2020 11:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZuexf2pqfHBCKKGRos8psg_6ZZFeXiFm3ncPz-6JtqEdQ@mail.gmail.com>
 <20200928170921.GA2485236@bjorn-Precision-5520>
In-Reply-To: <20200928170921.GA2485236@bjorn-Precision-5520>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 28 Sep 2020 11:10:52 -0700
Message-ID: <CAKgT0UfEQ7o=UKgdajvXc1W+MRhTE4DrQmy0i6Mw04tYpK+Ojg@mail.gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1/L0s ASPM v2
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ian Kumlien <ian.kumlien@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 28, 2020 at 10:11 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Sep 28, 2020 at 12:24:11PM +0200, Ian Kumlien wrote:
> > On Mon, Sep 28, 2020 at 2:06 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Sat, Sep 26, 2020 at 12:26:53AM +0200, Ian Kumlien wrote:
> > > > On Fri, Sep 25, 2020 at 5:49 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Fri, Sep 25, 2020 at 03:54:11PM +0200, Ian Kumlien wrote:
> > > > > > On Fri, Sep 25, 2020 at 3:39 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > >
> > > > > > > On Fri, Sep 25, 2020 at 12:18:50PM +0200, Ian Kumlien wrote:
> > > > > > > > So.......
> > > > > > > > [    0.815843] pci 0000:04:00.0: L1 latency exceeded - path: 1000 - max: 64000
> > > > > > > > [    0.815843] pci 0000:00:01.2: Upstream device - 32000
> > > > > > > > [    0.815844] pci 0000:01:00.0: Downstream device - 32000
> > > > > > >
> > > > > > > Wait a minute.  I've been looking at *03:00.0*, not 04:00.0.  Based
> > > > > > > on your bugzilla, here's the path:
> > > > > >
> > > > > > Correct, or you could do it like this:
> > > > > > 00:01.2/01:00.0/02:03.0/03:00.0 Ethernet controller: Intel Corporation
> > > > > > I211 Gigabit Network Connection (rev 03)
> > > > > >
> > > > > > >   00:01.2 Root Port              to [bus 01-07]
> > > > > > >   01:00.0 Switch Upstream Port   to [bus 02-07]
> > > > > > >   02:03.0 Switch Downstream Port to [bus 03]
> > > > > > >   03:00.0 Endpoint (Intel I211 NIC)
> > > > > > >
> > > > > > > Your system does also have an 04:00.0 here:
> > > > > > >
> > > > > > >   00:01.2 Root Port              to [bus 01-07]
> > > > > > >   01:00.0 Switch Upstream Port   to [bus 02-07]
> > > > > > >   02:04.0 Switch Downstream Port to [bus 04]
> > > > > > >   04:00.0 Endpoint (Realtek 816e)
> > > > > > >   04:00.1 Endpoint (Realtek RTL8111/8168/8411 NIC)
> > > > > > >   04:00.2 Endpoint (Realtek 816a)
> > > > > > >   04:00.4 Endpoint (Realtek 816d EHCI USB)
> > > > > > >   04:00.7 Endpoint (Realtek 816c IPMI)
> > > > > > >
> > > > > > > Which NIC is the problem?
> > > > > >
> > > > > > The intel one - so the side effect of the realtek nic is that it fixes
> > > > > > the intel nics issues.
> > > > > >
> > > > > > It would be that the intel nic actually has a bug with L1 (and it
> > > > > > would seem that it's to kind with latencies) so it actually has a
> > > > > > smaller buffer...
> > > > > >
> > > > > > And afair, the realtek has a larger buffer, since it behaves better
> > > > > > with L1 enabled.
> > > > > >
> > > > > > Either way, it's a fix that's needed ;)
> > > > >
> > > > > OK, what specifically is the fix that's needed?  The L0s change seems
> > > > > like a "this looks wrong" thing that doesn't actually affect your
> > > > > situation, so let's skip that for now.
> > > >
> > > > L1 latency calculation is not good enough, it assumes that *any*
> > > > link is the highest latency link - which is incorrect.
> > > >
> > > > The latency to bring L1 up is number-of-hops*1000 +
> > > > maximum-latency-along-the-path
> > > >
> > > > currently it's only doing number-of-hops*1000 +
> > > > arbitrary-latency-of-current-link
> > > >
> > > > > And let's support the change you *do* need with the "lspci -vv" for
> > > > > all the relevant devices (including both 03:00.0 and 04:00.x, I guess,
> > > > > since they share the 00:01.2 - 01:00.0 link), before and after the
> > > > > change.
> > > >
> > > > They are all included in all lspci output in the bug
> > >
> > > No doubt.  But I spent a long time going through those and the
> > > differences I found are not enough to show a spec violation or a fix.
> > >
> > > Here's what I extracted (this is a repeat; I mentioned this before):
> > >
> > >                                                     LnkCtl    LnkCtl
> > >            ------DevCap-------  ----LnkCap-------  -Before-  -After--
> > >   00:01.2                                L1 <32us       L1+       L1-
> > >   01:00.0                                L1 <32us       L1+       L1-
> > >   02:03.0                                L1 <32us       L1+       L1+
> > >   03:00.0  L0s <512ns L1 <64us  L0s <2us L1 <16us  L0s- L1-  L0s- L1-
> > >
> > > I don't see anything wrong here yet.  03:00.0 claims it can handle up
> > > to 64us of L1 exit latency, and the L1 exit latency of the entire path
> > > should be 33us.  What am I missing?
> >
> > it should be 32+3 so 35 us - but the intel nic claims something it
> > can't live up to.
>
> How did you compute 35us?  Here's my math for 33us:
>
>   It looks like we *should* be able to enable L1 on both links since
>   the exit latency should be <33us (first link starts exit at T=0,
>   completes by T=32; second link starts exit at T=1, completes by
>   T=33), and 03:00.0 can tolerate up to 64us.
>
> If 03:00.0 advertises that it can tolerate 64us but it really can't,
> the fix would be a quirk to override the DevCap value for that device.
>
> > Since this is triggered by the realtek device
>
> I'm still under the impression that the throughput problem is with
> 03:00.0, the Intel I211 NIC.  In what sense is this triggered by the
> Realtek device?  Does the I211 work correctly until we add the Realtek
> device below the same switch?
>
> >                                                      LnkCtl    LnkCtl
> >             ------DevCap-------  ----LnkCap-------  -Before-  -After--
> >    00:01.2                                L1 <32us       L1+       L1-
> >    01:00.0                                L1 <32us       L1+       L1-
> >    02:04.0                                L1 <32us       L1+       L1+
> >    04:00.0  L0s <512 L1 <64us
> >
> > But exit for 04:00.0 is 64us which means it breaks its own latency
> > requirements once it's behind anything
>
> From your "lspci-before" attachment, 04:00.0 advertises:
>
>   04:00.0 DevCap: Latency L1 <64us
>           LnkCap: Exit Latency L1 <64us
>
> So I see what you mean; if it's behind a switch, the link on the
> upstream side of the switch would add some L1 exit latency, so we
> wouldn't be able to exit L1 for the entire path in <64us.  This isn't
> broken in the sense of a hardware defect; it just means we won't be
> able to enable L1 on some parts of the path.
>
> I wouldn't be surprised if Linux is doing that wrong right now, but we
> would just need to nail down exactly what's wrong.

Actually I wonder if we shouldn't be looking at the wakeup latency
being the highest possible latency for any endpoint on the switch plus
1us per link? Wouldn't it be possible for us to see head-of-line
blocking on the PCIe bus if TLPs are being routed to the realtek
resulting in us having to buffer in the switch until the realtek link
is awake? The current code makes sense from the upstream perspective,
but I don't think it takes the downstream routing into account and
that could result in head-of-line blocking could it not?
