Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23298620096
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 22:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbiKGVLj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 16:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbiKGVKm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 16:10:42 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E2E12EF40;
        Mon,  7 Nov 2022 13:07:34 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id EB65BE0EB4;
        Mon,  7 Nov 2022 23:50:11 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=KmFcNHo9OqQxeOABfUnjYuizvlCdtot+YjGnLHVDMB8=; b=JXCzPHNq0k/d
        +ZReELY2FWHsbcLFsJsBAdei9yAwbnHPU9lZCYDanOVgDJycYyJIGoB5xJsmbAyD
        CVDPajtFWlja6YneBP9F1iPGmGBnMipOKo6uqMRa3HzaoisMkOJ1DGaIS40uwC2E
        fkgLkqppxf9VHYWujmKOV7opLYlOwSM=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id DE09BE0E1D;
        Mon,  7 Nov 2022 23:50:11 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 7 Nov 2022 23:50:11 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 06/20] dt-bindings: PCI: dwc: Add max-link-speed common property
Date:   Mon, 7 Nov 2022 23:49:20 +0300
Message-ID: <20221107204934.32655-7-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
References: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In accordance with [1] DW PCIe controllers support up to Gen5 link speed.
Let's add the max-link-speed property upper bound to 5 then. The DT
bindings of the particular devices are expected to setup more strict
constraint on that parameter.

[1] Synopsys DesignWare Cores PCI Express Controller Databook, Version
5.40a, March 2019, p. 27

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changelog v3:
- This is a new patch unpinned from the next one:
  https://lore.kernel.org/linux-pci/20220503214638.1895-2-Sergey.Semin@baikalelectronics.ru/
  by the Rob' request. (@Rob)
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml | 3 +++
 Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml     | 2 ++
 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml        | 1 +
 3 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index 91d24e400dfc..e63c21783fc1 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -54,6 +54,9 @@ properties:
       the peripheral devices available on the PCIe bus.
     maxItems: 1
 
+  max-link-speed:
+    maximum: 5
+
   num-lanes:
     description:
       Number of PCIe link lanes to use. Can be omitted if the already brought
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index dcd521aed213..fc3b5d4ac245 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -55,4 +55,6 @@ examples:
 
       phys = <&pcie_phy0>, <&pcie_phy1>, <&pcie_phy2>, <&pcie_phy3>;
       phy-names = "pcie0", "pcie1", "pcie2", "pcie3";
+
+      max-link-speed = <3>;
     };
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index d9512f7f7124..e787b9727589 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -74,4 +74,5 @@ examples:
       phy-names = "pcie";
 
       num-lanes = <1>;
+      max-link-speed = <3>;
     };
-- 
2.38.0


