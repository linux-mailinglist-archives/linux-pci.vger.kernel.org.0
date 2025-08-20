Return-Path: <linux-pci+bounces-34381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B18E7B2DB97
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 13:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADA9164D7E
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 11:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEB42BE7BE;
	Wed, 20 Aug 2025 11:48:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3FD1E51F1
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690481; cv=none; b=fmyMKeMU/6TvuFHWjcCNuzWWwLvb/+9TUwgIRGIVPSTjDZsRnqeA0malDa85dMA6F+nrjuCQ0eO8An4oDn114TF/hjqMHFH5h2qk2SeQw7Zfl7wAONJdpdGSskjtL+9xtkxynsNJHXqwldgzU6aRBg5ambk9A1wjVP/Z6uyq9n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690481; c=relaxed/simple;
	bh=Hg+0p53kGTa9qvkOCzaH9mC6tSZmEZYOx1M3Ov3hAfg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/bf1gFrJ3chUT5kMtVfrtZUNyQ115Bewzib1EPhuecAxHP0Dy9OWZM+mFIO/L5cxQ14vo7kBofUPpUF75g7egW4c61Waf+5oY0tTligqa89uT/hqt4Dtw8F5rFH5IOqdJZ8CXaBdxHE15QWOO2inry/GwJ+6kOs/LOe/ugxDng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 57KBJSJp019237
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 19:19:28 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 57KBIsOO018802
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 19:18:54 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Wed, 20 Aug 2025
 19:18:54 +0800
From: Randolph Lin <randolph@andestech.com>
To: <linux-pci@vger.kernel.org>
CC: <ben717@andestech.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
        <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <bhelgaas@google.com>,
        <randolph.sklin@gmail.com>, <tim609@andestech.com>,
        Randolph Lin <randolph@andestech.com>
Subject: [PATCH 5/6] PCI: andes: Add Andes QiLai SoC PCIe host driver support
Date: Wed, 20 Aug 2025 19:18:42 +0800
Message-ID: <20250820111843.811481-6-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820111843.811481-1-randolph@andestech.com>
References: <20250820111843.811481-1-randolph@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 57KBJSJp019237

Add driver support for DesignWare based PCIe controller in Andes
QiLai SoC. The driver only supports the Root Complex mode.

Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 drivers/pci/controller/dwc/Kconfig            |  13 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-andes-qilai.c | 227 ++++++++++++++++++
 3 files changed, 241 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-andes-qilai.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index ff6b6d9e18ec..a9c5a43f648b 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -49,6 +49,19 @@ config PCIE_AMD_MDB
 	  DesignWare IP and therefore the driver re-uses the DesignWare
 	  core functions to implement the driver.
 
+config PCIE_ANDES_QILAI
+	bool "ANDES QiLai PCIe controller"
+	depends on OF && (RISCV || COMPILE_TEST)
+	depends on PCI_MSI
+	depends on ARCH_ANDES
+	select PCIE_DW_HOST
+	default y if ARCH_ANDES
+	help
+	  Say Y here if you want to enable PCIe controller support on Andes
+	  QiLai SoCs. The Andes QiLai SoCs PCIe controller is based on
+	  DesignWare IP and therefore the driver re-uses the DesignWare
+	  core functions to implement the driver.
+
 config PCI_MESON
 	tristate "Amlogic Meson PCIe controller"
 	default m if ARCH_MESON
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 6919d27798d1..de9583cbd675 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
 obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
 obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
 obj-$(CONFIG_PCIE_AMD_MDB) += pcie-amd-mdb.o
+obj-$(CONFIG_PCIE_ANDES_QILAI) += pcie-andes-qilai.o
 obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
 obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
diff --git a/drivers/pci/controller/dwc/pcie-andes-qilai.c b/drivers/pci/controller/dwc/pcie-andes-qilai.c
new file mode 100644
index 000000000000..dd06eee82cac
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-andes-qilai.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the PCIe Controller in QiLai from Andes
+ *
+ * Copyright (C) 2025 Andes Technology Corporation
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+#include "pcie-designware.h"
+
+#define PCIE_INTR_CONTROL1			0x15c
+#define PCIE_MSI_CTRL_INT_EN			BIT(28)
+
+#define PCIE_LOGIC_COHERENCY_CONTROL3		0x8e8
+/* Write-Back, Read and Write Allocate */
+#define IOCP_ARCACHE				0xf
+/* Write-Back, Read and Write Allocate */
+#define IOCP_AWCACHE				0xf
+#define PCIE_CFG_MSTR_ARCACHE_MODE		GENMASK(6, 3)
+#define PCIE_CFG_MSTR_AWCACHE_MODE		GENMASK(14, 11)
+#define PCIE_CFG_MSTR_ARCACHE_VALUE		GENMASK(22, 19)
+#define PCIE_CFG_MSTR_AWCACHE_VALUE		GENMASK(30, 27)
+
+#define PCIE_GEN_CONTROL2			0x54
+#define PCIE_CFG_LTSSM_EN			BIT(0)
+
+#define PCIE_REGS_PCIE_SII_PM_STATE		0xc0
+#define SMLH_LINK_UP				BIT(6)
+#define RDLH_LINK_UP				BIT(7)
+#define PCIE_REGS_PCIE_SII_LINK_UP		(SMLH_LINK_UP | RDLH_LINK_UP)
+
+struct qilai_pcie {
+	struct dw_pcie dw;
+	struct platform_device *pdev;
+	void __iomem *apb_base;
+};
+
+#define to_qilai_pcie(_dw) container_of(_dw, struct qilai_pcie, dw)
+
+static u64 qilai_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 cpu_addr)
+{
+	struct dw_pcie_rp *pp = &pci->pp;
+
+	return cpu_addr - pp->cfg0_base;
+}
+
+static u32 qilai_pcie_outbound_atu_check(struct dw_pcie *pci,
+					 const struct dw_pcie_ob_atu_cfg *atu,
+					 u64 *limit_addr)
+{
+	u64 parent_bus_addr = atu->parent_bus_addr;
+
+	*limit_addr = parent_bus_addr + atu->size - 1;
+
+	/*
+	 * Addresses below 4 GB are not 1:1 mapped; therefore, range checks
+	 * only need to ensure addresses below 4 GB match pci->region_limit.
+	 */
+	if (lower_32_bits(*limit_addr & ~pci->region_limit) !=
+	    lower_32_bits(parent_bus_addr & ~pci->region_limit) ||
+	    !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
+	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size)
+		return -EINVAL;
+	else
+		return 0;
+}
+
+static bool qilai_pcie_link_up(struct dw_pcie *pci)
+{
+	struct qilai_pcie *qlpci = to_qilai_pcie(pci);
+	u32 val;
+
+	/* Read smlh & rdlh link up by checking debug port */
+	dw_pcie_read(qlpci->apb_base + PCIE_REGS_PCIE_SII_PM_STATE, 0x4, &val);
+
+	return (val & PCIE_REGS_PCIE_SII_LINK_UP) == PCIE_REGS_PCIE_SII_LINK_UP;
+}
+
+static int qilai_pcie_start_link(struct dw_pcie *pci)
+{
+	struct qilai_pcie *qlpci = to_qilai_pcie(pci);
+	u32 val;
+
+	/* Do phy link up */
+	dw_pcie_read(qlpci->apb_base + PCIE_GEN_CONTROL2, 0x4, &val);
+	val |= PCIE_CFG_LTSSM_EN;
+	dw_pcie_write(qlpci->apb_base + PCIE_GEN_CONTROL2, 0x4, val);
+
+	return 0;
+}
+
+static const struct dw_pcie_ops qilai_pcie_ops = {
+	.cpu_addr_fixup = qilai_pcie_cpu_addr_fixup,
+	.outbound_atu_check = qilai_pcie_outbound_atu_check,
+	.link_up = qilai_pcie_link_up,
+	.start_link = qilai_pcie_start_link,
+};
+
+static struct qilai_pcie *qilai_pcie_create_data(struct platform_device *pdev)
+{
+	struct qilai_pcie *qlpci;
+
+	qlpci = devm_kzalloc(&pdev->dev, sizeof(*qlpci), GFP_KERNEL);
+	if (!qlpci)
+		return ERR_PTR(-ENOMEM);
+
+	qlpci->pdev = pdev;
+	platform_set_drvdata(pdev, qlpci);
+
+	return qlpci;
+}
+
+/*
+ * Setup the Qilai PCIe IOCP (IO Coherence Port) Read/Write Behaviors to the
+ * Write-Back, Read and Write Allocate mode.
+ */
+static void qilai_pcie_iocp_cache_setup(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	u32 val;
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	dw_pcie_read(pci->dbi_base + PCIE_LOGIC_COHERENCY_CONTROL3,
+		     sizeof(val), &val);
+	val |= FIELD_PREP(PCIE_CFG_MSTR_ARCACHE_MODE, IOCP_ARCACHE);
+	val |= FIELD_PREP(PCIE_CFG_MSTR_AWCACHE_MODE, IOCP_AWCACHE);
+	val |= FIELD_PREP(PCIE_CFG_MSTR_ARCACHE_VALUE, IOCP_ARCACHE);
+	val |= FIELD_PREP(PCIE_CFG_MSTR_AWCACHE_VALUE, IOCP_AWCACHE);
+	dw_pcie_write(pci->dbi_base + PCIE_LOGIC_COHERENCY_CONTROL3,
+		      sizeof(val), val);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
+static void qilai_pcie_enable_msi(struct qilai_pcie *qlpci)
+{
+	u32 val;
+
+	dw_pcie_read(qlpci->apb_base + PCIE_INTR_CONTROL1,
+		     sizeof(val), &val);
+	val |= PCIE_MSI_CTRL_INT_EN;
+	dw_pcie_write(qlpci->apb_base + PCIE_INTR_CONTROL1,
+		      sizeof(val), val);
+}
+
+static int qilai_pcie_host_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct qilai_pcie *qlpci = to_qilai_pcie(pci);
+
+	qilai_pcie_enable_msi(qlpci);
+
+	return 0;
+}
+
+static const struct dw_pcie_host_ops qilai_pcie_host_ops = {
+	.init = qilai_pcie_host_init,
+};
+
+static int qilai_pcie_add_port(struct qilai_pcie *qlpci)
+{
+	struct device *dev = &qlpci->pdev->dev;
+	struct platform_device *pdev = qlpci->pdev;
+	int ret;
+
+	qlpci->dw.dev = dev;
+	qlpci->dw.ops = &qilai_pcie_ops;
+	qlpci->dw.pp.num_vectors = MAX_MSI_IRQS;
+	qlpci->dw.pp.ops = &qilai_pcie_host_ops;
+
+	dw_pcie_cap_set(&qlpci->dw, REQ_RES);
+
+	qlpci->apb_base = devm_platform_ioremap_resource_byname(pdev, "apb");
+	if (IS_ERR(qlpci->apb_base))
+		return PTR_ERR(qlpci->apb_base);
+
+	ret = dw_pcie_host_init(&qlpci->dw.pp);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to initialize PCIe host\n");
+		return ret;
+	}
+
+	qilai_pcie_iocp_cache_setup(&qlpci->dw.pp);
+
+	return 0;
+}
+
+static int qilai_pcie_probe(struct platform_device *pdev)
+{
+	struct qilai_pcie *qlpci;
+
+	qlpci = qilai_pcie_create_data(pdev);
+	if (IS_ERR(qlpci))
+		return PTR_ERR(qlpci);
+
+	platform_set_drvdata(pdev, qlpci);
+
+	return qilai_pcie_add_port(qlpci);
+}
+
+static const struct of_device_id qilai_pcie_of_match[] = {
+	{ .compatible = "andestech,qilai-pcie" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, qilai_pcie_of_match);
+
+static struct platform_driver qilai_pcie_driver = {
+	.probe = qilai_pcie_probe,
+	.driver = {
+		.name	= "qilai-pcie",
+		.of_match_table = qilai_pcie_of_match,
+	},
+};
+
+module_platform_driver(qilai_pcie_driver);
+
+MODULE_AUTHOR("Randolph Lin <randolph@andestech.com>");
+MODULE_DESCRIPTION("Andes Qilai PCIe driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


