Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185993F43DF
	for <lists+linux-pci@lfdr.de>; Mon, 23 Aug 2021 05:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbhHWD3a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Aug 2021 23:29:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49724 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233760AbhHWD32 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Aug 2021 23:29:28 -0400
X-UUID: 097d0c61d7c842508789cc7b0570b5f7-20210823
X-UUID: 097d0c61d7c842508789cc7b0570b5f7-20210823
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 24532140; Mon, 23 Aug 2021 11:28:44 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 23 Aug 2021 11:28:43 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 23 Aug 2021 11:28:41 +0800
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     <robh+dt@kernel.org>, <bhelgaas@google.com>,
        <matthias.bgg@gmail.com>, <lorenzo.pieralisi@arm.com>
CC:     <ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
        <yong.wu@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 3/6] PCI: mediatek: Add new method to get irq number
Date:   Mon, 23 Aug 2021 11:27:57 +0800
Message-ID: <20210823032800.1660-4-chuanjia.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210823032800.1660-1-chuanjia.liu@mediatek.com>
References: <20210823032800.1660-1-chuanjia.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use platform_get_irq_byname() to get the irq number
if the property of "interrupt-names" is defined.

Signed-off-by: Chuanjia Liu <chuanjia.liu@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 4296d9e04240..19e35ac62d43 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -654,7 +654,11 @@ static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
 		return err;
 	}
 
-	port->irq = platform_get_irq(pdev, port->slot);
+	if (of_find_property(dev->of_node, "interrupt-names", NULL))
+		port->irq = platform_get_irq_byname(pdev, "pcie_irq");
+	else
+		port->irq = platform_get_irq(pdev, port->slot);
+
 	if (port->irq < 0)
 		return port->irq;
 
-- 
2.18.0

