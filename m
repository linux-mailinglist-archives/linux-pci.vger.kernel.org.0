Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829B877F60B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 14:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350603AbjHQMJB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 08:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350681AbjHQMIp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 08:08:45 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34B1273C;
        Thu, 17 Aug 2023 05:08:41 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37HC8RXK062294;
        Thu, 17 Aug 2023 07:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692274107;
        bh=VYmIfnjsQD9QphhKFBwVqLW7ZygbzGKJXHfS+UGKrJs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dYVVbMnsRtLRAutysm6GKhEBuPFcerpoa8yOAG34P0wO0iWWRcMSIcgRzlgaIaXT6
         A3bz42CGOf9m6SJwV4RBlmOZGfYSI/mDh+hf1LAlfkTznfF0rpqh8+yF0x/cXScugl
         7k2GKISxrHKoMOG8uGp9qBAAtBh+lOAwd42uz/Pc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37HC8Rgg016286
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Aug 2023 07:08:27 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Aug 2023 07:08:27 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Aug 2023 07:08:27 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37HC8Qkc021347;
        Thu, 17 Aug 2023 07:08:26 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Achal Verma <a-verma1@ti.com>
Subject: [RFC PATCH 2/2] PCI: j721e: Add support to build pci-j721e as a kernel module
Date:   Thu, 17 Aug 2023 17:38:23 +0530
Message-ID: <20230817120823.1158766-3-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230817120823.1158766-1-a-verma1@ti.com>
References: <20230817120823.1158766-1-a-verma1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/pci/controller/cadence/pci-j721e-ep.c | 130 ++++++
 .../pci/controller/cadence/pci-j721e-host.c   | 208 ++++++++++
 drivers/pci/controller/cadence/pci-j721e.c    | 382 +++---------------
 drivers/pci/controller/cadence/pci-j721e.h    |  96 +++++
 .../controller/cadence/pcie-cadence-host.c    |  22 +
 drivers/pci/controller/cadence/pcie-cadence.c |  12 +
 drivers/pci/controller/cadence/pcie-cadence.h |   7 +
 9 files changed, 530 insertions(+), 335 deletions(-)
 create mode 100644 drivers/pci/controller/cadence/pci-j721e-ep.c
 create mode 100644 drivers/pci/controller/cadence/pci-j721e-host.c
 create mode 100644 drivers/pci/controller/cadence/pci-j721e.h

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index abc245dbedab..035e290742bb 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -43,10 +43,10 @@ config PCIE_CADENCE_PLAT_EP
 	  different vendors SoCs.
 
 config PCI_J721E
-	bool
+	tristate
 
 config PCI_J721E_HOST
-	bool "TI J721E PCIe controller (host mode)"
+	tristate "TI J721E PCIe controller (host mode)"
 	depends on OF
 	select PCIE_CADENCE_HOST
 	select PCI_J721E
@@ -56,7 +56,7 @@ config PCI_J721E_HOST
 	  core.
 
 config PCI_J721E_EP
-	bool "TI J721E PCIe controller (endpoint mode)"
+	tristate "TI J721E PCIe controller (endpoint mode)"
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
index 000000000000..005bdc9d36a2
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
+static void j721e_pcie_remove(struct platform_device *pdev)
+{
+	struct j721e_pcie *pcie = platform_get_drvdata(pdev);
+	struct cdns_pcie *cdns_pcie = pcie->cdns_pcie;
+	struct device *dev = &pdev->dev;
+
+	j721e_pcie_remove_link_irq(pcie);
+	cdns_pcie_stop_link(cdns_pcie);
+	cdns_pcie_deinit_phy(cdns_pcie);
+	j721e_disable_common_init(dev);
+}
+
+static struct platform_driver j721e_pcie_ep_driver = {
+	.probe  = j721e_pcie_probe,
+	.remove_new = j721e_pcie_remove,
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
index 000000000000..af47aa090159
--- /dev/null
+++ b/drivers/pci/controller/cadence/pci-j721e-host.c
@@ -0,0 +1,208 @@
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
+	.set_afs_bit = true,
+};
+
+static const struct j721e_pcie_data j7200_pcie_rc_data = {
+	.mode = PCI_MODE_RC,
+	.quirk_detect_quiet_flag = true,
+	.linkdown_irq_regfield = J7200_LINK_DOWN,
+	.byte_access_allowed = true,
+	.set_afs_bit = true,
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
+		rc->set_afs_bit = data->set_afs_bit;
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
+	pcie->perst_gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(pcie->perst_gpiod)) {
+		ret = PTR_ERR(pcie->perst_gpiod);
+		dev_err(dev, "Failed to get reset GPIO\n");
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
+	 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 5.0
+	 * indicates PERST# should be deasserted after minimum of 100ms
+	 * after power rails achieve specified operating limits and
+	 * 100us after reference clock gets stable.
+	 * PERST_INACTIVE_US accounts for both delays.
+	 */
+
+	fsleep(PERST_INACTIVE_US);
+	gpiod_set_value_cansleep(pcie->perst_gpiod, 1);
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
+static void j721e_pcie_remove(struct platform_device *pdev)
+{
+	struct j721e_pcie *pcie = platform_get_drvdata(pdev);
+	struct cdns_pcie *cdns_pcie = pcie->cdns_pcie;
+	struct cdns_pcie_rc *rc = container_of(cdns_pcie, struct cdns_pcie_rc, pcie);
+	struct device *dev = &pdev->dev;
+
+	cdns_pcie_host_remove_setup(rc);
+	j721e_pcie_remove_link_irq(pcie);
+
+	cdns_pcie_stop_link(cdns_pcie);
+	clk_disable_unprepare(pcie->refclk);
+	gpiod_set_value_cansleep(pcie->perst_gpiod, 0);
+	cdns_pcie_deinit_phy(cdns_pcie);
+	j721e_disable_common_init(dev);
+}
+
+static struct platform_driver j721e_pcie_host_driver = {
+	.probe  = j721e_pcie_probe,
+	.remove_new = j721e_pcie_remove,
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
index 7e94eb94f29c..7cac5d291622 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -2,101 +2,18 @@
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
-#include <linux/pci.h>
-#include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
+#include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/platform_device.h>
 
-#include "../../pci.h"
+//#include "../../pci.h"
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
-#define PERST_INACTIVE_US (PCIE_TPVPERL_MS*USEC_PER_MSEC + PCIE_TPERST_CLK_US)
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
-	unsigned int		set_afs_bit:1;
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
@@ -123,6 +40,16 @@ static void j721e_pcie_config_link_irq(struct j721e_pcie *pcie)
 	j721e_pcie_intd_writel(pcie, ENABLE_REG_SYS_2, reg);
 }
 
+void j721e_pcie_remove_link_irq(struct j721e_pcie *pcie)
+{
+	u32 reg;
+
+	reg = j721e_pcie_intd_readl(pcie, CLEAR_REG_SYS_2);
+	reg |= pcie->linkdown_irq_regfield;
+	j721e_pcie_intd_writel(pcie, CLEAR_REG_SYS_2, reg);
+}
+EXPORT_SYMBOL_GPL(j721e_pcie_remove_link_irq);
+
 static int j721e_pcie_start_link(struct cdns_pcie *cdns_pcie)
 {
 	struct j721e_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
@@ -158,14 +85,15 @@ static bool j721e_pcie_link_up(struct cdns_pcie *cdns_pcie)
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
-			       unsigned int offset)
+				unsigned int offset)
 {
 	struct device *dev = pcie->cdns_pcie->dev;
 	u32 mask = J721E_MODE_RC;
@@ -184,7 +112,7 @@ static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon,
 }
 
 static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
-				     struct regmap *syscon, unsigned int offset)
+			     struct regmap *syscon, unsigned int offset)
 {
 	struct device *dev = pcie->cdns_pcie->dev;
 	struct device_node *np = dev->of_node;
@@ -237,7 +165,7 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 
 	/* Do not error out to maintain old DT compatibility */
 	ret = of_parse_phandle_with_fixed_args(node, "ti,syscon-pcie-ctrl", 1,
-					       0, &args);
+						0, &args);
 	if (!ret)
 		offset = args.args[0];
 
@@ -262,171 +190,40 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 	return 0;
 }
 
-static int cdns_ti_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
-				    int where, int size, u32 *value)
+int j721e_pcie_setup_link_interrupts(struct j721e_pcie *pcie)
 {
-	if (pci_is_root_bus(bus))
-		return pci_generic_config_read32(bus, devfn, where, size,
-						 value);
-
-	return pci_generic_config_read(bus, devfn, where, size, value);
-}
+	struct device *dev = pcie->cdns_pcie->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	int ret;
 
-static int cdns_ti_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
-				     int where, int size, u32 value)
-{
-	if (pci_is_root_bus(bus))
-		return pci_generic_config_write32(bus, devfn, where, size,
-						  value);
+	ret = platform_get_irq_byname(pdev, "link_state");
+	if (ret < 0)
+		return ret;
+	ret = devm_request_irq(dev, ret, j721e_pcie_link_irq_handler, 0,
+			       "j721e-pcie-link-down-irq", pcie);
+	if (ret < 0) {
+		dev_err(dev, "failed to request link state IRQ %d\n", ret);
+		return ret;
+	}
 
-	return pci_generic_config_write(bus, devfn, where, size, value);
+	j721e_pcie_config_link_irq(pcie);
+	return 0;
 }
 
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
-	.set_afs_bit = true,
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
-	.set_afs_bit = true,
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
 	const struct j721e_pcie_data *data;
-	struct cdns_pcie *cdns_pcie;
-	struct j721e_pcie *pcie;
-	struct cdns_pcie_rc *rc = NULL;
-	struct cdns_pcie_ep *ep = NULL;
-	struct gpio_desc *perst_gpiod;
 	void __iomem *base;
-	struct clk *clk;
 	u32 num_lanes;
-	u32 mode;
 	int ret;
-	int irq;
 
 	data = of_device_get_match_data(dev);
 	if (!data)
 		return -EINVAL;
 
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
-		rc->set_afs_bit = data->set_afs_bit;
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
-
 	base = devm_platform_ioremap_resource_byname(pdev, "intd_cfg");
 	if (IS_ERR(base))
 		return PTR_ERR(base);
@@ -438,18 +235,18 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	pcie->user_cfg_base = base;
 
 	ret = of_property_read_u32(node, "num-lanes", &num_lanes);
-	if (ret || num_lanes > MAX_LANES)
+	if (ret || num_lanes > MAX_LANES) {
+		dev_warn(dev, "num-lanes property not provided or invalid, setting num-lanes to 1\n");
 		num_lanes = 1;
+	}
+
 	pcie->num_lanes = num_lanes;
 
 	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48)))
 		return -EINVAL;
 
-	irq = platform_get_irq_byname(pdev, "link_state");
-	if (irq < 0)
-		return irq;
-
 	dev_set_drvdata(dev, pcie);
+
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
@@ -463,107 +260,28 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		goto err_get_sync;
 	}
 
-	ret = devm_request_irq(dev, irq, j721e_pcie_link_irq_handler, 0,
-			       "j721e-pcie-link-down-irq", pcie);
+	ret = j721e_pcie_setup_link_interrupts(pcie);
 	if (ret < 0) {
-		dev_err(dev, "failed to request link state IRQ %d\n", irq);
+		dev_err(dev, "interrupt setup failed\n");
 		goto err_get_sync;
 	}
 
-	j721e_pcie_config_link_irq(pcie);
-
-	switch (mode) {
-	case PCI_MODE_RC:
-		perst_gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
-		if (IS_ERR(perst_gpiod)) {
-			ret = PTR_ERR(perst_gpiod);
-			dev_err(dev, "Failed to get reset GPIO\n");
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
-		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 5.0
-		 * indicates PERST# should be deasserted after minimum of 100ms
-		 * after power rails achieve specified operating limits and
-		 * 100us after reference clock gets stable.
-		 * PERST_INACTIVE_US accounts for both delays.
-		 */
-
-		fsleep(PERST_INACTIVE_US);
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
 
-static void j721e_pcie_remove(struct platform_device *pdev)
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
 }
+EXPORT_SYMBOL_GPL(j721e_disable_common_init);
 
-static struct platform_driver j721e_pcie_driver = {
-	.probe  = j721e_pcie_probe,
-	.remove_new = j721e_pcie_remove,
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
index 000000000000..89311ad5e990
--- /dev/null
+++ b/drivers/pci/controller/cadence/pci-j721e.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * pci-j721e - PCIe controller driver for TI's J721E SoCs
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com
+ */
+
+#include "../../pci.h"
+
+#ifndef _PCIE_J721E_H
+#define _PCIE_J721E_H
+
+#define ENABLE_REG_SYS_2	0x108
+#define CLEAR_REG_SYS_2         0x308
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
+#define PERST_INACTIVE_US (PCIE_TPVPERL_MS*USEC_PER_MSEC + PCIE_TPERST_CLK_US)
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
+	struct gpio_desc	*perst_gpiod;
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
+	unsigned int		set_afs_bit:1;
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
+void j721e_pcie_remove_link_irq(struct j721e_pcie *pcie);
+void j721e_disable_common_init(struct device *dev);
+
+#endif /* _PCIE_J721E_H */
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 06f3e1de1de2..c5f26ed16e23 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -160,6 +160,15 @@ static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
 	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
 }
 
+static void cdns_pcie_host_disable_ptm_response(struct cdns_pcie *pcie)
+{
+	u32 val;
+
+	val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
+	val &= ~CDNS_PCIE_LM_TPM_CTRL_PTMRSEN;
+	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val);
+}
+
 static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
@@ -580,4 +589,17 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 }
 EXPORT_SYMBOL_GPL(cdns_pcie_host_setup);
 
+int cdns_pcie_host_remove_setup(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie = &rc->pcie;
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rc);
+
+	pci_stop_root_bus(bridge->bus);
+	pci_remove_root_bus(bridge->bus);
+	cdns_pcie_host_disable_ptm_response(pcie);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_host_remove_setup);
+
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 4d16f6f37d1c..49c8eb7a5d2d 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -251,6 +251,18 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 }
 EXPORT_SYMBOL_GPL(cdns_pcie_init_phy);
 
+void cdns_pcie_deinit_phy(struct cdns_pcie *pcie)
+{
+	int i = pcie->phy_count;
+
+	cdns_pcie_disable_phy(pcie);
+	while (i--) {
+		device_link_del(pcie->link[i]);
+		devm_phy_put(pcie->dev, pcie->phy[i]);
+	}
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_deinit_phy);
+
 static int cdns_pcie_suspend_noirq(struct device *dev)
 {
 	struct cdns_pcie *pcie = dev_get_drvdata(dev);
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 5aa0b1298b17..c6529ba3c0f6 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -534,6 +534,7 @@ static inline bool cdns_pcie_link_up(struct cdns_pcie *pcie)
 
 #if IS_ENABLED(CONFIG_PCIE_CADENCE_HOST)
 int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
+int cdns_pcie_host_remove_setup(struct cdns_pcie_rc *rc);
 void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 			       int where);
 #else
@@ -542,6 +543,11 @@ static inline int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	return 0;
 }
 
+static inline int cdns_pcie_host_remove_setup(struct cdns_pcie_rc *rc)
+{
+	return 0;
+}
+
 static inline void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 					     int where)
 {
@@ -572,6 +578,7 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
 void cdns_pcie_disable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
+void cdns_pcie_deinit_phy(struct cdns_pcie *pcie);
 extern const struct dev_pm_ops cdns_pcie_pm_ops;
 
 #endif /* _PCIE_CADENCE_H */
-- 
2.25.1

