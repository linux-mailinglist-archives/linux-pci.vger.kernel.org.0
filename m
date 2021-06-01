Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8329396B84
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 04:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhFACp7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 22:45:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56306 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232268AbhFACp7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 May 2021 22:45:59 -0400
X-UUID: ca766e335ac945a58f3d09265ececf52-20210601
X-UUID: ca766e335ac945a58f3d09265ececf52-20210601
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 41655772; Tue, 01 Jun 2021 10:44:16 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 1 Jun 2021 10:44:15 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Jun 2021 10:44:14 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Randy Wu <Randy.Wu@mediatek.com>, <youlin.pei@mediatek.com>
Subject: [PATCH 2/2] PCI: mediatek-gen3: Add controller support for MT8195
Date:   Tue, 1 Jun 2021 10:44:08 +0800
Message-ID: <20210601024408.24485-3-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210601024408.24485-1-jianjun.wang@mediatek.com>
References: <20210601024408.24485-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MT8195 is an ARM platform SoC which has the same PCIe IP with MT8192.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 3c5b97716d40..c12e2450d0e1 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1010,6 +1010,7 @@ static const struct dev_pm_ops mtk_pcie_pm_ops = {
 
 static const struct of_device_id mtk_pcie_of_match[] = {
 	{ .compatible = "mediatek,mt8192-pcie" },
+	{ .compatible = "mediatek,mt8195-pcie" },
 	{},
 };
 
-- 
2.18.0

