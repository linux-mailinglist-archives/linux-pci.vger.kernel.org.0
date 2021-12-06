Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B04D46A5DF
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 20:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244293AbhLFTri (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 14:47:38 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:34577 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239791AbhLFTri (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 14:47:38 -0500
Received: by mail-ot1-f42.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso15072810otj.1;
        Mon, 06 Dec 2021 11:44:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OV4V5cyyfp1d5JWGFe/iPBsQ41nRRI65xNtRWHtdygo=;
        b=XtagYp0etFwKKStp+iKM33U/+sZl3DUhL0d/VN8F8vrgUkKi8zPfjjsFwqHsCtMI+I
         yG7k3+KDDkdPqP5AgbipqlK6RkbZP8OS4ns5n8rfu/K+do9TRvYfQWGlYdR0KK5xaBMW
         cpO/K8VEiIhPfbNSST9JGWhA1sGq+k5/SDJ6Xj9HTExKL11w8CipixKxp2EV1AXejAeI
         jH0NAxHrUE+JXJ81Jav6Ex4OUZ9xXH2JYIfcWGv5JTiyzHOqBDgrKfWcsgaPY+yMyc4A
         mp6zQtPh+K2AoJOyUv8i5ZJhZW2k9wvuB9nreCf/Udn91djy0/1epprZWhA0u4cr8k3t
         uAYg==
X-Gm-Message-State: AOAM531RG5cXJzZRK1C9PYakXrkmr234ozPwOtKHeDlMw6R7+BQ5wU7F
        3uXva9+iq3V/57TDgqL3ReXOeyUBzQ==
X-Google-Smtp-Source: ABdhPJwi4XEJy59m8vu3H7Fv79SUAhYZeBX8Nof8y9Mu60hPozLl0q+Nd+PTyUE+N+3I89DX4D0Azw==
X-Received: by 2002:a05:6830:2019:: with SMTP id e25mr32350823otp.96.1638819848480;
        Mon, 06 Dec 2021 11:44:08 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id g17sm2876640oiy.14.2021.12.06.11.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 11:44:08 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: Fix 'unevaluatedProperties' warnings
Date:   Mon,  6 Dec 2021 13:44:05 -0600
Message-Id: <20211206194406.2469361-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With 'unevaluatedProperties' support implemented, there's several
warnings due to undocumented properties:

Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.example.dt.yaml: pcie@1e140000: pcie@0,0: Unevaluated properties are not allowed ('phy-names' was unexpected)
Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.example.dt.yaml: pcie@1e140000: pcie@1,0: Unevaluated properties are not allowed ('phy-names' was unexpected)
Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.example.dt.yaml: pcie@1e140000: pcie@2,0: Unevaluated properties are not allowed ('phy-names' was unexpected)
Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.example.dt.yaml: pcie@11230000: Unevaluated properties are not allowed ('phy-names' was unexpected)
Documentation/devicetree/bindings/pci/microchip,pcie-host.example.dt.yaml: pcie@2030000000: Unevaluated properties are not allowed ('interrupt-controller' was unexpected)
Documentation/devicetree/bindings/pci/ti,am65-pci-ep.example.dt.yaml: pcie-ep@5500000: Unevaluated properties are not allowed ('num-ib-windows', 'num-ob-windows' were unexpected)
Documentation/devicetree/bindings/pci/ti,am65-pci-host.example.dt.yaml: pcie@5500000: Unevaluated properties are not allowed ('num-viewport', 'interrupts' were unexpected)
Documentation/devicetree/bindings/pci/ti,j721e-pci-host.example.dt.yaml: pcie@2900000: Unevaluated properties are not allowed ('dma-coherent' was unexpected)

Add the necessary property definitions or remove the properties from the
examples to fix these warnings.

Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Jianjun Wang <jianjun.wang@mediatek.com>
Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Daire McNamara <daire.mcnamara@microchip.com>
Cc: Abraham I <kishon@ti.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pci/mediatek,mt7621-pcie.yaml     |  3 +++
 .../bindings/pci/mediatek-pcie-gen3.yaml       |  4 ++++
 .../bindings/pci/microchip,pcie-host.yaml      | 18 ++++++++++++++++++
 .../bindings/pci/ti,am65-pci-ep.yaml           |  2 --
 .../bindings/pci/ti,am65-pci-host.yaml         |  4 +++-
 .../bindings/pci/ti,j721e-pci-host.yaml        |  2 ++
 6 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
index 044fa967bc8b..d60f43fd9c5a 100644
--- a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
@@ -45,6 +45,9 @@ patternProperties:
       phys:
         maxItems: 1
 
+      phy-names:
+        pattern: '^pcie-phy[0-2]$'
+
     required:
       - "#interrupt-cells"
       - interrupt-map-mask
diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index 742206dbd965..0499b94627ae 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -95,6 +95,10 @@ properties:
   phys:
     maxItems: 1
 
+  phy-names:
+    items:
+      - const: pcie-phy
+
   '#interrupt-cells':
     const: 1
 
diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
index 7b0776457178..edb4f81253c8 100644
--- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
@@ -46,6 +46,24 @@ properties:
   msi-parent:
     description: MSI controller the device is capable of using.
 
+  interrupt-controller:
+    type: object
+    properties:
+      '#address-cells':
+        const: 0
+
+      '#interrupt-cells':
+        const: 1
+
+      interrupt-controller: true
+
+    required:
+      - '#address-cells'
+      - '#interrupt-cells'
+      - interrupt-controller
+
+    additionalProperties: false
+
 required:
   - reg
   - reg-names
diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
index 78c217d362a7..a6896cb40e83 100644
--- a/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
@@ -66,8 +66,6 @@ examples:
         reg-names = "app", "dbics", "addr_space", "atu";
         power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
         ti,syscon-pcie-mode = <&pcie0_mode>;
-        num-ib-windows = <16>;
-        num-ob-windows = <16>;
         max-link-speed = <2>;
         dma-coherent;
         interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
index 834dc1c1743c..eabe1635e336 100644
--- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
@@ -29,6 +29,9 @@ properties:
       - const: config
       - const: atu
 
+  interrupts:
+    maxItems: 1
+
   power-domains:
     maxItems: 1
 
@@ -87,7 +90,6 @@ examples:
         ti,syscon-pcie-id = <&pcie_devid>;
         ti,syscon-pcie-mode = <&pcie0_mode>;
         bus-range = <0x0 0xff>;
-        num-viewport = <16>;
         max-link-speed = <2>;
         dma-coherent;
         interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index cc900202df29..2115d5a3f0e1 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -60,6 +60,8 @@ properties:
       - const: fck
       - const: pcie_refclk
 
+  dma-coherent: true
+
   vendor-id:
     const: 0x104c
 
-- 
2.32.0

