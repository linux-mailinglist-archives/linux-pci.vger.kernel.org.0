Return-Path: <linux-pci+bounces-361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4298013D9
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 21:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB481C20A1B
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 20:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4221451C36;
	Fri,  1 Dec 2023 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjsiliA/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF4120B05;
	Fri,  1 Dec 2023 20:02:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FEEC433C7;
	Fri,  1 Dec 2023 20:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701460931;
	bh=qRbu/W2TumRsl/oNyGI05bUuXDvIF9Q37QGkI1eZBN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hjsiliA/68HJEboavrtb6w1cOJu0P98HfHynHpjDhmEjdZb+f0RGxxsQ7x0wbqvE0
	 meHCBGCsNGVvTbh0B2NWh8PIytYQ5ooDuvl4WylzETqHQFZL5F7HKjZtmhfZp44Qmh
	 4qNSpTOFJapi9bt3ny9rC9dT/HTVXt+QV5L6jEoXAf83AvhUGcWldq/uOHvgIMX5t6
	 w/dA/c5Qak/gEtIAZ27gsm6VkFScCJ8Z36tgijSSyLD6pM1Jt9EJSAo+rHQbmn59qN
	 1RifoR7b8Tq8rsum0D6rPQV8xmICX6DGthLUqqW0z87+D5zupKG9thGOhMAg0E5R0v
	 mvFTzjrknBHOA==
Date: Fri, 1 Dec 2023 14:02:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: wangdong28 <wangdong202303@163.com>
Cc: nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, rafael@kernel.org, mingo@redhat.com,
	bp@alien8.de, tglx@linutronix.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, lenb@kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, ahuang12@lenovo.com,
	Dong Wang <wangdong28@lenovo.com>
Subject: Re: [PATCH v2] PCI/ACPI: Add extra slot register check for non-ACPI
 device
Message-ID: <20231201200209.GA521895@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701174316-14149-1-git-send-email-wangdong202303@163.com>

On Tue, Nov 28, 2023 at 08:25:16PM +0800, wangdong28 wrote:
> From: Dong Wang <wangdong28@lenovo.com>
> 
> When enabling VMD function in UEFI setup, the physical slot of the M.2
> NVMe device connected to the VMD device cannot be detected. Here is
> the result from lspci ("Physical Slot" field is NOT shown):

Apparently you're referring to the Physical Slot Number in the Slot
Capabilities register of a VMD Root Port?  That would not be related
to the NVMe device or whatever is *connected* to that Root Port.  It's
important to use the specific names to understand what's happening
here.

>  10001:01:00.0 Non-Volatile memory controller: Intel Corporation NVMe
>  Datacenter SSD [3DNAND, Beta Rock Controller] (prog-if 02 [NVM Express])
>    Subsystem: Intel Corporation NVMe Datacenter SSD [3DNAND] SE M.2 (P4511)
> 
> Generally, the physical slot (/sys/bus/pci/slots) will be created via
> either ACPI walking path during kernel init or hotplug path:
> 
> ACPI walking path:
>   pcibios_add_bus
>     acpi_pci_add_bus
>       acpi_pci_slot_enumerate
>         acpi_walk_namespace
>           register_slot
>             pci_create_slot

IIUC this path registers the slot with a slot number from the ACPI
_SUN method (register_slot() calls check_slot() to evaluate _SUN).

> hotplug path:
>   __pci_hp_initialize
>     pci_create_slot

IIUC this path registers the slot with a slot number from
PCI_EXP_SLTCAP_PSN (see init_slot() in pciehp).

> [M.2 NVMe Device]
> A. VMD disabled
> When VMD is disabled, NVMe will be discovered during bus scanning and
> recognized as acpi device. In this case, the physical slot is created
> via the ACPI walking path.

s/acpi device/ACPI device/

> B. VMD enabled
> vmd_enable_domain() invokes pcibios_add_bus(). This means that it goes
> through the ACPI walking path. However, acpi_pci_add_bus() returns
> directly becase the statment "!ACPI_HANDLE(bus->bridge)" is true.
> See the following code snippet:

s/becase/because/
s/statment/statement/

>   void acpi_pci_add_bus(struct pci_bus *bus)
>   {
>       ...
>       if (acpi_pci_disabled || !bus->bridge || !ACPI_HANDLE(bus->bridge))
> 		return;
>       ...
>   }
> 
> Since VMD creates its own root bus and devices of VMD are attached to
> the bus, those devices are non-ACPI devices. That's why
> "!ACPI_HANDLE(bus->bridge)" returns true.
> 
> In addition, M.2 NVMe devices does not have the hotplug capability.
> Here is the quote from PCI Express M.2 Specification (Revision 5.0,
> Version 1.0):
>
>   CAUTION: M.2 Add-in Cards are not designed or intended to support
>   Hot-Swap or Hot-Plug connections. Performing Hot-Swap or Hot-Plug
>   may pose danger to the M.2 Add-in Card, to the system Platform,
>   and to the person performing this act.

Why do we care about hotplug?  I don't think the Physical Slot Number
depends on hotplug support.

But it does look like we don't look at PCI_EXP_SLTCAP_PSN except in
pciehp, so if a slot doesn't support hotplug, I guess we probably
don't expose the slot in /sys/bus/pci/slots/.  I dunno whether that's
the right thing or not.

I can see that it might be useful to know what physical slot a device
is in even if the slot doesn't support hotplug.  And it seems that's
what you want to do here?  You want to expose the "slot" number of a
particular M.2 connector, even though the socket doesn't support
hotplug?

> M.2 NVMe devices (non-ACPI devices and no hotplug capability) connected
> to the VMD device cannot meet the above-mentioned paths. The corresponding
> slot info of the M.2 NVMe controller cannot be created in
> /sys/bus/pci/slots.
>
> Fix this issue by checking the available physical slot number in
> slot capabilities register. If the physical slot number is available,
> create the slot info accordingly. The following lspci output shows the
> available slot info with applying this patch:

s/physical slot number/Physical Slot Number/
s/slot capabilities/Slot Capabilities/

Capitalize them so we know they refer specifically to things in the
PCIe spec.

>  10001:01:00.0 Non-Volatile memory controller: Intel Corporation NVMe
>  Datacenter SSD [3DNAND, Beta Rock Controller] (prog-if 02 [NVM Express])
>    Subsystem: Intel Corporation NVMe Datacenter SSD [3DNAND] SE M.2 (P4511)
>    Physical Slot: 16
> 
> [U.2 NVMe device]
> A. VMD disabled
> Same as M.2 NVMe Device case "A".
> 
> B. VMD enabled
> Same as M.2 NVMe Device case "B".
> 
> The hotplug of the U.2 device is optional (See "PCI Express SFF-8639 Module
> Specification" for detail). The U.2 NVMe controller with hotplug capability
> connected to the VMD device can meet the hotplug path, so the slot info can
> be shown correctly via the lspci utility (without this patch):
> 
>  10000:82:00.0 Non-Volatile memory controller: Intel Corporation NVMe
>  Datacenter SSD [3DNAND, Beta Rock Controller] (prog-if 02 [NVM Express])
>    Subsystem: Lenovo Thinksystem U.2 P4610 NVMe SSD
>    Physical Slot: 64
> 
> For U.2 NVMe controller without hotplug capability, this patch is needed
> to fix the missing slot info.

So it seems like the question is whether we want to expose the slot
number in *general* (not just for M.2, U.2, etc) even when the slot
does not support hotplug.  The same would apply to normal PCIe slots
in a server or desktop, where you would put a GPU, NIC, etc, etc.

M.2 is a form factor specification that really doesn't have anything
to do with the enumeration and configuration done by software.  As far
as I can tell, there's nothing special about M.2 that justifies this
patch, so while M.2 might be an *example* of a case where this is
useful, it's not the *reason* for making a change like this.

> Suggested-and-reviewed-by: Adrian Huang <ahuang12@lenovo.com>
> Signed-off-by: Dong Wang <wangdong28@lenovo.com>
> ---
> v2:
>   * Fix the build error for non-x86 arch
> 
> ---
>  arch/x86/pci/common.c  | 21 +++++++++++++++++++++
>  drivers/pci/pci-acpi.c |  9 ++++++++-
>  include/linux/pci.h    |  1 +
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index ddb7986..b657b07 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -731,4 +731,25 @@ struct pci_dev *pci_real_dma_dev(struct pci_dev *dev)
>  
>  	return dev;
>  }
> +
> +#define SLOT_NAME_SIZE  5
> +
> +void pci_check_extra_slot_register(struct pci_bus *bus)
> +{
> +	struct pci_dev *pdev = bus->self;
> +	char slot_name[SLOT_NAME_SIZE];
> +	struct pci_slot *pci_slot;
> +	u32 slot_cap, slot_nr;
> +
> +	if (!is_vmd(bus) || !pdev || pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap))
> +		return;
> +
> +	if (!(slot_cap & PCI_EXP_SLTCAP_HPC)) {
> +		slot_nr = (slot_cap & PCI_EXP_SLTCAP_PSN) >> 19;
> +		snprintf(slot_name, SLOT_NAME_SIZE, "%u", slot_nr);
> +		pci_slot = pci_create_slot(bus, 0, slot_name, NULL);
> +		if (IS_ERR(pci_slot))
> +			pr_err("pci_create_slot returned %ld\n", PTR_ERR(pci_slot));

This patch basically reads the Physical Slot Number in the Slot
Capabilities register in a case where we didn't previously do that.

I guess we're reading PCI_EXP_SLTCAP from a VMD Root Port?  And we
currently don't do that for some reason?  I assume the same exact
problem would occur if that VMD Root Port were connected to an
ordinary PCIe slot?

> +	}
> +}
>  #endif
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 0045750..e2f2ba8 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -884,6 +884,8 @@ acpi_status pci_acpi_add_pm_notifier(struct acpi_device *dev,
>  	return acpi_add_pm_notifier(dev, &pci_dev->dev, pci_acpi_wake_dev);
>  }
>  
> +void __weak pci_check_extra_slot_register(struct pci_bus *bus) { }
> +
>  /*
>   * _SxD returns the D-state with the highest power
>   * (lowest D-state number) supported in the S-state "x".
> @@ -1202,9 +1204,14 @@ void acpi_pci_add_bus(struct pci_bus *bus)
>  	union acpi_object *obj;
>  	struct pci_host_bridge *bridge;
>  
> -	if (acpi_pci_disabled || !bus->bridge || !ACPI_HANDLE(bus->bridge))
> +	if (acpi_pci_disabled || !bus->bridge)
>  		return;
>  
> +	if (!ACPI_HANDLE(bus->bridge)) {
> +		pci_check_extra_slot_register(bus);
> +		return;
> +	}
> +
>  	acpi_pci_slot_enumerate(bus);
>  	acpiphp_enumerate_slots(bus);
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 60ca768..b9bb447 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1394,6 +1394,7 @@ static inline int pci_rebar_bytes_to_size(u64 bytes)
>  bool pci_device_is_present(struct pci_dev *pdev);
>  void pci_ignore_hotplug(struct pci_dev *dev);
>  struct pci_dev *pci_real_dma_dev(struct pci_dev *dev);
> +void pci_check_extra_slot_register(struct pci_bus *bus);
>  int pci_status_get_and_clear_errors(struct pci_dev *pdev);
>  
>  int __printf(6, 7) pci_request_irq(struct pci_dev *dev, unsigned int nr,
> -- 
> 1.8.3.1
> 

