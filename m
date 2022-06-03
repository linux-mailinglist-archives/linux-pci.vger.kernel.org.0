Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D540A53C338
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 04:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiFCCYD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 22:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiFCCYC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 22:24:02 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8E7377C7
        for <linux-pci@vger.kernel.org>; Thu,  2 Jun 2022 19:24:00 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220603022358epoutp01c60d2dee36ec86a8afe73649218d2b57~0_xa6LXXc0087500875epoutp01m
        for <linux-pci@vger.kernel.org>; Fri,  3 Jun 2022 02:23:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220603022358epoutp01c60d2dee36ec86a8afe73649218d2b57~0_xa6LXXc0087500875epoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654223038;
        bh=pVfyquUiCztu8odxdc3iVsb9cC99Xcjd5w1voSgjL+c=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=QDsLtOg7ZgBXCHRxSD/qq79esuHFcjMaXHxzz8qBSzsU/GudbT28hKSJo9drWQMq8
         ZOelKtbwnx3dfWcM341vZ/mA3PmuCFYCS9Hom+FoI1598DdKirRS3UGWUhy5sqpMQx
         ha7BJQlfr/MG/zli2FxxDXnbxTIrAImGIqsXChKw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220603022357epcas2p235cc51e0e6bc9248f73a9378a885a5af~0_xaSr3b01082810828epcas2p2c;
        Fri,  3 Jun 2022 02:23:57 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.92]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LDmsQ0Qcyz4x9Q1; Fri,  3 Jun
        2022 02:23:54 +0000 (GMT)
X-AuditID: b6c32a45-a8fff70000002755-7e-629970b906a1
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.65.10069.9B079926; Fri,  3 Jun 2022 11:23:53 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 1/5] dt-bindings: pci: Add ARTPEC-8 PCIe controller
Reply-To: wangseok.lee@samsung.com
Sender: Wangseok Lee <wangseok.lee@samsung.com>
From:   Wangseok Lee <wangseok.lee@samsung.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220603015431epcms2p6203908cebe6a320854136559a32b54cb@epcms2p6>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220603022353epcms2p5d83a4a7d95584ce6a65a63356cd46e76@epcms2p5>
Date:   Fri, 03 Jun 2022 11:23:53 +0900
X-CMS-MailID: 20220603022353epcms2p5d83a4a7d95584ce6a65a63356cd46e76
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmhe7OgplJBm+nWFgsacqweHlI02L+
        kXOsFrtnLGeymDn1DLPF80OzmC0+tahaXHjaw2bxctY9NouGnt+sFkfefGS22H98JZPF5V1z
        2CzOzjvOZjFh1TcWize/X7BbnFucadG69wi7xc47J5gdhD3WzFvD6HF9XYDHgk2lHptWdbJ5
        PLkynclj85J6j74tqxg9jt/YzuTxeZNcAGdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmB
        oa6hpYW5kkJeYm6qrZKLT4CuW2YO0D9KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKU
        nALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMzx+bmAsOWlXsXtDH2sDYqtXFyMEhIWAi0bGm
        pouRk0NIYAejxO8eHpAwr4CgxN8dwiBhYQE3iaW3VzBBlChJ7Fgzjxkiri9xfUU3K4jNJqAr
        8W/xS7YuRi4OEYGzTBI3725nBXGYBeawSFxv/gBWJSHAKzGj/SkLhC0tsX35VkYQm1PAT+Lc
        ly42iLiGxI9lvcwQtqjEzdVv2WHs98fmM0LYIhKt985C1QhKPPi5GyouJbHgySGoXdUS+//+
        ZoKwGxgl+u+nQvyrL7HjujFImFfAV+LKlp9ga1kEVCUerJkGVe4icX/ia7AxzALyEtvfzmEG
        aWUW0JRYv0sfYoqyxJFbLDBPNWz8zY7OZhbgk+g4/BcuvmPeE6jpahLzVu5knsCoPAsR0LOQ
        7JqFsGsBI/MqRrHUguLc9NRiowJDeMwm5+duYgSnay3XHYyT337QO8TIxMF4iFGCg1lJhLdk
        19QkId6UxMqq1KL8+KLSnNTiQ4ymQF9OZJYSTc4HZoy8knhDE0sDEzMzQ3MjUwNzJXFer5QN
        iUIC6YklqdmpqQWpRTB9TBycUg1MO+Ptvu55V60SdlJLcu+1iKecE9Qenrt3Lm/n8pv+GiaW
        4vOPfdn96tc6y8OsMy7+KbUz7uifsUZ2Qti8vL4Nd9mNd5ReZpu5/KduzZvn38/f7W5x2e5z
        bkZUQiLLQtWrNrw3j2zTOv37sdUC1hO8b7rOzjlx6ueZH2IP7q060JvJxGgX28YfO2FHvJtw
        /09xI3v3nufftvJ5+f185BVQMztrkVqRyIGfs5QizGLcTrPujAr8WC4YGn40uGeudNXBu6/W
        toYKsr6W/hMsssrY58anTM8WZ89K7jWp1nKTHn/5eWJ51bur3y473H1QoSPHJ51fOOHgpPh/
        5j80dpWIeR+xsEuZ3S1fk+V4KS8hXImlOCPRUIu5qDgRALo9ZlhgBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220603015431epcms2p6203908cebe6a320854136559a32b54cb
References: <20220603015431epcms2p6203908cebe6a320854136559a32b54cb@epcms2p6>
        <CGME20220603015431epcms2p6203908cebe6a320854136559a32b54cb@epcms2p5>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add description to support Axis, ARTPEC-8 SoC.
ARTPEC-8 is the SoC platform of Axis Communications
and PCIe controller is designed based on Design-Ware PCIe controller.

changes since v1 :
-'make dt_binding_check' result improvement
-Add the missing property list
-Align the indentation of continued lines/entries

Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
---
 .../bindings/pci/axis,artpec8-pcie-ep.yaml         | 108 ++++++++++++++++++
 .../devicetree/bindings/pci/axis,artpec8-pcie.yaml | 123 +++++++++++++++++++++
 2 files changed, 231 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/axis,artpec8-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
new file mode 100644
index 0000000..3512e38
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/axis,artpec8-pcie-ep.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/axis,artpec8-pcie-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARTPEC-8 SoC PCIe Controller Device Tree Bindings
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
+  interrupts-names:
+    items:
+      - const: intr
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
+      - const: pipe_clk
+      - const: dbi_clk
+      - const: mstr_clk
+      - const: slv_clk
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
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
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
+    artpec8 {
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
+            clock-names = "pipe_clk", "dbi_clk", "mstr_clk", "slv_clk";
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
index 0000000..945a061
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/axis,artpec8-pcie.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/axis,artpec8-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Artpec-8 SoC PCIe Controller Device Tree Bindings
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
+  device_type:
+    items:
+      - const: pci
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
+  interrupts-names:
+    items:
+      - const: intr
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
+      - const: pipe_clk
+      - const: dbi_clk
+      - const: mstr_clk
+      - const: slv_clk
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    items:
+      - const: pcie_phy
+
+required:
+  - reg
+  - reg-names
+  - device_type
+  - ranges
+  - num-lanes
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
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
+    artpec8 {
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
+            clock-names = "pipe_clk", "dbi_clk", "mstr_clk", "slv_clk";
+            phys = <&pcie_phy>;
+            phy-names = "pcie_phy";
+        };
+    };
+...
-- 
2.9.5
