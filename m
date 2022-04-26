Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D0250FEE9
	for <lists+linux-pci@lfdr.de>; Tue, 26 Apr 2022 15:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350868AbiDZNZL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Apr 2022 09:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiDZNZG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Apr 2022 09:25:06 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9B72F015;
        Tue, 26 Apr 2022 06:21:58 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout4.routing.net (Postfix) with ESMTP id DBA271009A7;
        Tue, 26 Apr 2022 13:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1650979316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/I3vczkANniTDx1yzkb6F3Q+qN8yNcM3KZAsi+3HfMw=;
        b=RKnCSZXRQ7fnjTXzbdlcvkOK6K98elSoFn72BifrXeGGDcl2cP+e/pEX/NiynIrEb2Temo
        9s7uAx3ZLpWWkiX3Dz6hwIhY7dv8U74Mej3F5DI9qtQIu2hAzRaKRc2qW2M1Lf+i3d4Gjv
        +r+l+8L0uiYdZsonvmi2nE5iJfVxooU=
Received: from localhost.localdomain (fttx-pool-80.245.77.37.bambit.de [80.245.77.37])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id DFCC74059D;
        Tue, 26 Apr 2022 13:21:54 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [RFC/RFT v2 01/11] dt-bindings: phy: rockchip: add PCIe v3 phy
Date:   Tue, 26 Apr 2022 15:21:29 +0200
Message-Id: <20220426132139.26761-2-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426132139.26761-1-linux@fw-web.de>
References: <20220426132139.26761-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 32b2cd93-5553-4018-86a3-43385b6d0de2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add a new binding file for Rockchip PCIe v3 phy driver.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

---
v2:
dt-bindings: rename yaml for PCIe v3
rockchip-pcie3-phy.yaml => rockchip,pcie3-phy.yaml

changes in pcie3 phy yaml
- change clock names to ordered const list
- extend pcie30-phymode description
- add phy-cells to required properties
- drop unevaluatedProperties
- example with 1 clock each line
- use default property instead of text describing it
- update license
---
 .../bindings/phy/rockchip,pcie3-phy.yaml      | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
new file mode 100644
index 000000000000..3592888b5ee2
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/rockchip,pcie3-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip PCIe v3 phy
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3568-pcie3-phy
+      - rockchip,rk3588-pcie3-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: "refclk_m"
+      - const: "refclk_n"
+      - const: "pclk"
+
+    minItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: phy
+
+  rockchip,phy-grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the syscon managing the phy "general register files"
+
+  rockchip,pipe-grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the syscon managing the pipe "general register files"
+
+  rockchip,pcie30-phymode:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: |
+      set the phy-mode for enabling bifurcation
+      bit0: bifurcation for port 0
+      bit1: bifurcation for port 1
+      bit2: aggregation
+      constants are defined in the dt-bindings/phy/phy-rockchip-pcie3.h
+    minimum: 0x0
+    maximum: 0x4
+    default: 0x4
+
+required:
+  - compatible
+  - reg
+  - rockchip,phy-grf
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3568-cru.h>
+    pcie30phy: phy@fe8c0000 {
+      compatible = "rockchip,rk3568-pcie3-phy";
+      reg = <0x0 0xfe8c0000 0x0 0x20000>;
+      #phy-cells = <0>;
+      clocks = <&pmucru CLK_PCIE30PHY_REF_M>,
+               <&pmucru CLK_PCIE30PHY_REF_N>,
+               <&cru PCLK_PCIE30PHY>;
+      clock-names = "refclk_m", "refclk_n", "pclk";
+      resets = <&cru SRST_PCIE30PHY>;
+      reset-names = "phy";
+      rockchip,phy-grf = <&pcie30_phy_grf>;
+    };
-- 
2.25.1

