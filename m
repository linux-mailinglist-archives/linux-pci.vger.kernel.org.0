Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E57D4413D6
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 07:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhKAGql (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 02:46:41 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45392 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231168AbhKAGqh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Nov 2021 02:46:37 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1094C20120B;
        Mon,  1 Nov 2021 07:44:04 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CC0082011F2;
        Mon,  1 Nov 2021 07:44:03 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 00E34183AD6D;
        Mon,  1 Nov 2021 14:44:01 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, broonie@kernel.org,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v4 4/6] PCI: dwc: Add dw_pcie_host_ops.host_exit() callback
Date:   Mon,  1 Nov 2021 14:17:56 +0800
Message-Id: <1635747478-25562-5-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635747478-25562-1-git-send-email-hongxing.zhu@nxp.com>
References: <1635747478-25562-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When link is never came up in the link training after host_init.
The clocks and power supplies usage counter balance should be handled
properly on some DWC platforms (for example, i.MX PCIe).

Add a new host_exit() callback into dw_pcie_host_ops, then it could be
invoked to handle the unbalance issue in the error handling after
host_init() function when link is down.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 5 ++++-
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f4755f3a03be..461863bde3c9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -405,7 +405,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (!dw_pcie_link_up(pci) && pci->ops && pci->ops->start_link) {
 		ret = pci->ops->start_link(pci);
 		if (ret)
-			goto err_free_msi;
+			goto err_host_init;
 	}
 
 	/* Ignore errors, the link may come up later */
@@ -417,6 +417,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (!ret)
 		return 0;
 
+err_host_init:
+	if (pp->ops->host_exit)
+		pp->ops->host_exit(pp);
 err_free_msi:
 	if (pp->has_msi_ctrl)
 		dw_pcie_free_msi(pp);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 7d6e9b7576be..1153687ea9a6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -174,6 +174,7 @@ enum dw_pcie_device_mode {
 
 struct dw_pcie_host_ops {
 	int (*host_init)(struct pcie_port *pp);
+	void (*host_exit)(struct pcie_port *pp);
 	int (*msi_host_init)(struct pcie_port *pp);
 };
 
-- 
2.25.1

