Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0DD490633
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jan 2022 11:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbiAQKpz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jan 2022 05:45:55 -0500
Received: from unknown-3-146.windriver.com ([147.11.3.146]:10400 "EHLO
        mail1.wrs.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233756AbiAQKpz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jan 2022 05:45:55 -0500
X-Greylist: delayed 1571 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jan 2022 05:45:54 EST
Received: from mail.windriver.com (mail.wrs.com [147.11.1.11])
        by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 20HAI1Rp024995
        (version=TLSv1.1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 17 Jan 2022 02:18:01 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 20HAHtAH008450
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Jan 2022 02:18:00 -0800 (PST)
Received: from pek-lpggp7.wrs.com (128.224.153.21) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 17 Jan 2022 02:17:51 -0800
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     <hongxing.zhu@nxp.com>, <l.stach@pengutronix.de>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>
CC:     <linux-imx@nxp.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] pci: imx: disable reglator when imx6_pcie_probe fails
Date:   Mon, 17 Jan 2022 18:17:35 +0800
Message-ID: <20220117101735.3512039-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [128.224.153.21]
X-ClientProxiedBy: ala-exchng01.corp.ad.wrs.com (147.11.82.252) To
 ala-exchng01.corp.ad.wrs.com (147.11.82.252)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: wrsadmin <wrsadmin@pek-xwang8-d1.corp.ad.wrs.com>

disable reglator when imx6_pcie_probe fails,
otherwise the following calltrace will appear

[ 3.785075] ------------[ cut here ]------------
[ 3.788142] Registering SWP/SWPB emulation handler
[ 3.789853] WARNING: CPU: 0 PID: 7 at drivers/regulator/core.c:2257 _regulator_put.part.0+0x1bc/0x1e0
[ 3.795680] Loading compiled-in X.509 certificates
[ 3.803947] Modules linked in:
[ 3.811922] CPU: 0 PID: 7 Comm: kworker/u8:0 Not tainted 5.16.0-10645-g3c750c7b6143-dirty #9
[ 3.820393] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[ 3.826945] Workqueue: events_unbound async_run_entry_fn
[ 3.832304] unwind_backtrace from show_stack+0x10/0x14
[ 3.837569] show_stack from dump_stack_lvl+0x58/0x70
[ 3.842663] dump_stack_lvl from __warn+0xd8/0x114
[ 3.847493] __warn from warn_slowpath_fmt+0x5c/0xc4
[ 3.852490] warn_slowpath_fmt from _regulator_put.part.0+0x1bc/0x1e0
[ 3.858968] _regulator_put.part.0 from regulator_put+0x2c/0x3c
[ 3.864918] regulator_put from release_nodes+0x50/0x178
[ 3.870270] release_nodes from devres_release_all+0x80/0xd0
[ 3.875968] devres_release_all from really_probe+0xdc/0x30c
[ 3.881661] really_probe from __driver_probe_device+0x80/0xe4
[ 3.887522] __driver_probe_device from driver_probe_device+0x30/0xd4
[ 3.893991] driver_probe_device from __driver_attach_async_helper+0x20/0x38
[ 3.901068] __driver_attach_async_helper from async_run_entry_fn+0x20/0xb4
[ 3.908059] async_run_entry_fn from process_one_work+0x298/0x7d0
[ 3.914188] process_one_work from worker_thread+0x30/0x510
[ 3.919792] worker_thread from kthread+0x128/0x14c
[ 3.924705] kthread from ret_from_fork+0x14/0x38
[ 3.929443] Exception stack(0xc20cbfb0 to 0xc20cbff8)
[ 3.934521] bfa0: 00000000 00000000 00000000 00000000
[ 3.942722] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[ 3.950922] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[ 3.957677] irq event stamp: 1207
[ 3.961024] hardirqs last enabled at (1215): [<c0198270>] __up_console_sem+0x50/0x60
[ 3.968974] hardirqs last disabled at (1224): [<c019825c>] __up_console_sem+0x3c/0x60
[ 3.976911] softirqs last enabled at (1206): [<c010150c>] __do_softirq+0x2ec/0x5a4
[ 3.984669] softirqs last disabled at (1197): [<c012ef08>] irq_exit+0x18c/0x20c
[ 3.992021] ---[ end trace 45a52c023bf8fb33 ]---

Signed-off-by: wrsadmin <wrsadmin@pek-xwang8-d1.corp.ad.wrs.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 6974bd5aa116..f8279a15463b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1216,7 +1216,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 
 	ret = dw_pcie_host_init(&pci->pp);
 	if (ret < 0)
-		return ret;
+		goto err_vpcie;
 
 	if (pci_msi_enabled()) {
 		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
@@ -1226,6 +1226,11 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+
+err_vpcie:
+	regulator_disable(imx6_pcie->vpcie);
+
+	return ret;
 }
 
 static void imx6_pcie_shutdown(struct platform_device *pdev)
-- 
2.25.1

