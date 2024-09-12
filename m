Return-Path: <linux-pci+bounces-13121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A9B976DCA
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 17:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA101F2A47A
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 15:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6DD1BB688;
	Thu, 12 Sep 2024 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hlsu+K1z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ED01B985C
	for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2024 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155064; cv=none; b=UvtkDLDTDfoU2DdBagofClZS/1/ws06N9wCqF7uVKB5AAefNiO1uAbTfWONDmxcrLRyIMv10K8v5Gl8Qv8c/EaNY677UtKcdl+VLn+Yykk26oFIDENK0oIP3kU2b+2VhMHJhurkJOd7IK+Iq/qtjtQDAusO7dHt2vRdDj9sB7uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155064; c=relaxed/simple;
	bh=6xdexdUEZWIRi5wQHqS7E84P2gcDr+TBdsaGq/MHx7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZs1XZ0W1eZ19399VM8iOtmYwMq2rTAnMXnycxe2awU2S2hRxpUBExcv6yPK5/9nYhmQFfaLeW/TOpNcxhuTTk4uzySH4EidsSWBt5Dwiotq5C+acDeXkD7cJnNSLVBQxMRCdQr6LuRV5EIQ41S55zCdOKeGto+od2TQz3Gax9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hlsu+K1z; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726155064; x=1757691064;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6xdexdUEZWIRi5wQHqS7E84P2gcDr+TBdsaGq/MHx7w=;
  b=hlsu+K1zPm7u4XYXcnBgpJT9SybGnWSG0kYVuorg7jMMKM0eitfTlXxg
   IVS7iMNgbEufNDfmnKQIo0ZI2uZySw8LGyD15rbrWqSJ6BoJb34yxXoXs
   4ooS61OpHEqCHoLncU9UelBgukahmPYW9rgS91bB6BsqYDi3i+FoivUHh
   qEeDENM3RVjLcGS9nS109s48h52mb9O6H/wJKtExBy6n557ny44CYrp5t
   XL0uL/rUzNXOXQYsZkJHegy+ck2mz9FIlVb0EfaDjoW7OXKlJ9TAr7xvF
   d0oFXxqXwGlPWXiQ6gmm0L/E3cAsqNBdV661C0oxpTekhCaYIB6oagFrp
   Q==;
X-CSE-ConnectionGUID: r26MBZcbTnOnlUhjsjdJ4A==
X-CSE-MsgGUID: HBnZM5LRQ4qxY7ruLEikoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="47533321"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="47533321"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 08:31:03 -0700
X-CSE-ConnectionGUID: w+MLts2CSGeeQjDUTZkSLg==
X-CSE-MsgGUID: mqgASGBKTWitOms2Pjrb3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="68049450"
Received: from unknown (HELO localhost) ([10.2.132.131])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 08:31:02 -0700
Date: Thu, 12 Sep 2024 08:31:00 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org, paul.m.stillwell.jr@intel.com
Subject: Re: [PATCH v2] PCI: vmd: Clear PCI_INTERRUPT_LINE for VMD
 sub-devices
Message-ID: <20240912083100.000069bf@linux.intel.com>
In-Reply-To: <20240912143657.sgigcoj2lkedwfu4@thinkpad>
References: <20240820223213.210929-1-nirmal.patel@linux.intel.com>
	<20240822094806.2tg2pe6m75ekuc7g@thinkpad>
	<20240822113010.000059a1@linux.intel.com>
	<20240912143657.sgigcoj2lkedwfu4@thinkpad>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 20:06:57 +0530
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:

> On Thu, Aug 22, 2024 at 11:30:10AM -0700, Nirmal Patel wrote:
> > On Thu, 22 Aug 2024 15:18:06 +0530
> > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> >   
> > > On Tue, Aug 20, 2024 at 03:32:13PM -0700, Nirmal Patel wrote:  
> > > > VMD does not support INTx for devices downstream from a VMD
> > > > endpoint. So initialize the PCI_INTERRUPT_LINE to 0 for all NVMe
> > > > devices under VMD to ensure other applications don't try to set
> > > > up an INTx for them.
> > > > 
> > > > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>    
> > > 
> > > I shared a diff to put it in pci_assign_irq() and you said that
> > > you were going to test it [1]. I don't see a reply to that and
> > > now you came up with another approach.
> > > 
> > > What happened inbetween?  
> > 
> > Apologies, I did perform the tests and the patch worked fine.
> > However, I was able to see lot of bridge devices had the register
> > set to 0xFF and I didn't want to alter them.  
> 
> You should've either replied to my comment or mentioned it in the
> changelog.
> 
> > Also pci_assign_irg would still set the
> > interrupt line register to 0 with or without VMD. Since I didn't
> > want to introduce issues for non-VMD setup, I decide to keep the
> > change limited only to the VMD.
> >   
> 
> Sorry no. SPDK usecase is not specific to VMD and so is the issue. So
> this should be fixed in the PCI core as I proposed. What if another
> bridge also wants to do the same?

Okay. Should I clear every device that doesn't have map_irq setup like
you mentioned in your suggested patch or keep it to NVMe or devices
with storage class code?

-nirmal
> 
> - Mani 
> 
> > -Nirmal  
> > > 
> > > - Mani
> > > 
> > > [1]
> > > https://lore.kernel.org/linux-pci/20240801115756.0000272e@linux.intel.com
> > >   
> > > > ---
> > > > v2->v1: Change the execution from fixup.c to vmd.c
> > > > ---
> > > >  drivers/pci/controller/vmd.c | 13 +++++++++++++
> > > >  1 file changed, 13 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/vmd.c
> > > > b/drivers/pci/controller/vmd.c index a726de0af011..2e9b99969b81
> > > > 100644 --- a/drivers/pci/controller/vmd.c
> > > > +++ b/drivers/pci/controller/vmd.c
> > > > @@ -778,6 +778,18 @@ static int vmd_pm_enable_quirk(struct
> > > > pci_dev *pdev, void *userdata) return 0;
> > > >  }
> > > >  
> > > > +/*
> > > > + * Some applications like SPDK reads PCI_INTERRUPT_LINE to
> > > > decide
> > > > + * whether INTx is enabled or not. Since VMD doesn't support
> > > > INTx,
> > > > + * write 0 to all NVMe devices under VMD.
> > > > + */
> > > > +static int vmd_clr_int_line_reg(struct pci_dev *dev, void
> > > > *userdata) +{
> > > > +	if(dev->class == PCI_CLASS_STORAGE_EXPRESS)
> > > > +		pci_write_config_byte(dev, PCI_INTERRUPT_LINE,
> > > > 0);
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long
> > > > features) {
> > > >  	struct pci_sysdata *sd = &vmd->sysdata;
> > > > @@ -932,6 +944,7 @@ static int vmd_enable_domain(struct vmd_dev
> > > > *vmd, unsigned long features) 
> > > >  	pci_scan_child_bus(vmd->bus);
> > > >  	vmd_domain_reset(vmd);
> > > > +	pci_walk_bus(vmd->bus, vmd_clr_int_line_reg,
> > > > &features); 
> > > >  	/* When Intel VMD is enabled, the OS does not discover
> > > > the Root Ports
> > > >  	 * owned by Intel VMD within the MMCFG space.
> > > > pci_reset_bus() applies -- 
> > > > 2.39.1
> > > > 
> > > >     
> > >   
> >   
> 


