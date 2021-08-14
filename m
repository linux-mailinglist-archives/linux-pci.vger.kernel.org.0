Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99023EC027
	for <lists+linux-pci@lfdr.de>; Sat, 14 Aug 2021 06:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbhHNELR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Aug 2021 00:11:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhHNELR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 14 Aug 2021 00:11:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7705D60F9E;
        Sat, 14 Aug 2021 04:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628914249;
        bh=W531wcBDCphnO0AKoG3om/WSDwZu3f3Xp80WMcYdRxo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XZeg82UaKPxIIAlhFITb8QZM3IR1b/2RwZZ7Q3cHUCWKGdD6bQfhJeFSUjaHAayc8
         GzxwfFvJPvaNiHP/UMrs7W8OnGUEMeF1D/p3KMq6rQpKHMbZXBNufzBVkKsIh8ZARI
         MrECVbCKqrvEDHF2oRVMY9qe0j40Ad93n0melzBj+qq+rmCp0bUyyOyexhWAW+d7iL
         1FimLyzFE0ix5xmjXbLPCth17Y2DlRv+8Y2jDZP1UbWnPYyPIrotj9jNm0qetCdpb5
         l5ivlEDegEYX5OfdtyYpSbiVvf8YdfZcmEEeBeo6Dkge9qeDXxyb1b8d5fPnRXa+qr
         kbEDyzB0Vw+aQ==
Date:   Fri, 13 Aug 2021 23:10:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shanker R Donthineni <sdonthineni@nvidia.com>
Cc:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v15 7/9] PCI: Setup ACPI fwnode early and at the same
 time with OF
Message-ID: <20210814041048.GA2765970@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ed12600-a6d4-f6f1-6250-a8ff9a3625a6@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 13, 2021 at 10:35:46PM -0500, Shanker R Donthineni wrote:
> Hi Bjorn,
> 
> On 8/13/21 6:04 PM, Bjorn Helgaas wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > [+cc Ben, Mika]
> >
> > On Thu, Aug 05, 2021 at 09:59:15PM +0530, Amey Narkhede wrote:
> >> From: Shanker Donthineni <sdonthineni@nvidia.com>
> >>
> >> The pci_dev objects are created through two mechanisms 1) during PCI
> >> bus scan and 2) from I/O Virtualization. The fwnode in pci_dev object
> >> is being set at different places depends on the type of firmware used,
> >> device creation mechanism, and acpi_pci_bridge_d3().
> >>
> >> The software features which have a dependency on ACPI fwnode properties
> >> and need to be handled before device_add() will not work. One use case,
> >> the software has to check the existence of _RST method to support ACPI
> >> based reset method.
> >>
> >> This patch does the two changes in order to provide fwnode consistently.
> >>  - Set ACPI and OF fwnodes from pci_setup_device().
> >>  - Remove pci_set_acpi_fwnode() in acpi_pci_bridge_d3().
> >>
> >> After this patch, ACPI/OF firmware properties are visible at the same
> >> time during the early stage of pci_dev setup. And also call sites should
> >> be able to use firmware agnostic functions device_property_xxx() for the
> >> early PCI quirks in the future.
> >>
> >> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> >> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> >> ---
> >>  drivers/pci/pci-acpi.c | 1 -
> >>  drivers/pci/probe.c    | 7 ++++---
> >>  2 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> >> index eaddbf701759..dae021322b3f 100644
> >> --- a/drivers/pci/pci-acpi.c
> >> +++ b/drivers/pci/pci-acpi.c
> >> @@ -952,7 +952,6 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
> >>               return false;
> >>
> >>       /* Assume D3 support if the bridge is power-manageable by ACPI. */
> >> -     pci_set_acpi_fwnode(dev);
> >>       adev = ACPI_COMPANION(&dev->dev);
> > I *think* the Root Port code farther down in this function is also now
> > unnecessary:
> >
> >   acpi_pci_bridge_d3(...)
> >   {
> >     ...
> >     root = pcie_find_root_port(dev);
> >     adev = ACPI_COMPANION(&root->dev);
> >     if (root == dev) {
> >       /*
> >        * It is possible that the ACPI companion is not yet bound
> >        * for the root port so look it up manually here.
> >        */
> >       if (!adev && !pci_dev_is_added(root))
> >         adev = acpi_pci_find_companion(&root->dev);
> >     }
> >
> > Since we're now setting the ACPI_COMPANION for every pci_dev long
> > before we get here, I think this could now be simplified to something
> > like this:
> >
> >   acpi_pci_bridge_d3(...)
> >   {
> >     if (!dev->is_hotplug_bridge)
> >       return false;
> >
> >     adev = ACPI_COMPANION(&dev->dev);
> >     if (adev && acpi_device_power_manageable(adev))
> >       return true;
> >
> >     root = pcie_find_root_port(dev);
> >     if (!root)
> >       return false;
> >
> >     adev = ACPI_COMPANION(&root->dev);
> >     if (!adev)
> >       return false;
> >
> >     rc = acpi_dev_get_property(dev, "HotPlugSupportInD3",
> >                                ACPI_TYPE_INTEGER, &val);
> >     if (rc < 0)
> >       return false;
> >
> >     return val == 1;
> >   }
> 
> Agree, thanks for your suggestion. Yes, it can be simplified too.
> Can I do something like this using the unified device property API?
> 
> static bool acpi_pci_bridge_d3(struct pci_dev *dev)
> {
>         struct acpi_device *adev;
>         struct pci_dev *root;
>         u8 val;
> 
>         if (!dev->is_hotplug_bridge)
>                 return false;
> 
>         adev = ACPI_COMPANION(&dev->dev);
>         if (adev && acpi_device_power_manageable(adev))
>                 return true;
> 
>         root = pcie_find_root_port(dev);
>         if (!root)
>                 return false;
> 
>         if (device_property_read_u8(&root->dev, "HotPlugSupportInD3", &val))
>                 return false;

I guess that might be OK.

TBH I don't really like the device_property_read_u8() thing because
(1) we know this is an ACPI property and I don't see a reason to use
an "generic" interface that doesn't buy us anything, and (2) the
connection to the source of the data (a _DSD method) is really, really
hard to find.

Admittedly, it's still pretty hard to connect acpi_dev_get_property()
with "_DSD".  The only real clue is the comment about "Look for a
special _DSD property ..."

>         return val == 1;
> }
> 
> > acpi_pci_bridge_d3() was added by 26ad34d510a8 ("PCI / ACPI: Whitelist
> > D3 for more PCIe hotplug ports") [1], so I cc'd Mika in case he has
> > any comment.
> >
> >>       if (adev && acpi_device_power_manageable(adev))
> >> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> >> index 379e85037d9b..15a6975d3757 100644
> >> --- a/drivers/pci/probe.c
> >> +++ b/drivers/pci/probe.c
> >> @@ -1789,6 +1789,9 @@ int pci_setup_device(struct pci_dev *dev)
> >>       dev->error_state = pci_channel_io_normal;
> >>       set_pcie_port_type(dev);
> >>
> >> +     pci_set_of_node(dev);
> >> +     pci_set_acpi_fwnode(dev);
> > Is there a reason why you moved pci_set_of_node() from
> > pci_scan_device() to here?  I think it's a good change; I'm just
> > curious if you tripped over something that required it.
> 
> There is no specific reason and not required but setting both the fwnodes
> at the same time improves the code readability and provides consistent
> device properties for callers.

Sounds good.

Bjorn
