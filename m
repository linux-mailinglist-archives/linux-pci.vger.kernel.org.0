Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090BA444ECD
	for <lists+linux-pci@lfdr.de>; Thu,  4 Nov 2021 07:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhKDGZR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 02:25:17 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:46554 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230213AbhKDGZQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Nov 2021 02:25:16 -0400
X-UUID: 85dac1906203479bbc81c834cdf6ee2d-20211104
X-UUID: 85dac1906203479bbc81c834cdf6ee2d-20211104
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <qizhong.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 877291729; Thu, 04 Nov 2021 14:22:37 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 4 Nov 2021 14:22:36 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs10n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 4 Nov 2021 14:22:35 +0800
From:   qizhong cheng <qizhong.cheng@mediatek.com>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczyi=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Chuanjia Liu <chuanjia.liu@mediatek.com>,
        Jiey Yang <ot_jiey.yang@mediatek.com>,
        qizhong cheng <qizhong.cheng@mediatek.com>
Subject: [PATCH] PCI: mediatek: Delay 100ms to wait power and clock to become stable
Date:   Thu, 4 Nov 2021 14:21:44 +0800
Message-ID: <20211104062144.31453-1-qizhong.cheng@mediatek.com>
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
---
 drivers/pci/controller/pcie-mediatek.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 2f3f974977a3..b32acbac8084 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -702,6 +702,14 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	 */
 	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
 
+	/*
+	 * Described in PCIe CEM specification setctions 2.2 (PERST# Signal)
+	 * and 2.2.1 (Initial Power-Up (G3 to S0)).
+	 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
+	 * for the power and clock to become stable.
+	 */
+	msleep(100);
+
 	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
 	val = readl(port->base + PCIE_RST_CTRL);
 	val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
-- 
2.25.1

