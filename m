Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A225131E553
	for <lists+linux-pci@lfdr.de>; Thu, 18 Feb 2021 06:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBRFWn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Feb 2021 00:22:43 -0500
Received: from inva020.nxp.com ([92.121.34.13]:33794 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhBRFWm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Feb 2021 00:22:42 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CDCDD1A0745;
        Thu, 18 Feb 2021 06:21:55 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7C7001A0E0C;
        Thu, 18 Feb 2021 06:21:50 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 41C0540291;
        Thu, 18 Feb 2021 06:21:44 +0100 (CET)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, stefan@agner.ch,
        lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH] PCI: imx6: Limit DBI register length for imx6qp pcie
Date:   Thu, 18 Feb 2021 13:09:40 +0800
Message-Id: <1613624980-29382-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Refer to commit 075af61c19cd ("PCI: imx6: Limit DBI register length"),
i.MX6QP PCIe has the similar issue.
Define the length of the DBI registers and limit config space to its
length for i.MX6QP PCIe too.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 0cf1333c0440..853ea8e82952 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1175,6 +1175,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.variant = IMX6QP,
 		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
 			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
+		.dbi_length = 0x200,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.17.1

