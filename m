Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1691D9D91
	for <lists+linux-pci@lfdr.de>; Tue, 19 May 2020 19:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgESRK5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 May 2020 13:10:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:52187 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbgESRK5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 May 2020 13:10:57 -0400
IronPort-SDR: mUdAwHwjaLqzVHZvw2xYplJCqd4YFkaQJFZJoEiJLoxkQd/1UTfAk50jEODfJCKf/iPmaNJGC0
 k43Gg1CoxXeA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 10:10:56 -0700
IronPort-SDR: YEfPeTPLf3xKET0vqRozbESjJnBS3MFTOVE2oJhdp6jdCl/X6iv5Zo3fjjH1ObYkx3Y+d4KkDk
 1MFbd3hx6BeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; 
   d="scan'208";a="343201225"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 19 May 2020 10:10:55 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.7.201.137])
        by linux.intel.com (Postfix) with ESMTP id 0C8375803C5;
        Tue, 19 May 2020 10:10:54 -0700 (PDT)
Message-ID: <8003f408ec9bcf0ea2522122ba4051ffb571e1b7.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] pci: Add ACPI StorageD3Enable _DSD support
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     lenb@kernel.org, bhelgaas@google.com, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 May 2020 10:10:53 -0700
In-Reply-To: <1967525.XL736rHnAO@kreacher>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
         <20200428003214.3764-2-david.e.box@linux.intel.com>
         <1967525.XL736rHnAO@kreacher>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2020-05-18 at 14:34 +0200, Rafael J. Wysocki wrote:
> On Tuesday, April 28, 2020 2:32:13 AM CEST David E. Box wrote:
> > NVMe storage power management during suspend-to-idle, particularly
> > on
> > laptops, has been inconsistent with some devices working with D3
> > while
> > others must rely on NVMe APST in order for power savings to be
> > realized.
> > Currently the default is to use APST unless quirked to do
> > otherwise.
> > However newer platforms, like Intel Comet Lake systems, may require
> > NVMe
> > drives to use D3 in order for the PCIe ports to be properly power
> > managed.
> > To make it easier for drivers to choose, these platforms may supply
> > a
> > special "StorageD3Enable" _DSD property under the root port that
> > the device
> > is attached to. If supplied, the driver must use D3 in order for
> > the
> > platform to realize the deepest power savings in suspend-to-idle.
> > 
> > Adds support for the _DSD to the pci/acpi layer.
> > 
> > Acked-by: Dan Williams <dan.j.williams@intel.com>
> > Link: 
> > https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> >  drivers/acpi/property.c |  3 +++
> >  drivers/pci/pci-acpi.c  | 47
> > +++++++++++++++++++++++++++++++++++++++++
> >  drivers/pci/pci.c       |  6 ++++++
> >  drivers/pci/pci.h       |  4 ++++
> >  include/linux/pci.h     |  1 +
> >  5 files changed, 61 insertions(+)
> > 
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index e601c4511a8b..f09375ab40e4 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -45,6 +45,9 @@ static const guid_t prp_guids[] = {
> >  	/* Thunderbolt GUID for WAKE_SUPPORTED: 6c501103-c189-4296-
> > ba72-9bf5a26ebe5d */
> >  	GUID_INIT(0x6c501103, 0xc189, 0x4296,
> >  		  0xba, 0x72, 0x9b, 0xf5, 0xa2, 0x6e, 0xbe, 0x5d),
> > +	/* D3 Support for storage devivce: 5025030f-842f-4ab4-a561-
> > 99a5189762d0 */
> > +	GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
> > +		  0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
> >  };
> >  
> >  /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-
> > 1319f52a966b */
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index d21969fba6ab..5df249ebf022 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -972,6 +972,52 @@ static bool acpi_pci_bridge_d3(struct pci_dev
> > *dev)
> >  	return val == 1;
> >  }
> >  
> > +static bool acpi_pci_storage_d3(struct pci_dev *dev)
> > +{
> > +	const struct fwnode_handle *fwnode;
> > +	struct acpi_device *adev;
> > +	struct pci_dev *root;
> > +	acpi_handle handle;
> > +	acpi_status status;
> > +	u8 val;
> > +
> > +	/*
> > +	 * Look for _DSD property specifying that the storage device on
> > +	 * the port must use D3 to support deep platform power savings
> > during
> > +	 * suspend-to-idle
> > +	 */
> > +	root = pci_find_pcie_root_port(dev);
> > +	if (!root)
> > +		return false;
> > +
> > +	adev = ACPI_COMPANION(&root->dev);
> > +	if (root == dev) {
> > +		/*
> > +		 * It is possible that the ACPI companion is not yet
> > bound
> > +		 * for the root port so look it up manually here.
> > +		 */
> > +		if (!adev && !pci_dev_is_added(root))
> > +			adev = acpi_pci_find_companion(&root->dev);
> > +	}
> > +
> > +	if (!adev)
> > +		return false;
> > +
> > +	status = acpi_get_handle(adev->handle, "PXSX", &handle);
> > +	if (ACPI_FAILURE(status))
> > +		return false;
> > +
> > +	adev = acpi_bus_get_acpi_device(handle);
> > +	if (!adev)
> > +		return false;
> > +
> > +	fwnode = acpi_fwnode_handle(adev);
> > +	if (!fwnode_property_read_u8(fwnode, "StorageD3Enable", &val))
> > +		return val == 1;
> > +
> > +	return false;
> > +}
> 
> Kind of orthogonal to what happens to the second patch in this
> series, I don't
> think that the PCI changes below are all needed.
> 
> IMO it would be sufficient to export the function above, maybe as
> pci_acpi_storage_d3(), to drivers, so that they can call it directly
> as
> desired.
> 
> Since _DSD return data are not allowed by the spec to change between
> subsequent invocations of it, the interested driver may call this
> function
> once at the device init time and quirk it accordingly if needed.

Yeah this is better. Will do. Thanks.

