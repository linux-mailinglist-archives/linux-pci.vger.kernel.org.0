Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE7B4B8142
	for <lists+linux-pci@lfdr.de>; Wed, 16 Feb 2022 08:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiBPHR7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Feb 2022 02:17:59 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiBPHR7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Feb 2022 02:17:59 -0500
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99FDC8FA4;
        Tue, 15 Feb 2022 23:17:46 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EEDB41A1A5B;
        Wed, 16 Feb 2022 07:52:56 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B6C5A1A1A59;
        Wed, 16 Feb 2022 07:52:56 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 763DF183F0C0;
        Wed, 16 Feb 2022 14:52:55 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, broonie@kernel.org,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        festevam@gmail.com, francesco.dolcini@toradex.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v7 6/8] PCI: dwc: Add dw_pcie_host_ops.host_exit() callback
Date:   Wed, 16 Feb 2022 14:21:01 +0800
Message-Id: <1644992463-14467-7-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644992463-14467-1-git-send-email-hongxing.zhu@nxp.com>
References: <1644992463-14467-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

