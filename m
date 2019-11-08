Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABD0CF457A
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2019 12:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbfKHLNa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Nov 2019 06:13:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:48304 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727573AbfKHLN3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Nov 2019 06:13:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF5EEAF62;
        Fri,  8 Nov 2019 11:13:25 +0000 (UTC)
Message-ID: <50e0292949a9f95cf756688eafe0b15a1cf3136e.camel@suse.de>
Subject: Re: [PATCH 3/4] PCI: brcmstb: add Broadcom STB PCIe host controller
 driver
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <wahrenst@gmx.net>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     mbrugger@suse.com, phil@raspberrypi.org,
        linux-kernel@vger.kernel.org, james.quinlan@broadcom.com,
        Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 08 Nov 2019 12:13:20 +0100
In-Reply-To: <87e5117a-f8ff-2a1b-379b-5f43383aa7c0@gmx.net>
References: <20191106214527.18736-1-nsaenzjulienne@suse.de>
         <20191106214527.18736-4-nsaenzjulienne@suse.de>
         <87e5117a-f8ff-2a1b-379b-5f43383aa7c0@gmx.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-7LN/3ZhiuzOWe383zsu9"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-7LN/3ZhiuzOWe383zsu9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,
thanks for the review!

On Thu, 2019-11-07 at 18:50 +0100, Stefan Wahren wrote:
> Hi Nicolas,
>=20
> Am 06.11.19 um 22:45 schrieb Nicolas Saenz Julienne:
> > From: Jim Quinlan <james.quinlan@broadcom.com>
> >=20
> > This commit adds the basic Broadcom STB PCIe controller.  Missing is th=
e
> > ability to process MSI. This functionality is added in a subsequent
> > commit.
> >=20
> > The PCIe block contains an MDIO interface.  This is a local interface
> > only accessible by the PCIe controller.  It cannot be used or shared
> > by any other HW.  As such, the small amount of code for this
> > controller is included in this driver as there is little upside to put
> > it elsewhere.
> >=20
> > This is based on Jim's original submission[1] but adapted and tailored
> > specifically to bcm2711's needs (that's the Raspberry Pi 4). Support fo=
r
> > the rest of the brcmstb family will soon follow once we get support for
> > multiple dma-ranges in dma/direct.
> >=20
> > [1] https://patchwork.kernel.org/patch/10605959/
> >=20
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > Co-developed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  drivers/pci/controller/Kconfig        |  12 +
> >  drivers/pci/controller/Makefile       |   1 +
> >  drivers/pci/controller/pcie-brcmstb.c | 973 ++++++++++++++++++++++++++
> >  3 files changed, 986 insertions(+)
> >  create mode 100644 drivers/pci/controller/pcie-brcmstb.c
> >=20
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kc=
onfig
> > index f5de9119e8d3..8b3aae91d8af 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -281,6 +281,18 @@ config VMD
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called vmd.
> >=20
> > +config PCIE_BRCMSTB
> > +	bool "Broadcom Brcmstb PCIe host controller"
> looking at the driver suggests me a tristate instead of bool.
> > +	depends on ARCH_BRCMSTB || BMIPS_GENERIC
> please add ARCH_BCM2835 for the Raspberry Pi 4
> > +	depends on OF
> > +	depends on SOC_BRCMSTB
> Why is this needed?

It's not, I missed it. For now, I edited it so it only depends on ARCH_BCM2=
835.

> > +	default ARCH_BRCMSTB || BMIPS_GENERIC
> also this needs ARCH_BCM2835
> > +	help
> > +	  Say Y here to enable PCIe host controller support for
> > +	  Broadcom Settop Box SOCs.  A Broadcom SOC will may have
> > +	  multiple host controllers as opposed to a single host
> > +	  controller with multiple ports.
> > +
> >  config PCI_HYPERV_INTERFACE
> >  	tristate "Hyper-V PCI Interface"
> >  	depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && X86_64
> > diff --git a/drivers/pci/controller/Makefile
> > b/drivers/pci/controller/Makefile
> > index a2a22c9d91af..3fc0b0cf5b5b 100644
> > --- a/drivers/pci/controller/Makefile
> > +++ b/drivers/pci/controller/Makefile
> > @@ -30,6 +30,7 @@ obj-$(CONFIG_PCIE_MEDIATEK) +=3D pcie-mediatek.o
> >  obj-$(CONFIG_PCIE_MOBIVEIL) +=3D pcie-mobiveil.o
> >  obj-$(CONFIG_PCIE_TANGO_SMP8759) +=3D pcie-tango.o
> >  obj-$(CONFIG_VMD) +=3D vmd.o
> > +obj-$(CONFIG_PCIE_BRCMSTB) +=3D pcie-brcmstb.o
> >  # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
> >  obj-y				+=3D dwc/
> >=20
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c
> > b/drivers/pci/controller/pcie-brcmstb.c
> > new file mode 100644
> > index 000000000000..880ec11d06a1
> > --- /dev/null
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -0,0 +1,973 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (C) 2009 - 2019 Broadcom */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/compiler.h>
> > +#include <linux/delay.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/ioport.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/kernel.h>
> > +#include <linux/list.h>
> > +#include <linux/log2.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_pci.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/pci.h>
> > +#include <linux/printk.h>
> > +#include <linux/sizes.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> > +#include <linux/types.h>
> > +
> > +#include "../pci.h"
> > +
> > ...
> >=20
> > +
> > +/* L23 is a low-power PCIe link state */
> > +static void enter_l23(struct brcm_pcie *pcie)
> > +{
> > +	void __iomem *base =3D pcie->base;
> > +	int l23, i;
> > +
> > +	/* assert request for L23 */
> > +	WR_FLD_RB(base, PCIE_MISC_PCIE_CTRL, PCIE_L23_REQUEST, 1);
> > +
> > +	/* Wait up to 30 msec for L23 */
> 36 msec?

Yes :)

> > +	l23 =3D RD_FLD(base, PCIE_MISC_PCIE_STATUS, PCIE_LINK_IN_L23);
> > +	for (i =3D 0; i < 15 && !l23; i++) {
> > +		usleep_range(2000, 2400);
> > +		l23 =3D RD_FLD(base, PCIE_MISC_PCIE_STATUS, PCIE_LINK_IN_L23);
> > +	}
> > +
> > +	if (!l23)
> > +		dev_err(pcie->dev, "failed to enter L23\n");
>=20
> I think most user don't know anything about L23.
>=20
> How about:
>=20
> failed to enter low-power link state

Noted

> > +}
> > +
> > +static void turn_off(struct brcm_pcie *pcie)
> > +{
> > +	void __iomem *base =3D pcie->base;
> > +
> > +	if (brcm_pcie_link_up(pcie))
> > +		enter_l23(pcie);
> > +	/* Assert fundamental reset */
> > +	brcm_pcie_perst_set(pcie, 1);
> > +	/* Deassert request for L23 in case it was asserted */
> > +	WR_FLD_RB(base, PCIE_MISC_PCIE_CTRL, PCIE_L23_REQUEST, 0);
> > +	/* Turn off SerDes */
> > +	WR_FLD_RB(base, PCIE_MISC_HARD_PCIE_HARD_DEBUG, SERDES_IDDQ, 1);
> > +	/* Shutdown PCIe bridge */
> > +	brcm_pcie_bridge_sw_init_set(pcie, 1);
> > +}
> > +
> > +static int brcm_pcie_suspend(struct device *dev)
> > +{
> > +	struct brcm_pcie *pcie =3D dev_get_drvdata(dev);
> > +
> > +	turn_off(pcie);
> > +	clk_disable_unprepare(pcie->clk);
> > +	pcie->suspended =3D true;
> > +
> > +	return 0;
> > +}
> > +
> > +static int brcm_pcie_resume(struct device *dev)
> > +{
> > +	struct brcm_pcie *pcie =3D dev_get_drvdata(dev);
> > +	void __iomem *base;
> > +	int ret;
> > +
> > +	base =3D pcie->base;
> > +	clk_prepare_enable(pcie->clk);
> > +
> > +	/* Take bridge out of reset so we can access the SerDes reg */
> > +	brcm_pcie_bridge_sw_init_set(pcie, 0);
> > +
> > +	/* Turn on SerDes */
> > +	WR_FLD_RB(base, PCIE_MISC_HARD_PCIE_HARD_DEBUG, SERDES_IDDQ, 0);
> > +	/* Wait for SerDes to be stable */
> > +	usleep_range(100, 200);
> > +
> > +	ret =3D brcm_pcie_setup(pcie);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pcie->suspended =3D false;
> > +
> > +	return 0;
> > +}
> > +
> > +static void _brcm_pcie_remove(struct brcm_pcie *pcie)
> > +{
> > +	turn_off(pcie);
> > +	clk_disable_unprepare(pcie->clk);
> > +	clk_put(pcie->clk);
> > +}
> > +
> > +static int brcm_pcie_remove(struct platform_device *pdev)
> > +{
> > +	struct brcm_pcie *pcie =3D platform_get_drvdata(pdev);
> > +
> > +	pci_stop_root_bus(pcie->root_bus);
> > +	pci_remove_root_bus(pcie->root_bus);
> > +	_brcm_pcie_remove(pcie);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id brcm_pcie_match[] =3D {
> > +	{ .compatible =3D "brcm,bcm2711-pcie", .data =3D &bcm2711_cfg },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, brcm_pcie_match);
> > +
> > +static int brcm_pcie_probe(struct platform_device *pdev)
> > +{
> > +	struct device_node *dn =3D pdev->dev.of_node;
> > +	const struct of_device_id *of_id;
> > +	const struct pcie_cfg_data *data;
> > +	struct resource *res;
> > +	int ret;
> > +	struct brcm_pcie *pcie;
> > +	void __iomem *base;
> > +	struct pci_host_bridge *bridge;
> > +	struct pci_bus *child;
> > +
> > +	bridge =3D devm_pci_alloc_host_bridge(&pdev->dev, sizeof(*pcie));
> > +	if (!bridge)
> > +		return -ENOMEM;
> > +
> > +	pcie =3D pci_host_bridge_priv(bridge);
> > +
> > +	of_id =3D of_match_node(brcm_pcie_match, dn);
> > +	if (!of_id) {
> > +		dev_err(&pdev->dev, "failed to look up compatible string\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	data =3D of_id->data;
> > +	pcie->reg_offsets =3D data->offsets;
> > +	pcie->reg_field_info =3D data->reg_field_info;
> > +	pcie->type =3D data->type;
> > +	pcie->dn =3D dn;
> > +	pcie->dev =3D &pdev->dev;
> > +
> > +	/* We use the domain number as our controller number */
> > +	pcie->id =3D of_get_pci_domain_nr(dn);
> > +	if (pcie->id < 0)
> > +		return pcie->id;
> > +
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res)
> > +		return -EINVAL;
> > +
> > +	base =3D devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(base))
> > +		return PTR_ERR(base);
> > +
> > +	pcie->clk =3D of_clk_get_by_name(dn, "sw_pcie");
> > +	if (IS_ERR(pcie->clk)) {
> we should handle EPROBE_DEFER here

Yes, I'll keep it in mind.

> > +		dev_err(&pdev->dev, "could not get clock\n");
> > +		pcie->clk =3D NULL;
> > +	}
> > +	pcie->base =3D base;
> > +
> > +	ret =3D of_pci_get_max_link_speed(dn);
> > +	pcie->gen =3D (ret < 0) ? 0 : ret;
> > +
> > +	pcie->ssc =3D of_property_read_bool(dn, "brcm,enable-ssc");
> > +
> > +	ret =3D irq_of_parse_and_map(pdev->dev.of_node, 0);
> > +	if (ret =3D=3D 0)
> > +		/* keep going, as we don't use this intr yet */
> > +		dev_warn(pcie->dev, "cannot get PCIe interrupt\n");
> > +	else
> > +		pcie->irq =3D ret;
> > +
> > +	ret =3D pci_parse_request_of_pci_ranges(pcie->dev, &bridge->windows,
> > +					      &bridge->dma_ranges, NULL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D clk_prepare_enable(pcie->clk);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "could not enable clock\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D brcm_pcie_setup(pcie);
> > +	if (ret)
> > +		goto fail;
> > +
> > +	bridge->dev.parent =3D &pdev->dev;
> > +	bridge->busnr =3D 0;
> > +	bridge->ops =3D &brcm_pcie_ops;
> > +	bridge->sysdata =3D pcie;
> > +	bridge->map_irq =3D of_irq_parse_and_map_pci;
> > +	bridge->swizzle_irq =3D pci_common_swizzle;
> > +
> > +	ret =3D pci_scan_root_bus_bridge(bridge);
> > +	if (ret < 0) {
> > +		dev_err(pcie->dev, "Scanning root bridge failed\n");
> > +		goto fail;
> > +	}
> > +
> > +	pci_assign_unassigned_bus_resources(bridge->bus);
> > +	list_for_each_entry(child, &bridge->bus->children, node)
> > +		pcie_bus_configure_settings(child);
> > +	pci_bus_add_devices(bridge->bus);
> > +	platform_set_drvdata(pdev, pcie);
> > +	pcie->root_bus =3D bridge->bus;
> > +
> > +	return 0;
> > +
> > +fail:
> > +	_brcm_pcie_remove(pcie);
> > +	return ret;
> > +}
> > +
> > +static const struct dev_pm_ops brcm_pcie_pm_ops =3D {
> > +	.suspend_noirq =3D brcm_pcie_suspend,
> > +	.resume_noirq =3D brcm_pcie_resume,
> > +};
> > +
> > +static struct platform_driver brcm_pcie_driver =3D {
> > +	.probe =3D brcm_pcie_probe,
> > +	.remove =3D brcm_pcie_remove,
> > +	.driver =3D {
> > +		.name =3D "brcm-pcie",
> > +		.owner =3D THIS_MODULE,
> This is already done by module_platform_driver

Noted

> > +		.of_match_table =3D brcm_pcie_match,
> > +		.pm =3D &brcm_pcie_pm_ops,
> > +	},
> > +};
> > +
> > +module_platform_driver(brcm_pcie_driver);
> > +
> > +MODULE_LICENSE("GPL v2");
>=20
> This is a mismatch to the SPDX (GPL 2 and higher), because this says GPL
> v2 only

Noted

Regards,
Nicolas


--=-7LN/3ZhiuzOWe383zsu9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3FTdAACgkQlfZmHno8
x/4phggAp6vKbULup21um9NuRa1mXPrMJTBuptz2RdcIJ8hKYs6itL0vP/dyYCsK
es3Ibkd6EUWwX6yYlKPCGju0kvsZwR1DQ+Nqwmz/yW2abbKRt7K0e0m7xsnSzGmI
D5C4SZh9LLdjwEcUFq27ZoDG9SbkxXoAzivEZ4oumhLQJa1ie+PdjJ0gJKN0t5pD
XflTJ7sAIU3jNf0SucygBLVDzrnn3fO6Ml/D/qr7m2VfzqKKrods5SsBsqL2NjJ3
KxVUMP0Pk3rj3l85bmUXL1Awab2s6BMPYAXmKDZHerAcc3VMtAW55Pm85mPtIh6w
yZFRF088gUmXSdz9DmRTV59q9UqvNA==
=3++k
-----END PGP SIGNATURE-----

--=-7LN/3ZhiuzOWe383zsu9--

