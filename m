Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405D146B2B5
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 07:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbhLGGJc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 01:09:32 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37050 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230094AbhLGGJc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 01:09:32 -0500
X-UUID: c7009bf4b7c64fe49c59bec8c178623c-20211207
X-UUID: c7009bf4b7c64fe49c59bec8c178623c-20211207
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <qizhong.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 628431408; Tue, 07 Dec 2021 14:05:58 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 7 Dec 2021 14:05:56 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkcas10.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 7 Dec 2021 14:05:56 +0800
From:   qizhong cheng <qizhong.cheng@mediatek.com>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <chuanjia.liu@mediatek.com>,
        <qizhong.cheng@mediatek.com>
Subject: [PATCH] PCI: mediatek: Delay 100ms to wait power and clock to become stable
Date:   Tue, 7 Dec 2021 14:05:50 +0800
Message-ID: <20211207060550.20918-1-qizhong.cheng@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Described in PCIe CEM specification setctions 2.2 (PERST# Signal) and
2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of PERST# should
be delayed 100ms (TPVPERL) for the power and clock to become stable.

Signed-off-by: qizhong cheng <qizhong.cheng@mediatek.com>
Change-Id: Ia9abe1e763564a5bad1d045fd268c38e76e2ae95
---
 drivers/pci/controller/pcie-mediatek.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 2f3f974977a3..a61ea3940471 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -702,6 +702,13 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	 */
 	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
 
+	/*
+	 * Described in PCIe CEM specification setctions 2.2 (PERST# Signal) and
+	 * 2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of PERST# should
+	 * be delayed 100ms (TPVPERL) for the power and clock to become stable.
+	 */
+	msleep(100);
+
 	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
 	val = readl(port->base + PCIE_RST_CTRL);
 	val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
-- 
2.25.1

