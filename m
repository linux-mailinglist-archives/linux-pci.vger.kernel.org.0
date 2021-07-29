Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E173DA294
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 13:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbhG2L4h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 07:56:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231674AbhG2L4g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 07:56:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D04060EFD;
        Thu, 29 Jul 2021 11:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627559793;
        bh=ryrQ4aOwXNxknddn27PIiC1ii8cdXtd/lDw0nb6oBB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ldXMpoMPhxpVQ+917Ky1CoHd1LqIdRUfnu+sPh+A0jBtTiROt+/ZxyuzNOm66o2i8
         G3sa/HUDJWTSCgzmzIvY+cECrHG24KTHUCPD6ZlMWtNfxJk/kFH3z2yKxd7EiDGFom
         kMkvWuT5IMatCENy8+ZDxdWwz99JyD56ZSiHUtudmslW0VcJgG4KEtH2Y/fmyv83UD
         KDfJmy4FnEE7GOPS9jOZzEzWy7qnTGNjlTriFJyH4lAByG02OpCR7Ip6EN6vS0wrmS
         t378bizfLHBP2zX2zTDilH4zQVaygzTG1Vl/Izy6aNtCcyrJaLyWmmARgIVIEfrLn9
         9uLrZ5DbxQtJQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m94eN-004d20-Bs; Thu, 29 Jul 2021 13:56:31 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 3/5] dt-bindings: PCI: kirin: Add support for Kirin970
Date:   Thu, 29 Jul 2021 13:56:26 +0200
Message-Id: <2cf7bd80d0b54f7658a64febf79d3a36e70aba86.1627559126.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627559126.git.mchehab+huawei@kernel.org>
References: <cover.1627559126.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new compatible, plus the new bindings needed by
HiKey970 board.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../bindings/pci/hisilicon,kirin-pcie.yaml    | 61 ++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
index 90cab09e8d4b..bb0c3a081d68 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
@@ -24,11 +24,13 @@ properties:
     contains:
       enum:
         - hisilicon,kirin960-pcie
+        - hisilicon,kirin970-pcie
 
   reg:
     description: |
       Should contain dbi, apb, config registers location and length.
-      For HiKey960, it should also contain phy.
+      For HiKey960, it should also contain phy. All other devices
+      should use a separate phy driver.
     minItems: 3
     maxItems: 4
 
@@ -47,6 +49,7 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/clock/hi3660-clock.h>
+    #include <dt-bindings/clock/hi3670-clock.h>
 
     soc {
       #address-cells = <2>;
@@ -83,4 +86,60 @@ examples:
         clock-names = "pcie_phy_ref", "pcie_aux", "pcie_apb_phy",
                       "pcie_apb_sys", "pcie_aclk";
       };
+
+      pcie@f5000000 {
+        compatible = "hisilicon,kirin970-pcie";
+        reg = <0x0 0xf4000000 0x0 0x1000000>,
+              <0x0 0xfc180000 0x0 0x1000>,
+              <0x0 0xf5000000 0x0 0x2000>;
+        reg-names = "dbi", "apb", "config";
+        bus-range = <0x0  0x1>;
+        msi-parent = <&its_pcie>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+        phys = <&pcie_phy>;
+        ranges = <0x02000000 0x0 0x00000000
+                  0x0 0xf6000000
+                  0x0 0x02000000>;
+        num-lanes = <1>;
+        #interrupt-cells = <1>;
+        interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "msi";
+        interrupt-map-mask = <0 0 0 7>;
+        interrupt-map = <0x0 0 0 1 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+                        <0x0 0 0 2 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+                        <0x0 0 0 3 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+                        <0x0 0 0 4 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
+        pcie@4,0 { // Lane 4: M.2
+          reg = <0 0 0 0 0>;
+          compatible = "pciclass,0604";
+          device_type = "pci";
+          reset-gpios = <&gpio7 1 0>;
+          clkreq-gpios = <&gpio27 3 0 >;
+          #address-cells = <3>;
+          #size-cells = <2>;
+          ranges;
+        };
+        pcie@5,0 { // Lane 5: Mini PCIe
+          reg = <0 0 0 0 0>;
+          compatible = "pciclass,0604";
+          device_type = "pci";
+          reset-gpios = <&gpio7 2 0>;
+          clkreq-gpios = <&gpio17 0 0 >;
+          #address-cells = <3>;
+          #size-cells = <2>;
+          ranges;
+        };
+        pcie@7,0 { // Lane 7: Ethernet
+          reg = <0 0 0 0 0>;
+          compatible = "pciclass,0604";
+          device_type = "pci";
+          reset-gpios = <&gpio7 3 0>;
+          clkreq-gpios = <&gpio20 0 0 >;
+          #address-cells = <3>;
+          #size-cells = <2>;
+          ranges;
+        };
+      };
     };
-- 
2.31.1

