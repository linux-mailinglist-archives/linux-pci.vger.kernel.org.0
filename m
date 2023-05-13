Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B3B70195C
	for <lists+linux-pci@lfdr.de>; Sat, 13 May 2023 20:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbjEMSqo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 May 2023 14:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjEMSqn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 May 2023 14:46:43 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19495213B;
        Sat, 13 May 2023 11:46:39 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34DIkPZX007312;
        Sat, 13 May 2023 13:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684003585;
        bh=CXea2lpYHMstq8Kqt1KnWuMEEIy5b0WXLeBI5VyCWeQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Ujn8MLDYUtULcsSkryXqzt6VzT7o3SnlOGO+3xcCt/NAmxVj1/SX+uK4td/JoZaLI
         3npcZs4lcNE7jt6P2JpoGvwK1eq+tZH22+yeMYvlNqmbjEsiFc868Ss4vNsupG0HQl
         LrEVPGThNEUOOSGvKgn9ID3s+1sVauvB7SgpnEQc=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34DIkPxG012359
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 13 May 2023 13:46:25 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 13
 May 2023 13:46:24 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 13 May 2023 13:46:24 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34DIkNTV024539;
        Sat, 13 May 2023 13:46:24 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, Achal Verma <a-verma1@ti.com>
Subject: [PATCH v2 2/2] PCI: j721e: Add support to build pci-j721e as a kernel module
Date:   Sun, 14 May 2023 00:16:20 +0530
Message-ID: <20230513184620.2200916-3-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230513184620.2200916-1-a-verma1@ti.com>
References: <20230513184620.2200916-1-a-verma1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci-j721e driver can be build as a in-built kernel driver only, which is
not required as it is not used during boot time in most cases.
This change add support to build pci-j721e as a kernel loadable module.

J721e PCIe controller can work in both host mode and end-point mode.
In order to enable host mode driver and endpoint driver to be built
independently either as built-in or kernel module, the pcie-j721e.c driver
is refactored into following components:

1) pci-j721e-host.c: Driver used when PCIe controller has to be
initialized in host mode.

2) pci-j721e-ep.c: Driver used when PCIe controller has to be
initialized in endpoint mode.

3) pci-j721e.c: contains common code required in both modes.

Signed-off-by: Achal Verma <a-verma1@ti.com>
---
 drivers/pci/controller/cadence/Kconfig        |   6 +-
 drivers/pci/controller/cadence/Makefile       |   2 +
 drivers/pci/controller/cadence/pci-j721e-ep.c | 130 +++++++
 .../pci/controller/cadence/pci-j721e-host.c   | 204 +++++++++++
 drivers/pci/controller/cadence/pci-j721e.c    | 343 +-----------------
 drivers/pci/controller/cadence/pci-j721e.h    |  88 +++++
 6 files changed, 443 insertions(+), 330 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/pci-j721e-ep.c
 create mode 100644 drivers/pci/controller/cadence/pci-j721e-host.c
 create mode 100644 drivers/pci/controller/cadence/pci-j721e.h

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index abc245dbedab..936335483b76 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -43,10 +43,10 @@ config PCIE_CADENCE_PLAT_EP
 	  different vendors SoCs.
 
 config PCI_J721E
-	bool
+	tristate
 
 config PCI_J721E_HOST
-	bool "TI J721E PCIe controller (host mode)"
+	tristate "TI J721E PCIe platform host controller"
 	depends on OF
 	select PCIE_CADENCE_HOST
 	select PCI_J721E
@@ -56,7 +56,7 @@ config PCI_J721E_HOST
 	  core.
 
 config PCI_J721E_EP
-	bool "TI J721E PCIe controller (endpoint mode)"
+	tristate "TI J721E PCIe platform endpoint controller"
 	depends on OF
 	depends on PCI_ENDPOINT
 	select PCIE_CADENCE_EP
diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index 9bac5fb2f13d..d49709870102 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -4,3 +4,5 @@ obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
 obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
 obj-$(CONFIG_PCI_J721E) += pci-j721e.o
+obj-$(CONFIG_PCI_J721E_HOST) += pci-j721e-host.o
+obj-$(CONFIG_PCI_J721E_EP) += pci-j721e-ep.o
diff --git a/drivers/pci/controller/cadence/pci-j721e-ep.c b/drivers/pci/controller/cadence/pci-j721e-ep.c
new file mode 100644
index 000000000000..33922e81b4e5
--- /dev/null
+++ b/drivers/pci/controller/cadence/pci-j721e-ep.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pci-j721e-ep - PCIe end-point controller driver for TI's J721E SoCs
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com
+ * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/of_device.h>
+
+#include "pcie-cadence.h"
+#include "pci-j721e.h"
+
+static const struct j721e_pcie_data j721e_pcie_ep_data = {
+	.mode = PCI_MODE_EP,
+	.linkdown_irq_regfield = LINK_DOWN,
+};
+
+static const struct j721e_pcie_data j7200_pcie_ep_data = {
+	.mode = PCI_MODE_EP,
+	.quirk_detect_quiet_flag = true,
+	.quirk_disable_flr = true,
+};
+
+static const struct j721e_pcie_data am64_pcie_ep_data = {
+	.mode = PCI_MODE_EP,
+	.linkdown_irq_regfield = J7200_LINK_DOWN,
+};
+
+static const struct of_device_id of_j721e_pcie_ep_match[] = {
+	{
+		.compatible = "ti,j721e-pcie-ep",
+		.data = &j721e_pcie_ep_data,
+	},
+	{
+		.compatible = "ti,j7200-pcie-ep",
+		.data = &j7200_pcie_ep_data,
+	},
+	{
+		.compatible = "ti,am64-pcie-ep",
+		.data = &am64_pcie_ep_data,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_j721e_pcie_ep_match);
+
+static int j721e_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct j721e_pcie_data *data;
+	struct cdns_pcie *cdns_pcie;
+	struct j721e_pcie *pcie;
+	struct cdns_pcie_ep *ep = NULL;
+	int ret;
+
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
+	if (!ep)
+		return -ENOMEM;
+
+	ep->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
+	ep->quirk_disable_flr = data->quirk_disable_flr;
+
+	cdns_pcie = &ep->pcie;
+	cdns_pcie->dev = dev;
+	cdns_pcie->ops = &j721e_pcie_ops;
+	pcie->cdns_pcie = cdns_pcie;
+
+	pcie->mode = PCI_MODE_EP;
+	pcie->linkdown_irq_regfield = data->linkdown_irq_regfield;
+
+	ret = j721e_pcie_common_init(pcie);
+	if (ret)
+		return ret;
+
+	ret = cdns_pcie_init_phy(dev, cdns_pcie);
+	if (ret) {
+		dev_err(dev, "Failed to init phy\n");
+		goto err_get_sync;
+	}
+
+	ret = cdns_pcie_ep_setup(ep);
+	if (ret < 0)
+		goto err_pcie_setup;
+
+
+	return 0;
+
+err_pcie_setup:
+	cdns_pcie_disable_phy(cdns_pcie);
+
+err_get_sync:
+	j721e_disable_common_init(dev);
+
+	return ret;
+}
+
+static int j721e_pcie_remove(struct platform_device *pdev)
+{
+	struct j721e_pcie *pcie = platform_get_drvdata(pdev);
+	struct cdns_pcie *cdns_pcie = pcie->cdns_pcie;
+	struct device *dev = &pdev->dev;
+
+	clk_disable_unprepare(pcie->refclk);
+	cdns_pcie_disable_phy(cdns_pcie);
+	j721e_disable_common_init(dev);
+
+	return 0;
+}
+
+static struct platform_driver j721e_pcie_ep_driver = {
+	.probe  = j721e_pcie_probe,
+	.remove = j721e_pcie_remove,
+	.driver = {
+		.name	= "j721e-pcie-ep",
+		.of_match_table = of_j721e_pcie_ep_match,
+		.suppress_bind_attrs = true,
+	},
+};
+module_platform_driver(j721e_pcie_ep_driver);
+MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/cadence/pci-j721e-host.c b/drivers/pci/controller/cadence/pci-j721e-host.c
new file mode 100644
index 000000000000..8f995d3f710c
--- /dev/null
+++ b/drivers/pci/controller/cadence/pci-j721e-host.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pci-j721e-host - PCIe host controller driver for TI's J721E SoCs
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com
+ * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
+#include <linux/of_device.h>
+
+#include "pcie-cadence.h"
+#include "pci-j721e.h"
+
+static int cdns_ti_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
+				    int where, int size, u32 *value)
+{
+	if (pci_is_root_bus(bus))
+		return pci_generic_config_read32(bus, devfn, where, size,
+						 value);
+
+	return pci_generic_config_read(bus, devfn, where, size, value);
+}
+
+static int cdns_ti_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
+				     int where, int size, u32 value)
+{
+	if (pci_is_root_bus(bus))
+		return pci_generic_config_write32(bus, devfn, where, size,
+						  value);
+
+	return pci_generic_config_write(bus, devfn, where, size, value);
+}
+
+static struct pci_ops cdns_ti_pcie_host_ops = {
+	.map_bus	= cdns_pci_map_bus,
+	.read		= cdns_ti_pcie_config_read,
+	.write		= cdns_ti_pcie_config_write,
+};
+
+static const struct j721e_pcie_data j721e_pcie_rc_data = {
+	.mode = PCI_MODE_RC,
+	.quirk_retrain_flag = true,
+	.byte_access_allowed = false,
+	.linkdown_irq_regfield = LINK_DOWN,
+};
+
+static const struct j721e_pcie_data j7200_pcie_rc_data = {
+	.mode = PCI_MODE_RC,
+	.quirk_detect_quiet_flag = true,
+	.linkdown_irq_regfield = J7200_LINK_DOWN,
+	.byte_access_allowed = true,
+};
+
+static const struct j721e_pcie_data am64_pcie_rc_data = {
+	.mode = PCI_MODE_RC,
+	.linkdown_irq_regfield = J7200_LINK_DOWN,
+	.byte_access_allowed = true,
+};
+
+static const struct of_device_id of_j721e_pcie_host_match[] = {
+	{
+		.compatible = "ti,j721e-pcie-host",
+		.data = &j721e_pcie_rc_data,
+	},
+	{
+		.compatible = "ti,j7200-pcie-host",
+		.data = &j7200_pcie_rc_data,
+	},
+	{
+		.compatible = "ti,am64-pcie-host",
+		.data = &am64_pcie_rc_data,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_j721e_pcie_host_match);
+
+static int j721e_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pci_host_bridge *bridge;
+	const struct j721e_pcie_data *data;
+	struct cdns_pcie *cdns_pcie;
+	struct j721e_pcie *pcie;
+	struct cdns_pcie_rc *rc = NULL;
+	struct gpio_desc *gpiod;
+	struct clk *clk;
+	int ret;
+
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
+	if (!bridge)
+		return -ENOMEM;
+
+	if (!data->byte_access_allowed)
+		bridge->ops = &cdns_ti_pcie_host_ops;
+	rc = pci_host_bridge_priv(bridge);
+	rc->quirk_retrain_flag = data->quirk_retrain_flag;
+	rc->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
+
+	cdns_pcie = &rc->pcie;
+	cdns_pcie->dev = dev;
+	cdns_pcie->ops = &j721e_pcie_ops;
+	pcie->cdns_pcie = cdns_pcie;
+
+	pcie->mode = PCI_MODE_RC;
+	pcie->linkdown_irq_regfield = data->linkdown_irq_regfield;
+
+	ret = j721e_pcie_common_init(pcie);
+	if (ret)
+		return ret;
+
+	gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod)) {
+		ret = PTR_ERR(gpiod);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get reset GPIO\n");
+		goto err_get_sync;
+	}
+
+	ret = cdns_pcie_init_phy(dev, cdns_pcie);
+	if (ret) {
+		dev_err(dev, "Failed to init phy\n");
+		goto err_get_sync;
+	}
+
+	clk = devm_clk_get_optional(dev, "pcie_refclk");
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		dev_err(dev, "failed to get pcie_refclk\n");
+		goto err_pcie_setup;
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		dev_err(dev, "failed to enable pcie_refclk\n");
+		goto err_pcie_setup;
+	}
+	pcie->refclk = clk;
+
+	/*
+	 * "Power Sequencing and Reset Signal Timings" table in
+	 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 3.0
+	 * indicates PERST# should be deasserted after minimum of 100us
+	 * once REFCLK is stable. The REFCLK to the connector in RC
+	 * mode is selected while enabling the PHY. So deassert PERST#
+	 * after 100 us.
+	 */
+	if (gpiod) {
+		usleep_range(100, 200);
+		gpiod_set_value_cansleep(gpiod, 1);
+	}
+
+	ret = cdns_pcie_host_setup(rc);
+	if (ret < 0) {
+		clk_disable_unprepare(pcie->refclk);
+		goto err_pcie_setup;
+	}
+
+	return 0;
+
+err_pcie_setup:
+	cdns_pcie_disable_phy(cdns_pcie);
+
+err_get_sync:
+	j721e_disable_common_init(dev);
+
+	return ret;
+}
+
+static int j721e_pcie_remove(struct platform_device *pdev)
+{
+	struct j721e_pcie *pcie = platform_get_drvdata(pdev);
+	struct cdns_pcie *cdns_pcie = pcie->cdns_pcie;
+	struct device *dev = &pdev->dev;
+
+	clk_disable_unprepare(pcie->refclk);
+	cdns_pcie_disable_phy(cdns_pcie);
+	j721e_disable_common_init(dev);
+
+	return 0;
+}
+
+static struct platform_driver j721e_pcie_host_driver = {
+	.probe  = j721e_pcie_probe,
+	.remove = j721e_pcie_remove,
+	.driver = {
+		.name	= "j721e-pcie-host",
+		.of_match_table = of_j721e_pcie_host_match,
+		.suppress_bind_attrs = true,
+	},
+};
+module_platform_driver(j721e_pcie_host_driver);
+MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index cc83a8925ce0..832644ee2c70 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -2,98 +2,18 @@
 /*
  * pci-j721e - PCIe controller driver for TI's J721E SoCs
  *
- * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2020-2023 Texas Instruments Incorporated - http://www.ti.com
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
-#include <linux/clk.h>
-#include <linux/delay.h>
-#include <linux/gpio/consumer.h>
-#include <linux/io.h>
-#include <linux/irqchip/chained_irq.h>
-#include <linux/irqdomain.h>
 #include <linux/mfd/syscon.h>
-#include <linux/of.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
-#include <linux/pci.h>
-#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #include "../../pci.h"
 #include "pcie-cadence.h"
-
-#define ENABLE_REG_SYS_2	0x108
-#define STATUS_REG_SYS_2	0x508
-#define STATUS_CLR_REG_SYS_2	0x708
-#define LINK_DOWN		BIT(1)
-#define J7200_LINK_DOWN		BIT(10)
-
-#define J721E_PCIE_USER_CMD_STATUS	0x4
-#define LINK_TRAINING_ENABLE		BIT(0)
-
-#define J721E_PCIE_USER_LINKSTATUS	0x14
-#define LINK_STATUS			GENMASK(1, 0)
-
-enum link_status {
-	NO_RECEIVERS_DETECTED,
-	LINK_TRAINING_IN_PROGRESS,
-	LINK_UP_DL_IN_PROGRESS,
-	LINK_UP_DL_COMPLETED,
-};
-
-#define J721E_MODE_RC			BIT(7)
-#define LANE_COUNT_MASK			BIT(8)
-#define LANE_COUNT(n)			((n) << 8)
-
-#define GENERATION_SEL_MASK		GENMASK(1, 0)
-
-#define MAX_LANES			2
-
-struct j721e_pcie {
-	struct cdns_pcie	*cdns_pcie;
-	struct clk		*refclk;
-	u32			mode;
-	u32			num_lanes;
-	void __iomem		*user_cfg_base;
-	void __iomem		*intd_cfg_base;
-	u32			linkdown_irq_regfield;
-};
-
-enum j721e_pcie_mode {
-	PCI_MODE_RC,
-	PCI_MODE_EP,
-};
-
-struct j721e_pcie_data {
-	enum j721e_pcie_mode	mode;
-	unsigned int		quirk_retrain_flag:1;
-	unsigned int		quirk_detect_quiet_flag:1;
-	unsigned int		quirk_disable_flr:1;
-	u32			linkdown_irq_regfield;
-	unsigned int		byte_access_allowed:1;
-};
-
-static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
-{
-	return readl(pcie->user_cfg_base + offset);
-}
-
-static inline void j721e_pcie_user_writel(struct j721e_pcie *pcie, u32 offset,
-					  u32 value)
-{
-	writel(value, pcie->user_cfg_base + offset);
-}
-
-static inline u32 j721e_pcie_intd_readl(struct j721e_pcie *pcie, u32 offset)
-{
-	return readl(pcie->intd_cfg_base + offset);
-}
-
-static inline void j721e_pcie_intd_writel(struct j721e_pcie *pcie, u32 offset,
-					  u32 value)
-{
-	writel(value, pcie->intd_cfg_base + offset);
-}
+#include "pci-j721e.h"
 
 static irqreturn_t j721e_pcie_link_irq_handler(int irq, void *priv)
 {
@@ -155,11 +75,12 @@ static bool j721e_pcie_link_up(struct cdns_pcie *cdns_pcie)
 	return false;
 }
 
-static const struct cdns_pcie_ops j721e_pcie_ops = {
+const struct cdns_pcie_ops j721e_pcie_ops = {
 	.start_link = j721e_pcie_start_link,
 	.stop_link = j721e_pcie_stop_link,
 	.link_up = j721e_pcie_link_up,
 };
+EXPORT_SYMBOL_GPL(j721e_pcie_ops);
 
 static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon,
 			       unsigned int offset)
@@ -181,7 +102,7 @@ static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon,
 }
 
 static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
-				     struct regmap *syscon, unsigned int offset)
+			     struct regmap *syscon, unsigned int offset)
 {
 	struct device *dev = pcie->cdns_pcie->dev;
 	struct device_node *np = dev->of_node;
@@ -259,167 +180,15 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 	return 0;
 }
 
-static int cdns_ti_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
-				    int where, int size, u32 *value)
-{
-	if (pci_is_root_bus(bus))
-		return pci_generic_config_read32(bus, devfn, where, size,
-						 value);
-
-	return pci_generic_config_read(bus, devfn, where, size, value);
-}
-
-static int cdns_ti_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
-				     int where, int size, u32 value)
-{
-	if (pci_is_root_bus(bus))
-		return pci_generic_config_write32(bus, devfn, where, size,
-						  value);
-
-	return pci_generic_config_write(bus, devfn, where, size, value);
-}
-
-static struct pci_ops cdns_ti_pcie_host_ops = {
-	.map_bus	= cdns_pci_map_bus,
-	.read		= cdns_ti_pcie_config_read,
-	.write		= cdns_ti_pcie_config_write,
-};
-
-static const struct j721e_pcie_data j721e_pcie_rc_data = {
-	.mode = PCI_MODE_RC,
-	.quirk_retrain_flag = true,
-	.byte_access_allowed = false,
-	.linkdown_irq_regfield = LINK_DOWN,
-};
-
-static const struct j721e_pcie_data j721e_pcie_ep_data = {
-	.mode = PCI_MODE_EP,
-	.linkdown_irq_regfield = LINK_DOWN,
-};
-
-static const struct j721e_pcie_data j7200_pcie_rc_data = {
-	.mode = PCI_MODE_RC,
-	.quirk_detect_quiet_flag = true,
-	.linkdown_irq_regfield = J7200_LINK_DOWN,
-	.byte_access_allowed = true,
-};
-
-static const struct j721e_pcie_data j7200_pcie_ep_data = {
-	.mode = PCI_MODE_EP,
-	.quirk_detect_quiet_flag = true,
-	.quirk_disable_flr = true,
-};
-
-static const struct j721e_pcie_data am64_pcie_rc_data = {
-	.mode = PCI_MODE_RC,
-	.linkdown_irq_regfield = J7200_LINK_DOWN,
-	.byte_access_allowed = true,
-};
-
-static const struct j721e_pcie_data am64_pcie_ep_data = {
-	.mode = PCI_MODE_EP,
-	.linkdown_irq_regfield = J7200_LINK_DOWN,
-};
-
-static const struct of_device_id of_j721e_pcie_match[] = {
-	{
-		.compatible = "ti,j721e-pcie-host",
-		.data = &j721e_pcie_rc_data,
-	},
-	{
-		.compatible = "ti,j721e-pcie-ep",
-		.data = &j721e_pcie_ep_data,
-	},
-	{
-		.compatible = "ti,j7200-pcie-host",
-		.data = &j7200_pcie_rc_data,
-	},
-	{
-		.compatible = "ti,j7200-pcie-ep",
-		.data = &j7200_pcie_ep_data,
-	},
-	{
-		.compatible = "ti,am64-pcie-host",
-		.data = &am64_pcie_rc_data,
-	},
-	{
-		.compatible = "ti,am64-pcie-ep",
-		.data = &am64_pcie_ep_data,
-	},
-	{},
-};
-
-static int j721e_pcie_probe(struct platform_device *pdev)
+int j721e_pcie_common_init(struct j721e_pcie *pcie)
 {
-	struct device *dev = &pdev->dev;
+	struct device *dev = pcie->cdns_pcie->dev;
+	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *node = dev->of_node;
-	struct pci_host_bridge *bridge;
-	const struct j721e_pcie_data *data;
-	struct cdns_pcie *cdns_pcie;
-	struct j721e_pcie *pcie;
-	struct cdns_pcie_rc *rc = NULL;
-	struct cdns_pcie_ep *ep = NULL;
-	struct gpio_desc *gpiod;
 	void __iomem *base;
-	struct clk *clk;
+	int irq;
 	u32 num_lanes;
-	u32 mode;
 	int ret;
-	int irq;
-
-	data = of_device_get_match_data(dev);
-	if (!data)
-		return -EINVAL;
-
-	mode = (u32)data->mode;
-
-	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
-	if (!pcie)
-		return -ENOMEM;
-
-	switch (mode) {
-	case PCI_MODE_RC:
-		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_HOST))
-			return -ENODEV;
-
-		bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
-		if (!bridge)
-			return -ENOMEM;
-
-		if (!data->byte_access_allowed)
-			bridge->ops = &cdns_ti_pcie_host_ops;
-		rc = pci_host_bridge_priv(bridge);
-		rc->quirk_retrain_flag = data->quirk_retrain_flag;
-		rc->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
-
-		cdns_pcie = &rc->pcie;
-		cdns_pcie->dev = dev;
-		cdns_pcie->ops = &j721e_pcie_ops;
-		pcie->cdns_pcie = cdns_pcie;
-		break;
-	case PCI_MODE_EP:
-		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_EP))
-			return -ENODEV;
-
-		ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
-		if (!ep)
-			return -ENOMEM;
-
-		ep->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
-		ep->quirk_disable_flr = data->quirk_disable_flr;
-
-		cdns_pcie = &ep->pcie;
-		cdns_pcie->dev = dev;
-		cdns_pcie->ops = &j721e_pcie_ops;
-		pcie->cdns_pcie = cdns_pcie;
-		break;
-	default:
-		dev_err(dev, "INVALID device type %d\n", mode);
-		return 0;
-	}
-
-	pcie->mode = mode;
-	pcie->linkdown_irq_regfield = data->linkdown_irq_regfield;
 
 	base = devm_platform_ioremap_resource_byname(pdev, "intd_cfg");
 	if (IS_ERR(base))
@@ -444,6 +213,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		return irq;
 
 	dev_set_drvdata(dev, pcie);
+
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
@@ -466,103 +236,22 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 	j721e_pcie_config_link_irq(pcie);
 
-	switch (mode) {
-	case PCI_MODE_RC:
-		gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
-		if (IS_ERR(gpiod)) {
-			ret = PTR_ERR(gpiod);
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "Failed to get reset GPIO\n");
-			goto err_get_sync;
-		}
-
-		ret = cdns_pcie_init_phy(dev, cdns_pcie);
-		if (ret) {
-			dev_err(dev, "Failed to init phy\n");
-			goto err_get_sync;
-		}
-
-		clk = devm_clk_get_optional(dev, "pcie_refclk");
-		if (IS_ERR(clk)) {
-			ret = PTR_ERR(clk);
-			dev_err(dev, "failed to get pcie_refclk\n");
-			goto err_pcie_setup;
-		}
-
-		ret = clk_prepare_enable(clk);
-		if (ret) {
-			dev_err(dev, "failed to enable pcie_refclk\n");
-			goto err_pcie_setup;
-		}
-		pcie->refclk = clk;
-
-		/*
-		 * "Power Sequencing and Reset Signal Timings" table in
-		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 3.0
-		 * indicates PERST# should be deasserted after minimum of 100us
-		 * once REFCLK is stable. The REFCLK to the connector in RC
-		 * mode is selected while enabling the PHY. So deassert PERST#
-		 * after 100 us.
-		 */
-		if (gpiod) {
-			usleep_range(100, 200);
-			gpiod_set_value_cansleep(gpiod, 1);
-		}
-
-		ret = cdns_pcie_host_setup(rc);
-		if (ret < 0) {
-			clk_disable_unprepare(pcie->refclk);
-			goto err_pcie_setup;
-		}
-
-		break;
-	case PCI_MODE_EP:
-		ret = cdns_pcie_init_phy(dev, cdns_pcie);
-		if (ret) {
-			dev_err(dev, "Failed to init phy\n");
-			goto err_get_sync;
-		}
-
-		ret = cdns_pcie_ep_setup(ep);
-		if (ret < 0)
-			goto err_pcie_setup;
-
-		break;
-	}
-
 	return 0;
 
-err_pcie_setup:
-	cdns_pcie_disable_phy(cdns_pcie);
-
 err_get_sync:
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
 
 	return ret;
+
 }
+EXPORT_SYMBOL_GPL(j721e_pcie_common_init);
 
-static int j721e_pcie_remove(struct platform_device *pdev)
+void j721e_disable_common_init(struct device *dev)
 {
-	struct j721e_pcie *pcie = platform_get_drvdata(pdev);
-	struct cdns_pcie *cdns_pcie = pcie->cdns_pcie;
-	struct device *dev = &pdev->dev;
-
-	clk_disable_unprepare(pcie->refclk);
-	cdns_pcie_disable_phy(cdns_pcie);
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
-
-	return 0;
 }
+EXPORT_SYMBOL_GPL(j721e_disable_common_init);
 
-static struct platform_driver j721e_pcie_driver = {
-	.probe  = j721e_pcie_probe,
-	.remove = j721e_pcie_remove,
-	.driver = {
-		.name	= "j721e-pcie",
-		.of_match_table = of_j721e_pcie_match,
-		.suppress_bind_attrs = true,
-	},
-};
-builtin_platform_driver(j721e_pcie_driver);
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/cadence/pci-j721e.h b/drivers/pci/controller/cadence/pci-j721e.h
new file mode 100644
index 000000000000..3f3cfed16ad7
--- /dev/null
+++ b/drivers/pci/controller/cadence/pci-j721e.h
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pci-j721e - PCIe controller driver for TI's J721E SoCs
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com
+ */
+
+#ifndef _PCIE_J721E_H
+#define _PCIE_J721E_H
+
+#define ENABLE_REG_SYS_2	0x108
+#define STATUS_REG_SYS_2	0x508
+#define STATUS_CLR_REG_SYS_2	0x708
+#define LINK_DOWN		BIT(1)
+#define J7200_LINK_DOWN		BIT(10)
+
+#define J721E_PCIE_USER_CMD_STATUS	0x4
+#define LINK_TRAINING_ENABLE		BIT(0)
+
+#define J721E_PCIE_USER_LINKSTATUS	0x14
+#define LINK_STATUS			GENMASK(1, 0)
+
+enum link_status {
+	NO_RECEIVERS_DETECTED,
+	LINK_TRAINING_IN_PROGRESS,
+	LINK_UP_DL_IN_PROGRESS,
+	LINK_UP_DL_COMPLETED,
+};
+
+#define J721E_MODE_RC			BIT(7)
+#define LANE_COUNT_MASK			BIT(8)
+#define LANE_COUNT(n)			((n) << 8)
+
+#define GENERATION_SEL_MASK		GENMASK(1, 0)
+
+#define MAX_LANES			2
+
+struct j721e_pcie {
+	struct cdns_pcie	*cdns_pcie;
+	struct clk		*refclk;
+	u32			mode;
+	u32			num_lanes;
+	void __iomem		*user_cfg_base;
+	void __iomem		*intd_cfg_base;
+	u32			linkdown_irq_regfield;
+};
+
+enum j721e_pcie_mode {
+	PCI_MODE_RC,
+	PCI_MODE_EP,
+};
+
+struct j721e_pcie_data {
+	enum j721e_pcie_mode	mode;
+	unsigned int		quirk_retrain_flag:1;
+	unsigned int		quirk_detect_quiet_flag:1;
+	unsigned int		quirk_disable_flr:1;
+	u32			linkdown_irq_regfield;
+	unsigned int		byte_access_allowed:1;
+};
+
+static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
+{
+	return readl(pcie->user_cfg_base + offset);
+}
+
+static inline void j721e_pcie_user_writel(struct j721e_pcie *pcie, u32 offset,
+					  u32 value)
+{
+	writel(value, pcie->user_cfg_base + offset);
+}
+
+static inline u32 j721e_pcie_intd_readl(struct j721e_pcie *pcie, u32 offset)
+{
+	return readl(pcie->intd_cfg_base + offset);
+}
+
+static inline void j721e_pcie_intd_writel(struct j721e_pcie *pcie, u32 offset,
+					  u32 value)
+{
+	writel(value, pcie->intd_cfg_base + offset);
+}
+
+extern const struct cdns_pcie_ops j721e_pcie_ops;
+int j721e_pcie_common_init(struct j721e_pcie *pcie);
+void j721e_disable_common_init(struct device *dev);
+
+#endif /* _PCIE_J721E_H */
-- 
2.25.1

