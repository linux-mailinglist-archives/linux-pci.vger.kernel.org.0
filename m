Return-Path: <linux-pci+bounces-12387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D989633A3
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 23:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8749A1C23F1B
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 21:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20CA1AC8A9;
	Wed, 28 Aug 2024 21:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="testeW97";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q7GXyTts"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A861ABED5;
	Wed, 28 Aug 2024 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879516; cv=none; b=T+BSi9NAfyRjrTIcfi/F7Fs5PdEtEg5dniiboTOvhfDY1pW8rBxZWhJluiA0r7VC7Bf+ZJONa7YfeE4sqJ/jpvEcM23yj8Ihlf4UccNfB1UkhiNDXpV6zEQqDNDQT8EneoIDLPFb0XITctrL8klMPm/ymrF8m5WrvxwhTANag5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879516; c=relaxed/simple;
	bh=/Ps7/eGxQldl91CBy36YhIiYyuvPwv6AobwEG8m44OA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rb4EoCeA1StnUw04wmv5y06KxnL8QQS3SEzI+Qri/kWxiQcbaY483fjg6XrXfohT8gG/2jiZI62uH7e9k8bYzKSO4aMnVmNFFzL2tIe7PmzCGUIOFb/q8Vx9aMj3XU8ceWo1/4piq0jtUFcMeOI7ZpkigenMqGuK6WXZh/kmMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=testeW97; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q7GXyTts; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724879507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WNFOyNCt6wcdA2prJP3abR4fOjwg9PndIMrgckIdWFk=;
	b=testeW97CeCYgFwn5VRnbc/ueSlh+H8c91sRFGoIU8MdYyIKRZSEXo1B+jJC/fanY7Q2Gc
	pAQfbL07DzGPNeMwc7dLACKuj4d9eUFyMwjNvzSongsJIQlglVnT8zxSXPLuh8yYyavGh6
	PRIMOqR4USTalgm9DnsIVAgE+PgQvbkuc40RjLoGyoEy+I6YPbq/W8ZWYaDCHNNotkzpTX
	diwTTlmRlQ6N2zPzWTXYa9JWK5wUv5Lv81S8tTgrkjF8taoIqyhwdb0AkC7RPEXMHlsyWd
	fGm2/CUgyGYGJpuUqgAYzceXuVxKtZg/2nI/WVSBNjW9FwhEnF3IMSyBCfPG1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724879507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WNFOyNCt6wcdA2prJP3abR4fOjwg9PndIMrgckIdWFk=;
	b=Q7GXyTts76R5pCNANZOXeOXPY9DaGAmynJdErfyx+fotzbGK5IRl0aBEFYVh9m6O9WZI3+
	P9a5AW5AFLTpLWBQ==
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Lukas Wunner
 <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linuxarm@huawei.com, Mahesh J
 Salgaonkar <mahesh@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, Davidlohr Bueso
 <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
 <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Will
 Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, terry.bowman@amd.com, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [RFC PATCH 0/9] pci: portdrv: Add auxiliary bus and register
 CXL PMUs (and aer)
In-Reply-To: <20240823120501.00004151@Huawei.com>
References: <20240529164103.31671-1-Jonathan.Cameron@huawei.com>
 <20240605180409.GA520888@bhelgaas> <20240605204428.00001cb2@Huawei.com>
 <20240605213910.00003034@huawei.com> <ZmG3vjD2sbCOPrM0@wunner.de>
 <20240823120501.00004151@Huawei.com>
Date: Wed, 28 Aug 2024 23:11:46 +0200
Message-ID: <87plpsbbe5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan!

On Fri, Aug 23 2024 at 12:05, Jonathan Cameron wrote:
> On Thu, 6 Jun 2024 15:21:02 +0200 Lukas Wunner <lukas@wunner.de> wrote:
>> On Thu, Jun 06, 2024 at 01:57:56PM +0100, Jonathan Cameron wrote:
>> > Or are you thinking we can make something like the following work
>> > (even when we can't do dynamic msix)?
>> > 
>> > Core bring up facilities and interrupt etc.  That includes bus master
>> > so msi/msix can be issued (which makes me nervous - putting aside other
>> > concerns as IIRC there are drivers where you have to be careful to
>> > tweak registers to ensure you don't get a storm of traffic when you
>> > hit bus master enable.

Correct. You have to be really careful about this.

>> > Specific driver may bind later - everything keeps running until 
>> > the specific driver calls pci_alloc_irq_vectors(), then we have to disable all
>> > interrupts for core managed services, change the number of vectors and
>> > then move them to wherever they end up before starting them again.
>> > We have to do the similar in the unwind path.  
>> 
>> My recollection is that Thomas Gleixner has brought up dynamic MSI-X
>> allocation.  So if both the PCI core services as well as the driver
>> use MSI-X, there's no problem.

Correct. If the core sets up N interrupts for core usage, then devices
can later on allocate MSI-X vectors on top if the underlying interrupt
domain hierarchy supports it. But see below.

>> For MSI, one approach might be to reserve a certain number of vectors
>> in the core for later use by the driver.

MSI is a problem in several aspects.

  1) You really have to know how many vectors you need at the end as you
     need to disable MSI in order to change the number of vectors in the
     config space. So if you do that after interrupts are already in use
     this can cause lost interrupts and stale devices. When MSI is
     disabled the interrupt might be routed to the legacy intX and aside
     of an eventual spurious interrupt message there is no trace of it.

  2) Allocating N vectors upfront and only using a small portion for the
     core and have the rest handy for drivers is problematic when the
     MSI implementation does not provide masking of the individual MSI
     interrupts. The driver probing might result in an interrupt
     storm for obvious reasons.

Aside of that if the core allocates N interrupts then all the resources
required (interrupt descriptors....CPU vectors) are allocated right
away. There is no reasonable way to do that post factum like we can do
with MSI-X. Any attempt to hack that into submission is futile and I
have zero interrest to even look at it.

The shortcomings of MSI are known for two decades and it's sufficiently
documented that it's a horrorshow for software to deal with it. Though
the 'save 5 gates and deal with it in software' camp still has not got
the memo. TBH, I don't care at all.

We can talk about MSI-X, but MSI is not going to gain support for any of
this. That's the only leverage we have to educate people who refuse to
accept reality.

> So, my first attempt at doing things in the core ran into what I think
> is probably a blocker. It's not entirely technical...
>
> +CC Thomas who can probably very quickly confirm if my reasoning is
> correct.
>
> If we move these services into the PCI core itself (as opposed keeping
> a PCI portdrv layer), then we need to bring up MSI for a device before
> we bind a driver to that struct pci_dev / struct device.
>
> If we follow through
> pci_alloc_irq_vectors_affinity()
> -> __pci_enable_msix_range() / __pci_enable_msi_range()
> -> pci_setup_msi_context()
> -> msi_setup_device_data()
> -> devres_add()
> //there is actually devres usage before this in msi_sysfs_create_group()
>   but this is a shorter path to illustrate the point.
>
> We will have registered a dev_res callback on the struct pci_dev
> that we later want to be able to bind a driver to.  That driver
> won't bind - because lifetimes of devres will be garbage
> (see really_probe() for the specific check and resulting
> "Resources present before probing")

That's because you are violating all layering rules. See below.

> So we in theory 'could' provide a non devres path through
> the MSI code, but I'm going to guess that Thomas will not
> be particularly keen on that to support this single use case.

Correct.

> Thomas, can you confirm if this is something you'd consider
> or outright reject? Or is there an existing route to have 
> MSI/X working pre driver bind and still be able to bind
> the driver later.

The initial enable has to set up at least one vector. That vector does
not have to be requested by anything, but that's it. After that you can
allocate with pci_msix_alloc_irq_at().

So looking at the ASCII art of the cover letter:

 _____________ __            ________ __________
|  Port       |  | creates  |        |          |
|  PCI Dev    |  |--------->| CPMU A |          |
|_____________|  |          |________|          |
|portdrv binds   |          | perf/cxlpmu binds |
|________________|          |___________________|
                 \         
                  \
                   \         ________ __________
                    \       |        |          |
                     ------>| CPMU B |          |    
                            |________|          |
                            | perf/cxlpmu binds |
                            |___________________|

AND

 _____________ __ 
|  Type 3     |  | creates                                 ________ _________
|  PCI Dev    |  |--------------------------------------->|        |         |
|_____________|  |                                        | CPMU C |         |
| cxl_pci binds  |                                        |________|         |
|________________|                                        | perf/cxpmu binds |
                                                          |__________________|

If I understand it correctly then both the portdrv and the cxl_pci
drivers create a "bus". The CPMU devices are attached to these buses.

So we are talking about distinctly different devices with the twist that
these devices somehow need to utilize the MSI/X (forget MSI) facility of
the device which creates the bus.

From the devres perspective we look at separate devices and that's what
the interrupt code expects too. This reminds me of the lengthy
discussion we had about IMS a couple of years ago.

  https://lore.kernel.org/all/87bljg7u4f.fsf@nanos.tec.linutronix.de/

My view on that issue was wrong because the Intel people described the
problem wrong. But the above pretty much begs for a proper separation
and hierarchical design because you provide an actual bus and distinct
devices. Reusing the ASCII art from that old thread for the second case,
but it's probably the same for the first one:

           ]-------------------------------------------|
           | PCI device                                |
           ]-------------------|                       |
           | Physical function |                       |
           ]-------------------|                       |
           ]-------------------|----------|            |
           | Control block for subdevices |            |
           ]------------------------------|            |
           |            | <- "Subdevice BUS"           |
           |            |                              |
           |            |-- Subddevice 0               | 
           |            |-- Subddevice 1               | 
           |            |-- ...                        | 
           |            |-- Subddevice N               | 
           ]-------------------------------------------|

1) cxl_pci driver binds to the PCI device.

2) cxl_pci driver creates AUXbus

3) Bus enumerates devices on AUXbus

4) Drivers bind to the AUXbus devices

So you have a clear provider consumer relationship. Whether the
subdevice utilizes resources of the PCI device or not is a hardware
implementation detail.

The important aspect is that you want to associate the subdevice
resources to the subdevice instances and not to the PCI device which
provides them.

Let me focus on interrupts, but it's probably the same for everything
else which is shared.

Look at how the PCI device manages interrupts with the per device MSI
mechanism. Forget doing this with either one of the legacy mechanisms.

  1) It creates a hierarchical interrupt domain and gets the required
     resources from the provided parent domain. The PCI side does not
     care whether this is x86 or arm64 and it neither cares whether the
     parent domain does remapping or not. The only way it cares is about
     the features supported by the different parent domains (think
     multi-MSI).
     
  2) Driver side allocations go through the per device domain

That AUXbus is not any different. When the CPMU driver binds it wants to
allocate interrupts. So instead of having a convoluted construct
reaching into the parent PCI device, you simply can do:

  1) Let the cxl_pci driver create a MSI parent domain and set that in
     the subdevice::msi::irqdomain pointer.

  2) Provide cxl_aux_bus_create_irqdomain() which allows the CPMU device
     driver to create a per device interrupt domain.

  3) Let the CPMU driver create its per device interrupt domain with
     the provided parent domain

  4) Let the CPMU driver allocate its MSI-X interrupts through the per
     device domain

Now on the cxl_pci side the AUXbus parent interrupt domain allocation
function does:

    if (!pci_msix_enabled(pdev))
    	return pci_msix_enable_and_alloc_irq_at(pdev, ....);
    else
        return pci_msix_alloc_irq_at(pdev, ....);

The condition can be avoided if the clx_pci driver enables MSI-X anyway
for it's own purposes. Obviously you need the corresponding counterpart
for free(), but that's left as an exercise for the reader.

That still associates the subdevice specific MSI-X interrups to the
underlying PCI device, but then you need to look at teardown. The
cxl_pci driver cannot go away before the CPMU drivers are shutdown.

The CPMU driver shutdown releases the interrupts through the interrupt
domain hierarchy, which removes them from the parent PCI device. Once
all CPMU drivers are gone, the shutdown of the cxl_pci driver gets rid
of the cxl_pci driver specific interrupts and everything is cleaned up.

This works out of the box on x86. The rest needs to gain support for
MSI_FLAG_PCI_MSIX_ALLOC_DYN. ARM64 and parts of ARM32 are already
converted over to the MSI parent domain concept, they just lack support
for dynamic allocation. The rest of the arch/ world needs some more
work. That's the problem of the architecture folks and that CXL auxbus
thing can simply tell them

      if (!pci_msix_can_alloc_dyn(pdev))
      		return -E_MAKE_YOUR_HOME_WORK;

and be done with it. Proliferating support for "two" legacy PCI/MSI
mechanisms by violating layering is not going to happen.

Neither I'm interrested to have creative workarounds for MSI as they are
going to create more problems than they solve, unless you come up with a
clean, simple and maintainable solution which works under all
circumstances. I'm not holding my breath...

I might not have all the crucial information as it happened in the
previous IMS discussion, but looking at your ASCII art makes me halfways
confident that I'm on the right track.

Thanks,

        tglx

