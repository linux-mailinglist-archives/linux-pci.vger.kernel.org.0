Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA1B503700
	for <lists+linux-pci@lfdr.de>; Sat, 16 Apr 2022 16:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiDPOH6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Apr 2022 10:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbiDPOH4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2022 10:07:56 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD91286EA
        for <linux-pci@vger.kernel.org>; Sat, 16 Apr 2022 07:05:23 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout3.routing.net (Postfix) with ESMTP id ACDE460362;
        Sat, 16 Apr 2022 13:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1650117332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s68gl0yAxZUm+X2bvVvokjQGAHtdT79RQMQEhISep+M=;
        b=rE8+uq6rNsCmMbExXD0PS3nAsHvd1dwdaJL/p41t0+95QEfLUYPl1ClZrBRyzZfI81PGKf
        o83mnws4tZCflHeGe/4+rnuKJtyX8Arfwu/t8rv+UGUKqu5PnxhOYhaHRAH7lakV4HxbdQ
        Fay4p/hLJBxd51Ey0DQwCUx16pTJp/8=
Received: from localhost.localdomain (fttx-pool-217.61.150.108.bambit.de [217.61.150.108])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 4397A1006D1;
        Sat, 16 Apr 2022 13:55:31 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [RFC/RFT 1/6] dt-bindings: phy: rockchip: add pcie3 phy
Date:   Sat, 16 Apr 2022 15:54:53 +0200
Message-Id: <20220416135458.104048-2-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416135458.104048-1-linux@fw-web.de>
References: <20220416135458.104048-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 2d0b12d3-a185-41d7-b17c-fea8090fc266
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add a new binding file for Rockchip PCIe V3 phy driver.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 .../bindings/phy/rockchip-pcie3-phy.yaml      | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip-pcie3-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/rockchip-pcie3-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip-pcie3-phy.yaml
new file mode 100644
index 000000000000..58a8ce175f13
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/rockchip-pcie3-phy.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/rockchip-pcie3-phy.yaml#
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
+    maxItems: 2
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    contains:
+      anyOf:
+        - enum: [ refclk_m, refclk_n, pclk ]
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
+      use PHY_MODE_PCIE_AGGREGATION if not defined
+    minimum: 0x0
+    maximum: 0x4
+
+
+required:
+  - compatible
+  - reg
+  - rockchip,phy-grf
+
+additionalProperties: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3568-cru.h>
+    pcie30phy: phy@fe8c0000 {
+      compatible = "rockchip,rk3568-pcie3-phy";
+      reg = <0x0 0xfe8c0000 0x0 0x20000>;
+      #phy-cells = <0>;
+      clocks = <&pmucru CLK_PCIE30PHY_REF_M>, <&pmucru CLK_PCIE30PHY_REF_N>,
+       <&cru PCLK_PCIE30PHY>;
+      clock-names = "refclk_m", "refclk_n", "pclk";
+      resets = <&cru SRST_PCIE30PHY>;
+      reset-names = "phy";
+      rockchip,phy-grf = <&pcie30_phy_grf>;
+    };
-- 
2.25.1

