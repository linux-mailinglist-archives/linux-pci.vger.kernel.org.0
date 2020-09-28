Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E470427ABBE
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 12:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgI1KYX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 06:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1KYX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 06:24:23 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E52FC061755
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2020 03:24:23 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g72so417921qke.8
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2020 03:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ONMQwBnEKV8poL/SY4eKE9jQeR6eWOBs7fxZwB/IeQg=;
        b=IsVDYpGydom0SAYAxmuEAbk1u6Rvzw4ej2dB47PoERwWFEYalvcAE807s7DbGfLtAR
         BRIhsxccVNptxgoyWS6z5vsV6iKRt3RQwIF4OriF45x65Wh/7j42s5ouKFzOpFYqYioj
         EYbNjJLjQB6eBG3XSluwpcajE4ntxQX7in7+sbPFYoXGQ2yZnQYbRUM9VlElu0L1YO/Z
         iA0IzJwrurPxqLFQLA0fDE5xnJgeJF2SAM7Q1lJTZsW2tUnGE+z7UZihv+Vz9ynlq1rs
         BKnMF5kD7R5UFFT6EWaGhTpiyNVyRxnipvJHcAj4Y6W7OKYdNqIm11dk4eU/7MbU25NE
         c08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ONMQwBnEKV8poL/SY4eKE9jQeR6eWOBs7fxZwB/IeQg=;
        b=uY+Ce0ak4jd7Z42s7UkwOQI5whEfeD82LPmsxbeI5NTpFvzs/1tp72pvDb06bSJeJU
         f+bJeQEjx7ywEAvQUwb1I+quBx1b54l1eQvOyyISLUxM5k04l44gSzVpaAqogZ/7WC1o
         zfRLcXnRTwu3cxqWQHWxiNILb+RAdU3NX4LOf8vB3xmmYCxTOM+6jW7s/lpK+ea8vrm2
         /wjoseaAvXYvhCVKO6SXcyJQAh3ErwSpmQGxf/036MVa5WW5/r4cbQwnogHX07j72r4y
         +hTeERoCyWYkubpEtNRaoOrpOKfGgwrs8n/Y+HhHyv4toDy7cI8xHg65GK8pDA3WN8ha
         SnhQ==
X-Gm-Message-State: AOAM5311X4S9mE4z4d4E8TeTErI7zyUoGXxpx/0KRKx67i6oWI2zyV1u
        AwYH8SlDTwitYcloE0RrhqBsaGV1bjLE+4az70/htzGyMCY=
X-Google-Smtp-Source: ABdhPJxXdjzQL5Q53sSLTqXpeHD8XU8mFz/G1VaG4fQPDCGkqOMqyfUspS9wJ2Cz9oheF+8ppx/IfYWvI3Jktw8zU5U=
X-Received: by 2002:a37:a3d8:: with SMTP id m207mr644250qke.175.1601288662592;
 Mon, 28 Sep 2020 03:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZsRgEEQ9bRqvMKTkGW4QhVp+cqNbw+VmRZQHfpy==F0+Q@mail.gmail.com>
 <20200928000637.GA2471891@bjorn-Precision-5520>
In-Reply-To: <20200928000637.GA2471891@bjorn-Precision-5520>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 28 Sep 2020 12:24:11 +0200
Message-ID: <CAA85sZuexf2pqfHBCKKGRos8psg_6ZZFeXiFm3ncPz-6JtqEdQ@mail.gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1/L0s ASPM v2
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 28, 2020 at 2:06 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sat, Sep 26, 2020 at 12:26:53AM +0200, Ian Kumlien wrote:
> > On Fri, Sep 25, 2020 at 5:49 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Fri, Sep 25, 2020 at 03:54:11PM +0200, Ian Kumlien wrote:
> > > > On Fri, Sep 25, 2020 at 3:39 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > >
> > > > > On Fri, Sep 25, 2020 at 12:18:50PM +0200, Ian Kumlien wrote:
> > > > > > So.......
> > > > > > [    0.815843] pci 0000:04:00.0: L1 latency exceeded - path: 1000 - max: 64000
> > > > > > [    0.815843] pci 0000:00:01.2: Upstream device - 32000
> > > > > > [    0.815844] pci 0000:01:00.0: Downstream device - 32000
> > > > >
> > > > > Wait a minute.  I've been looking at *03:00.0*, not 04:00.0.  Based
> > > > > on your bugzilla, here's the path:
> > > >
> > > > Correct, or you could do it like this:
> > > > 00:01.2/01:00.0/02:03.0/03:00.0 Ethernet controller: Intel Corporation
> > > > I211 Gigabit Network Connection (rev 03)
> > > >
> > > > >   00:01.2 Root Port              to [bus 01-07]
> > > > >   01:00.0 Switch Upstream Port   to [bus 02-07]
> > > > >   02:03.0 Switch Downstream Port to [bus 03]
> > > > >   03:00.0 Endpoint (Intel I211 NIC)
> > > > >
> > > > > Your system does also have an 04:00.0 here:
> > > > >
> > > > >   00:01.2 Root Port              to [bus 01-07]
> > > > >   01:00.0 Switch Upstream Port   to [bus 02-07]
> > > > >   02:04.0 Switch Downstream Port to [bus 04]
> > > > >   04:00.0 Endpoint (Realtek 816e)
> > > > >   04:00.1 Endpoint (Realtek RTL8111/8168/8411 NIC)
> > > > >   04:00.2 Endpoint (Realtek 816a)
> > > > >   04:00.4 Endpoint (Realtek 816d EHCI USB)
> > > > >   04:00.7 Endpoint (Realtek 816c IPMI)
> > > > >
> > > > > Which NIC is the problem?
> > > >
> > > > The intel one - so the side effect of the realtek nic is that it fixes
> > > > the intel nics issues.
> > > >
> > > > It would be that the intel nic actually has a bug with L1 (and it
> > > > would seem that it's to kind with latencies) so it actually has a
> > > > smaller buffer...
> > > >
> > > > And afair, the realtek has a larger buffer, since it behaves better
> > > > with L1 enabled.
> > > >
> > > > Either way, it's a fix that's needed ;)
> > >
> > > OK, what specifically is the fix that's needed?  The L0s change seems
> > > like a "this looks wrong" thing that doesn't actually affect your
> > > situation, so let's skip that for now.
> >
> > L1 latency calculation is not good enough, it assumes that *any*
> > link is the highest latency link - which is incorrect.
> >
> > The latency to bring L1 up is number-of-hops*1000 +
> > maximum-latency-along-the-path
> >
> > currently it's only doing number-of-hops*1000 +
> > arbitrary-latency-of-current-link
> >
> > > And let's support the change you *do* need with the "lspci -vv" for
> > > all the relevant devices (including both 03:00.0 and 04:00.x, I guess,
> > > since they share the 00:01.2 - 01:00.0 link), before and after the
> > > change.
> >
> > They are all included in all lspci output in the bug
>
> No doubt.  But I spent a long time going through those and the
> differences I found are not enough to show a spec violation or a fix.
>
> Here's what I extracted (this is a repeat; I mentioned this before):
>
>                                                     LnkCtl    LnkCtl
>            ------DevCap-------  ----LnkCap-------  -Before-  -After--
>   00:01.2                                L1 <32us       L1+       L1-
>   01:00.0                                L1 <32us       L1+       L1-
>   02:03.0                                L1 <32us       L1+       L1+
>   03:00.0  L0s <512ns L1 <64us  L0s <2us L1 <16us  L0s- L1-  L0s- L1-
>
> I don't see anything wrong here yet.  03:00.0 claims it can handle up
> to 64us of L1 exit latency, and the L1 exit latency of the entire path
> should be 33us.  What am I missing?

it should be 32+3 so 35 us - but the intel nic claims something it
can't live up to.

Since this is triggered by the realtek device
                                                     LnkCtl    LnkCtl
            ------DevCap-------  ----LnkCap-------  -Before-  -After--
   00:01.2                                L1 <32us       L1+       L1-
   01:00.0                                L1 <32us       L1+       L1-
   02:04.0                                L1 <32us       L1+       L1+
   04:00.0  L0s <512 L1 <64us

But exit for 04:00.0 is 64us which means it breaks its own latency
requirements once it's behind anything

> > > I want to identify something in the "before" configuration that is
> > > wrong according to the spec, and a change in the "after" config so it
> > > now conforms to the spec.
> >
> > So there are a few issues here, the current code does not apply to spec.
> >
> > The intel nic gets fixed as a side effect (it should still get a
> > proper fix) of making
> > the code apply to spec.
> >
> > Basically, while hunting for the issue, I found that the L1 and L0s
> > latency calculations used to determine
> > if they should be enabled or not is wrong - that is what I'm currently
> > trying to push - it also seems like the
> > intel nic claims that it can handle 64us but apparently it can't.
> >
> > So, three bugs, two are "fixed" one needs additional fixing.
>
> OK, we just need to split these up as much as possible and support
> them with the relevant lspci output, analysis of what specifically is
> wrong, and the lspci output showing the effect of the fix.

Could i have a copy of the pcie spec? I have found sections of it but
it's really hard to find them again when you
want to refer to something... Which I need to do to show that it
doesn't conform...

Ie I can't show all the errors on my system :)

> Bjorn
