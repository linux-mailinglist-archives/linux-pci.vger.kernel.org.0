Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3F81D78B4
	for <lists+linux-pci@lfdr.de>; Mon, 18 May 2020 14:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgERMeh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 May 2020 08:34:37 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55816 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbgERMeh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 May 2020 08:34:37 -0400
Received: from 89-64-86-21.dynamic.chello.pl (89.64.86.21) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 240662dfe3aa87da; Mon, 18 May 2020 14:34:34 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lenb@kernel.org, bhelgaas@google.com, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] pci: Add ACPI StorageD3Enable _DSD support
Date:   Mon, 18 May 2020 14:34:33 +0200
Message-ID: <1967525.XL736rHnAO@kreacher>
In-Reply-To: <20200428003214.3764-2-david.e.box@linux.intel.com>
References: <20200428003214.3764-1-david.e.box@linux.intel.com> <20200428003214.3764-2-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday, April 28, 2020 2:32:13 AM CEST David E. Box wrote:
> NVMe storage power management during suspend-to-idle, particularly on
> laptops, has been inconsistent with some devices working with D3 while
> others must rely on NVMe APST in order for power savings to be realized.
> Currently the default is to use APST unless quirked to do otherwise.
> However newer platforms, like Intel Comet Lake systems, may require NVMe
> drives to use D3 in order for the PCIe ports to be properly power managed.
> To make it easier for drivers to choose, these platforms may supply a
> special "StorageD3Enable" _DSD property under the root port that the device
> is attached to. If supplied, the driver must use D3 in order for the
> platform to realize the deepest power savings in suspend-to-idle.
> 
> Adds support for the _DSD to the pci/acpi layer.
> 
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/acpi/property.c |  3 +++
>  drivers/pci/pci-acpi.c  | 47 +++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.c       |  6 ++++++
>  drivers/pci/pci.h       |  4 ++++
>  include/linux/pci.h     |  1 +
>  5 files changed, 61 insertions(+)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index e601c4511a8b..f09375ab40e4 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -45,6 +45,9 @@ static const guid_t prp_guids[] = {
>  	/* Thunderbolt GUID for WAKE_SUPPORTED: 6c501103-c189-4296-ba72-9bf5a26ebe5d */
>  	GUID_INIT(0x6c501103, 0xc189, 0x4296,
>  		  0xba, 0x72, 0x9b, 0xf5, 0xa2, 0x6e, 0xbe, 0x5d),
> +	/* D3 Support for storage devivce: 5025030f-842f-4ab4-a561-99a5189762d0 */
> +	GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
> +		  0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
>  };
>  
>  /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index d21969fba6ab..5df249ebf022 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -972,6 +972,52 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
>  	return val == 1;
>  }
>  
> +static bool acpi_pci_storage_d3(struct pci_dev *dev)
> +{
> +	const struct fwnode_handle *fwnode;
> +	struct acpi_device *adev;
> +	struct pci_dev *root;
> +	acpi_handle handle;
> +	acpi_status status;
> +	u8 val;
> +
> +	/*
> +	 * Look for _DSD property specifying that the storage device on
> +	 * the port must use D3 to support deep platform power savings during
> +	 * suspend-to-idle
> +	 */
> +	root = pci_find_pcie_root_port(dev);
> +	if (!root)
> +		return false;
> +
> +	adev = ACPI_COMPANION(&root->dev);
> +	if (root == dev) {
> +		/*
> +		 * It is possible that the ACPI companion is not yet bound
> +		 * for the root port so look it up manually here.
> +		 */
> +		if (!adev && !pci_dev_is_added(root))
> +			adev = acpi_pci_find_companion(&root->dev);
> +	}
> +
> +	if (!adev)
> +		return false;
> +
> +	status = acpi_get_handle(adev->handle, "PXSX", &handle);
> +	if (ACPI_FAILURE(status))
> +		return false;
> +
> +	adev = acpi_bus_get_acpi_device(handle);
> +	if (!adev)
> +		return false;
> +
> +	fwnode = acpi_fwnode_handle(adev);
> +	if (!fwnode_property_read_u8(fwnode, "StorageD3Enable", &val))
> +		return val == 1;
> +
> +	return false;
> +}

Kind of orthogonal to what happens to the second patch in this series, I don't
think that the PCI changes below are all needed.

IMO it would be sufficient to export the function above, maybe as
pci_acpi_storage_d3(), to drivers, so that they can call it directly as
desired.

Since _DSD return data are not allowed by the spec to change between
subsequent invocations of it, the interested driver may call this function
once at the device init time and quirk it accordingly if needed.

Cheers!



