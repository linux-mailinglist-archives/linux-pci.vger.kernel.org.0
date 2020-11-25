Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E05C2C4ACA
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 23:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387438AbgKYWZL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 17:25:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:53334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729679AbgKYWZL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 17:25:11 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64E53206D9;
        Wed, 25 Nov 2020 22:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606343110;
        bh=JwS4iiMBvy8UW7/9BoV0RzEM7NAj3eXIL8p5M9E0NIQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JQ3C52Y7tC2y7YEfgP2nznaWEvKCQ8L/hB33FB7ermqbMhBMBkfEVDVayl0ahmc+Y
         Aabemp+fQZQV9l+UvTQ8EIFoYSqLoyHgBlEBKb/+zoU2FLqVNOgC8leMaBI6LbfyFk
         buLS/5nkw8+i5urxek6HzMNewYFxLKYM13J9YnQQ=
Date:   Wed, 25 Nov 2020 16:25:09 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        knsathya@kernel.org
Subject: Re: [PATCH v11 2/5] ACPI/PCI: Ignore _OSC negotiation result if
 pcie_ports_native is set.
Message-ID: <20201125222509.GA688516@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad9cd8ca-4c22-f691-b344-699d82a75872@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 25, 2020 at 02:21:49PM -0800, Kuppuswamy, Sathyanarayanan wrote:
> Hi Bjorn,
> 
> Thanks for the review.
> 
> On 11/25/20 12:12 PM, Bjorn Helgaas wrote:
> > On Mon, Oct 26, 2020 at 07:57:05PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > > pcie_ports_native is set only if user requests native handling
> > > of PCIe capabilities via pcie_port_setup command line option.
> > > User input takes precedence over _OSC based control negotiation
> > > result. So consider the _OSC negotiated result only if
> > > pcie_ports_native is unset.
> > > 
> > > Also, since struct pci_host_bridge ->native_* members caches the
> > > ownership status of various PCIe capabilities, use them instead
> > > of distributed checks for pcie_ports_native.
> > > 
> > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > ---
> > >   drivers/acpi/pci_root.c           | 35 ++++++++++++++++++++++---------
> > >   drivers/pci/hotplug/pciehp_core.c |  2 +-
> > >   drivers/pci/pci-acpi.c            |  3 ---
> > >   drivers/pci/pcie/aer.c            |  2 +-
> > >   drivers/pci/pcie/portdrv_core.c   |  9 +++-----
> > >   include/linux/acpi.h              |  2 ++
> > >   6 files changed, 32 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > > index c12b5fb3e8fb..a9e6b782622d 100644
> > > --- a/drivers/acpi/pci_root.c
> > > +++ b/drivers/acpi/pci_root.c
> > > @@ -41,6 +41,12 @@ static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
> > >   				| OSC_PCI_CLOCK_PM_SUPPORT \
> > >   				| OSC_PCI_MSI_SUPPORT)
> 
> > > +
> > > +	if (pcie_ports_native) {
> > > +		decode_osc_control(root, "OS forcibly taking over",
> > > +				   OSC_PCI_EXPRESS_CONTROL_MASKS);
> > 
> > The only place OSC_PCI_EXPRESS_CONTROL_MASKS is used is right here, so
> > it's kind of pointless.
> > 
> > I think I'd rather have this:
> > 
> >    dev_info(&root->device->dev, "Ignoring PCIe-related _OSC results because \"pcie_ports=native\" specified\n");
> I was trying to keep the same print format. In pci_root.c,
> decode_os_control() is repeatedly used to print info related to
> PCIe capability ownership.
> 
> But either way is fine with me. I can use the format you mentioned.
> > 
> > 
> > followed by something like this after we're done fiddling with all the
> > host_bridge->native* bits:
> > 
> 
> >    #define FLAG(x) ((x) ? '+' : '-')
> > 
> >    dev_info(&root->device->dev, "OS native features: SHPCHotplug%c PCIeCapability%c PCIeHotplug%c PME%c AER%c DPC%c LTR%c\n",
> >             FLAG(host_bridge->native_shpc_hotplug),
> > 	   ?,
> >             FLAG(host_bridge->native_pcie_hotplug),
> > 	   ...);
> > 
> > But I don't know how to handle OSC_PCI_EXPRESS_CAPABILITY_CONTROL
> > since we don't track it the same way.  Maybe we'd have to omit it from
> > this message for now?
> I will add it in next version. But for now, its not worry about
> OSC_PCI_EXPRESS_CAPABILITY_CONTROL.

I've been fiddling with this, so let me post a v12 tonight and you can
see what you think.

> > >   	/*
> > >   	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
> 
> > > -- 
> > > 2.17.1
> > > 
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
