Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED78127A4AE
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 02:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgI1AGk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 20:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgI1AGk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 20:06:40 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F157123977;
        Mon, 28 Sep 2020 00:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601251599;
        bh=KC5CcWfnXI5J7ZGZyWZksdDVk7BeqgeUgtI3GPqGpKQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=O8g2x38Mg8ZuQp+WJCUPCxkTengLKU3+mkk9/UhM2WhoYImMvjUa1YCjTUTUf8xQg
         JxfV1YcO+BnRJvThnnziykeWATi3FLWfWkzYozTjj/z5CLC2XTXo32h9NnjLwiQbkG
         flu3ExN/ZgGhSHSLXFENLY83v5CfFUbnl3+tAD2M=
Date:   Sun, 27 Sep 2020 19:06:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [PATCH] Use maximum latency when determining L1/L0s ASPM v2
Message-ID: <20200928000637.GA2471891@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA85sZsRgEEQ9bRqvMKTkGW4QhVp+cqNbw+VmRZQHfpy==F0+Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 26, 2020 at 12:26:53AM +0200, Ian Kumlien wrote:
> On Fri, Sep 25, 2020 at 5:49 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Sep 25, 2020 at 03:54:11PM +0200, Ian Kumlien wrote:
> > > On Fri, Sep 25, 2020 at 3:39 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > On Fri, Sep 25, 2020 at 12:18:50PM +0200, Ian Kumlien wrote:
> > > > > So.......
> > > > > [    0.815843] pci 0000:04:00.0: L1 latency exceeded - path: 1000 - max: 64000
> > > > > [    0.815843] pci 0000:00:01.2: Upstream device - 32000
> > > > > [    0.815844] pci 0000:01:00.0: Downstream device - 32000
> > > >
> > > > Wait a minute.  I've been looking at *03:00.0*, not 04:00.0.  Based
> > > > on your bugzilla, here's the path:
> > >
> > > Correct, or you could do it like this:
> > > 00:01.2/01:00.0/02:03.0/03:00.0 Ethernet controller: Intel Corporation
> > > I211 Gigabit Network Connection (rev 03)
> > >
> > > >   00:01.2 Root Port              to [bus 01-07]
> > > >   01:00.0 Switch Upstream Port   to [bus 02-07]
> > > >   02:03.0 Switch Downstream Port to [bus 03]
> > > >   03:00.0 Endpoint (Intel I211 NIC)
> > > >
> > > > Your system does also have an 04:00.0 here:
> > > >
> > > >   00:01.2 Root Port              to [bus 01-07]
> > > >   01:00.0 Switch Upstream Port   to [bus 02-07]
> > > >   02:04.0 Switch Downstream Port to [bus 04]
> > > >   04:00.0 Endpoint (Realtek 816e)
> > > >   04:00.1 Endpoint (Realtek RTL8111/8168/8411 NIC)
> > > >   04:00.2 Endpoint (Realtek 816a)
> > > >   04:00.4 Endpoint (Realtek 816d EHCI USB)
> > > >   04:00.7 Endpoint (Realtek 816c IPMI)
> > > >
> > > > Which NIC is the problem?
> > >
> > > The intel one - so the side effect of the realtek nic is that it fixes
> > > the intel nics issues.
> > >
> > > It would be that the intel nic actually has a bug with L1 (and it
> > > would seem that it's to kind with latencies) so it actually has a
> > > smaller buffer...
> > >
> > > And afair, the realtek has a larger buffer, since it behaves better
> > > with L1 enabled.
> > >
> > > Either way, it's a fix that's needed ;)
> >
> > OK, what specifically is the fix that's needed?  The L0s change seems
> > like a "this looks wrong" thing that doesn't actually affect your
> > situation, so let's skip that for now.
> 
> L1 latency calculation is not good enough, it assumes that *any*
> link is the highest latency link - which is incorrect.
> 
> The latency to bring L1 up is number-of-hops*1000 +
> maximum-latency-along-the-path
> 
> currently it's only doing number-of-hops*1000 +
> arbitrary-latency-of-current-link
> 
> > And let's support the change you *do* need with the "lspci -vv" for
> > all the relevant devices (including both 03:00.0 and 04:00.x, I guess,
> > since they share the 00:01.2 - 01:00.0 link), before and after the
> > change.
> 
> They are all included in all lspci output in the bug

No doubt.  But I spent a long time going through those and the
differences I found are not enough to show a spec violation or a fix.

Here's what I extracted (this is a repeat; I mentioned this before):

                                                    LnkCtl    LnkCtl
           ------DevCap-------  ----LnkCap-------  -Before-  -After--
  00:01.2                                L1 <32us       L1+       L1-
  01:00.0                                L1 <32us       L1+       L1-
  02:03.0                                L1 <32us       L1+       L1+
  03:00.0  L0s <512ns L1 <64us  L0s <2us L1 <16us  L0s- L1-  L0s- L1-

I don't see anything wrong here yet.  03:00.0 claims it can handle up
to 64us of L1 exit latency, and the L1 exit latency of the entire path
should be 33us.  What am I missing?

> > I want to identify something in the "before" configuration that is
> > wrong according to the spec, and a change in the "after" config so it
> > now conforms to the spec.
> 
> So there are a few issues here, the current code does not apply to spec.
> 
> The intel nic gets fixed as a side effect (it should still get a
> proper fix) of making
> the code apply to spec.
> 
> Basically, while hunting for the issue, I found that the L1 and L0s
> latency calculations used to determine
> if they should be enabled or not is wrong - that is what I'm currently
> trying to push - it also seems like the
> intel nic claims that it can handle 64us but apparently it can't.
> 
> So, three bugs, two are "fixed" one needs additional fixing.

OK, we just need to split these up as much as possible and support
them with the relevant lspci output, analysis of what specifically is
wrong, and the lspci output showing the effect of the fix.

Bjorn
