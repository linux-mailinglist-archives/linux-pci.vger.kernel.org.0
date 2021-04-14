Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A3235EA3B
	for <lists+linux-pci@lfdr.de>; Wed, 14 Apr 2021 03:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbhDNBPL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 21:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232096AbhDNBPK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Apr 2021 21:15:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3660613B6;
        Wed, 14 Apr 2021 01:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618362889;
        bh=Ilz1fM4cCSvk1C8dy8sdftyD3f2Y9Vn7ORj9gYC+c78=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TfzHmFoATvLhvsRPQwb/lc4tiIiefyzF0hHoLrgoST/f/dCEaXpUriR1lf8HF7QdH
         Y5XKg2RqWOynWCKLwe1FlC/BpacdaNauWU/YJMjZCDqDa0B+OIhZ9hxX+Yy87Ur3br
         sCIEkxe6z6zIK2Rc3FDQ5uBcn+xX0gkAryvxxFwgRtTdffcGhqVQv4lm/MZ+HADa7V
         l7Xhd5QFsUSJ/7fc+Y/k6d3qWVnYqbvkop6QaP+2pdJ21ZckUcdJI3BKs+b1nRV1AN
         3vEJ/JOco/D7B3+LLKlVz3EebttvZ04/gzltpa3JDZU/az8MPMTShHL9zLTAe83XxG
         UrT7upD3RkXOA==
Date:   Tue, 13 Apr 2021 20:14:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 7/8] cxl/port: Introduce cxl_port objects
Message-ID: <20210414011448.GA2266325@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hAc=DERr1z8kr=V01+NSi74f-kSfMAdeArLmVb112_Dw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 08, 2021 at 07:13:38PM -0700, Dan Williams wrote:
> Hi Bjorn, thanks for taking a look.
> 
> On Thu, Apr 8, 2021 at 3:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Greg, Rafael, Matthew: device model questions]
> >
> > Hi Dan,
> >
> > On Thu, Apr 01, 2021 at 07:31:20AM -0700, Dan Williams wrote:
> > > Once the cxl_root is established then other ports in the hierarchy can
> > > be attached. The cxl_port object, unlike cxl_root that is associated
> > > with host bridges, is associated with PCIE Root Ports or PCIE Switch
> > > Ports. Add cxl_port instances for all PCIE Root Ports in an ACPI0016
> > > host bridge.

Incidentally, "PCIe" is the abbreviation used in the PCIe specs, so I
try to use that instead of "PCIE" in drivers/pci/.

> > I'm not a device model expert, but I'm not sure about adding a new
> > /sys/bus/cxl/devices hierarchy.  I'm under the impression that CXL
> > devices will be enumerated by the PCI core as PCIe devices.
> 
> Yes, PCIe is involved, but mostly only for the CXL.io slow path
> (configuration and provisioning via mailbox) when we're talking about
> memory expander devices (CXL calls these Type-3). So-called "Type-3"
> support is the primary driver of this infrastructure.
>
> You might be thinking of CXL accelerator devices that will look like
> plain PCIe devices that happen to participate in the CPU cache
> hierarchy (CXL calls these Type-1). There will also be accelerator
> devices that want to share coherent memory with the system (CXL calls
> these Type-2).

IIUC all these CXL devices will be enumerated by the PCI core.  They
seem to have regular PCI BARs (separate from the HDM stuff), so the
PCI core will presumably manage address allocation for them.  It looks
like Function Level Reset and hotplug are supposed to use the regular
PCIe code.  I guess this will all be visible via lspci just like
regular PCI devices, right?

> The infrastructure being proposed here is primarily for the memory
> expander (Type-3) device case where the PCI sysfs hierarchy is wholly
> unsuited for modeling it. A single CXL memory region device may span
> multiple endpoints, switches, and host bridges. It poses similar
> stress to an OS device model as RAID where there is a driver for the
> component contributors to an upper level device / driver that exposes
> the RAID Volume (CXL memory region interleave set). The CXL memory
> decode space (HDM: Host Managed Device Memory) is independent of the
> PCIe MMIO BAR space.

It looks like you add a cxl_port for each ACPI0016 device and every
PCIe Root Port below it.  So I guess the upper level spanning is at a
higher level than cxl_port?

> That's where the /sys/bus/cxl hierarchy is needed, to manage the HDM
> space across the CXL topology in a way that is foreign to PCIE (HDM
> Decoder hierarchy).

When we do FLR on the PCIe device, what happens to these CXL clients?
Do they care?  Are they notified?  Do they need to do anything before
or after the FLR?

What about hotplug?  Spec says it leverages PCIe hotplug, but it looks
like maybe this all requires ACPI hotplug (acpiphp) for adding
ACPI0017 devices and notifying of hot remove requests?  If it uses
PCIe native hotplug (pciehp), what connects the CXL side to the PCI
side?

I guess the HDM address space management is entirely outside the scope
of PCI -- the address space is not described by the CXL host bridge
_CRS and not described by CXL endpoint BARs?  Where *is* it described
and who manages and allocates it?  I guess any transaction routing
through the CXL fabric for HDM space is also completely outside the
scope of PCI -- we don't need to worry about managing PCI-to-PCI
bridge windows, for instance?

Is there a cxl_register_driver() or something?  I assume there will be
drivers that need to manage CXL devices?  Or will they use
pci_register_driver() and search for a CXL capability?

> > Doesn't that mean we will have one struct device in the pci_dev,
> > and another one in the cxl_port?
> 
> Yes, that is the proposal.

> The superfluous power/ issue can be cleaned up with
> device_set_pm_not_required().

Thanks, we might be able to use that for portdrv.  I added it to my
list to investigate.

> What are the other problems this poses, because in other areas this
> ability to subdivide a device's functionality into sub-drivers is a
> useful organization principle?

Well, I'm thinking about things like enumeration, hotplug, reset,
resource management (BARs, bridge windows, etc), interrupts, power
management (suspend, resume, etc), and error reporting.  These are all
things that PCIe defines on a per-Function basis and seem kind of hard
to cleanly subdivide.

> So much so that several device writer teams came together to create
> the auxiliary-bus for the purpose of allowing sub-drivers to be
> carved off for independent functionality similar to the portdrv
> organization.

Is "auxiliary-bus" a specific thing?  I'm not familiar with it but
again I'd like to read up on it in case it has ideas we could
leverage.

Sub-drivers *is* an issue for PCI in general, although mostly I think
it tends to be historical devices where people made the design mistake
of putting several unrelated pieces of functionality in the same PCI
function, so I don't think PCI has good infrastructure for doing that.

Bjorn
