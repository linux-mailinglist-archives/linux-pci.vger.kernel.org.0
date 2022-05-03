Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69795190AC
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 23:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240795AbiECVvd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 17:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243215AbiECVvO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 17:51:14 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 231D241639;
        Tue,  3 May 2022 14:47:18 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 9A45316DD;
        Wed,  4 May 2022 00:47:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 9A45316DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651614471;
        bh=pqOkWF4oLNlytfZFxAXLVAxSu527r2OnjeJcHrZ0Tik=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=BkwtExdM5P6OaVkIcGr56WudEw53jpqXySGkZc9cK3FH6MNLZaeGdRukarvGY1aMs
         T1HvExgploQxRtdvFSj0e5aC4EbZ0bPI01t27oO/P7XV91/MWzLj/HlHeZux4gbuRN
         WOKheLpaVTgmKxLBdxMMSEz8PLxxwTqYiIr35BQg=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 May 2022 00:47:17 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 16/17] PCI: dwc: Introduce generic platform clocks and resets sets
Date:   Wed, 4 May 2022 00:46:37 +0300
Message-ID: <20220503214638.1895-17-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Clocks:
- DBI - data bus interface clock (on some DWC PCIe platforms it's
  referred as "pclk", "pcie", "sys", "ahb", "cfg", "iface", "gio", "reg",
  "pcie_apb_sys");
- MSTR - AXI-bus master interface clock (some DWC PCIe glue drivers refer
  to this clock as "port", "bus", "pcie_bus",
  "bus_master/master_bus/axi_m", "pcie_aclk");
- SLV - AXI-bus slave interface clock (also called as "port", "bus",
  "pcie_bus", "bus_slave/slave_bus/axi_s", "pcie_aclk",
  "pcie_inbound_axi");
- PIPE - Core-PCS PIPE interface clock coming from external PHY (it's
  normally named by the platform drivers as just "pipe")
- CORE - primary clock of the controller (none of the platform drivers
  declare such a clock but in accordance with the ref. manual the devices
  may have it separately specified);
- AUX - Auxiliary PMC domain clock (it is named by some platforms as
  "pcie_aux" and just "aux")
- REF - Generic reference clock (it is a generic clock source, which can
  be used as a signal source for multiple interfaces, some platforms call
  it as "ref", "general", "pcie_phy", "pcie_phy_ref").

Application resets:
- DBI - Data-bus interface reset (it's CSR interface clock and is normally
  called as "apb" though technically it's not APB but DWC PCIe-specific
  interface);
  apb, sys,
- MSTR -AXI-bus master reset (some platforms call it as "port", "apps",
  "bus", "axi_m");
- SLV - ABI-bus slave reset (some platforms call it as "port", "apps",
  "bus", "axi_s").

Core resets:
- NON_STICKY - Non-sticky CSR flags reset;
- STICKY - sticky CSR flags reset;
- PIPE - PIPE-interface (Core-PCS) logic reset (some platforms call it
  just "pipe");
- CORE - controller primary reset (resets everything except PMC module,
  some platforms refer to this signal as "soft", "pci");
- PHY - PCS/PHY block reset (strictly speaking it is normally connected to
  the out of the external block, but the reference manual says it must be
  available for the PMC working correctly, some existing platforms call it
  as "pciephy", "phy", "link");
- HOT - PMC hot reset signal (also called as sleep");
- PWR - cold reset signal (can be referred as "pwr", "turnoff").

As you can see each platform uses it's own naming for basically the same
set of the signals. In the framework of this commit we suggest to add a
set of the clocks and signals identifiers and corresponding names for each
denoted entity. The platforms will be able to use them to define local
mapping tables between the generic identifiers and the available set of
the clocks and resets. The tables can be then utilized to create the
corresponding bulk-arrays, which in its turn can be passed to the
clock/reset-bulk API methods to easily get/enable/disable/put,
get/reset/assert/deassert/put all the handlers at once or, if it's
required, manipulate with the handlers individually.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/pci/controller/dwc/pcie-designware.h | 79 ++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 03de8f20a2cc..765d99d5bfaa 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -183,6 +183,35 @@ enum dw_pcie_device_mode {
 	DW_PCIE_RC_TYPE,
 };
 
+enum dw_pcie_clk {
+	DW_PCIE_DBI_CLK,
+	DW_PCIE_MSTR_CLK,
+	DW_PCIE_SLV_CLK,
+	DW_PCIE_PIPE_CLK,
+	DW_PCIE_CORE_CLK,
+	DW_PCIE_AUX_CLK,
+	DW_PCIE_REF_CLK,
+	DW_PCIE_NUM_CLKS
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
 	int (*host_init)(struct pcie_port *pp);
 	void (*host_deinit)(struct pcie_port *pp);
@@ -373,6 +402,56 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
 	dw_pcie_writel_dbi(pci, reg, val);
 }
 
+static inline const char *dw_pcie_clk_name(enum dw_pcie_clk id)
+{
+	static const char *names[DW_PCIE_NUM_CLKS] = {
+		[DW_PCIE_DBI_CLK] = "dbi",
+		[DW_PCIE_MSTR_CLK] = "mstr",
+		[DW_PCIE_SLV_CLK] = "slv",
+		[DW_PCIE_PIPE_CLK] = "pipe",
+		[DW_PCIE_CORE_CLK] = "core",
+		[DW_PCIE_AUX_CLK] = "aux",
+		[DW_PCIE_REF_CLK] = "ref",
+	};
+
+	if (id >= DW_PCIE_NUM_CLKS)
+		return NULL;
+
+	return names[id];
+}
+
+static inline const char *dw_pcie_app_rst_name(enum dw_pcie_app_rst id)
+{
+	static const char *names[DW_PCIE_NUM_APP_RSTS] = {
+		[DW_PCIE_DBI_RST] = "dbi",
+		[DW_PCIE_MSTR_RST] = "mstr",
+		[DW_PCIE_SLV_RST] = "slv",
+	};
+
+	if (id >= DW_PCIE_NUM_APP_RSTS)
+		return NULL;
+
+	return names[id];
+}
+
+static inline const char *dw_pcie_core_rst_name(enum dw_pcie_core_rst id)
+{
+	static const char *names[DW_PCIE_NUM_CORE_RSTS] = {
+		[DW_PCIE_NON_STICKY_RST] = "non-sticky",
+		[DW_PCIE_STICKY_RST] = "sticky",
+		[DW_PCIE_CORE_RST] = "core",
+		[DW_PCIE_PIPE_RST] = "pipe",
+		[DW_PCIE_PHY_RST] = "phy",
+		[DW_PCIE_HOT_RST] = "hot",
+		[DW_PCIE_PWR_RST] = "pwr",
+	};
+
+	if (id >= DW_PCIE_NUM_CORE_RSTS)
+		return NULL;
+
+	return names[id];
+}
+
 #ifdef CONFIG_PCIE_DW_HOST
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
 int dw_pcie_setup_rc(struct pcie_port *pp);
-- 
2.35.1

