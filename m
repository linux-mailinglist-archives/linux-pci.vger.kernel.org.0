Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCDE459D4D
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 08:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhKWICc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 03:02:32 -0500
Received: from inva020.nxp.com ([92.121.34.13]:50192 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234596AbhKWICa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Nov 2021 03:02:30 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EE64E1A309C;
        Tue, 23 Nov 2021 08:59:21 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 866461A058C;
        Tue, 23 Nov 2021 08:59:21 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E1693183AC4E;
        Tue, 23 Nov 2021 15:59:17 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, broonie@kernel.org,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [RESEND v4 5/6] PCI: imx6: Fix the regulator dump when link never came up
Date:   Tue, 23 Nov 2021 15:31:56 +0800
Message-Id: <1637652717-17313-6-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637652717-17313-1-git-send-email-hongxing.zhu@nxp.com>
References: <1637652717-17313-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When PCIe PHY link never came up and vpcie regulator is present, there
would be following dump when try to put the regulator.
Add a new host_exit() callback for i.MX PCIe driver to disable this
regulator and fix this dump when link never came up.

The driver should undo any enables it did itself, and not undo any
enables that anything else did which means it should never be basing
decisions on regulator_is_enabled().

To keep usage counter balance of the clocks, powers and so on. Do the
clock disable in the error handling after host_init too.

  imx6q-pcie 33800000.pcie: Phy link never came up
  imx6q-pcie: probe of 33800000.pcie failed with error -110
  ------------[ cut here ]------------
  WARNING: CPU: 3 PID: 119 at drivers/regulator/core.c:2256 _regulator_put.part.0+0x14c/0x158
  Modules linked in:
  CPU: 3 PID: 119 Comm: kworker/u8:2 Not tainted 5.13.0-rc7-next-20210625-94710-ge4e92b2588a3 #10
  Hardware name: FSL i.MX8MM EVK board (DT)
  Workqueue: events_unbound async_run_entry_fn
  pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
  pc : _regulator_put.part.0+0x14c/0x158
  lr : regulator_put+0x34/0x48
  sp : ffff8000122ebb30
  x29: ffff8000122ebb30 x28: ffff800011be7000 x27: 0000000000000000
  x26: 0000000000000000 x25: 0000000000000000 x24: ffff00000025f2bc
  x23: ffff00000025f2c0 x22: ffff00000025f010 x21: ffff8000122ebc18
  x20: ffff800011e3fa60 x19: ffff00000375fd80 x18: 0000000000000010
  x17: 000000040044ffff x16: 00400032b5503510 x15: 0000000000000108
  x14: ffff0000003cc938 x13: 00000000ffffffea x12: 0000000000000000
  x11: 0000000000000000 x10: ffff80001076ba88 x9 : ffff80001076a540
  x8 : ffff00000025f2c0 x7 : ffff0000001f4450 x6 : ffff000000176cd8
  x5 : ffff000003857880 x4 : 0000000000000000 x3 : ffff800011e3fe30
  x2 : ffff0000003cc4c0 x1 : 0000000000000000 x0 : 0000000000000001
  Call trace:
   _regulator_put.part.0+0x14c/0x158
   regulator_put+0x34/0x48
   devm_regulator_release+0x10/0x18
   release_nodes+0x38/0x60
   devres_release_all+0x88/0xd0
   really_probe+0xd0/0x2e8
   __driver_probe_device+0x74/0xd8
   driver_probe_device+0x7c/0x108
   __device_attach_driver+0x8c/0xd0
   bus_for_each_drv+0x74/0xc0
   __device_attach_async_helper+0xb4/0xd8
   async_run_entry_fn+0x30/0x100
   process_one_work+0x19c/0x320
   worker_thread+0x48/0x418
   kthread+0x14c/0x158
   ret_from_fork+0x10/0x18
  ---[ end trace 3664ca4a50ce849b ]---

Link: https://lore.kernel.org/r/20201105211159.1814485-11-robh@kernel.org
Fixes: 886a9c134755 ("PCI: dwc: Move link handling into common code")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 11265c5e5782..8be4b8a9b564 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -366,8 +366,6 @@ static int imx6_pcie_attach_pd(struct device *dev)
 
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 {
-	struct device *dev = imx6_pcie->pci->dev;
-
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 	case IMX8MQ:
@@ -395,14 +393,6 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
 		break;
 	}
-
-	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
-		int ret = regulator_disable(imx6_pcie->vpcie);
-
-		if (ret)
-			dev_err(dev, "failed to disable vpcie regulator: %d\n",
-				ret);
-	}
 }
 
 static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
@@ -556,7 +546,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	struct device *dev = pci->dev;
 	int ret, err;
 
-	if (imx6_pcie->vpcie && !regulator_is_enabled(imx6_pcie->vpcie)) {
+	if (imx6_pcie->vpcie) {
 		ret = regulator_enable(imx6_pcie->vpcie);
 		if (ret) {
 			dev_err(dev, "failed to enable vpcie regulator: %d\n",
@@ -625,7 +615,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	return 0;
 
 err_clks:
-	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
+	if (imx6_pcie->vpcie) {
 		ret = regulator_disable(imx6_pcie->vpcie);
 		if (ret)
 			dev_err(dev, "failed to disable vpcie regulator: %d\n",
@@ -875,7 +865,6 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
-	imx6_pcie_reset_phy(imx6_pcie);
 	return ret;
 }
 
@@ -899,8 +888,20 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
+static void imx6_pcie_host_exit(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+
+	imx6_pcie_reset_phy(imx6_pcie);
+	imx6_pcie_clk_disable(imx6_pcie);
+	if (imx6_pcie->vpcie)
+		regulator_disable(imx6_pcie->vpcie);
+}
+
 static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
 	.host_init = imx6_pcie_host_init,
+	.host_exit = imx6_pcie_host_exit,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
-- 
2.25.1

