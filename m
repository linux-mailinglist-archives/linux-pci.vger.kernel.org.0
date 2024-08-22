Return-Path: <linux-pci+bounces-12033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA5F95BE3B
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 20:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FC55B27940
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 18:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900BD41C63;
	Thu, 22 Aug 2024 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpQm+ABF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B828155E48
	for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2024 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351414; cv=none; b=u65b0B0azfo1GxBHumHn8azZ8yS5LTk47EWQOGl7UDtuhqTzlDVEd87Vg3C2bALGjxhACdyznw6sU3XIhLS4T30M8UKNuTe+3x1HOSwvODYKwIz3mBREueWMMDlt+v466d2siU2MSwYubB6TZbi9mHJYf3jLrhTPp8ZCTvkT5Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351414; c=relaxed/simple;
	bh=JKpObr/cczTVpONnx+MLKKexqfS0ovw/IxCos90069Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkWfI+XXD1DD7yyThdb4wKXtVSBsfYnDEQxCqFgZtsN6qK4WDmEA8bs1/ZV3hqjrFAzIgBghgMKToLp6H1w1Ye03TMtcrWNqTNDs66XdC10bO2gfbWCqX3ljpbmMPAyuh8CWbjR/pYpqm59j/KIsxiyIWhbR9i30BcOObWi6dv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpQm+ABF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724351413; x=1755887413;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JKpObr/cczTVpONnx+MLKKexqfS0ovw/IxCos90069Q=;
  b=kpQm+ABFZEyvFtpPd1dFFnrv/3GoqyNGgWI0weyz/R5z3Jvm3ZdkK2FU
   GyMopkFvndPz1n0MA+J5IuZbt/TXxXVm1dxN8EeJ3dBZjL/y3RSuZF0QH
   BtkN30rcijytiZ4bC3/aKyUdPtyCzzBki5ATYic+RB0B+mtPYS/jMi+h/
   Q+mMgSzXuFs1zN+pDm5apaYqyNfiz9WWJPyBf0hMmISkhLSy7ZZrFW7pi
   Hl5Ljbp+PJD6OcnDKkcIa9gOC8HnXPZAYx3uukiunU1XDP79+aJwZC8sH
   PyXsG2TzgIZ2OSWZIVHkARROQ2rkPIBuSqLnmTN9Kn0nAtcZbhWvdHge2
   w==;
X-CSE-ConnectionGUID: CZ7qe8SdS3uv1c3SXy6dBA==
X-CSE-MsgGUID: CApygE7yQzOxUkxW7oNmdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="48184700"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="48184700"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 11:30:12 -0700
X-CSE-ConnectionGUID: /LNE4Lf/QlC79YvNVahwuw==
X-CSE-MsgGUID: 2OidSMZFT/STgWgYp/m8/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="61844294"
Received: from unknown (HELO localhost) ([10.2.132.131])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 11:30:12 -0700
Date: Thu, 22 Aug 2024 11:30:10 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org, paul.m.stillwell.jr@intel.com
Subject: Re: [PATCH v2] PCI: vmd: Clear PCI_INTERRUPT_LINE for VMD
 sub-devices
Message-ID: <20240822113010.000059a1@linux.intel.com>
In-Reply-To: <20240822094806.2tg2pe6m75ekuc7g@thinkpad>
References: <20240820223213.210929-1-nirmal.patel@linux.intel.com>
	<20240822094806.2tg2pe6m75ekuc7g@thinkpad>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 15:18:06 +0530
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:

> On Tue, Aug 20, 2024 at 03:32:13PM -0700, Nirmal Patel wrote:
> > VMD does not support INTx for devices downstream from a VMD
> > endpoint. So initialize the PCI_INTERRUPT_LINE to 0 for all NVMe
> > devices under VMD to ensure other applications don't try to set up
> > an INTx for them.
> > 
> > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>  
> 
> I shared a diff to put it in pci_assign_irq() and you said that you
> were going to test it [1]. I don't see a reply to that and now you
> came up with another approach.
> 
> What happened inbetween?

Apologies, I did perform the tests and the patch worked fine. However, I
was able to see lot of bridge devices had the register set to 0xFF and I
didn't want to alter them. Also pci_assign_irg would still set the
interrupt line register to 0 with or without VMD. Since I didn't want to
introduce issues for non-VMD setup, I decide to keep the change limited
only to the VMD.

-Nirmal
> 
> - Mani
> 
> [1]
> https://lore.kernel.org/linux-pci/20240801115756.0000272e@linux.intel.com
> 
> > ---
> > v2->v1: Change the execution from fixup.c to vmd.c
> > ---
> >  drivers/pci/controller/vmd.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/vmd.c
> > b/drivers/pci/controller/vmd.c index a726de0af011..2e9b99969b81
> > 100644 --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -778,6 +778,18 @@ static int vmd_pm_enable_quirk(struct pci_dev
> > *pdev, void *userdata) return 0;
> >  }
> >  
> > +/*
> > + * Some applications like SPDK reads PCI_INTERRUPT_LINE to decide
> > + * whether INTx is enabled or not. Since VMD doesn't support INTx,
> > + * write 0 to all NVMe devices under VMD.
> > + */
> > +static int vmd_clr_int_line_reg(struct pci_dev *dev, void
> > *userdata) +{
> > +	if(dev->class == PCI_CLASS_STORAGE_EXPRESS)
> > +		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 0);
> > +	return 0;
> > +}
> > +
> >  static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long
> > features) {
> >  	struct pci_sysdata *sd = &vmd->sysdata;
> > @@ -932,6 +944,7 @@ static int vmd_enable_domain(struct vmd_dev
> > *vmd, unsigned long features) 
> >  	pci_scan_child_bus(vmd->bus);
> >  	vmd_domain_reset(vmd);
> > +	pci_walk_bus(vmd->bus, vmd_clr_int_line_reg, &features);
> >  
> >  	/* When Intel VMD is enabled, the OS does not discover the
> > Root Ports
> >  	 * owned by Intel VMD within the MMCFG space.
> > pci_reset_bus() applies -- 
> > 2.39.1
> > 
> >   
> 


