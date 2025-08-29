Return-Path: <linux-pci+bounces-35091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2B7B3B5F2
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 10:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E4B1C85A96
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 08:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27B6286402;
	Fri, 29 Aug 2025 08:24:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5B427CCE2;
	Fri, 29 Aug 2025 08:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756455871; cv=none; b=Q80aOHkr/u5DcT71D067Y3lduZDl9XBfWUASiN2mLMTjoqWzdH8SmaL97kzIfkwREXQbi+2PKNovr+ZuOJdX1A7vSR6IOP7T39wshBaaHBxnds58K4r4PJx0genKZCbx/yYlu2Pa+Dkf0GifruOSFK+zytfQT/AtHmChXxgAJz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756455871; c=relaxed/simple;
	bh=HuRBr4DeKf4h0ZHdI9uVOEumW9yYIUjlHyYdC1c6pqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQrFG7z/zXyzW8bBdUQFpYEF10qtIDfAmyseGtbqywadBc7CF/+yiCkSh1m1yVQvTek01TsVSvBvX5U27zzw+gB7UQgZ9iZ5hr16h7Fk+jVmTgwmHsuvGkiE0KdHuL1E4B3JGI6hK6lvCokPp2R/ZpkLgpITeEx8MRr0gTpZUMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004758DT.eswin.cn (unknown [10.12.96.83])
	by app2 (Coremail) with SMTP id TQJkCgBnBpWoY7FooQfFAA--.41052S2;
	Fri, 29 Aug 2025 16:24:10 +0800 (CST)
From: zhangsenchuan@eswincomputing.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de,
	johan+linaro@kernel.org,
	quic_schintav@quicinc.com,
	shradha.t@samsung.com,
	cassel@kernel.org,
	thippeswamy.havalige@amd.com,
	mayank.rana@oss.qualcomm.com,
	inochiama@gmail.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: [PATCH v2 2/2] PCI: eic7700: Add Eswin eic7700 PCIe host controller driver
Date: Fri, 29 Aug 2025 16:24:05 +0800
Message-ID: <20250829082405.1203-1-zhangsenchuan@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250829082021.49-1-zhangsenchuan@eswincomputing.com>
References: <20250829082021.49-1-zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgBnBpWoY7FooQfFAA--.41052S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Kw4kCrWrtF15KryxurWkCrg_yoWktFyfpa
	1UJayYyF48JrW3Wa13AF95uF4avFnxua4UJ39agan7uay3J34kWr1ftry3tF97Cr4kury3
	J3WUta4xCF43JwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBm14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRNSdgDUUUU
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/

From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>

Add driver for the Eswin EIC7700 PCIe host controller.
The controller is based on the DesignWare PCIe core.

Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
Signed-off-by: Senchuan Zhang<zhangsenchuan@eswincomputing.com>
---
 drivers/pci/controller/dwc/Kconfig        |  12 +
 drivers/pci/controller/dwc/Makefile       |   1 +
 drivers/pci/controller/dwc/pcie-eic7700.c | 350 ++++++++++++++++++++++
 3 files changed, 363 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-eic7700.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index ff6b6d9e18ec..1c4063107a8a 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -492,4 +492,16 @@ config PCIE_VISCONTI_HOST
 	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
 	  This driver supports TMPV7708 SoC.

+config PCIE_EIC7700
+	tristate "ESWIN PCIe host controller"
+	depends on PCI_MSI
+	depends on ARCH_ESWIN || COMPILE_TEST
+	select PCIE_DW_HOST
+	help
+	  Enables support for the PCIe controller in the Eswin SoC
+	  The PCI controller on Eswin is based on DesignWare hardware
+	  It is a high-speed hardware bus standard used to connect
+	  processors with external devices. Say Y here if you want
+	  PCIe controller support for the ESWIN.
+
 endmenu
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 6919d27798d1..0717fe73a2a9 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
 obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
 obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
 obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
+obj-$(CONFIG_PCIE_EIC7700) += pcie-eic7700.o

 # The following drivers are for devices that use the generic ACPI
 # pci_root.c driver but don't support standard ECAM config access.
diff --git a/drivers/pci/controller/dwc/pcie-eic7700.c b/drivers/pci/controller/dwc/pcie-eic7700.c
new file mode 100644
index 000000000000..bf942154d971
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-eic7700.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ESWIN PCIe root complex driver
+ *
+ * Copyright 2025, Beijing ESWIN Computing Technology Co., Ltd.
+ *
+ * Authors: Yu Ning <ningyu@eswincomputing.com>
+ *          Senchuan Zhang <zhangsenchuan@eswincomputing.com>
+ */
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/reset.h>
+#include <linux/pm_runtime.h>
+
+#include "pcie-designware.h"
+
+struct eswin_pcie {
+	struct dw_pcie pci;
+	void __iomem *mgmt_base;
+	struct clk_bulk_data *clks;
+	struct reset_control *powerup_rst;
+	struct reset_control *cfg_rst;
+	struct reset_control *perst;
+
+	int num_clks;
+};
+
+#define PCIE_PM_SEL_AUX_CLK BIT(16)
+#define PCIEMGMT_APP_LTSSM_ENABLE BIT(5)
+
+#define PCIEMGMT_CTRL0_OFFSET 0x0
+#define PCIEMGMT_STATUS0_OFFSET 0x100
+
+#define PCIE_TYPE_DEV_VEND_ID 0x0
+#define PCIE_DSP_PF0_MSI_CAP 0x50
+#define PCIE_NEXT_CAP_PTR 0x70
+#define DEVICE_CONTROL_DEVICE_STATUS 0x78
+
+#define PCIE_MSI_MULTIPLE_MSG_32 (0x5 << 17)
+#define PCIE_MSI_MULTIPLE_MSG_MASK (0x7 << 17)
+
+#define PCIEMGMT_LINKUP_STATE_VALIDATE ((0x11 << 2) | 0x3)
+#define PCIEMGMT_LINKUP_STATE_MASK 0xff
+
+static int eswin_pcie_start_link(struct dw_pcie *pci)
+{
+	struct device *dev = pci->dev;
+	struct eswin_pcie *pcie = dev_get_drvdata(dev);
+	u32 val;
+
+	/* Enable LTSSM */
+	val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
+	val |= PCIEMGMT_APP_LTSSM_ENABLE;
+	writel_relaxed(val, pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
+
+	return 0;
+}
+
+static bool eswin_pcie_link_up(struct dw_pcie *pci)
+{
+	struct device *dev = pci->dev;
+	struct eswin_pcie *pcie = dev_get_drvdata(dev);
+	u32 val;
+
+	val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_STATUS0_OFFSET);
+
+	return ((val & PCIEMGMT_LINKUP_STATE_MASK) ==
+		     PCIEMGMT_LINKUP_STATE_VALIDATE);
+}
+
+static int eswin_pcie_power_on(struct eswin_pcie *pcie)
+{
+	int ret = 0;
+
+	/* pciet_cfg_rstn */
+	ret = reset_control_deassert(pcie->cfg_rst);
+	if (ret) {
+		dev_err(pcie->pci.dev, "cfg signal is invalid");
+		return ret;
+	}
+
+	/* pciet_powerup_rstn */
+	ret = reset_control_deassert(pcie->powerup_rst);
+	if (ret) {
+		dev_err(pcie->pci.dev, "powerup signal is invalid");
+		goto err_deassert_powerup;
+	}
+
+	return ret;
+
+err_deassert_powerup:
+	reset_control_assert(pcie->cfg_rst);
+
+	return ret;
+}
+
+static void eswin_pcie_power_off(struct eswin_pcie *eswin_pcie)
+{
+	reset_control_assert(eswin_pcie->powerup_rst);
+	reset_control_assert(eswin_pcie->cfg_rst);
+}
+
+static int eswin_pcie_host_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct eswin_pcie *pcie = dev_get_drvdata(pci->dev);
+	int ret;
+	u32 val;
+	u32 retries;
+
+	/* Fetch clocks */
+	pcie->num_clks = devm_clk_bulk_get_all_enabled(pci->dev, &pcie->clks);
+	if (pcie->num_clks < 0)
+		return dev_err_probe(pci->dev, pcie->num_clks,
+				     "failed to get pcie clocks\n");
+
+	ret = eswin_pcie_power_on(pcie);
+	if (ret)
+		return ret;
+
+	/* set device type : rc */
+	val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
+	val &= 0xfffffff0;
+	writel_relaxed(val | 0x4, pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
+
+	ret = reset_control_assert(pcie->perst);
+	if (ret) {
+		dev_err(pci->dev, "perst assert signal is invalid");
+		goto err_perst;
+	}
+	msleep(100);
+	ret = reset_control_deassert(pcie->perst);
+	if (ret) {
+		dev_err(pci->dev, "perst deassert signal is invalid");
+		goto err_perst;
+	}
+
+	/* app_hold_phy_rst */
+	val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
+	val &= ~(0x40);
+	writel_relaxed(val, pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
+
+	/*
+	 * It takes at least 20ms to wait for the pcie
+	 * status register to be 0.
+	 */
+	retries = 30;
+	do {
+		val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_STATUS0_OFFSET);
+		if (!(val & PCIE_PM_SEL_AUX_CLK))
+			break;
+		usleep_range(1000, 1100);
+		retries--;
+	} while (retries);
+
+	if (!retries) {
+		dev_err(pci->dev, "No clock exist.\n");
+		ret = -ENODEV;
+		goto err_clock;
+	}
+
+	/* config eswin vendor id and eic7700 device id */
+	dw_pcie_writel_dbi(pci, PCIE_TYPE_DEV_VEND_ID, 0x20301fe1);
+
+	/* lane fix config, real driver NOT need, default x4 */
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL);
+	val &= 0xffffff80;
+	val |= 0x44;
+	dw_pcie_writel_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL, val);
+
+	val = dw_pcie_readl_dbi(pci, DEVICE_CONTROL_DEVICE_STATUS);
+	val &= ~(0x7 << 5);
+	val |= (0x2 << 5);
+	dw_pcie_writel_dbi(pci, DEVICE_CONTROL_DEVICE_STATUS, val);
+
+	/*  config support 32 msi vectors */
+	val = dw_pcie_readl_dbi(pci, PCIE_DSP_PF0_MSI_CAP);
+	val &= ~PCIE_MSI_MULTIPLE_MSG_MASK;
+	val |= PCIE_MSI_MULTIPLE_MSG_32;
+	dw_pcie_writel_dbi(pci, PCIE_DSP_PF0_MSI_CAP, val);
+
+	/* disable msix cap */
+	val = dw_pcie_readl_dbi(pci, PCIE_NEXT_CAP_PTR);
+	val &= 0xffff00ff;
+	dw_pcie_writel_dbi(pci, PCIE_NEXT_CAP_PTR, val);
+
+	return 0;
+
+err_clock:
+	reset_control_assert(pcie->perst);
+err_perst:
+	eswin_pcie_power_off(pcie);
+	return ret;
+}
+
+static const struct dw_pcie_host_ops eswin_pcie_host_ops = {
+	.init = eswin_pcie_host_init,
+};
+
+static const struct dw_pcie_ops dw_pcie_ops = {
+	.start_link = eswin_pcie_start_link,
+	.link_up = eswin_pcie_link_up,
+};
+
+static int eswin_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dw_pcie *pci;
+	struct eswin_pcie *pcie;
+	int ret;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pci = &pcie->pci;
+	pci->dev = dev;
+	pci->ops = &dw_pcie_ops;
+	pci->pp.ops = &eswin_pcie_host_ops;
+
+	/* SiFive specific region: mgmt */
+	pcie->mgmt_base = devm_platform_ioremap_resource_byname(pdev, "mgmt");
+	if (IS_ERR(pcie->mgmt_base))
+		return dev_err_probe(dev, PTR_ERR(pcie->mgmt_base),
+				     "failed to map mgmt memory\n");
+
+	/* Fetch reset */
+	pcie->powerup_rst = devm_reset_control_get_optional(&pdev->dev,
+							    "powerup");
+	if (IS_ERR_OR_NULL(pcie->powerup_rst))
+		return dev_err_probe(dev, PTR_ERR(pcie->powerup_rst),
+				     "unable to get powerup reset\n");
+
+	pcie->cfg_rst = devm_reset_control_get_optional(&pdev->dev, "cfg");
+	if (IS_ERR_OR_NULL(pcie->cfg_rst))
+		return dev_err_probe(dev, PTR_ERR(pcie->cfg_rst),
+				     "unable to get cfg reset\n");
+
+	pcie->perst = devm_reset_control_get_optional(&pdev->dev, "pwren");
+	if (IS_ERR_OR_NULL(pcie->perst))
+		return dev_err_probe(dev, PTR_ERR(pcie->perst),
+				     "unable to get perst reset\n");
+
+	platform_set_drvdata(pdev, pcie);
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "pm_runtime_get_sync failed: %d\n", ret);
+		goto err_get_sync;
+	}
+
+	ret = dw_pcie_host_init(&pci->pp);
+	if (ret) {
+		dev_err(dev, "failed to initialize host: %d\n", ret);
+		goto err_host_init;
+	}
+
+	return ret;
+
+err_host_init:
+	pm_runtime_put_sync(dev);
+err_get_sync:
+	pm_runtime_disable(dev);
+	return ret;
+}
+
+static void eswin_pcie_remove(struct platform_device *pdev)
+{
+	struct eswin_pcie *pcie = platform_get_drvdata(pdev);
+
+	dw_pcie_host_deinit(&pcie->pci.pp);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	reset_control_assert(pcie->perst);
+	eswin_pcie_power_off(pcie);
+}
+
+static void eswin_pcie_shutdown(struct platform_device *pdev)
+{
+	struct eswin_pcie *pcie = platform_get_drvdata(pdev);
+
+	/* Bring down link, so bootloader gets clean state in case of reboot */
+	reset_control_assert(pcie->perst);
+}
+
+static int eswin_pcie_suspend(struct device *dev)
+{
+	struct eswin_pcie *pcie = dev_get_drvdata(dev);
+
+	reset_control_assert(pcie->perst);
+	eswin_pcie_power_off(pcie);
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
+
+	return 0;
+}
+
+static int eswin_pcie_resume(struct device *dev)
+{
+	int ret;
+	struct eswin_pcie *pcie = dev_get_drvdata(dev);
+
+	ret = eswin_pcie_host_init(&pcie->pci.pp);
+	if (ret < 0) {
+		dev_err(dev, "Failed to init host: %d\n", ret);
+		return ret;
+	}
+
+	dw_pcie_setup_rc(&pcie->pci.pp);
+	eswin_pcie_start_link(&pcie->pci);
+	dw_pcie_wait_for_link(&pcie->pci);
+
+	return 0;
+}
+
+static const struct dev_pm_ops eswin_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(eswin_pcie_suspend, eswin_pcie_resume)
+};
+
+static const struct of_device_id eswin_pcie_of_match[] = {
+	{ .compatible = "eswin,eic7700-pcie" },
+	{},
+};
+
+static struct platform_driver eswin_pcie_driver = {
+	.driver = {
+		.name = "eic7700-pcie",
+		.of_match_table = eswin_pcie_of_match,
+		.suppress_bind_attrs = true,
+		.pm = &eswin_pcie_pm_ops,
+	},
+	.probe = eswin_pcie_probe,
+	.remove = eswin_pcie_remove,
+	.shutdown = eswin_pcie_shutdown,
+};
+
+module_platform_driver(eswin_pcie_driver);
+
+MODULE_DEVICE_TABLE(of, eswin_pcie_of_match);
+MODULE_DESCRIPTION("PCIe host controller driver for eic7700 SoCs");
+MODULE_AUTHOR("Yu Ning <ningyu@eswincomputing.com>");
+MODULE_AUTHOR("Senchuan Zhang <zhangsenchuan@eswincomputing.com>");
+MODULE_LICENSE("GPL");
--
2.25.1


