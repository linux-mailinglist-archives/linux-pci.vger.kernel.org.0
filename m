Return-Path: <linux-pci+bounces-12826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B70296D6F9
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 13:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F411C24C8C
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 11:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35251991AC;
	Thu,  5 Sep 2024 11:23:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E0319884A;
	Thu,  5 Sep 2024 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535434; cv=none; b=StTmPU95X/JHpSWQ7yImuqlPhKCrHxjnnZdCm9kw8coBVyehZigDqSyB2/8XVD0c2VBdpDbWAbTR9kxsgwPw4BI2ixoNWFrHhbYrS5ot7fTn5kSdhC7nFdW1srhXuH0MjXo8NNrV3GbusFiZFy3oJ+9cEP84VGYpCCO7Bb14ewI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535434; c=relaxed/simple;
	bh=8kCS0pJXM3ezR5roVWNJdy8wnu81VgMsOVNuKqbx5vc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GipyKvd26hP1X8/6GYP9Z6M3ciLdtL4LekMHY/gkxS9UwF5xHCKwzgV6AzNXUkX+QduzcfxiOZfcmWSh9iB3JszfXRxPN9//wyD7L/zpLf1MurUerWbxzSZMHNRbZAbujneekFqTC9lEBpSeDLF4/y5ILL4tNA68tjejA3uZAng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WzxjG2btbz6K8yp;
	Thu,  5 Sep 2024 19:20:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3108C1400DC;
	Thu,  5 Sep 2024 19:23:44 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 5 Sep
 2024 12:23:43 +0100
Date: Thu, 5 Sep 2024 12:23:42 +0100
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
Message-ID: <20240905122342.000001be@Huawei.com>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Hi Thomas,

One quick follow up question below.

> 
> So looking at the ASCII art of the cover letter:
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

Hi Thomas,

I'm struggling to follow this suggestion
Would you expect the cxl_pci MSI parent domain to set it's parent as
msi_domain = irq_domain_create_hierarchy(dev_get_msi_domain(&pdev->dev),
					 IRQ_DOMAIN_FLAG_MSI_PARENT,
					 ...
which seems to cause a problem with deadlocks in __irq_domain_alloc_irqs()
or create a separate domain structure and provide callbacks that reach into
the parent domain as necessary?

Or do I have this entirely wrong? I'm struggling to relate what existing
code like PCI does to what I need to do here.

Jonathan



