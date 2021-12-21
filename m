Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A6247C43C
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 17:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240046AbhLUQyc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 11:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240060AbhLUQya (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 11:54:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9CBC061574;
        Tue, 21 Dec 2021 08:54:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35AEBB811EF;
        Tue, 21 Dec 2021 16:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E2FC36AEA;
        Tue, 21 Dec 2021 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640105668;
        bh=sTIkMQ3xYFHDLVOY17QuEyh4LCJmHAsCyyMMg+0eBb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MO4RxbBAD4aTjDueLV/qKKUUdHjbWlF3lwLPodN51SoAVZv8XZG7fWa0N1GhRO9xc
         f8jt8/XCHV6ubweVjXMsS6/Yrf1Ii/i3WdAXduqMI+nIbFVMPZzOnIGKqXhfKND32H
         N1njc7AapVw3fDoaqFtTbHG+kyoxatGo1fotfhHk=
Date:   Tue, 21 Dec 2021 17:54:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH RESEND V2 3/6] platform/x86/intel: Move intel_pmt from
 MFD to Auxiliary Bus
Message-ID: <YcIGwZqm2sfIixkH@kroah.com>
References: <20211208015015.891275-1-david.e.box@linux.intel.com>
 <20211208015015.891275-4-david.e.box@linux.intel.com>
 <YbDbql39x7Kw6iAC@kroah.com>
 <7e78e6311cb0d261892f7361a1ef10130436f358.camel@linux.intel.com>
 <YbD1NsYHbU8FvtTN@kroah.com>
 <a70956e1c4da10603e29087e893cbae62ce82631.camel@linux.intel.com>
 <YbEFuN7fwdiNI8vW@kroah.com>
 <622887d53eaf6e6ae36354bfa0ed483df1cd9214.camel@linux.intel.com>
 <YcGEaH0oAAocziU2@kroah.com>
 <e9648546c3fb751954e411dfa392f0e0f90f0c85.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9648546c3fb751954e411dfa392f0e0f90f0c85.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 21, 2021 at 08:44:57AM -0800, David E. Box wrote:
> On Tue, 2021-12-21 at 08:38 +0100, Greg KH wrote:
> > On Wed, Dec 08, 2021 at 01:30:06PM -0800, David E. Box wrote:
> > > On Wed, 2021-12-08 at 20:21 +0100, Greg KH wrote:
> > > > On Wed, Dec 08, 2021 at 11:09:48AM -0800, David E. Box wrote:
> > > > > On Wed, 2021-12-08 at 19:11 +0100, Greg KH wrote:
> > > > > > On Wed, Dec 08, 2021 at 09:47:26AM -0800, David E. Box wrote:
> > > > > > > On Wed, 2021-12-08 at 17:22 +0100, Greg KH wrote:
> > > > > > > > On Tue, Dec 07, 2021 at 05:50:12PM -0800, David E. Box wrote:
> > > > > > > > > +static struct pci_driver intel_vsec_pci_driver = {
> > > > > > > > > +       .name = "intel_vsec",
> > > > > > > > > +       .id_table = intel_vsec_pci_ids,
> > > > > > > > > +       .probe = intel_vsec_pci_probe,
> > > > > > > > > +};
> > > > > > > > 
> > > > > > > > So when the PCI device is removed from the system you leak
> > > > > > > > resources and
> > > > > > > > have dangling devices?
> > > > > > > 
> > > > > > > No.
> > > > > > > 
> > > > > > > > Why no PCI remove driver callback?
> > > > > > > 
> > > > > > > After probe all resources are device managed. There's nothing to
> > > > > > > explicitly clean up. When
> > > > > > > the
> > > > > > > PCI
> > > > > > > device is removed, all aux devices are automatically removed. This
> > > > > > > is the case for the SDSi
> > > > > > > driver
> > > > > > > as well.
> > > > > > 
> > > > > > Where is the "automatic cleanup" happening?  As this pci driver is
> > > > > > bound
> > > > > > to the PCI device, when the device is removed, what is called in this
> > > > > > driver to remove the resources allocated in the probe callback?
> > > > > > 
> > > > > > confused,
> > > > > 
> > > > > devm_add_action_or_reset(&pdev->dev, intel_vsec_remove_aux, auxdev)
> > > > 
> > > > Wow that is opaque.  Why not do it on remove instead?
> > > 
> > > This code is common for auxdev cleanup. AFAICT most auxiliary bus code is
> > > done by drivers that have
> > > some other primary function. They clean up their primary function resources
> > > in remove, but they
> > > clean up the auxdev using the method above. In this case the sole purpose of
> > > this driver is to
> > > create the auxdev. There are no other resources beyond what the auxdev is
> > > using.
> > > 
> > > Adding runtime pm to the pci driver will change this. Remove will be needed
> > > then.
> > 
> > And who will notice that being required when that happens?
> > 
> > Why is there no runtime PM for this driver?  Do you not care about power
> > consumption?  :)
> 
> Of course. :)
> 
> There's a backlog of patches waiting for this series. One adds support for the
> telemetry device (an auxdev) on the DG2 GPU. This device requires runtime pm in
> order for the slot to go D3. But this also requires changes to the telemetry
> driver in order for runtime pm to be handled correctly. These and other patches,
> including a series to have all current aux drivers use the new drvdata helpers,
> are waiting for this.

I can take the aux driver drvdata patch now, through my tree, if you
want, no need to make it wait for this tiny driver.

Feel free to send it independant of the existing patchset, and with the
cleanup patches at the same time, should be quite easy to get merged.

thanks,

greg k-h
