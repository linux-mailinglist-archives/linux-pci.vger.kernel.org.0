Return-Path: <linux-pci+bounces-41512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 631B8C6A82E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 17:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 078D535568B
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 16:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C8231280F;
	Tue, 18 Nov 2025 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zWX4zB/1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2503D36B060
	for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481776; cv=none; b=QyBj+TRKc5O9vyfo/Q/CZ8tWbFHvaAFBLQzlpbSkYyCFRs+BEsSg8bDgBDl7NUhgf0+CcpB0XjpDtZ0c093gGTu2K5Tjg0ba1WaKgpsjnUVDogyHPaTTQPFaw8KZbHxp9jXr8kD8FD7bk+le3iR9q+7eo6097LgkEDvEo9xytbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481776; c=relaxed/simple;
	bh=jYvQElvsgNDRjssWl/7N9i2M5c/4dLl+Leh5yhSj/xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwXj0pMLe5FHzX3fAnqqoeISmpYW+IrcIxyKNUh9PTIEsrT6AHeScpNjk3SepBXw4PsjvAShegirvhycTiElBvc1IdIff/FLHgfK9ABP0lnAY79aCqLLDN08cBplBJ4ZG2cpv+MY/JeZihv4dulvy2lv7AvUjpgVaT3t+NpY9GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zWX4zB/1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477770019e4so60776925e9.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 08:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763481772; x=1764086572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8rPc1Q7Ab5RULv9WRwCkjVSvPd0FRyIZ5xigzgSXKw=;
        b=zWX4zB/19qQsKEhqkeFCGIYdBncr9/SAgOQnlopgGEatBAo+rG+EBepfwQD1yMDLLE
         EUmtNkSUVEPRrhqCW68ufSn3zRWK19aX9cI1kQWuNOVqESKCJysEBLpkJcseFwCilD5f
         Cw4qjyyWiJWeC+7l1NGLQhKclQuzupVAJXPIsa+a400QFAzkL9iYHeX/R/FHBNh4jFV1
         txXvVoxieQhXSj3nUvPLS7Jy2U6hJZLwC0T0qHtJZxDq/NdiHxKmrnhMsH+yfXxM9B0C
         oC7C354Yj+XGWYuV9ejBJyTFSQfY8+7ks3sd22pI7nD/fai6liiAyhWLOhKdSU/ziHwO
         LhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763481772; x=1764086572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p8rPc1Q7Ab5RULv9WRwCkjVSvPd0FRyIZ5xigzgSXKw=;
        b=JSXTmYZRNPOCDfMaDxPKLk8zgE60hprnJx2ZpR6asr/GhwIj2RtmLW6/2z5Hqc4uve
         UbF3cASvXmQdtaMsiXInvRW6ETFLe43jroyh4foF5hjn8zb+u9JJrDbSC7z23+IM1yUH
         ejBIgLXkRqsIUL5VpGXeX9ZNixvLIdU2yj2QM1VdPIkFIe5Qw+BOfMoTeXRw9lTOMDL8
         YOPWA23aKtvG7XP2IBTL5XK1ecSET7O0o46J3U1ipcK4JoZaKpbLFJUEKIk4yj+Hy/wj
         2cgBYCcjvrdWo8WJo5w/l9AuELjiswDDN6UMpnRh9BJVzWZczgaADQx6UOqkg9xEXQX/
         1wNA==
X-Forwarded-Encrypted: i=1; AJvYcCWF6WFFYe+4HesjVTQFbWmRZg95GCS9uiD9ya/jH6Cps/zI6ynJ2z0H3NLRzc5ChOEyA26SejsJ6Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3zOkOpM2nw6IIWZrjSvqnWvLj8fOHYrKby1yPFdZxSxrPty8M
	V6xAgpNopp79juFrHl+3CDsTP+7cpIOVN3tGdQkxwKJQAWUcFNYSCxElu9FjPcpWa+A=
X-Gm-Gg: ASbGncuYcMcb0rNoQ+MxzhK79+Oql/bZ5ONtSKWM2acFHXLNNC21bVX0YemiroF8YsN
	/K+VVJZFGRVyOzhJmIeplW0EY8T8K1R7tv83dNePkIGKSumpd5rKfby8KHxMEnQlmPboTX7kkmz
	pXyC/IDtd4QvPi/e3vnIj3oDauHOAPE7HBGNN+6w9w9/xROxfWxXupqptT+NWUCruFPbDbV3kso
	TZ21Qnp0WifrKW2UP58sPzFJnb0USAhLfaFJUzC8W93rbrC4B0IK75U4AbhFsLBaFg2E6DFiq9V
	EnlPna0Pkxdzmh8qNZbQvyz8WY9aOv2aGSO/t3wtYIT5/PONS8924OuyfUeHIlPQnGraMwNsM/T
	N2sFUyUteGo9Ke5b113uv4eqvZXoT1beEjVKvVpktWOUkLSggACL2yY9gte7J8aas5bcxQnoIS0
	IktZyJ1OqbwUICmrc0wk2/ZvXY69TL/A==
X-Google-Smtp-Source: AGHT+IGyFoEL3zw1qZUaHUanPoDmy73Ha3AJCkV4FBXZ7E2g6BEcYZMSw2TPVNtzaY+tvbRM02dGsQ==
X-Received: by 2002:a05:600c:3593:b0:477:557b:6917 with SMTP id 5b1f17b1804b1-4778fe4fdecmr170047065e9.18.1763481772373;
        Tue, 18 Nov 2025 08:02:52 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:76db:cf5c:2806:ec0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779fc42f25sm171954575e9.6.2025.11.18.08.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 08:02:48 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	s32@nxp.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com,
	Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Cc: cassel@kernel.org
Subject: [PATCH 1/4 v5] dt-bindings: PCI: s32g: Add NXP PCIe controller
Date: Tue, 18 Nov 2025 17:02:35 +0100
Message-ID: <20251118160238.26265-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118160238.26265-1-vincent.guittot@linaro.org>
References: <20251118160238.26265-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the PCIe host controller available on the S32G platforms.

Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
Co-developed-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
Signed-off-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Co-developed-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
Signed-off-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 .../bindings/pci/nxp,s32g-pcie.yaml           | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
new file mode 100644
index 000000000000..da3106dfcf58
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/nxp,s32g-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP S32G2xxx/S32G3xxx PCIe Root Complex controller
+
+maintainers:
+  - Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
+  - Ionut Vicovan <ionut.vicovan@nxp.com>
+
+description:
+  This PCIe controller is based on the Synopsys DesignWare PCIe IP.
+  The S32G SoC family has two PCIe controllers, which can be configured as
+  either Root Complex or Endpoint.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - nxp,s32g2-pcie
+      - items:
+          - const: nxp,s32g3-pcie
+          - const: nxp,s32g2-pcie
+
+  reg:
+    maxItems: 6
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: dbi2
+      - const: atu
+      - const: dma
+      - const: ctrl
+      - const: config
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: msi
+      - const: dma
+    minItems: 1
+
+  pcie@0:
+    description:
+      Describe the S32G Root Port.
+    type: object
+    $ref: /schemas/pci/pci-pci-bridge.yaml#
+
+    properties:
+      reg:
+        maxItems: 1
+
+      phys:
+        maxItems: 1
+
+    required:
+      - reg
+      - phys
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - ranges
+  - pcie@0
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/phy/phy.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@40400000 {
+            compatible = "nxp,s32g3-pcie", "nxp,s32g2-pcie";
+            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
+                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
+                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
+                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
+                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
+                  <0x5f 0xffffe000 0x0 0x00002000>;   /* config space */
+            reg-names = "dbi", "dbi2", "atu", "dma", "ctrl", "config";
+            dma-coherent;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            device_type = "pci";
+            ranges =
+                     <0x81000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
+                     <0x82000000 0x0 0x00000000 0x58 0x00000000 0x0 0x80000000>,
+                     <0x82000000 0x1 0x00000000 0x59 0x00000000 0x6 0xfffe0000>;
+
+            bus-range = <0x0 0xff>;
+            interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi", "dma";
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 2 &gic 0 0 GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 3 &gic 0 0 GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 4 &gic 0 0 GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+
+            pcie@0 {
+                reg = <0x0 0x0 0x0 0x0 0x0>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
+
+                device_type = "pci";
+                phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
+            };
+        };
+    };
-- 
2.43.0


