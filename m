Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5052C75D6
	for <lists+linux-pci@lfdr.de>; Sat, 28 Nov 2020 23:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387845AbgK1WY5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Nov 2020 17:24:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387837AbgK1Vqf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Nov 2020 16:46:35 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A074020857;
        Sat, 28 Nov 2020 21:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606599953;
        bh=5bQO897GCWtzWi0kmP4gvDPngkZBXj4MeZpDPJPZ96w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HGw3AiJdbZf9XG2h/WAOQHMhhrWvVn1T8cEJSkOJCmf2RYmGlONA4P/5Udcqx0+7f
         sz5+uvOE+ZyDR516fq3x/o2NNFpRHZjnKXevCT5BRm4HoAvUX1tuMwguQ0u0Wz9ufx
         t55Urtcgv4Yac4Pj9IRYBK38hSpNSQvY7XV8+0MU=
Date:   Sat, 28 Nov 2020 15:45:52 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     ashok.raj@intel.com, knsathya@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 4/5] PCI/ACPI: Centralize pcie_ports_native checking
Message-ID: <20201128214552.GA907628@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c7eb524-ff3a-d3ec-f9e6-7656e75b3437@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 25, 2020 at 07:20:53PM -0800, Kuppuswamy, Sathyanarayanan wrote:
> On 11/25/20 5:18 PM, Bjorn Helgaas wrote:
> > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > If the user booted with "pcie_ports=native", we take control of the PCIe
> > features unconditionally, regardless of what _OSC says.
> > 
> > Centralize the testing of pcie_ports_native in acpi_pci_root_create(),
> > where we interpret the _OSC results, so other places only have to check
> > host_bridge->native_X and we don't have to sprinkle tests of
> > pcie_ports_native everywhere.
> > 
> > [bhelgaas: commit log, rework OSC_PCI_EXPRESS_CONTROL_MASKS, logging]
> > Link: https://lore.kernel.org/r/bc87c9e675118960949043a832bed86bc22becbd.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >   drivers/acpi/pci_root.c           | 19 +++++++++++++++++++
> >   drivers/pci/hotplug/pciehp_core.c |  2 +-
> >   drivers/pci/pci-acpi.c            |  3 ---
> >   drivers/pci/pcie/aer.c            |  2 +-
> >   drivers/pci/pcie/portdrv_core.c   |  9 +++------
> >   5 files changed, 24 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > index 6db071038fd5..36142ed7b8f8 100644
> > --- a/drivers/acpi/pci_root.c
> > +++ b/drivers/acpi/pci_root.c
> > @@ -882,6 +882,8 @@ static void acpi_pci_root_release_info(struct pci_host_bridge *bridge)
> >   			flag = 0;	\
> >   	} while (0)
> > +#define FLAG(x)		((x) ? '+' : '-')
> > +
> >   struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
> >   				     struct acpi_pci_root_ops *ops,
> >   				     struct acpi_pci_root_info *info,
> > @@ -930,6 +932,23 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
> >   	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_LTR_CONTROL, host_bridge->native_ltr);
> >   	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_DPC_CONTROL, host_bridge->native_dpc);
> > +	if (pcie_ports_native) {
> > +		dev_info(&root->device->dev, "Taking control of PCIe-related features because \"pcie_ports=native\" specified; may conflict with firmware\n");
> > +		host_bridge->native_pcie_hotplug = 1;
> > +		host_bridge->native_aer = 1;
> > +		host_bridge->native_pme = 1;
> > +		host_bridge->native_ltr = 1;
> > +		host_bridge->native_dpc = 1;
> > +	}
> Won't it be better if its merged with above OSC_OWNER() calls? If
> pcie_ports_native is set, then above OSC_OWNER() calls for PCIe
> related features are redundant. Let me know.

Yes, I think you're right.  I think it would also be nice to know
exactly which services we're overriding _OSC for, i.e., when we turn
native_aer from 0 to 1 and so on.  If we merge this back in, we'll
have a way to keep track of those.

> > @@ -208,8 +208,7 @@ static int get_port_device_capability(struct pci_dev *dev)
> >   	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> >   	int services = 0;
> > -	if (dev->is_hotplug_bridge &&
> > -	    (pcie_ports_native || host->native_pcie_hotplug)) {
> > +	if (host->native_pcie_hotplug && dev->is_hotplug_bridge) {
> May be this reordering can be split into a different patch ?

Good point, that makes the diff a little easier to read, thanks!
