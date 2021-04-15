Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152FA360189
	for <lists+linux-pci@lfdr.de>; Thu, 15 Apr 2021 07:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhDOFVz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 01:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhDOFVw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Apr 2021 01:21:52 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6E0C06175F
        for <linux-pci@vger.kernel.org>; Wed, 14 Apr 2021 22:21:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id x12so14120035ejc.1
        for <linux-pci@vger.kernel.org>; Wed, 14 Apr 2021 22:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yfHpVPgTxoCb2Y8HlsquPo4Y9DrlaYo1kZmF94VXk9g=;
        b=LXXLMqN91EHunpLCu7HVsmlVUG/34MyNVDrXjCBRS9736Y2tjgx8x5winXvUs+zXj3
         rwJ2uqJvK+Ob9ZnzAq6SV8qDx560IxhxYHiKKDTjSCc3HhCjcN06qslXMvmQviI9D39N
         gzmgaCj3t58bChjcG6ShEnLdx9HdOE7gzP8smWqB08wTMDb1tokv7X41knp4J6lxAD1q
         lTsSC2ry2mqH679hBxf+j+QML696u6DHJQvTYAP5DUsW4HeR7hBbdPePcYsnw9SJn8CU
         Fd3XWLdEtnwU8nuPNXFOlApKcKsPG2hhNPfLIqc3yJXU/guySXKE4vlF7vRSJ1aR18Jz
         M8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yfHpVPgTxoCb2Y8HlsquPo4Y9DrlaYo1kZmF94VXk9g=;
        b=JrP/iqiTFvm6W2v/+YOskArEBW8Xflc7NUrVAzmbcYv48gg8t2xSdTjGDKFy2cJRNw
         tQChm81KMlZZxafOqZzB/rsmCYSm1Ul9ZMGweg1khNA5VlOupYx3lHquQiKZj0I+AqtP
         s7vckOKRGn8z/7u3FEN/evrp4l8lM41yFDcNcyFf7ZSB60ikqE8q/tNQk5GKSR+EGqbj
         xrSHFa2or0qLUmjifRBbvIszcVZu4mY6ZJ9DtriL/Kv/OmV+UI027GhANRWb3OXKE6JX
         P+FQzKZ01VBMeSj1z7nITCq6ikzkkVLutJByAS9FF6L2vyzE07jaUJoJCWXwwD+qtptp
         rdHg==
X-Gm-Message-State: AOAM532wEEeTtEBI5EBA0LXFcfbndnbo5eKvQBx0qqr6eERD+UUXdsEm
        Ml3NveZwxSQ6EMHgd8xEtERmros+TvbMmUQiX6E4fw==
X-Google-Smtp-Source: ABdhPJwBKg5W4y/Mf5LNN3YaLgfsq6e9XlkPVLczLmK+QZIR3hWfVS2xvwGTnxXu7rmqfj/yjLTszCzhcNe5KyBvip4=
X-Received: by 2002:a17:906:ef2:: with SMTP id x18mr1581794eji.323.1618464085912;
 Wed, 14 Apr 2021 22:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4hAc=DERr1z8kr=V01+NSi74f-kSfMAdeArLmVb112_Dw@mail.gmail.com>
 <20210414011448.GA2266325@bjorn-Precision-5520>
In-Reply-To: <20210414011448.GA2266325@bjorn-Precision-5520>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 14 Apr 2021 22:21:14 -0700
Message-ID: <CAPcyv4iu8D-hJoujLXw8a4myS7trOE1FcUhESLB_imGMECVfrg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] cxl/port: Introduce cxl_port objects
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 13, 2021 at 6:15 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Apr 08, 2021 at 07:13:38PM -0700, Dan Williams wrote:
> > Hi Bjorn, thanks for taking a look.
> >
> > On Thu, Apr 8, 2021 at 3:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > [+cc Greg, Rafael, Matthew: device model questions]
> > >
> > > Hi Dan,
> > >
> > > On Thu, Apr 01, 2021 at 07:31:20AM -0700, Dan Williams wrote:
> > > > Once the cxl_root is established then other ports in the hierarchy can
> > > > be attached. The cxl_port object, unlike cxl_root that is associated
> > > > with host bridges, is associated with PCIE Root Ports or PCIE Switch
> > > > Ports. Add cxl_port instances for all PCIE Root Ports in an ACPI0016
> > > > host bridge.
>
> Incidentally, "PCIe" is the abbreviation used in the PCIe specs, so I
> try to use that instead of "PCIE" in drivers/pci/.

Noted.

>
> > > I'm not a device model expert, but I'm not sure about adding a new
> > > /sys/bus/cxl/devices hierarchy.  I'm under the impression that CXL
> > > devices will be enumerated by the PCI core as PCIe devices.
> >
> > Yes, PCIe is involved, but mostly only for the CXL.io slow path
> > (configuration and provisioning via mailbox) when we're talking about
> > memory expander devices (CXL calls these Type-3). So-called "Type-3"
> > support is the primary driver of this infrastructure.
> >
> > You might be thinking of CXL accelerator devices that will look like
> > plain PCIe devices that happen to participate in the CPU cache
> > hierarchy (CXL calls these Type-1). There will also be accelerator
> > devices that want to share coherent memory with the system (CXL calls
> > these Type-2).
>
> IIUC all these CXL devices will be enumerated by the PCI core.  They
> seem to have regular PCI BARs (separate from the HDM stuff), so the
> PCI core will presumably manage address allocation for them.  It looks
> like Function Level Reset and hotplug are supposed to use the regular
> PCIe code.  I guess this will all be visible via lspci just like
> regular PCI devices, right?

Yes. the CXL.io protocol is synonymous with PCIe. Hotplug is native
PCIe hotplug to negotiate getting the card online and offline.
Although, for offline an additional constraint is to deny removal
whenever the card has active pages in the page allocator. Similar to
what happens today for ACPI memory hotplug where the OS can say "nope,
there's still active pages in the range you asked to eject".

FLR has no effect on CXL.cache or CXL.mem state, only CXL.io.

> > The infrastructure being proposed here is primarily for the memory
> > expander (Type-3) device case where the PCI sysfs hierarchy is wholly
> > unsuited for modeling it. A single CXL memory region device may span
> > multiple endpoints, switches, and host bridges. It poses similar
> > stress to an OS device model as RAID where there is a driver for the
> > component contributors to an upper level device / driver that exposes
> > the RAID Volume (CXL memory region interleave set). The CXL memory
> > decode space (HDM: Host Managed Device Memory) is independent of the
> > PCIe MMIO BAR space.
>
> It looks like you add a cxl_port for each ACPI0016 device and every
> PCIe Root Port below it.  So I guess the upper level spanning is at a
> higher level than cxl_port?

A memory interleave can span any level of the hierarchy. It can be
across host bridges at the top level, but also incorporate a leaf
device at the bottom of a CXL switch hierarchy. There will be a
cxl_port instance for each side of each link.

> > That's where the /sys/bus/cxl hierarchy is needed, to manage the HDM
> > space across the CXL topology in a way that is foreign to PCIE (HDM
> > Decoder hierarchy).
>
> When we do FLR on the PCIe device, what happens to these CXL clients?
> Do they care?  Are they notified?  Do they need to do anything before
> or after the FLR?

Per CXL Spec:

"FLR has no effect on the CXL.cache and CXL.mem protocol. Any
CXL.cache and CXL.mem related control registers including CXL DVSEC
structures and state held by the CXL device are not affected by FLR.
The memory controller hosting the HDM is not reset by FLR."

> What about hotplug?  Spec says it leverages PCIe hotplug, but it looks
> like maybe this all requires ACPI hotplug (acpiphp) for adding
> ACPI0017 devices and notifying of hot remove requests?  If it uses
> PCIe native hotplug (pciehp), what connects the CXL side to the PCI
> side?

No ACPI hotplug is not involved. ACPI0017 is essentially just a dummy
anchor device to hang the interleave set coordination. The connect
from native hotplug to CXL is the cxl_mem driver. When that it detects
a new device it walks the cxl_port hierarchy to see if one is a parent
of this endpoint. Then it registers its HDM decoders with the CXL core
and the CXL core can online it as a standalone interneleave set or
consolidate it with others to make a wider set. For persistent memory
there is on-device metadata to recall whether this device was part of
a set previously. For volatile-only devices it would need to rely on
some policy to decide if devices are immediately onlined standalone,
or wait for an administrator to configure them.

> I guess the HDM address space management is entirely outside the scope
> of PCI -- the address space is not described by the CXL host bridge
> _CRS and not described by CXL endpoint BARs?

Correct.

> Where *is* it described
> and who manages and allocates it?

ACPI0017 will communicate a set of address spaces that the CXL core
can allocate interleave sets.

>  I guess any transaction routing
> through the CXL fabric for HDM space is also completely outside the
> scope of PCI -- we don't need to worry about managing PCI-to-PCI
> bridge windows, for instance?

Correct. For example a PCIe switch could disable all I/O space and
Memory (MMIO) space, but still decode Host-managed Device Memory (HDM)
space.

> Is there a cxl_register_driver() or something?  I assume there will be
> drivers that need to manage CXL devices?  Or will they use
> pci_register_driver() and search for a CXL capability?

A bit of both. The cxl_mem driver does pci_register_driver(), but for
ports there will be a driver on the CXL bus for that component
capability. Both endpoints and switches will produce cxl_port
instances to be connected / driven by a core driver and coordinated
with a root level driver for address space and interleave management.

> > > Doesn't that mean we will have one struct device in the pci_dev,
> > > and another one in the cxl_port?
> >
> > Yes, that is the proposal.
>
> > The superfluous power/ issue can be cleaned up with
> > device_set_pm_not_required().
>
> Thanks, we might be able to use that for portdrv.  I added it to my
> list to investigate.
>
> > What are the other problems this poses, because in other areas this
> > ability to subdivide a device's functionality into sub-drivers is a
> > useful organization principle?
>
> Well, I'm thinking about things like enumeration, hotplug, reset,
> resource management (BARs, bridge windows, etc), interrupts, power
> management (suspend, resume, etc), and error reporting.  These are all
> things that PCIe defines on a per-Function basis and seem kind of hard
> to cleanly subdivide.

Right, I'm hoping like FLR there is little need to coordinate PCI /
CXL.io operations with CXL.mem operations, or that once a PCI driver
registers some CXL capabilities it never needs to look back. The only
hook that violates this so far is NAKing device removal when CXL.mem
for that device is busy.

> > So much so that several device writer teams came together to create
> > the auxiliary-bus for the purpose of allowing sub-drivers to be
> > carved off for independent functionality similar to the portdrv
> > organization.
>
> Is "auxiliary-bus" a specific thing?  I'm not familiar with it but
> again I'd like to read up on it in case it has ideas we could
> leverage.

auxiliary-bus is not a specific thing, it's a generic way for any
driver to register a custom device for a sub-driver to drive. One of
the primary examples are PCI Ethernet drivers exporting RDMA device
interfaces for common RDMA functionality. So you could have multiple
generations of Ethernet devices all producing a common RDMA interface
and rather than have an equivalent RDMA driver per generation just
create a shared common one that attaches to all the different baseline
Ethernet implementations.

See:

Documentation/driver-api/auxiliary_bus.rst

That document is still a bit too generic, and I have an item on my
backlog to flesh it out with more practical guidelines.

> Sub-drivers *is* an issue for PCI in general, although mostly I think
> it tends to be historical devices where people made the design mistake
> of putting several unrelated pieces of functionality in the same PCI
> function, so I don't think PCI has good infrastructure for doing that.

Auxiliary-bus might help especially if those unrelated pieces have
been duplicated across multiple different device implementations.
Aux-bus might clean up the driver model for those pieces.
