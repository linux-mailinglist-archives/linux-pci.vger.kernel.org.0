Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4C02C46DC
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 18:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbgKYReL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 12:34:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730455AbgKYReL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2020 12:34:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606325650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W7NiL6tAav7XnNXNaLXFHj7hlsEMUdR6HMTlgfmIVEw=;
        b=VkgdMLxnXLaaqQulPsvSYm/45jjh5fDQs2CjGPEKV9f5+7na2bV27Z+sL476eHS9+8O9is
        KZt1XSSUWdpjy5jTA98fpOnoYowJtLhNC3uwVYtEBLsN7uGxFqCB+6bq8ZzOjnDjUWjz1Y
        cukBgFGFguSdwCtjFYioajw8vXhj/Cg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-1C9VISFDPn2wbfOdvO5isQ-1; Wed, 25 Nov 2020 12:34:08 -0500
X-MC-Unique: 1C9VISFDPn2wbfOdvO5isQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B608D185E489;
        Wed, 25 Nov 2020 17:34:06 +0000 (UTC)
Received: from w520.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0DDCE5C1A3;
        Wed, 25 Nov 2020 17:34:05 +0000 (UTC)
Date:   Wed, 25 Nov 2020 10:34:05 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "helgaas@kernel.org" <helgaas@kernel.org>,
        "Kalakota, SushmaX" <sushmax.kalakota@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Patel, Nirmal" <nirmal.patel@intel.com>
Subject: Re: [PATCH 2/5] PCI: Add a reset quirk for VMD
Message-ID: <20201125103405.19f792e1@w520.home>
In-Reply-To: <57d28cdc12734c38b09f18ccd493a4b60b1e9031.camel@intel.com>
References: <20201124214020.GA590491@bjorn-Precision-5520>
        <57d28cdc12734c38b09f18ccd493a4b60b1e9031.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 25 Nov 2020 17:22:05 +0000
"Derrick, Jonathan" <jonathan.derrick@intel.com> wrote:

> Hi Bjorn,
> 
> On Tue, 2020-11-24 at 15:40 -0600, Bjorn Helgaas wrote:
> > [+cc Alex]
> > 
> > On Fri, Nov 20, 2020 at 03:51:41PM -0700, Jon Derrick wrote:  
> > > VMD domains should be reset in-between special attachment such as VFIO
> > > users. VMD does not offer a reset, however the subdevice domain itself
> > > can be reset starting at the Root Bus. Add a Secondary Bus Reset on each
> > > of the individual root port devices immediately downstream of the VMD
> > > root bus.
> > > 
> > > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > > ---
> > >  drivers/pci/quirks.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 48 insertions(+)
> > > 
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index f70692a..ee58b51 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -3744,6 +3744,49 @@ static int reset_ivb_igd(struct pci_dev *dev, int probe)
> > >  	return 0;
> > >  }
> > >  
> > > +/* Issues SBR to VMD domain to clear PCI configuration */
> > > +static int reset_vmd_sbr(struct pci_dev *dev, int probe)
> > > +{
> > > +	char __iomem *cfgbar, *base;
> > > +	int rp;
> > > +	u16 ctl;
> > > +
> > > +	if (probe)
> > > +		return 0;
> > > +
> > > +	if (dev->dev.driver)
> > > +		return 0;  
> > 
> > I guess "dev" here is the VMD endpoint?  And if the vmd.c driver is
> > bound to it, you return success without doing anything?
> > 
> > If there's no driver for the VMD device, who is trying to reset it?
> > 
> > I guess I don't quite understand how VMD works.  I would have thought
> > that if vmd.c isn't bound to the VMD device, the devices behind the
> > VMD would be inaccessible and there'd be no point in a reset.  
> 
> This is basically the idea behind this reset - allow the user to reset
> VMD if there is no driver bound to it, but prevent the reset from
> deenumerating the domain if there is a driver.
> 
> If this is an unusual/unexpected use case, we can drop it.

I don't understand how this improves the vfio use case as claimed in
the commit log, are you expecting the device to be unbound from all
drivers and reset via pci-sysfs between uses?  vfio would not be able
to perform the reset itself with this behavior, including between
resets of a VM or between separate users without external manual
unbinding and reset.

   
> > > +	cfgbar = pci_iomap(dev, 0, 0);
> > > +	if (!cfgbar)
> > > +		return -ENOMEM;
> > > +
> > > +	/*
> > > +	 * Subdevice config space is mapped linearly using 4k config space
> > > +	 * increments. Use increments of 0x8000 to locate root port devices.
> > > +	 */
> > > +	for (rp = 0; rp < 4; rp++) {
> > > +		base = cfgbar + rp * 0x8000;  
> > 
> > I really don't like this part -- iomapping BAR 0 (apparently
> > VMD_CFGBAR), and making up the ECAM-ish addresses and basically
> > open-coding ECAM accesses below.  I guess this assumes Root Ports are
> > only on functions .0, .2, .4, .6?  
> 
> The Root Ports are Devices xx:00.0, xx:01.0, xx:02.0, and xx:03.0
> (corresponding to PCIE_EXT_SLOT_SHIFT = 15)
> 
> 
> > 
> > Is it all open-coded here because this reset path is only of interest
> > when vmd.c is NOT bound to the the VMD device, so you can't use
> > vmd->cfgbar, etc?  
> 
> That's correct, but as mentioned above it might be an unusual code path
> so is not as important as the reset within the driver in patch 1/5.
> 
> > 
> > What about the case when vmd.c IS bound?  We don't do anything here,
> > so does that mean we instead use the usual case of asserting SBR on
> > the Root Ports behind the VMD?  
> 
> It uses the standard Linux reset code paths for Root Port devices
> 
> >   
> > > +		if (readl(base + PCI_COMMAND) == 0xFFFFFFFF)
> > > +			continue;
> > > +
> > > +		/* pci_reset_secondary_bus() */
> > > +		ctl = readw(base + PCI_BRIDGE_CONTROL);
> > > +		ctl |= PCI_BRIDGE_CTL_BUS_RESET;
> > > +		writew(ctl, base + PCI_BRIDGE_CONTROL);
> > > +		readw(base + PCI_BRIDGE_CONTROL);
> > > +		msleep(2);
> > > +
> > > +		ctl &= ~PCI_BRIDGE_CTL_BUS_RESET;
> > > +		writew(ctl, base + PCI_BRIDGE_CONTROL);
> > > +		readw(base + PCI_BRIDGE_CONTROL);

We're performing an SBR of the internal root ports here, is the config
space of the affected endpoints handled via save+restore of the code
that calls this?  I'm a little rusty on VMD again.  Thanks,

Alex


> > > +	}
> > > +
> > > +	ssleep(1);
> > > +	pci_iounmap(dev, cfgbar);
> > > +	return 0;
> > > +}
> > > +
> > >  /* Device-specific reset method for Chelsio T4-based adapters */
> > >  static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
> > >  {
> > > @@ -3919,6 +3962,11 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
> > >  		reset_ivb_igd },
> > >  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M2_VGA,
> > >  		reset_ivb_igd },
> > > +	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D, reset_vmd_sbr },
> > > +	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0, reset_vmd_sbr },
> > > +	{ PCI_VENDOR_ID_INTEL, 0x467f, reset_vmd_sbr },
> > > +	{ PCI_VENDOR_ID_INTEL, 0x4c3d, reset_vmd_sbr },
> > > +	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B, reset_vmd_sbr },
> > >  	{ PCI_VENDOR_ID_SAMSUNG, 0xa804, nvme_disable_and_flr },
> > >  	{ PCI_VENDOR_ID_INTEL, 0x0953, delay_250ms_after_flr },
> > >  	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
> > > -- 
> > > 1.8.3.1
> > >   

