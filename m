Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75651EB4E1
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 07:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgFBFG3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 01:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgFBFG3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jun 2020 01:06:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7EF220734;
        Tue,  2 Jun 2020 05:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591074388;
        bh=VPB3/nfIo3wkT6buqIsn4QkzpoxQB3A4D03p/ipxB90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AV1Q+eCqHNkbHr8QF4ftuJfPx1YOHKgZ+rsAP5jBQJYGsYLS/afQjVEl7IQEcV11F
         qalyAlQq0m7WDk8Lej0UtiFQi9RFV/VxzwsFlLsp3D54nALjc6WWY+nu41UXg1dbGC
         RYaegQYIngxdMXKBsXMG2ngds4/FyiWj998v89g8=
Date:   Tue, 2 Jun 2020 07:06:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rajat Jain <rajatja@google.com>,
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
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
Message-ID: <20200602050626.GA2174820@kroah.com>
References: <CACK8Z6F3jE-aE+N7hArV3iye+9c-COwbi3qPkRPxfrCnccnqrw@mail.gmail.com>
 <20200601232542.GA473883@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601232542.GA473883@bjorn-Precision-5520>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 01, 2020 at 06:25:42PM -0500, Bjorn Helgaas wrote:
> [+cc Greg, linux-kernel for wider exposure]

Thanks for the cc:, missed this...

> 
> On Tue, May 26, 2020 at 09:30:08AM -0700, Rajat Jain wrote:
> > On Thu, May 14, 2020 at 7:18 PM Rajat Jain <rajatja@google.com> wrote:
> > > On Thu, May 14, 2020 at 12:13 PM Raj, Ashok <ashok.raj@intel.com> wrote:
> > > > On Wed, May 13, 2020 at 02:26:18PM -0700, Rajat Jain wrote:
> > > > > On Wed, May 13, 2020 at 8:19 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Fri, May 01, 2020 at 04:07:10PM -0700, Rajat Jain wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > Currently, the PCI subsystem marks the PCI devices as "untrusted", if
> > > > > > > the firmware asks it to:
> > > > > > >
> > > > > > > 617654aae50e ("PCI / ACPI: Identify untrusted PCI devices")
> > > > > > > 9cb30a71acd4 ("PCI: OF: Support "external-facing" property")
> > > > > > >
> > > > > > > An "untrusted" device indicates a (likely external facing) device that
> > > > > > > may be malicious, and can trigger DMA attacks on the system. It may
> > > > > > > also try to exploit any vulnerabilities exposed by the driver, that
> > > > > > > may allow it to read/write unintended addresses in the host (e.g. if
> > > > > > > DMA buffers for the device, share memory pages with other driver data
> > > > > > > structures or code etc).
> > > > > > >
> > > > > > > High Level proposal
> > > > > > > ===============
> > > > > > > Currently, the "untrusted" device property is used as a hint to enable
> > > > > > > IOMMU restrictions (on Intel), disable ATS (on ARM) etc. We'd like to
> > > > > > > go a step further, and allow the administrator to build a list of
> > > > > > > whitelisted drivers for these "untrusted" devices. This whitelist of
> > > > > > > drivers are the ones that he trusts enough to have little or no
> > > > > > > vulnerabilities. (He may have built this list of whitelisted drivers
> > > > > > > by a combination of code analysis of drivers, or by extensive testing
> > > > > > > using PCIe fuzzing etc). We propose that the administrator be allowed
> > > > > > > to specify this list of whitelisted drivers to the kernel, and the PCI
> > > > > > > subsystem to impose this behavior:
> > > > > > >
> > > > > > > 1) The "untrusted" devices can bind to only "whitelisted drivers".
> > > > > > > 2) The other devices (i.e. dev->untrusted=0) can bind to any driver.
> > > > > > >
> > > > > > > Of course this behavior is to be imposed only if such a whitelist is
> > > > > > > provided by the administrator.
> > 
> > I haven't heard much on this proposal after the initial inputs (to
> > which I responded). Essentially, I agree that IO-MMU and ACS
> > restrictions need to be put in plcase. But I think we need this
> > additionally. Does this look acceptable to you? I wanted to start
> > spinning out the patches, but wanted to see if there are any pending
> > comments or concerns.
> 
> I think it makes sense to code this up and see what it would look
> like.  The bare minimum seems like a driver "bind-to-external-devices"
> bit that's visible in sysfs plus something in the driver probe path
> that checks it.  Neither is inherently PCI-specific, but maybe the
> right place will become obvious when implementing it.
> 
> I'm still not 100% sure the device "external/untrusted" bit is the
> right thing to check.  If you don't trust a driver enough to expose it
> to an external device, is it reasonable to trust it for internal
> devices?  It seems like one could attack the driver of even an
> internal device like a NIC by controlling the data fed to it.  
> 
> The existing use of "external/untrusted" for IOMMU protection is
> different.  There we're acknowledging that the *device* itself is
> unknown and we need to protect ourselves from malicious DMA.
> 
> Here we're concerned about a *driver* that's completely under our
> control.  If we don't trust the driver, we could (a) fix the problems
> in the driver, (b) change the driver so it handles external/untrusted
> devices differently, or (c) not ship the driver at all.
> 
> I'm also not sure about the administrative details of this.  Certain
> versions of the driver may be trusted while others are untrusted.
> That would all have to be managed in userspace, so it's not really our
> problem, but it sounds like a hassle.  Putting the information in the
> driver itself would reduce that.

What about taking what we have today for USB devices/drivers where we
have different levels of "authorized"?  There's no reason that could not
just move to the driver core and be available for all devices/drivers as
that model has proven to work really well over time.

See the "authorized" sysfs file documentation in
Documentation/ABI/testing/sysfs-bus-usb for some details.  Lots of
userspace tools have been built on top of that api to control how and
when specific USB devices are "allowed" to be used by the kernel and
userspace.

thanks,

greg k-h
