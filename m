Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEC32109D2
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jul 2020 12:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgGAK53 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jul 2020 06:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729791AbgGAK53 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Jul 2020 06:57:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D80C206CB;
        Wed,  1 Jul 2020 10:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593601048;
        bh=qAAic7vs2yVMNd1JQknrRGHfHt4gS1Aw4pbTIJlwvsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H7vQIgD/P/I08yV5G1Fpjot1JnoS83yrvzBZtKfCOQQnUNvod1VWTSWtVpmdeHUpx
         FXTKsbPpQcW+PbZS5swhQEWKyoxPHXGQRqPCyYjeozsxxaCbHMrJIH4w3dNaont+QG
         XZCYdJnPRmNr0okB3mW1z++RwCnHWyfTg+YvxNIM=
Date:   Wed, 1 Jul 2020 12:57:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
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
Message-ID: <20200701105714.GA2098169@kroah.com>
References: <CACK8Z6EXDf2vUuJbKm18R6HovwUZia4y_qUrTW8ZW+8LA2+RgA@mail.gmail.com>
 <20200603121613.GA1488883@kroah.com>
 <CACK8Z6EOGduHX1m7eyhFgsGV7CYiVN0en4U0cM4BEWJwk2bmoA@mail.gmail.com>
 <20200605080229.GC2209311@kroah.com>
 <CACK8Z6GR7-wseug=TtVyRarVZX_ao2geoLDNBwjtB+5Y7VWNEQ@mail.gmail.com>
 <20200607113632.GA49147@kroah.com>
 <CAJmaN=m5cGc8019LocvHTo-1U6beA9-h=T-YZtQEYEb_ry=b+Q@mail.gmail.com>
 <20200630214559.GA7113@duo.ucw.cz>
 <20200701065426.GC2044019@kroah.com>
 <20200701084750.GA7144@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701084750.GA7144@amd>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 01, 2020 at 10:47:50AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > We normally trust the hardware NOT to be malicious. (Because if hacker
> > > has physical access to hardware and lot of resources, you lost).
> > 
> > That is what we originally thought, however the world has changed and we
> > need to be better about this, now that it is trivial to create a "bad"
> > device.
> 
> I'm not disagreeing.
> 
> > > This is still true today, but maybe trusting USB devices is bad idea,
> > > so drivers are being cleaned up. PCI drivers will be WORSE in this
> > > regard. And you can't really protect against malicious CPU, and it is
> > > very very hard to protect against malicous RAM (probably not practical
> > > without explicit CPU support).
> > > 
> > > Linux was designed with "don't let hackers near your hardware" threat
> > > model in mind.
> > 
> > Yes, it originally was designed that way, but again, the world has
> > changed so we have to change with it.  That is why USB has for a long
> > time now, allowed you to not bind drivers to devices that you do not
> > "trust", and that trust can be determined by userspace.  That all came
> > about thanks to the work done by the wireless USB spec people and kernel
> > authors, which showed that maybe you just don't want to trust any device
> > that comes within range of your system :)
> 
> Again, not disagreeing; but note the scale here.
> 
> It is mandatory to defend against malicious wireless USB devices.

Turns out there are no more wireless USB devices in the world, and the
code for that is gone from Linux :)

> We probably should work on robustness against malicious USB devices.

We are, and do have, that support today.

> Malicious PCI-express devices are lot less of concern.

Not really, they are a lot of concern to some people.  Valid attacks are
out there today, see the thunderbolt attacks that numerous people have
done and published recently and for many years.

> Defending against malicious CPU/RAM does not make much sense.

That's what the spectre and rowhammer fixes have been for :)

thanks,

greg k-h
