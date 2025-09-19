Return-Path: <linux-pci+bounces-36512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF72B8A74F
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 17:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787073B909B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 15:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E94831FEC6;
	Fri, 19 Sep 2025 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eahhOQno"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7158C31A55C
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297508; cv=none; b=GCJxxwvBdcs4bJiVHY4aI1MQ5TgxvxR1ebIiRBMJvgfyTamMWJqouvUMtdkeNaXvq7FqAiJpmyQ5905v8wsW44Glkhjn9e8WTi7nu38h+sUJT4HefPAMHcfYrTwmDq7ycFN/T7htEdKo9sqrQumZK3/MiWHj/x4kaukojdETtsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297508; c=relaxed/simple;
	bh=AQJN1sqWPKdNdfpRB8nChb7U4dPNPEMlgzYPiyse1lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u249lolX3ijlZUlXB9Wh88usdJyNuL0TGj/OMk4On1+F2GtlJV1eRW3eDBhofwF1eAd+/CK1HPdI7ZwcdcJ2M84Ya0+DCaI4fv7O+ibzPB12jpJp1T/jN0JjNhvyWn3hKDvNnfqhvjf1ekFElL3xBQgYQUzVO564f60lqUGJ5pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eahhOQno; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ec4d6ba0cdso1634275f8f.2
        for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 08:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758297505; x=1758902305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vS7mvhF1JO4dUjEbpDOATr6HeFKK48b7nTeLMm/UrOY=;
        b=eahhOQnotv0IR8b5m7iNCG2W+eLoQsFHl7wmGex9MAmjImhQjA2hu4WvaVm6HBPEWV
         OtGbSKf1kacd0/Yv/HF2vVre4SqSvvN5xA6S3ofmaSeNpOdi2KD/kBa5J0tmRE3jGZm+
         XZa1oN2KqOClJOXrFtXUq1OdqRIud+ajw7MAr35Ejw3Xshy0P/+BbD2kFD8PAIiRkQDd
         SJWhxXqLJ+qRcvzIoFeBAl5t3WcbuqfLvORO7q0J2HtsjYUdZf7reOTmmUeMdkL9dKAz
         Ja957l30DsBfL3naqEMKi4WQaMk1E4D3hRqwKRXTTIW1M4+5DNmE42c3GtPzQNbXJXk8
         naSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758297505; x=1758902305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vS7mvhF1JO4dUjEbpDOATr6HeFKK48b7nTeLMm/UrOY=;
        b=akzSfsSgTG5kNbXvLY85WnBi7LBs74Z3bML0ZtkLFzQ9olib3gEmzH6rSuXvmop4WY
         Ojvbq3aBPnGAbOAD/jFiUqVmRGRv94OewbueKLyQgM8qSOivR2oAA0doynpiUTYbZXxI
         N2MpWg2hmQyDZVhr4HgmKJJaAz2rlkB0RwS2siePW71v9ABADAJClnvxlS2zFT8ktbCe
         jUeXPLObOGQ2/tAHI455EvmxUhXGYKlC0paBrCOiuW0Yf0wnvGMlHevNo1KyN8ugRSXE
         BMLHnVyUY9qExYbvoEcLT7GBY3UXGj8tRC4s4xbYN2saFSdRHRCP3+HK06oZ+s4nqATf
         BRhg==
X-Forwarded-Encrypted: i=1; AJvYcCUCUmPqrKkie/nEmRq3mKmI0A3egGgLOy3oH+hpWiOwoeCM5GsE8FIDvEgsnZl58CNlulr8sDCEs3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpEoFFDUk4n01HzoOr9k+asMime8n6O7Gu3KXM911J6wbLLCN3
	2ZrCGLmzySFE0BRC1gBdgU0sLitXuToNWSW50Ko06b/HcV8gQEX4/2AA9c2L2aK+zvg=
X-Gm-Gg: ASbGncv7T7RJEUiBK6JND8BD/oDCOyAMdKOCEIqAltF+AWgE2jj5ve/4+yECY6l64fW
	ca/A6aMgKHMvlWxV3fK0xjoR2inC2fqlQN8RHCqea4qa0g0CDIcdHzhEljV9Kl66RIw72J7mzKO
	khQQBeduHSK8ga2b37U9hvep0nVvtaX+/Q5tfSW702xB5USze1kKdYy4xJ+e6OJT9htaI1nEYWW
	Uj2C/zUSzq6fYoCz+f1gEpEaV5dqx4QFDpHmKLiQQSjTf3rmL9zuK+KHbgeDEczZEhhy9wiRwRW
	ZP32ZFk7MllhBRQnA+9bi+UHm7AdRjuUk02gY01yIShWA66eEbHQz+UXPxR+yX7U8mX8LKMK1YZ
	CX2vETqlNkHHhdz5RigI2v3INNMo/6z2eNyLmLFTLmA==
X-Google-Smtp-Source: AGHT+IGHpr7IbIupTqCPhLagR2/pjjAWy2NRyzBJWRNwFS3zhzcdJAYgjTcIo3v6JaXEdhyc34PL2g==
X-Received: by 2002:a05:6000:4029:b0:3eb:5245:7c1f with SMTP id ffacd0b85a97d-3ee7da56fdemr3546022f8f.2.1758297504630;
        Fri, 19 Sep 2025 08:58:24 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:9dd0:62bf:d369:14ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407fa3sm8367224f8f.21.2025.09.19.08.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:58:23 -0700 (PDT)
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
Subject: [PATCH 1/3 v2] dt-bindings: PCI: s32g: Add NXP PCIe controller
Date: Fri, 19 Sep 2025 17:58:19 +0200
Message-ID: <20250919155821.95334-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919155821.95334-1-vincent.guittot@linaro.org>
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the PCIe controller available on the S32G platforms.

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
 .../devicetree/bindings/pci/nxp,s32-pcie.yaml | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml b/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
new file mode 100644
index 000000000000..cabb8b86c042
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/nxp,s32-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP S32G2xx/S32G3xx PCIe controller
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
+          - nxp,s32g2-pcie     # S32G2 SoCs RC mode
+      - items:
+          - const: nxp,s32g3-pcie
+          - const: nxp,s32g2-pcie
+
+  reg:
+    maxItems: 7
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: dbi2
+      - const: atu
+      - const: dma
+      - const: ctrl
+      - const: config
+      - const: addr_space
+
+  interrupts:
+    maxItems: 8
+
+  interrupt-names:
+    items:
+      - const: link-req-stat
+      - const: dma
+      - const: msi
+      - const: phy-link-down
+      - const: phy-link-up
+      - const: misc
+      - const: pcs
+      - const: tlp-req-no-comp
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - ranges
+  - phys
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
+  - $ref: /schemas/pci/pci-bus.yaml#
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
+            compatible = "nxp,s32g3-pcie",
+                         "nxp,s32g2-pcie";
+            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
+                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
+                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
+                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
+                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
+                  /*
+                   * RC configuration space, 4KB each for cfg0 and cfg1
+                   * at the end of the outbound memory map
+                   */
+                  <0x5f 0xffffe000 0x0 0x00002000>,
+                  <0x58 0x00000000 0x0 0x40000000>; /* 1GB EP addr space */
+            reg-names = "dbi", "dbi2", "atu", "dma", "ctrl",
+                        "config", "addr_space";
+            dma-coherent;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            device_type = "pci";
+            ranges =
+                  /*
+                   * downstream I/O, 64KB and aligned naturally just
+                   * before the config space to minimize fragmentation
+                   */
+                  <0x81000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
+                  /*
+                   * non-prefetchable memory, with best case size and
+                   * alignment
+                   */
+                  <0x82000000 0x0 0x00000000 0x58 0x00000000 0x7 0xfffe0000>;
+
+            bus-range = <0x0 0xff>;
+            interrupts =  <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+                          <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+                          <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+                          <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+                          <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+                          <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+                          <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+                          <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "link-req-stat", "dma", "msi",
+                              "phy-link-down", "phy-link-up", "misc",
+                              "pcs", "tlp-req-no-comp";
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 2 &gic 0 0 GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 3 &gic 0 0 GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 4 &gic 0 0 GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+
+            phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
+        };
+    };
-- 
2.43.0


