Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1022B57B095
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 07:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbiGTFyp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 01:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiGTFyp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 01:54:45 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8724649B68
        for <linux-pci@vger.kernel.org>; Tue, 19 Jul 2022 22:54:43 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220720055438epoutp027900cb34c21d19837daf7d8a010ee6a0~Dc9x6IANw1918419184epoutp02_
        for <linux-pci@vger.kernel.org>; Wed, 20 Jul 2022 05:54:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220720055438epoutp027900cb34c21d19837daf7d8a010ee6a0~Dc9x6IANw1918419184epoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658296478;
        bh=DMK8IgTtZbHF6hI7hCGciRf8wUaVR1Ad9VNtzlXOziE=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=LlaiAQ8w54lSde459i/hirpm9PQpceKB3h3b5wTjC31pkYwW/gRh+dFWJ+ydJIk+d
         THNunWieSixaFDJECnZRjepR0ud7vHJ+7G/pLIsnSyoeAX7sbquNhKuM4p2mBBgU1i
         UBag+N74hLaIgvvvrEIzzKw9B0gO3PGfi5bKIisQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220720055437epcas2p34da9921fabb951376fd1c7a2611e4704~Dc9xGq7du1267612676epcas2p3z;
        Wed, 20 Jul 2022 05:54:37 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.98]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LnlJs0nVdz4x9Q1; Wed, 20 Jul
        2022 05:54:37 +0000 (GMT)
X-AuditID: b6c32a46-0a3ff700000025b2-60-62d7989c37e5
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.84.09650.C9897D26; Wed, 20 Jul 2022 14:54:37 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v4 1/5] dt-bindings: pci: Add ARTPEC-8 PCIe controller
Reply-To: wangseok.lee@samsung.com
Sender: Wangseok Lee <wangseok.lee@samsung.com>
From:   Wangseok Lee <wangseok.lee@samsung.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>
CC:     Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>,
        Yeeun Kim <yeeun119.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800@epcms2p5>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220720055436epcms2p63896ebe4e2131e3844044d0112288570@epcms2p6>
Date:   Wed, 20 Jul 2022 14:54:36 +0900
X-CMS-MailID: 20220720055436epcms2p63896ebe4e2131e3844044d0112288570
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIJsWRmVeSWpSXmKPExsWy7bCmme7cGdeTDKYeYbJY0pRh8fKQpsX8
        I+dYLXbPWM5kMXPqGWaL54dmMVt8alG1uPC0h83i5ax7bBYNPb9ZLY68+chssf/4SiaLy7vm
        sFmcnXeczWLCqm8sFm9+v2C3OLc406J17xF2i513TjBb/Nr6h8lBxGPNvDWMHtfXBXgs2FTq
        sWlVJ5vHkyvTmTw2L6n36NuyitHj+I3tTB6fN8kFcEZl22SkJqakFimk5iXnp2TmpdsqeQfH
        O8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAPaWkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8u
        sVVKLUjJKTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM74taeTueCbT8WvnrksDYxzLLoYOTkk
        BEwkZq1YzdTFyMUhJLCDUeLJg9fMXYwcHLwCghJ/dwiD1AgLuEl0bTvMCGILCShJ7Fgzjxki
        ri9xfUU3K4jNJqAr8W/xSzYQW0TgM6vE9T2CIDOZBRYwSuz/vY8RYhmvxIz2pywQtrTE9uVb
        GUF2cQr4Sbxtc4AIa0j8WNbLDGGLStxc/ZYdxn5/bD7UGBGJ1ntnoWoEJR783A0Vl5JY8OQQ
        K4RdLbH/728mCLuBUaL/firIKgmgm3dcNwYJ8wr4SlxacpUFJMwioCox/WkxRLWLxLcdN8Cm
        MAvIS2x/OwccIMwCmhLrd+lDDFGWOHKLBealho2/2dHZzAJ8Eh2H/8LFd8x7AnWLmsS8lTuZ
        JzAqz0KE8iwku2Yh7FrAyLyKUSy1oDg3PbXYqMAIHrHJ+bmbGMFpW8ttB+OUtx/0DjEycTAe
        YpTgYFYS4X1aeD1JiDclsbIqtSg/vqg0J7X4EKMp0JMTmaVEk/OBmSOvJN7QxNLAxMzM0NzI
        1MBcSZzXK2VDopBAemJJanZqakFqEUwfEwenVAOTrujXbQc+csvu5+bK2irz7ejX9AczeER8
        rlyaUrjqbaLCM+b4bwLHKtO4HUIcZYymtZZnsokxNMce25ZdKVjINelOggOn5I3WSgVh/yPc
        FzTkN35VyZW+5mXc9srZr+ztn7KOO81O83VMf7x8er/h0GVPp6XrIhte1JQy8Msb/eXn3CxU
        s1a54W/2Zt+AeubJ953s65XjA9cK1V5eO13yotmEJ1a6Twp8BL/43OX87S5x2CbgVajgUoPd
        R7Szbm34dt6r1W2TuMJrr5NtPx601Tf9T35tZCAXmiy3Zk7V85UipcVuUh955oU6+Qut1mry
        cXF6vi/NcHpS7HQjyetLHGLdp5S9n2x9me22gxJLcUaioRZzUXEiAKGkd4JkBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800
References: <20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800@epcms2p5>
        <CGME20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800@epcms2p6>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add description to support Axis, ARTPEC-8 SoC. ARTPEC-8 is the SoC platform
of Axis Communications and PCIe controller is designed based on Design-Ware
PCIe controller.

Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
---
v3->v4 :
-Add missing properties

v2->v3 :
-Modify version history to fit the linux commit rule
-Remove 'Device Tree Bindings' on title
-Remove clock-names entries
-Change node name to soc from artpec8 on excamples

v1->v2 :
-'make dt_binding_check' result improvement
-Add the missing property list
-Align the indentation of continued lines/entries
---
 .../bindings/pci/axis,artpec8-pcie-ep.yaml         | 138 +++++++++++++++++++
 .../devicetree/bindings/pci/axis,artpec8-pcie.yaml | 148 +++++++++++++++++++++
 2 files changed, 286 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec8-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
new file mode 100644
index 0000000..435e86f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/axis,artpec8-pcie-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARTPEC-8 SoC PCIe Controller
+
+maintainers:
+  - Jesper Nilsson <jesper.nilsson@axis.com>
+
+description: |+
+  This PCIe end-point controller is based on the Synopsys DesignWare PCIe IP
+  and thus inherits all the common properties defined in snps,dw-pcie-ep.yaml.
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
+
+properties:
+  compatible:
+    const: axis,artpec8-pcie-ep
+
+  reg:
+    items:
+      - description: Data Bus Interface (DBI) registers.
+      - description: Data Bus Interface (DBI2) registers.
+      - description: PCIe address space region.
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: dbi2
+      - const: addr_space
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: PIPE clock, used by the controller to clock the PIPE
+      - description: PCIe dbi clock, ungated version
+      - description: PCIe master clock, ungated version
+      - description: PCIe slave clock, ungated version
+
+  clock-names:
+    items:
+      - const: pipe
+      - const: dbi
+      - const: mstr
+      - const: slv
+
+  samsung,fsys-sysreg:
+    description:
+      Phandle to system register of fsys block.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  samsung,syscon-phandle:
+    description:
+      Phandle to the PMU system controller node.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  samsung,fsys-bus-s:
+    description:
+      Phandle to bus-s of fsys block, this register
+      is additional control sysreg in fsys block and
+      this is used for pcie slave control setting.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  samsung,fsys-bus-p:
+    description:
+      Phandle to bus-p of fsys block, this register
+      is additional control sysreg in fsys block and
+      this is used for pcie dbi control setting.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    items:
+      - const: pcie_phy
+
+  num-lanes:
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - samsung,fsys-sysreg
+  - samsung,syscon-phandle
+  - samsung,syscon-bus-s-fsys
+  - samsung,syscon-bus-p-fsys
+  - phys
+  - phy-names
+  - num-lanes
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pcie_ep: pcie-ep@17200000 {
+            compatible = "axis,artpec8-pcie-ep";
+            reg = <0x0 0x17200000 0x0 0x1000>,
+                  <0x0 0x17201000 0x0 0x1000>,
+                  <0x2 0x00000000 0x6 0x00000000>;
+            reg-names = "dbi", "dbi2", "addr_space";
+            #interrupt-cells = <1>;
+            interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "intr";
+            clocks = <&clock_cmu_fsys 39>,
+                     <&clock_cmu_fsys 38>,
+                     <&clock_cmu_fsys 37>,
+                     <&clock_cmu_fsys 36>;
+            clock-names = "pipe", "dbi", "mstr", "slv";
+            samsung,fsys-sysreg = <&syscon_fsys>;
+            samsung,syscon-phandle = <&pmu_system_controller>;
+            samsung,syscon-bus-s-fsys = <&syscon_bus_s_fsys>;
+            samsung,syscon-bus-p-fsys = <&syscon_bus_p_fsys>;
+            phys = <&pcie_phy>;
+            phy-names = "pcie_phy";
+            num-lanes = <2>;
+            bus-range = <0x00 0xff>;
+            num-ib-windows = <16>;
+            num-ob-windows = <16>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/pci/axis,artpec8-pcie.yaml b/Documentation/devicetree/bindings/pci/axis,artpec8-pcie.yaml
new file mode 100644
index 0000000..b7cff4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/axis,artpec8-pcie.yaml
@@ -0,0 +1,148 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/axis,artpec8-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Artpec-8 SoC PCIe Controller
+
+maintainers:
+  - Jesper Nilsson <jesper.nilsson@axis.com>
+
+description: |+
+  This PCIe host controller is based on the Synopsys DesignWare PCIe IP
+  and thus inherits all the common properties defined in snps,dw-pcie.yaml.
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
+properties:
+  compatible:
+    const: axis,artpec8-pcie
+
+  reg:
+    items:
+      - description: Data Bus Interface (DBI) registers.
+      - description: External Local Bus interface (ELBI) registers.
+      - description: PCIe configuration space region.
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: elbi
+      - const: config
+
+  ranges:
+    maxItems: 2
+
+  num-lanes:
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: PIPE clock, used by the controller to clock the PIPE
+      - description: PCIe dbi clock, ungated version
+      - description: PCIe master clock,  ungated version
+      - description: PCIe slave clock, ungated version
+
+  clock-names:
+    items:
+      - const: pipe
+      - const: dbi
+      - const: mstr
+      - const: slv
+
+  samsung,fsys-sysreg:
+    description:
+      Phandle to system register of fsys block.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  samsung,syscon-phandle:
+    description:
+      Phandle to the PMU system controller node.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  samsung,fsys-bus-s:
+    description:
+      Phandle to bus-s of fsys block, this register
+      is additional control sysreg in fsys block and
+      this is used for pcie slave control setting.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  samsung,fsys-bus-p:
+    description:
+      Phandle to bus-p of fsys block, this register
+      is additional control sysreg in fsys block and
+      this is used for pcie dbi control setting.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    items:
+      - const: pcie_phy
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - device_type
+  - ranges
+  - num-lanes
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - samsung,fsys-sysreg
+  - samsung,syscon-phandle
+  - samsung,syscon-bus-s-fsys
+  - samsung,syscon-bus-p-fsys
+  - phys
+  - phy-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pcie: pcie@17200000 {
+            compatible = "axis,artpec8-pcie";
+            reg = <0x0 0x17200000 0x0 0x1000>,
+                  <0x0 0x16ca0000 0x0 0x2000>,
+                  <0x7 0x0001e000 0x0 0x2000>;
+            reg-names = "dbi", "elbi", "config";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            device_type = "pci";
+            ranges = </* non-prefetchable memory */
+                      0x83000000 0x0 0x0000000 0x2 0x00000000 0x5 0x00000000
+                      /* downstream I/O */
+                      0x81000000 0x0 0x0000000 0x7 0x00000000 0x0 0x00010000>;
+            num-lanes = <2>;
+            bus-range = <0x00 0xff>;
+            interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "intr";
+            #interrupt-cells = <1>;
+            clocks = <&cmu_fsys 39>,
+                     <&cmu_fsys 38>,
+                     <&cmu_fsys 37>,
+                     <&cmu_fsys 36>;
+            clock-names = "pipe", "dbi", "mstr", "slv";
+            samsung,fsys-sysreg = <&syscon_fsys>;
+            samsung,syscon-phandle = <&pmu_system_controller>;
+            samsung,syscon-bus-s-fsys = <&syscon_bus_s_fsys>;
+            samsung,syscon-bus-p-fsys = <&syscon_bus_p_fsys>;
+            phys = <&pcie_phy>;
+            phy-names = "pcie_phy";
+        };
+    };
+...
-- 
2.9.5
