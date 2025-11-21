Return-Path: <linux-pci+bounces-41886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 100A2C7AEDA
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 17:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C24F3A2010
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 16:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4912E2F0688;
	Fri, 21 Nov 2025 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QtdwJNYs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCA42F1FD3
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743767; cv=none; b=E7M4X+d3n0bmMrxhWHwpI9Fqyd3XBmIbzqLdKZQ+qePdH8YV5I5+wy0WiMEJU8PVwOeypDgLrdqrgjF+j5QhdIDCKvvXMv8kS8TkfaiiICDpyWIGkzRQPKlxQLGEL1zpS3Ev0XvBO1gxWFT5c5fQZ4wdR45nB7dyDyVN/UcHGZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743767; c=relaxed/simple;
	bh=LwWTZn9G4hy02sLAgSOfSCz7oCKcDzwyTL4UJEUsAVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5MuCOND510VGJwjSPVmNd/SYvJYk1d63cpaQ+tvk3jS7UmQPBq8AjTvyN14gurZOB41fA03qMKVPRMgQ7TCOmraGPtLhKKgVY6PNsNIhFioL5hwYSN8FLSJHUfyhcrzOs1b5Lg1OKC/tLLYYVMdHrPbqmR0tE8sAI8McPWFduQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QtdwJNYs; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so1329181f8f.0
        for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 08:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763743763; x=1764348563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wYeT/h/1x9MvlSpVGuLkmVdHMW20C6ijQ2jijWX0wk=;
        b=QtdwJNYsP/f9aau/Cmz/qiQBeqyNsrYH3XYQwhQsu4eBJmcHoGoT+ICCHW4OyejRvH
         TTl1y78bvrRxNLvCy4WDRWJcGygi+SIn2NtoD7fnfsdHS2g5Nwcmd41RhXC0vlm/Jotx
         QGU5KCxsQ5u4QZ/Wget9AMuMX0YyNnSNpxW9XfqfpNQJ1DWdvJbHtb+UYvbGxbCTKQqf
         IHh5WRirb7bFhy90AvrEzvSDFCtVatJObKUkHyZODm0gqpCr3YulY6/CYqHkRrkXRsiJ
         gLJmX38z8UMOjxHFY3KQYltUe/UnKzCShrKw7pQsn23puwmbz4mvtwt4DtbSMxDZ8gML
         +JoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763743763; x=1764348563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3wYeT/h/1x9MvlSpVGuLkmVdHMW20C6ijQ2jijWX0wk=;
        b=WjAm4mY8Sw4l2dmWQ7Zh4bE3w1a+v4fR43TLtdFrWhKippLpDS0KbKr460sNe3Y28Z
         MWtJLmNKTZNAdjCLuFckkxjKC41ljc5QCQAchcPx1GHxbBYIUKEKJOQrpon88prjabMe
         ql1sOCEE2l/oObJmu93MVExNy2SuKAcmuMz9Im0Qpus+j4+2On6qXIPvdU0gAgh06Yoq
         nM72AIpYj347tNUZOgxd2oz6+hPVu33cZAAiyZJ6uvBFNztvsi+C6UPqX8ZWWYHqar6h
         192llc6UIRipbwFnEmVt0eJ385YAfVjlMampMxm3GwOnouSek97szTbboHfawL3vql29
         kY9w==
X-Forwarded-Encrypted: i=1; AJvYcCUBByMzYDsgqS7KCBcMeK2MsjVI5OcUHhWQfxKieCaVYprmwTFophL1rzPXGyJYJxp8ExhXjif0lOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIjRAmqS0RPNPH8ExN6kz0K3VZmHApxRzaeWJbMLY/UXLG0gHA
	5YcgCHvJryjqbKa1H7Z55GFhWRuNVQBwDd/ZrQFOamii/iqlQkyHOVtNI2zQVRi3lDraROk6teI
	yf6K+
X-Gm-Gg: ASbGnctFV0MaXGEAamCbs5aUK+H1NczjbFH+vvKx+yQmZh+jbGYttS5az8O36zvHAzr
	l767l7qfKWqgZsFw2ik6a/XFDSmWMW1giiT/qWZ5BofKuL59CZH5SQIDekFOTUX/5SXx5Bow1Y2
	DFJEZB05ejKCyte+mlqoGmXHXwchrCTlN6eY+ny1PEa0iWx4xfFonKqPJWzWuRxLBQRgw/XQ+Q8
	Gc1IzKfhG+HWFVOPd6xrs0dOKEGj5FAyY6h/gGak1gARkl+u94xYMks/31eEOi1vstz/HfSRL+8
	SPnsB5L/SWag8cQNYBQSvNjSlPE/A/Bif4Rp1V8ulYZ8yiRad+it5oYuORfedr1Sv5ZmgXSkltE
	FBbXDW4Aou7h5hc+3kL9zsuwVMaKA51NBuNJVQ4UWKf6LuX8I/HagDbHAglcBhTr5xyZLD1+vn4
	jT4Mrgx///6GbsvfgDjbo=
X-Google-Smtp-Source: AGHT+IFTupEu7tQpaQcTp870nPjmfycov+d3eXmWpJglnNMzrHGGv2NoyhiwOnsqNMvhjJuRWF90yg==
X-Received: by 2002:a05:6000:290a:b0:429:d3e9:667 with SMTP id ffacd0b85a97d-42cc1ce47b9mr2775128f8f.18.1763743763176;
        Fri, 21 Nov 2025 08:49:23 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:803a:ae25:6381:a6fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb8ff3sm12938478f8f.29.2025.11.21.08.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:49:22 -0800 (PST)
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
Subject: [PATCH 1/4 v6] dt-bindings: PCI: s32g: Add NXP PCIe controller
Date: Fri, 21 Nov 2025 17:49:17 +0100
Message-ID: <20251121164920.2008569-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121164920.2008569-1-vincent.guittot@linaro.org>
References: <20251121164920.2008569-1-vincent.guittot@linaro.org>
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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/pci/nxp,s32g-pcie.yaml           | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
new file mode 100644
index 000000000000..66a050028278
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
+                     <0x01000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
+                     <0x02000000 0x0 0x00000000 0x58 0x00000000 0x0 0x80000000>,
+                     <0x02000000 0x1 0x00000000 0x59 0x00000000 0x6 0xfffe0000>;
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


