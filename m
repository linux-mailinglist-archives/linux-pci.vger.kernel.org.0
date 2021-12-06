Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A568E46A5E5
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 20:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbhLFTr5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 14:47:57 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:45639 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245093AbhLFTr5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 14:47:57 -0500
Received: by mail-ot1-f41.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso14988003otf.12;
        Mon, 06 Dec 2021 11:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pOQ79x7j60T/Aoxgzg7Q/WKtgZBCeGXzkMDE3RqKJOo=;
        b=3QmNFG4nFCwHFK6G4lTDvKegPj4zwBJcSM1hEKvUamJ7PeAvlCe3G8Uan4BjTLgsKy
         TGNRDHO0ubulixJq7F1X+UOY6cmlL28/Kje4LxDKlAhT3B2UAXKLaEiLhCRvsPuC/tze
         L+TuUewqUDjauW0N0/AReitQS6SS19wU/vzcItnAYHa8EvgB2cwezSsoRNxl/kDuTfIy
         MG2dyXZ/IOD9vaXK1oKVeHUKp6K0IiHXkXC5tyX5ylOvIgSLem8hZe9PE3Z2uiRVcWeT
         aG04K0qSM8KzOKX0JbvNDVr31D9BMww6U5usbEjedh8tJ0Avm0ddESjBiQZkH9DMFPPQ
         2DMg==
X-Gm-Message-State: AOAM532gBskUq39NztkagaknjFju48m3qycKy6NUIAkFTFTpfgzsNmeT
        5RQ+PQLP8RxizAIprB4vJmyK5bK5XA==
X-Google-Smtp-Source: ABdhPJz52nzCgw/hwbjYAAgjDYBEG+KdXK5nF3jLcZY0sCOmKJpTkCzBrNtc47G1zyZLA2GWcVNmwg==
X-Received: by 2002:a9d:77d1:: with SMTP id w17mr30919009otl.329.1638819867943;
        Mon, 06 Dec 2021 11:44:27 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id o6sm2291382oou.41.2021.12.06.11.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 11:44:27 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: PCI: designware: Fix 'unevaluatedProperties' warnings
Date:   Mon,  6 Dec 2021 13:44:25 -0600
Message-Id: <20211206194426.2470080-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With 'unevaluatedProperties' support implemented, there's a number of
warnings from the Designware PCIe based bindings:

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dt.yaml: pcie@1ffc000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'device_type', 'bus-range', 'ranges', '#interrupt-cells', 'interrupt-map-mask', 'interrupt-map' were unexpected)
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dt.yaml: pcie@1ffc000: Unevaluated properties are not allowed ('clock-names' was unexpected)
Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dt.yaml: pcie@f4000000: Unevaluated properties are not allowed ('bus-range', '#address-cells', '#size-cells', 'device_type', 'ranges', 'num-lanes', '#interrupt-cells', 'interrupts', 'interrupt-names', 'interrupt-map-mask', 'interrupt-map', 'clocks', 'clock-names' were unexpected)
Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dt.yaml: pcie@f4000000: Unevaluated properties are not allowed ('clock-names' was unexpected)
Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dt.yaml: pcie@f5000000: Unevaluated properties are not allowed ('bus-range', '#address-cells', '#size-cells', 'device_type', 'phys', 'ranges', 'num-lanes', '#interrupt-cells', 'interrupts', 'interrupt-names', 'interrupt-map-mask', 'interrupt-map', 'reset-gpios', 'pcie@0,0' were unexpected)
Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dt.yaml: pcie@f5000000: Unevaluated properties are not allowed ('phys', 'hisilicon,clken-gpios' were unexpected)
Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dt.yaml: pcie@d0e00000: Unevaluated properties are not allowed ('device_type', '#address-cells', '#size-cells', 'linux,pci-domain', 'bus-range', '#interrupt-cells', 'interrupt-map-mask', 'interrupt-map' were unexpected)
Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dt.yaml: pcie@d0e00000: Unevaluated properties are not allowed ('resets', 'phys', 'phy-names', 'reset-assert-ms' were unexpected)
Documentation/devicetree/bindings/pci/rockchip-dw-pcie.example.dt.yaml: pcie@fe280000: Unevaluated properties are not allowed ('clock-names', 'msi-map', 'phys', 'phy-names', 'power-domains', 'resets', 'reset-names' were unexpected)
Documentation/devicetree/bindings/pci/samsung,exynos-pcie.example.dt.yaml: pcie@15700000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#interrupt-cells', 'device_type', 'bus-range', 'ranges', 'interrupt-map-mask', 'interrupt-map' were unexpected)
Documentation/devicetree/bindings/pci/samsung,exynos-pcie.example.dt.yaml: pcie@15700000: Unevaluated properties are not allowed ('clock-names', 'phys', 'vdd10-supply', 'vdd18-supply' were unexpected)
Documentation/devicetree/bindings/pci/sifive,fu740-pcie.example.dt.yaml: pcie@e00000000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#interrupt-cells', 'device_type', 'dma-coherent', 'bus-range', 'ranges', 'interrupts', 'interrupt-parent', 'interrupt-map-mask', 'interrupt-map', 'clock-names', 'clocks' were unexpected)
Documentation/devicetree/bindings/pci/sifive,fu740-pcie.example.dt.yaml: pcie@e00000000: Unevaluated properties are not allowed ('dma-coherent', 'clock-names', 'resets', 'pwren-gpios' were unexpected)
Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.example.dt.yaml: pcie-ep@66000000: Unevaluated properties are not allowed ('clock-names', 'clocks', 'reset-names', 'resets', 'phy-names', 'phys' were unexpected)
Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.example.dt.yaml: pcie@28400000: Unevaluated properties are not allowed ('clock-names' was unexpected)
Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.example.dt.yaml: pcie@28400000: Unevaluated properties are not allowed ('device_type', 'bus-range', 'num-viewport', '#address-cells', '#size-cells', '#interrupt-cells', 'ranges', 'interrupt-names', 'interrupt-map-mask', 'interrupt-map', 'max-link-speed' were unexpected)

The main problem is that snps,dw-pcie.yaml and snps,dw-pcie-ep.yaml
shouldn't set 'unevaluatedProperties: false'. Otherwise, bindings that
reference them cannot add additional properties. With that addressed,
there's a handful of other undocumented properties to add.

Cc: Xiaowei Song <songxiaowei@hisilicon.com>
Cc: Binghui Wang <wangbinghui@hisilicon.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Greentime Hu <greentime.hu@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pci/hisilicon,kirin-pcie.yaml          | 13 +++++++++++++
 .../devicetree/bindings/pci/sifive,fu740-pcie.yaml  |  4 ++--
 .../devicetree/bindings/pci/snps,dw-pcie-ep.yaml    |  2 +-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml       |  2 +-
 .../bindings/pci/socionext,uniphier-pcie-ep.yaml    |  2 +-
 5 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
index cbee87802559..c9f04999c9cf 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
@@ -37,6 +37,19 @@ properties:
     minItems: 3
     maxItems: 4
 
+  clocks: true
+
+  clock-names:
+    items:
+      - const: pcie_phy_ref
+      - const: pcie_aux
+      - const: pcie_apb_phy
+      - const: pcie_apb_sys
+      - const: pcie_aclk
+
+  phys:
+    maxItems: 1
+
   hisilicon,clken-gpios:
     description: |
       Clock input enablement GPIOs from PCI devices like Ethernet, M.2 and
diff --git a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
index 2b9d1d6fc661..9215c6ee24a0 100644
--- a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
@@ -32,6 +32,8 @@ properties:
       - const: config
       - const: mgmt
 
+  dma-coherent: true
+
   num-lanes:
     const: 8
 
@@ -64,7 +66,6 @@ required:
   - interrupt-parent
   - interrupt-map-mask
   - interrupt-map
-  - clock-names
   - clocks
   - resets
   - pwren-gpios
@@ -104,7 +105,6 @@ examples:
                             <0x0 0x0 0x0 0x2 &plic0 58>,
                             <0x0 0x0 0x0 0x3 &plic0 59>,
                             <0x0 0x0 0x0 0x4 &plic0 60>;
-            clock-names = "pcie_aux";
             clocks = <&prci PRCI_CLK_PCIE_AUX>;
             resets = <&prci 4>;
             pwren-gpios = <&gpio 5 0>;
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index b5935b1b153f..b3b544eaf5aa 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -73,7 +73,7 @@ required:
   - reg-names
   - compatible
 
-unevaluatedProperties: false
+additionalProperties: true
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 9ed0dfba7f89..a5345c494744 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -73,7 +73,7 @@ properties:
       does not specify it, the driver autodetects it.
     deprecated: true
 
-unevaluatedProperties: false
+additionalProperties: true
 
 required:
   - reg
diff --git a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
index 144cbcd60a1c..179ab0858482 100644
--- a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
@@ -79,7 +79,7 @@ required:
   - resets
   - reset-names
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.32.0

