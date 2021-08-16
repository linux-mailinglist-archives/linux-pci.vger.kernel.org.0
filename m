Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CE53EDC06
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 19:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhHPRIG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Aug 2021 13:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229723AbhHPRIG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Aug 2021 13:08:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 197A960560;
        Mon, 16 Aug 2021 17:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629133654;
        bh=iwH2lqpuBwaf/UO2ySl5IkevAKeWD9j2qCmbumjqwXM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=f7H2fu3llRvEeEimJRXKtXgGcBh2JhDMFxsC/8pP0ziKbTIFyE6bI0ZOY4Zs7EnpJ
         y5h2xd2MRk5dxpS9YasbkJfFzjilWLObWqbtRHNxBb/4eKbndooXRMpvjL70plE2uQ
         yv9ysyUJZzWZq/tNco0FE0JTzJIzd2W33ngUTlPSX4wfniBq9ImBGkSy/xNo1PM5po
         mNftZ7WSRmVzP5B9J/HxARikBbA4qqwGZ2jpmgr3pNRJjZDZjtxdGEkBqSi6Q04WZD
         +PLtywPF4ivnzH3R2bN5Pye1G/rBA2qEpRrQtpUq6qp4uNIdELZxbzvEOO+UrkA6ia
         KBBgP/Y15jZzQ==
Date:   Mon, 16 Aug 2021 12:07:32 -0500
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
Message-ID: <20210816170732.GA2927693@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63e0f64c-e51b-feb7-a193-c2999a280b80@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 14, 2021 at 11:16:11AM -0500, Shanker R Donthineni wrote:
> Hi Bjorn,
> 
> On 8/13/21 11:10 PM, Bjorn Helgaas wrote:
> >>>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> >>>> index eaddbf701759..dae021322b3f 100644
> >>>> --- a/drivers/pci/pci-acpi.c
> >>>> +++ b/drivers/pci/pci-acpi.c
> >>>> @@ -952,7 +952,6 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
> >>>>               return false;
> >>>>
> >>>>       /* Assume D3 support if the bridge is power-manageable by ACPI. */
> >>>> -     pci_set_acpi_fwnode(dev);
> >>>>       adev = ACPI_COMPANION(&dev->dev);
> >>> I *think* the Root Port code farther down in this function is also now
> >>> unnecessary:
> >>>
> >>>   acpi_pci_bridge_d3(...)
> >>>   {
> >>>     ...
> >>>     root = pcie_find_root_port(dev);
> >>>     adev = ACPI_COMPANION(&root->dev);
> >>>     if (root == dev) {
> >>>       /*
> >>>        * It is possible that the ACPI companion is not yet bound
> >>>        * for the root port so look it up manually here.
> >>>        */
> >>>       if (!adev && !pci_dev_is_added(root))
> >>>         adev = acpi_pci_find_companion(&root->dev);
> >>>     }
> >>>
> >>> Since we're now setting the ACPI_COMPANION for every pci_dev long
> >>> before we get here, I think this could now be simplified to something
> >>> like this:
> >>>
> >>>   acpi_pci_bridge_d3(...)
> >>>   {
> >>>     if (!dev->is_hotplug_bridge)
> >>>       return false;
> >>>
> >>>     adev = ACPI_COMPANION(&dev->dev);
> >>>     if (adev && acpi_device_power_manageable(adev))
> >>>       return true;
> >>>
> >>>     root = pcie_find_root_port(dev);
> >>>     if (!root)
> >>>       return false;
> >>>
> >>>     adev = ACPI_COMPANION(&root->dev);
> >>>     if (!adev)
> >>>       return false;
> >>>
> >>>     rc = acpi_dev_get_property(dev, "HotPlugSupportInD3",
> >>>                                ACPI_TYPE_INTEGER, &val);
> >>>     if (rc < 0)
> >>>       return false;
> >>>
> >>>     return val == 1;
> >>>   }
> >> Agree, thanks for your suggestion. Yes, it can be simplified too.
> >> Can I do something like this using the unified device property API?
> >>
> >> static bool acpi_pci_bridge_d3(struct pci_dev *dev)
> >> {
> >>         struct acpi_device *adev;
> >>         struct pci_dev *root;
> >>         u8 val;
> >>
> >>         if (!dev->is_hotplug_bridge)
> >>                 return false;
> >>
> >>         adev = ACPI_COMPANION(&dev->dev);
> >>         if (adev && acpi_device_power_manageable(adev))
> >>                 return true;
> >>
> >>         root = pcie_find_root_port(dev);
> >>         if (!root)
> >>                 return false;
> >>
> >>         if (device_property_read_u8(&root->dev, "HotPlugSupportInD3", &val))
> >>                 return false;
> > I guess that might be OK.
> >
> > TBH I don't really like the device_property_read_u8() thing because
> > (1) we know this is an ACPI property and I don't see a reason to use
> > an "generic" interface that doesn't buy us anything, and (2) the
> > connection to the source of the data (a _DSD method) is really, really
> > hard to find.
> >
> > Admittedly, it's still pretty hard to connect acpi_dev_get_property()
> > with "_DSD".  The only real clue is the comment about "Look for a
> > special _DSD property ..."
> >
> Does it satisfy you if I change the comment and still use device_property API?
> 
> static bool acpi_pci_bridge_d3(struct pci_dev *dev)
> {
>         struct pci_dev *rpdev;
>         u8 val;
> 
>         if (!dev->is_hotplug_bridge)
>                 return false;
> 
>         /* Assume D3 support if the bridge is power-manageable by ACPI. */
>         if (acpi_pci_power_manageable(dev))
>                 return true;
> 
>         /*
>          * Look for 'HotPlugSupportInD3' property for the root port and if
>          * it is set we know the hierarchy behind it supports D3 just fine.
>          */
>         rpdev = pcie_find_root_port(dev);
>         if (!rpdev)
>                 return false;
> 
>         if (device_property_read_u8(&rpdev->dev, "HotPlugSupportInD3", &val))
>                 return false;
> 
>         return val == 1;
> }
> 
> If not, I'll do changes like this.

I guess either one is fine.  But I think we should extend the comment
and commit log to make it clear that device_property_read_u8() and
acpi_dev_get_property() are ultimately looking for a _DSD.  I should
have asked for this when we merged 26ad34d510a8 ("PCI / ACPI:
Whitelist D3 for more PCIe hotplug ports") in the first place.

If we expect that power management *should* be enabled for a bridge,
and we observe that it *isn't* enabled, it is unreasonably difficult
to figure out from the code what is missing in the firmware, namely,
the _DSD laid out in the commit log for 26ad34d510a8.

> static bool acpi_pci_bridge_d3(struct pci_dev *dev)
> {
>         const union acpi_object *obj;
>         struct acpi_device *adev;
>         struct pci_dev *rpdev;
> 
> 
>         if (!dev->is_hotplug_bridge)
>                 return false;
> 
>         /* Assume D3 support if the bridge is power-manageable by ACPI. */
>         if (acpi_pci_power_manageable(dev))
>                 return true;
> 
>         /*
>          * Look for 'HotPlugSupportInD3' property for the root port and if
>          * it is set we know the hierarchy behind it supports D3 just fine.
>          */
>         rpdev = pcie_find_root_port(dev);
>         if (!rpdev)
>                 return false;
> 
>         adev = ACPI_COMPANION(&rpdev->dev);
>         if (!adev)
>                 return false;
> 
>        if (acpi_dev_get_property(adev, "HotPlugSupportInD3",
>                                    ACPI_TYPE_INTEGER, &obj) < 0)
>                 return false;
> 
>         return obj->integer.value == 1;
> }
> 
> 
