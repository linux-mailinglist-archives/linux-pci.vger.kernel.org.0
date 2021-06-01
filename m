Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CF2396B87
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 04:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhFACqC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 22:46:02 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58803 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232644AbhFACqB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 May 2021 22:46:01 -0400
X-UUID: 48f6a0ec61794618bf6f8fabaf54b0cb-20210601
X-UUID: 48f6a0ec61794618bf6f8fabaf54b0cb-20210601
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1226191685; Tue, 01 Jun 2021 10:44:15 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 1 Jun 2021 10:44:13 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Jun 2021 10:44:13 +0800
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
Subject: [PATCH 1/2] dt-bindings: PCI: mediatek-gen3: Add support for MT8195
Date:   Tue, 1 Jun 2021 10:44:07 +0800
Message-ID: <20210601024408.24485-2-jianjun.wang@mediatek.com>
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
 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index e7b1f9892da4..d5e4a3e63d97 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -48,7 +48,9 @@ allOf:
 
 properties:
   compatible:
-    const: mediatek,mt8192-pcie
+    oneOf:
+      - const: mediatek,mt8192-pcie
+      - const: mediatek,mt8195-pcie
 
   reg:
     maxItems: 1
-- 
2.18.0

