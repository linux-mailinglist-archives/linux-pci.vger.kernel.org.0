Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399C71EC941
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 08:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgFCGHz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 02:07:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgFCGHy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jun 2020 02:07:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1240C2065C;
        Wed,  3 Jun 2020 06:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591164473;
        bh=VG3pHSr/9ExD+ftESX8H3WG/eux5qg75Y/6AYihJIGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nGNmmc3wZvta5Q9yTCfjC+cNGoWkPIahRxpC7+K9Sogzw+6snhMyo8mOFgEDPTvd8
         hRhRV050MeSUWm+970fkY+AWVpjnEnp93Xcub2+P0NjejUgj63GbOig1PAHULzmItM
         X0vS7R64VvXdVA/EbiZiMGqNGUbWTFdLmyV1EtdQ=
Date:   Wed, 3 Jun 2020 08:07:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatxjain@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
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
Message-ID: <20200603060751.GA465970@kroah.com>
References: <CACK8Z6F3jE-aE+N7hArV3iye+9c-COwbi3qPkRPxfrCnccnqrw@mail.gmail.com>
 <20200601232542.GA473883@bjorn-Precision-5520>
 <20200602050626.GA2174820@kroah.com>
 <CAA93t1puWzFx=1h0xkZEkpzPJJbBAF7ONL_wicSGxHjq7KL+WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA93t1puWzFx=1h0xkZEkpzPJJbBAF7ONL_wicSGxHjq7KL+WA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 03, 2020 at 02:27:33AM +0000, Rajat Jain wrote:
> On Mon, Jun 1, 2020 at 10:06 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jun 01, 2020 at 06:25:42PM -0500, Bjorn Helgaas wrote:
> > > [+cc Greg, linux-kernel for wider exposure]
> >
> > Thanks for the cc:, missed this...
> >
> > >
> > > On Tue, May 26, 2020 at 09:30:08AM -0700, Rajat Jain wrote:
> > > > On Thu, May 14, 2020 at 7:18 PM Rajat Jain <rajatja@google.com> wrote:
> > > > > On Thu, May 14, 2020 at 12:13 PM Raj, Ashok <ashok.raj@intel.com> wrote:
> > > > > > On Wed, May 13, 2020 at 02:26:18PM -0700, Rajat Jain wrote:
> > > > > > > On Wed, May 13, 2020 at 8:19 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > On Fri, May 01, 2020 at 04:07:10PM -0700, Rajat Jain wrote:
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > Currently, the PCI subsystem marks the PCI devices as "untrusted", if
> > > > > > > > > the firmware asks it to:
> > > > > > > > >
> > > > > > > > > 617654aae50e ("PCI / ACPI: Identify untrusted PCI devices")
> > > > > > > > > 9cb30a71acd4 ("PCI: OF: Support "external-facing" property")
> > > > > > > > >
> > > > > > > > > An "untrusted" device indicates a (likely external facing) device that
> > > > > > > > > may be malicious, and can trigger DMA attacks on the system. It may
> > > > > > > > > also try to exploit any vulnerabilities exposed by the driver, that
> > > > > > > > > may allow it to read/write unintended addresses in the host (e.g. if
> > > > > > > > > DMA buffers for the device, share memory pages with other driver data
> > > > > > > > > structures or code etc).
> > > > > > > > >
> > > > > > > > > High Level proposal
> > > > > > > > > ===============
> > > > > > > > > Currently, the "untrusted" device property is used as a hint to enable
> > > > > > > > > IOMMU restrictions (on Intel), disable ATS (on ARM) etc. We'd like to
> > > > > > > > > go a step further, and allow the administrator to build a list of
> > > > > > > > > whitelisted drivers for these "untrusted" devices. This whitelist of
> > > > > > > > > drivers are the ones that he trusts enough to have little or no
> > > > > > > > > vulnerabilities. (He may have built this list of whitelisted drivers
> > > > > > > > > by a combination of code analysis of drivers, or by extensive testing
> > > > > > > > > using PCIe fuzzing etc). We propose that the administrator be allowed
> > > > > > > > > to specify this list of whitelisted drivers to the kernel, and the PCI
> > > > > > > > > subsystem to impose this behavior:
> > > > > > > > >
> > > > > > > > > 1) The "untrusted" devices can bind to only "whitelisted drivers".
> > > > > > > > > 2) The other devices (i.e. dev->untrusted=0) can bind to any driver.
> > > > > > > > >
> > > > > > > > > Of course this behavior is to be imposed only if such a whitelist is
> > > > > > > > > provided by the administrator.
> > > >
> > > > I haven't heard much on this proposal after the initial inputs (to
> > > > which I responded). Essentially, I agree that IO-MMU and ACS
> > > > restrictions need to be put in plcase. But I think we need this
> > > > additionally. Does this look acceptable to you? I wanted to start
> > > > spinning out the patches, but wanted to see if there are any pending
> > > > comments or concerns.
> > >
> > > I think it makes sense to code this up and see what it would look
> > > like.  The bare minimum seems like a driver "bind-to-external-devices"
> > > bit that's visible in sysfs plus something in the driver probe path
> > > that checks it.  Neither is inherently PCI-specific, but maybe the
> > > right place will become obvious when implementing it.
> 
> 
> Agree. I'll try to code it up.
> 
> My proposal became PCI specific because
> 
> * The need for my proposal arrived out of the potentially malicious
> *external* devices that can (NOW, with the advent of thunderbolt)
> directly DMA into the CPU memory space. PCI (enabled by Thunderbolt 3
> and USB4) is the only interface that fits the bill for laptops at
> least (There are few more interfaces that allow DMA directly into host
> memory such as LPC etc, but they are all internal so far).

Again, that fits in exactly with what USB does, so you should just steal
that code and move it into the driver core for all busses to use.

> > > I'm also not sure about the administrative details of this.  Certain
> > > versions of the driver may be trusted while others are untrusted.
> > > That would all have to be managed in userspace, so it's not really our
> > > problem, but it sounds like a hassle.  Putting the information in the
> > > driver itself would reduce that.
> 
> I agree to the points you are making. *
> 
> - Who do you think should certify the driver? The driver maintainer?
> Do we really think driver authors / maintainers will responsibly
> update this field? Also, how often?

No, that way lies madness, don't have "certified" drivers or anything
like that.  Just put policy in place for if you can trust the _device_
or not.

> - Also, this being a policy decision, and thus best left outside the kernel?

Yes.  There are tools already that do this today for USB, take a look at
how they work for examples of the process.

> Thanks for the pointer! I'm still looking at the details yet, but a
> quick look (usb_dev_authorized()) seems to suggest that this API is
> "device based". The multiple levels of "authorized" seem to take shape
> from either how it is wired or from userspace choice. Once authorized,
> USB device or interface is authorized to be used by *anyone* (can be
> attached to any drivers). Do I understand it right that it does not
> differentiate between drivers?

Yes, and that is what you should do, don't fixate on drivers.  Users
know how to control and manage devices.  Us kernel developers are
responsible for writing solid drivers and getting them merged into the
kernel tree and maintaining them over time.  Drivers in the kernel
should always be trusted, if not, then we have bigger architectural
issues we need to deal with.

thanks,

greg k-h
