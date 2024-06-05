Return-Path: <linux-pci+bounces-8365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF27D8FD6B2
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 21:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559CA1F27883
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 19:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272E01527BA;
	Wed,  5 Jun 2024 19:44:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9658261FC0;
	Wed,  5 Jun 2024 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717616679; cv=none; b=JMPeAur6DjDajAUFk1SdlKypYPBwUWAe3CUgGrn+yb14yKKlFYfJOTO6RZI48K+9652Rn4c7GyQcro83hKuv7gy0oNlLcecrMbMhw9rBK23tuNp8oydVYdfftVQru5EoGJXCMte4m4mGFE7Z6viaADS3Au7z5rvfdAWIjz1iKNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717616679; c=relaxed/simple;
	bh=jerAg1qLkqtoBSg9ZXFcWDMNxuuiwy1hgIupCHOT3fo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pdjmdLmzFsyprVwuLN0ckcPRfRp/r48ZWRGq+hA6teJGiQScLqmBZ3uaKWRWAdv6m1cqvkQHCNmD/6QyGUeu49jpdglfqov3dEbYeWZPc6FhkZaapQrPPh95tYa9nkrxkpNM4l7eCCrhUm7ECwQKOkPvGfms28lYAy7/SBiVoyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vvd8s0vyqz6JBWH;
	Thu,  6 Jun 2024 03:40:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 53A651400D9;
	Thu,  6 Jun 2024 03:44:32 +0800 (CST)
Received: from localhost (10.126.172.226) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Jun
 2024 20:44:31 +0100
Date: Wed, 5 Jun 2024 20:44:28 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, Will Deacon <will@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	<linuxarm@huawei.com>, <terry.bowman@amd.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [RFC PATCH 0/9] pci: portdrv: Add auxiliary bus and register
 CXL PMUs (and aer)
Message-ID: <20240605204428.00001cb2@Huawei.com>
In-Reply-To: <20240605180409.GA520888@bhelgaas>
References: <20240529164103.31671-1-Jonathan.Cameron@huawei.com>
	<20240605180409.GA520888@bhelgaas>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 5 Jun 2024 13:04:09 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, May 29, 2024 at 05:40:54PM +0100, Jonathan Cameron wrote:
> > Focus of this RFC is CXL Performance Monitoring Units in CXL Root Ports +
> > Switch USP and DSPs.
> > 
> > The final patch moving AER to the aux bus is in the category of 'why
> > not try this' rather than something I feel is a particularly good idea.
> > I would like to get opinions on the various ways to avoid the double bus
> > situation introduced here. Some comments on other options for those existing
> > 'pci_express' bus devices at the end of this cover letter.
> > 
> > The primary problem this RFC tries to solve is providing a means to
> > register the CXL PMUs found in devices which will be bound to the
> > PCIe portdrv. The proposed solution is to avoid the limitations of
> > the existing pcie service driver approach by bolting on support
> > for devices registered on the auxiliary_bus.
> > 
> > Background
> > ==========
> > 
> > When the CXL PMU driver was added, only the instances found in CXL type 3
> > memory devices (end points) were supported. These PMUs also occur in CXL
> > root ports, and CXL switch upstream and downstream ports.  Adding
> > support for these was deliberately left for future work because theses
> > ports are all bound to the pcie portdrv via the appropriate PCI class
> > code.  Whilst some CXL support of functionality on RP and Switch Ports
> > is handled by the CXL port driver, that is not bound to the PCIe device,
> > is only instantiated as part of enumerating endpoints, and cannot use
> > interrupts because those are in control of the PCIe portdrv. A PMU with
> > out interrupts would be unfortunate so a different solution is needed.
> > 
> > Requirements
> > ============
> > 
> > - Register multiple CXL PMUs (CPMUs) per portdrv instance.  
> 
> What resources do CPMUs use?  BARs?  Config space registers in PCI
> Capabilities?  Interrupts?  Are any of these resources
> device-specific, or are they all defined by the CXL specs?

Uses the whole lot (there isn't a toy out there that the CXL
spec doesn't like to play with :). Discoverable via a CXL defined DVSEC
in config space. Registers are in a BAR (discovered from the DVSEC).
MSI/MSIX, number in a register in the BAR.

All the basic infrastructure and some performance event definitions
are in the CXL spec.  It's all discoverable. 

The events are even tagged with VID so a vendor can implement
someone else's definitions or those coming from another specification.
A bunch of CXL VID tagged ones exist for protocol events etc.

It's a really nice general spec.  If I were more of a dreamer and had
the time I'd try to get PCI-SIG to adopt it and we'd finally have
something generic for PCI performance counting.

> 
> The "device" is a nice way to package those up and manage ownership
> since there are often interdependencies.
> 
> I wish portdrv was directly implemented as part of the PCI core,
> without binding to the device as a "driver".  We handle some other
> pieces of functionality that way, e.g., the PCIe Capability itself,
> PM, VPD, MSI/MSI-X, 

Understood, though I would guess that even then there needs to
be a pci_driver binding to the class code to actually query all those
facilities and get interrupts registered etc.

> 
> > - portdrv binds to the PCIe class code for PCI_CLASS_BRIDGE_PCI_NORMAL which
> >   covers any PCI-Express port.
> > - PCI MSI / MSIX message based interrupts must be registered by one driver -
> >   in this case it's the portdrv.  
> 
> The fact that AER/DPC/hotplug/etc (the portdrv services) use MSI/MSI-X
> is a really annoying part of PCIe because bridges may have a BAR or
> two and are allowed to have device-specific endpoint-like behavior, so
> we may have to figure out how to share those interrupts between the
> PCIe-architected stuff and the device-specific stuff.  I guess that's
> messy no matter whether portdrv is its own separate driver or it's
> integrated into the core.

Yes, the interrupt stuff is the tricky bit.  I think whatever happens
we end up with a pci device driver that binds to the class code.
Maybe we have a way to switch in alternative drivers if that turns
out to be necessary.

Trying to actually manage the interrupts in the core (without a driver binding)
is really tricky.  Maybe we'll get there one day, but I don't think
it is the first target.  We should however make sure not to do anything
that would make that harder such as adding ABI in the wrong places.

> 
> > Side question.  Does anyone care if /sys/bus/pci_express goes away?
> > - in theory it's ABI, but in practice it provides very little
> >   actual ABI.  
> 
> I would *love* to get rid of /sys/bus/pci_express, but I don't know
> what, if anything, would break if we removed it.

Could try it and see who screams ;) or fake it via symlinks or similar
(under a suitable 'legacy' config variable that is on by default.)

How about I try the following steps:
0) An experiment to make sure I can fake /sys/bus/pci_express so it's
   at least hard to tell there aren't real 'devices' registered on that
   bus. Even if we decide not to do that long term, we need to know
   we can if a regressions report comes in.
   Worst comes to the worse we can register fake devices that fake
   drivers bind to that don't do anything beyond fill in sysfs.
1) Replace the bus/pci_express with direct functional calls in
   portdrv.  
   I'm thinking we have a few calls for each:
    bool aer_present(struct pci_dev *pci);
    aer_query_max_message_num() etc - used so we can do the msi/msix bit.
    aer_initialize()
    aer_finalize()
    aer_runtime_suspend() (where relevant for particular services)

   at the cost of a few less loops and a few more explicit calls
   that should simplify how things fit together.

2) Fix up anything in all that functionality that really cares
   that they are part of portdrv.  Not sure yet, but we may need
   a few additional things in struct pci_dev, or a to pass in some
   state storage in the ae_initialize() call or similar.
3) Consider moving that functionality to a more appropriate place.
   At this point we'll have services that can be used by other
   drivers - though I'm not yet sure how useful that will be.
4) End up with a small pci_driver that binds to pci devices with
   the appropriate class code. Should even be able to make it
   a module.
5) (maybe do this first) carry my auxiliary_bus + cpmu stuff
   and allow adopting other similar cases alongside the other
   parts.

Of course, no statements on 'when' I'll make progress if this seems
like a step forwards, but probably sometime this summer. Maybe sooner.

Jonathan

> 
> Bjorn


