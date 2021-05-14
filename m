Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000BB3803E2
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 09:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhENHBi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 03:01:38 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43338 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231373AbhENHBc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 03:01:32 -0400
X-UUID: e83256d0429e4fe38946c619dd78fe26-20210514
X-UUID: e83256d0429e4fe38946c619dd78fe26-20210514
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 409943478; Fri, 14 May 2021 14:59:53 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 14 May 2021 14:59:52 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 14 May 2021 14:59:50 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        <youlin.pei@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <qizhong.cheng@mediatek.com>, <sin_jieyang@mediatek.com>,
        <drinkcat@chromium.org>, <Rex-BC.Chen@mediatek.com>,
        Krzysztof Wilczyski <kw@linux.com>, <Ryan-JH.Yu@mediatek.com>
Subject: [PATCH 1/2] dt-bindings: PCI: mediatek-gen3: Add property to disable dvfsrc voltage request
Date:   Fri, 14 May 2021 14:59:26 +0800
Message-ID: <20210514065927.20774-2-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210514065927.20774-1-jianjun.wang@mediatek.com>
References: <20210514065927.20774-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add property to disable dvfsrc voltage request, if this property
is presented, we assume that the requested voltage is always
higher enough to keep the PCIe controller active.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 .../devicetree/bindings/pci/mediatek-pcie-gen3.yaml       | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index e7b1f9892da4..3e26c032cea9 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -96,6 +96,12 @@ properties:
   phys:
     maxItems: 1
 
+  disable-dvfsrc-vlt-req:
+    description: Disable dvfsrc voltage request, if this property is presented,
+      we assume that the requested voltage is always higher enough to keep
+      the PCIe controller active.
+    type: boolean
+
   '#interrupt-cells':
     const: 1
 
@@ -166,6 +172,8 @@ examples:
                      <&infracfg_rst 3>;
             reset-names = "phy", "mac";
 
+            disable-dvfsrc-vlt-req;
+
             #interrupt-cells = <1>;
             interrupt-map-mask = <0 0 0 0x7>;
             interrupt-map = <0 0 0 1 &pcie_intc 0>,
-- 
2.25.1

