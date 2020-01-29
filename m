Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6A814CC7A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 15:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgA2ObT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 09:31:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgA2ObR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 09:31:17 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3CA320716;
        Wed, 29 Jan 2020 14:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580308276;
        bh=BDy2XckpsiwyIjp1K++dkGaIVLjtMn3ISUcR6+TLvJ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iGOEQcM+SaqL4k+Hp1FWzvZDGGt6RCtrtc6GQ3pBPYqrNVnOdiLlBhEPb1bJZxXC9
         jp9zsNdUG7kDL6viFh2jvpPEGZfZYPm2YMMqf+QLgdLPw0+5WvZ86XlM/+Ex9TBM5g
         DeAiIeXemZoUvKLIRKBRlTBvwzRaiVFSZLUy7ZEk=
Date:   Wed, 29 Jan 2020 08:31:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH v4 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Message-ID: <20200129143115.GA106689@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR02MB6336D2BDBDF1B372AB5440BEA5050@MN2PR02MB6336.namprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 29, 2020 at 11:16:47AM +0000, Bharat Kumar Gogada wrote:
> > Subject: Re: [PATCH v4 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
> > 
> > On Tue, Jan 28, 2020 at 06:14:43PM +0530, Bharat Kumar Gogada wrote:
> > > - Add support for Versal CPM as Root Port.
> > > - The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrated
> > >   block for CPM along with the integrated bridge can function
> > >   as PCIe Root Port.
> > > - CPM Versal uses GICv3 ITS feature for achieving assigning MSI/MSI-X
> > >   vectors and handling MSI/MSI-X interrupts.
> > > - Bridge error and legacy interrupts in Versal CPM are handled using
> > >   Versal CPM specific MISC interrupt line.
> > >
> > > Changes v4:
> > > - change commit subject.
> > > - Remove unnecessary comments and type cast.
> > > - Added comments for CPM block register access using readl/writel.
> > >
> > > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > > ...
> > 
> > > +static bool xilinx_cpm_pcie_valid_device(struct pci_bus *bus,
> > > +					 unsigned int devfn)
> > > +{
> > > +	struct xilinx_cpm_pcie_port *port = bus->sysdata;
> > > +
> > > +	/* Only one device down on each root port */
> > > +	if (bus->number == port->root_busno && devfn > 0)
> > > +		return false;
> > 
> > This whole *_valid_device() thing is a mess.  We shouldn't need it at all.  But if
> > we *do* need it, I don't think you should check the entire devfn because that
> > means you can't attach a multifunction device.
> > 
> > Several other drivers with similar *_valid_device() implementations check only
> > PCI_SLOT():
> > 
> >   dw_pcie_valid_device()
> >   advk_pcie_valid_device()
> >   pci_dw_valid_device()
> >   altera_pcie_valid_device()
> >   mobiveil_pcie_valid_device()
> >   rockchip_pcie_valid_device()
> > 
> > Even checking just PCI_SLOT() is problematic because I think an ARI device with
> > more than 8 functions will not work correctly.
> > 
> > What exactly happens if you omit this function, i.e., if we just go ahead and
> > attempt config accesses when the device is not present?  We
> > *should* get something like an Unsupported Request completion, and that
> > *should* be a recoverable error.  Most hardware turns this error into read data
> > of 0xffffffff.  The OS should be able to figure out that there's no device there
> > and continue with no ill effects.
> > 
> Thanks Bjorn. I did test and I do not see any issue without this. 
> Will resend patch with this change.

That's great, thanks for testing that!  I wonder how many other
drivers could just drop that code.

Bjorn
