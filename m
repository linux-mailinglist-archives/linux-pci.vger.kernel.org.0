Return-Path: <linux-pci+bounces-8865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDFC90A663
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 09:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CD81F23F5A
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 07:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF2718F2E4;
	Mon, 17 Jun 2024 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kCMAnsko"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87B318F2DC;
	Mon, 17 Jun 2024 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607813; cv=none; b=gnGwzJkMxtEnI8y4o6P0BKobf97FnaQEbwqwecSGg3vhX93x/vqfMWDQtRfORKJUStk+0VCx5Ti8pKPx8XxJF1rQkokg5A2kw6aLmF36S7ljWz4CADG6OD3u3491H4IhCqaz0O1sZVyom4sqS/SveVVedu/NhlJS2t3P+d2YUvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607813; c=relaxed/simple;
	bh=QYz9yWQJa1DCtpUvl8YdCNZEaqQD8OrQPjvvlnmkLr8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jy0weANpImmxKG7pIaIpmH7iQRLtb3l4RGW/kVis5EB7DWkoJf1+orrhAvzBW+kqXwU94J0o+VkVBaNgMyfJh0dMrpVfVZqvHnczBgOkLAAXcs0n0L1yzqE3zJIkd4HF07MlyHZVascmaGidqmQ5uN3lh7LHm0BvJbDMB53K1Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kCMAnsko; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718607812; x=1750143812;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QYz9yWQJa1DCtpUvl8YdCNZEaqQD8OrQPjvvlnmkLr8=;
  b=kCMAnsko/KLh1S5T653nbfFJphmW+2nMq+FfdO14ompa3CJwtizsJYRY
   XWzc57NsMdikRMjEgKb5j5XRDZkJT/ROvpT72pBxZs1yJOD3SSoz6OaWZ
   rYH/WrZUVNAGf5er7evCJRDIbWovwMbXjmWzQ1Vn997N3BAV1f7dEpdaK
   Fw9bawoC5xmtNj3pXM6PIoiT70m1pOM2WrgR95ZKffAdaxra4WlVDQZZr
   75Kb8ixDaP2aMWbdUYfjqeY1gyjvzcPUzK/+RqI1oRgnidM8ILC/J2zV0
   HVLvjUBATC/gmPmaEHs9s1UyCqqiWcRXskv3TAzS0Xx714TMeHrryYcRi
   g==;
X-CSE-ConnectionGUID: SArWUtvkSUuMP1cICDjfwg==
X-CSE-MsgGUID: aPh2gOO6S3aMnb6dR1YExA==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="32963349"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="32963349"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 00:03:29 -0700
X-CSE-ConnectionGUID: D7X8ChCoSm6e+HzKFmWelg==
X-CSE-MsgGUID: LPkf39AVTwus5ME0Xpf17w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="72311292"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.247])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 00:03:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 17 Jun 2024 10:03:21 +0300 (EEST)
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, linuxarm@huawei.com, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-cxl@vger.kernel.org, 
    linux-pci@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, 
    Dave Jiang <dave.jiang@intel.com>, 
    Alison Schofield <alison.schofield@intel.com>, 
    Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
    Dan Williams <dan.j.williams@intel.com>, Will Deacon <will@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, terry.bowman@amd.com, 
    Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [RFC PATCH 0/9] pci: portdrv: Add auxiliary bus and register
 CXL PMUs (and aer)
In-Reply-To: <20240605213910.00003034@huawei.com>
Message-ID: <f4b23710-059a-51b7-9d27-b62e8b358b54@linux.intel.com>
References: <20240529164103.31671-1-Jonathan.Cameron@huawei.com> <20240605180409.GA520888@bhelgaas> <20240605204428.00001cb2@Huawei.com> <20240605213910.00003034@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 6 Jun 2024, Jonathan Cameron wrote:

> On Wed, 5 Jun 2024 20:44:28 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Wed, 5 Jun 2024 13:04:09 -0500
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > > On Wed, May 29, 2024 at 05:40:54PM +0100, Jonathan Cameron wrote:  
> > > > Focus of this RFC is CXL Performance Monitoring Units in CXL Root Ports +
> > > > Switch USP and DSPs.
> > > > 
> > > > The final patch moving AER to the aux bus is in the category of 'why
> > > > not try this' rather than something I feel is a particularly good idea.
> > > > I would like to get opinions on the various ways to avoid the double bus
> > > > situation introduced here. Some comments on other options for those existing
> > > > 'pci_express' bus devices at the end of this cover letter.
> > > > 
> > > > The primary problem this RFC tries to solve is providing a means to
> > > > register the CXL PMUs found in devices which will be bound to the
> > > > PCIe portdrv. The proposed solution is to avoid the limitations of
> > > > the existing pcie service driver approach by bolting on support
> > > > for devices registered on the auxiliary_bus.
> > > > 
> > > > Background
> > > > ==========
> > > > 
> > > > When the CXL PMU driver was added, only the instances found in CXL type 3
> > > > memory devices (end points) were supported. These PMUs also occur in CXL
> > > > root ports, and CXL switch upstream and downstream ports.  Adding
> > > > support for these was deliberately left for future work because theses
> > > > ports are all bound to the pcie portdrv via the appropriate PCI class
> > > > code.  Whilst some CXL support of functionality on RP and Switch Ports
> > > > is handled by the CXL port driver, that is not bound to the PCIe device,
> > > > is only instantiated as part of enumerating endpoints, and cannot use
> > > > interrupts because those are in control of the PCIe portdrv. A PMU with
> > > > out interrupts would be unfortunate so a different solution is needed.
> > > > 
> > > > Requirements
> > > > ============
> > > > 
> > > > - Register multiple CXL PMUs (CPMUs) per portdrv instance.    
> > > 
> > > What resources do CPMUs use?  BARs?  Config space registers in PCI
> > > Capabilities?  Interrupts?  Are any of these resources
> > > device-specific, or are they all defined by the CXL specs?  
> > 
> > Uses the whole lot (there isn't a toy out there that the CXL
> > spec doesn't like to play with :). Discoverable via a CXL defined DVSEC
> > in config space. Registers are in a BAR (discovered from the DVSEC).
> > MSI/MSIX, number in a register in the BAR.
> > 
> > All the basic infrastructure and some performance event definitions
> > are in the CXL spec.  It's all discoverable. 
> > 
> > The events are even tagged with VID so a vendor can implement
> > someone else's definitions or those coming from another specification.
> > A bunch of CXL VID tagged ones exist for protocol events etc.
> > 
> > It's a really nice general spec.  If I were more of a dreamer and had
> > the time I'd try to get PCI-SIG to adopt it and we'd finally have
> > something generic for PCI performance counting.
> > 
> > > 
> > > The "device" is a nice way to package those up and manage ownership
> > > since there are often interdependencies.
> > > 
> > > I wish portdrv was directly implemented as part of the PCI core,
> > > without binding to the device as a "driver".  We handle some other
> > > pieces of functionality that way, e.g., the PCIe Capability itself,
> > > PM, VPD, MSI/MSI-X,   
> > 
> > Understood, though I would guess that even then there needs to
> > be a pci_driver binding to the class code to actually query all those
> > facilities and get interrupts registered etc.
> 
> Or are you thinking we can make something like the following work
> (even when we can't do dynamic msix)?
> 
> Core bring up facilities and interrupt etc.  That includes bus master
> so msi/msix can be issued (which makes me nervous - putting aside other
> concerns as IIRC there are drivers where you have to be careful to
> tweak registers to ensure you don't get a storm of traffic when you
> hit bus master enable.
> 
> Specific driver may bind later - everything keeps running until 
> the specific driver calls pci_alloc_irq_vectors(), then we have to disable all
> interrupts for core managed services, change the number of vectors and
> then move them to wherever they end up before starting them again.
> We have to do the similar in the unwind path.
> 
> I can see we might make something like that work, but I'd be very worried
> we'd hit devices that didn't behave correctly under this flow even if
> there aren't any specification caused problems.
> 
> Even if this is a possible long term plan, maybe we don't want to try and
> get there in one hop?

I've just a small bit of detail to add here (but I'm far from expert when 
it comes to the driver model, rpm, etc. areas so please keep that in mind
if something I say doesn't make sense).

One problematic thing with current portdrv model and interrupts is that
portdrv resumes too late from hotplug's point of view.

When resuming, the PCI core tries to ensure downstream port's bus and 
devices there are in usable state by waiting for the devices before 
portdrv is resumed. For hotplug case, this is problematic because if 
devices were unplugged during suspend or are unplugged during that wait, 
hotplug cannot notice the unplug before the wait times out because hotplug 
is not yet resumed.

-- 
 i.


> 
> Jonathan
> 
> > 
> > >   
> > > > - portdrv binds to the PCIe class code for PCI_CLASS_BRIDGE_PCI_NORMAL which
> > > >   covers any PCI-Express port.
> > > > - PCI MSI / MSIX message based interrupts must be registered by one driver -
> > > >   in this case it's the portdrv.    
> > > 
> > > The fact that AER/DPC/hotplug/etc (the portdrv services) use MSI/MSI-X
> > > is a really annoying part of PCIe because bridges may have a BAR or
> > > two and are allowed to have device-specific endpoint-like behavior, so
> > > we may have to figure out how to share those interrupts between the
> > > PCIe-architected stuff and the device-specific stuff.  I guess that's
> > > messy no matter whether portdrv is its own separate driver or it's
> > > integrated into the core.  
> > 
> > Yes, the interrupt stuff is the tricky bit.  I think whatever happens
> > we end up with a pci device driver that binds to the class code.
> > Maybe we have a way to switch in alternative drivers if that turns
> > out to be necessary.
> > 
> > Trying to actually manage the interrupts in the core (without a driver binding)
> > is really tricky.  Maybe we'll get there one day, but I don't think
> > it is the first target.  We should however make sure not to do anything
> > that would make that harder such as adding ABI in the wrong places.
> > 
> > >   
> > > > Side question.  Does anyone care if /sys/bus/pci_express goes away?
> > > > - in theory it's ABI, but in practice it provides very little
> > > >   actual ABI.    
> > > 
> > > I would *love* to get rid of /sys/bus/pci_express, but I don't know
> > > what, if anything, would break if we removed it.  
> > 
> > Could try it and see who screams ;) or fake it via symlinks or similar
> > (under a suitable 'legacy' config variable that is on by default.)
> > 
> > How about I try the following steps:
> > 0) An experiment to make sure I can fake /sys/bus/pci_express so it's
> >    at least hard to tell there aren't real 'devices' registered on that
> >    bus. Even if we decide not to do that long term, we need to know
> >    we can if a regressions report comes in.
> >    Worst comes to the worse we can register fake devices that fake
> >    drivers bind to that don't do anything beyond fill in sysfs.
> > 1) Replace the bus/pci_express with direct functional calls in
> >    portdrv.  
> >    I'm thinking we have a few calls for each:
> >     bool aer_present(struct pci_dev *pci);
> >     aer_query_max_message_num() etc - used so we can do the msi/msix bit.
> >     aer_initialize()
> >     aer_finalize()
> >     aer_runtime_suspend() (where relevant for particular services)
> > 
> >    at the cost of a few less loops and a few more explicit calls
> >    that should simplify how things fit together.
> > 
> > 2) Fix up anything in all that functionality that really cares
> >    that they are part of portdrv.  Not sure yet, but we may need
> >    a few additional things in struct pci_dev, or a to pass in some
> >    state storage in the ae_initialize() call or similar.
> > 3) Consider moving that functionality to a more appropriate place.
> >    At this point we'll have services that can be used by other
> >    drivers - though I'm not yet sure how useful that will be.
> > 4) End up with a small pci_driver that binds to pci devices with
> >    the appropriate class code. Should even be able to make it
> >    a module.
> > 5) (maybe do this first) carry my auxiliary_bus + cpmu stuff
> >    and allow adopting other similar cases alongside the other
> >    parts.
> > 
> > Of course, no statements on 'when' I'll make progress if this seems
> > like a step forwards, but probably sometime this summer. Maybe sooner.
> > 
> > Jonathan
> > 
> > > 
> > > Bjorn  
> > 
> > 
> 

