Return-Path: <linux-pci+bounces-10985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CB193FED4
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 22:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E923F1C210B5
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 20:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123A1188CAD;
	Mon, 29 Jul 2024 20:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aSF2N7EV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46663188CA3
	for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722283819; cv=none; b=H+YzbMoDPa3/Se7zcCdZnD303EA1SlHFkBE5jHk0rF6L46kGPOUcsLDC2u8SHho/kmNlEjq8FUdflQfCFtPuDlyhNuR8SdWC6/D0pHqsSyrVk6b3xfwJ7aJ3+sxoRvzHc0e6RC49Jiws13YGuDC7ZfCzp3RU/r0IdfrvDJsXg8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722283819; c=relaxed/simple;
	bh=p/Csa5iqHgp40wgkuGqf/Jxs3cvWtxzpQk3F9iidFZc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O6JleOya7pJZNv+G+DFjqFe8D0XbLCJdR+tml938mNyDbwa7EzI1JIiO3stVAv4x+hMWQJyTkABAM+4u3GWEdTegt0R+I2+fsuCo3QDV1U1J5gxOyHz7mk/VLC34Y9nkpUP2Gie6z0VMI8uEZRtpHXc3u0P0nAfZTUBj8piLHMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aSF2N7EV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722283817; x=1753819817;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p/Csa5iqHgp40wgkuGqf/Jxs3cvWtxzpQk3F9iidFZc=;
  b=aSF2N7EVOyZ8IUQs0Z33+MAW8HPcjKxVvflBvilFaOH768cqOf1YXTb7
   sknmM5QjOQSg+7/rPyx3z6MhhYS4RfxHLm1/NvzlpaOwSTmzYOwe0Fplq
   khUV8PXzqlyhswyg7WLrSFy4FrpnK+663J2zzebEB8FBlFmsQxd/kv30i
   ra7cJKOJWHta+9lVwYq3zuUKBkbakZBPyS29pwt6Jb7c1gZfBnRx8SpUk
   ghjgja0cjo7AbPl4T+W71HRGGbQrOsJdNggKpWxWGYOqG7TfUnLQZXY0i
   vIzL76F3BuyTayNaNYx90P2ZXQsoNHRpUvbXzUIrxQNES8tnJVB6Huu9a
   A==;
X-CSE-ConnectionGUID: 7WmIsXH+Q9imYss1bDPusg==
X-CSE-MsgGUID: hohVz3+aQz+qar992w3WXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="23819171"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="23819171"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 13:10:17 -0700
X-CSE-ConnectionGUID: ylecFUkGShqTISrl/Lo/Pw==
X-CSE-MsgGUID: aqw5QSsyRr+U2ja0k3DwrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54329436"
Received: from pmaziews-mobl1.ger.corp.intel.com (HELO localhost) ([10.246.148.184])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 13:10:16 -0700
Date: Mon, 29 Jul 2024 13:10:15 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, paul.m.stillwell.jr@intel.com, Jim Harris
 <james.r.harris@intel.com>
Subject: Re: [PATCH] PCI: fixup PCI_INTERRUPT_LINE for VMD downstream
 devices
Message-ID: <20240729131015.000000b9@linux.intel.com>
In-Reply-To: <20240724191030.GA806685@bhelgaas>
References: <20240724170040.5193-1-nirmal.patel@linux.intel.com>
	<20240724191030.GA806685@bhelgaas>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jul 2024 14:10:30 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, Jul 24, 2024 at 10:00:40AM -0700, Nirmal Patel wrote:
> > VMD does not support legacy interrupts for devices downstream from a
> > VMD endpoint. So initialize the PCI_INTERRUPT_LINE to 0 for these
> > devices to ensure we don't try to set up a legacy irq for them.  
> 
> s/legacy interrupts/INTx/
> s/legacy irq/INTx/
> 
> > Note: This patch was proposed by Jim, I am trying to upstream it.
> > 
> > Signed-off-by: Jim Harris <james.r.harris@intel.com>
> > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > ---
> >  arch/x86/pci/fixup.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> > index b33afb240601..a3b34a256e7f 100644
> > --- a/arch/x86/pci/fixup.c
> > +++ b/arch/x86/pci/fixup.c
> > @@ -653,6 +653,20 @@ static void quirk_no_aersid(struct pci_dev
> > *pdev) DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL,
> > PCI_ANY_ID, PCI_CLASS_BRIDGE_PCI, 8, quirk_no_aersid);
> >  
> > +#if IS_ENABLED(CONFIG_VMD)
> > +/* 
> > + * VMD does not support legacy interrupts for downstream devices.
> > + * So PCI_INTERRPUT_LINE needs to be initialized to 0 to ensure OS
> > + * doesn't try to configure a legacy irq.  
> 
> s/legacy interrupts/INTx/
> s/PCI_INTERRPUT_LINE/PCI_INTERRUPT_LINE/
> 
> > + */
> > +static void quirk_vmd_interrupt_line(struct pci_dev *dev)
> > +{
> > +	if (is_vmd(dev->bus))
> > +		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 0);
> > +}
> > +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID,
> > quirk_vmd_interrupt_line);  
> 
> A quirk for every PCI device, even on systems without VMD, seems like
> kind of a clumsy way to deal with this.
> 
> Conceptually, I would expect a host bridge driver (VMD acts like a
> host bridge in this case) to know whether it supports INTx, and if the
> driver knows it doesn't support INTx or it has no _PRT or DT
> description of INTx routing to use, an attempt to configure INTx
> should just fail naturally.
> 
> I don't claim this is how host bridge drivers actually work; I just
> think it's the way they *should* work.

For VMD as a host bridge, pci_host_bridge::map_irq is null. Even all
VMD rootports' PCI_INTERRUPT_LINE registers are set to 0. Since VMD
doesn't explicitly set PCI_INTERRUPT_LINE register to 0 for all of its
sub-devices (i.e. NVMe), if some NVMes has non-zero value set for
PCI_INTERRUPT_LINE (i.e. 0xff) then some software like SPDK can read
it and make wrong assumption about INTx support.

Based your suggestion, it might be better if VMD sets
PCI_INTERRUPT_LINE register to 0 for all of its sub-devices during
VMD enumeration.

-nirmal.
> 
> > +#endif
> > +
> >  static void quirk_intel_th_dnv(struct pci_dev *dev)
> >  {
> >  	struct resource *r = &dev->resource[4];
> > -- 
> > 2.39.1
> >   


