Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25175466B9A
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 22:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377030AbhLBV1e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 16:27:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35098 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349000AbhLBV1b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 16:27:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6B526285A;
        Thu,  2 Dec 2021 21:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C889DC00446;
        Thu,  2 Dec 2021 21:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638480247;
        bh=o7+t3DCbVFKCCTBenNxoyOz36LbK9+1Y54ENVixcE0o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nJmhlcR5QFcSiT9vNQJwIqf3rsHqEjkUWfStp+dFT7IquVNhsLPo0qOIKrkIx0FOy
         orX0EnAJ88V3QeivowcPSy6RE9GStypMpGVp9c94nt0nzoIjF8RotK121LYr9daPa0
         YkrkEB4ly3s2THCuSzdqEFPw+TqSMS8FVMDZodQESy7z62RX+QQTB8r6NNrgIKQ26p
         vABKvtHBW9lEbKD/B+bMqsO9Ts1z8xpbQMKPewbKTMSBCGyBLhOQnpDXnfW6TvTzq2
         ndBHlIjXzxRJp/dQnPtXPSI4S3IwKN4r667arOdHIjfnHYmz2VJbZEtVVaggoF8K6p
         M80IgL6D3bA+A==
Date:   Thu, 2 Dec 2021 15:24:05 -0600
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
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 20/23] cxl/port: Introduce a port driver
Message-ID: <20211202212405.GA2918514@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ii=bjKNQxoMLF-gscJy7Bh8CUn205_1GpCwfMyJ22+6g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 23, 2021 at 11:17:55PM -0800, Dan Williams wrote:
> On Tue, Nov 23, 2021 at 10:33 PM Christoph Hellwig <hch@lst.de> wrote:
> > On Tue, Nov 23, 2021 at 04:40:06PM -0800, Dan Williams wrote:
> > > Let me ask a clarifying question coming from the other direction that
> > > resulted in the creation of the auxiliary bus architecture. Some
> > > background. RDMA is a protocol that may run on top of Ethernet.
> >
> > No, RDMA is a concept.  Linux supports 2 and a half RDMA protocols
> > that run over ethernet (RoCE v1 and v2 and iWarp).
> 
> Yes, I was being too coarse, point taken. However, I don't think that
> changes the observation that multiple vendors are using aux bus to
> share a feature driver across multiple base Ethernet drivers.
> 
> > > Consider the case where you have multiple generations of Ethernet
> > > adapter devices, but they all support common RDMA functionality. You
> > > only have the one PCI device to attach a unique Ethernet driver. What
> > > is an idiomatic way to deploy a module that automatically loads and
> > > attaches to the exported common functionality across adapters that
> > > otherwise have a unique native driver for the hardware device?
> >
> > The whole aux bus drama is mostly because the intel design for these
> > is really fucked up.  All the sane HCAs do not use this model.  All
> > this attchment crap really should not be there.
> 
> I am missing the counter proposal in both Bjorn's and your distaste
> for aux bus and PCIe portdrv?

For the case of PCIe portdrv, the functionality involved is Power
Management Events (PME), Advanced Error Reporting (AER), PCIe native
hotplug, Downstream Port Containment (DPC), and Bandwidth
Notifications.

Currently each has a separate "port service driver" with .probe(),
.remove(), .suspend(), .resume(), etc.

The services share interrupt vectors.  It's quite complicated to set
them up, and it has to be done in the portdrv, not in the individual
drivers.

They also share power state (D0, D3hot, etc).  

In my mind these are not separate devices from the underlying PCI
device, and I don't think splitting the support into "service drivers"
made things better.  I think it would be simpler if these were just
added to pci_init_capabilities() like other optional pieces of PCI
functionality.

Sysfs looks like this:

  /sys/devices/pci0000:00/0000:00:1c.0/                       # Root Port
  /sys/devices/pci0000:00/0000:00:1c.0/0000:00:1c.0:pcie002/  # AER "device"
  /sys/devices/pci0000:00/0000:00:1c.0/0000:00:1c.0:pcie010/  # BW notif

  /sys/bus/pci/devices/0000:00:1c.0 -> ../../../devices/pci0000:00/0000:00:1c.0/
  /sys/bus/pci_express/devices/0000:00:1c.0:pcie002 -> ../../../devices/pci0000:00/0000:00:1c.0/0000:00:1c.0:pcie002/

The "pcie002" names (hex for PCIE_PORT_SERVICE_AER, etc.) are
unintelligible.  I don't know why we have a separate
/sys/bus/pci_express hierarchy.

IIUC, CXL devices will be enumerated by the usual PCI enumeration, so
there will be a struct pci_dev for them, and they will appear under
/sys/devices/pci*/.

They will have the usual PCI Power Management, MSI, AER, DPC, and
similar Capabilites, so the PCI core will manage them.

CXL devices have lots of fancy additional features.  Does that merit
making a separate struct device and a separate sysfs hierarchy for
them?  I don't know.

> > > Another example, the Native PCIe Enclosure Management (NPEM)
> > > specification defines a handful of registers that can appear anywhere
> > > in the PCIe hierarchy. How can you write a common driver that is
> > > generically applicable to any given NPEM instance?
> >
> > Another totally messed up spec.  But then pretty much everything coming
> > from the PCIe SIG in terms of interface tends to be really, really
> > broken lately.

Hotplug is more central to PCI than NPEM is, but NPEM is a little bit
like PCIe native hotplug in concept: hotplug has a few registers that
control downstream indicators, interlock, and power controller; NPEM
has registers that control downstream indicators.

Both are prescribed by the PCIe spec and presumably designed to work
alongside the usual device-specific drivers for bridges, SSDs, etc.

I would at least explore the idea of doing common support by
integrating NPEM into the PCI core.  There would have to be some hook
for the enclosure-specific bits, but I think it's fair for the details
of sending commands and polling for command completed to be part of
the PCI core.

> DVSEC and DOE is more of the same in terms of composing add-on
> features into devices. Hardware vendors want to mix multiple hard-IPs
> into a single device, aux bus is one response. Topology specific buses
> like /sys/bus/cxl are another.

VSEC and DVSEC are pretty much wild cards since the PCIe spec says
nothing about what registers they may contain or how they should work.

DOE *is* specified by PCIe, at least in terms of the data transfer
protocol (interrupt usage, read/write mailbox, etc).  I think that,
and the fact that it's not specific to CXL, means we need some kind of
PCI core interface to do the transfers.

> This CXL port driver is offering enumeration, link management, and
> memory decode setup services to the rest of the topology. I see it as
> similar to management protocol services offered by libsas.

Bjorn
