Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE657529A5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 19:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjGMRS7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 13:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjGMRS6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 13:18:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8929C26A3;
        Thu, 13 Jul 2023 10:18:57 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-214-236.ewe-ip-backbone.de [91.248.214.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E28A26607052;
        Thu, 13 Jul 2023 18:18:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689268736;
        bh=6jGIKPbfF8lFaKxaxnrLO3vT+yEQbM1fwyNNnYbXS6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PLKB31XyoOBNRF8LVy2cE+0oXfj/7egsX6mmTa9pvIEw9EF1H/cIfCgJbglWhJjc+
         OW2oPkLPEWQVMiJG712gHFi4b/610V11zA/aFHJ/o4Dc0/vJrzUNJkoc3+ajkOriug
         I7NVE/iiV9qdRHR1NOpryI4vmIK5rQiTnvFn1bccajGr69n67Ui8HMEQY0Dpn7rbjA
         rtvEvqAbtDI7E2VI5r9DN0ag4J/ChzR0v1JTwMXLWgZZX1cVqdFZy03wnigxlPxyA9
         RHiBbdMHqFgw1NNdCpwhOx78OnvcBnu2TRJPSEobIKBj//XIsmH2Z5ddWmi9jZ7o3W
         ynbpJUAQYTClA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id CBDB5480086; Thu, 13 Jul 2023 19:18:53 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Serge Semin <fancer.lancer@gmail.com>
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
Subject: [PATCH v2 2/3] dt-bindings: PCI: dwc: rockchip: Add missing legacy-interrupt-controller
Date:   Thu, 13 Jul 2023 19:18:50 +0200
Message-Id: <20230713171851.73052-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713171851.73052-1-sebastian.reichel@collabora.com>
References: <20230713171851.73052-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/pci/rockchip-dw-pcie.yaml        | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
index aad53c7d8485..8460b1a87248 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -71,6 +71,28 @@ properties:
       - const: legacy
       - const: err
 
+  legacy-interrupt-controller:
+    description: Interrupt controller node for handling legacy PCI interrupts.
+    type: object
+    additionalProperties: false
+    properties:
+      "#address-cells":
+        const: 0
+
+      "#interrupt-cells":
+        const: 1
+
+      interrupt-controller: true
+
+      interrupts:
+        items:
+          - description: combined legacy interrupt
+    required:
+      - "#address-cells"
+      - "#interrupt-cells"
+      - interrupt-controller
+      - interrupts
+
   msi-map: true
 
   num-lanes: true
@@ -158,6 +180,14 @@ examples:
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
2.40.1

