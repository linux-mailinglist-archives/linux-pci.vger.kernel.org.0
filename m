Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 128FB3BE2F
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2019 23:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfFJVQi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jun 2019 17:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728508AbfFJVQh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jun 2019 17:16:37 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B00120820;
        Mon, 10 Jun 2019 21:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560201396;
        bh=SH/as1LkXY+tDnWeZrVqWz6aIhR9+aBuyt2yrIeNugg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZudaH9naW7kscr/rzGbM8Uwk/GNARNrVOsola8L4GdK1N1dlKk1T1cIa4O6Z1TJ9D
         SCosC4dJJxtfRLJfbRQxQzwI1g0h9pD0DEt858HkoONFVgPYe+dXKJy9qymDgVGptT
         CVrkc6oFhJUK2W5Z7W0s2EXdCA1vxEM0X7F4Mj1E=
Date:   Mon, 10 Jun 2019 16:16:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
        linux-pci@vger.kernel.org, linux@endlessm.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-ide@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: Add Intel remapped NVMe device support
Message-ID: <20190610211628.GA68572@google.com>
References: <20190610074456.2761-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610074456.2761-1-drake@endlessm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Dan, Alex]

On Mon, Jun 10, 2019 at 03:44:56PM +0800, Daniel Drake wrote:
> Consumer products that are configured by default to run the Intel SATA AHCI
> controller in "RAID" or "Intel RST Premium With Intel Optane System
> Acceleration" mode are becoming increasingly prevalent.
> 
> Unde this mode, NVMe devices are remapped into the SATA device and become
> hidden from the PCI bus, which means that Linux users cannot access their
> storage devices unless they go into the firmware setup menu to revert back
> to AHCI mode - assuming such option is available. Lack of support for this
> mode is also causing complications for vendors who distribute Linux.

Ugh.  Is there a spec that details what's actually going on here?
"Remapping" doesn't describe much other than to say "something magic
is happening here."

I'm guessing this is related to these:

  bfa9cb3e110c ("ahci-remap.h: add ahci remapping definitions")
  aecec8b60422 ("ahci: warn about remapped NVMe devices")

This driver makes a lot of assumptions about how this works, e.g.,
apparently there's an AHCI BAR that covers "hidden devices" plus some
other stuff of some magic size, whatever is special about device 0,
etc, but I don't see the source of those assumptions.

Why can't we use the device in "RAID" or "Intel RST Premium With Intel
Optane System Acceleration" mode?  Why doesn't Intel make a Linux
driver that works in that mode?

What do users see in that mode, i.e., how would they recognize that
they need this patch?

I'm not really keen on the precedent this sets about pretending things
are PCI when they're not.  This seems like a bit of a kludge that
might happen to work now but could easily break in the future because
it's not based on any spec we can rely on.  Plus it makes future PCI
maintenance harder because we have to worry about how these differ
from real PCI devices.

> Add support for the remapped NVMe mode by creating a virtual PCI bus,
> where the AHCI and NVMe devices are presented separately, allowing the
> ahci and nvme drivers to bind in the normal way.
> 
> Unfortunately the NVMe device configuration space is inaccesible under
> this scheme, so we provide a fake one, and hope that no DeviceID-based
> quirks are needed. The interrupt is shared between the AHCI and NVMe
> devices.
> 
> The existing ahci driver is modified to not claim devices where remapped
> NVMe devices are present, allowing this new driver to step in.
> 
> The details of the remapping scheme came from patches previously
> posted by Dan Williams and the resulting discussion.

Maybe these details answer some of my questions.  Please include the
URL (in addition to addressing the questions in the commit log).

> Signed-off-by: Daniel Drake <drake@endlessm.com>
> ---
>  drivers/ata/ahci.c                        |  25 +-
>  drivers/pci/controller/Kconfig            |  16 +
>  drivers/pci/controller/Makefile           |   1 +
>  drivers/pci/controller/intel-nvme-remap.c | 461 ++++++++++++++++++++++
>  4 files changed, 493 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/pci/controller/intel-nvme-remap.c
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index f7652baa6337..75c5733cbae9 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1499,7 +1499,7 @@ static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
>  }
>  #endif
>  
> -static void ahci_remap_check(struct pci_dev *pdev, int bar,
> +static int ahci_remap_check(struct pci_dev *pdev, int bar,
>  		struct ahci_host_priv *hpriv)
>  {
>  	int i, count = 0;
> @@ -1512,7 +1512,7 @@ static void ahci_remap_check(struct pci_dev *pdev, int bar,
>  	    pci_resource_len(pdev, bar) < SZ_512K ||
>  	    bar != AHCI_PCI_BAR_STANDARD ||
>  	    !(readl(hpriv->mmio + AHCI_VSCAP) & 1))
> -		return;
> +		return 0;
>  
>  	cap = readq(hpriv->mmio + AHCI_REMAP_CAP);
>  	for (i = 0; i < AHCI_MAX_REMAP; i++) {
> @@ -1527,17 +1527,20 @@ static void ahci_remap_check(struct pci_dev *pdev, int bar,
>  	}
>  
>  	if (!count)
> -		return;
> +		return 0;
> +
> +	/* Abort probe, allowing intel-nvme-remap to step in when available */
> +	if (IS_ENABLED(CONFIG_INTEL_NVME_REMAP)) {
> +		dev_info(&pdev->dev,
> +			 "Device will be handled by intel-nvme-remap.\n");
> +		return -ENODEV;
> +	}
>  
>  	dev_warn(&pdev->dev, "Found %d remapped NVMe devices.\n", count);
>  	dev_warn(&pdev->dev,
> -		 "Switch your BIOS from RAID to AHCI mode to use them.\n");
> +		 "Enable intel-nvme-remap or switch your BIOS to AHCI mode to use them.\n");

I don't think users will know how to "enable intel-nvme-remap".  I
think the message would have to mention a config option and rebuilding
the kernel.

> -	/*
> -	 * Don't rely on the msi-x capability in the remap case,
> -	 * share the legacy interrupt across ahci and remapped devices.
> -	 */
> -	hpriv->flags |= AHCI_HFLAG_NO_MSI;
> +	return 0;
>  }
>  
>  static int ahci_get_irq_vector(struct ata_host *host, int port)
> @@ -1717,7 +1720,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	hpriv->mmio = pcim_iomap_table(pdev)[ahci_pci_bar];
>  
>  	/* detect remapped nvme devices */
> -	ahci_remap_check(pdev, ahci_pci_bar, hpriv);
> +	rc = ahci_remap_check(pdev, ahci_pci_bar, hpriv);
> +	if (rc)
> +		return rc;
>  
>  	/* must set flag prior to save config in order to take effect */
>  	if (ahci_broken_devslp(pdev))
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 011c57cae4b0..20bf2b528c5f 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -265,6 +265,22 @@ config PCIE_TANGO_SMP8759
>  	  This can lead to data corruption if drivers perform concurrent
>  	  config and MMIO accesses.
>  
> +config INTEL_NVME_REMAP
> +	tristate "Support Intel NVMe remap via AHCI"
> +	depends on X86_64
> +	help
> +	  Adds support for hidden NVMe devices remapped into AHCI memory
> +	  on Intel platforms.

As a user, I don't know what "hidden NVMe devices" means.  I think
this needs to say something about RAID and/or the other Intel
marketing-speak.

> +	  As an alternative to this driver, it is sometimes possible to
> +	  make such devices appear in the normal way by configuring your
> +	  SATA controller to AHCI mode in the firmware setup menu.
> +
> +	  Say Y here if you want to access the remapped devices.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called intel-nvme-remap.
> +
>  config VMD
>  	depends on PCI_MSI && X86_64 && SRCU
>  	select X86_DEV_DMA_OPS
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index d56a507495c5..d4386025b0d1 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_INTEL_NVME_REMAP) += intel-nvme-remap.o
>  obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
>  obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
>  obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
> diff --git a/drivers/pci/controller/intel-nvme-remap.c b/drivers/pci/controller/intel-nvme-remap.c
> new file mode 100644
> index 000000000000..c5ac712443aa
> --- /dev/null
> +++ b/drivers/pci/controller/intel-nvme-remap.c
> @@ -0,0 +1,461 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel remapped NVMe device support.
> + *
> + * Copyright (c) 2019 Endless Mobile, Inc.
> + * Author: Daniel Drake <drake@endlessm.com>
> + *
> + * Some products ship by default with the SATA controller in "RAID" or
> + * "Intel RST Premium With Intel Optane System Acceleration" mode. Under this
> + * mode, which we refer to as "remapped NVMe" mode, any installed NVMe
> + * devices disappear from the PCI bus, and instead their I/O memory becomes
> + * available within the AHCI device BARs.
> + *
> + * This scheme is understood to be a way of avoiding usage of the standard
> + * Windows NVMe driver under that OS, instead mandating usage of Intel's
> + * driver instead, which has better power management, and presumably offers
> + * some RAID/disk-caching solutions too.
> + *
> + * Here in this driver, we support the remapped NVMe mode by claiming the
> + * AHCI device and creating a fake PCIe root port. On the new bus, the
> + * original AHCI device is exposed with only minor tweaks. Then, fake PCI
> + * devices corresponding to the remapped NVMe devices are created. The usual
> + * ahci and nvme drivers are then expected to bind to these devices and
> + * operate as normal.

I think this creates a fake PCI host bridge, but not an actual PCIe
Root Port, right?  I.e., "lspci" doesn't show a new Root Port device,
does it?

But I suppose "lspci" *does* show new NVMe devices that seem to be
PCIe endpoints?  But they probably don't *work* like PCIe endpoints,
e.g., we can't control ASPM, can't use AER, etc?

> + * The PCI configuration space for the NVMe devices is completely
> + * unavailable, so we fake a minimal one and hope for the best.
> + *
> + * Interrupts are shared between the AHCI and NVMe devices. For simplicity,
> + * we only support the legacy interrupt here, although MSI support
> + * could potentially be added later.
> + */
> +
> +#define MODULE_NAME "intel-nvme-remap"
> +
> +#include <linux/ahci-remap.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +
> +#define AHCI_PCI_BAR_STANDARD 5
> +
> +struct nvme_remap_dev {
> +	struct pci_dev		*dev;		/* AHCI device */
> +	struct pci_bus		*bus;		/* our fake PCI bus */
> +	struct pci_sysdata	sysdata;
> +	int			irq_base;	/* our fake interrupts */
> +
> +	/*
> +	 * When we detect an all-ones write to a BAR register, this flag
> +	 * is set, so that we return the BAR size on the next read (a
> +	 * standard PCI behaviour).
> +	 * This includes the assumption that an all-ones BAR write is
> +	 * immediately followed by a read of the same register.
> +	 */
> +	bool			bar_sizing;
> +
> +	/*
> +	 * Resources copied from the AHCI device, to be regarded as
> +	 * resources on our fake bus.
> +	 */
> +	struct resource		ahci_resources[PCI_NUM_RESOURCES];
> +
> +	/* Resources corresponding to the NVMe devices. */
> +	struct resource		remapped_dev_mem[AHCI_MAX_REMAP];
> +
> +	/* Number of remapped NVMe devices found. */
> +	int			num_remapped_devices;
> +};
> +
> +static inline struct nvme_remap_dev *nrdev_from_bus(struct pci_bus *bus)
> +{
> +	return container_of(bus->sysdata, struct nvme_remap_dev, sysdata);
> +}
> +
> +
> +/******** PCI configuration space **********/
> +
> +/*
> + * Helper macros for tweaking returned contents of PCI configuration space.
> + *
> + * value contains len bytes of data read from reg.
> + * If fixup_reg is included in that range, fix up the contents of that
> + * register to fixed_value.
> + */
> +#define NR_FIX8(fixup_reg, fixed_value) do { \
> +		if (reg <= fixup_reg && fixup_reg < reg + len) \
> +			((u8 *) value)[fixup_reg - reg] = (u8) (fixed_value); \
> +	} while (0)

These implicitly depend on local variables named "reg", "len",
"value".  Can you make that explicit?

> +#define NR_FIX16(fixup_reg, fixed_value) do { \
> +		NR_FIX8(fixup_reg, fixed_value); \
> +		NR_FIX8(fixup_reg + 1, fixed_value >> 8); \
> +	} while (0)
> +
> +#define NR_FIX24(fixup_reg, fixed_value) do { \
> +		NR_FIX8(fixup_reg, fixed_value); \
> +		NR_FIX8(fixup_reg + 1, fixed_value >> 8); \
> +		NR_FIX8(fixup_reg + 2, fixed_value >> 16); \
> +	} while (0)
> +
> +#define NR_FIX32(fixup_reg, fixed_value) do { \
> +		NR_FIX16(fixup_reg, (u16) fixed_value); \
> +		NR_FIX16(fixup_reg + 2, fixed_value >> 16); \
> +	} while (0)
> +
> +/*
> + * Read PCI config space of the slot 0 (AHCI) device.
> + * We pass through the read request to the underlying device, but
> + * tweak the results in some cases.
> + */
> +static int nvme_remap_pci_read_slot0(struct pci_bus *bus, int reg,
> +				     int len, u32 *value)
> +{
> +	struct nvme_remap_dev *nrdev = nrdev_from_bus(bus);
> +	struct pci_bus *ahci_dev_bus = nrdev->dev->bus;
> +	int ret;
> +
> +	ret = ahci_dev_bus->ops->read(ahci_dev_bus, nrdev->dev->devfn,
> +				      reg, len, value);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Adjust the device class, to prevent this driver from attempting to
> +	 * additionally probe the device we're simulating here.
> +	 */
> +	NR_FIX24(PCI_CLASS_PROG, PCI_CLASS_STORAGE_SATA_AHCI);
> +
> +	/*
> +	 * Unset interrupt pin, otherwise ACPI tries to find routing
> +	 * info for our virtual IRQ, fails, and complains.
> +	 */
> +	NR_FIX8(PCI_INTERRUPT_PIN, 0);
> +
> +	/*
> +	 * Truncate the AHCI BAR to not include the region that covers the
> +	 * hidden devices. This will cause the ahci driver to successfully
> +	 * probe th new device (instead of handing it over to this driver).
> +	 */
> +	if (nrdev->bar_sizing) {
> +		NR_FIX32(PCI_BASE_ADDRESS_5, ~(SZ_16K - 1));
> +		nrdev->bar_sizing = false;
> +	}
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +/*
> + * Read PCI config space of a remapped device.
> + * Since the original PCI config space is inaccessible, we provide a minimal,
> + * fake config space instead.
> + */
> +static int nvme_remap_pci_read_remapped(struct pci_bus *bus, unsigned int port,
> +					int reg, int len, u32 *value)
> +{
> +	struct nvme_remap_dev *nrdev = nrdev_from_bus(bus);
> +	struct resource *remapped_mem;
> +
> +	if (port > nrdev->num_remapped_devices)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	*value = 0;
> +	remapped_mem = &nrdev->remapped_dev_mem[port - 1];
> +
> +	/* Set a Vendor ID, otherwise Linux assumes no device is present */
> +	NR_FIX16(PCI_VENDOR_ID, PCI_VENDOR_ID_INTEL);
> +
> +	/* Always appear on & bus mastering */
> +	NR_FIX16(PCI_COMMAND, PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
> +
> +	/* Set class so that nvme driver probes us */
> +	NR_FIX24(PCI_CLASS_PROG, PCI_CLASS_STORAGE_EXPRESS);
> +
> +	if (nrdev->bar_sizing) {
> +		NR_FIX32(PCI_BASE_ADDRESS_0,
> +			 ~(resource_size(remapped_mem) - 1));
> +		nrdev->bar_sizing = false;
> +	} else {
> +		resource_size_t mem_start = remapped_mem->start;
> +
> +		mem_start |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> +		NR_FIX32(PCI_BASE_ADDRESS_0, mem_start);
> +		mem_start >>= 32;
> +		NR_FIX32(PCI_BASE_ADDRESS_1, mem_start);
> +	}
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +/* Read PCI configuration space. */
> +static int nvme_remap_pci_read(struct pci_bus *bus, unsigned int devfn,
> +			       int reg, int len, u32 *value)
> +{
> +	if (PCI_SLOT(devfn) == 0)
> +		return nvme_remap_pci_read_slot0(bus, reg, len, value);
> +	else
> +		return nvme_remap_pci_read_remapped(bus, PCI_SLOT(devfn),
> +						    reg, len, value);
> +}
> +
> +/*
> + * Write PCI config space of the slot 0 (AHCI) device.
> + * Apart from the special case of BAR sizing, we disable all writes.
> + * Otherwise, the ahci driver could make changes (e.g. unset PCI bus master)
> + * that would affect the operation of the NVMe devices.
> + */
> +static int nvme_remap_pci_write_slot0(struct pci_bus *bus, int reg,
> +				      int len, u32 value)
> +{
> +	struct nvme_remap_dev *nrdev = nrdev_from_bus(bus);
> +	struct pci_bus *ahci_dev_bus = nrdev->dev->bus;
> +
> +	if (reg >= PCI_BASE_ADDRESS_0 && reg <= PCI_BASE_ADDRESS_5) {
> +		/*
> +		 * Writing all-ones to a BAR means that the size of the
> +		 * memory region is being checked. Flag this so that we can
> +		 * reply with an appropriate size on the next read.
> +		 */
> +		if (value == ~0)
> +			nrdev->bar_sizing = true;
> +
> +		return ahci_dev_bus->ops->write(ahci_dev_bus,
> +						nrdev->dev->devfn,
> +						reg, len, value);
> +	}
> +
> +	return PCIBIOS_SET_FAILED;
> +}
> +
> +/*
> + * Write PCI config space of a remapped device.
> + * Since the original PCI config space is inaccessible, we reject all
> + * writes, except for the special case of BAR probing.
> + */
> +static int nvme_remap_pci_write_remapped(struct pci_bus *bus,
> +					 unsigned int port,
> +					 int reg, int len, u32 value)
> +{
> +	struct nvme_remap_dev *nrdev = nrdev_from_bus(bus);
> +
> +	if (port > nrdev->num_remapped_devices)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	/*
> +	 * Writing all-ones to a BAR means that the size of the memory
> +	 * region is being checked. Flag this so that we can reply with
> +	 * an appropriate size on the next read.
> +	 */
> +	if (value == ~0 && reg >= PCI_BASE_ADDRESS_0
> +			&& reg <= PCI_BASE_ADDRESS_5) {
> +		nrdev->bar_sizing = true;
> +		return PCIBIOS_SUCCESSFUL;
> +	}
> +
> +	return PCIBIOS_SET_FAILED;
> +}
> +
> +/* Write PCI configuration space. */
> +static int nvme_remap_pci_write(struct pci_bus *bus, unsigned int devfn,
> +				int reg, int len, u32 value)
> +{
> +	if (PCI_SLOT(devfn) == 0)
> +		return nvme_remap_pci_write_slot0(bus, reg, len, value);
> +	else
> +		return nvme_remap_pci_write_remapped(bus, PCI_SLOT(devfn),
> +						     reg, len, value);
> +}
> +
> +static struct pci_ops nvme_remap_pci_ops = {
> +	.read	= nvme_remap_pci_read,
> +	.write	= nvme_remap_pci_write,
> +};
> +
> +
> +/******** Initialization & exit **********/
> +
> +/*
> + * Find a PCI domain ID to use for our fake bus.
> + * Start at 0x10000 to not clash with ACPI _SEG domains (16 bits).
> + */
> +static int find_free_domain(void)
> +{
> +	int domain = 0xffff;
> +	struct pci_bus *bus = NULL;
> +
> +	while ((bus = pci_find_next_bus(bus)) != NULL)
> +		domain = max_t(int, domain, pci_domain_nr(bus));
> +
> +	return domain + 1;
> +}

This is the same as vmd_find_free_domain().  There might not be a
conflict now, but both places should call the same interface so future
changes can take both callers into account.

> +static int find_remapped_devices(struct nvme_remap_dev *nrdev,
> +				 struct list_head *resources)
> +{
> +	void __iomem *mmio;
> +	int i, count = 0;
> +	u32 cap;
> +
> +	mmio = pcim_iomap(nrdev->dev, AHCI_PCI_BAR_STANDARD,
> +			  pci_resource_len(nrdev->dev,
> +					   AHCI_PCI_BAR_STANDARD));
> +	if (!mmio)
> +		return -ENODEV;
> +
> +	/* Check if this device might have remapped nvme devices. */
> +	if (pci_resource_len(nrdev->dev, AHCI_PCI_BAR_STANDARD) < SZ_512K ||
> +	    !(readl(mmio + AHCI_VSCAP) & 1))
> +		return -ENODEV;
> +
> +	cap = readq(mmio + AHCI_REMAP_CAP);

Can you provide a spec reference for AHCI_VSCAP and AHCI_REMAP_CAP?
It might not need to be in the code, but it would be useful in the
commit log at least.

> +	for (i = 0; i < AHCI_MAX_REMAP; i++) {
> +		struct resource *remapped_mem;
> +
> +		if ((cap & (1 << i)) == 0)
> +			continue;
> +		if (readl(mmio + ahci_remap_dcc(i))
> +				!= PCI_CLASS_STORAGE_EXPRESS)
> +			continue;
> +
> +		/* We've found a remapped device */
> +		remapped_mem = &nrdev->remapped_dev_mem[count++];
> +		remapped_mem->start =
> +			pci_resource_start(nrdev->dev, AHCI_PCI_BAR_STANDARD)
> +			+ ahci_remap_base(i);
> +		remapped_mem->end = remapped_mem->start
> +			+ AHCI_REMAP_N_SIZE - 1;
> +		remapped_mem->flags = IORESOURCE_MEM | IORESOURCE_PCI_FIXED;
> +		pci_add_resource(resources, remapped_mem);
> +	}
> +
> +	pcim_iounmap(nrdev->dev, mmio);
> +
> +	if (count == 0)
> +		return -ENODEV;
> +
> +	nrdev->num_remapped_devices = count;
> +	dev_info(&nrdev->dev->dev, "Found %d remapped NVMe devices\n",
> +		 nrdev->num_remapped_devices);
> +	return 0;
> +}
> +
> +static void nvme_remap_remove_root_bus(void *data)
> +{
> +	struct pci_bus *bus = data;
> +
> +	pci_stop_root_bus(bus);
> +	pci_remove_root_bus(bus);
> +}
> +
> +static int nvme_remap_probe(struct pci_dev *dev,
> +			    const struct pci_device_id *id)
> +{
> +	struct nvme_remap_dev *nrdev;
> +	LIST_HEAD(resources);
> +	int i;
> +	int ret;
> +	struct pci_dev *child;
> +
> +	nrdev = devm_kzalloc(&dev->dev, sizeof(*nrdev), GFP_KERNEL);
> +	nrdev->sysdata.domain = find_free_domain();
> +	nrdev->dev = dev;
> +	pci_set_drvdata(dev, nrdev);
> +
> +	ret = pcim_enable_device(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	pci_set_master(dev);
> +
> +	ret = find_remapped_devices(nrdev, &resources);
> +	if (ret)
> +		return ret;
> +
> +	/* Add resources from the original AHCI device */
> +	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> +		struct resource *res = &dev->resource[i];
> +
> +		if (res->start) {
> +			struct resource *nr_res = &nrdev->ahci_resources[i];
> +
> +			nr_res->start = res->start;
> +			nr_res->end = res->end;
> +			nr_res->flags = res->flags;
> +			pci_add_resource(&resources, nr_res);
> +		}
> +	}
> +
> +	/* Create virtual interrupts */
> +	nrdev->irq_base = devm_irq_alloc_descs(&dev->dev, -1, 0,
> +					       nrdev->num_remapped_devices + 1,
> +					       0);
> +	if (nrdev->irq_base < 0)
> +		return nrdev->irq_base;
> +
> +	/* Create and populate PCI bus */
> +	nrdev->bus = pci_create_root_bus(&dev->dev, 0, &nvme_remap_pci_ops,
> +					 &nrdev->sysdata, &resources);
> +	if (!nrdev->bus)
> +		return -ENODEV;
> +
> +	if (devm_add_action_or_reset(&dev->dev, nvme_remap_remove_root_bus,
> +				     nrdev->bus))
> +		return -ENOMEM;
> +
> +	/* We don't support sharing MSI interrupts between these devices */
> +	nrdev->bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
> +
> +	pci_scan_child_bus(nrdev->bus);
> +
> +	list_for_each_entry(child, &nrdev->bus->devices, bus_list) {
> +		/*
> +		 * Prevent PCI core from trying to move memory BARs around.
> +		 * The hidden NVMe devices are at fixed locations.
> +		 */
> +		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> +			struct resource *res = &child->resource[i];
> +
> +			if (res->flags & IORESOURCE_MEM)
> +				res->flags |= IORESOURCE_PCI_FIXED;
> +		}
> +
> +		/* Share the legacy IRQ between all devices */
> +		child->irq = dev->irq;
> +	}
> +
> +	pci_assign_unassigned_bus_resources(nrdev->bus);
> +	pci_bus_add_devices(nrdev->bus);
> +
> +	return 0;
> +}
> +
> +static const struct pci_device_id nvme_remap_ids[] = {
> +	/*
> +	 * Match all Intel RAID controllers.
> +	 *
> +	 * There's overlap here with the set of devices detected by the ahci
> +	 * driver, but ahci will only successfully probe when there
> +	 * *aren't* any remapped NVMe devices, and this driver will only
> +	 * successfully probe when there *are* remapped NVMe devices that
> +	 * need handling.
> +	 */
> +	{
> +		PCI_VDEVICE(INTEL, PCI_ANY_ID),
> +		.class = PCI_CLASS_STORAGE_RAID << 8,
> +		.class_mask = 0xffffff00,
> +	},
> +	{0,}
> +};
> +MODULE_DEVICE_TABLE(pci, nvme_remap_ids);
> +
> +static struct pci_driver nvme_remap_drv = {
> +	.name		= MODULE_NAME,
> +	.id_table	= nvme_remap_ids,
> +	.probe		= nvme_remap_probe,
> +};
> +module_pci_driver(nvme_remap_drv);
> +
> +MODULE_AUTHOR("Daniel Drake <drake@endlessm.com>");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
