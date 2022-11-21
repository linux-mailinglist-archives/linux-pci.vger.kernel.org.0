Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBA16320EF
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 12:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiKULmL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 06:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiKULlw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 06:41:52 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624DF1F625
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 03:41:28 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221121114124epoutp0250c24dc04dd1d7782e69c513a06e2cd4~plr8yT6wK1350513505epoutp02s
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 11:41:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221121114124epoutp0250c24dc04dd1d7782e69c513a06e2cd4~plr8yT6wK1350513505epoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669030884;
        bh=cSHmDhjCJcXRdCB64KSC2RMtoqKGEgP+tJKJ6Eny1E8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WuQiamUZFrDn1nzFRON+itDHmtjx5iIOP1ryph+aXE4iFhKVCAkDKv9vuB2CRtMRy
         /oQhCDpozptJtAIVKk1VhblFPFSnRvKSLXsJuszo6djyVY9daURLN5ixsSfACUkCU/
         IvI/1ydMwFIx8F7Wtc/yVv6nAF33mnJ5vrsUvxtE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221121114124epcas5p4b84ca9062261d803fc3a6db9dda5e8c1~plr8IR4RY1510615106epcas5p4I;
        Mon, 21 Nov 2022 11:41:24 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NG57k46Xjz4x9Pv; Mon, 21 Nov
        2022 11:41:22 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.D4.56352.2E36B736; Mon, 21 Nov 2022 20:41:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221121104719epcas5p2f87febfba74a4ca6807b3095acf507d0~pk8uvGQtc1633716337epcas5p2u;
        Mon, 21 Nov 2022 10:47:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221121104719epsmtrp11863a397d22de0bcf2b74a8827f3141e~pk8uuGUbI2438624386epsmtrp1S;
        Mon, 21 Nov 2022 10:47:19 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-01-637b63e2d78b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.5B.14392.7375B736; Mon, 21 Nov 2022 19:47:19 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221121104716epsmtip1939538519be9bfffb3d07318ec139ca9~pk8rNwdSR1012210122epsmtip1_;
        Mon, 21 Nov 2022 10:47:16 +0000 (GMT)
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
Subject: [PATCH 1/6] dt-bindings: phy: Add PCIe PHY bindings for FSD
Date:   Mon, 21 Nov 2022 16:22:05 +0530
Message-Id: <20221121105210.68596-2-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221121105210.68596-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTe0xTVxjf6X30gqne8BgH5lhznVlgAemE7vDSRZl2c1nINEycE7v2piCl
        rb3Fx4gCii5rBHmqcaUjFsPADZUCltfKa1AQHI6OkGkQCFtgw+E6rJs8tkLL9t/vfN/v9/2+
        7zvnUJjPMBlEpal0rFYlVTKkN97YFRISNinLkkXUmjei9rkOHI0bG0m0VNzDR53mBj4amRni
        o8ozqWjY+jr6svsegc6abpJo6OcLJCqYnsBQzoUFAg03G0g0aOwlUWGNE0d5i3k4an9SA9BU
        6SSBvru9F11rmOejq0MWAp1r6+Yjo6UcoPyuU+jBbC2Bmh7asLeCJAvPi4Gkoi5TUlfzOSl5
        ONJKSqbsl3kSa/nXfIm5MltSUF8DJL2jd3iSP+uCE70PpMelslI5qxWyKplanqZSxDN79qbs
        TIkSR4jCRNHoTUaokmaw8UzCe4lhu9KUrsEZ4TGpMtMVSpRyHLNlW5xWnaljhalqThfPsBq5
        UhOpCeekGVymShGuYnUxooiIN6JcxMPpqcu5I4SmzPeE7XErLwf0rtcDLwrSkfDHpp/4euBN
        +dAtAPaPXybdBweAJfeLPBkngDnnS7E1yUKhk3An2gC05C17JOd48FKHFV9hkXQozH2qX1X4
        0Q4MPrsUs0LC6AoAJ0argR5QlC+dAPUziSscnN4M9bYqYgUL6Bio77PgbrdX4I1b7at1vOhY
        WGt6sGoG6XkKtvT/TrpJrjpnewk39oW/9tbz3TgIzlw878EKWG2+4hlBCZ3mSp4bb4ftdgO+
        0g9Gh8CbzVvc4ZdhWX/tKgWj18P8hSkPXQAtxjW8Cc4vtXr6DITGnmFPCxL4yPiNZ3UFADZP
        PiIKQfDV/y0qAKgBgayGy1CwXJRmq4o9/t+1ydQZdWD1dYfusYDJ8SfhnYBHgU4AKYzxE2Qf
        zJL5COTSk5+yWnWKNlPJcp0gyrXAIizIX6Z2fQ+VLkUUGR0RKRaLI6O3ikVMgMB0JVTmQyuk
        OjadZTWsdk3Ho7yCcnibHPXMUdPsztKBt+/80HL6g7Av9tlt308kHOp6PtHNqf2V2uv7qWuV
        L6wrejHQktb393Jl8bPX7ITGz3E4y17KTh/XLjuMJWFJiqV1+2z9VvZibHDF4sjk4kCoOFFc
        9fHdHQeKrdu/lRs2vH+C8FdU3c7bMWr5yHmoFBuTWXu2ffLHfjE7xIgO1nK4NCA5yjl42jzW
        39h00nQjN6Gs/J2BaKx6IRz3s8wOYv9UCV/9Lbbq3fy4ex9+1ph0JNnWfeRY20Yh/vilzbtC
        7gd0GLIb7LRs7ozhaP31QEUdZdP/cqtk2WBy7H4a161ISE6S/9Xy1TRImjtVvGFMcLfPzxHd
        LGBwLlUqCsW0nPRfYp8IXWYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJTtc8vDrZ4PpMQ4sD7w+yWDyYt43N
        4u+kY+wWhzZvZbe49vICu8WSpgyLy/u1LeYfOcdq0bx4PZvFhac9bBZ9Lx4yWzT0/Ga1uLxr
        DpvF2XnH2SwmrPrGYtHyp4XF4sCHVYwWT6Y8YrU4ujHYYtHWL+wWsy7sYLVo3XuE3WLejrmM
        Fr2Hay1uv1nHarHzzglmBymP378mMXos2FTqsWlVJ5vHnWt72DyeXJnO5LF/7hp2j81L6j36
        tqxi9Dh+YzuTx+dNcgFcUVw2Kak5mWWpRfp2CVwZ/xqvsRZMFa448XYPUwPjcb4uRk4OCQET
        id8TvrF2MXJxCAnsZpTo+NPNCpGQlPh8cR0ThC0ssfLfc3aIomYmiUdLVoMl2AS0JBq/djGD
        JEQEelgkZm+9A1bFLLCEUWLz3T1sXYwcHMICLhJdLwNAGlgEVCW6TiwH28ArYCXRdXIHC8QG
        eYnVGw4wg9icAtYS6xbfZgOxhYBq1t34wz6BkW8BI8MqRsnUguLc9NxiwwLDvNRyveLE3OLS
        vHS95PzcTYzg6NLS3MG4fdUHvUOMTByMhxglOJiVRHhFjlUmC/GmJFZWpRblxxeV5qQWH2KU
        5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cBU91LPkUmIRT70xzKhmqP8r9IiGJewGPw4
        dXfjvj45pyuGGjOYMvfLFbnZzdm7vmvhGvE91ya0rkxfLuZR2FmtoslnOP3K3acxn9oy2Nze
        RPNvCJ/Ctf/WyXLXP2Lz5ursz+B4WlLmo5JrpDDdubOlS8GeITeZ++yJ1d+jztr7fJOPZvqz
        Mjb1wlWeW0uXvk6OZF84Zdva73br106xb/507c1Bc5WFfD5M3yd+PdZa03bO5/+3DdWH5u1J
        9mr+fvq6k2rcJ++nPsGxa08/e1zCwpHEunVTgi4PZ+KnrbIRb3YqZ5x8O0F29f6fUcGP7Io0
        titlHG+4/bm9v/xbuMEfq7Pvvxd19DdP/rNBM4hfiaU4I9FQi7moOBEABQO/pB0DAAA=
X-CMS-MailID: 20221121104719epcas5p2f87febfba74a4ca6807b3095acf507d0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221121104719epcas5p2f87febfba74a4ca6807b3095acf507d0
References: <20221121105210.68596-1-shradha.t@samsung.com>
        <CGME20221121104719epcas5p2f87febfba74a4ca6807b3095acf507d0@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document the PCIe PHY device tree bindings for Tesla
FSD SoC

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 .../bindings/phy/phy-tesla-pcie.yaml          | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-tesla-pcie.yaml

diff --git a/Documentation/devicetree/bindings/phy/phy-tesla-pcie.yaml b/Documentation/devicetree/bindings/phy/phy-tesla-pcie.yaml
new file mode 100644
index 000000000000..8fa9a050af7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-tesla-pcie.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/phy-tesla-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tesla FSD SoC PCIe PHY
+
+maintainers:
+  - Shradha Todi <shradha.t@samsung.com>
+
+properties:
+  "#phy-cells":
+    const: 0
+
+  compatible:
+    enum:
+      - tesla,fsd-pcie-phy
+
+  reg:
+    minItems: 2
+    maxItems: 2
+
+  reg-names:
+    minItems: 2
+    maxItems: 2
+    items:
+      enum: [phy, pcs]
+    description: |
+      phy is the register access to PMA layer
+      pcs is the register access to PCS layer
+
+  phy-mode:
+    description: |
+      Defines the bifurcation mode of the PHY
+
+  tesla,pmureg-phandle:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: phandle for PMU system controller interface used to
+                 control PMU register bits for PCIe PHY
+
+  tesla,pcie-sysreg:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: phandle for system control registers, used to
+                 control phy signals at system level
+
+required:
+  - "#phy-cells"
+  - compatible
+  - reg
+  - reg-names
+  - phy-mode
+  - tesla,pmureg-phandle
+  - tesla,pcie-sysreg
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      pcie_phy0: pcie-phy@15080000 {
+        compatible = "tesla,fsd-pcie-phy";
+        #phy-cells = <0>;
+        reg = <0x0 0x15080000 0x0 0x2000>, <0x0 0x150A0000 0x0 0x1000>;
+        reg-names = "phy", "pcs";
+        tesla,pmureg-phandle = <&pmu_system_controller>;
+        tesla,pcie-sysreg = <&sysreg_fsys0>;
+        phy-mode = <0>;
+        status = "disabled";
+      };
+    };
+...
-- 
2.17.1

