Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA030733702
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jun 2023 19:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345789AbjFPRB3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 13:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345372AbjFPRAo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 13:00:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7F530F5;
        Fri, 16 Jun 2023 10:00:43 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-215-052.ewe-ip-backbone.de [91.248.215.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 604026606F85;
        Fri, 16 Jun 2023 18:00:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686934841;
        bh=mUHbgHwI0ryNn4lkHpGJMiFlejZz09YJSeHgaUj4sVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S1CdmAWzKuFM2OPpy48efHFqKqrkGIb8x97s4ZbEWcBxF8q5+lpT+Hrz3PXf47ERw
         sBj4/bCLkLcZ8UtHigoDGHI+aqatV8L56UUYix5NOYc9KF81pN6soxP21e1xIizYgT
         MTJ7l07paZki5dLIjjlsYMQkaG9eZAHZqpI88J6iT66mMjoNcBrBbJXwAzqyIgEljL
         qDPM6I7IWZw+5HBqDdxspiSHpoVh9Net8+ZcmyykbXUf253Ah06b+0xMFHW7BgOFBP
         p5fFMCQS/8UKcSogOo5SHKmWL4OvzJUldwxs/f3UtKxLC4GGX3cDQOmgcJWGPUr/4F
         KJv0MEivPOSMQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 10B6F480583; Fri, 16 Jun 2023 19:00:39 +0200 (CEST)
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
Subject: [PATCH v1 1/4] dt-bindings: PCI: dwc: rockchip: Fix interrupt-names issue
Date:   Fri, 16 Jun 2023 19:00:19 +0200
Message-Id: <20230616170022.76107-2-sebastian.reichel@collabora.com>
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

The RK356x (and RK3588) have 5 ganged interrupts. For example the
"legacy" interrupt combines "inta/intb/intc/intd" with a register
providing the details.

Currently the binding is not specifying these interrupts resulting
in a bunch of errors for all rk356x boards using PCIe.

Fix this by specifying the interrupts and add them to the example
to prevent regressions.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/pci/rockchip-dw-pcie.yaml         | 18 ++++++++++++++++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml  | 15 ++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
index 24c88942e59e..98e45d2d8dfe 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
@@ -56,6 +56,17 @@ properties:
       - const: pclk
       - const: aux
 
+  interrupts:
+    maxItems: 5
+
+  interrupt-names:
+    items:
+      - const: sys
+      - const: pmc
+      - const: msg
+      - const: legacy
+      - const: err
+
   msi-map: true
 
   num-lanes: true
@@ -98,6 +109,7 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     bus {
         #address-cells = <2>;
@@ -117,6 +129,12 @@ examples:
                           "aclk_dbi", "pclk",
                           "aux";
             device_type = "pci";
+            interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "sys", "pmc", "msg", "legacy", "err";
             linux,pci-domain = <2>;
             max-link-speed = <2>;
             msi-map = <0x2000 &its 0x2000 0x1000>;
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 1a83f0f65f19..9f605eb297f5 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -193,9 +193,22 @@ properties:
           oneOf:
             - description: See native "app" IRQ for details
               enum: [ intr ]
+        - description: Combined Legacy A/B/C/D interrupt signal.
+          const: legacy
+        - description: Combined System interrupt signal.
+          const: sys
+        - description: Combined Power Management interrupt signal.
+          const: pmc
+        - description: Combined Message Received interrupt signal.
+          const: msg
+        - description: Combined Error interrupt signal.
+          const: err
+
     allOf:
       - contains:
-          const: msi
+          enum:
+            - msi
+            - msg
 
 additionalProperties: true
 
-- 
2.39.2

