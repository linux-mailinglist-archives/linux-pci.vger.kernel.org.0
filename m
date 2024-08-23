Return-Path: <linux-pci+bounces-12087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0376A95CB22
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 13:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C857B20C44
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 11:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220FD381BD;
	Fri, 23 Aug 2024 11:05:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EEB149C46;
	Fri, 23 Aug 2024 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724411109; cv=none; b=WPT4ABsN3D6oItqhnbrfTBFZo2B+49xDtavgLXOUXfE84vSSuCyfH67Z8oC9oIZgF+3wU5uymlPdkyRKl9eytrCqUoPWHbOcZlnVz1NkBFBOUkxhGVDUyZ0xNbk2ECx3Dqp+VGZYFYfHzK3xyejTAYYA3vRYCP21FNtoseb+VSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724411109; c=relaxed/simple;
	bh=NQSHdvDg6tVcIpaIBq8j2YHTEEIKgEdkqQIGGNW5Fw0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJVdmzKKXCQeRuv4w/6dors8C16iB5+I0eeiB5LdfbjKqyIxKmMLP6p5NCtoIfNdRkrpW8GHLNlodkw8L6/T9aLZApGRKo5wqWX+SSDbDt4SvThb/iqIop6OND8beiSW8U9lMomr7r0SXwfoVVFtvRATHTKJ55Gbb6cp6YAxRHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wqxvf0h27z67HLW;
	Fri, 23 Aug 2024 19:01:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EB3E2140A70;
	Fri, 23 Aug 2024 19:05:02 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 12:05:02 +0100
Date: Fri, 23 Aug 2024 12:05:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Lukas Wunner <lukas@wunner.de>, Thomas Gleixner <tglx@linutronix.de>
CC: Bjorn Helgaas <helgaas@kernel.org>, <linuxarm@huawei.com>, "Mahesh J
 Salgaonkar" <mahesh@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Will
 Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, <terry.bowman@amd.com>, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [RFC PATCH 0/9] pci: portdrv: Add auxiliary bus and register
 CXL PMUs (and aer)
Message-ID: <20240823120501.00004151@Huawei.com>
In-Reply-To: <ZmG3vjD2sbCOPrM0@wunner.de>
References: <20240529164103.31671-1-Jonathan.Cameron@huawei.com>
	<20240605180409.GA520888@bhelgaas>
	<20240605204428.00001cb2@Huawei.com>
	<20240605213910.00003034@huawei.com>
	<ZmG3vjD2sbCOPrM0@wunner.de>
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

On Thu, 6 Jun 2024 15:21:02 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> On Thu, Jun 06, 2024 at 01:57:56PM +0100, Jonathan Cameron wrote:
> > Or are you thinking we can make something like the following work
> > (even when we can't do dynamic msix)?
> > 
> > Core bring up facilities and interrupt etc.  That includes bus master
> > so msi/msix can be issued (which makes me nervous - putting aside other
> > concerns as IIRC there are drivers where you have to be careful to
> > tweak registers to ensure you don't get a storm of traffic when you
> > hit bus master enable.
> > 
> > Specific driver may bind later - everything keeps running until 
> > the specific driver calls pci_alloc_irq_vectors(), then we have to disable all
> > interrupts for core managed services, change the number of vectors and
> > then move them to wherever they end up before starting them again.
> > We have to do the similar in the unwind path.  
> 
> My recollection is that Thomas Gleixner has brought up dynamic MSI-X
> allocation.  So if both the PCI core services as well as the driver
> use MSI-X, there's no problem.
> 
> For MSI, one approach might be to reserve a certain number of vectors
> in the core for later use by the driver.

So, my first attempt at doing things in the core ran into what I think
is probably a blocker. It's not entirely technical...

+CC Thomas who can probably very quickly confirm if my reasoning is
correct.

If we move these services into the PCI core itself (as opposed keeping
a PCI portdrv layer), then we need to bring up MSI for a device before
we bind a driver to that struct pci_dev / struct device.

If we follow through
pci_alloc_irq_vectors_affinity()
-> __pci_enable_msix_range() / __pci_enable_msi_range()
-> pci_setup_msi_context()
-> msi_setup_device_data()
-> devres_add()
//there is actually devres usage before this in msi_sysfs_create_group()
  but this is a shorter path to illustrate the point.

We will have registered a dev_res callback on the struct pci_dev
that we later want to be able to bind a driver to.  That driver
won't bind - because lifetimes of devres will be garbage
(see really_probe() for the specific check and resulting
"Resources present before probing")

So we in theory 'could' provide a non devres path through
the MSI code, but I'm going to guess that Thomas will not
be particularly keen on that to support this single use case.

Thomas, can you confirm if this is something you'd consider
or outright reject? Or is there an existing route to have 
MSI/X working pre driver bind and still be able to bind
the driver later.

Hence, subject to Thomas reply to above, I think we are back
to having a pci portdrv,

The options then become a case of tidying everything up and
supporting one of (or combination of).

1) Make all functionality currently handled by portdrv
   available in easily consumed form.  Handle 'extended' drivers
   by unbinding the class driver and binding another one (if
   the more specific driver happened not to bind) - we could
   make this consistent by checking for class matches first
   so we always land the generic driver if multiple are ready
   to go.  This may be a simple as an
   'devm_init_pcie_portdrv_standard(int mymaxmsgnum);' in probe
   of an extended driver.

2) Add lightweight static path to adding additional 'services'
   to portdrv.  Similar to current detection code to work out
   what message numbers are in going to be needed
3) Make portdrv support dynamic child drivers including increasing
   number of irq vectors if needed.
4) Do nothing at all and revisit next year (that 'worked' for
   last few years :)

Option 3 is most flexible but is it worth it?
- If we resize irq vectors, we will need to free all interrupts
  anyway and then reallocate them because they may move (maybe
  we can elide that if we are lucky for some devices).
- Will need to handle missed interrupts whilst they were disabled.
- Each 'child driver' will have to provide a 'detection' routine
  that will be called for all registered instances so that we can
  match against particular capabilities, stuff from BARs etc.
- Maybe we treat the 'normal' facilities from the PCI spec specially
  to avoid the interrupt enable/disable/enable dances except when
  there is something 'extra' present. That is more likely to hide
  odd bugs however.

I'm thinking option 3 is a case of over engineering something
better solved by 1 (or maybe 2).

There will be an LPC uconf session on this, but I'm going to
have some more time before LPC for exploration, so any inputs
now might help focus that effort. If not, see you in Vienna.

Jonathan




