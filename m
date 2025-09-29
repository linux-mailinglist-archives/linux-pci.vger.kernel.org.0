Return-Path: <linux-pci+bounces-37193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1761BA9105
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 13:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082363AE6D1
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 11:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587D2301718;
	Mon, 29 Sep 2025 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYN+e98o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674153016FA
	for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145903; cv=none; b=L0GgfJhMpmHc42sYRNeZxhj26EGlBZaypGHhs2sLysTcsL/hJfbqPA2UVRdrRAYzB19kpUIgEtZHLn4//kgAGMFr/MNhRp9LdpZPDLdVhnlfQEnLV6H9a2z52u0n6/pCykkKfMHXpiEeiN06KxmwQiEOm9LaxseACCu107hxL1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145903; c=relaxed/simple;
	bh=JmJSN/YBNM+mDU5SsW6cP009KHpjO9jA4E3c7+XHHtg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4P8hLJZDCEXqkizECXRe57EZTuUT2YOLfY6wc5TNCVQFVkpqUPuvRQgLvQrU8pFfcRgW4oFFgp+wPdpIU8OTT9eoc26+rUwu2i+gooOwu9c4WHWvRUofP3Hr9nT1zXrg6Dm/m2V5+kAlmgTywEc+HkQIIYwSOVLepShX1mls6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYN+e98o; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e504975dbso8641695e9.1
        for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 04:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759145900; x=1759750700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0akVzwetHFuOLRrA1RBETtHcqSI0prdy+4IQvcPTIc=;
        b=DYN+e98oXyGkYzKeQVUq4kIMyWNoJyecT9cneTEE3SXYMgOpvNWiBzis72iZM3f0k8
         mWiwFqdiglEAvXt8g9s/IBWZF0Ycmctu/YLqhK1+53cyo5i/6BdwELSRsM7jUQt5ZWQT
         WAwLs+oSHnUdDyHwbRjuq58MzksfkKmTBIo7VOscH0FDAPzY6a21raZSpjYZp2x5Tvhw
         OoZI8TU8Bg+yhDRIOdVpIskGn+R0F3eNcytwxPrvL89gaAbHbA6CeZSkwNYn32req/+7
         y2aSAs2Cdh+1TOXrZ8S6AqwzR5ayPwmsPiH8NPAKPC/rq05G3i2PnHTCqkciZzITnUmA
         cPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145900; x=1759750700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0akVzwetHFuOLRrA1RBETtHcqSI0prdy+4IQvcPTIc=;
        b=rzZ/P7PbDLBDLZia51D6plH67z6I2gJK5ux8yYCIIAq2QgTRtmFEiM6uhXGjYQlA7g
         K+eHv21pxUh7I6LqT2jxzZSaq0aeNdez1r74Hg++QWT8K3GsJ2GR2Q2BgUbJROzVaFnM
         eb2rsLLK3BcjNFVnkNvUtZ+h2HJ7A98YXkHOg+Jn+qxMoeQWZT/EbsFj/phYaRLVkDlv
         MVDNVs3XRwDBtEs4SbSyDsREyi/VgtrHHnePHdpBgATzZVrqMiDbOQ8Vh9JhmW1mdX0q
         1vFyNnNrtig5HrlSre8imnoz3JoRSug1NwLvnsMFCaXQLlwo3y8giIKBCLMb/E39PDp3
         d42A==
X-Forwarded-Encrypted: i=1; AJvYcCUEGjU8Poic6sr0uVkSQgw2pfDqVu+xgTB0HNyFw3BUbV/UFmDo3fnp66WagghRo3VM9iLdNvOrI4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDqrPuuyOGPHWcA+rhi6u21FIW3ztXhp9J0dqBoEaX5sRCJd7I
	0WxD8Heh0IUZNgvZkLmeddSj7fJxBTgQNZb+Z09IiX3cedIa7s5ComMpMJtLsg==
X-Gm-Gg: ASbGncsGul9iy8iu0WhiZx9k+UaNyxt/RY+sZARe7wcvhPQskW3xn8YhPhWGXdsa5Ur
	xGI1RD8IJtA+Xd+Gymjyxz8RH1cIazsVQs+/Wld5V81072zdSYm4r8p4nN/BIYWJPE3c+l1Qntf
	/sj2Ta9qiKuIKfUIrwnT52DA3KiDOPXYj2c7/EsiokUdWhxbjcumiWW3hr5nwDG1GQxspnMb5EY
	kT6ptRlP8dsXHUJS7WrfMqsth3owHnWh+UrZLH4sKX91Rw1w+obmajY2KTtOMEzdRLtbh+y3fgZ
	HMU0y0LVchX92FGygRAf/ivZxqZFXR9feAPq8GDB8a0Xh5g1hrMiYrmL30miA/Drb/CcZ3FdzIs
	9ZI3iFlJYfi/zu4VN/mkMJJ3nNDQdGFZdw8bPxil8QUIAn5Q2i9ac0LAHRW4JSAIp3aSucRW0IX
	RD3Zx/og==
X-Google-Smtp-Source: AGHT+IHc2sldTrNgGF8rhPUi/DYc+1Z7wh5Q8HiRuvHW/nw/mJhTW80r4LIKdvY/BzwTBOCgANZI6A==
X-Received: by 2002:a05:600c:181c:b0:46d:996b:826f with SMTP id 5b1f17b1804b1-46e32a02d46mr117755925e9.25.1759145899467;
        Mon, 29 Sep 2025 04:38:19 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46e56f53596sm9502465e9.7.2025.09.29.04.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 04:38:19 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/5] dt-bindings: PCI: mediatek: Add support for Airoha AN7583
Date: Mon, 29 Sep 2025 13:38:02 +0200
Message-ID: <20250929113806.2484-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929113806.2484-1-ansuelsmth@gmail.com>
References: <20250929113806.2484-1-ansuelsmth@gmail.com>
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
index fca6cb20d18b..b91b13a0220c 100644
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
@@ -55,6 +56,17 @@ properties:
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
 
@@ -90,6 +102,45 @@ required:
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
@@ -106,6 +157,8 @@ allOf:
 
         power-domains: false
 
+        mediatek,pbus-csr: false
+
       required:
         - phys
         - phy-names
@@ -123,6 +176,8 @@ allOf:
 
         phy-names: false
 
+        mediatek,pbus-csr: false
+
       required:
         - power-domains
 
@@ -135,6 +190,8 @@ allOf:
         clocks:
           minItems: 6
 
+        mediatek,pbus-csr: false
+
       required:
         - power-domains
 
@@ -157,6 +214,8 @@ allOf:
 
         power-domain: false
 
+        mediatek,pbus-csr: false
+
 unevaluatedProperties: false
 
 examples:
@@ -316,3 +375,54 @@ examples:
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


