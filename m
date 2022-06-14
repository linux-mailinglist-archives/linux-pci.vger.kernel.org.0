Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132DB54A3A5
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 03:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346107AbiFNB1b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 21:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240862AbiFNB1Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 21:27:24 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B65ED8
        for <linux-pci@vger.kernel.org>; Mon, 13 Jun 2022 18:27:19 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220614012716epoutp0150a87134b8fb3e8045dcfdb574b369dd~4WGDrbBaI2570325703epoutp01N
        for <linux-pci@vger.kernel.org>; Tue, 14 Jun 2022 01:27:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220614012716epoutp0150a87134b8fb3e8045dcfdb574b369dd~4WGDrbBaI2570325703epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655170036;
        bh=KzKahmVZYmTvoOtGzCa8vM5WwpxKgfThYlPDOd7HKWE=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=PazTpfxTm3c59NB14bwGfe1ZxvOv8/Ga7mdI0he3vis6YGevlvjw3kVh/gh8bJ19t
         6RuIclFJK/wm55+Wlv7AfdPXMrJ56IWIoE3rzn/w95nBUFJ2Y0c2YnsAnluVBfNIfM
         R69Out2Vqzqc31dHd2abL7eOQtF1aSAGpsNKm4z0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220614012715epcas2p40a79def60ad6ca161c512bb1ade92326~4WGCu75sj1882518825epcas2p4U;
        Tue, 14 Jun 2022 01:27:15 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.68]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LMW4y3MVXz4x9Ps; Tue, 14 Jun
        2022 01:27:14 +0000 (GMT)
X-AuditID: b6c32a48-ca1c5a80000025de-33-62a7e3f22b69
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.BA.09694.2F3E7A26; Tue, 14 Jun 2022 10:27:14 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v3 1/5] dt-bindings: pci: Add ARTPEC-8 PCIe controller
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
In-Reply-To: <20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220614012713epcms2p810386a5137fbcf6aefc41fe086badc0b@epcms2p8>
Date:   Tue, 14 Jun 2022 10:27:13 +0900
X-CMS-MailID: 20220614012713epcms2p810386a5137fbcf6aefc41fe086badc0b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMJsWRmVeSWpSXmKPExsWy7bCmhe6nx8uTDFa+ErZY0pRh8fKQpsX8
        I+dYLXbPWM5kMXPqGWaL54dmMVt8alG1uPC0h83i5ax7bBYNPb9ZLY68+chssf/4SiaLy7vm
        sFmcnXeczWLCqm8sFm9+v2C3OLc406J17xF2i513TjBb/Nr6h8lBxGPNvDWMHtfXBXgs2FTq
        sWlVJ5vHkyvTmTw2L6n36NuyitHj+I3tTB6fN8kFcEZl22SkJqakFimk5iXnp2TmpdsqeQfH
        O8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAPaWkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8u
        sVVKLUjJKTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM5Yc+sva8F2+4qLl2azNTB26HUxcnJI
        CJhIXPq1l7WLkYtDSGAHo0Tn2mdADgcHr4CgxN8dwiA1wgJuEm1txxhBbCEBJYkda+YxQ8T1
        Ja6v6GYFsdkEdCX+LX7JBmKLCHxmlbi+RxBkJrPAAkaJ/b/3MUIs45WY0f6UBcKWlti+fCtY
        nFPAT2Lh0UlMEHENiR/LepkhbFGJm6vfssPY74/Nh5ojItF67yxUjaDEg5+7oeJSEgueHGKF
        sKsl9v/9DTWzgVGi/34qyF8SQEfvuG4MEuYV8JX4+GU+WAmLgKpE07/vUOUuEgvnngL7hVlA
        XmL72znMIK3MApoS63fpQ0xRljhyiwXmqYaNv9nR2cwCfBIdh//CxXfMewI1XU1i3sqdzBMY
        lWchwnkWkl2zEHYtYGRexSiWWlCcm55abFRgAo/a5PzcTYzg1K3lsYNx9tsPeocYmTgYDzFK
        cDArifBOvrgsSYg3JbGyKrUoP76oNCe1+BCjKdCXE5mlRJPzgdkjryTe0MTSwMTMzNDcyNTA
        XEmc1ytlQ6KQQHpiSWp2ampBahFMHxMHp1QDk4t/N9/GdbU+udZn3O//XDLl9tfCycs25Wb8
        72cR4DKPy8+W5Vw69UZl2v8CncwFcotmewpezlbMZNnd02j4cs47dZ3d11fWNsce4Diwwp/3
        q7rGilwHjvdmXlx7LCdxBqi83GvqO6kjJ5RhgtfjBS5/uXcWTP54o3wp150ta5t15h+5tvRk
        wcaQi4Gv96SY6b5X2HX5y/NnmWF7f8/nvrttmZJngEL29MqVWzV4DRbNeH33p1jO/+mWGi7f
        rEUzM2a1GHjbv1rcN8lSbpnh7MOPYqbFHwrs4VwZtjna/effi2tvOj/MDjHukOIWmMnUfKRA
        xvDi9B08ySwv7/Xtkm9dpJJ5cImiPtPBmMZlFUosxRmJhlrMRcWJAKPR1/BmBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7
References: <20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7>
        <CGME20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p8>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add description to support Axis, ARTPEC-8 SoC.
ARTPEC-8 is the SoC platform of Axis Communications
and PCIe controller is designed based on Design-Ware PCIe controller.

Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
---
v2->v3 :
- modify version history to fit the linux commit rule
- remove 'Device Tree Bindings' on title
- remove the interrupt-names, phy-names entries
- remove '_clk' suffix
- add the compatible entries on required
- change node name to soc from artpec8 on examples

v1->v2 :
-'make dt_binding_check' result improvement
-Add the missing property list
-Align the indentation of continued lines/entries
---
 .../bindings/pci/axis,artpec8-pcie-ep.yaml         | 109 +++++++++++++++++++
 .../devicetree/bindings/pci/axis,artpec8-pcie.yaml | 120 +++++++++++++++++++++
 2 files changed, 229 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec8-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
new file mode 100644
index 0000000..d802bba
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
@@ -0,0 +1,109 @@
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
+  phys:
+    maxItems: 1
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
index 0000000..dbbe1fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/axis,artpec8-pcie.yaml
@@ -0,0 +1,120 @@
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
+  phys:
+    maxItems: 1
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
