Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADDB46B647
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 09:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbhLGIpp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 03:45:45 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:38176 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229846AbhLGIpp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 03:45:45 -0500
X-UUID: 87fd9c02db674226a9c5c0bd5aba56f2-20211207
X-UUID: 87fd9c02db674226a9c5c0bd5aba56f2-20211207
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <qizhong.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1654386062; Tue, 07 Dec 2021 16:42:12 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 7 Dec 2021 16:42:11 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkcas10.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 7 Dec 2021 16:42:10 +0800
From:   qizhong cheng <qizhong.cheng@mediatek.com>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <qizhong.cheng@mediatek.com>, <chuanjia.liu@mediatek.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [RESEND PATCH v2] PCI: mediatek: Delay 100ms to wait power and clock to become stable
Date:   Tue, 7 Dec 2021 16:41:53 +0800
Message-ID: <20211207084153.23019-1-qizhong.cheng@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Described in PCIe CEM specification sections 2.2 (PERST# Signal) and
2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of PERST# should
be delayed 100ms (TPVPERL) for the power and clock to become stable.

Signed-off-by: qizhong cheng <qizhong.cheng@mediatek.com>
Acked-by: Pali Rohár <pali@kernel.org>
---

v2:
 - Typo fix.
 - Rewrap into one paragraph.

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
+	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal) and
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

