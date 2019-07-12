Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA0E067050
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 15:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfGLNmf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jul 2019 09:42:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbfGLNme (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Jul 2019 09:42:34 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0F4920863;
        Fri, 12 Jul 2019 13:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562938952;
        bh=sX2Tj+ooiTQwrhN1gPovj4F+xH5PcTENwNeil/xWTPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MyD1bfAop1C7kq4kmy/3la7CfntOOcVB7mBnD2TgJF/7yopGdJYylUpEkbIl8qPrv
         9+gDXxBF/sDXqcRLUzH+jV73w3Pzd/I8v0GXGT80NFAvaoQ4AjaegD9KD3L0vbWMbI
         7JvA4F/uDN0xifWgpJsPQ0SqIFUXz3TKEhqXYE2Q=
Date:   Fri, 12 Jul 2019 08:42:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Chocron <jonnyc@amazon.com>
Cc:     lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, robh+dt@kernel.org,
        mark.rutland@arm.com, dwmw@amazon.co.uk, benh@kernel.crashing.org,
        alisaidi@amazon.com, ronenk@amazon.com, barakw@amazon.com,
        talel@amazon.com, hanochu@amazon.com, hhhawa@amazon.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 6/8] PCI: al: Add support for DW based driver type
Message-ID: <20190712134217.GD46935@google.com>
References: <20190710164519.17883-1-jonnyc@amazon.com>
 <20190710164519.17883-7-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710164519.17883-7-jonnyc@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 11, 2019 at 05:57:05PM +0300, Jonathan Chocron wrote:
> This driver is DT based and utilizes the DesignWare APIs.
> It allows using a smaller ECAM range for a larger bus range -
> usually an entire bus uses 1MB of address space, but the driver
> can use it for a larger number of buses.
> 
> All link initializations are handled by the boot FW.
> 
> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> ---
>  drivers/pci/controller/dwc/Kconfig   |  11 +
>  drivers/pci/controller/dwc/pcie-al.c | 397 +++++++++++++++++++++++++++
>  2 files changed, 408 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index a6ce1ee51b4c..51da9cb219aa 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -230,4 +230,15 @@ config PCIE_UNIPHIER
>  	  Say Y here if you want PCIe controller support on UniPhier SoCs.
>  	  This driver supports LD20 and PXs3 SoCs.
>  
> +config PCIE_AL
> +	bool "Amazon Annapurna Labs PCIe controller"
> +	depends on OF && (ARM64 || COMPILE_TEST)
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIE_DW_HOST
> +	help
> +	  Say Y here to enable support of the Annapurna Labs PCIe controller IP
> +	  on Amazon SoCs.
> +	  The PCIe controller uses the DesignWare core plus
> +	  Amazon-specific hardware wrappers.

Is this one paragraph or two?

This should mention the fact that only DT platforms need
CONFIG_PCIE_AL.  ACPI platforms with the Annapurna Labs PCIe
controller don't need this.

> +
>  endmenu
> diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
> index 3ab58f0584a8..2742a0895aab 100644
> --- a/drivers/pci/controller/dwc/pcie-al.c
> +++ b/drivers/pci/controller/dwc/pcie-al.c
> @@ -91,3 +91,400 @@ struct pci_ecam_ops al_pcie_ops = {
>  };
>  
>  #endif /* defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS) */
> +
> +#ifdef CONFIG_PCIE_AL
> +
> +#include <linux/of_pci.h>
> +#include "pcie-designware.h"
> +
> +#define AL_PCIE_REV_ID_2	2
> +#define AL_PCIE_REV_ID_3	3
> +#define AL_PCIE_REV_ID_4	4
> +
> +/* The AXI regs are always at the beginning of the PCIE controller reg space. */
> +#define AXI_BASE_OFFSET		0x0
> +
> +#define DEVICE_ID_OFFSET	0x16c
> +
> +#define DEVICE_REV_ID			0x0
> +#define DEVICE_REV_ID_DEV_ID_MASK	0xFFFF0000
> +#define DEVICE_REV_ID_DEV_ID_SHIFT	16
> +
> +#define DEVICE_REV_ID_DEV_ID_X4		(0 << DEVICE_REV_ID_DEV_ID_SHIFT)
> +#define DEVICE_REV_ID_DEV_ID_X8		(2 << DEVICE_REV_ID_DEV_ID_SHIFT)
> +#define DEVICE_REV_ID_DEV_ID_X16	(4 << DEVICE_REV_ID_DEV_ID_SHIFT)
> +
> +/* The ob_ctrl offset inside the axi regs is different between revisions.
> + */

s/axi/AXI/ to be consistent.

Fix comment style (either single-line with "/* ... */" or multi-line
with "/*" on first line and "*/" on last line).

> +#define OB_CTRL_REV1_2_OFFSET	0x0040
> +#define OB_CTRL_REV3_5_OFFSET	0x0030
> +
> +#define CFG_TARGET_BUS			0x0
> +#define CFG_TARGET_BUS_MASK_SHIFT	0
> +#define CFG_TARGET_BUS_BUSNUM_SHIFT	8
> +
> +#define CFG_CONTROL			0x4
> +#define CFG_CONTROL_SUBBUS_MASK		0x0000FF00
> +#define CFG_CONTROL_SUBBUS_SHIFT	8
> +#define CFG_CONTROL_SEC_BUS_MASK	0x00FF0000
> +#define CFG_CONTROL_SEC_BUS_SHIFT	16
> +
> +struct al_pcie_reg_offsets {
> +	unsigned int ob_ctrl;
> +};
> +
> +struct al_pcie_target_bus_cfg {
> +	u8 reg_val;
> +	u8 reg_mask;
> +	u8 ecam_mask;
> +};
> +
> +struct al_pcie {
> +	struct dw_pcie	*pci;
> +	void __iomem	*controller_base; /* base of PCIe unit (not DW core) */
> +	void __iomem	*dbi_base;

I *guess* this is different from the dw_pcie.dbi_base?

> +	resource_size_t ecam_size;
> +	struct device *dev;
> +	unsigned int controller_rev_id;
> +	struct al_pcie_reg_offsets reg_offsets;
> +	struct al_pcie_target_bus_cfg target_bus_cfg;
> +};
> +
> +#define PCIE_ECAM_DEVFN(x)		(((x) & 0xff) << 12)
> +
> +#define to_al_pcie(x)		dev_get_drvdata((x)->dev)
> +
> +static int al_pcie_rev_id_get(struct al_pcie *pcie, unsigned int *rev_id)

I think al_pcie_rev_id_get() and al_pcie_reg_offsets_set() are more
complicated than necessary, at least for the current code.  All you're
really using is something like this:

  static void al_pcie_rev_id_get(...)
  {
    ...
    switch (dev_rev_id) {
    case DEVICE_REV_ID_DEV_ID_X4:
      pcie->reg_offsets.ob_ctrl = OB_CTRL_REV1_2_OFFSET;
      break;
    case DEVICE_REV_ID_DEV_ID_X8:
    case DEVICE_REV_ID_DEV_ID_X16:
      pcie->reg_offsets.ob_ctrl = OB_CTRL_REV3_5_OFFSET;
      break;
    default:
      dev_err("unsupported rev_id\n");
      break;
    }
  }

> +{
> +	void __iomem *dev_rev_id_addr;
> +	u32 dev_rev_id;
> +
> +	dev_rev_id_addr = (void __iomem *)((uintptr_t)pcie->controller_base +
> +			  AXI_BASE_OFFSET + DEVICE_ID_OFFSET + DEVICE_REV_ID);
> +
> +	dev_rev_id = readl(dev_rev_id_addr) & DEVICE_REV_ID_DEV_ID_MASK;
> +
> +	switch (dev_rev_id) {
> +	case DEVICE_REV_ID_DEV_ID_X4:
> +		*rev_id = AL_PCIE_REV_ID_2;
> +		break;
> +	case DEVICE_REV_ID_DEV_ID_X8:
> +		*rev_id = AL_PCIE_REV_ID_3;
> +		break;
> +	case DEVICE_REV_ID_DEV_ID_X16:
> +		*rev_id = AL_PCIE_REV_ID_4;
> +		break;
> +	default:
> +		dev_err(pcie->dev, "Unsupported dev_rev_id (0x%08x)\n",
> +			dev_rev_id);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(pcie->dev, "dev_rev_id: 0x%08x\n", dev_rev_id);
> +
> +	return 0;
> +}
> +
> +static int al_pcie_reg_offsets_set(struct al_pcie *pcie)
> +{
> +	switch (pcie->controller_rev_id) {
> +	case AL_PCIE_REV_ID_2:
> +		pcie->reg_offsets.ob_ctrl = OB_CTRL_REV1_2_OFFSET;
> +		break;
> +	case AL_PCIE_REV_ID_3:
> +	case AL_PCIE_REV_ID_4:
> +		pcie->reg_offsets.ob_ctrl = OB_CTRL_REV3_5_OFFSET;
> +		break;
> +	default:
> +		dev_err(pcie->dev, "Unsupported controller rev_id: 0x%x\n",
> +			pcie->controller_rev_id);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static inline void al_pcie_target_bus_set(struct al_pcie *pcie,
> +					  u8 target_bus,
> +					  u8 mask_target_bus)
> +{
> +	void __iomem *cfg_control_addr;
> +	u32 reg = (target_bus << CFG_TARGET_BUS_BUSNUM_SHIFT) |
> +		       mask_target_bus;
> +
> +	cfg_control_addr = (void __iomem *)((uintptr_t)pcie->controller_base +
> +			   AXI_BASE_OFFSET + pcie->reg_offsets.ob_ctrl +
> +			   CFG_TARGET_BUS);
> +
> +	writel(reg, cfg_control_addr);
> +}
> +
> +static void __iomem *al_pcie_conf_addr_map(struct al_pcie *pcie,
> +					   unsigned int busnr,
> +					   unsigned int devfn)
> +{
> +	void __iomem *pci_base_addr;
> +	struct pcie_port *pp = &pcie->pci->pp;
> +	struct al_pcie_target_bus_cfg *target_bus_cfg = &pcie->target_bus_cfg;
> +	unsigned int busnr_ecam = busnr & target_bus_cfg->ecam_mask;
> +	unsigned int busnr_reg = busnr & target_bus_cfg->reg_mask;
> +
> +	pci_base_addr = (void __iomem *)((uintptr_t)pp->va_cfg0_base +
> +				 (busnr_ecam << 20) +
> +				 PCIE_ECAM_DEVFN(devfn));
> +
> +	if (busnr_reg != target_bus_cfg->reg_val) {
> +		dev_dbg(pcie->pci->dev, "Changing target bus busnum val from %d to %d\n",
> +			target_bus_cfg->reg_val, busnr_reg);
> +		target_bus_cfg->reg_val = busnr_reg;
> +		al_pcie_target_bus_set(pcie,
> +				       target_bus_cfg->reg_val,
> +				       target_bus_cfg->reg_mask);
> +	}
> +
> +	return pci_base_addr;
> +}
> +
> +static int al_pcie_rd_other_conf(struct pcie_port *pp,
> +				 struct pci_bus *bus,
> +				 unsigned int devfn,
> +				 int where,
> +				 int size,
> +				 u32 *val)

Rewrap to use fewer lines.

> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct al_pcie *pcie = to_al_pcie(pci);
> +	unsigned int busnr = bus->number;
> +	void __iomem *pci_addr;
> +	int rc;
> +
> +	pci_addr = al_pcie_conf_addr_map(pcie, busnr, devfn);
> +
> +	rc = dw_pcie_read(pci_addr + where, size, val);
> +
> +	dev_dbg(pci->dev, "%d-byte config read from %04x:%02x:%02x.%d offset %#x (pci_addr: 0x%p) - val:0x%x\n",
> +		size, pci_domain_nr(bus), bus->number,
> +		PCI_SLOT(devfn), PCI_FUNC(devfn), where,
> +		(pci_addr + where), *val);
> +
> +	return rc;
> +}
> +
> +static int al_pcie_wr_other_conf(struct pcie_port *pp,
> +				 struct pci_bus *bus,
> +				 unsigned int devfn,
> +				 int where,
> +				 int size,
> +				 u32 val)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct al_pcie *pcie = to_al_pcie(pci);
> +	unsigned int busnr = bus->number;
> +	void __iomem *pci_addr;
> +	int rc;
> +
> +	pci_addr = al_pcie_conf_addr_map(pcie, busnr, devfn);
> +
> +	rc = dw_pcie_write(pci_addr + where, size, val);
> +
> +	dev_dbg(pci->dev, "%d-byte config write to %04x:%02x:%02x.%d offset %#x (pci_addr: 0x%p) - val:0x%x\n",
> +		size, pci_domain_nr(bus), bus->number,
> +		PCI_SLOT(devfn), PCI_FUNC(devfn), where,
> +		(pci_addr + where), val);
> +
> +	return rc;
> +}
> +
> +static int al_pcie_config_prepare(struct al_pcie *pcie)
> +{
> +	struct al_pcie_target_bus_cfg *target_bus_cfg;
> +	struct pcie_port *pp = &pcie->pci->pp;
> +	unsigned int ecam_bus_mask;
> +	u8 secondary_bus;
> +	u8 subordinate_bus;
> +	void __iomem *cfg_control_addr;
> +	u32 cfg_control;
> +	u32 reg = 0;

Why is this initialized?  It doesn't look like it can be used before
being set.

> +	target_bus_cfg = &pcie->target_bus_cfg;
> +
> +	ecam_bus_mask = (pcie->ecam_size >> 20) - 1;
> +	if (ecam_bus_mask > 255) {
> +		dev_warn(pcie->dev, "ECAM window size is larger than 256MB. Cutting off at 256\n");
> +		ecam_bus_mask = 255;
> +	}
> +
> +	/* This portion is taken from the transaction address */
> +	target_bus_cfg->ecam_mask = ecam_bus_mask;
> +	/* This portion is taken from the cfg_target_bus reg */
> +	target_bus_cfg->reg_mask = ~target_bus_cfg->ecam_mask;
> +	target_bus_cfg->reg_val = pp->busn->start & target_bus_cfg->reg_mask;
> +
> +	al_pcie_target_bus_set(pcie,
> +			       target_bus_cfg->reg_val,
> +			       target_bus_cfg->reg_mask);
> +
> +	secondary_bus = pp->busn->start + 1;
> +	subordinate_bus = pp->busn->end;
> +
> +	/* Set the valid values of secondary and subordinate buses */
> +	cfg_control_addr = pcie->controller_base +
> +		AXI_BASE_OFFSET + pcie->reg_offsets.ob_ctrl + CFG_CONTROL;
> +
> +	cfg_control = readl(cfg_control_addr);
> +
> +	reg = (cfg_control & ~CFG_CONTROL_SEC_BUS_MASK) |
> +	       (secondary_bus << CFG_CONTROL_SEC_BUS_SHIFT);
> +	reg = (reg & ~CFG_CONTROL_SUBBUS_MASK) |
> +	       (subordinate_bus << CFG_CONTROL_SUBBUS_SHIFT);
> +
> +	writel(reg, cfg_control_addr);
> +
> +	return 0;
> +}
> +
> +static int al_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct al_pcie *pcie = to_al_pcie(pci);
> +	int link_up = 0;
> +	u32 reg = 0;

Why initialize link_up and reg?

> +	int rc;
> +
> +	reg = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE);
> +	if (reg != PCI_HEADER_TYPE_BRIDGE) {
> +		dev_err(pci->dev, "PCIe controller is not set to bridge type (%d)!\n",
> +			reg);
> +		return -EIO;
> +	}
> +
> +	link_up = dw_pcie_link_up(pci);
> +	if (!link_up) {
> +		dev_err(pci->dev, "link in not up!\n");

s/in/is/

> +		return -ENOLINK;
> +	}
> +
> +	dev_info(pci->dev, "link is up\n");
> +
> +	rc = al_pcie_rev_id_get(pcie, &pcie->controller_rev_id);
> +	if (rc)
> +		return rc;
> +
> +	rc = al_pcie_reg_offsets_set(pcie);
> +	if (rc)
> +		return rc;
> +
> +	rc = al_pcie_config_prepare(pcie);
> +	if (rc)
> +		return rc;
> +
> +	return 0;
> +}
> +
> +static const struct dw_pcie_host_ops al_pcie_host_ops = {
> +	.rd_other_conf = al_pcie_rd_other_conf,
> +	.wr_other_conf = al_pcie_wr_other_conf,
> +	.host_init = al_pcie_host_init,
> +};
> +
> +static int al_add_pcie_port(struct pcie_port *pp,
> +			    struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	pp->ops = &al_pcie_host_ops;
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize host\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dw_pcie_ops dw_pcie_ops = {
> +};
> +
> +static int al_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct al_pcie *al_pcie;
> +	struct dw_pcie *pci;
> +	struct resource *dbi_res;
> +	struct resource *controller_res;
> +	struct resource *ecam_res;
> +	int ret;
> +
> +	al_pcie = devm_kzalloc(dev, sizeof(*al_pcie), GFP_KERNEL);
> +	if (!al_pcie)
> +		return -ENOMEM;
> +
> +	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> +	if (!pci)
> +		return -ENOMEM;
> +
> +	pci->dev = dev;
> +	pci->ops = &dw_pcie_ops;
> +
> +	al_pcie->pci = pci;
> +	al_pcie->dev = dev;
> +
> +	dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> +	pci->dbi_base = devm_pci_remap_cfg_resource(dev, dbi_res);
> +	if (IS_ERR(pci->dbi_base)) {
> +		dev_err(dev, "couldn't remap dbi base %p\n", dbi_res);

%pR (see below).

> +		return PTR_ERR(pci->dbi_base);
> +	}
> +
> +	ecam_res = platform_get_resource_byname(pdev,
> +						IORESOURCE_MEM,
> +						"config");
> +	if (!ecam_res) {
> +		dev_err(dev, "couldn't find 'config' reg in DT\n");
> +		return -ENOENT;
> +	}
> +	al_pcie->ecam_size = resource_size(ecam_res);
> +
> +	controller_res = platform_get_resource_byname(pdev,
> +						      IORESOURCE_MEM,
> +						      "controller");
> +	al_pcie->controller_base = devm_ioremap_resource(dev,
> +							 controller_res);

Several of these function calls would fit on one line, or at least
fewer than they currently use.

> +	if (IS_ERR(al_pcie->controller_base)) {
> +		dev_err(dev, "couldn't remap controller base %p\n",
> +			controller_res);

Use %pR.  I think this %p prints the address of the struct resource,
not the address you tried to map.

> +		return PTR_ERR(al_pcie->controller_base);
> +	}
> +
> +	dev_dbg(dev, "From DT: dbi_base: 0x%llx, controller_base: 0x%llx\n",
> +		dbi_res->start, controller_res->start);

Use %pR instead of printing dbi_res->start, controller_res->start.

> +
> +	platform_set_drvdata(pdev, al_pcie);
> +
> +	ret = al_add_pcie_port(&pci->pp, pdev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id al_pcie_of_match[] = {
> +	{ .compatible = "amazon,al-pcie",
> +	  .data = NULL,

".data = NULL" is unnecessary.

> +	},
> +	{},
> +};
> +
> +static struct platform_driver al_pcie_driver = {
> +	.driver = {
> +		.name	= "al-pcie",
> +		.of_match_table = al_pcie_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe = al_pcie_probe,
> +};
> +builtin_platform_driver(al_pcie_driver);
> +
> +#endif /* CONFIG_PCIE_AL*/
> -- 
> 2.17.1
> 
> 
