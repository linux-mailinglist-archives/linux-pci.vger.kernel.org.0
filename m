Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527FC45B085
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 00:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240313AbhKWX7J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 18:59:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230491AbhKWX7J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Nov 2021 18:59:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 701216101A;
        Tue, 23 Nov 2021 23:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637711760;
        bh=YyJ+FtaJPzSG06lGEJ1w4cla4LkypsPyiglLR3HZK7w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QAJ8wZ93fGahAYpmu3wVxn3b27G6FPia8PZEoLeBilTQAq5SECxLT62Kulx2Qam3w
         LSuHF8ENPXFPSjDFGybOZgvIZ21qs9aF43GqLKfEZ+6qBstWIXbHzuDipUGqxCc/Ep
         Yw+G9K9Z7H1aIMMnshmx2ZVdRAT/2PanDYPTw4MUI6MwjUZlzKvC1gfM/+073mLAXC
         EFAEtdN+MooUbq9Q5ETGIWzQ9i5SOtz9Vetzksm8eVdhJZTm/681etXM6rkGjt0Pfx
         4u0SLM2X2aGE7PKBr/peSDnTLZ7JO7bg0xx2jrguBeiTcdoBUDnQ85vVkhNYP21tUk
         bHRpM9NKmicjg==
Date:   Tue, 23 Nov 2021 17:55:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 20/23] cxl/port: Introduce a port driver
Message-ID: <20211123235557.GA2247853@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h7h3oJTEorMhL6MMD5FYbSxaWs6tb3-w=JWxhR=j77+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Christoph, since he has opinions about portdrv;
Greg, Rafael, since they have good opinions about sysfs structure]

On Tue, Nov 23, 2021 at 02:36:32PM -0800, Dan Williams wrote:
> On Tue, Nov 23, 2021 at 2:03 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> [..]
> > > I hope this driver is not modeled on the PCI portdrv.  IMO, that
> > > was a design error, and the "port service drivers" (PME,
> > > hotplug, AER, etc) should be directly integrated into the PCI
> > > core instead of pretending to be independent drivers.
> >
> > I'd like to understand a bit about why you think it was a design
> > error. The port driver is intended to be a port services driver,
> > however I see the services provided as quite different than the
> > ones you mention. The primary service cxl_port will provide from
> > here on out is the ability to manage HDM decoder resources for a
> > port. Other independent drivers that want to use HDM decoder
> > resources would rely on the port driver for this.
> >
> > It could be in CXL core just the same, but I don't see too much of
> > a benefit since the code would be almost identical. One nice
> > aspect of having the port driver outside of CXL core is it would
> > allow CXL devices which do not need port services (type-1 and
> > probably type-2) to not need to load the port driver. We do not
> > have examples of such devices today but there's good evidence they
> > are being built. Whether or not they will even want CXL core is
> > another topic up for debate however.
> >
> > I admit Dan and I did discuss putting this in either its own port
> > driver, or within core as a port driver. My inclination is, less
> > is more in CXL core; but perhaps you will be able to change my
> > mind.
> 
> No, I don't think Bjorn is talking about whether the driver is
> integrated into cxl_core.ko vs its own cxl_port.ko. IIUC this goes
> back to the original contention about have /sys/bus/cxl at all:
> 
> https://lore.kernel.org/r/CAPcyv4iu8D-hJoujLXw8a4myS7trOE1FcUhESLB_imGMECVfrg@mail.gmail.com

That question was about whether we want the same physical device to be
represented both in the /sys/bus/pci hierarchy and the /sys/bus/cxl
hierarchy.  That still seems a little weird to me, but I don't know
enough about the CXL constraints to really object to it.

My question here is more about whether you're going to use something
like the pcie_port_service_register() model for supporting multiple
drivers attached to the same physical device.

The PCIe portdrv creates a /sys/bus/pci_express hierarchy parallel to
the /sys/bus/pci hierarchy.  The pci_express hierarchy has a "device"
for every service (hotplug, AER, DPC, PME, etc) (see
pcie_device_init()).  This device creation is quite complicated and
depends on whether the Port advertises a Capability, whether the
platform has granted control to the OS, whether support is compiled
in, etc.

I think that was a mistake because these hotplug, AER, DPC, PME
"devices" are not independent things.  They are optional features that
can be added to a variety of devices, and those devices might have
their own drivers.  For example, we want to write drivers for
vendor-specific functionality like PMUs in switches, but we can't do
that cleanly because portdrv claims them.

The portdrv features are fully specified by the PCIe spec, so nothing
is vendor-specific.  They share interrupts.  They share power state.
They cannot be reset independently.  They are not addressable entities
in the usual bus/device/function model.  They can't be removed or
added like the underlying device can.  I wasn't there when they were
designed, but from reading the spec, it seems like they were designed
as optional features of a device, not as separate devices themselves.

> Unlike pcieportdrv where the functionality is bounded to a single
> device instance with relatively simpler hierarchical coordination of
> the memory space and services. CXL interleaving is both a foreign
> concept to the PCIE core and an awkward fit for the pci_bus_type
> device model. CXL uses the cxl_bus_type and bus drivers to
> coordinate CXL operations that have cross PCI device implications.
> 
> Outside of that I think the auxiliary device driver model, of which
> the PCIE portdrv model is an open-coded form, is a useful construct
> for separation of concerns. That said, I do want to hear more about
> what trouble it has caused though to make sure that CXL does not
> trip over the same issues longer term.

Bjorn
