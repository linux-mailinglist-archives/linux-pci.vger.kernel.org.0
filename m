Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195083F43E4
	for <lists+linux-pci@lfdr.de>; Mon, 23 Aug 2021 05:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbhHWD3o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Aug 2021 23:29:44 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:36036 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234427AbhHWD3n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Aug 2021 23:29:43 -0400
X-UUID: 3bc7393a40834d968507b134c914d571-20210823
X-UUID: 3bc7393a40834d968507b134c914d571-20210823
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2099527350; Mon, 23 Aug 2021 11:28:58 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 23 Aug 2021 11:28:56 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 23 Aug 2021 11:28:55 +0800
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     <robh+dt@kernel.org>, <bhelgaas@google.com>,
        <matthias.bgg@gmail.com>, <lorenzo.pieralisi@arm.com>
CC:     <ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
        <yong.wu@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 4/6] PCI: mediatek: Get pci domain and decide how to parse node
Date:   Mon, 23 Aug 2021 11:27:58 +0800
Message-ID: <20210823032800.1660-5-chuanjia.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210823032800.1660-1-chuanjia.liu@mediatek.com>
References: <20210823032800.1660-1-chuanjia.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use of_get_pci_domain_nr() to get the pci domain.
If the property of "linux,pci-domain" is defined in node,
we assume that the PCIe bridge is an individual bridge,
hence that we only need to parse one port.

Signed-off-by: Chuanjia Liu <chuanjia.liu@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 29 +++++++++++++++-----------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 19e35ac62d43..928e0983a900 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -1048,22 +1048,27 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
 	struct device *dev = pcie->dev;
 	struct device_node *node = dev->of_node, *child;
 	struct mtk_pcie_port *port, *tmp;
-	int err;
+	int err, slot;
+
+	slot = of_get_pci_domain_nr(dev->of_node);
+	if (slot < 0) {
+		for_each_available_child_of_node(node, child) {
+			err = of_pci_get_devfn(child);
+			if (err < 0) {
+				dev_err(dev, "failed to get devfn: %d\n", err);
+				goto error_put_node;
+			}
 
-	for_each_available_child_of_node(node, child) {
-		int slot;
+			slot = PCI_SLOT(err);
 
-		err = of_pci_get_devfn(child);
-		if (err < 0) {
-			dev_err(dev, "failed to parse devfn: %d\n", err);
-			goto error_put_node;
+			err = mtk_pcie_parse_port(pcie, child, slot);
+			if (err)
+				goto error_put_node;
 		}
-
-		slot = PCI_SLOT(err);
-
-		err = mtk_pcie_parse_port(pcie, child, slot);
+	} else {
+		err = mtk_pcie_parse_port(pcie, node, slot);
 		if (err)
-			goto error_put_node;
+			return err;
 	}
 
 	err = mtk_pcie_subsys_powerup(pcie);
-- 
2.18.0

