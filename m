Return-Path: <linux-pci+bounces-10810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4943B93CA25
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 23:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743CE1C21256
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 21:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8736487AE;
	Thu, 25 Jul 2024 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZP8t5sE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2421C6BE
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721942527; cv=none; b=OtIzSf511f5ySUdXcsvPxh1s5vC3fzM9cY/AMldzRzemvZPCHbMjSk1hNnWNzTwmOLJ2eBhoxsj0aJ7HhPvp19qqKGFH19aaWe/dymbtsFUcmoN7cmFakiXEODYKYUD5wNSfe11L+N1aX4WmdoEmty1MC7+wlK8Jm2ak9N4XTK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721942527; c=relaxed/simple;
	bh=4ZPAI+qK2UTbWYxSAFqkMimeCmRDM8QaR/6OYTx54JA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKtSGM8VQF9/oZO5NCf8rPqeQrmZzVlLyyJtcArHyxOHr8chy9KotBPa3BkTfu+m3c3RFcJPwgW+8FY7Mbz4lTLCu10MABsurYyWZ/tFv4zSsTTrEsKYlg1337+NVwu5DGzTCqUobDSrkZlNYbBepjy8GVxp/0DChSwznUkMW1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZP8t5sE; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721942526; x=1753478526;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4ZPAI+qK2UTbWYxSAFqkMimeCmRDM8QaR/6OYTx54JA=;
  b=lZP8t5sERXH+JrBfZTc/neyoW7mylNIT29Fyl8TkUSCshA6SGxl+08HE
   VpV41RYEour6TyzE4iD8YZePMgyuBf6EQz6Pysrjdnq9m0QNS0SRWDBrz
   LHZLde3aJ9R1JqA3vO6JP8EpsGuVUuexOlgp5/ooXUstqtDJKEt7pdTdE
   Xma0MGdb7xp7lI2BYPPgcV5ErDOCWF2Fd6sJiMG60vZAwAOtWh8oJzKny
   BgQpC4iSeWF+H/8R+we40DBlBLTV5VZw1Asnpn5pHCQegpi8f/QLoINzB
   wWaquosrY5IJcN9qhhDPEoLi0IgEbi5YOH9j4rCzrOZotmO8uu1Pr+jBE
   A==;
X-CSE-ConnectionGUID: 30DiQ3cgRMafty6WYZ3qrQ==
X-CSE-MsgGUID: gJdU8VQEQmaYDiBObnX0PQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19562493"
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="19562493"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 14:22:06 -0700
X-CSE-ConnectionGUID: j7bPsQUTQq6EhHuWCPclcA==
X-CSE-MsgGUID: DnfF5ti4SHCw3KMeZYitxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="57855006"
Received: from unknown (HELO localhost) ([10.2.132.131])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 14:22:05 -0700
Date: Thu, 25 Jul 2024 14:22:03 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 paul.m.stillwell.jr@intel.com, Jim Harris <james.r.harris@intel.com>
Subject: Re: [PATCH] PCI: fixup PCI_INTERRUPT_LINE for VMD downstream
 devices
Message-ID: <20240725142203.0000335d@linux.intel.com>
In-Reply-To: <20240725041013.GB2317@thinkpad>
References: <20240724170040.5193-1-nirmal.patel@linux.intel.com>
	<20240724191030.GA806685@bhelgaas>
	<20240725041013.GB2317@thinkpad>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
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

Thanks for the response and suggestion. I will make adjustments in VMD
driver code.

-nirmal

