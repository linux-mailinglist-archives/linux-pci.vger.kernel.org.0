Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8A75460E4
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 11:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348533AbiFJJGU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 05:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348474AbiFJJF7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 05:05:59 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B6F22188;
        Fri, 10 Jun 2022 02:04:55 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 1B6EA16D3;
        Fri, 10 Jun 2022 11:58:14 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 1B6EA16D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654851494;
        bh=p2li6fTI7zv1zU8QzVj4lnusDLEfp9fYzKRh7kPajdE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=fxwKpVYrWCzdtadw7XInY4McGABWf9fe4JQR3vNdsfYuMB+2By3ijkAHvyjotg0F7
         q1XAmfcXNkwwbxZdr6rnIQBZlkqsQ0eFxKYZ2+BcRsOYQlu3BKc03AAww9Dg1JRI8a
         Ya85h84qqTvBwm6TD6hlsMejnpIeoAibe2ISJJm8=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:57:21 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 16/17] PCI: dwc: Introduce generic platform clocks and resets
Date:   Fri, 10 Jun 2022 11:57:04 +0300
Message-ID: <20220610085706.15741-17-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently almost each platform driver uses its own resets and clocks
naming in order to get the corresponding descriptors. It makes the code
harder to maintain and comprehend especially seeing the DWC PCIe core main
resets and clocks signals set hasn't changed much for about at least one
major IP-core release. So in order to organize things around these signals
we suggest to create a generic interface for them in accordance with the
naming introduced in the DWC PCIe IP-core reference manual:

Application clocks:
- "dbi"  - data bus interface clock (on some DWC PCIe platforms it's
           referred as "pclk", "pcie", "sys", "ahb", "cfg", "iface",
           "gio", "reg", "pcie_apb_sys");
- "mstr" - AXI-bus master interface clock (some DWC PCIe glue drivers
           refer to this clock as "port", "bus", "pcie_bus",
           "bus_master/master_bus/axi_m", "pcie_aclk");
- "slv"  - AXI-bus slave interface clock (also called as "port", "bus",
           "pcie_bus", "bus_slave/slave_bus/axi_s", "pcie_aclk",
           "pcie_inbound_axi").

Core clocks:
- "pipe" - core-PCS PIPE interface clock coming from external PHY (it's
           normally named by the platform drivers as just "pipe");
- "core" - primary clock of the controller (none of the platform drivers
           declare such a clock but in accordance with the ref. manual
           the devices may have it separately specified);
- "aux"  - auxiliary PMC domain clock (it is named by some platforms as
           "pcie_aux" and just "aux");
- "ref"  - Generic reference clock (it is a generic clock source, which
           can be used as a signal source for multiple interfaces, some
           platforms call it as "ref", "general", "pcie_phy",
           "pcie_phy_ref").

Application resets:
- "dbi"  - Data-bus interface reset (it's CSR interface clock and is
           normally called as "apb" though technically it's not APB but
           DWC PCIe-specific interface);
- "mstr" - AXI-bus master reset (some platforms call it as "port", "apps",
           "bus", "axi_m");
- "slv"  - ABI-bus slave reset (some platforms call it as "port", "apps",
           "bus", "axi_s").

Core resets:
- "non-sticky" - non-sticky CSR flags reset;
- "sticky"     - sticky CSR flags reset;
- "pipe"       - PIPE-interface (Core-PCS) logic reset (some platforms
                 call it just "pipe");
- "core"       - controller primary reset (resets everything except PMC
                 module, some platforms refer to this signal as "soft",
                 "pci");
- "phy"        - PCS/PHY block reset (strictly speaking it is normally
                 connected to the input of an external block, but the
                 reference manual says it must be available for the PMC
                 working correctly, some existing platforms call it
                 "pciephy", "phy", "link");
- "hot"        - PMC hot reset signal (also called as "sleep");
- "pwr"        - cold reset signal (can be referred as "pwr", "turnoff").

Bus reset:
- "perst" - PCIe standard signal used to reset the PCIe peripheral
            devices.

As you can see each platform uses it's own naming for basically the same
set of the signals. In the framework of this commit we suggest to add a
set of the clocks and reset signals resources, corresponding names and
identifiers for each denoted entity. At current stage the platforms will
be able to use the provided infrastructure to automatically request all
these resources and manipulate with them in the Host/EP init callbacks.
Alas it isn't that easy to create a common cold/hot reset procedure due to
too many platform-specifics in the procedure, like the external flags
exposure and the delays requirement.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v3:
- Add a method to at least request the generic clocks and resets. (@Rob)
- Add GPIO-based PERST# signal support.
---
 drivers/pci/controller/dwc/pcie-designware.c | 91 ++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h | 42 +++++++++
 2 files changed, 133 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 3d3129e1fb88..fd43514a00bb 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -10,7 +10,9 @@
 
 #include <linux/align.h>
 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/ioport.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -20,11 +22,89 @@
 #include "../../pci.h"
 #include "pcie-designware.h"
 
+static const char * const dw_pcie_app_clks[DW_PCIE_NUM_APP_CLKS] = {
+	[DW_PCIE_DBI_CLK] = "dbi",
+	[DW_PCIE_MSTR_CLK] = "mstr",
+	[DW_PCIE_SLV_CLK] = "slv",
+};
+
+static const char * const dw_pcie_core_clks[DW_PCIE_NUM_CORE_CLKS] = {
+	[DW_PCIE_PIPE_CLK] = "pipe",
+	[DW_PCIE_CORE_CLK] = "core",
+	[DW_PCIE_AUX_CLK] = "aux",
+	[DW_PCIE_REF_CLK] = "ref",
+};
+
+static const char * const dw_pcie_app_rsts[DW_PCIE_NUM_APP_RSTS] = {
+	[DW_PCIE_DBI_RST] = "dbi",
+	[DW_PCIE_MSTR_RST] = "mstr",
+	[DW_PCIE_SLV_RST] = "slv",
+};
+
+static const char * const dw_pcie_core_rsts[DW_PCIE_NUM_CORE_RSTS] = {
+	[DW_PCIE_NON_STICKY_RST] = "non-sticky",
+	[DW_PCIE_STICKY_RST] = "sticky",
+	[DW_PCIE_CORE_RST] = "core",
+	[DW_PCIE_PIPE_RST] = "pipe",
+	[DW_PCIE_PHY_RST] = "phy",
+	[DW_PCIE_HOT_RST] = "hot",
+	[DW_PCIE_PWR_RST] = "pwr",
+};
+
+static int dw_pcie_get_clocks(struct dw_pcie *pci)
+{
+	int i, ret;
+
+	for (i = 0; i < DW_PCIE_NUM_APP_CLKS; i++)
+		pci->app_clks[i].id = dw_pcie_app_clks[i];
+
+	for (i = 0; i < DW_PCIE_NUM_CORE_CLKS; i++)
+		pci->core_clks[i].id = dw_pcie_core_clks[i];
+
+	ret = devm_clk_bulk_get_optional(pci->dev, DW_PCIE_NUM_APP_CLKS,
+					 pci->app_clks);
+	if (ret)
+		return ret;
+
+	return devm_clk_bulk_get_optional(pci->dev, DW_PCIE_NUM_CORE_CLKS,
+					  pci->core_clks);
+}
+
+static int dw_pcie_get_resets(struct dw_pcie *pci)
+{
+	int i, ret;
+
+	for (i = 0; i < DW_PCIE_NUM_APP_RSTS; i++)
+		pci->app_rsts[i].id = dw_pcie_app_rsts[i];
+
+	for (i = 0; i < DW_PCIE_NUM_CORE_RSTS; i++)
+		pci->core_rsts[i].id = dw_pcie_core_rsts[i];
+
+	ret = devm_reset_control_bulk_get_optional_shared(pci->dev,
+							  DW_PCIE_NUM_APP_RSTS,
+							  pci->app_rsts);
+	if (ret)
+		return ret;
+
+	ret = devm_reset_control_bulk_get_optional_exclusive(pci->dev,
+							     DW_PCIE_NUM_CORE_RSTS,
+							     pci->core_rsts);
+	if (ret)
+		return ret;
+
+	pci->pe_rst = devm_gpiod_get_optional(pci->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(pci->pe_rst))
+		return PTR_ERR(pci->pe_rst);
+
+	return 0;
+}
+
 int dw_pcie_get_res(struct dw_pcie *pci)
 {
 	struct platform_device *pdev = to_platform_device(pci->dev);
 	struct device_node *np = dev_of_node(pci->dev);
 	struct resource *res;
+	int ret;
 
 	if (!pci->dbi_base) {
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
@@ -62,6 +142,17 @@ int dw_pcie_get_res(struct dw_pcie *pci)
 	if (!pci->atu_size)
 		pci->atu_size = SZ_4K;
 
+	/* LLDD is supposed to manually switch the clocks and resets state */
+	if (dw_pcie_cap_is(pci, REQ_RES)) {
+		ret = dw_pcie_get_clocks(pci);
+		if (ret)
+			return ret;
+
+		ret = dw_pcie_get_resets(pci);
+		if (ret)
+			return ret;
+	}
+
 	if (pci->link_gen < 1)
 		pci->link_gen = of_pci_get_max_link_speed(np);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 59ebcf880d0d..779fbf147d9b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -13,10 +13,13 @@
 
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/dma-mapping.h>
+#include <linux/gpio/consumer.h>
 #include <linux/irq.h>
 #include <linux/msi.h>
 #include <linux/pci.h>
+#include <linux/reset.h>
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
@@ -45,6 +48,7 @@
 	 __dw_pcie_ver_cmp(_pci, TYPE_ ## _type, >=))
 
 /* DWC PCIe controller capabilities */
+#define DW_PCIE_CAP_REQ_RES		0
 #define DW_PCIE_CAP_IATU_UNROLL		1
 #define DW_PCIE_CAP_CDM_CHECK		2
 
@@ -194,6 +198,39 @@ enum dw_pcie_device_mode {
 	DW_PCIE_RC_TYPE,
 };
 
+enum dw_pcie_app_clk {
+	DW_PCIE_DBI_CLK,
+	DW_PCIE_MSTR_CLK,
+	DW_PCIE_SLV_CLK,
+	DW_PCIE_NUM_APP_CLKS
+};
+
+enum dw_pcie_core_clk {
+	DW_PCIE_PIPE_CLK,
+	DW_PCIE_CORE_CLK,
+	DW_PCIE_AUX_CLK,
+	DW_PCIE_REF_CLK,
+	DW_PCIE_NUM_CORE_CLKS
+};
+
+enum dw_pcie_app_rst {
+	DW_PCIE_DBI_RST,
+	DW_PCIE_MSTR_RST,
+	DW_PCIE_SLV_RST,
+	DW_PCIE_NUM_APP_RSTS
+};
+
+enum dw_pcie_core_rst {
+	DW_PCIE_NON_STICKY_RST,
+	DW_PCIE_STICKY_RST,
+	DW_PCIE_CORE_RST,
+	DW_PCIE_PIPE_RST,
+	DW_PCIE_PHY_RST,
+	DW_PCIE_HOT_RST,
+	DW_PCIE_PWR_RST,
+	DW_PCIE_NUM_CORE_RSTS
+};
+
 struct dw_pcie_host_ops {
 	int (*host_init)(struct dw_pcie_rp *pp);
 	void (*host_deinit)(struct dw_pcie_rp *pp);
@@ -294,6 +331,11 @@ struct dw_pcie {
 	int			num_lanes;
 	int			link_gen;
 	u8			n_fts[2];
+	struct clk_bulk_data	app_clks[DW_PCIE_NUM_APP_CLKS];
+	struct clk_bulk_data	core_clks[DW_PCIE_NUM_CORE_CLKS];
+	struct reset_control_bulk_data	app_rsts[DW_PCIE_NUM_APP_RSTS];
+	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
+	struct gpio_desc		*pe_rst;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
-- 
2.35.1

