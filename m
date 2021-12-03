Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253B5467FA2
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 23:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354082AbhLCWG2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 17:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383281AbhLCWG2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Dec 2021 17:06:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E822C061751;
        Fri,  3 Dec 2021 14:03:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28F2462D29;
        Fri,  3 Dec 2021 22:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6D4C53FAD;
        Fri,  3 Dec 2021 22:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638568982;
        bh=H2BgCLm3pz5R138ik5NPBfu1aihTaYxp7vBcb9Mo9nk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RdYJgu/ErPChHGjPfvCbdY7dwR3GK6AEP77aIC0clQnnq7/XqRsbWVgxyf31MPgO0
         OyPrzQYs7AYzE5BMhSWT2gO5xzgMBjrod7t8VZ6zH2N4ETnzZyVzMD0NuDAuEDmMp/
         hAenwW7aNShzUlhlHJx+1pbF0fpuaOrYVMTvmVcf7EO27fVCTmQf0b39pc46dJ4paA
         e/kkAGPJJLq96+VTnhMNFYoPFYTUfXrKFgB9GbPXsYI0w8f4xR2MQZROh+tjl8/ASN
         tR3MvFNKkRRbqbnTUxmZD1SPmsi8Uh41Dj5fxonmNJo4wxFwuMDFRNdKUbUfpyEjVq
         AyQ8nFE//YbXg==
Date:   Fri, 3 Dec 2021 16:03:01 -0600
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
Message-ID: <20211203220301.GA3021152@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jrm+9UmV=6UHpBDkDd+5TTFvWo-jqDKQ6JZyaygmeB+g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 02, 2021 at 05:38:17PM -0800, Dan Williams wrote:
> [ add Stuart for NPEM feedback ]
> 
> On Thu, Dec 2, 2021 at 1:24 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Nov 23, 2021 at 11:17:55PM -0800, Dan Williams wrote:
> > > On Tue, Nov 23, 2021 at 10:33 PM Christoph Hellwig <hch@lst.de> wrote:
> > > > On Tue, Nov 23, 2021 at 04:40:06PM -0800, Dan Williams wrote:
> > > > > Let me ask a clarifying question coming from the other direction that
> > > > > resulted in the creation of the auxiliary bus architecture. Some
> > > > > background. RDMA is a protocol that may run on top of Ethernet.
> > > >
> > > > No, RDMA is a concept.  Linux supports 2 and a half RDMA protocols
> > > > that run over ethernet (RoCE v1 and v2 and iWarp).
> > >
> > > Yes, I was being too coarse, point taken. However, I don't think that
> > > changes the observation that multiple vendors are using aux bus to
> > > share a feature driver across multiple base Ethernet drivers.
> > >
> > > > > Consider the case where you have multiple generations of Ethernet
> > > > > adapter devices, but they all support common RDMA functionality. You
> > > > > only have the one PCI device to attach a unique Ethernet driver. What
> > > > > is an idiomatic way to deploy a module that automatically loads and
> > > > > attaches to the exported common functionality across adapters that
> > > > > otherwise have a unique native driver for the hardware device?
> > > >
> > > > The whole aux bus drama is mostly because the intel design for these
> > > > is really fucked up.  All the sane HCAs do not use this model.  All
> > > > this attchment crap really should not be there.
> > >
> > > I am missing the counter proposal in both Bjorn's and your distaste
> > > for aux bus and PCIe portdrv?
> >
> > For the case of PCIe portdrv, the functionality involved is Power
> > Management Events (PME), Advanced Error Reporting (AER), PCIe native
> > hotplug, Downstream Port Containment (DPC), and Bandwidth
> > Notifications.
> >
> > Currently each has a separate "port service driver" with .probe(),
> > .remove(), .suspend(), .resume(), etc.
> >
> > The services share interrupt vectors.  It's quite complicated to set
> > them up, and it has to be done in the portdrv, not in the individual
> > drivers.
> >
> > They also share power state (D0, D3hot, etc).
> >
> > In my mind these are not separate devices from the underlying PCI
> > device, and I don't think splitting the support into "service drivers"
> > made things better.  I think it would be simpler if these were just
> > added to pci_init_capabilities() like other optional pieces of PCI
> > functionality.
> >
> > Sysfs looks like this:
> >
> >   /sys/devices/pci0000:00/0000:00:1c.0/                       # Root Port
> >   /sys/devices/pci0000:00/0000:00:1c.0/0000:00:1c.0:pcie002/  # AER "device"
> >   /sys/devices/pci0000:00/0000:00:1c.0/0000:00:1c.0:pcie010/  # BW notif
> >
> >   /sys/bus/pci/devices/0000:00:1c.0 -> ../../../devices/pci0000:00/0000:00:1c.0/
> >   /sys/bus/pci_express/devices/0000:00:1c.0:pcie002 -> ../../../devices/pci0000:00/0000:00:1c.0/0000:00:1c.0:pcie002/
> >
> > The "pcie002" names (hex for PCIE_PORT_SERVICE_AER, etc.) are
> > unintelligible.  I don't know why we have a separate
> > /sys/bus/pci_express hierarchy.
> >
> > IIUC, CXL devices will be enumerated by the usual PCI enumeration, so
> > there will be a struct pci_dev for them, and they will appear under
> > /sys/devices/pci*/.
> >
> > They will have the usual PCI Power Management, MSI, AER, DPC, and
> > similar Capabilites, so the PCI core will manage them.
> >
> > CXL devices have lots of fancy additional features.  Does that merit
> > making a separate struct device and a separate sysfs hierarchy for
> > them?  I don't know.
> 
> Thank you, this framing really helps.
> 
> So, if I look at this through the lens of the "can this just be
> handled by pci_init_capabilities()?" guardband, where the capability
> is device-scoped and shares resources that a driver for the same
> device would use, then yes, PCIe port services do not merit a separate
> bus.
> 
> CXL memory expansion is distinctly not in that category. CXL is a
> distinct specification (i.e. unlike PCIe port services which are
> literally in the PCI Sig purview), distinct transport/data layer
> (effectively a different physical connection on the wire), and is
> composable in ways that PCIe is not.
> 
> For example, if you trigger FLR on a PCI device you would expect the
> entirety of pci_init_capabilities() needs to be saved / restored, CXL
> state is not affected by FLR.
> 
> The separate link layer for CXL means that mere device visibility is
> not sufficient to determine CXL operation. Whereas with a PCI driver
> if you can see the device you know that the device is ready to be the
> target of config, io, and mmio cycles, 

Not strictly true.  A PCI device must respond to config transactions
within a short time after reset, but it does not respond to IO or MEM
transactions until a driver sets PCI_COMMAND_IO or PCI_COMMAND_MEMORY.

> ... CXL.mem operation may not be available when the device is
> visible to enumeration.

> The composability of CXL places the highest demand for an independent
> 'struct bus_type' and registering CXL devices for their corresponding
> PCIe devices. The bus is a rendezvous for all the moving pieces needed
> to validate and provision a CXL memory region that may span multiple
> endpoints, switches and host bridges. An action like reprogramming
> memory decode of an endpoint needs to be coordinated across the entire
> topology.

I guess software uses the CXL DVSEC to distinguish a CXL device from a
PCIe device, at least for 00.0.  Not sure about non-Dev 0 Func 0
devices; maybe this implies other functions in the same device are
part of the same CXL device?

A CXL device may comprise several PCIe devices, and I think they may
have non-CXL Capabilities, so I assume you need a struct pci_dev for
each PCIe device?

Looks like a single CXL DVSEC controls the entire CXL device
(including several PCIe devices), so I assume you want some kind of
struct cxl_dev to represent that aggregation?

> The fact that the PCI core remains blissfully unaware of all these
> interdependencies is a feature because CXL is effectively a super-set
> of PCIe for fast-path CXL.mem operation, even though it is derivative
> for enumeration and slow-path manageability.

I don't know how blissfully unaware PCI can be.  Can a user remove a
PCIe device that's part of a CXL device via sysfs?  Is the PCIe device
available for drivers to claim?  Do we need coordination between
cxl_driver_register() and pci_register_driver()?  Does CXL impose new
constraints on PCI power management?

> So I hope you see CXL's need to create some PCIe-symbiotic objects in
> order to compose CXL objects (like interleaved memory regions) that
> have no PCIe analog.

> > Hotplug is more central to PCI than NPEM is, but NPEM is a little bit
> > like PCIe native hotplug in concept: hotplug has a few registers that
> > control downstream indicators, interlock, and power controller; NPEM
> > has registers that control downstream indicators.
> >
> > Both are prescribed by the PCIe spec and presumably designed to work
> > alongside the usual device-specific drivers for bridges, SSDs, etc.
> >
> > I would at least explore the idea of doing common support by
> > integrating NPEM into the PCI core.  There would have to be some hook
> > for the enclosure-specific bits, but I think it's fair for the details
> > of sending commands and polling for command completed to be part of
> > the PCI core.
> 
> The problem with NPEM compared to hotplug LED signaling is that it has
> the strange property that an NPEM higher in the topology might
> override one lower in the topology. This is to support things like
> NVME enclosures where the NVME device itself may have an NPEM
> instance, but that instance is of course not suitable for signaling
> that the device is not present.

I would envision the PCI core providing only a bare-bones "send this
command and wait for it to complete" sort of interface.  Everything
else, including deciding which device to use, would go elsewhere.

> So, instead the system may be designed to have an NPEM in the
> upstream switch port and disable the NPEM instances in the device.
> Platform firmware decides which NPEM is in use.

Since you didn't mention a firmware interface to communicate which
NPEM is in use, I assume firmware does this by preventing other
devices from advertising NPEM support?

> It also has the "fun" property of additionally being overridden by ACPI.
> ...
> One of the nice properties of the auxiliary organization is well
> defined module boundaries. Will NPEM in the PCI core now force
> CONFIG_ENCLOSURE_SERVICES to be built-in? That seems an unwanted side
> effect to me.

If the PCI core provides only the mechanism, and the smarts of NPEM
are in something analogous to drivers/scsi/ses.c, I don't think it
would force CONFIG_ENCLOSURE_SERVICES to be built-in.

> > DOE *is* specified by PCIe, at least in terms of the data transfer
> > protocol (interrupt usage, read/write mailbox, etc).  I think that,
> > and the fact that it's not specific to CXL, means we need some kind of
> > PCI core interface to do the transfers.
> 
> DOE transfer code belongs in drivers/pci/ period, but does it really
> need to be in drivers/pci/built-in.a for everyone regardless of
> whether it is being used or not?

I think my opinion would depend on how small the DOE transfer code
could be made and how much it would complicate things to make it a
module.  And also how we could enforce whatever mutual exclusion we
need to make it safe.

Bjorn
