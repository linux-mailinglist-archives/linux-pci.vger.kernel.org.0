Return-Path: <linux-pci+bounces-10984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CE693FECC
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 22:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55CA71C210E9
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 20:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93AA189F33;
	Mon, 29 Jul 2024 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0+MGHp8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D25D188CB8
	for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 20:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722283743; cv=none; b=a+keUuLladrzaAWLPkyOKKvhcVHfDoTzlcmLHyZExIkvpMQuyc7ZLkT79oyE/Fona7OvtjQ+N6tT2wMOm6zaV4IR37BwYgg2VGoKihEZtzWmFRKvrJeByQs2gYkbIcY9wtk6C4Ac/E7DcuedmuRvZb05Mer1RvfRnhGDVSm4rxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722283743; c=relaxed/simple;
	bh=bvRsn+eQFP8Hd2Z6tHRhRIKQNTDE35z3vhWNWv049OY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+Iuc7GJKIEGMePQtSEQyGljlE2xRr9lUjl/lpkAWe1eyDKeCOYy99nvo1WTD4qFOALOfZz6uZTG8RQ2aaocunh6VCd+QK4/sqsCJ1hgvcBgWAndiSeHC41swQ8D169FRQdksL0C0JqSb9mFNLT0s1hrmuMFJdCEHCY/dBqAzXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0+MGHp8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722283742; x=1753819742;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bvRsn+eQFP8Hd2Z6tHRhRIKQNTDE35z3vhWNWv049OY=;
  b=B0+MGHp8GFnj3nNPpYR9kbMNeYjDT7Q/1DAssVUymtqy9K24wMiyPAoK
   9rjvr/uo8HCH9HGnKPCzUVRlNTxuxaas9ezPdWNn7nm9ILivXgf3ngr7U
   iBB2aT1uhwrYFJ/sEbx+qGy9Cm3pf75ijJwgLoLASTcBQwUO93Jo1JJOX
   3NRp1XYeIA1Jz6oLoWxeEMcCqnqJpuiSkjGxvJE0dPSnpOvxrem+cEnZ1
   0pxiwNVFRLpKvl8e0f9wGpbm+8iS3VodiP6R44OT/mZ8NoZfrMS4XqJce
   RU9euWgvJGSbBY3y0xuwyA7ebXm0bLV6oFT5wSABC3SwIdsxP2SSvEsFs
   g==;
X-CSE-ConnectionGUID: L792fS4sQBKK1pzP9CZUrA==
X-CSE-MsgGUID: Vzf6g162QPqkeD83JAmc+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="23818872"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="23818872"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 13:09:01 -0700
X-CSE-ConnectionGUID: mh7dIHhNRHucBprv7z/m4Q==
X-CSE-MsgGUID: JQEa0qnIS46KF1rlTLjPhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54165428"
Received: from pmaziews-mobl1.ger.corp.intel.com (HELO localhost) ([10.246.148.184])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 13:09:01 -0700
Date: Mon, 29 Jul 2024 13:08:59 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 paul.m.stillwell.jr@intel.com, Jim Harris <james.r.harris@intel.com>
Subject: Re: [PATCH] PCI: fixup PCI_INTERRUPT_LINE for VMD downstream
 devices
Message-ID: <20240729130859.00006a5a@linux.intel.com>
In-Reply-To: <20240725041013.GB2317@thinkpad>
References: <20240724170040.5193-1-nirmal.patel@linux.intel.com>
	<20240724191030.GA806685@bhelgaas>
	<20240725041013.GB2317@thinkpad>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 09:40:13 +0530
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:

> On Wed, Jul 24, 2024 at 02:10:30PM -0500, Bjorn Helgaas wrote:
> > On Wed, Jul 24, 2024 at 10:00:40AM -0700, Nirmal Patel wrote:  
> > > VMD does not support legacy interrupts for devices downstream
> > > from a VMD endpoint. So initialize the PCI_INTERRUPT_LINE to 0
> > > for these devices to ensure we don't try to set up a legacy irq
> > > for them.  
> > 
> > s/legacy interrupts/INTx/
> > s/legacy irq/INTx/
> >   
> > > Note: This patch was proposed by Jim, I am trying to upstream it.
> > > 
> > > Signed-off-by: Jim Harris <james.r.harris@intel.com>
> > > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > > ---
> > >  arch/x86/pci/fixup.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> > > index b33afb240601..a3b34a256e7f 100644
> > > --- a/arch/x86/pci/fixup.c
> > > +++ b/arch/x86/pci/fixup.c
> > > @@ -653,6 +653,20 @@ static void quirk_no_aersid(struct pci_dev
> > > *pdev) DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL,
> > > PCI_ANY_ID, PCI_CLASS_BRIDGE_PCI, 8, quirk_no_aersid);
> > >  
> > > +#if IS_ENABLED(CONFIG_VMD)
> > > +/* 
> > > + * VMD does not support legacy interrupts for downstream devices.
> > > + * So PCI_INTERRPUT_LINE needs to be initialized to 0 to ensure
> > > OS
> > > + * doesn't try to configure a legacy irq.  
> > 
> > s/legacy interrupts/INTx/
> > s/PCI_INTERRPUT_LINE/PCI_INTERRUPT_LINE/
> >   
> > > + */
> > > +static void quirk_vmd_interrupt_line(struct pci_dev *dev)
> > > +{
> > > +	if (is_vmd(dev->bus))
> > > +		pci_write_config_byte(dev, PCI_INTERRUPT_LINE,
> > > 0); +}
> > > +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID,
> > > quirk_vmd_interrupt_line);  
> > 
> > A quirk for every PCI device, even on systems without VMD, seems
> > like kind of a clumsy way to deal with this.
> > 
> > Conceptually, I would expect a host bridge driver (VMD acts like a
> > host bridge in this case) to know whether it supports INTx, and if
> > the driver knows it doesn't support INTx or it has no _PRT or DT
> > description of INTx routing to use, an attempt to configure INTx
> > should just fail naturally.
> > 
> > I don't claim this is how host bridge drivers actually work; I just
> > think it's the way they *should* work.
> >   
> 
> Absolutely! This patch is fixing the issue in a wrong place. There
> are existing DT based host bridge drivers that disable INTx due to
> lack of hardware capability. The driver just need to nullify
> pci_host_bridge::map_irq callback.
> 
> - Mani
> 
For VMD as a host bridge, pci_host_bridge::map_irq is null. Even all
VMD rootports' PCI_INTERRUPT_LINE registers are set to 0. Since VMD
doesn't explicitly set PCI_INTERRUPT_LINE register to 0 for all of its
sub-devices (i.e. NVMe), if some NVMes has non-zero value set for
PCI_INTERRUPT_LINE (i.e. 0xff) then some software like SPDK can read
it and make wrong assumption about INTx support.

Based Bjorn's and your suggestion, it might be better if VMD sets
PCI_INTERRUPT_LINE register for all of its sub-devices during VMD
enumeration.

-nirmal. 

