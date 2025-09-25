Return-Path: <linux-pci+bounces-36999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3624FBA0951
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 18:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF450387BA2
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 16:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9940E305E19;
	Thu, 25 Sep 2025 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uifd6ReT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8084F3081BC
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817434; cv=none; b=o/rO+xTbdzv5Kpj7OyWZ5aqfSMVsirBY3uMDReIMohJAw+Dq2E+bPzmsrfQkQC+dLXN1q3qevaP6GCA4Hg3NgiE6q3wL3Tl3DVnF1JUuCfXGc0G4DDltwG2XmyMHCKLiPVsZ0fXAUKv7vTRUCk1/2Enl8Bfe9EDxmHq06Mkv608=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817434; c=relaxed/simple;
	bh=wI2EgBAstfuh0Lwsj21CyJ/ou9l4B9diH54Sb1sikXo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeYHyAZycPxaDACgJfjse2TgXcEeq5/90ff/j2Lqzd2V+mHGNpa1TiQKATPKKkaQXJ8nOXhCUue7Bd96e1AN7J5Tik9T/fV0LUxsNGrHMIsCh8x7cg6j4uVuYy36wGAxM6atLArwDn3EK9BJ7kBEQfc/9XBZ/Mry6xnwQe94t8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uifd6ReT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so9359375e9.3
        for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 09:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758817431; x=1759422231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojrSKhmG/fxO+GWCa4ng/6S+zCuiK4Lwk2+N5nW6KeM=;
        b=Uifd6ReTOoiTKNi4QE0vkUHTl245ESxhb8Djo5pMbndfskumdfSYzrEuD2d5xFWfgb
         y+MwpvfgJPlGAyaSCjO9ciUdMaFhhQABZflnfctYSIYwni1DX7ryWsDbBRoxIXIa+4dr
         HZH8Wsy+x4WN8803jYttJug1ZJxAOoO9tOn4zAjYaUf3q8+lIytC7+CWl8lSGJqU+s7U
         CjCiqfQkN8z++hWxvxCq+/4ILveWEiAtUj6fqyClXvCDF2WVOKFSQmSSSVhGtS3yfF2F
         qZC4/Uyxi+LiiSAf/o9ka0jFeXQ+uhDIFOvEmn3n1MGu4nWRaAtxT19wWc37P0+lt4Xe
         p7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758817431; x=1759422231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojrSKhmG/fxO+GWCa4ng/6S+zCuiK4Lwk2+N5nW6KeM=;
        b=J5IUUIpfyYWrC+b2ymtHXdWquBNh9nXHsnSA9ovjeRPlvbDwaacKp6sa1dHQ2v00ki
         LPkISd9r9aLVxkFr6VCDeOcZoyJqf4CrqS3g91oi6xcPArxeN8FDoWjQsqOcFl6eYbc9
         GvFRWJujKChUoVHxMCXtzvJjIwwCqQgfx2NT+wPPKp88bp7XoREp2fe+nvX3aPudHlhc
         RfBTDlWdw6Rdwp6B7HrEmzhGegaLmNz4RLq58xdeB1jDpGv//BdgnnYb4WuqwofWUAHZ
         JhIzR9uvTZmBBy6aDWkDevOTiHGwH0kjfyDF7ipMnfj2wWHanbD8gjpnlcgOlg/qY4vA
         NXqA==
X-Forwarded-Encrypted: i=1; AJvYcCXmJ/sDRsMQy30TJp8YRk+bCzd5wN7j6uYJ9Cy+ncSBnmwnaksKN1xjGaKZATemGmR3OolvOrQF+9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh5AuKqydDL50xAecDksVPr0KUPBveOzmfRebQAoYjdY2feFHj
	guSmv5D20ZRkdhxM0zLocVqNBfXXAkppuOiXQCSQ968R+IiNnaKwVSnf
X-Gm-Gg: ASbGncvBTtSHhEJhKU3+iK+BfjAUGI41lVrrXN+wtNBeeXcPlBRvm09lHLKeLG6CQ+p
	+J3dlKVIIGyGXz4dB5S9VvKLRxawjjDT3QjJiJ2LU7OVtmP4Ge6QLi+0qrjLQa/rDo0uGDuPTTZ
	kqcBshC2LeEzzJRYfyTv4BO1tW+8tbF2fzmAj6L8CUo+4u1KCxNJiX2cdSRn0Noq8RsqG8Cps3j
	sW71MSWm8HV5Z9XaMpTQWuJDVEFe7ikKqNUyXyN4AEXwvBJ+QqqB1+1R7C5tisydm1UAfO6fBMt
	seYCz8ZcTIPQmnRehKcluvQUre+ehC0l0Msb5HY5ydptr7iczomLRdcLI+wA969aTxTiV0ok6XF
	m1W1FuCmhhdHr0+x68cz4a8MvQPfvvgvx/ZlHKtUDlf5IWQJM+xC4hsO7dMz2K8rQckLiXr4=
X-Google-Smtp-Source: AGHT+IGoQEBIl1V2qVvXVjckSIeQJSaJ6Q4rOdOHbSTXBeT0yFthNPrs3b6Al9NZzt3gqkVk7xB4/w==
X-Received: by 2002:a05:600c:5290:b0:46e:394b:4991 with SMTP id 5b1f17b1804b1-46e394b4b1emr10436875e9.11.1758817430492;
        Thu, 25 Sep 2025 09:23:50 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-40fb985e080sm3534819f8f.24.2025.09.25.09.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 09:23:50 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com
Subject: [PATCH v3 3/4] dt-bindings: PCI: mediatek: Add support for Airoha AN7583
Date: Thu, 25 Sep 2025 18:23:17 +0200
Message-ID: <20250925162332.9794-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925162332.9794-1-ansuelsmth@gmail.com>
References: <20250925162332.9794-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce Airoha AN7583 SoC compatible in mediatek PCIe controller
binding.

Similar to GEN3, the Airoha AN7583 GEN2 PCIe controller require the
PBUS csr property to permit the correct functionality of the PCIe
controller.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/pci/mediatek-pcie.yaml           | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
index e3afedb77a01..46000049a6c5 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - airoha,an7583-pcie
           - mediatek,mt2712-pcie
           - mediatek,mt7622-pcie
           - mediatek,mt7629-pcie
@@ -61,6 +62,17 @@ properties:
   power-domains:
     maxItems: 1
 
+  mediatek,pbus-csr:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to pbus-csr syscon
+          - description: offset of pbus-csr base address register
+          - description: offset of pbus-csr base address mask register
+    description:
+      Phandle with two arguments to the syscon node used to detect if
+      a given address is accessible on PCIe controller.
+
   '#interrupt-cells':
     const: 1
 
@@ -96,6 +108,45 @@ required:
 allOf:
   - $ref: /schemas/pci/pci-host-bridge.yaml#
 
+  - if:
+      properties:
+        compatible:
+          const: airoha,an7583-pcie
+    then:
+      properties:
+        reg:
+          maxItems: 1
+
+        reg-names:
+          const: port1
+
+        clocks:
+          maxItems: 1
+
+        clock-names:
+          const: sys_ck1
+
+        reset:
+          maxItems: 1
+
+        reset-names:
+          const: pcie-rst1
+
+        phys:
+          maxItems: 1
+
+        phy-names:
+          const: pcie-phy1
+
+        power-domain: false
+
+      required:
+        - resets
+        - reset-names
+        - phys
+        - phy-names
+        - mediatek,pbus-csr
+
   - if:
       properties:
         compatible:
@@ -131,6 +182,8 @@ allOf:
 
         power-domains: false
 
+        mediatek,pbus-csr: false
+
       required:
         - phys
         - phy-names
@@ -169,6 +222,8 @@ allOf:
 
         phy-names: false
 
+        mediatek,pbus-csr: false
+
       required:
         - power-domains
 
@@ -209,6 +264,8 @@ allOf:
           items:
             - enum: [ pcie-phy0, pcie-phy1 ]
 
+        mediatek,pbus-csr: false
+
       required:
         - power-domains
 
@@ -243,6 +300,8 @@ allOf:
 
         power-domain: false
 
+        mediatek,pbus-csr: false
+
 unevaluatedProperties: false
 
 examples:
@@ -402,3 +461,54 @@ examples:
             };
         };
     };
+
+  # AN7583
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/en7523-clk.h>
+
+    soc_3 {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@1fa92000 {
+            compatible = "airoha,an7583-pcie";
+            device_type = "pci";
+            linux,pci-domain = <1>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            reg = <0x0 0x1fa92000 0x0 0x1670>;
+            reg-names = "port1";
+
+            clocks = <&scuclk EN7523_CLK_PCIE>;
+            clock-names = "sys_ck1";
+
+            phys = <&pciephy>;
+            phy-names = "pcie-phy1";
+
+            ranges = <0x02000000 0 0x24000000 0x0 0x24000000 0 0x4000000>;
+
+            resets = <&scuclk>; /* AN7583_PCIE1_RST */
+            reset-names = "pcie-rst1";
+
+            mediatek,pbus-csr = <&pbus_csr 0x8 0xc>;
+
+            interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "pcie_irq";
+            bus-range = <0x00 0xff>;
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 7>;
+            interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+                            <0 0 0 2 &pcie_intc1 1>,
+                            <0 0 0 3 &pcie_intc1 2>,
+                            <0 0 0 4 &pcie_intc1 3>;
+
+            pcie_intc1_4: interrupt-controller {
+                interrupt-controller;
+                #address-cells = <0>;
+                #interrupt-cells = <1>;
+            };
+        };
+    };
-- 
2.51.0


