Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4BB6F363A
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 18:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbfKGRwg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 12:52:36 -0500
Received: from mout.gmx.net ([212.227.17.22]:52331 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbfKGRwe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 12:52:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573149052;
        bh=OwtuhNAIJaNQjbKPqzEL4/P8L+3KwPZ3DY2zwTd8dEY=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:References:Date:In-Reply-To;
        b=Ev45NPl8Yn4BKXfTfJhUTafDYkjFc+HJyu28UHs3m9iE+FxH8HNHm0MeJ0YgJ/tU0
         0Nr5ScKyFFrzuw6urElSrUTEH9FQXbEkAGuiosPnbLka+PTX4j/bSetvX/8iDrTGj/
         6heNS4oYZqFRB6zRpCdnBLX8ZV5K57RAKFx+7Ukk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.167] ([37.4.249.112]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mq2jC-1i7TrS2Blq-00nAI0; Thu, 07
 Nov 2019 18:50:52 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 3/4] PCI: brcmstb: add Broadcom STB PCIe host controller
 driver
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
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
References: <20191106214527.18736-1-nsaenzjulienne@suse.de>
 <20191106214527.18736-4-nsaenzjulienne@suse.de>
Message-ID: <87e5117a-f8ff-2a1b-379b-5f43383aa7c0@gmx.net>
Date:   Thu, 7 Nov 2019 18:50:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106214527.18736-4-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:JK5O2wzCrNR0Cqnn7NmOYx+uUs1GE+Mk5KrnpZOPjRlpt8a1bBD
 FYEPQhVt0bHqNgMgLC07gA/KBLfT00eWBH8YhnKl7w8mcHT1KCMAXCXEm79qJc6K3b6GKzU
 iTl4ug3A4ZzRV2iv5gzlJ3NEGwWZGWKHgwpGc7eOcaUpyQP36lkf/djw7zNuv+HNgM1TTkZ
 Huh/Nv3T754hpzFeWD7IQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+Q/nDJ0bno4=:xHdP/9PpYxjCdQurf9bp1T
 /UTb38E+BR0113EpyUnuK4rR12xjMNwfTtBim36GJfI0WZF0p8yiAwAJL9lN54sqfIZb3SAqa
 Yd2jctScMDAn30gsbogJorJ7WcO9DzbStMgLGD9PUFFeOdK2j3njEia0omBW06DmLma9SPv4Y
 sUpi/NIaWIp6kw0t0yrUeCb+8SrY5JJIoA/SaTjMmmIdYC8AAq3qq3DO2gJGRbz7I5yefQdwn
 7RU1BvGXfPZQ0UFloxhT7ywjuF4L97jFMsevWwMrQLW8niG9W5yO+GwX3Wpx9Tk//xwACrZMt
 /QW61pROJoXhwqvoWuErQokuit/FZxIcRXlxmEeCSr3SAU7quDleYvsOfvlwFLtsLLAJFc9qQ
 /8aipWO/c7mPSGozYSqQlw+HMDZVRg9M1B8apf5UMr5bCDyYZF2H4xMQVoy9IW1bP0AAPgOxT
 /J1gaT8orGzG4k+AlH8roSCi23NeRGTWCJSL5OBUGr8d7oI43HM8EB7wzuOqYKHzFBy61AYMc
 uGoJhR/W/YL0MYEga1Xp+ML6BdfEfLUefUrRas36tQpNA9GHSwe+ujdVKjyZrH+aCkm4W1CHY
 pzcvLPws/mRzgZb4AGhszRJKWp0UyVfWbLuM8UFfU3CUIalyIBlBngV6ltJ0ug/OKGutE6TJj
 +JZsoqi3jYnutHrSRMnjQWYDfDE+xUXPJ0cTXp1Pdy6FVyPNpRt8Aeza9E9dcj5hHlPRqVG+G
 FkwzxBZGXgkJUQwDiPcYVMVsLcVi/1Fn97wLxn3B9I5ttwtexFl7e2rY3I2doVGpHCpKuOxUS
 u9V+Y4Nbx3KDsDtj/o+Meaq/aFjHdNHxu1Xf//GyOO2YkOOy9WUFqedcf1tfz+0JtK85d3FLp
 wt8WClNkpwr5cgNONqmpsxoCw2wzlKlZ42P6rv0r8KggF9aQKbd/kke7zM8iMNkIzU89rnbxh
 IlfPSo88tbhU3I/QvNKr5F2QBpLvbIsmSW8sddNP5v/rFGBh87Rw/h+dr+T/PsPqf6ntwB/zE
 TKiLyooZQJy1O/Ch+pdz96PbPXXzzRgzGq2fWdDxsBe9d4MOYa4FaHYZJ1gYWs64X8x4dbsyz
 jPGiGwaibkxBaZ6OKIgsH+jZ/rYCnjtoABjzFUCMFImJi7m7z98gBXxp9ZS1W30IjOUrLqYVg
 9LGR1VniHuO+b5+ouxLFKNU1uubw2sj4TLztAU0O8tFzRopc6JbfORaFUQ5EY73oEzOb7emOT
 3qjgeeaCcEGIAnv+Z628F3gY7aJqsYoQjwwVeQdE72UJrlDDOc+zQXEIx0Z4=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nicolas,

Am 06.11.19 um 22:45 schrieb Nicolas Saenz Julienne:
> From: Jim Quinlan <james.quinlan@broadcom.com>
>
> This commit adds the basic Broadcom STB PCIe controller.  Missing is the
> ability to process MSI. This functionality is added in a subsequent
> commit.
>
> The PCIe block contains an MDIO interface.  This is a local interface
> only accessible by the PCIe controller.  It cannot be used or shared
> by any other HW.  As such, the small amount of code for this
> controller is included in this driver as there is little upside to put
> it elsewhere.
>
> This is based on Jim's original submission[1] but adapted and tailored
> specifically to bcm2711's needs (that's the Raspberry Pi 4). Support for
> the rest of the brcmstb family will soon follow once we get support for
> multiple dma-ranges in dma/direct.
>
> [1] https://patchwork.kernel.org/patch/10605959/
>
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Co-developed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/pci/controller/Kconfig        |  12 +
>  drivers/pci/controller/Makefile       |   1 +
>  drivers/pci/controller/pcie-brcmstb.c | 973 ++++++++++++++++++++++++++
>  3 files changed, 986 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-brcmstb.c
>
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kco=
nfig
> index f5de9119e8d3..8b3aae91d8af 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -281,6 +281,18 @@ config VMD
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called vmd.
>
> +config PCIE_BRCMSTB
> +	bool "Broadcom Brcmstb PCIe host controller"
looking at the driver suggests me a tristate instead of bool.
> +	depends on ARCH_BRCMSTB || BMIPS_GENERIC
please add ARCH_BCM2835 for the Raspberry Pi 4
> +	depends on OF
> +	depends on SOC_BRCMSTB
Why is this needed?
> +	default ARCH_BRCMSTB || BMIPS_GENERIC
also this needs ARCH_BCM2835
> +	help
> +	  Say Y here to enable PCIe host controller support for
> +	  Broadcom Settop Box SOCs.  A Broadcom SOC will may have
> +	  multiple host controllers as opposed to a single host
> +	  controller with multiple ports.
> +
>  config PCI_HYPERV_INTERFACE
>  	tristate "Hyper-V PCI Interface"
>  	depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && X86_64
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Ma=
kefile
> index a2a22c9d91af..3fc0b0cf5b5b 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_PCIE_MEDIATEK) +=3D pcie-mediatek.o
>  obj-$(CONFIG_PCIE_MOBIVEIL) +=3D pcie-mobiveil.o
>  obj-$(CONFIG_PCIE_TANGO_SMP8759) +=3D pcie-tango.o
>  obj-$(CONFIG_VMD) +=3D vmd.o
> +obj-$(CONFIG_PCIE_BRCMSTB) +=3D pcie-brcmstb.o
>  # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
>  obj-y				+=3D dwc/
>
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/control=
ler/pcie-brcmstb.c
> new file mode 100644
> index 000000000000..880ec11d06a1
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -0,0 +1,973 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2009 - 2019 Broadcom */
> +
> +#include <linux/clk.h>
> +#include <linux/compiler.h>
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/log2.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/pci.h>
> +#include <linux/printk.h>
> +#include <linux/sizes.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +#include "../pci.h"
> +
> ...
>
> +
> +/* L23 is a low-power PCIe link state */
> +static void enter_l23(struct brcm_pcie *pcie)
> +{
> +	void __iomem *base =3D pcie->base;
> +	int l23, i;
> +
> +	/* assert request for L23 */
> +	WR_FLD_RB(base, PCIE_MISC_PCIE_CTRL, PCIE_L23_REQUEST, 1);
> +
> +	/* Wait up to 30 msec for L23 */
36 msec?
> +	l23 =3D RD_FLD(base, PCIE_MISC_PCIE_STATUS, PCIE_LINK_IN_L23);
> +	for (i =3D 0; i < 15 && !l23; i++) {
> +		usleep_range(2000, 2400);
> +		l23 =3D RD_FLD(base, PCIE_MISC_PCIE_STATUS, PCIE_LINK_IN_L23);
> +	}
> +
> +	if (!l23)
> +		dev_err(pcie->dev, "failed to enter L23\n");

I think most user don't know anything about L23.

How about:

failed to enter low-power link state

> +}
> +
> +static void turn_off(struct brcm_pcie *pcie)
> +{
> +	void __iomem *base =3D pcie->base;
> +
> +	if (brcm_pcie_link_up(pcie))
> +		enter_l23(pcie);
> +	/* Assert fundamental reset */
> +	brcm_pcie_perst_set(pcie, 1);
> +	/* Deassert request for L23 in case it was asserted */
> +	WR_FLD_RB(base, PCIE_MISC_PCIE_CTRL, PCIE_L23_REQUEST, 0);
> +	/* Turn off SerDes */
> +	WR_FLD_RB(base, PCIE_MISC_HARD_PCIE_HARD_DEBUG, SERDES_IDDQ, 1);
> +	/* Shutdown PCIe bridge */
> +	brcm_pcie_bridge_sw_init_set(pcie, 1);
> +}
> +
> +static int brcm_pcie_suspend(struct device *dev)
> +{
> +	struct brcm_pcie *pcie =3D dev_get_drvdata(dev);
> +
> +	turn_off(pcie);
> +	clk_disable_unprepare(pcie->clk);
> +	pcie->suspended =3D true;
> +
> +	return 0;
> +}
> +
> +static int brcm_pcie_resume(struct device *dev)
> +{
> +	struct brcm_pcie *pcie =3D dev_get_drvdata(dev);
> +	void __iomem *base;
> +	int ret;
> +
> +	base =3D pcie->base;
> +	clk_prepare_enable(pcie->clk);
> +
> +	/* Take bridge out of reset so we can access the SerDes reg */
> +	brcm_pcie_bridge_sw_init_set(pcie, 0);
> +
> +	/* Turn on SerDes */
> +	WR_FLD_RB(base, PCIE_MISC_HARD_PCIE_HARD_DEBUG, SERDES_IDDQ, 0);
> +	/* Wait for SerDes to be stable */
> +	usleep_range(100, 200);
> +
> +	ret =3D brcm_pcie_setup(pcie);
> +	if (ret)
> +		return ret;
> +
> +	pcie->suspended =3D false;
> +
> +	return 0;
> +}
> +
> +static void _brcm_pcie_remove(struct brcm_pcie *pcie)
> +{
> +	turn_off(pcie);
> +	clk_disable_unprepare(pcie->clk);
> +	clk_put(pcie->clk);
> +}
> +
> +static int brcm_pcie_remove(struct platform_device *pdev)
> +{
> +	struct brcm_pcie *pcie =3D platform_get_drvdata(pdev);
> +
> +	pci_stop_root_bus(pcie->root_bus);
> +	pci_remove_root_bus(pcie->root_bus);
> +	_brcm_pcie_remove(pcie);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id brcm_pcie_match[] =3D {
> +	{ .compatible =3D "brcm,bcm2711-pcie", .data =3D &bcm2711_cfg },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, brcm_pcie_match);
> +
> +static int brcm_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device_node *dn =3D pdev->dev.of_node;
> +	const struct of_device_id *of_id;
> +	const struct pcie_cfg_data *data;
> +	struct resource *res;
> +	int ret;
> +	struct brcm_pcie *pcie;
> +	void __iomem *base;
> +	struct pci_host_bridge *bridge;
> +	struct pci_bus *child;
> +
> +	bridge =3D devm_pci_alloc_host_bridge(&pdev->dev, sizeof(*pcie));
> +	if (!bridge)
> +		return -ENOMEM;
> +
> +	pcie =3D pci_host_bridge_priv(bridge);
> +
> +	of_id =3D of_match_node(brcm_pcie_match, dn);
> +	if (!of_id) {
> +		dev_err(&pdev->dev, "failed to look up compatible string\n");
> +		return -EINVAL;
> +	}
> +
> +	data =3D of_id->data;
> +	pcie->reg_offsets =3D data->offsets;
> +	pcie->reg_field_info =3D data->reg_field_info;
> +	pcie->type =3D data->type;
> +	pcie->dn =3D dn;
> +	pcie->dev =3D &pdev->dev;
> +
> +	/* We use the domain number as our controller number */
> +	pcie->id =3D of_get_pci_domain_nr(dn);
> +	if (pcie->id < 0)
> +		return pcie->id;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
> +
> +	base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	pcie->clk =3D of_clk_get_by_name(dn, "sw_pcie");
> +	if (IS_ERR(pcie->clk)) {
we should handle EPROBE_DEFER here
> +		dev_err(&pdev->dev, "could not get clock\n");
> +		pcie->clk =3D NULL;
> +	}
> +	pcie->base =3D base;
> +
> +	ret =3D of_pci_get_max_link_speed(dn);
> +	pcie->gen =3D (ret < 0) ? 0 : ret;
> +
> +	pcie->ssc =3D of_property_read_bool(dn, "brcm,enable-ssc");
> +
> +	ret =3D irq_of_parse_and_map(pdev->dev.of_node, 0);
> +	if (ret =3D=3D 0)
> +		/* keep going, as we don't use this intr yet */
> +		dev_warn(pcie->dev, "cannot get PCIe interrupt\n");
> +	else
> +		pcie->irq =3D ret;
> +
> +	ret =3D pci_parse_request_of_pci_ranges(pcie->dev, &bridge->windows,
> +					      &bridge->dma_ranges, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D clk_prepare_enable(pcie->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "could not enable clock\n");
> +		return ret;
> +	}
> +
> +	ret =3D brcm_pcie_setup(pcie);
> +	if (ret)
> +		goto fail;
> +
> +	bridge->dev.parent =3D &pdev->dev;
> +	bridge->busnr =3D 0;
> +	bridge->ops =3D &brcm_pcie_ops;
> +	bridge->sysdata =3D pcie;
> +	bridge->map_irq =3D of_irq_parse_and_map_pci;
> +	bridge->swizzle_irq =3D pci_common_swizzle;
> +
> +	ret =3D pci_scan_root_bus_bridge(bridge);
> +	if (ret < 0) {
> +		dev_err(pcie->dev, "Scanning root bridge failed\n");
> +		goto fail;
> +	}
> +
> +	pci_assign_unassigned_bus_resources(bridge->bus);
> +	list_for_each_entry(child, &bridge->bus->children, node)
> +		pcie_bus_configure_settings(child);
> +	pci_bus_add_devices(bridge->bus);
> +	platform_set_drvdata(pdev, pcie);
> +	pcie->root_bus =3D bridge->bus;
> +
> +	return 0;
> +
> +fail:
> +	_brcm_pcie_remove(pcie);
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops brcm_pcie_pm_ops =3D {
> +	.suspend_noirq =3D brcm_pcie_suspend,
> +	.resume_noirq =3D brcm_pcie_resume,
> +};
> +
> +static struct platform_driver brcm_pcie_driver =3D {
> +	.probe =3D brcm_pcie_probe,
> +	.remove =3D brcm_pcie_remove,
> +	.driver =3D {
> +		.name =3D "brcm-pcie",
> +		.owner =3D THIS_MODULE,
This is already done by module_platform_driver
> +		.of_match_table =3D brcm_pcie_match,
> +		.pm =3D &brcm_pcie_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(brcm_pcie_driver);
> +
> +MODULE_LICENSE("GPL v2");

This is a mismatch to the SPDX (GPL 2 and higher), because this says GPL
v2 only

Thanks
Stefan

> +MODULE_DESCRIPTION("Broadcom STB PCIe RC driver");
> +MODULE_AUTHOR("Broadcom");
