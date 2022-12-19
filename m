Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28295651274
	for <lists+linux-pci@lfdr.de>; Mon, 19 Dec 2022 20:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiLSTMt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Dec 2022 14:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbiLSTM2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2022 14:12:28 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F8811C15;
        Mon, 19 Dec 2022 11:12:25 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id x44-20020a05683040ac00b006707c74330eso5897814ott.10;
        Mon, 19 Dec 2022 11:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46JbXkm0AGTOlW4ZS4S/fkNOhqoj9coxtpa3c0vWKNs=;
        b=W7/RvYO7UxR2AOsthPDF3eZ6GFecklfUp6K/kJACO8NxHzX27u6ZMVf7mIm1pzvylg
         g/QPSlLsO720NDY1QZzaiSBJc0MekKOcuv3brgY7zfTiec6ZVgAOCeyQj8yzDMpCzskK
         VO1roYl5KqbsDSjg+5QIg19c9VGyww+e2BIosaiKVdjSM6kBRb2iEmRy0o4WbKYZIJ/2
         OzDmkFcAO/rIJkJbVtWaZ0/pYbRaAE+/VpRoQWXbAEB8TO6lpgr1ZYSd05yrdWl0/E+3
         vSLzhVVKJhW6IIHY6zBcfEWJz/DzqahgaHqQJ452p3cHE5kzlYJKjreVoO0WcRR5Xvxs
         Y/Dg==
X-Gm-Message-State: ANoB5pmz7+cGj0rWF8D1rbdMFWploC1l4LSKEFHPJ9iBSjbp8gSfvnrv
        0/iw+Dy1Q4eu6W566uYqIQ==
X-Google-Smtp-Source: AA0mqf6vCAuA3U1rnxHRSuh61gekR8vtt1ysysMF0P5bkOCPR+XEkcbQ0uG6ukdpk8Cp1bV+bNOAKQ==
X-Received: by 2002:a05:6830:1517:b0:670:69ac:bb49 with SMTP id k23-20020a056830151700b0067069acbb49mr21123363otp.15.1671477144921;
        Mon, 19 Dec 2022 11:12:24 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ci10-20020a05683063ca00b00660fe564e12sm1723447otb.58.2022.12.19.11.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:12:24 -0800 (PST)
Received: (nullmailer pid 1976200 invoked by uid 1000);
        Mon, 19 Dec 2022 19:12:23 -0000
From:   Rob Herring <robh@kernel.org>
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: Convert Rockchip RK3399 PCIe to DT schema
Date:   Mon, 19 Dec 2022 13:12:08 -0600
Message-Id: <20221219191209.1975834-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the Rockchip RK3399 PCIe Host/Endpoint controller to DT schema
format. Like most dual mode PCI controllers, we need to split the schema
into common, host and endpoint schemas.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Shawn (or anyone from Rockchip), Note and please ack the license change.
---
 .../pci/rockchip,rk3399-pcie-common.yaml      |  69 +++++++++
 .../bindings/pci/rockchip,rk3399-pcie-ep.yaml |  68 +++++++++
 .../bindings/pci/rockchip,rk3399-pcie.yaml    | 132 +++++++++++++++++
 .../bindings/pci/rockchip-pcie-ep.txt         |  62 --------
 .../bindings/pci/rockchip-pcie-host.txt       | 135 ------------------
 MAINTAINERS                                   |   2 +-
 6 files changed, 270 insertions(+), 198 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-common.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt

diff --git a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-common.yaml b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-common.yaml
new file mode 100644
index 000000000000..a8574f8a84a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-common.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/rockchip,rk3399-pcie-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip AXI PCIe Bridge Common Properties
+
+maintainers:
+  - Shawn Lin <shawn.lin@rock-chips.com>
+
+properties:
+  reg:
+    maxItems: 2
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: aclk
+      - const: aclk-perf
+      - const: hclk
+      - const: pm
+
+  num-lanes:
+    maximum: 4
+
+  phys:
+    oneOf:
+      - maxItems: 1
+      - maxItems: 4
+
+  phy-names:
+    oneOf:
+      - const: pcie-phy
+      - items:
+          - const: pcie-phy-0
+          - const: pcie-phy-1
+          - const: pcie-phy-2
+          - const: pcie-phy-3
+
+  resets:
+    maxItems: 7
+
+  reset-names:
+    items:
+      - const: core
+      - const: mgmt
+      - const: mgmt-sticky
+      - const: pipe
+      - const: pm
+      - const: pclk
+      - const: aclk
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - phys
+  - phy-names
+  - resets
+  - reset-names
+
+additionalProperties: true
+
+...
diff --git a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
new file mode 100644
index 000000000000..88386a6d7011
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/rockchip,rk3399-pcie-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip AXI PCIe Endpoint
+
+maintainers:
+  - Shawn Lin <shawn.lin@rock-chips.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-ep.yaml#
+  - $ref: rockchip,rk3399-pcie-common.yaml#
+
+properties:
+  compatible:
+    const: rockchip,rk3399-pcie-ep
+
+  reg: true
+
+  reg-names:
+    items:
+      - const: apb-base
+      - const: mem-base
+
+  rockchip,max-outbound-regions:
+    description: Maximum number of outbound regions
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 32
+    default: 32
+
+required:
+  - rockchip,max-outbound-regions
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/clock/rk3399-cru.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie-ep@f8000000 {
+            compatible = "rockchip,rk3399-pcie-ep";
+            reg = <0x0 0xfd000000 0x0 0x1000000>, <0x0 0x80000000 0x0 0x20000>;
+            reg-names = "apb-base", "mem-base";
+            clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
+              <&cru PCLK_PCIE>, <&cru SCLK_PCIE_PM>;
+            clock-names = "aclk", "aclk-perf",
+                    "hclk", "pm";
+            max-functions = /bits/ 8 <8>;
+            num-lanes = <4>;
+            resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
+              <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE> ,
+              <&cru SRST_PCIE_PM>, <&cru SRST_P_PCIE>, <&cru SRST_A_PCIE>;
+            reset-names = "core", "mgmt", "mgmt-sticky", "pipe",
+                    "pm", "pclk", "aclk";
+            phys = <&pcie_phy 0>, <&pcie_phy 1>, <&pcie_phy 2>, <&pcie_phy 3>;
+            phy-names = "pcie-phy-0", "pcie-phy-1", "pcie-phy-2", "pcie-phy-3";
+            rockchip,max-outbound-regions = <16>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
new file mode 100644
index 000000000000..531008f0b6ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/rockchip,rk3399-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip AXI PCIe Root Port Bridge Host
+
+maintainers:
+  - Shawn Lin <shawn.lin@rock-chips.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: rockchip,rk3399-pcie-common.yaml#
+
+properties:
+  compatible:
+    const: rockchip,rk3399-pcie
+
+  reg: true
+
+  reg-names:
+    items:
+      - const: axi-base
+      - const: apb-base
+
+  interrupts:
+    maxItems: 3
+
+  interrupt-names:
+    items:
+      - const: sys
+      - const: legacy
+      - const: client
+
+  aspm-no-l0s:
+    description: This property is needed if using 24MHz OSC for RC's PHY.
+
+  ep-gpios:
+    description: pre-reset GPIO
+
+  vpcie12v-supply:
+    description: The 12v regulator to use for PCIe.
+
+  vpcie3v3-supply:
+    description: The 3.3v regulator to use for PCIe.
+
+  vpcie1v8-supply:
+    description: The 1.8v regulator to use for PCIe.
+
+  vpcie0v9-supply:
+    description: The 0.9v regulator to use for PCIe.
+
+  interrupt-controller:
+    type: object
+    additionalProperties: false
+
+    properties:
+      '#address-cells':
+        const: 0
+
+      '#interrupt-cells':
+        const: 1
+
+      interrupt-controller: true
+
+required:
+  - ranges
+  - "#interrupt-cells"
+  - interrupts
+  - interrupt-controller
+  - interrupt-map
+  - interrupt-map-mask
+  - msi-map
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/clock/rk3399-cru.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@f8000000 {
+            compatible = "rockchip,rk3399-pcie";
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
+              <&cru PCLK_PCIE>, <&cru SCLK_PCIE_PM>;
+            clock-names = "aclk", "aclk-perf",
+                    "hclk", "pm";
+            interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH 0>,
+                  <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH 0>,
+                  <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH 0>;
+            interrupt-names = "sys", "legacy", "client";
+            ep-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
+            ranges = <0x83000000 0x0 0xfa000000 0x0 0xfa000000 0x0 0x600000
+                0x81000000 0x0 0xfa600000 0x0 0xfa600000 0x0 0x100000>;
+            num-lanes = <4>;
+            msi-map = <0x0 &its 0x0 0x1000>;
+            reg = <0x0 0xf8000000 0x0 0x2000000>, <0x0 0xfd000000 0x0 0x1000000>;
+            reg-names = "axi-base", "apb-base";
+            resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
+              <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE> ,
+              <&cru SRST_PCIE_PM>, <&cru SRST_P_PCIE>, <&cru SRST_A_PCIE>;
+            reset-names = "core", "mgmt", "mgmt-sticky", "pipe",
+                    "pm", "pclk", "aclk";
+            /* deprecated legacy PHY model */
+            phys = <&pcie_phy>;
+            phy-names = "pcie-phy";
+            pinctrl-names = "default";
+            pinctrl-0 = <&pcie_clkreq>;
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 7>;
+            interrupt-map = <0 0 0 1 &pcie0_intc 0>,
+                <0 0 0 2 &pcie0_intc 1>,
+                <0 0 0 3 &pcie0_intc 2>,
+                <0 0 0 4 &pcie0_intc 3>;
+
+            pcie0_intc: interrupt-controller {
+                interrupt-controller;
+                #address-cells = <0>;
+                #interrupt-cells = <1>;
+            };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt
deleted file mode 100644
index 778467307a93..000000000000
--- a/Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt
+++ /dev/null
@@ -1,62 +0,0 @@
-* Rockchip AXI PCIe Endpoint Controller DT description
-
-Required properties:
-- compatible: Should contain "rockchip,rk3399-pcie-ep"
-- reg: Two register ranges as listed in the reg-names property
-- reg-names: Must include the following names
-	- "apb-base"
-	- "mem-base"
-- clocks: Must contain an entry for each entry in clock-names.
-		See ../clocks/clock-bindings.txt for details.
-- clock-names: Must include the following entries:
-	- "aclk"
-	- "aclk-perf"
-	- "hclk"
-	- "pm"
-- resets: Must contain seven entries for each entry in reset-names.
-	   See ../reset/reset.txt for details.
-- reset-names: Must include the following names
-	- "core"
-	- "mgmt"
-	- "mgmt-sticky"
-	- "pipe"
-	- "pm"
-	- "aclk"
-	- "pclk"
-- pinctrl-names : The pin control state names
-- pinctrl-0: The "default" pinctrl state
-- phys: Must contain an phandle to a PHY for each entry in phy-names.
-- phy-names: Must include 4 entries for all 4 lanes even if some of
-  them won't be used for your cases. Entries are of the form "pcie-phy-N":
-  where N ranges from 0 to 3.
-  (see example below and you MUST also refer to ../phy/rockchip-pcie-phy.txt
-  for changing the #phy-cells of phy node to support it)
-- rockchip,max-outbound-regions: Maximum number of outbound regions
-
-Optional Property:
-- num-lanes: number of lanes to use
-- max-functions: Maximum number of functions that can be configured (default 1).
-
-pcie0-ep: pcie@f8000000 {
-	compatible = "rockchip,rk3399-pcie-ep";
-	#address-cells = <3>;
-	#size-cells = <2>;
-	rockchip,max-outbound-regions = <16>;
-	clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
-		 <&cru PCLK_PCIE>, <&cru SCLK_PCIE_PM>;
-	clock-names = "aclk", "aclk-perf",
-		      "hclk", "pm";
-	max-functions = /bits/ 8 <8>;
-	num-lanes = <4>;
-	reg = <0x0 0xfd000000 0x0 0x1000000>, <0x0 0x80000000 0x0 0x20000>;
-	reg-names = "apb-base", "mem-base";
-	resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
-		 <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE> ,
-		 <&cru SRST_PCIE_PM>, <&cru SRST_P_PCIE>, <&cru SRST_A_PCIE>;
-	reset-names = "core", "mgmt", "mgmt-sticky", "pipe",
-		      "pm", "pclk", "aclk";
-	phys = <&pcie_phy 0>, <&pcie_phy 1>, <&pcie_phy 2>, <&pcie_phy 3>;
-	phy-names = "pcie-phy-0", "pcie-phy-1", "pcie-phy-2", "pcie-phy-3";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pcie_clkreq>;
-};
diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
deleted file mode 100644
index af34c65773fd..000000000000
--- a/Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
+++ /dev/null
@@ -1,135 +0,0 @@
-* Rockchip AXI PCIe Root Port Bridge DT description
-
-Required properties:
-- #address-cells: Address representation for root ports, set to <3>
-- #size-cells: Size representation for root ports, set to <2>
-- #interrupt-cells: specifies the number of cells needed to encode an
-		interrupt source. The value must be 1.
-- compatible: Should contain "rockchip,rk3399-pcie"
-- reg: Two register ranges as listed in the reg-names property
-- reg-names: Must include the following names
-	- "axi-base"
-	- "apb-base"
-- clocks: Must contain an entry for each entry in clock-names.
-		See ../clocks/clock-bindings.txt for details.
-- clock-names: Must include the following entries:
-	- "aclk"
-	- "aclk-perf"
-	- "hclk"
-	- "pm"
-- msi-map: Maps a Requester ID to an MSI controller and associated
-	msi-specifier data. See ./pci-msi.txt
-- interrupts: Three interrupt entries must be specified.
-- interrupt-names: Must include the following names
-	- "sys"
-	- "legacy"
-	- "client"
-- resets: Must contain seven entries for each entry in reset-names.
-	   See ../reset/reset.txt for details.
-- reset-names: Must include the following names
-	- "core"
-	- "mgmt"
-	- "mgmt-sticky"
-	- "pipe"
-	- "pm"
-	- "aclk"
-	- "pclk"
-- pinctrl-names : The pin control state names
-- pinctrl-0: The "default" pinctrl state
-- #interrupt-cells: specifies the number of cells needed to encode an
-	interrupt source. The value must be 1.
-- interrupt-map-mask and interrupt-map: standard PCI properties
-
-Required properties for legacy PHY model (deprecated):
-- phys: From PHY bindings: Phandle for the Generic PHY for PCIe.
-- phy-names:  MUST be "pcie-phy".
-
-Required properties for per-lane PHY model (preferred):
-- phys: Must contain an phandle to a PHY for each entry in phy-names.
-- phy-names: Must include 4 entries for all 4 lanes even if some of
-  them won't be used for your cases. Entries are of the form "pcie-phy-N":
-  where N ranges from 0 to 3.
-  (see example below and you MUST also refer to ../phy/rockchip-pcie-phy.txt
-  for changing the #phy-cells of phy node to support it)
-
-Optional Property:
-- aspm-no-l0s: RC won't support ASPM L0s. This property is needed if
-	using 24MHz OSC for RC's PHY.
-- ep-gpios: contain the entry for pre-reset GPIO
-- num-lanes: number of lanes to use
-- vpcie12v-supply: The phandle to the 12v regulator to use for PCIe.
-- vpcie3v3-supply: The phandle to the 3.3v regulator to use for PCIe.
-- vpcie1v8-supply: The phandle to the 1.8v regulator to use for PCIe.
-- vpcie0v9-supply: The phandle to the 0.9v regulator to use for PCIe.
-
-*Interrupt controller child node*
-The core controller provides a single interrupt for legacy INTx. The PCIe node
-should contain an interrupt controller node as a target for the PCI
-'interrupt-map' property. This node represents the domain at which the four
-INTx interrupts are decoded and routed.
-
-
-Required properties for Interrupt controller child node:
-- interrupt-controller: identifies the node as an interrupt controller
-- #address-cells: specifies the number of cells needed to encode an
-	address. The value must be 0.
-- #interrupt-cells: specifies the number of cells needed to encode an
-	interrupt source. The value must be 1.
-
-Example:
-
-pcie0: pcie@f8000000 {
-	compatible = "rockchip,rk3399-pcie";
-	#address-cells = <3>;
-	#size-cells = <2>;
-	clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
-		 <&cru PCLK_PCIE>, <&cru SCLK_PCIE_PM>;
-	clock-names = "aclk", "aclk-perf",
-		      "hclk", "pm";
-	bus-range = <0x0 0x1>;
-	interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH 0>,
-		     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH 0>,
-		     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH 0>;
-	interrupt-names = "sys", "legacy", "client";
-	assigned-clocks = <&cru SCLK_PCIEPHY_REF>;
-	assigned-clock-parents = <&cru SCLK_PCIEPHY_REF100M>;
-	assigned-clock-rates = <100000000>;
-	ep-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
-	ranges = <0x83000000 0x0 0xfa000000 0x0 0xfa000000 0x0 0x600000
-		  0x81000000 0x0 0xfa600000 0x0 0xfa600000 0x0 0x100000>;
-	num-lanes = <4>;
-	msi-map = <0x0 &its 0x0 0x1000>;
-	reg = <0x0 0xf8000000 0x0 0x2000000>, <0x0 0xfd000000 0x0 0x1000000>;
-	reg-names = "axi-base", "apb-base";
-	resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
-		 <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE> ,
-		 <&cru SRST_PCIE_PM>, <&cru SRST_P_PCIE>, <&cru SRST_A_PCIE>;
-	reset-names = "core", "mgmt", "mgmt-sticky", "pipe",
-		      "pm", "pclk", "aclk";
-	/* deprecated legacy PHY model */
-	phys = <&pcie_phy>;
-	phy-names = "pcie-phy";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pcie_clkreq>;
-	#interrupt-cells = <1>;
-	interrupt-map-mask = <0 0 0 7>;
-	interrupt-map = <0 0 0 1 &pcie0_intc 0>,
-			<0 0 0 2 &pcie0_intc 1>,
-			<0 0 0 3 &pcie0_intc 2>,
-			<0 0 0 4 &pcie0_intc 3>;
-	pcie0_intc: interrupt-controller {
-		interrupt-controller;
-		#address-cells = <0>;
-		#interrupt-cells = <1>;
-	};
-};
-
-pcie0: pcie@f8000000 {
-	...
-
-	/* preferred per-lane PHY model */
-	phys = <&pcie_phy 0>, <&pcie_phy 1>, <&pcie_phy 2>, <&pcie_phy 3>;
-	phy-names = "pcie-phy-0", "pcie-phy-1", "pcie-phy-2", "pcie-phy-3";
-
-	...
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index 28cc7862a187..a080a536bfd2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16309,7 +16309,7 @@ M:	Shawn Lin <shawn.lin@rock-chips.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-rockchip@lists.infradead.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/rockchip-pcie*
+F:	Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie*
 F:	drivers/pci/controller/pcie-rockchip*
 
 PCIE DRIVER FOR SOCIONEXT UNIPHIER
-- 
2.35.1

