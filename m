Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254EE4372DA
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 09:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhJVHkM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 03:40:12 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56134 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231773AbhJVHkL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Oct 2021 03:40:11 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AED701A132F;
        Fri, 22 Oct 2021 09:37:52 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 75B401A1327;
        Fri, 22 Oct 2021 09:37:52 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 11B15183AC99;
        Fri, 22 Oct 2021 15:37:51 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 3/7] PCI: imx6: Fix the regulator dump when link never came up
Date:   Fri, 22 Oct 2021 15:12:26 +0800
Message-Id: <1634886750-13861-4-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
References: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When PCIe PHY link never came up and vpcie regulator is present, there
would be following dump when try to put the regulator.
Disable this regulator to fix this dump when link never came up.

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
 drivers/pci/controller/dwc/pci-imx6.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 3372775834a2..39a485bfc676 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1180,8 +1180,12 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = dw_pcie_host_init(&pci->pp);
-	if (ret < 0)
+	if (ret < 0) {
+		if (imx6_pcie->vpcie
+		    && regulator_is_enabled(imx6_pcie->vpcie) > 0)
+			regulator_disable(imx6_pcie->vpcie);
 		return ret;
+	}
 
 	if (pci_msi_enabled()) {
 		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
-- 
2.25.1

