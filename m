Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 835D96CC3E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2019 11:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389845AbfGRJrw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jul 2019 05:47:52 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:54578 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfGRJrw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jul 2019 05:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1563443271; x=1594979271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=dFcxU8h/m/ZJQchVd2KEmDIwNYQepURf3sm5UuVZw+0=;
  b=uj9hDPXi3ywy7g8PVqlRgopUOmTWpk2gRrtkuKNjkz2EsiFv2/IYDl+w
   Zw6/K39fkm0zwh3EbGrOyv6lBUmqr4xY0rKUNCE5NayjNNWp495hDaRHt
   w0HduiSl+VQkNzaUOertXSXWK1czLSyUe3Od2l6ODjF2A7Mc+j1MRvirN
   k=;
X-IronPort-AV: E=Sophos;i="5.64,276,1559520000"; 
   d="scan'208";a="686208982"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 18 Jul 2019 09:47:46 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 5877CA17B6;
        Thu, 18 Jul 2019 09:47:43 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 18 Jul 2019 09:47:42 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.161.219) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 18 Jul 2019 09:47:36 +0000
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <alisaidi@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        <talel@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Subject: [PATCH v2 6/8] PCI: al: Add support for DW based driver type
Date:   Thu, 18 Jul 2019 12:47:16 +0300
Message-ID: <20190718094718.25083-2-jonnyc@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718094531.21423-1-jonnyc@amazon.com>
References: <20190718094531.21423-1-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.219]
X-ClientProxiedBy: EX13D19UWC001.ant.amazon.com (10.43.162.64) To
 EX13D13UWA001.ant.amazon.com (10.43.160.136)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This driver is DT based and utilizes the DesignWare APIs.
It allows using a smaller ECAM range for a larger bus range -
usually an entire bus uses 1MB of address space, but the driver
can use it for a larger number of buses.

All link initializations are handled by the boot FW.

Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
---
 drivers/pci/controller/dwc/Kconfig   |  12 +
 drivers/pci/controller/dwc/pcie-al.c | 373 +++++++++++++++++++++++++++
 2 files changed, 385 insertions(+)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 6ea778ae4877..3c6094cbcc3b 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -230,4 +230,16 @@ config PCIE_UNIPHIER
 	  Say Y here if you want PCIe controller support on UniPhier SoCs.
 	  This driver supports LD20 and PXs3 SoCs.
 
+config PCIE_AL
+	bool "Amazon Annapurna Labs PCIe controller"
+	depends on OF && (ARM64 || COMPILE_TEST)
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIE_DW_HOST
+	help
+	  Say Y here to enable support of the Amazon's Annapurna Labs PCIe
+	  controller IP on Amazon SoCs. The PCIe controller uses the DesignWare
+	  core plus Annapurna Labs proprietary hardware wrappers. This is
+	  required only for DT-based platforms. ACPI platforms with the
+	  Annapurna Labs PCIe controller don't need to enable this.
+
 endmenu
diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
index 3ab58f0584a8..40555532fb9a 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -91,3 +91,376 @@ struct pci_ecam_ops al_pcie_ops = {
 };
 
 #endif /* defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS) */
+
+#ifdef CONFIG_PCIE_AL
+
+#include <linux/of_pci.h>
+#include "pcie-designware.h"
+
+#define AL_PCIE_REV_ID_2	2
+#define AL_PCIE_REV_ID_3	3
+#define AL_PCIE_REV_ID_4	4
+
+#define AXI_BASE_OFFSET		0x0
+
+#define DEVICE_ID_OFFSET	0x16c
+
+#define DEVICE_REV_ID			0x0
+#define DEVICE_REV_ID_DEV_ID_MASK	GENMASK(31, 16)
+
+#define DEVICE_REV_ID_DEV_ID_X4		0
+#define DEVICE_REV_ID_DEV_ID_X8		2
+#define DEVICE_REV_ID_DEV_ID_X16	4
+
+#define OB_CTRL_REV1_2_OFFSET	0x0040
+#define OB_CTRL_REV3_5_OFFSET	0x0030
+
+#define CFG_TARGET_BUS			0x0
+#define CFG_TARGET_BUS_MASK_MASK	GENMASK(7, 0)
+#define CFG_TARGET_BUS_BUSNUM_MASK	GENMASK(15, 8)
+
+#define CFG_CONTROL			0x4
+#define CFG_CONTROL_SUBBUS_MASK		GENMASK(15, 8)
+#define CFG_CONTROL_SEC_BUS_MASK	GENMASK(23, 16)
+
+struct al_pcie_reg_offsets {
+	unsigned int ob_ctrl;
+};
+
+struct al_pcie_target_bus_cfg {
+	u8 reg_val;
+	u8 reg_mask;
+	u8 ecam_mask;
+};
+
+struct al_pcie {
+	struct dw_pcie *pci;
+	void __iomem *controller_base; /* base of PCIe unit (not DW core) */
+	struct device *dev;
+	resource_size_t ecam_size;
+	unsigned int controller_rev_id;
+	struct al_pcie_reg_offsets reg_offsets;
+	struct al_pcie_target_bus_cfg target_bus_cfg;
+};
+
+#define PCIE_ECAM_DEVFN(x)		(((x) & 0xff) << 12)
+
+#define to_al_pcie(x)		dev_get_drvdata((x)->dev)
+
+static int al_pcie_rev_id_get(struct al_pcie *pcie, unsigned int *rev_id)
+{
+	void __iomem *dev_rev_id_addr;
+	u32 dev_rev_id;
+
+	dev_rev_id_addr = (void __iomem *)((uintptr_t)pcie->controller_base +
+			  AXI_BASE_OFFSET + DEVICE_ID_OFFSET + DEVICE_REV_ID);
+
+	dev_rev_id = FIELD_GET(DEVICE_REV_ID_DEV_ID_MASK,
+			       readl(dev_rev_id_addr));
+	switch (dev_rev_id) {
+	case DEVICE_REV_ID_DEV_ID_X4:
+		*rev_id = AL_PCIE_REV_ID_2;
+		break;
+	case DEVICE_REV_ID_DEV_ID_X8:
+		*rev_id = AL_PCIE_REV_ID_3;
+		break;
+	case DEVICE_REV_ID_DEV_ID_X16:
+		*rev_id = AL_PCIE_REV_ID_4;
+		break;
+	default:
+		dev_err(pcie->dev, "Unsupported dev_rev_id (0x%x)\n",
+			dev_rev_id);
+		return -EINVAL;
+	}
+
+	dev_dbg(pcie->dev, "dev_rev_id: 0x%x\n", dev_rev_id);
+
+	return 0;
+}
+
+static int al_pcie_reg_offsets_set(struct al_pcie *pcie)
+{
+	switch (pcie->controller_rev_id) {
+	case AL_PCIE_REV_ID_2:
+		pcie->reg_offsets.ob_ctrl = OB_CTRL_REV1_2_OFFSET;
+		break;
+	case AL_PCIE_REV_ID_3:
+	case AL_PCIE_REV_ID_4:
+		pcie->reg_offsets.ob_ctrl = OB_CTRL_REV3_5_OFFSET;
+		break;
+	default:
+		dev_err(pcie->dev, "Unsupported controller rev_id: 0x%x\n",
+			pcie->controller_rev_id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline void al_pcie_target_bus_set(struct al_pcie *pcie,
+					  u8 target_bus,
+					  u8 mask_target_bus)
+{
+	void __iomem *cfg_control_addr;
+	u32 reg;
+
+	reg = FIELD_PREP(CFG_TARGET_BUS_MASK_MASK, mask_target_bus) |
+	      FIELD_PREP(CFG_TARGET_BUS_BUSNUM_MASK, target_bus);
+
+	cfg_control_addr = (void __iomem *)((uintptr_t)pcie->controller_base +
+			   AXI_BASE_OFFSET + pcie->reg_offsets.ob_ctrl +
+			   CFG_TARGET_BUS);
+
+	writel(reg, cfg_control_addr);
+}
+
+static void __iomem *al_pcie_conf_addr_map(struct al_pcie *pcie,
+					   unsigned int busnr,
+					   unsigned int devfn)
+{
+	void __iomem *pci_base_addr;
+	struct pcie_port *pp = &pcie->pci->pp;
+	struct al_pcie_target_bus_cfg *target_bus_cfg = &pcie->target_bus_cfg;
+	unsigned int busnr_ecam = busnr & target_bus_cfg->ecam_mask;
+	unsigned int busnr_reg = busnr & target_bus_cfg->reg_mask;
+
+	pci_base_addr = (void __iomem *)((uintptr_t)pp->va_cfg0_base +
+					 (busnr_ecam << 20) +
+					 PCIE_ECAM_DEVFN(devfn));
+
+	if (busnr_reg != target_bus_cfg->reg_val) {
+		dev_dbg(pcie->pci->dev, "Changing target bus busnum val from 0x%x to 0x%x\n",
+			target_bus_cfg->reg_val, busnr_reg);
+		target_bus_cfg->reg_val = busnr_reg;
+		al_pcie_target_bus_set(pcie,
+				       target_bus_cfg->reg_val,
+				       target_bus_cfg->reg_mask);
+	}
+
+	return pci_base_addr;
+}
+
+static int al_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
+				 unsigned int devfn, int where, int size,
+				 u32 *val)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct al_pcie *pcie = to_al_pcie(pci);
+	unsigned int busnr = bus->number;
+	void __iomem *pci_addr;
+	int rc;
+
+	pci_addr = al_pcie_conf_addr_map(pcie, busnr, devfn);
+
+	rc = dw_pcie_read(pci_addr + where, size, val);
+
+	dev_dbg(pci->dev, "%d-byte config read from %04x:%02x:%02x.%d offset 0x%x (pci_addr: 0x%px) - val:0x%x\n",
+		size, pci_domain_nr(bus), bus->number,
+		PCI_SLOT(devfn), PCI_FUNC(devfn), where,
+		(pci_addr + where), *val);
+
+	return rc;
+}
+
+static int al_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
+				 unsigned int devfn, int where, int size,
+				 u32 val)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct al_pcie *pcie = to_al_pcie(pci);
+	unsigned int busnr = bus->number;
+	void __iomem *pci_addr;
+	int rc;
+
+	pci_addr = al_pcie_conf_addr_map(pcie, busnr, devfn);
+
+	rc = dw_pcie_write(pci_addr + where, size, val);
+
+	dev_err(pci->dev, "%d-byte config write to %04x:%02x:%02x.%d offset 0x%x (pci_addr: 0x%px) - val:0x%x\n",
+		size, pci_domain_nr(bus), bus->number,
+		PCI_SLOT(devfn), PCI_FUNC(devfn), where,
+		(pci_addr + where), val);
+
+	return rc;
+}
+
+static int al_pcie_config_prepare(struct al_pcie *pcie)
+{
+	struct al_pcie_target_bus_cfg *target_bus_cfg;
+	struct pcie_port *pp = &pcie->pci->pp;
+	unsigned int ecam_bus_mask;
+	u8 secondary_bus;
+	u8 subordinate_bus;
+	void __iomem *cfg_control_addr;
+	u32 cfg_control;
+	u32 reg;
+
+	target_bus_cfg = &pcie->target_bus_cfg;
+
+	ecam_bus_mask = (pcie->ecam_size >> 20) - 1;
+	if (ecam_bus_mask > 255) {
+		dev_warn(pcie->dev, "ECAM window size is larger than 256MB. Cutting off at 256\n");
+		ecam_bus_mask = 255;
+	}
+
+	/* This portion is taken from the transaction address */
+	target_bus_cfg->ecam_mask = ecam_bus_mask;
+	/* This portion is taken from the cfg_target_bus reg */
+	target_bus_cfg->reg_mask = ~target_bus_cfg->ecam_mask;
+	target_bus_cfg->reg_val = pp->busn->start & target_bus_cfg->reg_mask;
+
+	al_pcie_target_bus_set(pcie, target_bus_cfg->reg_val,
+			       target_bus_cfg->reg_mask);
+
+	secondary_bus = pp->busn->start + 1;
+	subordinate_bus = pp->busn->end;
+
+	/* Set the valid values of secondary and subordinate buses */
+	cfg_control_addr = pcie->controller_base + AXI_BASE_OFFSET +
+			   pcie->reg_offsets.ob_ctrl + CFG_CONTROL;
+
+	cfg_control = readl(cfg_control_addr);
+
+	reg = cfg_control &
+	      ~(CFG_CONTROL_SEC_BUS_MASK | CFG_CONTROL_SUBBUS_MASK);
+
+	reg |= FIELD_PREP(CFG_CONTROL_SUBBUS_MASK, subordinate_bus) |
+	       FIELD_PREP(CFG_CONTROL_SEC_BUS_MASK, secondary_bus);
+
+	writel(reg, cfg_control_addr);
+
+	return 0;
+}
+
+static int al_pcie_host_init(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct al_pcie *pcie = to_al_pcie(pci);
+	int link_up;
+	int rc;
+
+	link_up = dw_pcie_link_up(pci);
+	if (!link_up) {
+		dev_err(pci->dev, "link is not up!\n");
+		return -ENOLINK;
+	}
+
+	dev_info(pci->dev, "link is up\n");
+
+	rc = al_pcie_rev_id_get(pcie, &pcie->controller_rev_id);
+	if (rc)
+		return rc;
+
+	rc = al_pcie_reg_offsets_set(pcie);
+	if (rc)
+		return rc;
+
+	rc = al_pcie_config_prepare(pcie);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static const struct dw_pcie_host_ops al_pcie_host_ops = {
+	.rd_other_conf = al_pcie_rd_other_conf,
+	.wr_other_conf = al_pcie_wr_other_conf,
+	.host_init = al_pcie_host_init,
+};
+
+static int al_add_pcie_port(struct pcie_port *pp,
+			    struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	pp->ops = &al_pcie_host_ops;
+
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(dev, "failed to initialize host\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dw_pcie_ops dw_pcie_ops = {
+};
+
+static int al_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct al_pcie *al_pcie;
+	struct dw_pcie *pci;
+	struct resource *dbi_res;
+	struct resource *controller_res;
+	struct resource *ecam_res;
+	int ret;
+
+	al_pcie = devm_kzalloc(dev, sizeof(*al_pcie), GFP_KERNEL);
+	if (!al_pcie)
+		return -ENOMEM;
+
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	pci->dev = dev;
+	pci->ops = &dw_pcie_ops;
+
+	al_pcie->pci = pci;
+	al_pcie->dev = dev;
+
+	dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
+	pci->dbi_base = devm_pci_remap_cfg_resource(dev, dbi_res);
+	if (IS_ERR(pci->dbi_base)) {
+		dev_err(dev, "couldn't remap dbi base %pR\n", dbi_res);
+		return PTR_ERR(pci->dbi_base);
+	}
+
+	ecam_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
+	if (!ecam_res) {
+		dev_err(dev, "couldn't find 'config' reg in DT\n");
+		return -ENOENT;
+	}
+	al_pcie->ecam_size = resource_size(ecam_res);
+
+	controller_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						      "controller");
+	al_pcie->controller_base = devm_ioremap_resource(dev, controller_res);
+	if (IS_ERR(al_pcie->controller_base)) {
+		dev_err(dev, "couldn't remap controller base %pR\n",
+			controller_res);
+		return PTR_ERR(al_pcie->controller_base);
+	}
+
+	dev_dbg(dev, "From DT: dbi_base: %pR, controller_base: %pR\n",
+		dbi_res, controller_res);
+
+	platform_set_drvdata(pdev, al_pcie);
+
+	ret = al_add_pcie_port(&pci->pp, pdev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id al_pcie_of_match[] = {
+	{ .compatible = "amazon,al-pcie",
+	},
+	{},
+};
+
+static struct platform_driver al_pcie_driver = {
+	.driver = {
+		.name	= "al-pcie",
+		.of_match_table = al_pcie_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = al_pcie_probe,
+};
+builtin_platform_driver(al_pcie_driver);
+
+#endif /* CONFIG_PCIE_AL*/
-- 
2.17.1

