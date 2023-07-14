Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B68754202
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 20:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbjGNR4A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 13:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbjGNRzh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 13:55:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB823C1B;
        Fri, 14 Jul 2023 10:55:07 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-208-179.ewe-ip-backbone.de [91.248.208.179])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5382F6605954;
        Fri, 14 Jul 2023 18:53:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689357226;
        bh=wX8auK31Dgn9eqocHqcN+eNmo/yYDWpGmugDZ3zb274=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M+d23B74uq5E5wjx2dE9tUR8yZCdcBovWFyzSLO1z02uBe3Is/JSLjb6lbJncP7xJ
         NNrvPwGv4pI+jRQMwR1cisQYvgLEgGLqSV/JIWm1fZ+lLrnyX9Pdg1lHj0QaAsV2fJ
         KmOyF+mIQmzGplFqwexk/54qOFkFZnaOaLTh2h9rTyeRlRBbwZH/I4I+USSyfkPGFc
         ums2C0ytlupS907IMP4s3BcOaaB4zdRPeq/5l7tcF30beBohHtrm2Ei0D9OKWNa4xK
         jXkSrXaBbm4WIryehPV9PK8bChjeu4cMr597e2TrkIerkdKyzuRRd0iSw4okLlBgob
         EqqhO9B7zJv2g==
Received: by jupiter.universe (Postfix, from userid 1000)
        id C124948059A; Fri, 14 Jul 2023 19:53:43 +0200 (CEST)
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
        kernel@collabora.com
Subject: [PATCH v1 1/2] dt-bindings: phy: rockchip: add RK3588 PCIe v3 phy
Date:   Fri, 14 Jul 2023 19:53:30 +0200
Message-Id: <20230714175331.112923-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230714175331.112923-1-sebastian.reichel@collabora.com>
References: <20230714175331.112923-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the RK3568 PCIe v3 PHY supported has been upstreamed, RK3588
support was included, but the DT binding does not reflect this.
This adds the missing bits.

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

