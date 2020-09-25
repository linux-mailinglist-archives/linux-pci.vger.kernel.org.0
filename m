Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16E127942E
	for <lists+linux-pci@lfdr.de>; Sat, 26 Sep 2020 00:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgIYW1F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 18:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgIYW1F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 18:27:05 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C49C0613CE
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 15:27:05 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o21so2941041qtp.2
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 15:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2AdFulKFxP+iqq8Kp0DDRTBioLEGOowxYYyiL0nYjyw=;
        b=TAdCZ38MB2FgZYVUPqRfBxPqlFGXhiY4V/yq3AtP1e/kVtfEvZq6YzUPgRGXqZsI8g
         BKSIFXaBh0dvti3K+8tZO8sEbW/SBN5X11O77c+F3LqsMQfVQg+MbGzC4er6zJMUG1lo
         SEMArYNUP2yz0ReIVqWvlSK0bbnGW8cjFn2r+yy9BkdAvLOeKSQ5TLmDbsmTr+2d+C9h
         H2gKAMvSOckKSvq0eT8Nbagefy3OnYhb7lr1ETQT/DtzRn9MlNoe0DyTh2B7TLP3F2LV
         XJJyyb4k4ZTTuePQDUGOrgaNUTAegcxsWnsuvqdjTTv0oRaLHyRlTYbYQchMEcXTBR3e
         GOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2AdFulKFxP+iqq8Kp0DDRTBioLEGOowxYYyiL0nYjyw=;
        b=OltGib2k1eWGPVDpuy0OA6EbfVSQ/72PFkVXirwfl9WLpkRycst0UXKo8XHD6M/9wP
         2y/vGturbMqVCM7M1Hs3MB3uCTLroqjQV+VGTKWi6GB877478Wq5waTVBpcD9jIB/Amh
         FJchIFo2TGHPhHC0kWCDFJd0gY+d25CUQMcxfeqfx5dbPU20YJGxrDbgKrsV45U+jwe+
         TI5Xj5pPa2ZV/Tv0kXyS6VQwLoXcT2cQ3lzlBoYtJ/nZbTVcs81iR+lpPMdTowK56wzf
         osuqe4k5a+L5rogv61h+F0f5ZQEY7B000gbCr+AZa14K7dOrAsJ8TumD+gutd6lfZBmc
         +hjw==
X-Gm-Message-State: AOAM5332MWuZoCvGrAyKFMgiiPq9ELjKAp8Z6ua3Lyk6w3c2jQJBGbnT
        iF/UOFojLjebAyyvWxovRnxF0Q89B0SmSQyPx8U=
X-Google-Smtp-Source: ABdhPJzwg2zZEX79/hhwv6aYSDZHVnQZ2qVXJYLsfXCjoBvCRcWf9FfRLCKxZDB94R1vxxxQZjtNNjaozH9cTNRSZaE=
X-Received: by 2002:ac8:7c90:: with SMTP id y16mr1927317qtv.45.1601072824502;
 Fri, 25 Sep 2020 15:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZvrPApeAYPVSYdVuKnp84xCpLBLf+f32e=R9tdPC0dvOw@mail.gmail.com>
 <20200925154936.GA2438758@bjorn-Precision-5520>
In-Reply-To: <20200925154936.GA2438758@bjorn-Precision-5520>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Sat, 26 Sep 2020 00:26:53 +0200
Message-ID: <CAA85sZsRgEEQ9bRqvMKTkGW4QhVp+cqNbw+VmRZQHfpy==F0+Q@mail.gmail.com>
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

On Fri, Sep 25, 2020 at 5:49 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc linux-pci, others again]
>
> On Fri, Sep 25, 2020 at 03:54:11PM +0200, Ian Kumlien wrote:
> > On Fri, Sep 25, 2020 at 3:39 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Fri, Sep 25, 2020 at 12:18:50PM +0200, Ian Kumlien wrote:
> > > > So.......
> > > > [    0.815843] pci 0000:04:00.0: L1 latency exceeded - path: 1000 - max: 64000
> > > > [    0.815843] pci 0000:00:01.2: Upstream device - 32000
> > > > [    0.815844] pci 0000:01:00.0: Downstream device - 32000
> > >
> > > Wait a minute.  I've been looking at *03:00.0*, not 04:00.0.  Based
> > > on your bugzilla, here's the path:
> >
> > Correct, or you could do it like this:
> > 00:01.2/01:00.0/02:03.0/03:00.0 Ethernet controller: Intel Corporation
> > I211 Gigabit Network Connection (rev 03)
> >
> > >   00:01.2 Root Port              to [bus 01-07]
> > >   01:00.0 Switch Upstream Port   to [bus 02-07]
> > >   02:03.0 Switch Downstream Port to [bus 03]
> > >   03:00.0 Endpoint (Intel I211 NIC)
> > >
> > > Your system does also have an 04:00.0 here:
> > >
> > >   00:01.2 Root Port              to [bus 01-07]
> > >   01:00.0 Switch Upstream Port   to [bus 02-07]
> > >   02:04.0 Switch Downstream Port to [bus 04]
> > >   04:00.0 Endpoint (Realtek 816e)
> > >   04:00.1 Endpoint (Realtek RTL8111/8168/8411 NIC)
> > >   04:00.2 Endpoint (Realtek 816a)
> > >   04:00.4 Endpoint (Realtek 816d EHCI USB)
> > >   04:00.7 Endpoint (Realtek 816c IPMI)
> > >
> > > Which NIC is the problem?
> >
> > The intel one - so the side effect of the realtek nic is that it fixes
> > the intel nics issues.
> >
> > It would be that the intel nic actually has a bug with L1 (and it
> > would seem that it's to kind with latencies) so it actually has a
> > smaller buffer...
> >
> > And afair, the realtek has a larger buffer, since it behaves better
> > with L1 enabled.
> >
> > Either way, it's a fix that's needed ;)
>
> OK, what specifically is the fix that's needed?  The L0s change seems
> like a "this looks wrong" thing that doesn't actually affect your
> situation, so let's skip that for now.

L1 latency calculation is not good enough, it assumes that *any*
link is the highest latency link - which is incorrect.

The latency to bring L1 up is number-of-hops*1000 +
maximum-latency-along-the-path

currently it's only doing number-of-hops*1000 +
arbitrary-latency-of-current-link

> And let's support the change you *do* need with the "lspci -vv" for
> all the relevant devices (including both 03:00.0 and 04:00.x, I guess,
> since they share the 00:01.2 - 01:00.0 link), before and after the
> change.

They are all included in all lspci output in the bug

> I want to identify something in the "before" configuration that is
> wrong according to the spec, and a change in the "after" config so it
> now conforms to the spec.

So there are a few issues here, the current code does not apply to spec.

The intel nic gets fixed as a side effect (it should still get a
proper fix) of making
the code apply to spec.

Basically, while hunting for the issue, I found that the L1 and L0s
latency calculations used to determine
if they should be enabled or not is wrong - that is what I'm currently
trying to push - it also seems like the
intel nic claims that it can handle 64us but apparently it can't.

So, three bugs, two are "fixed" one needs additional fixing.

> Bjorn
