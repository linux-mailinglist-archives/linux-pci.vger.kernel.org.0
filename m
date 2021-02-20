Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADF7320360
	for <lists+linux-pci@lfdr.de>; Sat, 20 Feb 2021 04:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBTDCg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Feb 2021 22:02:36 -0500
Received: from inva021.nxp.com ([92.121.34.21]:57462 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229985AbhBTDCg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Feb 2021 22:02:36 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5BE67200165;
        Sat, 20 Feb 2021 04:01:49 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 99AE32006B1;
        Sat, 20 Feb 2021 04:01:43 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 050E5402F6;
        Sat, 20 Feb 2021 04:01:34 +0100 (CET)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v2] PCI: imx6: Limit DBI register length for imx6qp PCIe
Date:   Sat, 20 Feb 2021 10:49:48 +0800
Message-Id: <1613789388-2495-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613789388-2495-1-git-send-email-hongxing.zhu@nxp.com>
References: <1613789388-2495-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Define the length of the DBI registers and limit config space to its
length. This makes sure that the kernel does not access registers beyond
that point that otherwise would lead to an abort on the i.MX 6QuadPlus.

See commit 075af61c19cd ("PCI: imx6: Limit DBI register length") that
resolves a similar issue on the i.MX 6Quad PCIe.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
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

