Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B6B207E46
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jun 2020 23:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390242AbgFXVPw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 17:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389905AbgFXVPw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jun 2020 17:15:52 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0953820768;
        Wed, 24 Jun 2020 21:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593033351;
        bh=NCiSl6UjdDz+uEErbk+g5RFhE1kVn04xQudcrBUevWg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jDbFC7LPnPZ/V8LUrPNVYE/lDbbFYbfcUooOECi1zMVznB3/9wllOOEoYZPunS1e1
         QefKGq75ygQpW4L8ujqjkbbrphA/1dpbl734T72n7UJPOHFH4asxRqhEHD5YN4boFd
         BIjN/ZHnyI0ATv040gg7+Pc89ser1aeTs4LHbgdE=
Date:   Wed, 24 Jun 2020 16:15:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     shyjumon.n@intel.com, rjw@rjwysocki.net, lenb@kernel.org,
        bhelgaas@google.com, dan.j.williams@intel.com, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-acpi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 1/2] PCI: Add ACPI StorageD3Enable _DSD support
Message-ID: <20200624211549.GA2586552@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612204820.20111-2-david.e.box@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 12, 2020 at 01:48:19PM -0700, David E. Box wrote:
> StorageD3Enable is a boolean property that indicates that the platform
> wants to use D3 for PCIe storage drives during suspend-to-idle. It is a
> BIOS work around that is currently in use on shipping systems like some
> Intel Comet Lake platforms. It is meant to change default driver policy for
> suspend that may cause higher power consumption.
> 
> Add the DSD property for recognition by fwnode calls and provide an
> exported symbol for device drivers to use to read the property as needed.
> 
> Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/acpi/property.c |  3 +++
>  drivers/pci/pci-acpi.c  | 59 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h     |  2 ++
>  3 files changed, 64 insertions(+)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index e601c4511a8b..c2e2ae774a19 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -45,6 +45,9 @@ static const guid_t prp_guids[] = {
>  	/* Thunderbolt GUID for WAKE_SUPPORTED: 6c501103-c189-4296-ba72-9bf5a26ebe5d */
>  	GUID_INIT(0x6c501103, 0xc189, 0x4296,
>  		  0xba, 0x72, 0x9b, 0xf5, 0xa2, 0x6e, 0xbe, 0x5d),
> +	/* Storage device needs D3 GUID: 5025030f-842f-4ab4-a561-99a5189762d0 */
> +	GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
> +		  0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
>  };
>  
>  /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index d21969fba6ab..732df524e09c 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -972,6 +972,65 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
>  	return val == 1;
>  }
>  
> +/**
> + * pci_acpi_storage_d3 - whether root port requests D3 for idle suspend
> + * @pdev: PCI device to check
> + *
> + * Returns true if the ACPI companion device contains the "StorageD3Enable"
> + * _DSD property and the value is 1. This indicates that the root port is
> + * used by a storage device and the platform is requesting D3 for the
> + * device during suspend to idle in order to support platform pm.
> + */
> +bool pci_acpi_storage_d3(struct pci_dev *dev)
> +{
> +	const struct fwnode_handle *fwnode;
> +	struct acpi_device *adev;
> +	struct pci_dev *root;
> +	acpi_handle handle;
> +	acpi_status status;
> +	bool ret = false;
> +	u8 val;
> +
> +	/*
> +	 * Look for _DSD property specifying that the storage device on
> +	 * the port must use D3 to support deep platform power savings during
> +	 * suspend-to-idle
> +	 */
> +	root = pci_find_pcie_root_port(dev);

I think this would need to be updated to apply to v5.8-rc1 after
6ae72bfa656e ("PCI: Unify pcie_find_root_port() and
pci_find_pcie_root_port()").

https://git.kernel.org/linus/6ae72bfa656e

> +	if (!root)
> +		return false;
> +
> +	adev = ACPI_COMPANION(&root->dev);
> +	if (!adev) {
> +		/*
> +		 * It is possible that the ACPI companion is not yet bound
> +		 * for the root port so look it up manually here.
> +		 */
> +		if (!adev && !pci_dev_is_added(root))
> +			adev = acpi_pci_find_companion(&root->dev);

I see that you copied this "ACPI companion not yet bound" thing from
acpi_pci_bridge_d3().  But it's ugly.

Isn't there a way we can bind the ACPI companion during normal PCI
enumeration so we don't need this exception case?

I really do not like the idea of putting this code in the PCI core
because AFAICT the PCI core can do nothing with this information.

If we could make sure during enumeration that the root port always has
an ACPI companion, this code could go to the nvme driver itself.  And
we could also clean up the ugliness in acpi_pci_bridge_d3().

Rafael, is that possible?  I don't really know how the companion
device gets set.  Maybe this is could be done somewhere around
pci_device_add()?

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
> +		ret = (val == 1);
> +
> +	acpi_bus_put_acpi_device(adev);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_acpi_storage_d3);
> +
>  static bool acpi_pci_power_manageable(struct pci_dev *dev)
>  {
>  	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 83ce1cdf5676..396fcb269a60 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2318,10 +2318,12 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
>  void
>  pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
>  bool pci_pr3_present(struct pci_dev *pdev);
> +bool pci_acpi_storage_d3(struct pci_dev *dev);
>  #else
>  static inline struct irq_domain *
>  pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
>  static inline bool pci_pr3_present(struct pci_dev *pdev) { return false; }
> +static inline bool pci_acpi_storage_d3(struct pci_dev *dev) { return false; }
>  #endif
>  
>  #ifdef CONFIG_EEH
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-nvme mailing list
> linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
