Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C12D1F3759
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 11:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgFIJyt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 05:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbgFIJys (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 05:54:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2ACC2074B;
        Tue,  9 Jun 2020 09:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591696486;
        bh=b/I0kNxHIl+13KoxgRCT6zkbblfDXS0iLu6pitfhlpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LrBZ8ycOBrsIie8XtRMmWnyHu9bjTpH+5cu1njFaZcwCTTexT3mRmcURDHoEQ8EhE
         Q9DAexLcgpwTZ9cPhe+u4X2DxNWHiBujlEUN4QUOuRoe8BEz+9e5/hw3c63MnQRW1J
         RdnFDqmQ0DtO0Ko2wtHgrl0zfWc7jeITMVyFrTtE=
Date:   Tue, 9 Jun 2020 11:54:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Jesse Barnes <jsbarnes@google.com>,
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
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
Message-ID: <20200609095444.GA533843@kroah.com>
References: <CACK8Z6EXDf2vUuJbKm18R6HovwUZia4y_qUrTW8ZW+8LA2+RgA@mail.gmail.com>
 <20200603121613.GA1488883@kroah.com>
 <CACK8Z6EOGduHX1m7eyhFgsGV7CYiVN0en4U0cM4BEWJwk2bmoA@mail.gmail.com>
 <20200605080229.GC2209311@kroah.com>
 <CACK8Z6GR7-wseug=TtVyRarVZX_ao2geoLDNBwjtB+5Y7VWNEQ@mail.gmail.com>
 <20200607113632.GA49147@kroah.com>
 <CAJmaN=m5cGc8019LocvHTo-1U6beA9-h=T-YZtQEYEb_ry=b+Q@mail.gmail.com>
 <20200608175015.GA457685@kroah.com>
 <CAJmaN=mvnrLLkJC=6ddO_Rj+1FpRHoQzWFo9W3AZmsW_qS5CYQ@mail.gmail.com>
 <CACK8Z6GZprVZMM=JQ-9zjosYQ6OLpifp_g8RmSTa3HwWWTB8Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6GZprVZMM=JQ-9zjosYQ6OLpifp_g8RmSTa3HwWWTB8Lw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 08, 2020 at 11:41:19AM -0700, Rajat Jain wrote:
> Hi Jesse and Greg,
> 
> On Mon, Jun 8, 2020 at 11:30 AM Jesse Barnes <jsbarnes@google.com> wrote:
> >
> > > > I think your suggestion to disable driver binding once the initial
> > > > bus/slot devices have been bound will probably work for this
> > > > situation.  I just wanted to be clear that without some auditing,
> > > > fuzzing, and additional testing, we simply have to assume that drivers
> > > > are *not* secure and avoid using them on untrusted devices until we're
> > > > fairly confident they can handle them (whether just misbehaving or
> > > > malicious), in combination with other approaches like IOMMUs of
> > > > course.  And this isn't because we don't trust driver authors or
> > > > kernel developers to dtrt, it's just that for many devices (maybe USB
> > > > is an exception) I think driver authors haven't had to consider this
> > > > case much, and so I think it's prudent to expect bugs in this area
> > > > that we need to find & fix.
> > >
> > > For USB, yes, we have now had to deal with "untrusted devices" lieing
> > > about their ids and sending us horrible data.  That's all due to the
> > > fuzzing tools that have been written over the past few years, and now we
> > > have some of those in the kernel tree itself to help with that testing.
> 
> This is great to hear! I tried to look up but didn't find anything
> else in-kernel, except the kcov support to export coverage info for
> userspace fuzzers. Can you please give us some pointers for in-kernel
> fuzzing tools?

For USB, it's a combination of using syzbot with the "raw gadget" driver
and the loopback gadget/host controller.  See many posts from Andrey
Konovalov <andreyknvl@google.com> on the linux-usb@vger.kernel.org list
for details as to how he does this.

> > > For PCI, heh, good luck, those assumptions about "devices sending valid
> > > data" are everywhere, if our experience with USB is any indication.
> > >
> > > But, to take USB as an example, this is exactly what the USB
> > > "authorized" flag is there for, it's a "trust" setting that userspace
> > > has control over.  This came from the wireless USB spec, where it was
> > > determined that you could not trust devices.  So just use that same
> > > model here, move it to the driver core for all busses to use and you
> > > should be fine.
> > >
> > > If that doesn't meet your needs, please let me know the specifics of
> > > why, with patches :)
> >
> > Yeah will do for sure.  I don't want to carry a big infra for this on our own!
> >
> > > Now, as to you all getting some sort of "Hardware flag" to determine
> > > "inside" vs. "outside" devices, hah, good luck!  It took us a long time
> > > to get that for USB, and even then, BIOSes lie and get it wrong all the
> > > time.  So you will have to also deal with that in some way, for your
> > > userspace policy.
> >
> > I think that's inherently platform specific to some extent.  We can do
> > it with our coreboot based firmware, but there's no guarantee other
> > vendors will adopt the same approach.  But I think at least for the
> > ChromeOS ecosystem we can come up with something that'll work, and
> > allow us to dtrt in userspace wrt driver binding.
> 
> Agree, we can work with our firmware teams to get that right, and then
> expose it from kernel to userspace to help it implement the policy we
> want.

This is already in the spec for USB, I suggest working to get this added
to the other bus type specs that you care about as well (UEFI, PCI,
etc.)

thanks,

greg k-h
