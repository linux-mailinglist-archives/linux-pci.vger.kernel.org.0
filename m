Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D536320F2
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 12:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiKULmj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 06:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiKULmI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 06:42:08 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B862F26AD6
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 03:41:44 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221121114143epoutp018c8d0b12f9332ae6e6c16235d783b443~plsN7aH0K1658516585epoutp01N
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 11:41:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221121114143epoutp018c8d0b12f9332ae6e6c16235d783b443~plsN7aH0K1658516585epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669030903;
        bh=0zbIhn5TaJQkfyFJvDuGve8uJxHunuYx0rJ8jMh05Gg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=msChGel3qJhgR1MkfYt1cMnJTUNrqlt6tH9lSMoHfDdfTKHzIeCW55qBgeOvhx64X
         jkNae5G9x4pVrPcFlQSYyaSpR4233ELIfU0kSOIhlgonP767ITCy1WW5k+Eq2fsF/M
         4doZUFJR3QqRJF3lR8SyrKGrmmvcxxSzln9FfKb8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221121114142epcas5p313e82f6fbbdc2f9a28843c8d8f784aa7~plsNQ3EqK2269022690epcas5p3l;
        Mon, 21 Nov 2022 11:41:42 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NG5844nVcz4x9Px; Mon, 21 Nov
        2022 11:41:40 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.0D.39477.4F36B736; Mon, 21 Nov 2022 20:41:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221121104725epcas5p3af00b0c717f2132f5c1ba7fd4e903e26~pk8zxqSjq0704807048epcas5p3K;
        Mon, 21 Nov 2022 10:47:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221121104725epsmtrp2f61699b0cdfce296acecc66619af55b3~pk8zwi8wU2142421424epsmtrp2U;
        Mon, 21 Nov 2022 10:47:25 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-74-637b63f4b997
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.5B.14392.D375B736; Mon, 21 Nov 2022 19:47:25 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221121104721epsmtip1824dcd096c5ed7d940a64a483e00dd12~pk8wUZ9y91012310123epsmtip1W;
        Mon, 21 Nov 2022 10:47:21 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com, vkoul@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, mani@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com, rcsekar@samsung.com,
        sriranjani.p@samsung.com, bharat.uppal@samsung.com,
        s.prashar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, p.rajanbabu@samsung.com,
        niyas.ahmed@samsung.com, chanho61.park@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH 2/6] dt-bindings: PCI: Add PCIe controller bindings for FSD
Date:   Mon, 21 Nov 2022 16:22:06 +0530
Message-Id: <20221121105210.68596-3-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221121105210.68596-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTa0yTVxjHd/q2bwtJ3cvF7dg5ZEU+UAZtoa2HCkic28qckQSybM6tNOVd
        i72mF0DRUEWMojCGbiDYgoImlItSLqsCk5Wbc2GSwBgBjGDYsoE6AhUXwW0tr2zffuc5/+f5
        P+c557Cw4Hs4h5Wtt5AmvULLxQPpnX1RvBivMl8p6KqOQL1/fk9HM45OHL0oH2QiT1sHE43/
        McJE9SfUaPR2NKrp/4mBCuuu42jk13M4Kv19FkO2c6sMNHrrEo6GHUM4KnOu0NHJtZN01Lvo
        BGjuwkMGGmhNR1c6vExUNeJmoKKefiZyuO0AlfQdQ1OPWhjo5vQdLIUjW31eDmS1LqvM5TyD
        y6bHu3HZ3FgFTXbb3sSUtdUXyErbnUA2NPEtTbbsCksLPKBJVJOKLNIUTuqVhqxsvSqJuzdd
        /o5cLBEIY4QJaAc3XK/QkUncPR+mxbyXrfUdnBueo9BafaE0hdnM5ScnmgxWCxmuNpgtSVzS
        mKU1ioyxZoXObNWrYvWkRSoUCOLEPmGmRm1v+pFmdErzHjRcxWygL7oYsFiQEMHmKnkxCGAF
        E10APnAHUbwE4Fg1j+IVAI8/TfOzX/50vJ9RDAJ98R4ACz2TgFoU0eC1ySaGX4UTPF9CMebn
        UGIJg8++kfpFGFEL4OxEA/BvhBB74UrrwnoCnYiENxbOM/wdsQkpnF5Opdy2wcYbvet1Aoid
        sKVuCvfXgcQiCy72/UCnRHtgzS+jDIpD4PxQO5NiDlx+0oNTrIINbZUYxVq40lZPo3gX7B27
        RPf7YkQUvH6LT4XfhF/fbVmXYMQmWLI691LOhm7HBkdA74vuly1sgY7BjRZk8Gafg0YNpRTA
        geZBehkIq/rfohYAJ9hCGs06FWkWG+P0ZO5/V6Y06Fxg/WXzPnCD2ZnFWA+gsYAHQBbGDWUX
        HMxXBrOzFIePkCaD3GTVkmYPEPvm9xXG2aw0+L6G3iIXihIEIolEIkqIlwi5r7PrKnnKYEKl
        sJAakjSSpo08GiuAY6Olt18r33H6+OGth6pDPA0dsrX5satnCt4monef2nex7jGbHxaco9M8
        XPsy5UrL7v2Gg6e7M4OcC6/lbZogKku4unfdn8CtU6/uH2s8elZfESKas18esGfv42eViHMF
        zyJcxy7Lawb+jkzitD9fqnwjaHNybnN9YcrHcdb5mjjOkLficaX0XqLHFp13RJN34FG8tDpA
        8xtbm+P56IvZO0/K3hpOTd3Jd4USzsh/7nYk03UzmRmarhOqz2yHWuIlhWLG6aELP3ujaviE
        8Gz++eK/2psqBLMo7WLGSMCuT9ne0kZ4/7vCV+wZBUWmz0+FlmxTbu8g35+MpvHvt6pt2y2d
        w1VHuXSzWiHkYSaz4l9dutjBYgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRe0hTYRjG/c45O+c4WpzU6svKYBLkRGsg9GF2gajOMLCUivpDG3pSy03Z
        vGQlalbg0BBrWOY1LdymR515WVnqZq6bNrPE3Kw0I9MkayrdL0767+H5PfB74aVxj1zCm45X
        JnMqpTxBTAqJFovYJ2DrodPRm3rMItT5qYtAb8paSPSrsIdC5qZmCg1+sFGo+mwcGujwR+Xd
        fQKUU1VPItu7PBJdnBjFUVbeDwEauF1Cot4yK4kK9PMEOvfzHIE6Z/QAjV8eE6D7jRHoevMs
        hYptbQJ0/m43hcraSgHKt2Qg+0degEyOB/gOb/bH90LAVhhTWKM+l2Qdg+0kO/68CGM7Smsp
        tqk6k714Sw9Y61ArxjqNPvuER4QhMVxCfCqn2rjtqDCutPYxlqQPPvladwPPAhZ/DXCnIRME
        5wa7BQvZg7kD4NsSfLFfBZ39PLaYPaHu93tKA4T/NjkYnPlSQy4AkpHA7DkNvgC8mDwCXmt2
        uFY4Uw1g00i7a+XJhML5ximXgmDWw4apS/8yTYuYYOhwyhYN66ChodNldme2QL7KTi5eFAz5
        oZ9UAVhaAdz0YBWXpFbEKtTSJKmSSwtUyxXqFGVsYHSiwghc35L4tYFW/UygGWA0MANI42Iv
        kVdPerSHKEaefopTJUapUhI4tRmspgnxSpFN8zDKg4mVJ3MnOC6JU/2nGO3unYUxkguK8j/h
        YZuuosIugTJ9EkxbIrRBrccCJWOvNpt2h+8piPQffO8Wro3xtVDTTnNOzoA11vO47F5Go4wN
        fhJZ6WblMz7V8c9WDA+hpvrnN8c7Jve86J5tjLCrp/3KQzp7cz9PpBV7zTmXbdx8mJrd+ch2
        cMYSEz3eHxD1cuSAfnvdWemBmmNha7FdZ7p8NwTsDTF0mFJ2aumey7pJd8tBx7Zs3rcgQJd8
        5WPVmW+m/tG84jXzmQ7tflRWUT/p62PVNQyYKr+mhmplD5cvGc0chvF9dQJblyEMlU/IP39p
        K6qS1qsYTJ5fFz5nz+atdunTJedlhjUt/KU/w0YxoY6TSyW4Si3/C+mEDDocAwAA
X-CMS-MailID: 20221121104725epcas5p3af00b0c717f2132f5c1ba7fd4e903e26
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221121104725epcas5p3af00b0c717f2132f5c1ba7fd4e903e26
References: <20221121105210.68596-1-shradha.t@samsung.com>
        <CGME20221121104725epcas5p3af00b0c717f2132f5c1ba7fd4e903e26@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document the PCIe controller device tree bindings for
Tesla FSD SoC for both RC and EP

Signed-off-by: Shradha Todi  <shradha.t@samsung.com>
---
 .../bindings/pci/tesla,pcie-fsd-ep.yaml       | 107 ++++++++++++++++
 .../bindings/pci/tesla,pcie-fsd.yaml          | 117 ++++++++++++++++++
 2 files changed, 224 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/tesla,pcie-fsd-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/tesla,pcie-fsd.yaml

diff --git a/Documentation/devicetree/bindings/pci/tesla,pcie-fsd-ep.yaml b/Documentation/devicetree/bindings/pci/tesla,pcie-fsd-ep.yaml
new file mode 100644
index 000000000000..07308cb9a35c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/tesla,pcie-fsd-ep.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/tesla,pcie-fsd-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare based PCIe EP controller on FSD SoCs
+
+maintainers:
+  - Shradha Todi <shradha.t@samsung.com>
+
+description: |
+  FSD PCIe EP controller is based on Synopsys DesignWare PCIe IP
+  and thus inherits all the common properties defined in
+  snps,dw-pcie-ep.yaml. The controller instance is dual mode and
+  can work in Root port mode or Endpoint mode at a time.
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
+
+properties:
+  compatible:
+    enum:
+      - tesla,fsd-pcie-ep
+
+  reg:
+    items:
+      - description: controller's application logic registers
+      - description: controller's own configuration registers
+                     are available.
+      - description: controller's own configuration shadow registers
+                     are available.
+      - description: Map the remote Root Complex slave address space
+
+  reg-names:
+    items:
+      - const: appl
+      - const: dbi
+      - const: dbi2
+      - const: addr_space
+
+  clocks:
+    items:
+      - description: Auxiliary clock for PCIe
+      - description: AHB clock for PCIe dbi
+      - description: AHB clock for PCIe master
+      - description: AHB clock for PCIe slave
+
+  clock-names:
+    items:
+      - const: aux_clk
+      - const: dbi_clk
+      - const: mstr_clk
+      - const: slv_clk
+
+  interrupts:
+    items:
+      - description: Controller interrupt
+
+  interrupt-names:
+    items:
+      - const: sub_ctrl_intr
+
+  tesla,pcie-sysreg:
+    $ref: '/schemas/types.yaml#/definitions/phandle-array'
+    description: phandle for system control registers, used to
+                 control signals at system level
+
+required:
+
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - ranges
+  - num-lanes
+  - tesla,pcie-sysreg
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/clock/fsd-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pcie4_ep: pcie-ep@15400000 {
+      compatible = "tesla,fsd-pcie-ep";
+      clocks = <&clock_fsys0 PCIE_SUBCTRL_INST0_AUX_CLK_SOC>,
+               <&clock_fsys0 PCIE_SUBCTRL_INST0_DBI_ACLK_SOC>,
+               <&clock_fsys0 PCIE_SUBCTRL_INST0_MSTR_ACLK_SOC>,
+               <&clock_fsys0 PCIE_SUBCTRL_INST0_SLV_ACLK_SOC>;
+      clock-names = "aux_clk", "dbi_clk", "mstr_clk", "slv_clk";
+      interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
+      interrupt-names = "sub_ctrl_intr";
+      reg = <0x15090000 0x1000>,
+            <0x15400000 0x1000>,
+            <0x15401000 0x80>,
+            <0x15800000 0xFF0000>;
+      reg-names = "appl", "dbi", "dbi2", "addr_space";
+      num-lanes = <4>;
+      tesla,pcie-sysreg = <&sysreg_fsys0 0x434>;
+      phys = <&pcie_phy0>;
+      phy-names = "pcie_phy0";
+      status = "disabled";
+    };
+...
diff --git a/Documentation/devicetree/bindings/pci/tesla,pcie-fsd.yaml b/Documentation/devicetree/bindings/pci/tesla,pcie-fsd.yaml
new file mode 100644
index 000000000000..85648e5c7d27
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/tesla,pcie-fsd.yaml
@@ -0,0 +1,117 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/pci/tesla,pcie-fsd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare based PCIe controller on FSD SoCs
+
+maintainers:
+  - Shradha Todi <shradha.t@samsung.com>
+
+description: |
+  FSD PCIe controller is based on Synopsys DesignWare PCIe IP
+  and thus inherits all the common properties defined in
+  designware-pcie.txt.
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
+properties:
+  compatible:
+    const: tesla,fsd-pcie
+
+  reg:
+    items:
+      - description: controller's application logic registers
+      - description: controller's own configuration registers
+                     are available.
+      - description: configuration registers
+
+  reg-names:
+    items:
+      - const: appl
+      - const: dbi
+      - const: config
+
+  clocks:
+    items:
+      - description: Auxiliary clock for PCIe
+      - description: AHB clock for PCIe dbi
+      - description: AHB clock for PCIe master
+      - description: AHB clock for PCIe slave
+
+  clock-names:
+    items:
+      - const: aux_clk
+      - const: dbi_clk
+      - const: mstr_clk
+      - const: slv_clk
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: MSI interrupt
+      - description: Controller interrupt
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: msi
+      - const: sub_ctrl_intr
+
+  tesla,pcie-sysreg:
+    $ref: '/schemas/types.yaml#/definitions/phandle-array'
+    description: phandle for system control registers, used to
+                 control signals at system level
+
+required:
+
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - ranges
+  - num-lanes
+  - tesla,pcie-sysreg
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/clock/fsd-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      pcie4_rc: pcie@15400000 {
+        compatible = "tesla,fsd-pcie";
+        clocks = <&clock_fsys0 PCIE_SUBCTRL_INST0_AUX_CLK_SOC>,
+                 <&clock_fsys0 PCIE_SUBCTRL_INST0_DBI_ACLK_SOC>,
+                 <&clock_fsys0 PCIE_SUBCTRL_INST0_MSTR_ACLK_SOC>,
+                 <&clock_fsys0 PCIE_SUBCTRL_INST0_SLV_ACLK_SOC>;
+        clock-names = "aux_clk", "dbi_clk", "mstr_clk", "slv_clk";
+        #address-cells = <3>;
+        #size-cells = <2>;
+        dma-coherent;
+        interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "msi";
+        num-lanes = <4>;
+        reg = <0x0 0x15090000 0x0 0x1000>,
+              <0x0 0x15400000 0x0 0x1000>,
+              <0x0 0x15800000 0x0 0x1000>;
+        reg-names = "appl", "dbi", "config";
+        ranges =  <0x82000000 0 0x15801000 0 0x15801000 0 0xffefff>;
+        tesla,pcie-sysreg = <&sysreg_fsys0 0x434>;
+        phys = <&pcie_phy0>;
+        phy-names = "pcie_phy0";
+        iommu-map = <0x0 &smmu_fsys0 0x4 0x10000>;
+        iommu-map-mask = <0x0>;
+        status = "disabled";
+      };
+    };
+...
-- 
2.17.1

