Return-Path: <linux-pci+bounces-12431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA37D964438
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 14:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C181F26005
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 12:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E561957F4;
	Thu, 29 Aug 2024 12:18:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005E7195FF0;
	Thu, 29 Aug 2024 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933880; cv=none; b=QIUofz5clk/UL4iMKlLnwa2bfH4UAdjP+3U67EUiH5xBBs1fuQrEouz5aFbajLPS9YvYYDfxYRbDk71ysoH5EpvtLJ/7a1XfZhmK0m/0X+fb2fEEn5evv496jw+QWoyD5dOWeskbLIsVUawWagXOaW8buoAOJAyGpifxJbCG1AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933880; c=relaxed/simple;
	bh=rQzBdfFFPPGfRO9Vlb9VncNv+90udFIi6TXohzBAOfg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrDPGj+u/Xv11RiulWS22Skogrc123doWflHx0wgZCbYqgS62zWrE90Eo1V8IXxarloN+iFl3jr+bmaJ+DDsWlqMkDPdNAW/54rfwBLR2DMFzy5t/T7j3xZugu20U/1iMhTA9wXirnUidBPTXurl8NS26enX4AgBsu6O6FbDmqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WvgFL6fFNz6J7X5;
	Thu, 29 Aug 2024 20:14:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8980B140519;
	Thu, 29 Aug 2024 20:17:48 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 29 Aug
 2024 13:17:47 +0100
Date: Thu, 29 Aug 2024 13:17:46 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
	<linuxarm@huawei.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, Will Deacon <will@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	<terry.bowman@amd.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Ilpo =?ISO-8859-1?Q?J=E4rvi?=
 =?ISO-8859-1?Q?nen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [RFC PATCH 0/9] pci: portdrv: Add auxiliary bus and register
 CXL PMUs (and aer)
Message-ID: <20240829131746.00003743@Huawei.com>
In-Reply-To: <87plpsbbe5.ffs@tglx>
References: <20240529164103.31671-1-Jonathan.Cameron@huawei.com>
	<20240605180409.GA520888@bhelgaas>
	<20240605204428.00001cb2@Huawei.com>
	<20240605213910.00003034@huawei.com>
	<ZmG3vjD2sbCOPrM0@wunner.de>
	<20240823120501.00004151@Huawei.com>
	<87plpsbbe5.ffs@tglx>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 28 Aug 2024 23:11:46 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> Jonathan!

Hi Thomas,

Thanks for taking a look.  This has slightly suffered from being
a thread that diverged a long way from the original patch set.
So the question here wasn't really related to the cover letter :(
I think much of the discussion still applies however and some
of it answers questions I didn't even know I had.

Some new ascii art follows with the various options we are
considering (having ruled out the one this patch set covers).

The meat of the query was whether MSI or MSIX can be used prior
to binding a driver to struct device (pci_dev).  In theory
possible, but the infrastructure currently doesn't enable this.
The rest is details of the pain in actually using that if it
is possible.  You answered that I think so all good.

> 
> On Fri, Aug 23 2024 at 12:05, Jonathan Cameron wrote:
> > On Thu, 6 Jun 2024 15:21:02 +0200 Lukas Wunner <lukas@wunner.de> wrote:  
> >> On Thu, Jun 06, 2024 at 01:57:56PM +0100, Jonathan Cameron wrote:  
> >> > Or are you thinking we can make something like the following work
> >> > (even when we can't do dynamic msix)?
> >> > 
> >> > Core bring up facilities and interrupt etc.  That includes bus master
> >> > so msi/msix can be issued (which makes me nervous - putting aside other
> >> > concerns as IIRC there are drivers where you have to be careful to
> >> > tweak registers to ensure you don't get a storm of traffic when you
> >> > hit bus master enable.  
> 
> Correct. You have to be really careful about this.
> 
> >> > Specific driver may bind later - everything keeps running until 
> >> > the specific driver calls pci_alloc_irq_vectors(), then we have to disable all
> >> > interrupts for core managed services, change the number of vectors and
> >> > then move them to wherever they end up before starting them again.
> >> > We have to do the similar in the unwind path.    
> >> 
> >> My recollection is that Thomas Gleixner has brought up dynamic MSI-X
> >> allocation.  So if both the PCI core services as well as the driver
> >> use MSI-X, there's no problem.  
> 
> Correct. If the core sets up N interrupts for core usage, then devices
> can later on allocate MSI-X vectors on top if the underlying interrupt
> domain hierarchy supports it. But see below.
> 
> >> For MSI, one approach might be to reserve a certain number of vectors
> >> in the core for later use by the driver.  
> 
> MSI is a problem in several aspects.
> 
>   1) You really have to know how many vectors you need at the end as you
>      need to disable MSI in order to change the number of vectors in the
>      config space. So if you do that after interrupts are already in use
>      this can cause lost interrupts and stale devices. When MSI is
>      disabled the interrupt might be routed to the legacy intX and aside
>      of an eventual spurious interrupt message there is no trace of it.

Ah. I'd not thought of the intX fallback. Ouch, so we'd definitely
need to do device side masking of all the sources before disabling MSI
and poll all the status registers to see if we missed anything.
That's not implausible to implement if fiddly.

> 
>   2) Allocating N vectors upfront and only using a small portion for the
>      core and have the rest handy for drivers is problematic when the
>      MSI implementation does not provide masking of the individual MSI
>      interrupts. The driver probing might result in an interrupt
>      storm for obvious reasons.

Ouch.  We 'should' be ok on that because the device should be well behaved
and as long as a given feature isn't enabled. If there are devices out
there that come up with an interrupt enabled by default (to which portdrv
attaches), then this problem would already have surfaced.
There might be some corners where a feature isn't enabled unless enough
vectors are requested but even those should have surfaced due to the
portdrv 'find what is used' dance where it first requests all the MSI
vectors, then checks what numbers are used (which aren't known until
MSI is enabled) and then releases all the vectors.

> 
> Aside of that if the core allocates N interrupts then all the resources
> required (interrupt descriptors....CPU vectors) are allocated right
> away. There is no reasonable way to do that post factum like we can do
> with MSI-X. Any attempt to hack that into submission is futile and I
> have zero interrest to even look at it.
> 
> The shortcomings of MSI are known for two decades and it's sufficiently
> documented that it's a horrorshow for software to deal with it. Though
> the 'save 5 gates and deal with it in software' camp still has not got
> the memo. TBH, I don't care at all.

Snag here is the aim is refactor a driver that has to handle ancient
implementation without breaking.  We can enable new shiny stuff for
MSI-X only but I don't want parallel infrastructure.

> 
> We can talk about MSI-X, but MSI is not going to gain support for any of
> this. That's the only leverage we have to educate people who refuse to
> accept reality.

Fully on board with the aim, but legacy is the pain point here.

> 
> > So, my first attempt at doing things in the core ran into what I think
> > is probably a blocker. It's not entirely technical...
> >
> > +CC Thomas who can probably very quickly confirm if my reasoning is
> > correct.
> >
> > If we move these services into the PCI core itself (as opposed keeping
> > a PCI portdrv layer), then we need to bring up MSI for a device before
> > we bind a driver to that struct pci_dev / struct device.
> >
> > If we follow through
> > pci_alloc_irq_vectors_affinity()  
> > -> __pci_enable_msix_range() / __pci_enable_msi_range()
> > -> pci_setup_msi_context()
> > -> msi_setup_device_data()
> > -> devres_add()  
> > //there is actually devres usage before this in msi_sysfs_create_group()
> >   but this is a shorter path to illustrate the point.
> >
> > We will have registered a dev_res callback on the struct pci_dev
> > that we later want to be able to bind a driver to.  That driver
> > won't bind - because lifetimes of devres will be garbage
> > (see really_probe() for the specific check and resulting
> > "Resources present before probing")  
> 
> That's because you are violating all layering rules. See below.

Agreed.  I never liked this approach. This was an exercise
in ruling it out.

> 
> > So we in theory 'could' provide a non devres path through
> > the MSI code, but I'm going to guess that Thomas will not
> > be particularly keen on that to support this single use case.  
> 
> Correct.

Excellent.  

> 
> > Thomas, can you confirm if this is something you'd consider
> > or outright reject? Or is there an existing route to have 
> > MSI/X working pre driver bind and still be able to bind
> > the driver later.  
> 
> The initial enable has to set up at least one vector. That vector does
> not have to be requested by anything, but that's it. After that you can
> allocate with pci_msix_alloc_irq_at().
> 
> So looking at the ASCII art of the cover letter:

This is focused on the CXL CPMU thing which is where the patch set
was focused, but not so much the discussion on 'fixing' portdrv.

> 
>  _____________ __            ________ __________
> |  Port       |  | creates  |        |          |
> |  PCI Dev    |  |--------->| CPMU A |          |
> |_____________|  |          |________|          |
> |portdrv binds   |          | perf/cxlpmu binds |
> |________________|          |___________________|
>                  \         
>                   \
>                    \         ________ __________
>                     \       |        |          |
>                      ------>| CPMU B |          |      
>                             |________|          |
>                             | perf/cxlpmu binds |
>                             |___________________|
> 
> AND
> 
>  _____________ __ 
> |  Type 3     |  | creates                                 ________ _________
> |  PCI Dev    |  |--------------------------------------->|        |         |
> |_____________|  |                                        | CPMU C |         |
> | cxl_pci binds  |                                        |________|         |
> |________________|                                        | perf/cxpmu binds |
>                                                           |__________________|
> 
> If I understand it correctly then both the portdrv and the cxl_pci
> drivers create a "bus". The CPMU devices are attached to these buses.
> 
> So we are talking about distinctly different devices with the twist that
> these devices somehow need to utilize the MSI/X (forget MSI) facility of
> the device which creates the bus.

yes.

> 
> From the devres perspective we look at separate devices and that's what
> the interrupt code expects too. This reminds me of the lengthy
> discussion we had about IMS a couple of years ago.
> 
>   https://lore.kernel.org/all/87bljg7u4f.fsf@nanos.tec.linutronix.de/
> 
> My view on that issue was wrong because the Intel people described the
> problem wrong. But the above pretty much begs for a proper separation
> and hierarchical design because you provide an actual bus and distinct
> devices. Reusing the ASCII art from that old thread for the second case,
> but it's probably the same for the first one:
> 
>            ]-------------------------------------------|
>            | PCI device                                |
>            ]-------------------|                       |
>            | Physical function |                       |
>            ]-------------------|                       |
>            ]-------------------|----------|            |
>            | Control block for subdevices |            |
>            ]------------------------------|            |
>            |            | <- "Subdevice BUS"           |
>            |            |                              |
>            |            |-- Subddevice 0               | 
>            |            |-- Subddevice 1               | 
>            |            |-- ...                        | 
>            |            |-- Subddevice N               | 
>            ]-------------------------------------------|
> 
> 1) cxl_pci driver binds to the PCI device.
> 
> 2) cxl_pci driver creates AUXbus

It's using a different CXL specific bus, but I the
discussion still holds and it's very auxbus like.

> 
> 3) Bus enumerates devices on AUXbus
> 
> 4) Drivers bind to the AUXbus devices
> 
> So you have a clear provider consumer relationship. Whether the
> subdevice utilizes resources of the PCI device or not is a hardware
> implementation detail.
> 
> The important aspect is that you want to associate the subdevice
> resources to the subdevice instances and not to the PCI device which
> provides them.
> 
> Let me focus on interrupts, but it's probably the same for everything
> else which is shared.
> 
> Look at how the PCI device manages interrupts with the per device MSI
> mechanism. Forget doing this with either one of the legacy mechanisms.

Unfortunately legacy is a problem because the support for MSI is
already upstream.  So anything we do to cxl_pci and children
is an optimization only.

This is probably doable for the portdrv refactoring of extensions + hanging
the CXL PMU off that though as we don't currently have upstream support
for that combination (so no chance of regressions)

Anyway I'll read this as talking about portdrv.c and the CPMU driver
binding to an auxbus device rather than cxl_pci.

> 
>   1) It creates a hierarchical interrupt domain and gets the required
>      resources from the provided parent domain. The PCI side does not
>      care whether this is x86 or arm64 and it neither cares whether the
>      parent domain does remapping or not. The only way it cares is about
>      the features supported by the different parent domains (think
>      multi-MSI).
>      
>   2) Driver side allocations go through the per device domain
> 
> That AUXbus is not any different. When the CPMU driver binds it wants to
> allocate interrupts. So instead of having a convoluted construct
> reaching into the parent PCI device, you simply can do:
> 
>   1) Let the cxl_pci driver create a MSI parent domain and set that in
>      the subdevice::msi::irqdomain pointer.
> 
>   2) Provide cxl_aux_bus_create_irqdomain() which allows the CPMU device
>      driver to create a per device interrupt domain.
> 
>   3) Let the CPMU driver create its per device interrupt domain with
>      the provided parent domain
> 
>   4) Let the CPMU driver allocate its MSI-X interrupts through the per
>      device domain
> 
> Now on the cxl_pci side the AUXbus parent interrupt domain allocation
> function does:
> 
>     if (!pci_msix_enabled(pdev))
>     	return pci_msix_enable_and_alloc_irq_at(pdev, ....);
>     else
>         return pci_msix_alloc_irq_at(pdev, ....);
> 
> The condition can be avoided if the clx_pci driver enables MSI-X anyway
> for it's own purposes. Obviously you need the corresponding counterpart
> for free(), but that's left as an exercise for the reader.
> 
> That still associates the subdevice specific MSI-X interrups to the
> underlying PCI device, but then you need to look at teardown. The
> cxl_pci driver cannot go away before the CPMU drivers are shutdown.
>
> The CPMU driver shutdown releases the interrupts through the interrupt
> domain hierarchy, which removes them from the parent PCI device. Once
> all CPMU drivers are gone, the shutdown of the cxl_pci driver gets rid
> of the cxl_pci driver specific interrupts and everything is cleaned up.
> 
> This works out of the box on x86. The rest needs to gain support for
> MSI_FLAG_PCI_MSIX_ALLOC_DYN. ARM64 and parts of ARM32 are already
> converted over to the MSI parent domain concept, they just lack support
> for dynamic allocation. The rest of the arch/ world needs some more
> work. That's the problem of the architecture folks and that CXL auxbus
> thing can simply tell them
> 
>       if (!pci_msix_can_alloc_dyn(pdev))
>       		return -E_MAKE_YOUR_HOME_WORK;

Given my focus I need the arm64 case, but fine with this for others.

> 
> and be done with it. Proliferating support for "two" legacy PCI/MSI
> mechanisms by violating layering is not going to happen.
> 
> Neither I'm interrested to have creative workarounds for MSI as they are
> going to create more problems than they solve, unless you come up with a
> clean, simple and maintainable solution which works under all
> circumstances. I'm not holding my breath...

Nor am I.

> 
> I might not have all the crucial information as it happened in the
> previous IMS discussion, but looking at your ASCII art makes me halfways
> confident that I'm on the right track.

So that background I mentioned on the options for portdrv.
Note that the CPMU bit is an extension to this.
Much as I'd love to break non per device msix /dynamic msix it is a
non starter given need to improve existing driver.
However enabling CPMU and other extensions only for dynamic msix seems
fine to me.

Option 1. Tidy up today's solution only
---------------------------------------
Layering violations etc as you state above, but IRQ + MSI has to
work.

Port Drv                               PME                     AER 
--------                               ---                     ---
   |
0. Bind to pci_dev                
1. Set max MSI/MSIX
2. Read per subdriver msgnum            
3. Set to max msgnum seen             
4. Bus master enable etc.               
   |                                    
5. Register pci_express bus devices
   | (note this is a weird bus we'd all
   |  like to get rid of)
   |---------------------------------->|
   |                              6. Bind PME driver
   |                              7. Look up msgnum (again)
   |                              8. request_irq()
   |                              9. enable PME int (device side)
   |                                   | 
   |                                   |          
   |---------------------------------------------------> 6a. Bind AER driver
   |                                   |                 7a. Look up msgnum(again)
   |                                   |                 8a. request_irq()
   |                                   |                 9a. handle AER int (device side)
   |                                   |                        |   
10. unbind parent.                     |                        |
11. unregister children,               |                        |
   |-----------------------------12. PME remove() does...       |
   |                             13. disable int (device side)  |
   |                             14. free_irq() and cancel work |
   |                                                            |
   |--------------------------------------------------->12a. AER remove() does...
   |                                                    13a. Disable AER int (dev side)
   |                                                    14a. free irq cancel work etc.
   |
15. Finish remove pordrv remove()

- New functions added via same framework, so register on the pci_express bus.
  or via an auxbus. The auxbus was focus of this series.  If we are switching
  to a different bus, can do the approach you suggest and dynamic MSI-X only,
  - would be odd to do this for the pci_express bus given need the layering
    breakage anyway to keep MSI working.

(I think option 3 is better as it gets rid of existing layering issues
 that you called out).

Option 2:  What provoked this bit of the thread (but not the original thread which was
           option 1).

(This doesn't work - I think)

The PCI core would have to work with out dynamic MSIX as legacy but
we could do what you suggested for the 'extension' part and only
succeed in Extended PCI Port driver probing if that feature is
available (and safe on device)

Aim here was that 'core' PCI defined services 'should' need a driver bound.
This is true for some already.

PCI core                                                Extended PCI Port driver.
   |                                                    This only handles non PCI spec stuff.
   |
 1. Enumerate device
 2. Do interrupt discover as 
    previously done in portdrv
 3. Enable irq / MSI / MSIX as appropriate for
    AER, PME, DPC etc but not extended features.
 (note this would require binding to the device,
  which doesn't have a driver bound yet).
 4. Provide all the services original in portdrv
   |
   |
 5. Driver bind happens (fails because of note above).
   |------------------------------------------------------------|
   |                                                      6. request MSI/MSIX vectors.
   |<-----------------------------------------------------------|
6. Quiesce AER PME Etc.                                         .
7. Unbind all irqs (they may move anyway)                       .
8. Release msi/msix vecotrs etc.                                .
9. Request expanded set of MSI/MISX                             .
10. request all AER/PME etc irqs again.                         .
11. Check for missed interrupts (status register reads)         .
    and handle if we did.                                       . 
  |------------------------------------------------------------>|
  |                                                         Carry on as normal.

With your notes on dynamic MSIx and domains, this could be simplified
but falls down on the fact we can't handle stuff pre driver bind.
We could do a layered driver with domains and maybe hide that in the PCI
core, but why bother. (Option dead because you quite rightly are
not interested in more layering violations to solve that devres
issue).

Option 3: Move to flatter design for existing portdrv (+ children)
    The children (standard features) become library function calls
    Extensibility solved in 2a and 2b below.

Port Drv
   |
1. Set max MSI/MSIX
2. Read per subdriver msgnum
3. Set to max msgnum seen
4. Bus master enable etc.
5. PME setup
      Call pme_init(pci_dev);
      Request irq etc
6. AER setup
      Call aer_rp_init(pci_dev)'
      Request irq etc.
   |
   |
   |
7. unbind parent.
8. remove calls pme_exit(pci_dev)
9. remove calls aer_exit(pci_dev)
etc

So how to make this extensible
------------------------------
Option 3a:
- Augment main driver - possibly only if MSIX and
  dynamic allocation supported.

Option 3b:
- Leave main driver alone, extension requires binding
  a specific driver. Advantage is this is simple and
  that we don't end up with an ever increasing amount of
  'feature' discovery code in a single driver.

Note that this choice has nothing to do with the interrupt bits
but is more about feature discovery.

Either way, structure looks like above for PCI spec
defined 'normal' services + extra.

Port Drv                                                CXL PMU driver
   |                                                         |
1. Set max MSI/MSIX
2. Read per subdriver msgnum
3. Set to max msgnum seen
   If handling interrupts other than dynamic msix
   then we need to find child driver interrupts here
   too. Note that the Portdrv has to have specific code
   to enumerate the 'features' for which child devices
   are created anyway, so this isn't much worse.

4. Bus master enable etc.
5. PME setup
      Call pme_init(pci_dev);
      Request irq etc
6. AER setup
      Call aer_rp_init(pci_dev)'
      Request irq etc.
   |
7. Create create child devices
   |------------------------------------------------->Non dynamic msix
                                                      8. Request IRQ.
                                                      9. Normal driver operation.
                                                      Dynamic msix
                                                      8. Setup per device MSI Domain
                                                      9. request msix vectors
                                                         as you describe above.


So currently I'm thinking option 3 and with your inputs above
only support CXL PMU and other extended features with dynamic MSI-X.
Hopefully anyone who has built an MSI only CXL switch with a CPMU hasn't
read this far so won't object :)  Congratulations to anyone who
gets this far.

My current plan is to do:
1. Squash the various existing pci_express child drivers into the
   portdrv as simple library calls.
If using MSIX.
2. Add interrupt domain / msix stuff as you suggest + CPMU
   child as example.

Whether we end up with option 3a or 3b can be figure out later.

Thanks again for very useful feedback.

Jonathan

   

> 
> Thanks,
> 
>         tglx


