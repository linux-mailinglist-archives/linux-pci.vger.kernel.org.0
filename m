Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E9430BFD1
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 14:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhBBNme (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 08:42:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:59600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232331AbhBBNb2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 08:31:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E564B64F69;
        Tue,  2 Feb 2021 13:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612272602;
        bh=sSaD7ZjZax5SWdJfL3lxHnmESoHHAqsZQp3tIpWjuII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FN6Lh7lwWo4uhRohZnqPfaAUvBwF98JO5/606yFydvSu5+xuMD5P9AaiSECToYLk5
         gGDh+13QvzOEkvwW+WWLRzJO5qUdibsgagO8c+PdcM4KUN987FP8sy9jH1s8m3TFTw
         U0402UsU9X4EXXVOkJ8oRPse99rWxZrAMGMnbr2KdOUBOtyjB+eXQnu2Osbl8PLO4s
         jIaJWoPwVc5YB4HCYEgOuxtGkc1SWu0Wt3JBR/bSwKoB7zR15bwdbxKqFyx1uNE5tU
         hswKvy7le8OPQeAIDiTOBWzFLd6HAUpGsSWxkMqNfFzyYiTbIqvxQj+TnXmwraBeC7
         Z5QwHTjxleQ4g==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l6vkl-0011yr-Gs; Tue, 02 Feb 2021 14:29:59 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 03/13] doc: bindings: add new parameters used by Hikey 970
Date:   Tue,  2 Feb 2021 14:29:48 +0100
Message-Id: <95dea944565d0a7ee5a35449c18c703dd005158c.1612271903.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612271903.git.mchehab+huawei@kernel.org>
References: <cover.1612271903.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are a few extra optional bindings that are
needed for Hikey 970 PCI to work. Add them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../bindings/pci/hisilicon,kirin-pcie.yaml    | 60 ++++++++++++++++++-
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
index 46f9f3f25dbc..7a58883e07ec 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
@@ -34,8 +34,18 @@ properties:
       - const: config       # PCIe configuration space registers
 
   reset-gpios:
-    description: The GPIO to generate PCIe PERST# assert and deassert signal.
-    maxItems: 1
+    description: The GPIOs to generate PCIe PERST# assert and deassert signal.
+    minItems: 1
+    maxItems: 4
+
+  clkreq-gpios:
+    description: CLKREQ signal GPIO pins to be enabled during PCI power on
+    minItems: 1
+    maxItems: 3
+
+  eye_param:
+    description: items to adjust the eye parameters
+    maxItems: 5
 
 required:
   - compatible
@@ -52,12 +62,13 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/clock/hi3660-clock.h>
+    #include <dt-bindings/clock/hi3670-clock.h>
 
     soc {
       #address-cells = <2>;
       #size-cells = <2>;
 
-      pcie: pcie@f4000000 {
+      pcie1: pcie@f4000000 {
         compatible = "hisilicon,kirin960-pcie";
         reg = <0x0 0xf4000000 0x0 0x1000>,
               <0x0 0xff3fe000 0x0 0x1000>,
@@ -87,4 +98,47 @@ examples:
                       "pcie_apb_sys", "pcie_aclk";
         reset-gpios = <&gpio11 1 0 >;
       };
+
+      pcie2: pcie@f5000000 {
+        compatible = "hisilicon,kirin970-pcie";
+        reg = <0x0 0xf4000000 0x0 0x1000000>,
+              <0x0 0xfc180000 0x0 0x1000>,
+              <0x0 0xfc000000 0x0 0x80000>,
+              <0x0 0xf5000000 0x0 0x2000>;
+        pci-supply = <&ldo33>;
+        reg-names = "dbi", "apb", "phy", "config";
+        bus-range = <0x0  0x1>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+        ranges = <0x02000000 0x0 0x00000000 0x0 0xf6000000 0x0 0x02000000>;
+        num-lanes = <1>;
+        #interrupt-cells = <1>;
+        interrupts = <0 283 4>;
+        interrupt-names = "msi";
+        interrupt-map-mask = <0 0 0 7>;
+        interrupt-map = <0x0 0 0 1 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+                        <0x0 0 0 2 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+                        <0x0 0 0 3 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+                        <0x0 0 0 4 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&crg_ctrl HI3670_CLK_GATE_PCIEPHY_REF>,
+                 <&crg_ctrl HI3670_CLK_GATE_PCIEAUX>,
+                 <&crg_ctrl HI3670_PCLK_GATE_PCIE_PHY>,
+                 <&crg_ctrl HI3670_PCLK_GATE_PCIE_SYS>,
+                 <&crg_ctrl HI3670_ACLK_GATE_PCIE>;
+
+        clock-names = "pcie_phy_ref", "pcie_aux",
+                      "pcie_apb_phy", "pcie_apb_sys",
+                      "pcie_aclk";
+        reset-gpios = <&gpio7 0 0 >, <&gpio25 2 0 >,
+                      <&gpio3 1 0 >, <&gpio27 4 0 >;
+
+        clkreq-gpios = <&gpio20 6 0 >, <&gpio27 3 0 >, <&gpio17 0 0 >;
+
+        /* vboost iboost pre post main */
+        eye_param = <0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF>;
+        msi-parent = <&its_pcie>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pcie_clkreq_pmx_func &pcie_clkreq_cfg_func>;
+      };
     };
-- 
2.29.2

