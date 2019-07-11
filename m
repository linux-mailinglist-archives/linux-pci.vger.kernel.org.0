Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 946366597B
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2019 16:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfGKO5M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 10:57:12 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:62262 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbfGKO5M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 10:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1562857031; x=1594393031;
  h=from:to:cc:message-id:in-reply-to:references:
   mime-version:subject:resent-from:resent-cc:date:
   content-transfer-encoding;
  bh=fFCIE6Gtuppnoz9hn96ftUyHG1gsIf9U00rUHChbLh8=;
  b=oaHVIHRviBlY9xpycqE3a0FG++VbXNZMV26bANeEHVHvGxJ45+9vsBxW
   uAVkt2fFIqVMjg8I29+LInVd1oqUZUhl6FbX1X1WzUUl2owXii+4JIr8h
   EzjuZnTSI639gBfeqxM9K60Ju16k0NXjnXRg9pKDIOON0Ev26cQmIN6Xr
   Q=;
X-IronPort-AV: E=Sophos;i="5.62,478,1554768000"; 
   d="scan'208";a="684958826"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 11 Jul 2019 14:57:08 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id AA372A2753;
        Thu, 11 Jul 2019 14:57:08 +0000 (UTC)
Received: from EX13P01UWA002.ant.amazon.com (10.43.160.46) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Jul 2019 14:57:08 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13P01UWA002.ant.amazon.com (10.43.160.46) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Jul 2019 14:57:07 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.107.0.52) by
 mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 11 Jul 2019 14:57:06 +0000
Received: from EX13D13UWB003.ant.amazon.com (10.43.161.233) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server
 (TLS) id 15.0.1367.3 via Mailbox Transport; Wed, 10 Jul 2019 16:45:47 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB003.ant.amazon.com (10.43.161.233) with Microsoft SMTP Server
 (TLS) id 15.0.1367.3; Wed, 10 Jul 2019 16:45:47 +0000
Received: from email-inbound-relay-2a-53356bf6.us-west-2.amazon.com
 (10.25.10.214) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 10 Jul 2019 16:45:47
 +0000
Received: by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix)
        id D85E8A23A1; Wed, 10 Jul 2019 16:45:46 +0000 (UTC)
Received: from u9ff250417f405e.ant.amazon.com
 (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70]) by
 email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS
 id 15FE7A2398; Wed, 10 Jul 2019 16:45:45 +0000 (UTC)
Received: from u9ff250417f405e.ant.amazon.com (localhost [127.0.0.1]) by
 u9ff250417f405e.ant.amazon.com (8.15.2/8.15.2/Debian-10) with ESMTP id
 x6AGjgXO021913; Wed, 10 Jul 2019 19:45:42 +0300
Received: (from jonnyc@localhost)
        by u9ff250417f405e.ant.amazon.com (8.15.2/8.15.2/Submit) id x6AGjea0021870;
        Wed, 10 Jul 2019 19:45:40 +0300
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <alisaidi@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        <talel@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Message-ID: <20190710164519.17883-7-jonnyc@amazon.com>
In-Reply-To: <20190710164519.17883-1-jonnyc@amazon.com>
References: <20190710164519.17883-1-jonnyc@amazon.com>
Content-Type: text/plain
MIME-Version: 1.0
Subject: [PATCH 6/8] PCI: al: Add support for DW based driver type
Date:   Thu, 11 Jul 2019 17:57:05 +0300
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Content-Transfer-Encoding: quoted-printable
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
 drivers/pci/controller/dwc/Kconfig   |  11 +
 drivers/pci/controller/dwc/pcie-al.c | 397 +++++++++++++++++++++++++++
 2 files changed, 408 insertions(+)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dw=
c/Kconfig
index a6ce1ee51b4c..51da9cb219aa 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -230,4 +230,15 @@ config PCIE_UNIPHIER
 	  Say Y here if you want PCIe controller support on UniPhier SoCs.
 	  This driver supports LD20 and PXs3 SoCs.
=20
+config PCIE_AL
+	bool "Amazon Annapurna Labs PCIe controller"
+	depends on OF && (ARM64 || COMPILE_TEST)
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIE_DW_HOST
+	help
+	  Say Y here to enable support of the Annapurna Labs PCIe controller IP
+	  on Amazon SoCs.
+	  The PCIe controller uses the DesignWare core plus
+	  Amazon-specific hardware wrappers.
+
 endmenu
diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/=
dwc/pcie-al.c
index 3ab58f0584a8..2742a0895aab 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -91,3 +91,400 @@ struct pci_ecam_ops al_pcie_ops =3D {
 };
=20
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
+/* The AXI regs are always at the beginning of the PCIE controller reg spa=
ce. */
+#define AXI_BASE_OFFSET		0x0
+
+#define DEVICE_ID_OFFSET	0x16c
+
+#define DEVICE_REV_ID			0x0
+#define DEVICE_REV_ID_DEV_ID_MASK	0xFFFF0000
+#define DEVICE_REV_ID_DEV_ID_SHIFT	16
+
+#define DEVICE_REV_ID_DEV_ID_X4		(0 << DEVICE_REV_ID_DEV_ID_SHIFT)
+#define DEVICE_REV_ID_DEV_ID_X8		(2 << DEVICE_REV_ID_DEV_ID_SHIFT)
+#define DEVICE_REV_ID_DEV_ID_X16	(4 << DEVICE_REV_ID_DEV_ID_SHIFT)
+
+/* The ob_ctrl offset inside the axi regs is different between revisions.
+ */
+#define OB_CTRL_REV1_2_OFFSET	0x0040
+#define OB_CTRL_REV3_5_OFFSET	0x0030
+
+#define CFG_TARGET_BUS			0x0
+#define CFG_TARGET_BUS_MASK_SHIFT	0
+#define CFG_TARGET_BUS_BUSNUM_SHIFT	8
+
+#define CFG_CONTROL			0x4
+#define CFG_CONTROL_SUBBUS_MASK		0x0000FF00
+#define CFG_CONTROL_SUBBUS_SHIFT	8
+#define CFG_CONTROL_SEC_BUS_MASK	0x00FF0000
+#define CFG_CONTROL_SEC_BUS_SHIFT	16
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
+	struct dw_pcie	*pci;
+	void __iomem	*controller_base; /* base of PCIe unit (not DW core) */
+	void __iomem	*dbi_base;
+	resource_size_t ecam_size;
+	struct device *dev;
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
+	dev_rev_id_addr =3D (void __iomem *)((uintptr_t)pcie->controller_base +
+			  AXI_BASE_OFFSET + DEVICE_ID_OFFSET + DEVICE_REV_ID);
+
+	dev_rev_id =3D readl(dev_rev_id_addr) & DEVICE_REV_ID_DEV_ID_MASK;
+
+	switch (dev_rev_id) {
+	case DEVICE_REV_ID_DEV_ID_X4:
+		*rev_id =3D AL_PCIE_REV_ID_2;
+		break;
+	case DEVICE_REV_ID_DEV_ID_X8:
+		*rev_id =3D AL_PCIE_REV_ID_3;
+		break;
+	case DEVICE_REV_ID_DEV_ID_X16:
+		*rev_id =3D AL_PCIE_REV_ID_4;
+		break;
+	default:
+		dev_err(pcie->dev, "Unsupported dev_rev_id (0x%08x)\n",
+			dev_rev_id);
+		return -EINVAL;
+	}
+
+	dev_dbg(pcie->dev, "dev_rev_id: 0x%08x\n", dev_rev_id);
+
+	return 0;
+}
+
+static int al_pcie_reg_offsets_set(struct al_pcie *pcie)
+{
+	switch (pcie->controller_rev_id) {
+	case AL_PCIE_REV_ID_2:
+		pcie->reg_offsets.ob_ctrl =3D OB_CTRL_REV1_2_OFFSET;
+		break;
+	case AL_PCIE_REV_ID_3:
+	case AL_PCIE_REV_ID_4:
+		pcie->reg_offsets.ob_ctrl =3D OB_CTRL_REV3_5_OFFSET;
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
+	u32 reg =3D (target_bus << CFG_TARGET_BUS_BUSNUM_SHIFT) |
+		       mask_target_bus;
+
+	cfg_control_addr =3D (void __iomem *)((uintptr_t)pcie->controller_base +
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
+	struct pcie_port *pp =3D &pcie->pci->pp;
+	struct al_pcie_target_bus_cfg *target_bus_cfg =3D &pcie->target_bus_cfg;
+	unsigned int busnr_ecam =3D busnr & target_bus_cfg->ecam_mask;
+	unsigned int busnr_reg =3D busnr & target_bus_cfg->reg_mask;
+
+	pci_base_addr =3D (void __iomem *)((uintptr_t)pp->va_cfg0_base +
+				 (busnr_ecam << 20) +
+				 PCIE_ECAM_DEVFN(devfn));
+
+	if (busnr_reg !=3D target_bus_cfg->reg_val) {
+		dev_dbg(pcie->pci->dev, "Changing target bus busnum val from %d to %d\n"=
,
+			target_bus_cfg->reg_val, busnr_reg);
+		target_bus_cfg->reg_val =3D busnr_reg;
+		al_pcie_target_bus_set(pcie,
+				       target_bus_cfg->reg_val,
+				       target_bus_cfg->reg_mask);
+	}
+
+	return pci_base_addr;
+}
+
+static int al_pcie_rd_other_conf(struct pcie_port *pp,
+				 struct pci_bus *bus,
+				 unsigned int devfn,
+				 int where,
+				 int size,
+				 u32 *val)
+{
+	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
+	struct al_pcie *pcie =3D to_al_pcie(pci);
+	unsigned int busnr =3D bus->number;
+	void __iomem *pci_addr;
+	int rc;
+
+	pci_addr =3D al_pcie_conf_addr_map(pcie, busnr, devfn);
+
+	rc =3D dw_pcie_read(pci_addr + where, size, val);
+
+	dev_dbg(pci->dev, "%d-byte config read from %04x:%02x:%02x.%d offset %#x =
(pci_addr: 0x%p) - val:0x%x\n",
+		size, pci_domain_nr(bus), bus->number,
+		PCI_SLOT(devfn), PCI_FUNC(devfn), where,
+		(pci_addr + where), *val);
+
+	return rc;
+}
+
+static int al_pcie_wr_other_conf(struct pcie_port *pp,
+				 struct pci_bus *bus,
+				 unsigned int devfn,
+				 int where,
+				 int size,
+				 u32 val)
+{
+	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
+	struct al_pcie *pcie =3D to_al_pcie(pci);
+	unsigned int busnr =3D bus->number;
+	void __iomem *pci_addr;
+	int rc;
+
+	pci_addr =3D al_pcie_conf_addr_map(pcie, busnr, devfn);
+
+	rc =3D dw_pcie_write(pci_addr + where, size, val);
+
+	dev_dbg(pci->dev, "%d-byte config write to %04x:%02x:%02x.%d offset %#x (=
pci_addr: 0x%p) - val:0x%x\n",
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
+	struct pcie_port *pp =3D &pcie->pci->pp;
+	unsigned int ecam_bus_mask;
+	u8 secondary_bus;
+	u8 subordinate_bus;
+	void __iomem *cfg_control_addr;
+	u32 cfg_control;
+	u32 reg =3D 0;
+
+	target_bus_cfg =3D &pcie->target_bus_cfg;
+
+	ecam_bus_mask =3D (pcie->ecam_size >> 20) - 1;
+	if (ecam_bus_mask > 255) {
+		dev_warn(pcie->dev, "ECAM window size is larger than 256MB. Cutting off =
at 256\n");
+		ecam_bus_mask =3D 255;
+	}
+
+	/* This portion is taken from the transaction address */
+	target_bus_cfg->ecam_mask =3D ecam_bus_mask;
+	/* This portion is taken from the cfg_target_bus reg */
+	target_bus_cfg->reg_mask =3D ~target_bus_cfg->ecam_mask;
+	target_bus_cfg->reg_val =3D pp->busn->start & target_bus_cfg->reg_mask;
+
+	al_pcie_target_bus_set(pcie,
+			       target_bus_cfg->reg_val,
+			       target_bus_cfg->reg_mask);
+
+	secondary_bus =3D pp->busn->start + 1;
+	subordinate_bus =3D pp->busn->end;
+
+	/* Set the valid values of secondary and subordinate buses */
+	cfg_control_addr =3D pcie->controller_base +
+		AXI_BASE_OFFSET + pcie->reg_offsets.ob_ctrl + CFG_CONTROL;
+
+	cfg_control =3D readl(cfg_control_addr);
+
+	reg =3D (cfg_control & ~CFG_CONTROL_SEC_BUS_MASK) |
+	       (secondary_bus << CFG_CONTROL_SEC_BUS_SHIFT);
+	reg =3D (reg & ~CFG_CONTROL_SUBBUS_MASK) |
+	       (subordinate_bus << CFG_CONTROL_SUBBUS_SHIFT);
+
+	writel(reg, cfg_control_addr);
+
+	return 0;
+}
+
+static int al_pcie_host_init(struct pcie_port *pp)
+{
+	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
+	struct al_pcie *pcie =3D to_al_pcie(pci);
+	int link_up =3D 0;
+	u32 reg =3D 0;
+	int rc;
+
+	reg =3D dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE);
+	if (reg !=3D PCI_HEADER_TYPE_BRIDGE) {
+		dev_err(pci->dev, "PCIe controller is not set to bridge type (%d)!\n",
+			reg);
+		return -EIO;
+	}
+
+	link_up =3D dw_pcie_link_up(pci);
+	if (!link_up) {
+		dev_err(pci->dev, "link in not up!\n");
+		return -ENOLINK;
+	}
+
+	dev_info(pci->dev, "link is up\n");
+
+	rc =3D al_pcie_rev_id_get(pcie, &pcie->controller_rev_id);
+	if (rc)
+		return rc;
+
+	rc =3D al_pcie_reg_offsets_set(pcie);
+	if (rc)
+		return rc;
+
+	rc =3D al_pcie_config_prepare(pcie);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static const struct dw_pcie_host_ops al_pcie_host_ops =3D {
+	.rd_other_conf =3D al_pcie_rd_other_conf,
+	.wr_other_conf =3D al_pcie_wr_other_conf,
+	.host_init =3D al_pcie_host_init,
+};
+
+static int al_add_pcie_port(struct pcie_port *pp,
+			    struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	int ret;
+
+	pp->ops =3D &al_pcie_host_ops;
+
+	ret =3D dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(dev, "failed to initialize host\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dw_pcie_ops dw_pcie_ops =3D {
+};
+
+static int al_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct al_pcie *al_pcie;
+	struct dw_pcie *pci;
+	struct resource *dbi_res;
+	struct resource *controller_res;
+	struct resource *ecam_res;
+	int ret;
+
+	al_pcie =3D devm_kzalloc(dev, sizeof(*al_pcie), GFP_KERNEL);
+	if (!al_pcie)
+		return -ENOMEM;
+
+	pci =3D devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	pci->dev =3D dev;
+	pci->ops =3D &dw_pcie_ops;
+
+	al_pcie->pci =3D pci;
+	al_pcie->dev =3D dev;
+
+	dbi_res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
+	pci->dbi_base =3D devm_pci_remap_cfg_resource(dev, dbi_res);
+	if (IS_ERR(pci->dbi_base)) {
+		dev_err(dev, "couldn't remap dbi base %p\n", dbi_res);
+		return PTR_ERR(pci->dbi_base);
+	}
+
+	ecam_res =3D platform_get_resource_byname(pdev,
+						IORESOURCE_MEM,
+						"config");
+	if (!ecam_res) {
+		dev_err(dev, "couldn't find 'config' reg in DT\n");
+		return -ENOENT;
+	}
+	al_pcie->ecam_size =3D resource_size(ecam_res);
+
+	controller_res =3D platform_get_resource_byname(pdev,
+						      IORESOURCE_MEM,
+						      "controller");
+	al_pcie->controller_base =3D devm_ioremap_resource(dev,
+							 controller_res);
+	if (IS_ERR(al_pcie->controller_base)) {
+		dev_err(dev, "couldn't remap controller base %p\n",
+			controller_res);
+		return PTR_ERR(al_pcie->controller_base);
+	}
+
+	dev_dbg(dev, "From DT: dbi_base: 0x%llx, controller_base: 0x%llx\n",
+		dbi_res->start, controller_res->start);
+
+	platform_set_drvdata(pdev, al_pcie);
+
+	ret =3D al_add_pcie_port(&pci->pp, pdev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id al_pcie_of_match[] =3D {
+	{ .compatible =3D "amazon,al-pcie",
+	  .data =3D NULL,
+	},
+	{},
+};
+
+static struct platform_driver al_pcie_driver =3D {
+	.driver =3D {
+		.name	=3D "al-pcie",
+		.of_match_table =3D al_pcie_of_match,
+		.suppress_bind_attrs =3D true,
+	},
+	.probe =3D al_pcie_probe,
+};
+builtin_platform_driver(al_pcie_driver);
+
+#endif /* CONFIG_PCIE_AL*/
--=20
2.17.1


