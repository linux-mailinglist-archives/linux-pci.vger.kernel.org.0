Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74B8620143
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 22:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiKGVgG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 16:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiKGVgF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 16:36:05 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08CBEBB5;
        Mon,  7 Nov 2022 13:36:01 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id CC540E0EC5;
        Mon,  7 Nov 2022 23:50:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=aTQE9pVonwaAz7HnJcTbgclIFcLfY1cE/qvybgZYs5c=; b=sK9lw2WV3PGS
        r4Y9lcFyH9gGnKlfTIPRMQm9AmMc9fjH6c621T2vDRtdFPYdYY1t28z48W6mytKL
        MYKWtZOkmEfTd34ygL9t60VuYGyIqS8UcU1IH9HPXX4jV92lFdTf/Ek6fhloLFa6
        P5yj7HV1gzN9u11oYbLtfWy+/erM7Y4=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id BA949E0E1D;
        Mon,  7 Nov 2022 23:50:32 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 7 Nov 2022 23:50:32 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 17/20] PCI: dwc: Introduce generic resources getter
Date:   Mon, 7 Nov 2022 23:49:31 +0300
Message-ID: <20221107204934.32655-18-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
References: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the DW PCIe Root Port and Endpoint CSR spaces are retrieved in
the separate parts of the DW PCIe core driver. It doesn't really make
sense since the both controller types have identical set of the core CSR
regions: DBI, DBI CS2 and iATU/eDMA. Thus we can simplify the DW PCIe Host
and EP initialization methods by moving the platform-specific registers
space getting and mapping into a common method. It gets to be even more
justified seeing the CSRs base address pointers are preserved in the
common DW PCIe descriptor. Note all the OF-based common DW PCIe settings
initialization will be moved to the new method too in order to have a
single function for all the generic platform properties handling in single
place.

A nice side-effect of this change is that the pcie-designware-host.c and
pcie-designware-ep.c drivers are cleaned up from all the direct dw_pcie
storage modification, which makes the DW PCIe core, Root Port and Endpoint
modules more coherent.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changelog v3:
- This is a new patch created on v3 lap of the series.

Changelog v4:
- Convert the method name from dw_pcie_get_res() to
  dw_pcie_get_resources(). (@Bjorn)
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 26 +------
 .../pci/controller/dwc/pcie-designware-host.c | 15 +---
 drivers/pci/controller/dwc/pcie-designware.c  | 75 ++++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |  3 +
 4 files changed, 65 insertions(+), 54 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 237bb01d7852..80a64b63c055 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -13,8 +13,6 @@
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 
-#include "../../pci.h"
-
 void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
 {
 	struct pci_epc *epc = ep->epc;
@@ -688,29 +686,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct device *dev = pci->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	struct device_node *np = dev->of_node;
 	const struct pci_epc_features *epc_features;
 	struct dw_pcie_ep_func *ep_func;
 
 	INIT_LIST_HEAD(&ep->func_list);
 
-	if (!pci->dbi_base) {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
-		pci->dbi_base = devm_pci_remap_cfg_resource(dev, res);
-		if (IS_ERR(pci->dbi_base))
-			return PTR_ERR(pci->dbi_base);
-	}
-
-	if (!pci->dbi_base2) {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi2");
-		if (!res) {
-			pci->dbi_base2 = pci->dbi_base + SZ_4K;
-		} else {
-			pci->dbi_base2 = devm_pci_remap_cfg_resource(dev, res);
-			if (IS_ERR(pci->dbi_base2))
-				return PTR_ERR(pci->dbi_base2);
-		}
-	}
+	ret = dw_pcie_get_resources(pci);
+	if (ret)
+		return ret;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
 	if (!res)
@@ -739,9 +722,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		return -ENOMEM;
 	ep->outbound_addr = addr;
 
-	if (pci->link_gen < 1)
-		pci->link_gen = of_pci_get_max_link_speed(np);
-
 	epc = devm_pci_epc_create(dev, &epc_ops);
 	if (IS_ERR(epc)) {
 		dev_err(dev, "Failed to create epc device\n");
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ea923c25e12d..3ab6ae3712c4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -16,7 +16,6 @@
 #include <linux/pci_regs.h>
 #include <linux/platform_device.h>
 
-#include "../../pci.h"
 #include "pcie-designware.h"
 
 static struct pci_ops dw_pcie_ops;
@@ -395,6 +394,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	raw_spin_lock_init(&pp->lock);
 
+	ret = dw_pcie_get_resources(pci);
+	if (ret)
+		return ret;
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (res) {
 		pp->cfg0_size = resource_size(res);
@@ -408,13 +411,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		return -ENODEV;
 	}
 
-	if (!pci->dbi_base) {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
-		pci->dbi_base = devm_pci_remap_cfg_resource(dev, res);
-		if (IS_ERR(pci->dbi_base))
-			return PTR_ERR(pci->dbi_base);
-	}
-
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
 	if (!bridge)
 		return -ENOMEM;
@@ -429,9 +425,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->io_base = pci_pio_to_address(win->res->start);
 	}
 
-	if (pci->link_gen < 1)
-		pci->link_gen = of_pci_get_max_link_speed(np);
-
 	/* Set default bus ops */
 	bridge->ops = &dw_pcie_ops;
 	bridge->child_ops = &dw_child_pcie_ops;
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 9d78e7ca61e1..a8436027434d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -11,6 +11,7 @@
 #include <linux/align.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/ioport.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/sizes.h>
@@ -19,6 +20,59 @@
 #include "../../pci.h"
 #include "pcie-designware.h"
 
+int dw_pcie_get_resources(struct dw_pcie *pci)
+{
+	struct platform_device *pdev = to_platform_device(pci->dev);
+	struct device_node *np = dev_of_node(pci->dev);
+	struct resource *res;
+
+	if (!pci->dbi_base) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
+		pci->dbi_base = devm_pci_remap_cfg_resource(pci->dev, res);
+		if (IS_ERR(pci->dbi_base))
+			return PTR_ERR(pci->dbi_base);
+	}
+
+	/* DBI2 is mainly useful for the endpoint controller */
+	if (!pci->dbi_base2) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi2");
+		if (res) {
+			pci->dbi_base2 = devm_pci_remap_cfg_resource(pci->dev, res);
+			if (IS_ERR(pci->dbi_base2))
+				return PTR_ERR(pci->dbi_base2);
+		} else {
+			pci->dbi_base2 = pci->dbi_base + SZ_4K;
+		}
+	}
+
+	/* For non-unrolled iATU/eDMA platforms this range will be ignored */
+	if (!pci->atu_base) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
+		if (res) {
+			pci->atu_size = resource_size(res);
+			pci->atu_base = devm_ioremap_resource(pci->dev, res);
+			if (IS_ERR(pci->atu_base))
+				return PTR_ERR(pci->atu_base);
+		} else {
+			pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
+		}
+	}
+
+	/* Set a default value suitable for at most 8 in and 8 out windows */
+	if (!pci->atu_size)
+		pci->atu_size = SZ_4K;
+
+	if (pci->link_gen < 1)
+		pci->link_gen = of_pci_get_max_link_speed(np);
+
+	of_property_read_u32(np, "num-lanes", &pci->num_lanes);
+
+	if (of_property_read_bool(np, "snps,enable-cdm-check"))
+		dw_pcie_cap_set(pci, CDM_CHECK);
+
+	return 0;
+}
+
 void dw_pcie_version_detect(struct dw_pcie *pci)
 {
 	u32 ver;
@@ -639,25 +693,8 @@ static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
 
 void dw_pcie_iatu_detect(struct dw_pcie *pci)
 {
-	struct platform_device *pdev = to_platform_device(pci->dev);
-
 	if (dw_pcie_iatu_unroll_enabled(pci)) {
 		dw_pcie_cap_set(pci, IATU_UNROLL);
-
-		if (!pci->atu_base) {
-			struct resource *res =
-				platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
-			if (res) {
-				pci->atu_size = resource_size(res);
-				pci->atu_base = devm_ioremap_resource(pci->dev, res);
-			}
-			if (!pci->atu_base || IS_ERR(pci->atu_base))
-				pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
-		}
-
-		if (!pci->atu_size)
-			/* Pick a minimal default, enough for 8 in and 8 out windows */
-			pci->atu_size = SZ_4K;
 	} else {
 		pci->atu_base = pci->dbi_base + PCIE_ATU_VIEWPORT_BASE;
 		pci->atu_size = PCIE_ATU_VIEWPORT_SIZE;
@@ -675,7 +712,6 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
 
 void dw_pcie_setup(struct dw_pcie *pci)
 {
-	struct device_node *np = pci->dev->of_node;
 	u32 val;
 
 	if (pci->link_gen > 0)
@@ -703,14 +739,13 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	val |= PORT_LINK_DLL_LINK_EN;
 	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
 
-	if (of_property_read_bool(np, "snps,enable-cdm-check")) {
+	if (dw_pcie_cap_is(pci, CDM_CHECK)) {
 		val = dw_pcie_readl_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS);
 		val |= PCIE_PL_CHK_REG_CHK_REG_CONTINUOUS |
 		       PCIE_PL_CHK_REG_CHK_REG_START;
 		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
 	}
 
-	of_property_read_u32(np, "num-lanes", &pci->num_lanes);
 	if (!pci->num_lanes) {
 		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
 		return;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index c6dddacee3b1..081f169e6021 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -46,6 +46,7 @@
 
 /* DWC PCIe controller capabilities */
 #define DW_PCIE_CAP_IATU_UNROLL		1
+#define DW_PCIE_CAP_CDM_CHECK		2
 
 #define dw_pcie_cap_is(_pci, _cap) \
 	test_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
@@ -338,6 +339,8 @@ struct dw_pcie {
 #define to_dw_pcie_from_ep(endpoint)   \
 		container_of((endpoint), struct dw_pcie, ep)
 
+int dw_pcie_get_resources(struct dw_pcie *pci);
+
 void dw_pcie_version_detect(struct dw_pcie *pci);
 
 u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
-- 
2.38.0


