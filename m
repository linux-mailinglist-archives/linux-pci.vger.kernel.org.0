Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F44821044E
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jul 2020 08:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgGAGyl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jul 2020 02:54:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgGAGyk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Jul 2020 02:54:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5594720663;
        Wed,  1 Jul 2020 06:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593586480;
        bh=i3cB/NSEphJHv0SPMo4Ri+dw2QUCGFXRezo5zBud4QA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bDRsiEvPxim7mIUQLMxS/bLPSvzf6RXw4lSl/UsxT+cvAnNOw215ac1BuCnhaJNg3
         3TjgAr5gFP9SkbmaCwFRyf2nOKWXxSRdt/xyceKZvhv9Rn7QHLd463e5uWZAQEjR7v
         fdO+FsCbOcQb8VTtmJaMa2ssYxvTRsZsBRTbNaqA=
Date:   Wed, 1 Jul 2020 08:54:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jesse Barnes <jsbarnes@google.com>,
        Rajat Jain <rajatja@google.com>,
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
Message-ID: <20200701065426.GC2044019@kroah.com>
References: <CAA93t1puWzFx=1h0xkZEkpzPJJbBAF7ONL_wicSGxHjq7KL+WA@mail.gmail.com>
 <20200603060751.GA465970@kroah.com>
 <CACK8Z6EXDf2vUuJbKm18R6HovwUZia4y_qUrTW8ZW+8LA2+RgA@mail.gmail.com>
 <20200603121613.GA1488883@kroah.com>
 <CACK8Z6EOGduHX1m7eyhFgsGV7CYiVN0en4U0cM4BEWJwk2bmoA@mail.gmail.com>
 <20200605080229.GC2209311@kroah.com>
 <CACK8Z6GR7-wseug=TtVyRarVZX_ao2geoLDNBwjtB+5Y7VWNEQ@mail.gmail.com>
 <20200607113632.GA49147@kroah.com>
 <CAJmaN=m5cGc8019LocvHTo-1U6beA9-h=T-YZtQEYEb_ry=b+Q@mail.gmail.com>
 <20200630214559.GA7113@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630214559.GA7113@duo.ucw.cz>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 30, 2020 at 11:45:59PM +0200, Pavel Machek wrote:
> Hi!
> 
> > Yes such drivers should be fixed, no doubt.  But without lots of
> > fuzzing (we're working on this) and testing we'd like to avoid
> > exposing that attack surface at all.
> > 
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
> We normally trust the hardware NOT to be malicious. (Because if hacker
> has physical access to hardware and lot of resources, you lost).

That is what we originally thought, however the world has changed and we
need to be better about this, now that it is trivial to create a "bad"
device.

> This is still true today, but maybe trusting USB devices is bad idea,
> so drivers are being cleaned up. PCI drivers will be WORSE in this
> regard. And you can't really protect against malicious CPU, and it is
> very very hard to protect against malicous RAM (probably not practical
> without explicit CPU support).
> 
> Linux was designed with "don't let hackers near your hardware" threat
> model in mind.

Yes, it originally was designed that way, but again, the world has
changed so we have to change with it.  That is why USB has for a long
time now, allowed you to not bind drivers to devices that you do not
"trust", and that trust can be determined by userspace.  That all came
about thanks to the work done by the wireless USB spec people and kernel
authors, which showed that maybe you just don't want to trust any device
that comes within range of your system :)

thanks,

greg k-h
