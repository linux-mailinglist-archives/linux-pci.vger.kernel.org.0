Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A847C41DC97
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 16:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351101AbhI3Oot (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 10:44:49 -0400
Received: from netrider.rowland.org ([192.131.102.5]:32923 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1350332AbhI3Oot (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 10:44:49 -0400
Received: (qmail 465943 invoked by uid 1000); 30 Sep 2021 10:43:05 -0400
Date:   Thu, 30 Sep 2021 10:43:05 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
Message-ID: <20210930144305.GA464826@rowland.harvard.edu>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org>
 <YVXBNJ431YIWwZdQ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVXBNJ431YIWwZdQ@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 03:52:52PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Sep 30, 2021 at 06:59:36AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Sep 29, 2021 at 06:05:07PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > While the common case for device-authorization is to skip probe of
> > > unauthorized devices, some buses may still want to emit a message on
> > > probe failure (Thunderbolt), or base probe failures on the
> > > authorization status of a related device like a parent (USB). So add
> > > an option (has_probe_authorization) in struct bus_type for the bus
> > > driver to own probe authorization policy.
> > > 
> > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > 
> > 
> > So what e.g. the PCI patch
> > https://lore.kernel.org/all/CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com/
> > actually proposes is a list of
> > allowed drivers, not devices. Doing it at the device level
> > has disadvantages, for example some devices might have a legacy
> > unsafe driver, or an out of tree driver. It also does not
> > address drivers that poke at hardware during init.
> 
> Doing it at a device level is the only sane way to do this.
> 
> A user needs to say "this device is allowed to be controlled by this
> driver".  This is the trust model that USB has had for over a decade and
> what thunderbolt also has.
> 
> > Accordingly, I think the right thing to do is to skip
> > driver init for disallowed drivers, not skip probe
> > for specific devices.
> 
> What do you mean by "driver init"?  module_init()?
> 
> No driver should be touching hardware in their module init call.  They
> should only be touching it in the probe callback as that is the only
> time they are ever allowed to talk to hardware.  Specifically the device
> that has been handed to them.
> 
> If there are in-kernel PCI drivers that do not do this, they need to be
> fixed today.
> 
> We don't care about out-of-tree drivers for obvious reasons that we have
> no control over them.

I don't see any point in talking about "untrusted drivers".  If a 
driver isn't trusted then it doesn't belong in your kernel.  Period.  
When you load a driver into your kernel, you are implicitly trusting 
it (aside from limitations imposed by security modules).  The code 
it contains, the module_init code in particular, runs with full 
superuser permissions.

What use is there in loading a driver but telling the kernel "I don't 
trust this driver, so don't allow it to probe any devices"?  Why not 
just blacklist it so that it never gets modprobed in the first place?

Alan Stern
