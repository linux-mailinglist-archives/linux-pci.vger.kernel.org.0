Return-Path: <linux-pci+bounces-13185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 803EC9785AD
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 18:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BDD0288814
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 16:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC374A21;
	Fri, 13 Sep 2024 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rsfTMK2R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="goGmJOqL"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C303DF44;
	Fri, 13 Sep 2024 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726244660; cv=none; b=LeZ4HxiBb6Gioj+BNWmFlS7TTKSEioTvowgVhovl4niX1kveICAy4RIfrrBKsxbh+zZ0tgW+7Vh0GCcJqZ5OwP4NugVdzpzSYdScuUudQOssW5UCtb3FhH2cQqQtjA6PJQYb8bPjEY934DRK8csveKRQPxFFgz73ogAih8+cu3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726244660; c=relaxed/simple;
	bh=4KbweOLEW4rykq3LdE48/Z53JFTGhqnuVPlJuHu61vA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SRHopX44krJLhZ2yfZDmKanm+ju9o8+sIpNk1TnLqx8JCiflEO4EFeOCe8q7ALApxyYFM7nuBSr4Xcs6zSdBa1KpxPN6e0pJCrgoNTJ4+k5BsU17p+UcKVtfLFYD9haC+aMtYyGWm80aN4Y5qPS+EZGb2SyoV6+f2FmilOgskSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rsfTMK2R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=goGmJOqL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726244655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Hax2cW5JgDt95oBN7qxKwUxgSAj7F/34L7wd/yOIdQ=;
	b=rsfTMK2RqRQ4PZ9WvKEXF6usrbOGZDJGJvs4UFVXdu/zTDf9umHvgfbMtunurZLWadfTdP
	oAEShglv2prP6mY6HwqErlgjn52+DupBDDUP5FCgAr0PJAgs9mmsYSKVFATXsxEMimdYge
	uvaupmsZPBWcP11tfbcTaQ2RX8hTjyiNmL9Dedk8ZcSjr83kg9u9MrkRkjsxkublrOXkyY
	s1lYt/arNTzKs9FK+gO9d78YN+LuJ90M33qvreU17xQJ+43c0QWcKN7gffJwCoBI9QvzGk
	AxByZIQW3lQ93quwoRFnfgdvuRFyaAsEkGdWJ9jbayka89OOK1rPkD0RfrjUbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726244655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Hax2cW5JgDt95oBN7qxKwUxgSAj7F/34L7wd/yOIdQ=;
	b=goGmJOqLlDeEYvaLcbyXUAIQak5mvw2T2Dy0ydd96ektmtghGqWEeh6yHYLl2UDZVogujV
	ggcS4o3nlyuRWeCQ==
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 Mahesh
 J Salgaonkar <mahesh@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
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
In-Reply-To: <20240912183429.00006fa7@Huawei.com>
References: <20240905122342.000001be@Huawei.com> <87jzfpdrc7.ffs@tglx>
 <20240906181832.00007dc7@Huawei.com> <20240910174743.000037c7@huawei.com>
 <87h6an9sxp.ffs@tglx> <20240912173720.000077ac@Huawei.com>
 <20240912183429.00006fa7@Huawei.com>
Date: Fri, 13 Sep 2024 18:24:14 +0200
Message-ID: <87ed5n8qtt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 12 2024 at 18:34, Jonathan Cameron wrote:
> On Thu, 12 Sep 2024 17:37:20 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>> One bit that is challenging me is that the PCI access functions
>> use the pci_dev that is embedded via irq_data->common->msi_desc->dev
>> (and hence doesn't give us a obvious path to any hierarchical structures)
>> E.g. __pci_write_msi_msg() and which checks the pci_dev is
>> powered up.
>>
>> I'd like to be able to do a call to the parent similar to
>> irq_chip_unmask_parent to handle write_msi_msg() for the new device
>> domain.

That's what hierarchy is about.  I see your problem vs. the
msi_desc::dev though.

>> So how should this be avoided or should msi_desc->dev be the
>> PCI device?

See below.

> I thought about this whilst cycling home.  Perhaps my fundamental
> question is more basic  Which device should
> msi_dec->dev be?
> * The ultimate requester of the msi  -  so here the one calling
>   our new pci_msix_subdev_alloc_at(),
> * The one on which the msi_write_msg() should occur. - here
>   that would be the struct pci_dev given the checks needed on
>   whether the device is powered up.  If this is the case, can
>   we instead use the irq_data->dev in __pci_write_msi_msg()?

Only for per device MSI domains and you need to look irq data up, so
leave that alone.

> Also, is it valid to use the irq_domain->dev for callbacks such
> as msi_prepare_desc on basis that (I think) is the device
> that 'hosts' the irq domain, so can we use it to replace the
> use of msi_desc->dev in pci_msix_prepare_desc()
> If we can that enables our subdev to use a prepare_desc callback
> that does something like
>
> 	struct msi_domain *info;
>
> 	domain = domain->parent;
> 	info = domain->host_data;
>
> 	info->ops->prepare_desc(domain, arg, desc);

That should work, but you can simply do:

subdev_prepare_desc(domain, arg, desc)
{
        desc->dev = domain->parent->dev;
        pci_msix_prepare_desc(domain, arg, desc);
}

as this is a strict relationship in the PCI code.

This needs a validation that nothing relies on desc->dev being the same
as the device which allocated the descriptor:

  msi_desc_to_pci_dev(), msi_desc_to_dev() and a pile of open coded
  accesses.

The open coded access should be fixed and prevented by marking it
__private so people are forced to use the accessor functions.

If there is no reliance, we can just do that.

I checked the MSI core code already. Nothing to see there.

Thanks,

        tglx

