Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E81278D24
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 17:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgIYPtj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 11:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbgIYPti (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Sep 2020 11:49:38 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB69C21741;
        Fri, 25 Sep 2020 15:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601048978;
        bh=cKzZWX5mj7Pd/sOVx9LfHypkQnMVfc8jvu6G/5cB93c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dBUE6Gwuo3fBCyROBahd6HGwJzScz7IWD3WjBJLAF5UFJJ6COE1Iq+2tbRt0RnISq
         d/1pXcQ0VEnLpakybyZPmgLoMJ2EGmxbUZ7TQDvCRXJ+qykR7J3uOcaFlPRH+hWKF1
         IozG9wGdhjg+ZFyLDoNavMbC7UWNfSamLpuW+Hho=
Date:   Fri, 25 Sep 2020 10:49:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [PATCH] Use maximum latency when determining L1/L0s ASPM v2
Message-ID: <20200925154936.GA2438758@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA85sZvrPApeAYPVSYdVuKnp84xCpLBLf+f32e=R9tdPC0dvOw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci, others again]

On Fri, Sep 25, 2020 at 03:54:11PM +0200, Ian Kumlien wrote:
> On Fri, Sep 25, 2020 at 3:39 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Fri, Sep 25, 2020 at 12:18:50PM +0200, Ian Kumlien wrote:
> > > So.......
> > > [    0.815843] pci 0000:04:00.0: L1 latency exceeded - path: 1000 - max: 64000
> > > [    0.815843] pci 0000:00:01.2: Upstream device - 32000
> > > [    0.815844] pci 0000:01:00.0: Downstream device - 32000
> >
> > Wait a minute.  I've been looking at *03:00.0*, not 04:00.0.  Based
> > on your bugzilla, here's the path:
> 
> Correct, or you could do it like this:
> 00:01.2/01:00.0/02:03.0/03:00.0 Ethernet controller: Intel Corporation
> I211 Gigabit Network Connection (rev 03)
> 
> >   00:01.2 Root Port              to [bus 01-07]
> >   01:00.0 Switch Upstream Port   to [bus 02-07]
> >   02:03.0 Switch Downstream Port to [bus 03]
> >   03:00.0 Endpoint (Intel I211 NIC)
> >
> > Your system does also have an 04:00.0 here:
> >
> >   00:01.2 Root Port              to [bus 01-07]
> >   01:00.0 Switch Upstream Port   to [bus 02-07]
> >   02:04.0 Switch Downstream Port to [bus 04]
> >   04:00.0 Endpoint (Realtek 816e)
> >   04:00.1 Endpoint (Realtek RTL8111/8168/8411 NIC)
> >   04:00.2 Endpoint (Realtek 816a)
> >   04:00.4 Endpoint (Realtek 816d EHCI USB)
> >   04:00.7 Endpoint (Realtek 816c IPMI)
> >
> > Which NIC is the problem?
> 
> The intel one - so the side effect of the realtek nic is that it fixes
> the intel nics issues.
> 
> It would be that the intel nic actually has a bug with L1 (and it
> would seem that it's to kind with latencies) so it actually has a
> smaller buffer...
> 
> And afair, the realtek has a larger buffer, since it behaves better
> with L1 enabled.
> 
> Either way, it's a fix that's needed ;)

OK, what specifically is the fix that's needed?  The L0s change seems
like a "this looks wrong" thing that doesn't actually affect your
situation, so let's skip that for now.

And let's support the change you *do* need with the "lspci -vv" for
all the relevant devices (including both 03:00.0 and 04:00.x, I guess,
since they share the 00:01.2 - 01:00.0 link), before and after the
change.

I want to identify something in the "before" configuration that is
wrong according to the spec, and a change in the "after" config so it
now conforms to the spec.

Bjorn
