Return-Path: <linux-pci+bounces-39140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C3EC0104F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 14:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4FC1A0121B
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 12:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5616A3112AD;
	Thu, 23 Oct 2025 12:13:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C87831076A;
	Thu, 23 Oct 2025 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221607; cv=none; b=WOVs79SnCRIQVK//aQs+vk5vpHE7J0W5Yy+i8kuSBsouDb6Oy3RyLRurC96CvKtqlvWP9ycySD9mYyXuAwR1Vjfzn6K2VI6gvPasurBC+zLWF9O24Je7JJHCR9bh72tSmqr3fiDxs1gV1DRIBv2uypfWwNUA6WeS+0OAXEkUiAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221607; c=relaxed/simple;
	bh=67CQkxXX400mRvcXCA2ATq17vNxMxL2ukbLYJP+hwLQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcPYejy2791TNDgXAZxD/GM7P/GYC/PnDkPpQig6aogix8stf4wOIubDucdLCdR1r35sWY+5m1FytNNofdzCwUpTtlN38UWMKb/Meb5L7Bi7NGZ+fCmk7C6s3/9mZ/7ouS+T8zN5lsv1VjrlCu7YGbT/SgtO79jkDFG4uiIP28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 59NC9hvQ039377
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 20:09:43 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Thu, 23 Oct 2025
 20:09:43 +0800
From: Randolph Lin <randolph@andestech.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <jingoohan1@gmail.com>,
        <mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <alex@ghiti.fr>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <ben717@andestech.com>, <inochiama@gmail.com>,
        <thippeswamy.havalige@amd.com>, <namcao@linutronix.de>,
        <shradha.t@samsung.com>, <pjw@kernel.org>, <randolph.sklin@gmail.com>,
        <tim609@andestech.com>, Randolph Lin <randolph@andestech.com>
Subject: [PATCH v9 3/4] PCI: andes: Add Andes QiLai SoC PCIe host driver support
Date: Thu, 23 Oct 2025 20:09:32 +0800
Message-ID: <20251023120933.2427946-4-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023120933.2427946-1-randolph@andestech.com>
References: <20251023120933.2427946-1-randolph@andestech.com>
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
X-MAIL:Atcsqr.andestech.com 59NC9hvQ039377

Add driver support for DesignWare based PCIe controller in Andes
QiLai SoC. The driver only supports the Root Complex mode.

Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 drivers/pci/controller/dwc/Kconfig            |  13 ++
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-andes-qilai.c | 198 ++++++++++++++++++
 3 files changed, 212 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-andes-qilai.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 349d4657393c..09ce40640e2f 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -61,6 +61,19 @@ config PCI_MESON
 	  and therefore the driver re-uses the DesignWare core functions to
 	  implement the driver.
 
+config PCIE_ANDES_QILAI
+	tristate "Andes QiLai PCIe controller"
+	depends on ARCH_ANDES || COMPILE_TEST
+	depends on PCI_MSI
+	select PCIE_DW_HOST
+	help
+	  Say Y here to enable PCIe controller support on Andes QiLai SoCs,
+	  which operate in Root Complex mode. The Andes QiLai SoC PCIe
+	  controller is based on DesignWare IP (5.97a version) and therefore
+	  the driver re-uses the DesignWare core functions to implement the
+	  driver. The Andes QiLai SoC features three Root Complexes, each
+	  operating on PCIe 4.0.
+
 config PCIE_ARTPEC6
 	bool
 
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 7ae28f3b0fb3..5d3ec2d26275 100644
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
index 000000000000..daa0281abd24
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-andes-qilai.c
@@ -0,0 +1,198 @@
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
+
+/*
+ * Refer to Table A4-5 (Memory type encoding) in the
+ * AMBA AXI and ACE Protocol Specification.
+ *
+ * The selected value corresponds to the Memory type field:
+ * "Write-back, Read and Write-allocate".
+ *
+ * The last three rows in the table A4-5 in
+ * AMBA AXI and ACE Protocol Specification:
+ * ARCACHE        AWCACHE        Memory type
+ * ------------------------------------------------------------------
+ * 1111 (0111)    0111           Write-back Read-allocate
+ * 1011           1111 (1011)    Write-back Write-allocate
+ * 1111           1111           Write-back Read and Write-allocate (selected)
+ */
+#define IOCP_ARCACHE				0b1111
+#define IOCP_AWCACHE				0b1111
+
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
+	struct dw_pcie pci;
+	void __iomem *apb_base;
+};
+
+#define to_qilai_pcie(_pci) container_of(_pci, struct qilai_pcie, pci)
+
+static bool qilai_pcie_link_up(struct dw_pcie *pci)
+{
+	struct qilai_pcie *pcie = to_qilai_pcie(pci);
+	u32 val;
+
+	/* Read smlh & rdlh link up by checking debug port */
+	val = readl(pcie->apb_base + PCIE_REGS_PCIE_SII_PM_STATE);
+
+	return (val & PCIE_REGS_PCIE_SII_LINK_UP) == PCIE_REGS_PCIE_SII_LINK_UP;
+}
+
+static int qilai_pcie_start_link(struct dw_pcie *pci)
+{
+	struct qilai_pcie *pcie = to_qilai_pcie(pci);
+	u32 val;
+
+	val = readl(pcie->apb_base + PCIE_GEN_CONTROL2);
+	val |= PCIE_CFG_LTSSM_EN;
+	writel(val, pcie->apb_base + PCIE_GEN_CONTROL2);
+
+	return 0;
+}
+
+static const struct dw_pcie_ops qilai_pcie_ops = {
+	.link_up = qilai_pcie_link_up,
+	.start_link = qilai_pcie_start_link,
+};
+
+/*
+ * Set up the QiLai PCIe IOCP (IO Coherence Port) Read/Write Behaviors to the
+ * Write-Back, Read and Write Allocate mode.
+ *
+ * The IOCP HW target is SoC last-level cache (L2 Cache), which serves as the
+ * system cache. The IOCP HW helps maintain cache monitoring, ensuring that
+ * the device can snoop data from/to the cache.
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
+	FIELD_MODIFY(PCIE_CFG_MSTR_ARCACHE_MODE, &val, IOCP_ARCACHE);
+	FIELD_MODIFY(PCIE_CFG_MSTR_AWCACHE_MODE, &val, IOCP_AWCACHE);
+	FIELD_MODIFY(PCIE_CFG_MSTR_ARCACHE_VALUE, &val, IOCP_ARCACHE);
+	FIELD_MODIFY(PCIE_CFG_MSTR_AWCACHE_VALUE, &val, IOCP_AWCACHE);
+	dw_pcie_write(pci->dbi_base + PCIE_LOGIC_COHERENCY_CONTROL3,
+		      sizeof(val), val);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
+static void qilai_pcie_enable_msi(struct qilai_pcie *pcie)
+{
+	u32 val;
+
+	val = readl(pcie->apb_base + PCIE_INTR_CONTROL1);
+	val |= PCIE_MSI_CTRL_INT_EN;
+	writel(val, pcie->apb_base + PCIE_INTR_CONTROL1);
+}
+
+static int qilai_pcie_host_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct qilai_pcie *pcie = to_qilai_pcie(pci);
+
+	qilai_pcie_enable_msi(pcie);
+
+	return 0;
+}
+
+static void qilai_pcie_host_post_init(struct dw_pcie_rp *pp)
+{
+	qilai_pcie_iocp_cache_setup(pp);
+}
+
+static const struct dw_pcie_host_ops qilai_pcie_host_ops = {
+	.init = qilai_pcie_host_init,
+	.post_init = qilai_pcie_host_post_init,
+};
+
+static int qilai_pcie_probe(struct platform_device *pdev)
+{
+	struct qilai_pcie *pcie;
+	struct dw_pcie *pci;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, pcie);
+
+	pci = &pcie->pci;
+	pcie->pci.dev = dev;
+	pcie->pci.ops = &qilai_pcie_ops;
+	pcie->pci.pp.ops = &qilai_pcie_host_ops;
+	pci->use_parent_dt_ranges = true;
+
+	dw_pcie_cap_set(&pcie->pci, REQ_RES);
+
+	pcie->apb_base = devm_platform_ioremap_resource_byname(pdev, "apb");
+	if (IS_ERR(pcie->apb_base))
+		return PTR_ERR(pcie->apb_base);
+
+	ret = dw_pcie_host_init(&pcie->pci.pp);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to initialize PCIe host\n");
+		return ret;
+	}
+
+	return 0;
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
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+
+builtin_platform_driver(qilai_pcie_driver);
+
+MODULE_AUTHOR("Randolph Lin <randolph@andestech.com>");
+MODULE_DESCRIPTION("Andes QiLai PCIe driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


