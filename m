Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6277236577C
	for <lists+linux-pci@lfdr.de>; Tue, 20 Apr 2021 13:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhDTLWW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Apr 2021 07:22:22 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:43026 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231882AbhDTLWU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Apr 2021 07:22:20 -0400
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 68450440E57;
        Tue, 20 Apr 2021 14:21:46 +0300 (IDT)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/5] dt-bindings: phy: qcom,qmp: Add IPQ60xx PCIe PHY bindings
Date:   Tue, 20 Apr 2021 14:21:39 +0300
Message-Id: <f787ca496eae2a0d5ff4f17655eaff9f39a14321.1618916235.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618916235.git.baruch@tkos.co.il>
References: <cover.1618916235.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add ipq6018 qmp phy device for the single PCIe serdes lane on IPQ60xx
SoCs.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index 626447fee092..cb2eb7ac6d28 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -17,6 +17,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,ipq6018-qmp-pcie-phy
       - qcom,ipq8074-qmp-pcie-phy
       - qcom,ipq8074-qmp-usb3-phy
       - qcom,msm8996-qmp-pcie-phy
@@ -294,6 +295,30 @@ allOf:
           items:
             - const: phy
             - const: common
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq6018-qmp-pcie-phy
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Phy aux clock.
+            - description: Phy config clock.
+        clock-names:
+          items:
+            - const: aux
+            - const: cfg_ahb
+        resets:
+          items:
+            - description: reset of phy block.
+            - description: phy common block reset.
+        reset-names:
+          items:
+            - const: phy
+            - const: common
   - if:
       properties:
         compatible:
-- 
2.30.2

