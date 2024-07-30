Return-Path: <linux-pci+bounces-11027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB85941F03
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 19:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E9FCB20E29
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 17:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7A0168490;
	Tue, 30 Jul 2024 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T6Jr3g2s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DDC1A76C9
	for <linux-pci@vger.kernel.org>; Tue, 30 Jul 2024 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722361879; cv=none; b=Y00K4KUqTZS1MDvQe/FnXTEBs/i71YfYSDXsh+EYGHaukAkPGahw/zQufcj0NKnr5GkpNtmJ6vwiHo/tIWafO4/iJ2aAkaVsQkPrT6Vun20LGOM8j0HWz4lytbJVNDGdr615n83850DxMWZrbFLotqNhJDmk+cejyy5dt+hytbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722361879; c=relaxed/simple;
	bh=Um4W4MDCqCmCxDO4fCT4NJhWZ7UZ5dYPjKblwQNzfqo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xwe0nuE21qpX1yZuHtMGW9VTa9GNKCL8VMy3SBYddnM2hafAxsooYtsmtIv4ZvW4HVqetouNgLCFmVxAz3SsEP8iyDHjBdf5UR379UjNYOa9AsaJ2iuykayAkSSX6FvwOmXX2slmfng2aCbj3JtClW/0s0m96CEqIMSs621Ponk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T6Jr3g2s; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722361875; x=1753897875;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Um4W4MDCqCmCxDO4fCT4NJhWZ7UZ5dYPjKblwQNzfqo=;
  b=T6Jr3g2sYHCmVQ4NEZwSl0gxWvAvwqQdVxtyrCTN03VIWoZwNANEeArj
   D/Iw4YU46xPWrpBgVZQy0TXF1MY95oN+SzxPbihlEI0ZakCQG0XvVJclE
   KC0bF79rc+etICVJGLaNHUAuff2p7gYIykdCgDGoeXlM5JvY1Vrf646iV
   ShLi+OYODKlekjkkNtPxe3oWd0/qg8HBpMr2K21QhH4CA9M9AB8n4PikP
   IZsxgB0nF1FIKP0WH5ZNQ7lSpvvHRwXJM4m02WGuPc0sKK6+9VJveVYz+
   X5NNk0LNFyOyKYeF+BVnjAVNxnHTz4FCKqFY9BlYZlg2JMPZFWQecbaJ2
   g==;
X-CSE-ConnectionGUID: j6Mwi3z9QBGgGAgyNkEaMA==
X-CSE-MsgGUID: NKM6OmOlRvuEAifxT6r4cA==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="24067070"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="24067070"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 10:51:15 -0700
X-CSE-ConnectionGUID: esPVYI4DQWi7/zXrd7iLhA==
X-CSE-MsgGUID: 1o9Bvg2XRRe5CEKTESrAnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="54412504"
Received: from patelni-mobl1.amr.corp.intel.com (HELO localhost) ([10.246.148.184])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 10:51:16 -0700
Date: Tue, 30 Jul 2024 10:51:15 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 paul.m.stillwell.jr@intel.com, Jim Harris <james.r.harris@intel.com>
Subject: Re: [PATCH] PCI: fixup PCI_INTERRUPT_LINE for VMD downstream
 devices
Message-ID: <20240730105115.00004089@linux.intel.com>
In-Reply-To: <20240730052830.GA3122@thinkpad>
References: <20240724170040.5193-1-nirmal.patel@linux.intel.com>
	<20240724191030.GA806685@bhelgaas>
	<20240725041013.GB2317@thinkpad>
	<20240729130859.00006a5a@linux.intel.com>
	<20240730052830.GA3122@thinkpad>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 10:58:30 +0530
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:

> On Mon, Jul 29, 2024 at 01:08:59PM -0700, Nirmal Patel wrote:
> > On Thu, 25 Jul 2024 09:40:13 +0530
> > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> >   
> > > On Wed, Jul 24, 2024 at 02:10:30PM -0500, Bjorn Helgaas wrote:  
> > > > On Wed, Jul 24, 2024 at 10:00:40AM -0700, Nirmal Patel wrote:
> > > >  
> > > > > VMD does not support legacy interrupts for devices downstream
> > > > > from a VMD endpoint. So initialize the PCI_INTERRUPT_LINE to 0
> > > > > for these devices to ensure we don't try to set up a legacy
> > > > > irq for them.    
> > > > 
> > > > s/legacy interrupts/INTx/
> > > > s/legacy irq/INTx/
> > > >     
> > > > > Note: This patch was proposed by Jim, I am trying to upstream
> > > > > it.
> > > > > 
> > > > > Signed-off-by: Jim Harris <james.r.harris@intel.com>
> > > > > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > > > > ---
> > > > >  arch/x86/pci/fixup.c | 14 ++++++++++++++
> > > > >  1 file changed, 14 insertions(+)
> > > > > 
> > > > > diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> > > > > index b33afb240601..a3b34a256e7f 100644
> > > > > --- a/arch/x86/pci/fixup.c
> > > > > +++ b/arch/x86/pci/fixup.c
> > > > > @@ -653,6 +653,20 @@ static void quirk_no_aersid(struct
> > > > > pci_dev *pdev)
> > > > > DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL,
> > > > > PCI_ANY_ID, PCI_CLASS_BRIDGE_PCI, 8, quirk_no_aersid); 
> > > > > +#if IS_ENABLED(CONFIG_VMD)
> > > > > +/* 
> > > > > + * VMD does not support legacy interrupts for downstream
> > > > > devices.
> > > > > + * So PCI_INTERRPUT_LINE needs to be initialized to 0 to
> > > > > ensure OS
> > > > > + * doesn't try to configure a legacy irq.    
> > > > 
> > > > s/legacy interrupts/INTx/
> > > > s/PCI_INTERRPUT_LINE/PCI_INTERRUPT_LINE/
> > > >     
> > > > > + */
> > > > > +static void quirk_vmd_interrupt_line(struct pci_dev *dev)
> > > > > +{
> > > > > +	if (is_vmd(dev->bus))
> > > > > +		pci_write_config_byte(dev,
> > > > > PCI_INTERRUPT_LINE, 0); +}
> > > > > +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID,
> > > > > quirk_vmd_interrupt_line);    
> > > > 
> > > > A quirk for every PCI device, even on systems without VMD, seems
> > > > like kind of a clumsy way to deal with this.
> > > > 
> > > > Conceptually, I would expect a host bridge driver (VMD acts
> > > > like a host bridge in this case) to know whether it supports
> > > > INTx, and if the driver knows it doesn't support INTx or it has
> > > > no _PRT or DT description of INTx routing to use, an attempt to
> > > > configure INTx should just fail naturally.
> > > > 
> > > > I don't claim this is how host bridge drivers actually work; I
> > > > just think it's the way they *should* work.
> > > >     
> > > 
> > > Absolutely! This patch is fixing the issue in a wrong place. There
> > > are existing DT based host bridge drivers that disable INTx due to
> > > lack of hardware capability. The driver just need to nullify
> > > pci_host_bridge::map_irq callback.
> > > 
> > > - Mani
> > >   
> > For VMD as a host bridge, pci_host_bridge::map_irq is null. Even all
> > VMD rootports' PCI_INTERRUPT_LINE registers are set to 0.   
> 
> If map_irq is already NULL, then how INTx is being configured? In
> your patch description:
VMD uses MSIx.
> 
> "So initialize the PCI_INTERRUPT_LINE to 0 for these devices to
> ensure we don't try to set up a legacy irq for them."
> 
> Who is 'we'? For sure the PCI core wouldn't set INTx in your case.
> Does 'we' refer to device firmware?
> 
> >Since VMD
> > doesn't explicitly set PCI_INTERRUPT_LINE register to 0 for all of
> > its sub-devices (i.e. NVMe), if some NVMes has non-zero value set
> > for PCI_INTERRUPT_LINE (i.e. 0xff) then some software like SPDK can
> > read it and make wrong assumption about INTx support.
> >   
> 
> Is this statement is true (I haven't heard of before), then don't we
> need to set PCI_INTERRUPT_LINE to 0 for all devices irrespective of
> host bridge? 
Since VMD doesn't support legacy interrupt, BIOS sets
PCI_INTERRUPT_LINE registers to 0 for all of the VMD rootports but
not the NVMes'.

According to PCIe base specs, "Values in this register are
programmed by system software and are system architecture specific.
The Function itself does not use this value; rather the value in this
register is used by device drivers and operating systems."

We had an issue raised on us sometime back because some SSDs have 0xff
(i.e. Samsung) set to these registers by firmware and SPDK was reading
them when SSDs were behind VMD which led them to believe VMD had INTx
support enabled. After some testing, it made more sense to clear these
registers for all of the VMD owned devices.

> 
> > Based Bjorn's and your suggestion, it might be better if VMD sets
> > PCI_INTERRUPT_LINE register for all of its sub-devices during VMD
> > enumeration.
> >   
> 
> What about hotplug devices?
That is a good question and because of that I thought of putting the
fix in fixup.c. But I am open to your suggestion since fixup is not the
right place.

Thanks
- nirmal
> 
> - Mani
> 


