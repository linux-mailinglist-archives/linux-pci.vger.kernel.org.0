Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40D9748336
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 13:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjGELqj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 07:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjGELqi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 07:46:38 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FE201BC0;
        Wed,  5 Jul 2023 04:46:13 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,182,1684767600"; 
   d="scan'208";a="166982748"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jul 2023 20:46:11 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A1828400C45B;
        Wed,  5 Jul 2023 20:46:11 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     marek.vasut+renesas@gmail.com, fancer.lancer@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v17 02/20] PCI: Rename PCI_EPC_IRQ_LEGACY to PCI_EPC_IRQ_INTX
Date:   Wed,  5 Jul 2023 20:41:48 +0900
Message-Id: <20230705114206.3585188-3-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Using "INTx" instead of "legacy" is more specific. So, rename
PCI_EPC_IRQ_LEGACY to PCI_EPC_IRQ_INTX.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Acked-by: Jesper Nilsson <jesper.nilsson@axis.com> # ARTPEC
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
This CC-list is for git send-email.

Cc: Tom Joseph <tjoseph@cadence.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Minghuan Lian <minghuan.Lian@nxp.com>
Cc: Mingkai Hu <mingkai.hu@nxp.com>
Cc: Roy Zang <roy.zang@nxp.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Srikanth Thokala <srikanth.thokala@intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c  |  2 +-
 drivers/pci/controller/dwc/pci-dra7xx.c           |  2 +-
 drivers/pci/controller/dwc/pci-imx6.c             |  2 +-
 drivers/pci/controller/dwc/pci-keystone.c         |  2 +-
 drivers/pci/controller/dwc/pci-layerscape-ep.c    |  2 +-
 drivers/pci/controller/dwc/pcie-artpec6.c         |  2 +-
 drivers/pci/controller/dwc/pcie-designware-plat.c |  2 +-
 drivers/pci/controller/dwc/pcie-keembay.c         |  2 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c         |  2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c        |  2 +-
 drivers/pci/controller/dwc/pcie-uniphier-ep.c     |  2 +-
 drivers/pci/controller/pcie-rcar-ep.c             |  2 +-
 drivers/pci/controller/pcie-rockchip-ep.c         |  2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c     | 10 +++++-----
 include/linux/pci-epc.h                           |  4 ++--
 15 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index b8b655d4047e..2af8eb4e6d91 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -539,7 +539,7 @@ static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
 	struct device *dev = pcie->dev;
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_EPC_IRQ_INTX:
 		if (vfn > 0) {
 			dev_err(dev, "Cannot raise legacy interrupts for VF\n");
 			return -EINVAL;
diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 4ae807e7cf79..b42fb1cc8bc8 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -410,7 +410,7 @@ static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_EPC_IRQ_INTX:
 		dra7xx_pcie_raise_legacy_irq(dra7xx);
 		break;
 	case PCI_EPC_IRQ_MSI:
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 27aaa2a6bf39..a32f1867e0bb 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1063,7 +1063,7 @@ static int imx6_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_EPC_IRQ_INTX:
 		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
 	case PCI_EPC_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 78818853af9e..3806f5530937 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -908,7 +908,7 @@ static int ks_pcie_am654_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_EPC_IRQ_INTX:
 		ks_pcie_am654_raise_legacy_irq(ks_pcie);
 		break;
 	case PCI_EPC_IRQ_MSI:
diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index de4c1758a6c3..b2e14d64dba2 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -155,7 +155,7 @@ static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_EPC_IRQ_INTX:
 		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
 	case PCI_EPC_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index 98102079e26d..128cb1118e3a 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -357,7 +357,7 @@ static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_EPC_IRQ_INTX:
 		dev_err(pci->dev, "EP cannot trigger legacy IRQs\n");
 		return -EINVAL;
 	case PCI_EPC_IRQ_MSI:
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 1fcfb840f238..fc3b02949218 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -48,7 +48,7 @@ static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_EPC_IRQ_INTX:
 		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
 	case PCI_EPC_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
index f90f36bac018..ceb940b327cb 100644
--- a/drivers/pci/controller/dwc/pcie-keembay.c
+++ b/drivers/pci/controller/dwc/pcie-keembay.c
@@ -290,7 +290,7 @@ static int keembay_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_EPC_IRQ_INTX:
 		/* Legacy interrupts are not supported in Keem Bay */
 		dev_err(pci->dev, "Legacy IRQ is not supported\n");
 		return -EINVAL;
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 0fe7f06f2102..93624728c772 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -660,7 +660,7 @@ static int qcom_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_EPC_IRQ_INTX:
 		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
 	case PCI_EPC_IRQ_MSI:
 		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index e1db909f53ec..65dc1131f716 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2000,7 +2000,7 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_EPC_IRQ_INTX:
 		return tegra_pcie_ep_raise_legacy_irq(pcie, interrupt_num);
 
 	case PCI_EPC_IRQ_MSI:
diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
index 4d0a587c0ba5..7787eedf87f4 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
@@ -262,7 +262,7 @@ static int uniphier_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_EPC_IRQ_INTX:
 		return uniphier_pcie_ep_raise_legacy_irq(ep);
 	case PCI_EPC_IRQ_MSI:
 		return uniphier_pcie_ep_raise_msi_irq(ep, func_no,
diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
index f9682df1da61..fbdf3d85301c 100644
--- a/drivers/pci/controller/pcie-rcar-ep.c
+++ b/drivers/pci/controller/pcie-rcar-ep.c
@@ -408,7 +408,7 @@ static int rcar_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
 	struct rcar_pcie_endpoint *ep = epc_get_drvdata(epc);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_EPC_IRQ_INTX:
 		return rcar_pcie_ep_assert_intx(ep, fn, 0);
 
 	case PCI_EPC_IRQ_MSI:
diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 0af0e965fb57..e856a45d0986 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -413,7 +413,7 @@ static int rockchip_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn, u8 vfn,
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 
 	switch (type) {
-	case PCI_EPC_IRQ_LEGACY:
+	case PCI_EPC_IRQ_INTX:
 		return rockchip_pcie_ep_send_legacy_irq(ep, fn, 0);
 	case PCI_EPC_IRQ_MSI:
 		return rockchip_pcie_ep_send_msi_irq(ep, fn, interrupt_num);
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 1f0d2b84296a..caa30596fadd 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -19,11 +19,11 @@
 #include <linux/pci-epf.h>
 #include <linux/pci_regs.h>
 
-#define IRQ_TYPE_LEGACY			0
+#define IRQ_TYPE_INTX			0
 #define IRQ_TYPE_MSI			1
 #define IRQ_TYPE_MSIX			2
 
-#define COMMAND_RAISE_LEGACY_IRQ	BIT(0)
+#define COMMAND_RAISE_INTX_IRQ		BIT(0)
 #define COMMAND_RAISE_MSI_IRQ		BIT(1)
 #define COMMAND_RAISE_MSIX_IRQ		BIT(2)
 #define COMMAND_READ			BIT(3)
@@ -600,9 +600,9 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	WRITE_ONCE(reg->status, status);
 
 	switch (reg->irq_type) {
-	case IRQ_TYPE_LEGACY:
+	case IRQ_TYPE_INTX:
 		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
-				  PCI_EPC_IRQ_LEGACY, 0);
+				  PCI_EPC_IRQ_INTX, 0);
 		break;
 	case IRQ_TYPE_MSI:
 		count = pci_epc_get_msi(epc, epf->func_no, epf->vfunc_no);
@@ -659,7 +659,7 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 	}
 
 	switch (command) {
-	case COMMAND_RAISE_LEGACY_IRQ:
+	case COMMAND_RAISE_INTX_IRQ:
 	case COMMAND_RAISE_MSI_IRQ:
 	case COMMAND_RAISE_MSIX_IRQ:
 		pci_epf_test_raise_irq(epf_test, reg);
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 5cb694031072..c5ada36b6ca0 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -21,7 +21,7 @@ enum pci_epc_interface_type {
 
 enum pci_epc_irq_type {
 	PCI_EPC_IRQ_UNKNOWN,
-	PCI_EPC_IRQ_LEGACY,
+	PCI_EPC_IRQ_INTX,
 	PCI_EPC_IRQ_MSI,
 	PCI_EPC_IRQ_MSIX,
 };
@@ -54,7 +54,7 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
  *	     MSI-X capability register
  * @get_msix: ops to get the number of MSI-X interrupts allocated by the RC
  *	     from the MSI-X capability register
- * @raise_irq: ops to raise a legacy, MSI or MSI-X interrupt
+ * @raise_irq: ops to raise an INTx, MSI or MSI-X interrupt
  * @map_msi_irq: ops to map physical address to MSI address and return MSI data
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
-- 
2.25.1

