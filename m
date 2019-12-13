Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0EEB11E580
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 15:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfLMOXw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 09:23:52 -0500
Received: from foss.arm.com ([217.140.110.172]:32826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbfLMOXv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Dec 2019 09:23:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15EEC13D5;
        Fri, 13 Dec 2019 06:23:50 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E8BC3F52E;
        Fri, 13 Dec 2019 06:23:48 -0800 (PST)
Date:   Fri, 13 Dec 2019 14:23:34 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] pcie: Add quirk for the Arm Neoverse N1SDP platform
Message-ID: <20191213142334.1631e3db@donnerap.cambridge.arm.com>
In-Reply-To: <20191212123748.GF24359@e119886-lin.cambridge.arm.com>
References: <20191209160638.141431-1-andre.przywara@arm.com>
        <20191212123748.GF24359@e119886-lin.cambridge.arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 12 Dec 2019 12:37:48 +0000
Andrew Murray <andrew.murray@arm.com> wrote:

Hi Andrew,

> On Mon, Dec 09, 2019 at 04:06:38PM +0000, Andre Przywara wrote:
> > From: Deepak Pandey <Deepak.Pandey@arm.com>
> > 
> > The Arm N1SDP SoC suffers from some PCIe integration issues, most
> > prominently config space accesses to not existing BDFs being answered
> > with a bus abort, resulting in an SError.  
> 
> It wouldn't be a surprise if the host controller handled UR completions
> differently depending on if they were in response to a Type 0 configuration
> request or a Type 1 configuration request. (I think I've seen this before).

Yeah, that rings a bell here as well, I remember something with the RK3399 PCIe RC.
 
> Have you verified that you still get a bus abort when you attempt to
> perform a config read of a non-existent device downstream of the PCIe switch?
> (and thus as a response to a Type 1 request).

I think I have checked this (please confirm if my experiment is valid): I get SErrors for both probing non-existent devices on bus 0 and other busses.

> I ask because if this is the case, and knowing that the PCIe switch is
> fixed, then it would be possible to simplify this quirk (by just making
> assumptions of the presence of devices in bus 0 rather than all the busses).

Yeah, thanks for trying, but no luck here ;-)

> > To mitigate this, the firmware scans the bus before boot (catching the
> > SErrors) and creates a table with valid BDFs, which acts as a filter for
> > Linux' config space accesses.
> > 
> > Add code consulting the table as an ACPI PCIe quirk, also register the
> > corresponding device tree based description of the host controller.
> > Also fix the other two minor issues on the way, namely not being fully
> > ECAM compliant and config space accesses being restricted to 32-bit
> > accesses only.
> > 
> > This allows the Arm Neoverse N1SDP board to boot Linux without crashing
> > and to access *any* devices (there are no platform devices except UART).  
> 
> This implies that this quirk has no side-effects and everything will work
> as expected - but this is only true for the simple case. For example hot
> plug won't work, SR-IOV, and others won't work.

Yeah, good point, I should have mentioned this. This is really a best effort hack^Wworkaround to make the system work as best as possible.
Yes, SR-IOV won't work. We are about to evaluate our options here, but for now it's just not supported on this system.

I don't think hot plug is of a particular concern here, since the hardware doesn't support physical hot plug. I am not sure if a Thunderbolt add-in card would trigger this problem, but in the worst case it just wouldn't work.

> Also what happens for devices that return CRS? - does this also result in an
> abort?

I haven't tried, and it looks like it's hard to trigger? But chances are indeed that it could generate SErrors.

> Does that mean that the firmware will consider these devices as not
> present instead of not ready yet? If this is an issue, then FLR of devices
> will also create issues (resulting in SErrors for users).
> 
> I think it would be helpful to update this commit message to indicate that
> this makes it work better, but it may be broken in certain ways.

Good point. This is really a pragmatic patch to make the system usable at all.

> > Signed-off-by: Deepak Pandey <Deepak.Pandey@arm.com>
> > [Sudipto: extend to cover the CCIX root port as well]
> > Signed-off-by: Sudipto Paul <sudipto.paul@arm.com>
> > [Andre: fix coding style issues, rewrite some parts, add DT support]
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  arch/arm64/configs/defconfig        |   1 +
> >  drivers/acpi/pci_mcfg.c             |   7 +
> >  drivers/pci/controller/Kconfig      |  11 ++
> >  drivers/pci/controller/Makefile     |   1 +
> >  drivers/pci/controller/pcie-n1sdp.c | 196 ++++++++++++++++++++++++++++
> >  include/linux/pci-ecam.h            |   2 +
> >  6 files changed, 218 insertions(+)
> >  create mode 100644 drivers/pci/controller/pcie-n1sdp.c
> > 
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 6a83ba2aea3e..58124ef5070b 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -177,6 +177,7 @@ CONFIG_NET_9P=y
> >  CONFIG_NET_9P_VIRTIO=y
> >  CONFIG_PCI=y
> >  CONFIG_PCIEPORTBUS=y
> > +CONFIG_PCI_QUIRKS=y
> >  CONFIG_PCI_IOV=y
> >  CONFIG_HOTPLUG_PCI=y
> >  CONFIG_HOTPLUG_PCI_ACPI=y
> > diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> > index 6b347d9920cc..7a2b41b9ab57 100644
> > --- a/drivers/acpi/pci_mcfg.c
> > +++ b/drivers/acpi/pci_mcfg.c
> > @@ -142,6 +142,13 @@ static struct mcfg_fixup mcfg_quirks[] = {
> >  	XGENE_V2_ECAM_MCFG(4, 0),
> >  	XGENE_V2_ECAM_MCFG(4, 1),
> >  	XGENE_V2_ECAM_MCFG(4, 2),
> > +
> > +#define N1SDP_ECAM_MCFG(rev, seg, ops) \
> > +	{"ARMLTD", "ARMN1SDP", rev, seg, MCFG_BUS_ANY, ops }
> > +
> > +	/* N1SDP SoC with v1 PCIe controller */
> > +	N1SDP_ECAM_MCFG(0x20181101, 0, &pci_n1sdp_pcie_ecam_ops),
> > +	N1SDP_ECAM_MCFG(0x20181101, 1, &pci_n1sdp_ccix_ecam_ops),
> >  };
> >  
> >  static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > index c77069c8ee5d..45700d32f02e 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -37,6 +37,17 @@ config PCI_FTPCI100
> >  	depends on OF
> >  	default ARCH_GEMINI
> >  
> > +config PCIE_HOST_N1SDP_ECAM
> > +	bool "ARM N1SDP PCIe Controller"
> > +	depends on ARM64
> > +	depends on OF || (ACPI && PCI_QUIRKS)
> > +	select PCI_HOST_COMMON
> > +	default y if ARCH_VEXPRESS
> > +	help
> > +	  Say Y here if you want PCIe support for the Arm N1SDP platform.
> > +	  The controller is ECAM compliant, but needs a quirk to workaround
> > +	  an integration issue.  
> 
> Again - please indicate the scope of support provided.
> 
> > +
> >  config PCI_TEGRA
> >  	bool "NVIDIA Tegra PCIe controller"
> >  	depends on ARCH_TEGRA || COMPILE_TEST
> > diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> > index 3d4f597f15ce..5f47fefbd67d 100644
> > --- a/drivers/pci/controller/Makefile
> > +++ b/drivers/pci/controller/Makefile
> > @@ -28,6 +28,7 @@ obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
> >  obj-$(CONFIG_PCIE_MOBIVEIL) += pcie-mobiveil.o
> >  obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
> >  obj-$(CONFIG_VMD) += vmd.o
> > +obj-$(CONFIG_PCIE_HOST_N1SDP_ECAM) += pcie-n1sdp.o
> >  # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
> >  obj-y				+= dwc/
> >  
> > diff --git a/drivers/pci/controller/pcie-n1sdp.c b/drivers/pci/controller/pcie-n1sdp.c
> > new file mode 100644
> > index 000000000000..620ab221466c
> > --- /dev/null
> > +++ b/drivers/pci/controller/pcie-n1sdp.c
> > @@ -0,0 +1,196 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2018/2019 ARM Ltd.
> > + *
> > + * This quirk is to mask the following issues:
> > + * - PCIE SLVERR: config space accesses to invalid PCIe BDFs cause a bus
> > + *		  error (signalled as an asynchronous SError)
> > + * - MCFG BDF mapping: the root complex is mapped separately from the device
> > + *		       config space
> > + * - Non 32-bit accesses to config space are not supported.
> > + *
> > + * At boot time the SCP board firmware creates a discovery table with
> > + * the root complex' base address and the valid BDF values, discovered while
> > + * scanning the config space and catching the SErrors.
> > + * Linux responds only to the EPs listed in this table, returning NULL  
> 
> NIT: it will respond to the switch devices which aren't EPs.
> 
> 
> > + * for the rest.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/ioport.h>
> > +#include <linux/sizes.h>
> > +#include <linux/of_pci.h>
> > +#include <linux/of.h>
> > +#include <linux/pci-ecam.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/module.h>
> > +
> > +/* Platform specific values as hardcoded in the firmware. */
> > +#define AP_NS_SHARED_MEM_BASE	0x06000000
> > +#define MAX_SEGMENTS		2		/* Two PCIe root complexes. */
> > +#define BDF_TABLE_SIZE		SZ_16K
> > +
> > +/*
> > + * Shared memory layout as written by the SCP upon boot time:
> > + *  ----
> > + *  Discover data header --> RC base address
> > + *                       \-> BDF Count
> > + *  Discover data        --> BDF 0...n
> > + *  ----
> > + */
> > +struct pcie_discovery_data {
> > +	u32 rc_base_addr;
> > +	u32 nr_bdfs;
> > +	u32 valid_bdfs[0];
> > +} *pcie_discovery_data[MAX_SEGMENTS];
> > +
> > +void __iomem *rc_remapped_addr[MAX_SEGMENTS];
> > +
> > +/*
> > + * map_bus() is called before we do a config space access for a certain
> > + * device. We use this to check whether this device is valid, avoiding
> > + * config space accesses which would result in an SError otherwise.
> > + */
> > +static void __iomem *pci_n1sdp_map_bus(struct pci_bus *bus, unsigned int devfn,
> > +				       int where)
> > +{
> > +	struct pci_config_window *cfg = bus->sysdata;
> > +	unsigned int devfn_shift = cfg->ops->bus_shift - 8;
> > +	unsigned int busn = bus->number;
> > +	unsigned int segment = bus->domain_nr;
> > +	unsigned int bdf_addr;
> > +	unsigned int table_count, i;
> > +
> > +	if (segment >= MAX_SEGMENTS ||
> > +	    busn < cfg->busr.start || busn > cfg->busr.end)
> > +		return NULL;
> > +
> > +	/* The PCIe root complex has a separate config space mapping. */
> > +	if (busn == 0 && devfn == 0)
> > +		return rc_remapped_addr[segment] + where;
> > +
> > +	busn -= cfg->busr.start;
> > +	bdf_addr = (busn << cfg->ops->bus_shift) + (devfn << devfn_shift);
> > +	table_count = pcie_discovery_data[segment]->nr_bdfs;
> > +	for (i = 0; i < table_count; i++) {
> > +		if (bdf_addr == pcie_discovery_data[segment]->valid_bdfs[i])
> > +			return pci_ecam_map_bus(bus, devfn, where);
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +static int pci_n1sdp_init(struct pci_config_window *cfg, unsigned int segment)
> > +{
> > +	phys_addr_t table_base;
> > +	struct device *dev = cfg->parent;
> > +	struct pcie_discovery_data *shared_data;
> > +	size_t bdfs_size;
> > +
> > +	if (segment >= MAX_SEGMENTS)
> > +		return -ENODEV;
> > +
> > +	table_base = AP_NS_SHARED_MEM_BASE + segment * BDF_TABLE_SIZE;  
> 
> How can you be sure that this table is populated and isn't junk? I.e. using an older
> SCP version?

This is just (and always was) part of the firmware. If not, it won't work. Technically we tie this to the DT compatible or the ACPI signature.

> > +
> > +	if (!request_mem_region(table_base, BDF_TABLE_SIZE,
> > +				"PCIe valid BDFs")) {
> > +		dev_err(dev, "PCIe BDF shared region request failed\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	shared_data = devm_ioremap(dev,
> > +				   table_base, BDF_TABLE_SIZE);
> > +	if (!shared_data)
> > +		return -ENOMEM;
> > +
> > +	/* Copy the valid BDFs structure to allocated normal memory. */
> > +	bdfs_size = sizeof(struct pcie_discovery_data) +
> > +		    sizeof(u32) * shared_data->nr_bdfs;
> > +	pcie_discovery_data[segment] = devm_kmalloc(dev, bdfs_size, GFP_KERNEL);
> > +	if (!pcie_discovery_data[segment])
> > +		return -ENOMEM;
> > +
> > +	memcpy_fromio(pcie_discovery_data[segment], shared_data, bdfs_size);
> > +
> > +	rc_remapped_addr[segment] = devm_ioremap_nocache(dev,
> > +						shared_data->rc_base_addr,
> > +						PCI_CFG_SPACE_EXP_SIZE);
> > +	if (!rc_remapped_addr[segment]) {
> > +		dev_err(dev, "Cannot remap root port base\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	devm_iounmap(dev, shared_data);
> > +
> > +	return 0;
> > +}
> > +
> > +static int pci_n1sdp_pcie_init(struct pci_config_window *cfg)
> > +{
> > +	return pci_n1sdp_init(cfg, 0);
> > +}
> > +
> > +static int pci_n1sdp_ccix_init(struct pci_config_window *cfg)
> > +{
> > +	return pci_n1sdp_init(cfg, 1);
> > +}
> > +
> > +struct pci_ecam_ops pci_n1sdp_pcie_ecam_ops = {
> > +	.bus_shift	= 20,
> > +	.init		= pci_n1sdp_pcie_init,
> > +	.pci_ops	= {
> > +		.map_bus        = pci_n1sdp_map_bus,
> > +		.read           = pci_generic_config_read32,
> > +		.write          = pci_generic_config_write32,
> > +	}
> > +};
> > +
> > +struct pci_ecam_ops pci_n1sdp_ccix_ecam_ops = {
> > +	.bus_shift	= 20,
> > +	.init		= pci_n1sdp_ccix_init,
> > +	.pci_ops	= {
> > +		.map_bus        = pci_n1sdp_map_bus,
> > +		.read           = pci_generic_config_read32,
> > +		.write          = pci_generic_config_write32,
> > +	}
> > +};
> > +
> > +static const struct of_device_id n1sdp_pcie_of_match[] = {
> > +	{ .compatible = "arm,n1sdp-pcie" },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, n1sdp_pcie_of_match);
> > +
> > +static int n1sdp_pcie_probe(struct platform_device *pdev)
> > +{
> > +	const struct device_node *of_node = pdev->dev.of_node;
> > +	u32 segment;
> > +
> > +	if (of_property_read_u32(of_node, "linux,pci-domain", &segment)) {
> > +		dev_err(&pdev->dev, "N1SDP PCI controllers require linux,pci-domain property\n");
> > +		return -EINVAL;
> > +	}  
> 
> Can you use of_get_pci_domain_nr here?

Ah, indeed. There seems to be an of_... function for everything ;-)

Cheers,
Andre.

> > +
> > +	switch (segment) {
> > +	case 0:
> > +		return pci_host_common_probe(pdev, &pci_n1sdp_pcie_ecam_ops);
> > +	case 1:
> > +		return pci_host_common_probe(pdev, &pci_n1sdp_ccix_ecam_ops);
> > +	}
> > +
> > +	dev_err(&pdev->dev, "Invalid segment number, must be smaller than %d\n",
> > +		MAX_SEGMENTS);
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static struct platform_driver n1sdp_pcie_driver = {
> > +	.driver = {
> > +		.name = KBUILD_MODNAME,
> > +		.of_match_table = n1sdp_pcie_of_match,
> > +		.suppress_bind_attrs = true,
> > +	},
> > +	.probe = n1sdp_pcie_probe,
> > +};
> > +builtin_platform_driver(n1sdp_pcie_driver);
> > diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> > index a73164c85e78..03cdea69f4e8 100644
> > --- a/include/linux/pci-ecam.h
> > +++ b/include/linux/pci-ecam.h
> > @@ -57,6 +57,8 @@ extern struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium ThunderX 1.x */
> >  extern struct pci_ecam_ops xgene_v1_pcie_ecam_ops; /* APM X-Gene PCIe v1 */
> >  extern struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene PCIe v2.x */
> >  extern struct pci_ecam_ops al_pcie_ops; /* Amazon Annapurna Labs PCIe */
> > +extern struct pci_ecam_ops pci_n1sdp_pcie_ecam_ops; /* Arm N1SDP PCIe */
> > +extern struct pci_ecam_ops pci_n1sdp_ccix_ecam_ops; /* Arm N1SDP PCIe */
> >  #endif
> >  
> >  #ifdef CONFIG_PCI_HOST_COMMON
> > -- 
> > 2.17.1
> >   

