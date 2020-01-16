Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E409613FC86
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2020 23:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388736AbgAPW60 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jan 2020 17:58:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:52766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729567AbgAPW6Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Jan 2020 17:58:25 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0BF62072B;
        Thu, 16 Jan 2020 22:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579215504;
        bh=GZpXWSV3Jz5PrOYP7iVzszWgvE83teU2nHv1ScuQsSY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hyyPuyZe+SW8K62f5jp90jiniM2d1iZiC0u98/q3+BQRwiZSZAcKgxGHnJpk5P7OQ
         +hYsFofh97sK0y3nW0MA5EtVON1b8tI99iJgM/z7lVVxKFol3cOXroyobQCXPt2g2/
         gOKQruVksF4UplvmNij2ozi5uOZX6VDQrRjx61y0=
Date:   Thu, 16 Jan 2020 16:58:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Huong Nguyen <huong.nguyen@dell.com>,
        Austin Bolen <Austin.Bolen@dell.com>
Subject: Re: [PATCH v12 8/8] PCI/ACPI: Enable EDR support
Message-ID: <20200116225822.GA219420@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0723444f-6014-3e75-8116-f052f9a9cb24@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 16, 2020 at 02:24:10PM -0800, Kuppuswamy Sathyanarayanan wrote:
> 
> On 1/16/20 2:10 PM, Bjorn Helgaas wrote:
> > On Sun, Jan 12, 2020 at 02:44:02PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > 
> > > As per PCI firmware specification r3.2 Downstream Port Containment
> > > Related Enhancements ECN, sec 4.5.1, OS must implement following steps
> > > to enable/use EDR feature.
> > > 
> > > 1. OS can use bit 7 of _OSC Control Field to negotiate control over
> > > Downstream Port Containment (DPC) configuration of PCIe port. After _OSC
> > > negotiation, firmware will Set this bit to grant OS control over PCIe
> > > DPC configuration and Clear it if this feature was requested and denied,
> > > or was not requested.
> > > 
> > > 2. Also, if OS supports EDR, it should expose its support to BIOS by
> > > setting bit 7 of _OSC Support Field. And if OS sets bit 7 of _OSC
> > > Control Field it must also expose support for EDR by setting bit 7 of
> > > _OSC Support Field.
> > > 
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > Cc: Len Brown <lenb@kernel.org>
> > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > Acked-by: Keith Busch <keith.busch@intel.com>
> > > Tested-by: Huong Nguyen <huong.nguyen@dell.com>
> > > Tested-by: Austin Bolen <Austin.Bolen@dell.com>
> > > ---
> > >   drivers/acpi/pci_root.c         | 9 +++++++++
> > >   drivers/pci/pcie/portdrv_core.c | 7 +++++--
> > >   drivers/pci/probe.c             | 1 +
> > >   include/linux/acpi.h            | 6 ++++--
> > >   include/linux/pci.h             | 3 ++-
> > >   5 files changed, 21 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > > index d1e666ef3fcc..134e20474dfd 100644
> > > --- a/drivers/acpi/pci_root.c
> > > +++ b/drivers/acpi/pci_root.c
> > > @@ -131,6 +131,7 @@ static struct pci_osc_bit_struct pci_osc_support_bit[] = {
> > >   	{ OSC_PCI_CLOCK_PM_SUPPORT, "ClockPM" },
> > >   	{ OSC_PCI_SEGMENT_GROUPS_SUPPORT, "Segments" },
> > >   	{ OSC_PCI_MSI_SUPPORT, "MSI" },
> > > +	{ OSC_PCI_EDR_SUPPORT, "EDR" },
> > >   	{ OSC_PCI_HPX_TYPE_3_SUPPORT, "HPX-Type3" },
> > >   };
> > > @@ -141,6 +142,7 @@ static struct pci_osc_bit_struct pci_osc_control_bit[] = {
> > >   	{ OSC_PCI_EXPRESS_AER_CONTROL, "AER" },
> > >   	{ OSC_PCI_EXPRESS_CAPABILITY_CONTROL, "PCIeCapability" },
> > >   	{ OSC_PCI_EXPRESS_LTR_CONTROL, "LTR" },
> > > +	{ OSC_PCI_EXPRESS_DPC_CONTROL, "DPC" },
> > >   };
> > >   static void decode_osc_bits(struct acpi_pci_root *root, char *msg, u32 word,
> > > @@ -440,6 +442,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
> > >   		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
> > >   	if (pci_msi_enabled())
> > >   		support |= OSC_PCI_MSI_SUPPORT;
> > > +	if (IS_ENABLED(CONFIG_PCIE_EDR))
> > > +		support |= OSC_PCI_EDR_SUPPORT;
> > >   	decode_osc_support(root, "OS supports", support);
> > >   	status = acpi_pci_osc_support(root, support);
> > > @@ -487,6 +491,9 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
> > >   			control |= OSC_PCI_EXPRESS_AER_CONTROL;
> > >   	}
> > > +	if (IS_ENABLED(CONFIG_PCIE_DPC))
> > > +		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
> > The ECN [1] says:
> > 
> >    If this bit is set by the OS, this indicates that it supports both
> >    native OS control and firmware ownership models (i.e. Error
> >    Disconnect Recover notification) of Downstream Port Containment.
> > 
> > But if CONFIG_PCIE_DPC=y and CONFIG_PCIE_EDR is not set, we will set
> > OSC_PCI_EXPRESS_DPC_CONTROL even though we don't support EDR.  That
> > doesn't seem to match what the spec says.
> Agreed.
> > 
> > I think this needs to be something like:
> > 
> >    if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
> >      control |= OSC_PCI_EXPRESS_DPC_CONTROL;
> Since CONFIG_PCIE_EDR has dependency on CONFIG_PCIE_DPC,
> I think we can just use IS_ENABLED(CONFIG_PCIE_EDR) here.
> 
> I will fix it and send an update. You want to me to send a new
> patch set of just an update to this patch ?

I'm still working through the rest of these, so I'd suggest making
this change in your local copy but waiting to send it for a few days.
Unless there's more substantial stuff to change, I can fix this
myself.

Bjorn
