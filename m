Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27964E905A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 10:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239470AbiC1IpG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 04:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239469AbiC1IpG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 04:45:06 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75626393D3
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2022 01:43:25 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220328084322epoutp01d031d7be8b4f5d8cf74eb09a3d03bc90~gfujooOW71854418544epoutp01Z
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2022 08:43:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220328084322epoutp01d031d7be8b4f5d8cf74eb09a3d03bc90~gfujooOW71854418544epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648457002;
        bh=q+HVAoGqH/dia7eZTAEaFllANNuLtxUgWBVlfJGeTSQ=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=LG+3W0XjKQkNCoam+k7N+jbx410o6MAgKY9rSTgvUzw4BIlMxjHeeAYiqY1f2vx00
         svMuaeSeARxzifT6+NhxZbwjGdYTWCnfdsbCUblXAoY/xKCjZ8HZqxs5WzyjI4K54u
         KQpNNs5krEUEP8KxKeJ0gZ+4d/MBTKNq4SUtvq+k=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220328084321epcas2p4beb7cee7ab047cdbeb9531b88c180a5b~gfui0S8EY1900419004epcas2p4o;
        Mon, 28 Mar 2022 08:43:21 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.88]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KRmS76nKyz4x9Q4; Mon, 28 Mar
        2022 08:43:19 +0000 (GMT)
X-AuditID: b6c32a46-be9ff70000023ea8-c7-62417527a335
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.4C.16040.72571426; Mon, 28 Mar 2022 17:43:19 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 2/5] dt-bindings: phy: Add ARTPEC-8 PCIe phy
Reply-To: wangseok.lee@samsung.com
Sender: =?UTF-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>
From:   =?UTF-8?B?7J207JmV7ISd?= <wangseok.lee@samsung.com>
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
        =?UTF-8?B?7KCE66y46riw?= <moonki.jun@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220328084319epcms2p3670d7836bb111e0d9c648aeebfde8603@epcms2p3>
Date:   Mon, 28 Mar 2022 17:43:19 +0900
X-CMS-MailID: 20220328084319epcms2p3670d7836bb111e0d9c648aeebfde8603
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmua56qWOSwbJ9phZLmjIsXh7StJh/
        5ByrxfNDs5gtPrWoWlx42sNm8XLWPTaLhp7frBZH3nxktth/fCWTxeVdc9gszs47zmYxYdU3
        Fos3v1+wW5xbnGnRuvcIu8XOOyeYHQQ91sxbw+hxfV2Ax4JNpR6bVnWyeTy5Mp3JY/OSeo++
        LasYPY7f2M7k8XmTXABnVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJu
        qq2Si0+ArltmDtAXSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8
        dL281BIrQwMDI1OgwoTsjLPn9rIXNApVNDytb2C8wtvFyMkhIWAiceTyZJYuRi4OIYEdjBJr
        /rQzdzFycPAKCEr83SEMUiMsYCPxZ/dsZhBbSEBJYseaecwQcWuJT1Mus4DYbAKWEhdbHzKC
        zBEROMskcfPudlYQh1ngNrPE/OfvWSC28UrMaH8KZUtLbF++lRHC1pD4sayXGcIWlbi5+i07
        jP3+2HyoGhGJ1ntnoWoEJR783A0Vl5JY8OQQK4RdLbH/728mCLuBUaL/firIMxIC+hI7rhuD
        hHkFfCWeXpoFNoZFQFVi9+lOqHIXiVsX94DFmQXkJba/nQMOB2YBTYn1u/QhpihLHLkF90jD
        xt/s6GxmAT6JjsN/4eI75j2Bmq4mMW/lTmaIMTISW1/6T2BUmoUI51lI1s5CWLuAkXkVo1hq
        QXFuemqxUYERPGaT83M3MYJTs5bbDsYpbz/oHWJk4mA8xCjBwawkwit71j5JiDclsbIqtSg/
        vqg0J7X4EKMp0MMTmaVEk/OB2SGvJN7QxNLAxMzM0NzI1MBcSZzXK2VDopBAemJJanZqakFq
        EUwfEwenVANT8SPd/vvnGiYfSV8UIqD0/snco60XVt32vLC4y+rKSfbJLwRafNPeFt8OUvsf
        03Lijnj6dO1asfCiY3XLJkgJpc708PJUKvP/lcP9t4ohdfvVcCHtt58ZXidVvrlzZO0KowfX
        /r0JWNgwq7qTzbhLwc7ov2SLtvKFPMVfK58b3u1kTvzsPK/vTPb6lZtOvBE9e+qd6vnTkxf0
        zOT1mHtvtbBEpEQfK8fZPazMLveu7Dr57v1up8ehgXu62GtCdus+Vd19LbDw7FtjhtzKfc22
        nkW7Hi7eefPE5H+O/c+nvN/z2rt3TiinzDbvEI/Il/OThWf3Zi10y1Z4ceH//+o7r7KKrmo3
        7/pe/0z2lt4DNyWW4oxEQy3mouJEAM2QofZWBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220328084319epcms2p3670d7836bb111e0d9c648aeebfde8603
References: <CGME20220328084319epcms2p3670d7836bb111e0d9c648aeebfde8603@epcms2p3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
and PCIe phy is designed based on SAMSUNG PHY.

Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
---
 .../bindings/phy/axis,artpec8-pcie-phy.yaml        | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml
new file mode 100644
index 0000000..f5f4166
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/axis,artpec8-pcie-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARTPEC-8 SoC PCIe PHY Device Tree Bindings
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
+  clocks:
+    items:
+      - description: PCIe PHY reference clock
+
+  clock-names:
+    items:
+      - const: ref_clk
+
+required:
+  - compatible
+  - "#phy-cells"
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - samsung,fsys-sysreg
+  - num-lanes
+
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    artec8 {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pcie_phy: pcie-phy@16c80000 {
+            compatible = "samsung,artpec8-pcie-phy";
+            #phy-cells = <0>;
+            reg = <0x0 0x16c80000 0x0 0x2000>,
+                    <0x0 0x16c90000 0x0 0x1000>;
+            reg-names = "phy", "pcs";
+            clocks = <&clock_cmu_fsys 53>;
+            clock-names = "ref_clk";
+            samsung,fsys-sysreg = <&syscon_fsys>;
+            num-lanes = <2>;
+        };
+    };
+...
-- 
2.9.5
