Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF36F1ECF97
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 14:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgFCMQQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 08:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgFCMQQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jun 2020 08:16:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA86A20772;
        Wed,  3 Jun 2020 12:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591186575;
        bh=SFfD7rjQgMSgbL8bRzZJf0ZisuK+c3EJzF7HL2U+4s4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CP+LvbJAwXvzFCN3wDOem5l94RPsCUTr0n4cOquKAB6Er8utvuoz4fMwcADi5QsQ0
         ww+3CuG/VKjMIfCLmmGZnKCv3T5Kq1PzLgQxi2AIwlg/KhZD7fc9bv7hYobbAARVf6
         eGCY6PD/SxBswyO2cbkwezisnBCGaxhcpaaDxUOU=
Date:   Wed, 3 Jun 2020 14:16:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Rajat Jain <rajatxjain@gmail.com>,
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
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
Message-ID: <20200603121613.GA1488883@kroah.com>
References: <CACK8Z6F3jE-aE+N7hArV3iye+9c-COwbi3qPkRPxfrCnccnqrw@mail.gmail.com>
 <20200601232542.GA473883@bjorn-Precision-5520>
 <20200602050626.GA2174820@kroah.com>
 <CAA93t1puWzFx=1h0xkZEkpzPJJbBAF7ONL_wicSGxHjq7KL+WA@mail.gmail.com>
 <20200603060751.GA465970@kroah.com>
 <CACK8Z6EXDf2vUuJbKm18R6HovwUZia4y_qUrTW8ZW+8LA2+RgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6EXDf2vUuJbKm18R6HovwUZia4y_qUrTW8ZW+8LA2+RgA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 03, 2020 at 04:51:18AM -0700, Rajat Jain wrote:
> Hello,
> 
> >
> > > Thanks for the pointer! I'm still looking at the details yet, but a
> > > quick look (usb_dev_authorized()) seems to suggest that this API is
> > > "device based". The multiple levels of "authorized" seem to take shape
> > > from either how it is wired or from userspace choice. Once authorized,
> > > USB device or interface is authorized to be used by *anyone* (can be
> > > attached to any drivers). Do I understand it right that it does not
> > > differentiate between drivers?
> >
> > Yes, and that is what you should do, don't fixate on drivers.  Users
> > know how to control and manage devices.  Us kernel developers are
> > responsible for writing solid drivers and getting them merged into the
> > kernel tree and maintaining them over time.  Drivers in the kernel
> > should always be trusted, ...
> 
> 1) Yes, I agree that this would be ideal, and this should be our
> mission. I should clarify that I may have used the wrong term
> "Trusted/Certified drivers". I didn't really mean that the drivers may
> be malicious by intent. What I really meant is that a driver may have
> an attack surface, which is a vulnerability that may be exploited.

Any code has such a thing, proving otherwise is a tough problem :)

> Realistically speaking, finding vulnerabilities in drivers, creating
> attacks to exploit them, and fixing them is a never ending cat and
> mouse game. At Least "identifying the vulnerabilities" part is better
> performed by security folks rather than driver writers.

Are you sure about that?  It's hard to prove a negative :)

> Earlier in the
> thread I had mentioned certain studies/projects that identified and
> exploited such vulnerabilities in the drivers. I should have used the
> term "Vetted Drivers" maybe to convey the intent better - drivers that
> have been vetted by a security focussed team (admin). What I'm
> advocating here is an administrator's right to control the drivers
> that he wants to allow for external ports on his systems.

That's an odd thing, but sure, if you want to write up such a policy for
your systems, great.  But that policy does not belong in the kernel, it
belongs in userspace.

> 2) In addition to the problem of driver negligences / vulnerabilities
> to be exploited, we ran into another problem with the "whitelist
> devices only" approach. We did start with the "device based" approach
> only initially - but quickly realized that anything we use to
> whitelist an external device can only be based on the info provided by
> *that device* itself. So until we have devices that exchange
> certificates with kernel [1], it is easy for a malicious device to
> spoof a whitelisted device (by presenting the same VID:DID or any
> other data that is used by us to whitelist it).
> 
> [1] https://www.intel.com/content/www/us/en/io/pci-express/pcie-device-security-enhancements-spec.html
> 
> I hope that helps somewhat clarify how / why we reached here?

Kind of, I still think all you need to do is worry about controling the
devices and if a driver should bind to it or not.  Again, much like USB
has been doing for a very long time now.  The idea of "spoofing" ids
also is not new, and has been around for a very long time as well, and
again, the controls that the USB core gives you allows you to make any
type of policy decision you want to, in userspace.

So please, in summary:
	- don't think this is some new type of thing, it's an old issue
	  transferred to yet-another-hardware-bus.  Not to say this is
	  not important, just please look at the work that others have
	  done in the past to help mitigate and solve this (reading the
	  Wireless USB spec should help you out here too, as they
	  detailed all of this.)
	- do copy what USB did, by moving that logic into the driver
	  core so that all busses who want to take advantage of this
	  type of functionality, easily can do so.

thanks,

greg k-h
