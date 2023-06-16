Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459E573370D
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jun 2023 19:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346060AbjFPRBm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 13:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345381AbjFPRAo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 13:00:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F69230F9;
        Fri, 16 Jun 2023 10:00:43 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-215-052.ewe-ip-backbone.de [91.248.215.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6D92D6606F86;
        Fri, 16 Jun 2023 18:00:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686934841;
        bh=UUp1ukfBywtwpph0BM+a29Xo/RNDQnnSMjgz7LkN1Zw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=msXBX3v/bw9oWUk68ClxuJHLoBW+kShPYmlyil7ZsQbf/tJHHvGSN+qSQs5ZJKBsi
         riuH9SBaJNosZrohWiM1K0qh6ovjSLSWnB3ziBnxWyRAnIaufz9qXA3p+9w76Pbe6p
         4ly7dPNMxzq2n04Il8SCtFkNUBgO2qTL7Oeiy+uisz2X+kMyEfSExYcQaw78pGpILN
         et1warkNVV99NGzB/L8F3SShOrizPsunC3vqBU12DcKMgIz3qw9VmsbNmKKsubFcrt
         Dpj2qDBkTSamasPhK83nxaA+7TUAKIf1utFYdmAPWiwbx2yGqWqcbBqXa7SOZCuLBi
         Q5cZpNUmhH/KA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 124BF480596; Fri, 16 Jun 2023 19:00:39 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 2/4] dt-bindings: PCI: dwc: rockchip: Add missing legacy-interrupt-controller
Date:   Fri, 16 Jun 2023 19:00:20 +0200
Message-Id: <20230616170022.76107-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616170022.76107-1-sebastian.reichel@collabora.com>
References: <20230616170022.76107-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rockchip RK356x and RK3588 handle legacy interrupts via a ganged
interrupts. The RK356x DT implements this via a sub-node named
"legacy-interrupt-controller", just like a couple of other PCIe
implementations. This adds proper documentation for this and updates
the example to avoid regressions.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/pci/rockchip-dw-pcie.yaml        | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
index 98e45d2d8dfe..bf81d306cc80 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -67,6 +67,22 @@ properties:
       - const: legacy
       - const: err
 
+  legacy-interrupt-controller:
+    description: Interrupt controller node for handling legacy PCI interrupts.
+    type: object
+    properties:
+      "#address-cells":
+        const: 0
+
+      "#interrupt-cells":
+        const: 1
+
+      "interrupt-controller": true
+
+      interrupts:
+        items:
+          - description: combined legacy interrupt
+
   msi-map: true
 
   num-lanes: true
@@ -148,6 +164,14 @@ examples:
             reset-names = "pipe";
             #address-cells = <3>;
             #size-cells = <2>;
+
+            legacy-interrupt-controller {
+                interrupt-controller;
+                #address-cells = <0>;
+                #interrupt-cells = <1>;
+                interrupt-parent = <&gic>;
+                interrupts = <GIC_SPI 72 IRQ_TYPE_EDGE_RISING>;
+            };
         };
     };
 ...
-- 
2.39.2

