Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CAB26B0D9
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 00:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgIOWUr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 18:20:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbgIOWUf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Sep 2020 18:20:35 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C39E2067C;
        Tue, 15 Sep 2020 22:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600208434;
        bh=rsBNcyRTcmtG6f8LHfewk1P2V4ElS7/w5uWBvd+DKMI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=W/2H3EY/FfCvr1Zj1kbFWtglv/yGbivmeZtmbS7ZYStp8qUW18Bt06zY70F3uJBE5
         4l9sFbY9fRaxZTxE1QZI7T95FerE38QIMQs8HhirP/tME1H4OZ2VfGUR+h/LQlJAKS
         xGi0K9ShGs+H5f2Xrz6QKP1/BPaC+j/zOZor1DPU=
Date:   Tue, 15 Sep 2020 17:20:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [PATCH v8 2/5] ACPI/PCI: Ignore _OSC negotiation result if
 pcie_ports_native is set.
Message-ID: <20200915222033.GA1438273@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <badc377a-09f9-aabe-0b34-9f806da4b255@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 13, 2020 at 01:54:38PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> On 9/10/20 1:14 PM, Bjorn Helgaas wrote:
> > On Fri, Jul 24, 2020 at 08:58:53PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > 
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
> > >   drivers/acpi/pci_root.c           | 61 ++++++++++++++++++++++++++-----
> > >   drivers/pci/hotplug/pciehp_core.c |  2 +-
> > >   drivers/pci/pci-acpi.c            |  3 --
> > >   drivers/pci/pcie/aer.c            |  2 +-
> > >   drivers/pci/pcie/portdrv_core.c   |  9 ++---
> > >   5 files changed, 56 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > > index f90e841c59f5..f8981d4e044d 100644
> > > --- a/drivers/acpi/pci_root.c
> > > +++ b/drivers/acpi/pci_root.c
> > > @@ -145,6 +145,17 @@ static struct pci_osc_bit_struct pci_osc_control_bit[] = {
> > >   	{ OSC_PCI_EXPRESS_DPC_CONTROL, "DPC" },
> > >   };
> 
> > > +		else
> > > +			dev_warn(&bus->dev, "OS overrides %s firmware control",
> > > +			get_osc_desc(OSC_PCI_EXPRESS_NATIVE_HP_CONTROL));
> > 
> > There's got to be a way to write this more concisely.  Maybe something
> > like this?
> > 
> >    #define OSC_OWNER(ctrl, bit, flag) \
> >      if (!(ctrl & bit)) \
> >        flag = 0;
> > 
> >    if (pcie_ports_native)
> >      decode_osc_control(root, "OS forcibly taking over", ~0);
>
> BIT1 and BIT6 does not have PCIe dependency. And BIT7-31 are reserved.
> So we can't force all _OSC bits based on pcie_ports_native value.
> So, IM0, its better to handle PCIe features seperatly.

Yes, we may need to handle a few bits specially.  But we need to
figure out a nicer-looking way of coding this.  It's too cumbersome to
check pcie_ports_native and log a message for every _OSC bit
individually.

> >    else {
> >      ctrl = root->osc_control_set;
> >      OSC_OWNER(ctrl, OSC_PCI_EXPRESS_AER_CONTROL, host_bridge->native_aer);
> >      OSC_OWNER(ctrl, OSC_PCI_EXPRESS_PME_CONTROL, host_bridge->native_pme);
> >      ...
> >    }
> 
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
