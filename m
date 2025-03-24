Return-Path: <linux-pci+bounces-24521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5563FA6DA5A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 13:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A461894250
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 12:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E4325F966;
	Mon, 24 Mar 2025 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k9KC7duf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B4A25EFAD
	for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820730; cv=none; b=rw1T371seoXExQydNc8TVctrrJV5k5bvKFzPnXQVhXh6k2zGWg3TlVJuq6H9njh91n2KtwoDVpbL0nd9806zcq52iBA4tSLXcKc+/QD9OtkQQajQcHtS1GOUxzUz4/86QoOvwXqcQaJqxDn9gO/goqVIsdz9exeXpPmxChozTTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820730; c=relaxed/simple;
	bh=l6XNwYZzVEyldu2L1XIJIXB2rpGx7TM2hQ0ZGfc6Tuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pr9BNUfn67+Nh8rs8nsiH8I5RySwf2e4yGbWeluFRiTIksO/PCUnr/A6RGXI/Hdmk8OmUL/LgPqg5w/InZnml2yIsrYdfImtA7IfDX1M4sbVqQCgLcBq9O3UD89ad2o4qsVwcNdfT6kTpMAbN523mZTz+NGz/s9PRYsG92I3lHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k9KC7duf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4394944f161so4663175e9.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742820727; x=1743425527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R1A1Q+2wy4k15GAqSgjm67tMHvqg/xX+3SaoiedBFQQ=;
        b=k9KC7dufYGFRCJ6vaAMkOIt0ttqorW7Z284uq57SAw8K38d0yJu0aPuG1xdPaOcl6Z
         r6BnImYOAhfa7T3/qVg8Thz3/7cY6v6SIINDD41ryWqB1OAm6oyX17AuTBJiDRZdO3yr
         tuRFFa/hRcjsrfBpdVYAnKtAGcrEYKqpa46eeHw/UsajoisfHteG3qz1uYWrqL5yzIby
         +KnItX2WXctPzOiS68K04FQRFg1Sfl1o7ZJ1Faoyg7AcalKOaQXBeWrCS1IJyyaLDYGO
         Aq2Ut3eTUrTw8J22rLP2hb/cQ/Uw3FRATD4VXu8BvPQ5FZtAHCDWh490oOTwjCFqu5Fu
         DVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742820727; x=1743425527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1A1Q+2wy4k15GAqSgjm67tMHvqg/xX+3SaoiedBFQQ=;
        b=rkb34E1lpIcPZujsygtFXr6/CDWdBPV9xW/np8+1WHxZ+IzKs9W1ZOnLkMQzErQ/vT
         mKAkKC8RMHqbgXLYS7/p4bDXV4lr3DwBg7uJ9Vz7WcuCql/+zR3SYHgS9RTePGMbVx+O
         kGz/bpRF3qiLZPp6A9aZW5if8JSVBuLLZ2vamycbSgDk7eFTA1lTJ+xA0gRa9afXsKc1
         bw2NSMdNQ0N2CNIokY+9FMFg8Cy5jFX57RF1VOs+wneOVGINIWTVq+As/nixyCzeZYBh
         nsKJRZEjqyAY3VGkz/BT9fiU7XwtIxAof4T8Lp7c6XE3ZOQSh3guEe2ePBYGVDPuVDDp
         402g==
X-Forwarded-Encrypted: i=1; AJvYcCVMUqpvHXlOnUfOuGrY7otGqnVUlRNuTLS+J+z4eagul7sdxEBR0eEPTONdqRqnzhgySr6oqikjBvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf4pRAxgO45DpEs9dn1mt4mlSohg1hNyWZGhZ8/dqvh6ilquhp
	s4qnPv2hecSvkePORhxSR5ag4bAdOqTLhEtyQRCaBKLEgRHoimM6nksbgVgj7o8=
X-Gm-Gg: ASbGncvUUQ/JDe/SFXu3otbSPUztZzmzLYRiqulTxm+7wnDyxrFT9JXuIYI/H6+IaAc
	yLvSttETC2gCritY+G3L0AsYqGiBg8RblRqvZic8KVWglqfrRy04yhdbtqoZ5KfqvsV1osKkl2c
	to5HEvmn9jcC3a4P+tl1Qhwcl5CKTs2hjW6X8E4s9vkckOC5B+/1RNkTBWwBJ7+i6xOt53D7Jk8
	mYZEBb1S9Nyd3abLwYidqFCuaOR2XCEdaV8qmuQEYl2PpA9QnAneqqnf1qWnBMExkoUg2JPFMGw
	aia+lznmNz1ZMWAWi5SOCAkLj1RyoNGO/ZuZNG+cRhxKxbaNIZ3Xn12oMg==
X-Google-Smtp-Source: AGHT+IGp6OoK+LL772bza4xOXI8JB/t2slrk7Xmti+PTEuocNjBZEmHgZtjGi4JTILsctkK+qOrR9Q==
X-Received: by 2002:a05:600c:b8b:b0:439:a1ce:5669 with SMTP id 5b1f17b1804b1-43d50a521f6mr48781635e9.5.1742820726497;
        Mon, 24 Mar 2025 05:52:06 -0700 (PDT)
Received: from krzk-bin.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd2704bsm118704565e9.18.2025.03.24.05.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:52:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Tom Joseph <tjoseph@cadence.com>,
	Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: PCI: Correct indentation and style in DTS example
Date: Mon, 24 Mar 2025 13:52:01 +0100
Message-ID: <20250324125202.81986-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DTS example in the bindings should be indented with 2- or 4-spaces and
aligned with opening '- |', so correct any differences like 3-spaces or
mixtures 2- and 4-spaces in one binding.

No functional changes here, but saves some comments during reviews of
new patches built on existing code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pci/brcm,stb-pcie.yaml           |  81 +++++++------
 .../bindings/pci/cdns,cdns-pcie-ep.yaml       |  16 +--
 .../bindings/pci/intel,keembay-pcie-ep.yaml   |  26 ++--
 .../bindings/pci/intel,keembay-pcie.yaml      |  38 +++---
 .../bindings/pci/microchip,pcie-host.yaml     |  54 ++++-----
 .../devicetree/bindings/pci/rcar-pci-ep.yaml  |  34 +++---
 .../bindings/pci/rcar-pci-host.yaml           |  46 +++----
 .../bindings/pci/xilinx-versal-cpm.yaml       | 112 +++++++++---------
 8 files changed, 202 insertions(+), 205 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 29f0e1eb5096..c4f9674e8695 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -186,49 +186,48 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     scb {
-            #address-cells = <2>;
-            #size-cells = <1>;
-            pcie0: pcie@7d500000 {
-                    compatible = "brcm,bcm2711-pcie";
-                    reg = <0x0 0x7d500000 0x9310>;
-                    device_type = "pci";
-                    #address-cells = <3>;
-                    #size-cells = <2>;
-                    #interrupt-cells = <1>;
-                    interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-                                 <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
-                    interrupt-names = "pcie", "msi";
-                    interrupt-map-mask = <0x0 0x0 0x0 0x7>;
-                    interrupt-map = <0 0 0 1 &gicv2 GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH
-                                     0 0 0 2 &gicv2 GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH
-                                     0 0 0 3 &gicv2 GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH
-                                     0 0 0 4 &gicv2 GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <2>;
+        #size-cells = <1>;
+        pcie0: pcie@7d500000 {
+            compatible = "brcm,bcm2711-pcie";
+            reg = <0x0 0x7d500000 0x9310>;
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            #interrupt-cells = <1>;
+            interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "pcie", "msi";
+            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+            interrupt-map = <0 0 0 1 &gicv2 GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH
+                             0 0 0 2 &gicv2 GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH
+                             0 0 0 3 &gicv2 GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH
+                             0 0 0 4 &gicv2 GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 
-                    msi-parent = <&pcie0>;
-                    msi-controller;
-                    ranges = <0x02000000 0x0 0xf8000000 0x6 0x00000000 0x0 0x04000000>;
-                    dma-ranges = <0x42000000 0x1 0x00000000 0x0 0x40000000 0x0 0x80000000>,
-                                 <0x42000000 0x1 0x80000000 0x3 0x00000000 0x0 0x80000000>;
-                    brcm,enable-ssc;
-                    brcm,scb-sizes =  <0x0000000080000000 0x0000000080000000>;
+            msi-parent = <&pcie0>;
+            msi-controller;
+            ranges = <0x02000000 0x0 0xf8000000 0x6 0x00000000 0x0 0x04000000>;
+            dma-ranges = <0x42000000 0x1 0x00000000 0x0 0x40000000 0x0 0x80000000>,
+                         <0x42000000 0x1 0x80000000 0x3 0x00000000 0x0 0x80000000>;
+            brcm,enable-ssc;
+            brcm,scb-sizes =  <0x0000000080000000 0x0000000080000000>;
 
-                    /* PCIe bridge, Root Port */
-                    pci@0,0 {
-                            #address-cells = <3>;
-                            #size-cells = <2>;
-                            reg = <0x0 0x0 0x0 0x0 0x0>;
-                            compatible = "pciclass,0604";
-                            device_type = "pci";
-                            vpcie3v3-supply = <&vreg7>;
-                            ranges;
+            /* PCIe bridge, Root Port */
+            pci@0,0 {
+                #address-cells = <3>;
+                #size-cells = <2>;
+                reg = <0x0 0x0 0x0 0x0 0x0>;
+                compatible = "pciclass,0604";
+                device_type = "pci";
+                vpcie3v3-supply = <&vreg7>;
+                ranges;
 
-                            /* PCIe endpoint */
-                            pci-ep@0,0 {
-                                    assigned-addresses =
-                                        <0x82010000 0x0 0xf8000000 0x6 0x00000000 0x0 0x2000>;
-                                    reg = <0x0 0x0 0x0 0x0 0x0>;
-                                    compatible = "pci14e4,1688";
-                            };
-                    };
+                /* PCIe endpoint */
+                pci-ep@0,0 {
+                    assigned-addresses = <0x82010000 0x0 0xf8000000 0x6 0x00000000 0x0 0x2000>;
+                    reg = <0x0 0x0 0x0 0x0 0x0>;
+                    compatible = "pci14e4,1688";
+                };
             };
+        };
     };
diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
index 98651ab22103..8735293962ee 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
@@ -37,14 +37,14 @@ examples:
         #size-cells = <2>;
 
         pcie-ep@fc000000 {
-                compatible = "cdns,cdns-pcie-ep";
-                reg = <0x0 0xfc000000 0x0 0x01000000>,
-                      <0x0 0x80000000 0x0 0x40000000>;
-                reg-names = "reg", "mem";
-                cdns,max-outbound-regions = <16>;
-                max-functions = /bits/ 8 <8>;
-                phys = <&pcie_phy0>;
-                phy-names = "pcie-phy";
+            compatible = "cdns,cdns-pcie-ep";
+            reg = <0x0 0xfc000000 0x0 0x01000000>,
+                  <0x0 0x80000000 0x0 0x40000000>;
+            reg-names = "reg", "mem";
+            cdns,max-outbound-regions = <16>;
+            max-functions = /bits/ 8 <8>;
+            phys = <&pcie_phy0>;
+            phy-names = "pcie-phy";
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
index 730e63fd7669..b19f61ae72fb 100644
--- a/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
@@ -53,17 +53,17 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     pcie-ep@37000000 {
-          compatible = "intel,keembay-pcie-ep";
-          reg = <0x37000000 0x00001000>,
-                <0x37100000 0x00001000>,
-                <0x37300000 0x00001000>,
-                <0x36000000 0x01000000>,
-                <0x37800000 0x00000200>;
-          reg-names = "dbi", "dbi2", "atu", "addr_space", "apb";
-          interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
-                       <GIC_SPI 108 IRQ_TYPE_EDGE_RISING>,
-                       <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
-                       <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
-          interrupt-names = "pcie", "pcie_ev", "pcie_err", "pcie_mem_access";
-          num-lanes = <2>;
+        compatible = "intel,keembay-pcie-ep";
+        reg = <0x37000000 0x00001000>,
+              <0x37100000 0x00001000>,
+              <0x37300000 0x00001000>,
+              <0x36000000 0x01000000>,
+              <0x37800000 0x00000200>;
+        reg-names = "dbi", "dbi2", "atu", "addr_space", "apb";
+        interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 108 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "pcie", "pcie_ev", "pcie_err", "pcie_mem_access";
+        num-lanes = <2>;
     };
diff --git a/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml b/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
index 1fd557504b10..dd71e3d6bf94 100644
--- a/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
@@ -75,23 +75,23 @@ examples:
     #define KEEM_BAY_A53_PCIE
     #define KEEM_BAY_A53_AUX_PCIE
     pcie@37000000 {
-          compatible = "intel,keembay-pcie";
-          reg = <0x37000000 0x00001000>,
-                <0x37300000 0x00001000>,
-                <0x36e00000 0x00200000>,
-                <0x37800000 0x00000200>;
-          reg-names = "dbi", "atu", "config", "apb";
-          #address-cells = <3>;
-          #size-cells = <2>;
-          device_type = "pci";
-          ranges = <0x02000000 0 0x36000000 0x36000000 0 0x00e00000>;
-          interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
-                       <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
-                       <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
-          interrupt-names = "pcie", "pcie_ev", "pcie_err";
-          clocks = <&scmi_clk KEEM_BAY_A53_PCIE>,
-                   <&scmi_clk KEEM_BAY_A53_AUX_PCIE>;
-          clock-names = "master", "aux";
-          reset-gpios = <&pca2 9 GPIO_ACTIVE_LOW>;
-          num-lanes = <2>;
+        compatible = "intel,keembay-pcie";
+        reg = <0x37000000 0x00001000>,
+              <0x37300000 0x00001000>,
+              <0x36e00000 0x00200000>,
+              <0x37800000 0x00000200>;
+        reg-names = "dbi", "atu", "config", "apb";
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+        ranges = <0x02000000 0 0x36000000 0x36000000 0 0x00e00000>;
+        interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "pcie", "pcie_ev", "pcie_err";
+        clocks = <&scmi_clk KEEM_BAY_A53_PCIE>,
+                 <&scmi_clk KEEM_BAY_A53_AUX_PCIE>;
+        clock-names = "master", "aux";
+        reset-gpios = <&pca2 9 GPIO_ACTIVE_LOW>;
+        num-lanes = <2>;
     };
diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
index 103574d18dbc..1aadfdee868f 100644
--- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
@@ -65,33 +65,33 @@ unevaluatedProperties: false
 examples:
   - |
     soc {
-            #address-cells = <2>;
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pcie0: pcie@2030000000 {
+            compatible = "microchip,pcie-host-1.0";
+            reg = <0x0 0x70000000 0x0 0x08000000>,
+                  <0x0 0x43008000 0x0 0x00002000>,
+                  <0x0 0x4300a000 0x0 0x00002000>;
+            reg-names = "cfg", "bridge", "ctrl";
+            device_type = "pci";
+            #address-cells = <3>;
             #size-cells = <2>;
-            pcie0: pcie@2030000000 {
-                    compatible = "microchip,pcie-host-1.0";
-                    reg = <0x0 0x70000000 0x0 0x08000000>,
-                          <0x0 0x43008000 0x0 0x00002000>,
-                          <0x0 0x4300a000 0x0 0x00002000>;
-                    reg-names = "cfg", "bridge", "ctrl";
-                    device_type = "pci";
-                    #address-cells = <3>;
-                    #size-cells = <2>;
-                    #interrupt-cells = <1>;
-                    interrupts = <119>;
-                    interrupt-map-mask = <0x0 0x0 0x0 0x7>;
-                    interrupt-map = <0 0 0 1 &pcie_intc0 0>,
-                                    <0 0 0 2 &pcie_intc0 1>,
-                                    <0 0 0 3 &pcie_intc0 2>,
-                                    <0 0 0 4 &pcie_intc0 3>;
-                    interrupt-parent = <&plic0>;
-                    msi-parent = <&pcie0>;
-                    msi-controller;
-                    bus-range = <0x00 0x7f>;
-                    ranges = <0x03000000 0x0 0x78000000 0x0 0x78000000 0x0 0x04000000>;
-                    pcie_intc0: interrupt-controller {
-                        #address-cells = <0>;
-                        #interrupt-cells = <1>;
-                        interrupt-controller;
-                    };
+            #interrupt-cells = <1>;
+            interrupts = <119>;
+            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+            interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+                            <0 0 0 2 &pcie_intc0 1>,
+                            <0 0 0 3 &pcie_intc0 2>,
+                            <0 0 0 4 &pcie_intc0 3>;
+            interrupt-parent = <&plic0>;
+            msi-parent = <&pcie0>;
+            msi-controller;
+            bus-range = <0x00 0x7f>;
+            ranges = <0x03000000 0x0 0x78000000 0x0 0x78000000 0x0 0x04000000>;
+            pcie_intc0: interrupt-controller {
+                #address-cells = <0>;
+                #interrupt-cells = <1>;
+                interrupt-controller;
             };
+        };
     };
diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
index 32a3b7665ff5..6b91581c30ae 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
@@ -73,21 +73,21 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/power/r8a774c0-sysc.h>
 
-     pcie0_ep: pcie-ep@fe000000 {
-            compatible = "renesas,r8a774c0-pcie-ep",
-                         "renesas,rcar-gen3-pcie-ep";
-            reg = <0xfe000000 0x80000>,
-                  <0xfe100000 0x100000>,
-                  <0xfe200000 0x200000>,
-                  <0x30000000 0x8000000>,
-                  <0x38000000 0x8000000>;
-            reg-names = "apb-base", "memory0", "memory1", "memory2", "memory3";
-            interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
-            resets = <&cpg 319>;
-            power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
-            clocks = <&cpg CPG_MOD 319>;
-            clock-names = "pcie";
-            max-functions = /bits/ 8 <1>;
+    pcie0_ep: pcie-ep@fe000000 {
+        compatible = "renesas,r8a774c0-pcie-ep",
+                     "renesas,rcar-gen3-pcie-ep";
+        reg = <0xfe000000 0x80000>,
+              <0xfe100000 0x100000>,
+              <0xfe200000 0x200000>,
+              <0x30000000 0x8000000>,
+              <0x38000000 0x8000000>;
+        reg-names = "apb-base", "memory0", "memory1", "memory2", "memory3";
+        interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+        resets = <&cpg 319>;
+        power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+        clocks = <&cpg CPG_MOD 319>;
+        clock-names = "pcie";
+        max-functions = /bits/ 8 <1>;
     };
diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
index 666f013e3af8..7896576920aa 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
@@ -113,27 +113,27 @@ examples:
         pcie: pcie@fe000000 {
             compatible = "renesas,pcie-r8a7791", "renesas,pcie-rcar-gen2";
             reg = <0 0xfe000000 0 0x80000>;
-             #address-cells = <3>;
-             #size-cells = <2>;
-             bus-range = <0x00 0xff>;
-             device_type = "pci";
-             ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000>,
-                      <0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000>,
-                      <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>,
-                      <0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
-             dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>,
-                          <0x42000000 2 0x00000000 2 0x00000000 0 0x40000000>;
-             interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
-                          <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
-                          <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
-             #interrupt-cells = <1>;
-             interrupt-map-mask = <0 0 0 0>;
-             interrupt-map = <0 0 0 0 &gic GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
-             clocks = <&cpg CPG_MOD 319>, <&pcie_bus_clk>;
-             clock-names = "pcie", "pcie_bus";
-             power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
-             resets = <&cpg 319>;
-             vpcie3v3-supply = <&pcie_3v3>;
-             vpcie12v-supply = <&pcie_12v>;
-         };
+            #address-cells = <3>;
+            #size-cells = <2>;
+            bus-range = <0x00 0xff>;
+            device_type = "pci";
+            ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000>,
+                     <0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000>,
+                     <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>,
+                     <0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
+            dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>,
+                         <0x42000000 2 0x00000000 2 0x00000000 0 0x40000000>;
+            interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0>;
+            interrupt-map = <0 0 0 0 &gic GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cpg CPG_MOD 319>, <&pcie_bus_clk>;
+            clock-names = "pcie", "pcie_bus";
+            power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+            resets = <&cpg 319>;
+            vpcie3v3-supply = <&pcie_3v3>;
+            vpcie12v-supply = <&pcie_12v>;
+        };
     };
diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index d674a24c8ccc..9823456addea 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -76,64 +76,62 @@ unevaluatedProperties: false
 
 examples:
   - |
-
     versal {
-               #address-cells = <2>;
-               #size-cells = <2>;
-               cpm_pcie: pcie@fca10000 {
-                       compatible = "xlnx,versal-cpm-host-1.00";
-                       device_type = "pci";
-                       #address-cells = <3>;
-                       #interrupt-cells = <1>;
-                       #size-cells = <2>;
-                       interrupts = <0 72 4>;
-                       interrupt-parent = <&gic>;
-                       interrupt-map-mask = <0 0 0 7>;
-                       interrupt-map = <0 0 0 1 &pcie_intc_0 0>,
-                                       <0 0 0 2 &pcie_intc_0 1>,
-                                       <0 0 0 3 &pcie_intc_0 2>,
-                                       <0 0 0 4 &pcie_intc_0 3>;
-                       bus-range = <0x00 0xff>;
-                       ranges = <0x02000000 0x0 0xe0010000 0x0 0xe0010000 0x0 0x10000000>,
-                                <0x43000000 0x80 0x00000000 0x80 0x00000000 0x0 0x80000000>;
-                       msi-map = <0x0 &its_gic 0x0 0x10000>;
-                       reg = <0x0 0xfca10000 0x0 0x1000>,
-                             <0x6 0x00000000 0x0 0x10000000>;
-                       reg-names = "cpm_slcr", "cfg";
-                       pcie_intc_0: interrupt-controller {
-                               #address-cells = <0>;
-                               #interrupt-cells = <1>;
-                               interrupt-controller;
-                       };
-               };
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pcie@fca10000 {
+            compatible = "xlnx,versal-cpm-host-1.00";
+            device_type = "pci";
+            #address-cells = <3>;
+            #interrupt-cells = <1>;
+            #size-cells = <2>;
+            interrupts = <0 72 4>;
+            interrupt-parent = <&gic>;
+            interrupt-map-mask = <0 0 0 7>;
+            interrupt-map = <0 0 0 1 &pcie_intc_0 0>,
+                            <0 0 0 2 &pcie_intc_0 1>,
+                            <0 0 0 3 &pcie_intc_0 2>,
+                            <0 0 0 4 &pcie_intc_0 3>;
+            bus-range = <0x00 0xff>;
+            ranges = <0x02000000 0x0 0xe0010000 0x0 0xe0010000 0x0 0x10000000>,
+                     <0x43000000 0x80 0x00000000 0x80 0x00000000 0x0 0x80000000>;
+            msi-map = <0x0 &its_gic 0x0 0x10000>;
+            reg = <0x0 0xfca10000 0x0 0x1000>,
+                  <0x6 0x00000000 0x0 0x10000000>;
+            reg-names = "cpm_slcr", "cfg";
+            pcie_intc_0: interrupt-controller {
+                    #address-cells = <0>;
+                    #interrupt-cells = <1>;
+                    interrupt-controller;
+            };
+        };
 
-               cpm5_pcie: pcie@fcdd0000 {
-                       compatible = "xlnx,versal-cpm5-host";
-                       device_type = "pci";
-                       #address-cells = <3>;
-                       #interrupt-cells = <1>;
-                       #size-cells = <2>;
-                       interrupts = <0 72 4>;
-                       interrupt-parent = <&gic>;
-                       interrupt-map-mask = <0 0 0 7>;
-                       interrupt-map = <0 0 0 1 &pcie_intc_1 0>,
-                                       <0 0 0 2 &pcie_intc_1 1>,
-                                       <0 0 0 3 &pcie_intc_1 2>,
-                                       <0 0 0 4 &pcie_intc_1 3>;
-                       bus-range = <0x00 0xff>;
-                       ranges = <0x02000000 0x0 0xe0000000 0x0 0xe0000000 0x0 0x10000000>,
-                                <0x43000000 0x80 0x00000000 0x80 0x00000000 0x0 0x80000000>;
-                       msi-map = <0x0 &its_gic 0x0 0x10000>;
-                       reg = <0x00 0xfcdd0000 0x00 0x1000>,
-                             <0x06 0x00000000 0x00 0x1000000>,
-                             <0x00 0xfce20000 0x00 0x1000000>;
-                       reg-names = "cpm_slcr", "cfg", "cpm_csr";
-
-                       pcie_intc_1: interrupt-controller {
-                               #address-cells = <0>;
-                               #interrupt-cells = <1>;
-                               interrupt-controller;
-                       };
-               };
+        pcie@fcdd0000 {
+            compatible = "xlnx,versal-cpm5-host";
+            device_type = "pci";
+            #address-cells = <3>;
+            #interrupt-cells = <1>;
+            #size-cells = <2>;
+            interrupts = <0 72 4>;
+            interrupt-parent = <&gic>;
+            interrupt-map-mask = <0 0 0 7>;
+            interrupt-map = <0 0 0 1 &pcie_intc_1 0>,
+                            <0 0 0 2 &pcie_intc_1 1>,
+                            <0 0 0 3 &pcie_intc_1 2>,
+                            <0 0 0 4 &pcie_intc_1 3>;
+            bus-range = <0x00 0xff>;
+            ranges = <0x02000000 0x0 0xe0000000 0x0 0xe0000000 0x0 0x10000000>,
+                     <0x43000000 0x80 0x00000000 0x80 0x00000000 0x0 0x80000000>;
+            msi-map = <0x0 &its_gic 0x0 0x10000>;
+            reg = <0x00 0xfcdd0000 0x00 0x1000>,
+                  <0x06 0x00000000 0x00 0x1000000>,
+                  <0x00 0xfce20000 0x00 0x1000000>;
+            reg-names = "cpm_slcr", "cfg", "cpm_csr";
 
+            pcie_intc_1: interrupt-controller {
+                #address-cells = <0>;
+                #interrupt-cells = <1>;
+                interrupt-controller;
+            };
+        };
     };
-- 
2.43.0


