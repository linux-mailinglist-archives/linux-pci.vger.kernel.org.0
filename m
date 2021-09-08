Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39C3403538
	for <lists+linux-pci@lfdr.de>; Wed,  8 Sep 2021 09:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347857AbhIHHXa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Sep 2021 03:23:30 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45780 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239498AbhIHHX3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Sep 2021 03:23:29 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D431E204514;
        Wed,  8 Sep 2021 09:22:20 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 71EBB202EEF;
        Wed,  8 Sep 2021 09:22:20 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1A67B183AD2A;
        Wed,  8 Sep 2021 15:22:19 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH 2/3] PCI: imx: add err check to host init and fix regulator dump
Date:   Wed,  8 Sep 2021 14:59:25 +0800
Message-Id: <1631084366-24785-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631084366-24785-1-git-send-email-hongxing.zhu@nxp.com>
References: <1631084366-24785-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since there is error return check of the host_init callback, add error
check to imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
function.

Because that i.MX PCIe doesn't support the hot-plug feature. To save
power consumption as much as possible, turn off the clocks and power
supplies when the PCIe PHY link is never came up in probe procedure.

When PCIe link is never came up and vpcie regulator is present, there
would be following dump when try to put the regulator.
Disable this regulator to fix this dump when link is never came up.

[    2.335880] imx6q-pcie 33800000.pcie: Phy link never came up
[    2.341642] imx6q-pcie: probe of 33800000.pcie failed with error -110
[    2.348160] ------------[ cut here ]------------
[    2.352778] WARNING: CPU: 3 PID: 119 at drivers/regulator/core.c:2256 _regulator_put.part.0+0x14c/0x158
[    2.362184] Modules linked in:
[    2.365243] CPU: 3 PID: 119 Comm: kworker/u8:2 Not tainted 5.13.0-rc7-next-20210625-94710-ge4e92b2588a3 #10
[    2.374987] Hardware name: FSL i.MX8MM EVK board (DT)
[    2.380040] Workqueue: events_unbound async_run_entry_fn
[    2.385359] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
[    2.391369] pc : _regulator_put.part.0+0x14c/0x158
[    2.396163] lr : regulator_put+0x34/0x48
[    2.400088] sp : ffff8000122ebb30
[    2.403400] x29: ffff8000122ebb30 x28: ffff800011be7000 x27: 0000000000000000
[    2.410546] x26: 0000000000000000 x25: 0000000000000000 x24: ffff00000025f2bc
[    2.417689] x23: ffff00000025f2c0 x22: ffff00000025f010 x21: ffff8000122ebc18
[    2.424834] x20: ffff800011e3fa60 x19: ffff00000375fd80 x18: 0000000000000010
[    2.431979] x17: 000000040044ffff x16: 00400032b5503510 x15: 0000000000000108
[    2.439124] x14: ffff0000003cc938 x13: 00000000ffffffea x12: 0000000000000000
[    2.446267] x11: 0000000000000000 x10: ffff80001076ba88 x9 : ffff80001076a540
[    2.453411] x8 : ffff00000025f2c0 x7 : ffff0000001f4450 x6 : ffff000000176cd8
[    2.460556] x5 : ffff000003857880 x4 : 0000000000000000 x3 : ffff800011e3fe30
[    2.467700] x2 : ffff0000003cc4c0 x1 : 0000000000000000 x0 : 0000000000000001
[    2.474847] Call trace:
[    2.477295]  _regulator_put.part.0+0x14c/0x158
[    2.481742]  regulator_put+0x34/0x48
[    2.485322]  devm_regulator_release+0x10/0x18
[    2.489681]  release_nodes+0x38/0x60
[    2.493262]  devres_release_all+0x88/0xd0
[    2.497276]  really_probe+0xd0/0x2e8
[    2.500858]  __driver_probe_device+0x74/0xd8
[    2.505137]  driver_probe_device+0x7c/0x108
[    2.509325]  __device_attach_driver+0x8c/0xd0
[    2.513685]  bus_for_each_drv+0x74/0xc0
[    2.517531]  __device_attach_async_helper+0xb4/0xd8
[    2.522419]  async_run_entry_fn+0x30/0x100
[    2.526521]  process_one_work+0x19c/0x320
[    2.530532]  worker_thread+0x48/0x418
[    2.534199]  kthread+0x14c/0x158
[    2.537432]  ret_from_fork+0x10/0x18
[    2.541013] ---[ end trace 3664ca4a50ce849b ]---

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 28 +++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 0264432e4c4a..129928e42f84 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -144,6 +144,7 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
 
 static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie);
+static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie);
 
 static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
 {
@@ -485,24 +486,24 @@ static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
 		dev_err(dev, "PCIe PLL lock timeout\n");
 }
 
-static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
+static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct device *dev = pci->dev;
-	int ret;
+	int ret, err;
 
 	if (imx6_pcie->vpcie && !regulator_is_enabled(imx6_pcie->vpcie)) {
 		ret = regulator_enable(imx6_pcie->vpcie);
 		if (ret) {
 			dev_err(dev, "failed to enable vpcie regulator: %d\n",
 				ret);
-			return;
+			return ret;
 		}
 	}
 
-	ret = imx6_pcie_clk_enable(imx6_pcie);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie clocks\n");
+	err = imx6_pcie_clk_enable(imx6_pcie);
+	if (err) {
+		dev_err(dev, "unable to enable pcie clocks: %d\n", err);
 		goto err_clks;
 	}
 
@@ -557,7 +558,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 		break;
 	}
 
-	return;
+	return 0;
 
 err_clks:
 	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
@@ -566,6 +567,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 			dev_err(dev, "failed to disable vpcie regulator: %d\n",
 				ret);
 	}
+	return err;
 }
 
 static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
@@ -810,17 +812,27 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
 	imx6_pcie_reset_phy(imx6_pcie);
+	imx6_pcie_clk_disable(imx6_pcie);
+	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0)
+		regulator_disable(imx6_pcie->vpcie);
 	return ret;
 }
 
 static int imx6_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+	int ret;
 
 	imx6_pcie_assert_core_reset(imx6_pcie);
 	imx6_pcie_init_phy(imx6_pcie);
-	imx6_pcie_deassert_core_reset(imx6_pcie);
+	ret = imx6_pcie_deassert_core_reset(imx6_pcie);
+	if (ret < 0) {
+		dev_err(dev, "pcie host init failed: %d.\n", ret);
+		return ret;
+	}
+
 	imx6_setup_phy_mpll(imx6_pcie);
 
 	return 0;
-- 
2.25.1

