Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECB7756ACC
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 19:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjGQRf7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 13:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjGQRf6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 13:35:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE691BE;
        Mon, 17 Jul 2023 10:35:38 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-189-171.ewe-ip-backbone.de [91.248.189.171])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CD3E566028F5;
        Mon, 17 Jul 2023 18:35:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689615316;
        bh=64KeJPG4Zg7KDZinmnbpSO47kNMgAyfiBh+eN2b40rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B5HBbDB20yXRLoz4slfRfa4dcG7iTPpeXK0IKlVynGXZfrgZ/LTtP0NCtNffMTqp2
         53y1ZhTnvb6nxC7WHaZme7TNf4+gjZOb1w7pG4WwffjpLj2HG5r23fVt7C0tOV3O8Z
         YKWgBBEsTY540MUUQRvdf4+4SlmnZxx8LqfouRU0AwF9FDU9LoToi1Zcl4stwDZkvK
         cR6MuMrIjixM9Zlc4MTTibxIXGuHxU6j7afd6FpeZrqSvmO+t7HXff2HhQoYiYRBpC
         Qj7kH3ITX820LlNRz+dt9drHpbb2oJVULN0ijOb8COb5GIdTBGtyYJSPJIn+kx5bYD
         pNWzNDmnpYOMQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id D348D480C77; Mon, 17 Jul 2023 19:35:12 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, John Clark <inindev@gmail.com>,
        Qu Wenruo <wqu@suse.com>, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: phy: rockchip: add RK3588 PCIe v3 phy
Date:   Mon, 17 Jul 2023 19:35:11 +0200
Message-Id: <20230717173512.65169-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717173512.65169-1-sebastian.reichel@collabora.com>
References: <20230717173512.65169-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the RK3568 PCIe v3 PHY supported has been upstreamed, RK3588
support was included, but the DT binding does not reflect this.
This adds the missing bits.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/phy/rockchip,pcie3-phy.yaml      | 33 ++++++++++++++++---
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
index 9f2d8d2cc7a5..c4fbffcde6e4 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
@@ -13,19 +13,18 @@ properties:
   compatible:
     enum:
       - rockchip,rk3568-pcie3-phy
+      - rockchip,rk3588-pcie3-phy
 
   reg:
     maxItems: 1
 
   clocks:
-    minItems: 3
+    minItems: 1
     maxItems: 3
 
   clock-names:
-    items:
-      - const: refclk_m
-      - const: refclk_n
-      - const: pclk
+    minItems: 1
+    maxItems: 3
 
   data-lanes:
     description: which lanes (by position) should be mapped to which
@@ -61,6 +60,30 @@ required:
   - rockchip,phy-grf
   - "#phy-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - rockchip,rk3588-pcie3-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          items:
+            - const: pclk
+    else:
+      properties:
+        clocks:
+          minItems: 3
+
+        clock-names:
+          items:
+            - const: refclk_m
+            - const: refclk_n
+            - const: pclk
+
 additionalProperties: false
 
 examples:
-- 
2.40.1

