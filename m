Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CF44E8BEC
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 04:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbiC1CLe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Mar 2022 22:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbiC1CLd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Mar 2022 22:11:33 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889CD27CD6
        for <linux-pci@vger.kernel.org>; Sun, 27 Mar 2022 19:09:52 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220328020950epoutp019b6d67da7d8a6be7d31a3a425c608768~gaW9UdM442108221082epoutp01e
        for <linux-pci@vger.kernel.org>; Mon, 28 Mar 2022 02:09:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220328020950epoutp019b6d67da7d8a6be7d31a3a425c608768~gaW9UdM442108221082epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648433390;
        bh=iuokl0K2CXgMI3+fhXbeLGRi9Qj1Yz9sNan7oHp3dAw=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=mtP5kAbLg347WahyM+Y+kPpx/cF3eHSxLoHHl0Cju3hwLGnbOiPVj2Cd2f9aISRwD
         EPD7hu6cHoX54GeWTuWFV2io13ERQZ6Jzm0vcI1pwzE8NUxpcqh/kWFEvsGKZPtyx0
         gcAstpfJVKmJc927/AZNaQ1xucv53jY/5gZxmX20=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220328020949epcas2p319215359bf2ded2e0f388f51d12127bd~gaW8vvakI1241312413epcas2p3d;
        Mon, 28 Mar 2022 02:09:49 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.98]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KRbk44VTDz4x9Ps; Mon, 28 Mar
        2022 02:09:48 +0000 (GMT)
X-AuditID: b6c32a45-4fdff700000228cc-ef-624118eba8d9
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        3D.47.10444.BE811426; Mon, 28 Mar 2022 11:09:47 +0900 (KST)
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
Message-ID: <20220328020947epcms2p2525f40ac5157735063927aedfbf6fc4f@epcms2p2>
Date:   Mon, 28 Mar 2022 11:09:47 +0900
X-CMS-MailID: 20220328020947epcms2p2525f40ac5157735063927aedfbf6fc4f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmue5rCcckg5nHtS2WNGVYvDykaTH/
        yDlWi+eHZjFbfGpRtbjwtIfN4uWse2wWDT2/WS2OvPnIbLH/+Eomi8u75rBZnJ13nM1iwqpv
        LBZvfr9gtzi3ONOide8Rdoudd04wOwh6rJm3htHj+roAjwWbSj02repk83hyZTqTx+Yl9R59
        W1Yxehy/sZ3J4/MmuQDOqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTc
        VFslF58AXbfMHKAvlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV5
        6Xp5qSVWhgYGRqZAhQnZGWt/r2AuWC1c0fC0voHxCm8XIweHhICJxJlD8l2MXBxCAjsYJfa+
        +MMOEucVEJT4u0O4i5GTQ1jARuLP7tnMILaQgJLEjjXzmCHi1hKfplxmAbHZBCwlLrY+ZASZ
        IyJwlkni5t3trCAOs8BtZon5z9+DVUkI8ErMaH8KZUtLbF++lRHC1pD4sayXGcIWlbi5+i07
        jP3+2HyoGhGJ1ntnoWoEJR783A0Vl5JY8OQQK4RdLbH/728mCLuBUaL/firEk/oSO64bg4R5
        BXwl3i/bzgZiswioSpw/exHqHBeJ07tOg41kFpCX2P52DjNIK7OApsT6XfoQU5QljtyCe6Rh
        4292dDazAJ9Ex+G/cPEd855AHaMmMW/lTmaIMTISW1/6T2BUmoUI51lI1s5CWLuAkXkVo1hq
        QXFuemqxUYEhPGKT83M3MYITs5brDsbJbz/oHWJk4mA8xCjBwawkwit71j5JiDclsbIqtSg/
        vqg0J7X4EKMp0MMTmaVEk/OBuSGvJN7QxNLAxMzM0NzI1MBcSZzXK2VDopBAemJJanZqakFq
        EUwfEwenVAPT+Qev2+qmerg8vbnRpPHiJ9aJvlv2HAtMP5K76P5B3eiYMjXJW7tYZrYxlE67
        px2o1hxw1oz5ziKz4CjTqzc7n1f/2yQXJRpquDMurfLUcSbWoyply1V1X7IpffjWs2bJZOP1
        fdG8nP9EFy48t0Y5gbGj/v2HXU1vZkybO3/l+a7LXA+2tLcu+q8cw6nedUPz4uSFm4zc/a/d
        sA8vXTYlXbnUxmE+4xp368KVC+bzLlqR/sJl54/brPdmF2z4t2rqwcs9wn1185evfnRttdEq
        PocVL3rE8k68Pbl++e5tpmX3d62QmdfjZ31rvc7zR/8co/gm93MJPn32bfnLHf6+LfWT559h
        uii1g4+XUcT/pJISS3FGoqEWc1FxIgBgYiqxVQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220328020947epcms2p2525f40ac5157735063927aedfbf6fc4f
References: <CGME20220328020947epcms2p2525f40ac5157735063927aedfbf6fc4f@epcms2p2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
