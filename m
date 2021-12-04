Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755044681C8
	for <lists+linux-pci@lfdr.de>; Sat,  4 Dec 2021 02:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383949AbhLDB2J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 20:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237601AbhLDB2I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Dec 2021 20:28:08 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB88C061751
        for <linux-pci@vger.kernel.org>; Fri,  3 Dec 2021 17:24:44 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so6478385pjc.4
        for <linux-pci@vger.kernel.org>; Fri, 03 Dec 2021 17:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7zI36NSxfaJ5J3uTjk8pT0e/FfDhLW9RCH5r38MxLg=;
        b=a9RCYLgDeD1h8NpvO4+DR9cuiRNH0wl2YINuvJV4aFt/aXx6pNOUE545BWaPKxppx+
         9+KzR14rOMN0l76U6JbYNgznFhWIScaLxHohcCuPf9nmDzHzzyjDK1SZyYxS0cuPQllf
         d7GBoWgyt2pBquYEKXDFJbeerNnpqTxtSpI87aSmyeSt5yHWg0bulzCm/tWOz+2BenTr
         3aIXpqU8D2+Ezj6EzQGgvWKBlDTC2PgbomxGzACH0LcHQEthwnTjIp9PABlvX5K4m1MY
         5YGvrdvYh/T95bcM7jf0IoFU1IVWYsLwvtNHBngUnkRm8Jx62SVmRZUtykyfes3/baoP
         jZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7zI36NSxfaJ5J3uTjk8pT0e/FfDhLW9RCH5r38MxLg=;
        b=W/yY6zQaqPkX8C1pQQjLBOyoqmOQSgRprS++R9P89ZAWGCKmTHxc/Qw9/GDC5CGpeb
         MKdk377EYQ511NXxiH3tuNjLgv9k3/fmhnsKjJZUGGi4y3epCJvAjL3fJHOqrnUC22/X
         XotkELGydqcXMv3CqUIVlKCg5ZAILgpfMC4YA8c8LaBIusswWReAAFK3kiAtSabVisj0
         Tn1UWsoixD/AohdPJClDORtu8/Kfjb1XktjcldWFAGtnQ3OPTPW+KJfxw8E6tOAy3/gD
         0BJBCiACgduQJ090TjaUY5LfEl7ibqdZ9FlP+sECOnFPe+GqngEIWKIWhzEVjvyEua52
         lBEQ==
X-Gm-Message-State: AOAM533qRNo4AlOUNYkbmi6pGLNwIW5MX/WYAw2JBKLvgtRZjUpc3EqA
        cyLOxNdCSMEFBwB02tlwYCJS0g0jCG8XpWGuTuNG6Q==
X-Google-Smtp-Source: ABdhPJz44d7GFga6KYEjo7D807/7ueAOex5LdL/6Oa/Cid+csLacrtm9bCs3Hl76VsJKYlYy8gf5t2QMTKdKGVoyWSc=
X-Received: by 2002:a17:902:6acb:b0:142:76c3:d35f with SMTP id
 i11-20020a1709026acb00b0014276c3d35fmr26747682plt.89.1638581083442; Fri, 03
 Dec 2021 17:24:43 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4jrm+9UmV=6UHpBDkDd+5TTFvWo-jqDKQ6JZyaygmeB+g@mail.gmail.com>
 <20211203220301.GA3021152@bhelgaas>
In-Reply-To: <20211203220301.GA3021152@bhelgaas>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 3 Dec 2021 17:24:34 -0800
Message-ID: <CAPcyv4hU3ZUG_Psx7GKS-fQMf8_Rb-pn8Lubvnqqbr4Q8AzZcA@mail.gmail.com>
Subject: Re: [PATCH 20/23] cxl/port: Introduce a port driver
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 3, 2021 at 2:03 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Dec 02, 2021 at 05:38:17PM -0800, Dan Williams wrote:
> > [ add Stuart for NPEM feedback ]
> >
> > On Thu, Dec 2, 2021 at 1:24 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, Nov 23, 2021 at 11:17:55PM -0800, Dan Williams wrote:
> > > > On Tue, Nov 23, 2021 at 10:33 PM Christoph Hellwig <hch@lst.de> wrote:
> > > > > On Tue, Nov 23, 2021 at 04:40:06PM -0800, Dan Williams wrote:
> > > > > > Let me ask a clarifying question coming from the other direction that
> > > > > > resulted in the creation of the auxiliary bus architecture. Some
> > > > > > background. RDMA is a protocol that may run on top of Ethernet.
> > > > >
> > > > > No, RDMA is a concept.  Linux supports 2 and a half RDMA protocols
> > > > > that run over ethernet (RoCE v1 and v2 and iWarp).
> > > >
> > > > Yes, I was being too coarse, point taken. However, I don't think that
> > > > changes the observation that multiple vendors are using aux bus to
> > > > share a feature driver across multiple base Ethernet drivers.
> > > >
> > > > > > Consider the case where you have multiple generations of Ethernet
> > > > > > adapter devices, but they all support common RDMA functionality. You
> > > > > > only have the one PCI device to attach a unique Ethernet driver. What
> > > > > > is an idiomatic way to deploy a module that automatically loads and
> > > > > > attaches to the exported common functionality across adapters that
> > > > > > otherwise have a unique native driver for the hardware device?
> > > > >
> > > > > The whole aux bus drama is mostly because the intel design for these
> > > > > is really fucked up.  All the sane HCAs do not use this model.  All
> > > > > this attchment crap really should not be there.
> > > >
> > > > I am missing the counter proposal in both Bjorn's and your distaste
> > > > for aux bus and PCIe portdrv?
> > >
> > > For the case of PCIe portdrv, the functionality involved is Power
> > > Management Events (PME), Advanced Error Reporting (AER), PCIe native
> > > hotplug, Downstream Port Containment (DPC), and Bandwidth
> > > Notifications.
> > >
> > > Currently each has a separate "port service driver" with .probe(),
> > > .remove(), .suspend(), .resume(), etc.
> > >
> > > The services share interrupt vectors.  It's quite complicated to set
> > > them up, and it has to be done in the portdrv, not in the individual
> > > drivers.
> > >
> > > They also share power state (D0, D3hot, etc).
> > >
> > > In my mind these are not separate devices from the underlying PCI
> > > device, and I don't think splitting the support into "service drivers"
> > > made things better.  I think it would be simpler if these were just
> > > added to pci_init_capabilities() like other optional pieces of PCI
> > > functionality.
> > >
> > > Sysfs looks like this:
> > >
> > >   /sys/devices/pci0000:00/0000:00:1c.0/                       # Root Port
> > >   /sys/devices/pci0000:00/0000:00:1c.0/0000:00:1c.0:pcie002/  # AER "device"
> > >   /sys/devices/pci0000:00/0000:00:1c.0/0000:00:1c.0:pcie010/  # BW notif
> > >
> > >   /sys/bus/pci/devices/0000:00:1c.0 -> ../../../devices/pci0000:00/0000:00:1c.0/
> > >   /sys/bus/pci_express/devices/0000:00:1c.0:pcie002 -> ../../../devices/pci0000:00/0000:00:1c.0/0000:00:1c.0:pcie002/
> > >
> > > The "pcie002" names (hex for PCIE_PORT_SERVICE_AER, etc.) are
> > > unintelligible.  I don't know why we have a separate
> > > /sys/bus/pci_express hierarchy.
> > >
> > > IIUC, CXL devices will be enumerated by the usual PCI enumeration, so
> > > there will be a struct pci_dev for them, and they will appear under
> > > /sys/devices/pci*/.
> > >
> > > They will have the usual PCI Power Management, MSI, AER, DPC, and
> > > similar Capabilites, so the PCI core will manage them.
> > >
> > > CXL devices have lots of fancy additional features.  Does that merit
> > > making a separate struct device and a separate sysfs hierarchy for
> > > them?  I don't know.
> >
> > Thank you, this framing really helps.
> >
> > So, if I look at this through the lens of the "can this just be
> > handled by pci_init_capabilities()?" guardband, where the capability
> > is device-scoped and shares resources that a driver for the same
> > device would use, then yes, PCIe port services do not merit a separate
> > bus.
> >
> > CXL memory expansion is distinctly not in that category. CXL is a
> > distinct specification (i.e. unlike PCIe port services which are
> > literally in the PCI Sig purview), distinct transport/data layer
> > (effectively a different physical connection on the wire), and is
> > composable in ways that PCIe is not.
> >
> > For example, if you trigger FLR on a PCI device you would expect the
> > entirety of pci_init_capabilities() needs to be saved / restored, CXL
> > state is not affected by FLR.
> >
> > The separate link layer for CXL means that mere device visibility is
> > not sufficient to determine CXL operation. Whereas with a PCI driver
> > if you can see the device you know that the device is ready to be the
> > target of config, io, and mmio cycles,
>
> Not strictly true.  A PCI device must respond to config transactions
> within a short time after reset, but it does not respond to IO or MEM
> transactions until a driver sets PCI_COMMAND_IO or PCI_COMMAND_MEMORY.

Right, what I was attempting to convey is that it's not like CXL.mem.
While flipping a bit on the device turns on PCI.mmio target support,
there's additional polling and status checking to be done after the
device is enabled to be a target for CXL.mem. I.e. the CXL.mem
configuration is done via PCI.mmio* (*for CXL 2.0 devices) and only
after the device negotiates a CXL link beyond the base PCIe link. It
is also the case that the device may not be ready for CXL.mem until
all the devices that compose the same range are available as well.

>
> > ... CXL.mem operation may not be available when the device is
> > visible to enumeration.
>
> > The composability of CXL places the highest demand for an independent
> > 'struct bus_type' and registering CXL devices for their corresponding
> > PCIe devices. The bus is a rendezvous for all the moving pieces needed
> > to validate and provision a CXL memory region that may span multiple
> > endpoints, switches and host bridges. An action like reprogramming
> > memory decode of an endpoint needs to be coordinated across the entire
> > topology.
>
> I guess software uses the CXL DVSEC to distinguish a CXL device from a
> PCIe device, at least for 00.0.

driver/cxl/pci.c attaches to: "PCI_DEVICE_CLASS((PCI_CLASS_MEMORY_CXL
<< 8 | CXL_MEMORY_PROGIF), ~0)"

I am not aware of any restriction for that class code to appear at function0?

> Not sure about non-Dev 0 Func 0
> devices; maybe this implies other functions in the same device are
> part of the same CXL device?

DVSEC is really only telling us the layout of the MMIO register space.
A CXL Memory Device (CXL.mem endpoint) implements so-called "device"
registers and "component" registers. The "device" registers control
things that a traditional PCI driver would control like a mailbox
interface and device local status registers. The "component" registers
are what mediate access to the CXL.mem decode space.

It is somewhat confusing because CXL 1.1 devices used the DVSEC
configuration registers directly for CXL.mem configuration, but CXL
2.0 ditched that organization. The Linux driver is only targeting CXL
2.0+ devices as platform firmware owns setting up CXL 1.1 memory
expanders. As far as Linux is concerned CXL 1.1 looks like DDR i.e.
it's just address space set up by the BIOS and populated into EFI and
ACPI tables. CXL 1.1 is also implementing a 1:1 device-to-memory-range
association. CXL 2.0 allows for N:1 devices-to-memory-range and
dynamic configuration of that by the OS. CXL 1.1 platform firmware
locks out the OS from making configuration changes.

> A CXL device may comprise several PCIe devices, and I think they may
> have non-CXL Capabilities, so I assume you need a struct pci_dev for
> each PCIe device?
>
> Looks like a single CXL DVSEC controls the entire CXL device
> (including several PCIe devices), so I assume you want some kind of
> struct cxl_dev to represent that aggregation?

We have 3 classes of a 'cxl_dev' in drivers/cxl:

"mem" devices (PCIe endpoints)
"port" devices (PCIe Upstream Switch Ports, PCIe Root Ports, ACPI0016
Host Bridge devices, and ACPI0017 CXL Root devices)
"region" devices (aggregate devices composed of multiple mem devices).

The "mem" driver is tasked with enumerating all "ports" in the path
between itself and the ACPI0017 root and validating that a CXL link is
up at each hop before enumerating "region" devices.

>
> > The fact that the PCI core remains blissfully unaware of all these
> > interdependencies is a feature because CXL is effectively a super-set
> > of PCIe for fast-path CXL.mem operation, even though it is derivative
> > for enumeration and slow-path manageability.
>
> I don't know how blissfully unaware PCI can be.  Can a user remove a
> PCIe device that's part of a CXL device via sysfs?

Yes. If that PCIe device is an endpoint then the corresponding "mem"
driver will get a ->remove() event because it is registered as a child
of that parent PCIe device. That in turn will tear down the relevant
part of the CXL port topology.

However, a gap (deliberate design choice?) in the PCI hotplug
implementation I currently see is an ability for an endpoint PCI
driver to dynamically deny hotplug requests based on the state of the
device. pci_ignore_hotplug() seems inadequate for the job of making
sure that someone first disables all participation of a "mem" device
in all regions before asking for its physical removal. However, if
someone force removes a device the driver and CXL subsystem will do
the right thing and go fail that memory region for all users. I'm
working with other DAX developers on a range based memory_failure()
api for this case.

> Is the PCIe device available for drivers to claim?

drivers/cxl/pci.c *is* a native PCI driver for CXL memory expanders.
You might be thinking of CXL accelerator devices, where the CXL.cache
and CXL.mem capabilities are incremental capabilities for the
accelerator. So, for example, a GPU with CXL.mem capabilities, would
be mostly ignored by the drivers/cxl/ stack by default. Only if that
device+driver wanted to emulate a generic memory expander and share
its memory space with the host might it instantiate mem, port, and
region objects. Otherwise CXL for accelerators is mostly a transparent
capability that the OS may not need to manage. Rather than copy data
back and forth between the host a CXL enabled GPU's driver can just
assign pointers to its local memory space and trust that it is
coherent. That's a gross oversimplification, but I want to convey that
there are CXL devices like accelerators that are the responsibility of
each accelerator PCI driver, vs CXL memory expander devices which are
generic providers of "System RAM" and "Persistent Memory" resources
and need the "mem", "port", "region" schema.

> Do we need coordination between cxl_driver_register() and pci_register_driver()?

They do not collide, and I think this goes back to the concern about
whether drivers/cxl/ is scanning for all CXL DVSECs. No, it only cares
about the CXL DVSEC in CXL memory expander endpoints with the
aforementioned class code, and the CXL DVSEC in every upstream switch
port in the ancestry up to the CXL root device (ACPI0017). CXL
accelerator drivers will always use pci_register_driver() and can
decide to register their DVSEC with the CXL core, or keep it private
to themselves. I imagine a GPU accelerator might register a "mem"
device if it needs to get CXL.mem decode set up after a hotplug event,
but if it's only using CXL.cache, or if its memory space was
established by platform firmware then drivers/cxl/ is not involved.

> Does CXL impose new constraints on PCI power management?

Recall that CXL is built such that it could be supported by a legacy
operating system where platform firmware owns the setup of devices,
just like DDR memory does not need a driver. This is where CXL 1.1
played until CXL 2.0 added so much configuration complexity (hotplug,
interleave, persistent memory) that it started to need OS help. The
Linux PCIe PM code will not notice a difference, but behind the scenes
the device, if it is offering coherent memory to the CPU, will be
coordinating with the CPU like it was part of the CPU package and not
a discrete device. I do not see new PM software enabling required in
my reading of "Section 10.0 Power Management" of the CXL
specification.

> > So I hope you see CXL's need to create some PCIe-symbiotic objects in
> > order to compose CXL objects (like interleaved memory regions) that
> > have no PCIe analog.
>
> > > Hotplug is more central to PCI than NPEM is, but NPEM is a little bit
> > > like PCIe native hotplug in concept: hotplug has a few registers that
> > > control downstream indicators, interlock, and power controller; NPEM
> > > has registers that control downstream indicators.
> > >
> > > Both are prescribed by the PCIe spec and presumably designed to work
> > > alongside the usual device-specific drivers for bridges, SSDs, etc.
> > >
> > > I would at least explore the idea of doing common support by
> > > integrating NPEM into the PCI core.  There would have to be some hook
> > > for the enclosure-specific bits, but I think it's fair for the details
> > > of sending commands and polling for command completed to be part of
> > > the PCI core.
> >
> > The problem with NPEM compared to hotplug LED signaling is that it has
> > the strange property that an NPEM higher in the topology might
> > override one lower in the topology. This is to support things like
> > NVME enclosures where the NVME device itself may have an NPEM
> > instance, but that instance is of course not suitable for signaling
> > that the device is not present.
>
> I would envision the PCI core providing only a bare-bones "send this
> command and wait for it to complete" sort of interface.  Everything
> else, including deciding which device to use, would go elsewhere.
>
> > So, instead the system may be designed to have an NPEM in the
> > upstream switch port and disable the NPEM instances in the device.
> > Platform firmware decides which NPEM is in use.
>
> Since you didn't mention a firmware interface to communicate which
> NPEM is in use, I assume firmware does this by preventing other
> devices from advertising NPEM support?

That's also my assumption. If the OS sees a disabled NPEM in the
topology it just needs to assume firmware knew what it was doing when
it disabled it. I wish NPEM was better specified than "trust firmware
to do the right thing via an ambiguous signal".

>
> > It also has the "fun" property of additionally being overridden by ACPI.
> > ...
> > One of the nice properties of the auxiliary organization is well
> > defined module boundaries. Will NPEM in the PCI core now force
> > CONFIG_ENCLOSURE_SERVICES to be built-in? That seems an unwanted side
> > effect to me.
>
> If the PCI core provides only the mechanism, and the smarts of NPEM
> are in something analogous to drivers/scsi/ses.c, I don't think it
> would force CONFIG_ENCLOSURE_SERVICES to be built-in.

What is that dynamic thing that glues CONFIG_ENCLOSURE_SERVICES to the
PCI core that also does not require statically linking that glue to
every driver that wants to talk to NPEM? I don't mind that the base
hardware access mechanism library is in the PCI core, but what does
NVME and the CXL memory expander driver register to get NPEM service
and associate their block / memory device with an enclosure slot? To
me that glue for these one-off ancillary features is what aux-bus is
all about, but I'm open to it not being aux-bus in the end. Maybe
Stuart has a proposal here?

>
> > > DOE *is* specified by PCIe, at least in terms of the data transfer
> > > protocol (interrupt usage, read/write mailbox, etc).  I think that,
> > > and the fact that it's not specific to CXL, means we need some kind of
> > > PCI core interface to do the transfers.
> >
> > DOE transfer code belongs in drivers/pci/ period, but does it really
> > need to be in drivers/pci/built-in.a for everyone regardless of
> > whether it is being used or not?
>
> I think my opinion would depend on how small the DOE transfer code
> could be made and how much it would complicate things to make it a
> module.  And also how we could enforce whatever mutual exclusion we
> need to make it safe.

At least for the mutual exclusion aspect I'm thinking of typical
request_region() style exclusion where the aux-driver claims the
configuration address register range.
