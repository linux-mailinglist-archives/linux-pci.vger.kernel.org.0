Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9589B57B09D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 07:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbiGTF5W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 01:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGTF5V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 01:57:21 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FFD5508D
        for <linux-pci@vger.kernel.org>; Tue, 19 Jul 2022 22:57:19 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220720055718epoutp0245ba41feba3c8c2fd00f68cade744878~DdAGZhmBR2236022360epoutp02V
        for <linux-pci@vger.kernel.org>; Wed, 20 Jul 2022 05:57:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220720055718epoutp0245ba41feba3c8c2fd00f68cade744878~DdAGZhmBR2236022360epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658296638;
        bh=eEzTLcInQohfGMzkO9dU6+s8ihd2sWC+hDcEBUfC1Us=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=UgOmMKURNOEWoJVnaJBth01S+lsqARuTM5bkNoPlBPHvK7bWOrwFcKr3mE6omfVL9
         CZY3Vf6tu6Y5gKz2l8wRwjpHtKmEnQEHTEPxNTUIHoWYWFC9DRb96ueHz+I3gSuqw3
         g/KLJCFMRFANgR/0AM1mS3Tx1rqR8jn0JQiIAcrI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220720055717epcas2p3a3e4e7bf83d6eedc83646ed245433c0a~DdAFz273L0525505255epcas2p3l;
        Wed, 20 Jul 2022 05:57:17 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.69]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LnlMw5yQvz4x9Q8; Wed, 20 Jul
        2022 05:57:16 +0000 (GMT)
X-AuditID: b6c32a48-9f7ff700000025be-3b-62d7993c5791
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.52.09662.C3997D26; Wed, 20 Jul 2022 14:57:16 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v4 2/5] dt-bindings: phy: Add ARTPEC-8 PCIe phy
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
Message-ID: <20220720055716epcms2p60e80b1089dca0f83a894262bce676858@epcms2p6>
Date:   Wed, 20 Jul 2022 14:57:16 +0900
X-CMS-MailID: 20220720055716epcms2p60e80b1089dca0f83a894262bce676858
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAJsWRmVeSWpSXmKPExsWy7bCmha7NzOtJBjca1C2WNGVYvDykaTH/
        yDlWi90zljNZzJx6htni+aFZzBafWlQtLjztYbN4Oesem0VDz29WiyNvPjJb7D++ksni8q45
        bBZn5x1ns5iw6huLxZvfL9gtzi3OtGjde4TdYuedE8wWv7b+YXIQ8Vgzbw2jx/V1AR4LNpV6
        bFrVyebx5Mp0Jo/NS+o9+rasYvQ4fmM7k8fnTXIBnFHZNhmpiSmpRQqpecn5KZl56bZK3sHx
        zvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlATykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otL
        bJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjMut/1mLpgiVdE3J7mBsVWki5GTQ0LA
        ROJcw2XmLkYuDiGBHYwSm3dMBXI4OHgFBCX+7hAGqREWsJf48mQDO4gtJKAksWPNPGaIuL7E
        9RXdrCA2m4CuxL/FL9lAbBGBz6wS1/cIgsxkFljAKLH/9z5GiGW8EjPan7JA2NIS25dvZQTZ
        xSngJ/G2zQEirCHxY1kvM4QtKnFz9Vt2GPv9sflQY0QkWu+dhaoRlHjwczdUXEpiwZNDrBB2
        tcT+v7+ZIOwGRon++6kgqySAbt5x3RgkzCvgK7F+y0uwchYBVYlrn4+wQ5S4SCx/UgQSZhaQ
        l9j+dg44QJgFNCXW79KHqFCWOHKLBealho2/2dHZzAJ8Eh2H/8LFd8x7AnWLmsS8lTuZJzAq
        z0KE8iwku2Yh7FrAyLyKUSy1oDg3PbXYqMAEHq/J+bmbGMFJW8tjB+Pstx/0DjEycTAeYpTg
        YFYS4X1aeD1JiDclsbIqtSg/vqg0J7X4EKMp0JMTmaVEk/OBeSOvJN7QxNLAxMzM0NzI1MBc
        SZzXK2VDopBAemJJanZqakFqEUwfEwenVAOT1cy3MXX/JPIP3/SJ1pFx+V13aEt+knqe52Tx
        a5WJcwVOF5bq7ph4+23SeXPxpTULHq5Y9IJnS3mvlGv+2t0pz84KcrGUt+peZnmX1FH7JkFL
        s3Gq9bPM2/Jf6z/uKzhoycOub915zE3S86HmT8nJgrmnJa+lGPx4qxfb3H3sj8OSjWYXv1Y/
        ZHV49oOl8e7Hzt9757ZvyHaunv/iD9daF6/VAoJu3xTd+lcLFjRvfHtWymxjekfMfd/GpXm7
        +H73N8Z9U3i7uOdHwgmHPTumuR7tO6NX+nSmdqDBDMGg6k69aQKv0tZ03W8pCkkoPSV7q8Od
        06xVna2YWfdOQ6tebrd6+ulLvJ9EltVvv6bEUpyRaKjFXFScCAAAntsiYwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800
References: <20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800@epcms2p5>
        <CGME20220720055108epcms2p563c65b3de6333ccbc68386aa2471a800@epcms2p6>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add description to support Axis, ARTPEC-8 SoC. ARTPEC-8 is the SoC platform
of Axis Communications and PCIe PHY is designed based on Samsung PHY.

Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
---
v3->v4 :
-Add "fsys-sysreg" to properties
-Modify the "lcpll-ref-clk" and "clocks" in properties
 "lcpll-ref-clk" is custom properties, so add 'vendor', type(enum),
 description
 Add the maxItem in clocks, add clock-names in properties

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
 .../bindings/phy/axis,artpec8-pcie-phy.yaml        | 85 ++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml
new file mode 100644
index 0000000..9db39ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/axis,artpec8-pcie-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARTPEC-8 SoC PCIe PHY
+
+maintainers:
+  - Jesper Nilsson <jesper.nilsson@axis.com>
+
+properties:
+  compatible:
+    const: axis,artpec8-pcie-phy
+
+  reg:
+    items:
+      - description: PHY registers.
+      - description: PHY coding sublayer registers.
+
+  reg-names:
+    items:
+      - const: phy
+      - const: pcs
+
+  "#phy-cells":
+    const: 0
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: ref
+
+  samsung,fsys-sysreg:
+    description:
+      Phandle to system register of fsys block.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  num-lanes:
+    const: 2
+
+  axis,lcpll-ref-clk:
+    description:
+      select the reference clock of phy and initialization is performed
+      with the reference clock according to the selected value.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2, 3, 4 ]
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#phy-cells"
+  - clocks
+  - clock-names
+  - samsung,fsys-sysreg
+  - num-lanes
+  - axis,lcpll-ref-clk
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pcie_phy: pcie-phy@16c80000 {
+            compatible = "axis,artpec8-pcie-phy";
+            reg = <0x0 0x16c80000 0x0 0x2000>,
+                  <0x0 0x16c90000 0x0 0x1000>;
+            reg-names = "phy", "pcs";
+            #phy-cells = <0>;
+            clocks = <&clock_cmu_fsys 53>;
+            clock-names = "ref";
+            samsung,fsys-sysreg = <&syscon_fsys>;
+            num-lanes = <2>;
+            axis,lcpll-ref-clk = <1>;
+        };
+    };
+...
-- 
2.9.5
