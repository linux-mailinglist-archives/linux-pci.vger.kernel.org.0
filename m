Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C3D466F2D
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 02:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377962AbhLCBlv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 20:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377969AbhLCBlv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 20:41:51 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6360CC061757
        for <linux-pci@vger.kernel.org>; Thu,  2 Dec 2021 17:38:28 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b11so982559pld.12
        for <linux-pci@vger.kernel.org>; Thu, 02 Dec 2021 17:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M/ANrGwhQFEx6Z+5lVwqburaYvP+7L9tRLRfIoQa5r0=;
        b=e9yEasfbu/n5VFWbDdC3r7xVC2jkcUxdTCWtPoD/X5ezVz8VXPmt+5OlfW8FUbT+mj
         yBrynj3XVLmYL4rf4DIFdpswc3xsG42oa7GhwOaSDSgexhENBlx5luJTONvqwUqprZtX
         iAYrr1xahlHb8vEpIIhATUACXBrFuWskzObnohi3BqARtl9RfEOqMMtQySrNnZ5eePkH
         GoxlxEKZPGrU6XJ/b+2laG4w9747GKnBC2353EJyslQWFjGsc4Jd8y+UoQM+7VBRQK8a
         /gLPtPLo4Oo2zEaO22Iyn5DRzmyNUSHK6leeV89+vSgPb5x79WSNq8u0q1Gz3dzgx0mJ
         TChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/ANrGwhQFEx6Z+5lVwqburaYvP+7L9tRLRfIoQa5r0=;
        b=vlxYhTVBerlCh70fITbL4hCYfAh2z+ZGwTxZ8NzYqJes+1hxBHnQh0tSt8brs6J2ro
         We3+7sm+ckbtwaBjzjRA1G9tqhOUIJYbGVZR97QGHERvsAd5qamDmahq4eH64D5+d2B2
         5vwLXae2oth9U1zPuzrF3pqJ8YWkWwLhMdtHyFP5uIYbJqVLonYEbfwBe56ogduYzHLd
         YNn4vqrnadtLY+OF3SAAlK8mL5t8S2NRRi6C7JLNTy5JvJY6YJXhqFiuHg4rwwH4JAjx
         J5YJCl7klteKrPs6pBdnKyeVEs/z/5efks+2uMDYUG4dQ2PdVY8fTtpyWRduFQfqZMpE
         zHAQ==
X-Gm-Message-State: AOAM532qGS6QwfSPFTUfFF8s61t/smkjeHD/YJB21LaHJNfrjVXZZbc1
        7ObmNK0jfuAGGipPQMAyPzNLArEKRhagFFIXy8a55Q==
X-Google-Smtp-Source: ABdhPJyuemrB0Hk8bozmT1P7PNE8L4B+temcrkeA0TWstKPlI+GBgAVKXaAu1qxnNa1q8DIg5sRiwMaA/FXTTvYbbnU=
X-Received: by 2002:a17:902:6acb:b0:142:76c3:d35f with SMTP id
 i11-20020a1709026acb00b0014276c3d35fmr19254879plt.89.1638495507759; Thu, 02
 Dec 2021 17:38:27 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4ii=bjKNQxoMLF-gscJy7Bh8CUn205_1GpCwfMyJ22+6g@mail.gmail.com>
 <20211202212405.GA2918514@bhelgaas>
In-Reply-To: <20211202212405.GA2918514@bhelgaas>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 2 Dec 2021 17:38:17 -0800
Message-ID: <CAPcyv4jrm+9UmV=6UHpBDkDd+5TTFvWo-jqDKQ6JZyaygmeB+g@mail.gmail.com>
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

[ add Stuart for NPEM feedback ]

On Thu, Dec 2, 2021 at 1:24 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Nov 23, 2021 at 11:17:55PM -0800, Dan Williams wrote:
> > On Tue, Nov 23, 2021 at 10:33 PM Christoph Hellwig <hch@lst.de> wrote:
> > > On Tue, Nov 23, 2021 at 04:40:06PM -0800, Dan Williams wrote:
> > > > Let me ask a clarifying question coming from the other direction that
> > > > resulted in the creation of the auxiliary bus architecture. Some
> > > > background. RDMA is a protocol that may run on top of Ethernet.
> > >
> > > No, RDMA is a concept.  Linux supports 2 and a half RDMA protocols
> > > that run over ethernet (RoCE v1 and v2 and iWarp).
> >
> > Yes, I was being too coarse, point taken. However, I don't think that
> > changes the observation that multiple vendors are using aux bus to
> > share a feature driver across multiple base Ethernet drivers.
> >
> > > > Consider the case where you have multiple generations of Ethernet
> > > > adapter devices, but they all support common RDMA functionality. You
> > > > only have the one PCI device to attach a unique Ethernet driver. What
> > > > is an idiomatic way to deploy a module that automatically loads and
> > > > attaches to the exported common functionality across adapters that
> > > > otherwise have a unique native driver for the hardware device?
> > >
> > > The whole aux bus drama is mostly because the intel design for these
> > > is really fucked up.  All the sane HCAs do not use this model.  All
> > > this attchment crap really should not be there.
> >
> > I am missing the counter proposal in both Bjorn's and your distaste
> > for aux bus and PCIe portdrv?
>
> For the case of PCIe portdrv, the functionality involved is Power
> Management Events (PME), Advanced Error Reporting (AER), PCIe native
> hotplug, Downstream Port Containment (DPC), and Bandwidth
> Notifications.
>
> Currently each has a separate "port service driver" with .probe(),
> .remove(), .suspend(), .resume(), etc.
>
> The services share interrupt vectors.  It's quite complicated to set
> them up, and it has to be done in the portdrv, not in the individual
> drivers.
>
> They also share power state (D0, D3hot, etc).
>
> In my mind these are not separate devices from the underlying PCI
> device, and I don't think splitting the support into "service drivers"
> made things better.  I think it would be simpler if these were just
> added to pci_init_capabilities() like other optional pieces of PCI
> functionality.
>
> Sysfs looks like this:
>
>   /sys/devices/pci0000:00/0000:00:1c.0/                       # Root Port
>   /sys/devices/pci0000:00/0000:00:1c.0/0000:00:1c.0:pcie002/  # AER "device"
>   /sys/devices/pci0000:00/0000:00:1c.0/0000:00:1c.0:pcie010/  # BW notif
>
>   /sys/bus/pci/devices/0000:00:1c.0 -> ../../../devices/pci0000:00/0000:00:1c.0/
>   /sys/bus/pci_express/devices/0000:00:1c.0:pcie002 -> ../../../devices/pci0000:00/0000:00:1c.0/0000:00:1c.0:pcie002/
>
> The "pcie002" names (hex for PCIE_PORT_SERVICE_AER, etc.) are
> unintelligible.  I don't know why we have a separate
> /sys/bus/pci_express hierarchy.
>
> IIUC, CXL devices will be enumerated by the usual PCI enumeration, so
> there will be a struct pci_dev for them, and they will appear under
> /sys/devices/pci*/.
>
> They will have the usual PCI Power Management, MSI, AER, DPC, and
> similar Capabilites, so the PCI core will manage them.
>
> CXL devices have lots of fancy additional features.  Does that merit
> making a separate struct device and a separate sysfs hierarchy for
> them?  I don't know.

Thank you, this framing really helps.

So, if I look at this through the lens of the "can this just be
handled by pci_init_capabilities()?" guardband, where the capability
is device-scoped and shares resources that a driver for the same
device would use, then yes, PCIe port services do not merit a separate
bus.

CXL memory expansion is distinctly not in that category. CXL is a
distinct specification (i.e. unlike PCIe port services which are
literally in the PCI Sig purview), distinct transport/data layer
(effectively a different physical connection on the wire), and is
composable in ways that PCIe is not.

For example, if you trigger FLR on a PCI device you would expect the
entirety of pci_init_capabilities() needs to be saved / restored, CXL
state is not affected by FLR.

The separate link layer for CXL means that mere device visibility is
not sufficient to determine CXL operation. Whereas with a PCI driver
if you can see the device you know that the device is ready to be the
target of config, io, and mmio cycles, CXL.mem operation may not be
available when the device is visible to enumeration.

The composability of CXL places the highest demand for an independent
'struct bus_type' and registering CXL devices for their corresponding
PCIe devices. The bus is a rendezvous for all the moving pieces needed
to validate and provision a CXL memory region that may span multiple
endpoints, switches and host bridges. An action like reprogramming
memory decode of an endpoint needs to be coordinated across the entire
topology.

The fact that the PCI core remains blissfully unaware of all these
interdependencies is a feature because CXL is effectively a super-set
of PCIe for fast-path CXL.mem operation, even though it is derivative
for enumeration and slow-path manageability.

So I hope you see CXL's need to create some PCIe-symbiotic objects in
order to compose CXL objects (like interleaved memory regions) that
have no PCIe analog.

> > > > Another example, the Native PCIe Enclosure Management (NPEM)
> > > > specification defines a handful of registers that can appear anywhere
> > > > in the PCIe hierarchy. How can you write a common driver that is
> > > > generically applicable to any given NPEM instance?
> > >
> > > Another totally messed up spec.  But then pretty much everything coming
> > > from the PCIe SIG in terms of interface tends to be really, really
> > > broken lately.
>
> Hotplug is more central to PCI than NPEM is, but NPEM is a little bit
> like PCIe native hotplug in concept: hotplug has a few registers that
> control downstream indicators, interlock, and power controller; NPEM
> has registers that control downstream indicators.
>
> Both are prescribed by the PCIe spec and presumably designed to work
> alongside the usual device-specific drivers for bridges, SSDs, etc.
>
> I would at least explore the idea of doing common support by
> integrating NPEM into the PCI core.  There would have to be some hook
> for the enclosure-specific bits, but I think it's fair for the details
> of sending commands and polling for command completed to be part of
> the PCI core.

The problem with NPEM compared to hotplug LED signaling is that it has
the strange property that an NPEM higher in the topology might
override one lower in the topology. This is to support things like
NVME enclosures where the NVME device itself may have an NPEM
instance, but that instance is of course not suitable for signaling
that the device is not present. So, instead the system may be designed
to have an NPEM in the upstream switch port and disable the NPEM
instances in the device. Platform firmware decides which NPEM is in
use.

It also has the "fun" property of additionally being overridden by ACPI.

Stuart, have a look at collapsing the auxiliary-device approach into
pci_init_capabilities() and whether that can still coordinate with the
enclosure code.

One of the nice properties of the auxiliary organization is well
defined module boundaries. Will NPEM in the PCI core now force
CONFIG_ENCLOSURE_SERVICES to be built-in? That seems an unwanted side
effect to me.

> > DVSEC and DOE is more of the same in terms of composing add-on
> > features into devices. Hardware vendors want to mix multiple hard-IPs
> > into a single device, aux bus is one response. Topology specific buses
> > like /sys/bus/cxl are another.
>
> VSEC and DVSEC are pretty much wild cards since the PCIe spec says
> nothing about what registers they may contain or how they should work.
>
> DOE *is* specified by PCIe, at least in terms of the data transfer
> protocol (interrupt usage, read/write mailbox, etc).  I think that,
> and the fact that it's not specific to CXL, means we need some kind of
> PCI core interface to do the transfers.

DOE transfer code belongs in drivers/pci/ period, but does it really
need to be in drivers/pci/built-in.a for everyone regardless of
whether it is being used or not?
