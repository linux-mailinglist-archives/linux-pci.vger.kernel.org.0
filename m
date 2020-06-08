Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA38D1F1E8F
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jun 2020 19:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbgFHRuT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jun 2020 13:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730379AbgFHRuT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Jun 2020 13:50:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08123206A4;
        Mon,  8 Jun 2020 17:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591638618;
        bh=BOMvK8twEoxR2gwl3HoMy3REosGmlB54aUnofqfDoas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1aK5QW9RqII2SRd29V0nMDSbTZciFbUOl0ilBGgnUUh3VxRo2eW52VYb23WShnlvG
         Au+nfCKDOICC2QyN1+b9IcWsg7odj6Zk3TwDH0b6aw+sdGNuU7kNlrUiQP3BjJ82tp
         ZG8Ov275r8bWZFXRoh/xoLe1djlonSYzyZpdMJhw=
Date:   Mon, 8 Jun 2020 19:50:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jesse Barnes <jsbarnes@google.com>
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
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
Message-ID: <20200608175015.GA457685@kroah.com>
References: <20200602050626.GA2174820@kroah.com>
 <CAA93t1puWzFx=1h0xkZEkpzPJJbBAF7ONL_wicSGxHjq7KL+WA@mail.gmail.com>
 <20200603060751.GA465970@kroah.com>
 <CACK8Z6EXDf2vUuJbKm18R6HovwUZia4y_qUrTW8ZW+8LA2+RgA@mail.gmail.com>
 <20200603121613.GA1488883@kroah.com>
 <CACK8Z6EOGduHX1m7eyhFgsGV7CYiVN0en4U0cM4BEWJwk2bmoA@mail.gmail.com>
 <20200605080229.GC2209311@kroah.com>
 <CACK8Z6GR7-wseug=TtVyRarVZX_ao2geoLDNBwjtB+5Y7VWNEQ@mail.gmail.com>
 <20200607113632.GA49147@kroah.com>
 <CAJmaN=m5cGc8019LocvHTo-1U6beA9-h=T-YZtQEYEb_ry=b+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJmaN=m5cGc8019LocvHTo-1U6beA9-h=T-YZtQEYEb_ry=b+Q@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 08, 2020 at 10:03:38AM -0700, Jesse Barnes wrote:
> > > I feel a lot of resistance to the proposal, however, I'm not hearing
> > > any realistic solutions that may help us to move forward. We want to
> > > go with a solution that is acceptable upstream as that is our mission,
> > > and also helps the community, however the behemoth task of "inspect
> > > all drivers and fix them" before launching a product is really an
> > > unfair ask I feel :-(. Can you help us by suggesting a proposal that
> > > does not require us to trust a driver equally for internal / external
> > > devices?
> >
> > I have no idea why you feel you have to "inspect all drivers" other than
> > the fact that for some reason _you_ do not feel they are secure today.
> >
> > What type of "assurance" are you, or anyone else going to be able to
> > provide for any kernel driver that would meet such a "I feel good now"
> > level?  Have you done that work for any specific driver already so that
> > you can show us what you mean by this effort?  Perhaps it's as simple as
> > "oh look, this tool over here runs 'clean' on the source code, all is
> > good!", or not, I really have no idea.
> 
> I think there's a disconnect somewhere in this discussion... maybe
> we're just approaching this with different assumptions?
> 
> I think you recognize the potential for driver vulnerabilities when
> binding to new or potentially hostile devices that may be spoofing
> DID/VID/class/etc than then go on to abuse driver trust or the driver
> using unvalidated inputs from the device to crash or run arbitrary
> code on the target system.
> 
> Yes such drivers should be fixed, no doubt.  But without lots of
> fuzzing (we're working on this) and testing we'd like to avoid
> exposing that attack surface at all.
> 
> I think your suggestion to disable driver binding once the initial
> bus/slot devices have been bound will probably work for this
> situation.  I just wanted to be clear that without some auditing,
> fuzzing, and additional testing, we simply have to assume that drivers
> are *not* secure and avoid using them on untrusted devices until we're
> fairly confident they can handle them (whether just misbehaving or
> malicious), in combination with other approaches like IOMMUs of
> course.  And this isn't because we don't trust driver authors or
> kernel developers to dtrt, it's just that for many devices (maybe USB
> is an exception) I think driver authors haven't had to consider this
> case much, and so I think it's prudent to expect bugs in this area
> that we need to find & fix.

For USB, yes, we have now had to deal with "untrusted devices" lieing
about their ids and sending us horrible data.  That's all due to the
fuzzing tools that have been written over the past few years, and now we
have some of those in the kernel tree itself to help with that testing.

For PCI, heh, good luck, those assumptions about "devices sending valid
data" are everywhere, if our experience with USB is any indication.

But, to take USB as an example, this is exactly what the USB
"authorized" flag is there for, it's a "trust" setting that userspace
has control over.  This came from the wireless USB spec, where it was
determined that you could not trust devices.  So just use that same
model here, move it to the driver core for all busses to use and you
should be fine.

If that doesn't meet your needs, please let me know the specifics of
why, with patches :)

Now, as to you all getting some sort of "Hardware flag" to determine
"inside" vs. "outside" devices, hah, good luck!  It took us a long time
to get that for USB, and even then, BIOSes lie and get it wrong all the
time.  So you will have to also deal with that in some way, for your
userspace policy.

good luck!

greg k-h
