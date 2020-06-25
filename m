Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F7420A3AD
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jun 2020 19:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406643AbgFYRHH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Jun 2020 13:07:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:62673 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404317AbgFYRHG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Jun 2020 13:07:06 -0400
IronPort-SDR: Hvotsl3EfQ6uOPWWlXVaP0UI3ufm7v8dV7VosErf4+3SJqWgLAnTtXsfeckNabLiXkFgMe8v8u
 nt3Q+CJqHSPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="125228107"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="125228107"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 10:07:05 -0700
IronPort-SDR: /GjSqtvB7JpoKmeoiKtapQriYCQHUe2yBzDZcba5ww/50F+IAnYPGmgBW839dUkOoM+97miSi5
 GMxW9WM986oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="279875278"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 25 Jun 2020 10:07:04 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id A052C5804B4;
        Thu, 25 Jun 2020 10:07:04 -0700 (PDT)
Message-ID: <caf3ac3324cc64686a88cb7bc369bcfb500c2767.camel@linux.intel.com>
Subject: Re: [PATCH V2 1/2] PCI: Add ACPI StorageD3Enable _DSD support
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     shyjumon.n@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Date:   Thu, 25 Jun 2020 10:07:04 -0700
In-Reply-To: <CAJZ5v0i8dCN=HMFk_+ZX-Wr73P6kdQBtV0i3FtrZrO9cegXsvQ@mail.gmail.com>
References: <20200612204820.20111-2-david.e.box@linux.intel.com>
         <20200624211549.GA2586552@bjorn-Precision-5520>
         <CAJZ5v0i8dCN=HMFk_+ZX-Wr73P6kdQBtV0i3FtrZrO9cegXsvQ@mail.gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2020-06-25 at 13:30 +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 24, 2020 at 11:15 PM Bjorn Helgaas <helgaas@kernel.org>
> wrote:
> > On Fri, Jun 12, 2020 at 01:48:19PM -0700, David E. Box wrote:
> > > StorageD3Enable is a boolean property that indicates that the
> > > platform
> > > wants to use D3 for PCIe storage drives during suspend-to-idle.
> > > It is a
> > > BIOS work around that is currently in use on shipping systems
> > > like some
> > > Intel Comet Lake platforms. It is meant to change default driver
> > > policy for
> > > suspend that may cause higher power consumption.
> > > 
> > > Add the DSD property for recognition by fwnode calls and provide
> > > an
> > > exported symbol for device drivers to use to read the property as
> > > needed.
> > > 
> > > Link: 
> > > https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > ---
> > >  drivers/acpi/property.c |  3 +++
> > >  drivers/pci/pci-acpi.c  | 59
> > > +++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/pci.h     |  2 ++
> > >  3 files changed, 64 insertions(+)
> > > 
> > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > index e601c4511a8b..c2e2ae774a19 100644
> > > --- a/drivers/acpi/property.c
> > > +++ b/drivers/acpi/property.c
> > > @@ -45,6 +45,9 @@ static const guid_t prp_guids[] = {
> > >       /* Thunderbolt GUID for WAKE_SUPPORTED: 6c501103-c189-4296-
> > > ba72-9bf5a26ebe5d */
> > >       GUID_INIT(0x6c501103, 0xc189, 0x4296,
> > >                 0xba, 0x72, 0x9b, 0xf5, 0xa2, 0x6e, 0xbe, 0x5d),
> > > +     /* Storage device needs D3 GUID: 5025030f-842f-4ab4-a561-
> > > 99a5189762d0 */
> > > +     GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
> > > +               0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
> > >  };
> > > 
> > >  /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-
> > > 1319f52a966b */
> > > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > > index d21969fba6ab..732df524e09c 100644
> > > --- a/drivers/pci/pci-acpi.c
> > > +++ b/drivers/pci/pci-acpi.c
> > > @@ -972,6 +972,65 @@ static bool acpi_pci_bridge_d3(struct
> > > pci_dev *dev)
> > >       return val == 1;
> > >  }
> > > 
> > > +/**
> > > + * pci_acpi_storage_d3 - whether root port requests D3 for idle
> > > suspend
> > > + * @pdev: PCI device to check
> > > + *
> > > + * Returns true if the ACPI companion device contains the
> > > "StorageD3Enable"
> > > + * _DSD property and the value is 1. This indicates that the
> > > root port is
> > > + * used by a storage device and the platform is requesting D3
> > > for the
> > > + * device during suspend to idle in order to support platform
> > > pm.
> > > + */
> > > +bool pci_acpi_storage_d3(struct pci_dev *dev)
> > > +{
> > > +     const struct fwnode_handle *fwnode;
> > > +     struct acpi_device *adev;
> > > +     struct pci_dev *root;
> > > +     acpi_handle handle;
> > > +     acpi_status status;
> > > +     bool ret = false;
> > > +     u8 val;
> > > +
> > > +     /*
> > > +      * Look for _DSD property specifying that the storage
> > > device on
> > > +      * the port must use D3 to support deep platform power
> > > savings during
> > > +      * suspend-to-idle
> > > +      */
> > > +     root = pci_find_pcie_root_port(dev);
> > 
> > I think this would need to be updated to apply to v5.8-rc1 after
> > 6ae72bfa656e ("PCI: Unify pcie_find_root_port() and
> > pci_find_pcie_root_port()").
> > 
> > https://git.kernel.org/linus/6ae72bfa656e
> > 
> > > +     if (!root)
> > > +             return false;
> > > +
> > > +     adev = ACPI_COMPANION(&root->dev);
> > > +     if (!adev) {
> > > +             /*
> > > +              * It is possible that the ACPI companion is not
> > > yet bound
> > > +              * for the root port so look it up manually here.
> > > +              */
> > > +             if (!adev && !pci_dev_is_added(root))
> > > +                     adev = acpi_pci_find_companion(&root->dev);
> > 
> > I see that you copied this "ACPI companion not yet bound" thing
> > from
> > acpi_pci_bridge_d3().  But it's ugly.
> > 
> > Isn't there a way we can bind the ACPI companion during normal PCI
> > enumeration so we don't need this exception case?
> > 
> > I really do not like the idea of putting this code in the PCI core
> > because AFAICT the PCI core can do nothing with this information.
> > 
> > If we could make sure during enumeration that the root port always
> > has
> > an ACPI companion, this code could go to the nvme driver itself.

This is fine with me if it's acceptable with the nvme maintainers.

> >   And
> > we could also clean up the ugliness in acpi_pci_bridge_d3().
> > 
> > Rafael, is that possible?  I don't really know how the companion
> > device gets set.
> 
> That's a bit convoluted.
> 
> device_add() calls device_platform_notify(), before calling
> bus_add_device().
> 
> device_platform_notify() calls acpi_platform_notify() which invokes
> acpi_device_notify() that looks for the companion via
> type->find_companion() which for PCI points to
> acpi_pci_find_companion().  If found, the companion is attached to
> the
> dev structure as a physical_node, via acpi_bind_one().
> 
> So by the time bus_probe_device() runs, the companion should be there
> already - if it is there at all.
> 
> The parent ACPI companion should be present when the child is probing
> too, as per the above.
> 
> > Maybe this is could be done somewhere around pci_device_add()?
> 
> It is done in there.
> 
> It is not necessary to call acpi_pci_find_companion() from
> pci_acpi_storage_d3() as long as that function is required to be
> called by the target device's driver probe or later.

Thanks for the clarification. Since this would get called at driver
probe this bit of code is not needed.

David

