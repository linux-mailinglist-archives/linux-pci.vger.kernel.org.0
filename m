Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6423346B11D
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 03:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhLGDAL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 22:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhLGDAL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 22:00:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF37C061746;
        Mon,  6 Dec 2021 18:56:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8D163CE194C;
        Tue,  7 Dec 2021 02:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BBDC004DD;
        Tue,  7 Dec 2021 02:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638845797;
        bh=mCwvhRwDnQW3if30AiPiTxXr+ZG8/cQeJPPM4FkezS8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eE70kYkYLESQQpRIGayNnrcyDACZswLgaqNCO94gkq2CJoQVwXJZ7PRyFttJrTQjD
         EBQdEDvcUhZ66imLZPOj/xBorgInWxRqpXMBQxh2KcvWyHp+cDQzpQ60QFHyZ+6ab+
         Fuxsg3VUOTf1CtC4HfSmw2zmyhDML7uNnW/+e/3m04zigL6hmeT9MhLsDcojeD5H/R
         EL11X6RatxFMrYvXd1+og+UOzbA3r9M5bUwT9uwfYbPqzBxAFk0JiOgfmBE1NPzUKG
         I6nH+ZVOL4rrt/82qM0kNduErcjtHVVqDwAvXYvCMHtFvLrxJXsmNkk70wMF15ZsQw
         DEZk8rPxxX9LQ==
Date:   Mon, 6 Dec 2021 20:56:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Hayes <Stuart.Hayes@dell.com>
Subject: Re: [PATCH 20/23] cxl/port: Introduce a port driver
Message-ID: <20211207025635.GA9183@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hU3ZUG_Psx7GKS-fQMf8_Rb-pn8Lubvnqqbr4Q8AzZcA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 03, 2021 at 05:24:34PM -0800, Dan Williams wrote:
> On Fri, Dec 3, 2021 at 2:03 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Dec 02, 2021 at 05:38:17PM -0800, Dan Williams wrote:

I'm cutting out a bunch of details, not because they're unimportant,
but because I don't know enough yet for them to make sense to me.

> > I guess software uses the CXL DVSEC to distinguish a CXL device
> > from a PCIe device, at least for 00.0.
> 
> driver/cxl/pci.c attaches to: "PCI_DEVICE_CLASS((PCI_CLASS_MEMORY_CXL
> << 8 | CXL_MEMORY_PROGIF), ~0)"
> 
> I am not aware of any restriction for that class code to appear at
> function0?

Maybe it's not an actual restriction; I'm reading CXL r2.0, sec 8.1.3,
where it says:

  The PCIe configuration space of Device 0, Function 0 shall include
  the CXL PCI Express Designated Vendor-Specific Extended Capability
  (DVSEC) as shown in Figure 126. The capability, status and control
  fields in Device 0, Function 0 DVSEC control the CXL functionality
  of the entire CXL device.
  ...
  Software may use the presence of this DVSEC to differentiate between
  a CXL device and a PCIe device. As such, a standard PCIe device must
  not expose this DVSEC.

Sections 9.11.5 and 9.12.2 also talk about looking for CXL DVSEC on
dev 0, func 0 to identify CXL devices.

> > Not sure about non-Dev 0 Func 0 devices; maybe this implies other
> > functions in the same device are part of the same CXL device?
> 
> DVSEC is really only telling us the layout of the MMIO register
> space. ...

And DVSEC also apparently tells us that "this is a CXL device, not
just an ordinary PCIe device"?  It's not clear to me how you identify
other PCIe functions that are also part of the same CXL device.

> > > The fact that the PCI core remains blissfully unaware of all these
> > > interdependencies is a feature because CXL is effectively a super-set
> > > of PCIe for fast-path CXL.mem operation, even though it is derivative
> > > for enumeration and slow-path manageability.
> >
> > I don't know how blissfully unaware PCI can be.  Can a user remove a
> > PCIe device that's part of a CXL device via sysfs?
> 
> Yes. If that PCIe device is an endpoint then the corresponding "mem"
> driver will get a ->remove() event because it is registered as a child
> of that parent PCIe device. That in turn will tear down the relevant
> part of the CXL port topology.

The CXL device may include several PCIe devices.  "mem" is a CXL
driver that's bound to one of them (?)  Is that what you mean by "mem"
being a "child of the the parent PCIe device"?

> However, a gap (deliberate design choice?) in the PCI hotplug
> implementation I currently see is an ability for an endpoint PCI
> driver to dynamically deny hotplug requests based on the state of the
> device. ...

PCI allows surprise remove, so drivers generally can't deny hot
unplugs.  PCIe *does* provide for an Electromechanical Interlock (see
PCI_EXP_SLTCTL_EIC), but we don't currently support it.

> > Is the PCIe device available for drivers to claim?
> 
> drivers/cxl/pci.c *is* a native PCI driver for CXL memory expanders.
> You might be thinking of CXL accelerator devices, where the CXL.cache
> and CXL.mem capabilities are incremental capabilities for the
> accelerator.  ...

No, I'm not nearly sophisticated enough to be thinking of specific
types of CXL things :)

> > Do we need coordination between cxl_driver_register() and
> > pci_register_driver()?
> 
> They do not collide, and I think this goes back to the concern about
> whether drivers/cxl/ is scanning for all CXL DVSECs. ...

Sorry, I don't remember what this concern was, and I don't know why
they don't collide.  I *would* know that if I knew that the set of
things cxl_driver_register() binds to doesn't intersect the set of
pci_devs, but it's not clear to me what those things are.

The PCI core enumerates devices by doing config reads of the Vendor ID
for every possible bus and device number.  It allocs a pci_dev for
each device it finds, and those are the things pci_register_driver()
binds drivers to based on Vendor ID, Device ID, etc.

How does CXL enumeration work?  Do you envision it being integrated
into PCI enumeration?  Does it build a list/tree/etc of cxl_devs?

cxl_driver_register() associates a driver with something.  What
exactly is the thing the driver is associated with?  A pci_dev?  A
cxl_dev?  Some kind of aggregate CXL device composed of several PCIe
devices?

I expected cxl_driver.probe() to take a "struct cxl_dev *" or similar,
but it takes a "struct device *".  I'm trying to apply my knowledge of
how other buses work in Linux, but obviously it's not working very
well.

> > Does CXL impose new constraints on PCI power management?
> 
> Recall that CXL is built such that it could be supported by a legacy
> operating system where platform firmware owns the setup of devices,
> just like DDR memory does not need a driver. This is where CXL 1.1
> played until CXL 2.0 added so much configuration complexity (hotplug,
> interleave, persistent memory) that it started to need OS help. The
> Linux PCIe PM code will not notice a difference, but behind the scenes
> the device, if it is offering coherent memory to the CPU, will be
> coordinating with the CPU like it was part of the CPU package and not
> a discrete device. I do not see new PM software enabling required in
> my reading of "Section 10.0 Power Management" of the CXL
> specification.

So if Linux PM decides to suspend a PCIe device that's part of a CXL
device and put it in D3hot, this is not a problem for CXL?  I guess if
a CXL driver binds to the PCIe device, it can control what PM will do.
But I thought CXL drivers would bind to a CXL thing, not a PCIe thing.

I see lots of mentions of LTR in sec 10, which really scares me
because I'm pretty confident that Linux handling of LTR is broken, and
I have no idea how to fix it.

> > > So, instead the system may be designed to have an NPEM in the
> > > upstream switch port and disable the NPEM instances in the device.
> > > Platform firmware decides which NPEM is in use.
> >
> > Since you didn't mention a firmware interface to communicate which
> > NPEM is in use, I assume firmware does this by preventing other
> > devices from advertising NPEM support?
> 
> That's also my assumption. If the OS sees a disabled NPEM in the
> topology it just needs to assume firmware knew what it was doing when
> it disabled it. I wish NPEM was better specified than "trust firmware
> to do the right thing via an ambiguous signal".

If we enumerate a device with a capability that is disabled, we
normally don't treat that as a signal that it cannot be enabled.
There are lots of enable bits in PCI capabilities, and I don't know of
any cases where Linux assumes "Enable == 0" means "don't use this
feature."  Absent some negotiation like _OSC or some documented
restriction, e.g., in the PCI Firmware spec, Linux normally just
enables features when it decides to use them.

Bjorn
