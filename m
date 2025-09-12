Return-Path: <linux-pci+bounces-36030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47736B550AB
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 16:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042EB58465F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 14:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1023112CB;
	Fri, 12 Sep 2025 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdKk2shd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C807230F800
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686482; cv=none; b=RaUn9HZO/urVO+5HS7fWgphKBXSCmGeCcr8UDiPF0dV9HPIhAq5B3enIh1nROeD5w+AmxH04oe9fGDqsDVpfLRfmXPr+3urO9oCIxuDMzfd+44EuPkNdKR2XyASDRiT309RgBrqDEpR6yMJrDVmN984W3TyunRbUpgHDugZirFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686482; c=relaxed/simple;
	bh=f24DU5lC2gBcLbPMhD+jzo5pBeClzy+bh3ExwSA72ck=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yl8PX4EKriRTMKZ/OFpPaAkwKzWZVJPUYT4SfzNXFqPuxEpmX4yG+QxIM0ZwSunbg6U6rdHTWwo8v+3y0GYr/8cRsf3rVhhO0ncHJYNU75DJvtR+A5P7ygjQP2QpFjJP9PFtBwAcxStWSQPDjEavV/bLeQG6TkGEF8qbhoJR01g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fdKk2shd; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3e76766a172so649611f8f.0
        for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 07:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757686479; x=1758291279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQyCKb+9uJp7SOdagD6pw2vnDQu7jCiCKfd/I4XXgVA=;
        b=fdKk2shdis2yqRltQsQ6UF1KhFCMamWgW/hW6ITrrAb6JkxnkplOKlsGuhKyUEoebn
         kKWKeguIz80kv2ZsdvokhLCAq180jVt9FE5OnhJ3VtxiKLnGAIfayDDW65Muq6btwy0V
         4eVkvm0tmkoo6RqQBnGGrsFUXkwct/nsvN6BOmTKGvGVpFHg0ZrUXqlUP6YuSwMTS173
         ADCp3uTdMl5Pi2T7GxJ6QATebMMqmQhE8D+Wb/WymM/0JG/WO/jgKALLqduyOwLTLlNS
         PgbPbjgZg2nZWznVt5oWghgnkXLvwp8Xe3kILG4e7wG25XjhuVoSPWOnYPuGB5JGqV8R
         0TLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686479; x=1758291279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQyCKb+9uJp7SOdagD6pw2vnDQu7jCiCKfd/I4XXgVA=;
        b=IYcm5ocYZFTpamc2MH7JQf6TMceZ1gg5ZwFCxJl2qfEoAnQLl/GKOJvAwzo88Kx6Co
         uHfmXgRAg4XS9f2FsC8VjN7V1+xt0QIzrAIu6lS7khe+ixdlDGvBMt+fPceV3F5Mpey+
         sHBXujuBAnGHSSdjBb4DyBD+tm5JPuMG8RhArE7nDa4NT0zrvUQ1EvAXxC3gn3Qkr7Q1
         HHS9baXCgvKfjrYMucwhzWb6maoVnmVr2EAycGuzCwrww4Y7WxUs9or2ha+qJ3d3Ld4I
         65X0JAyGo+9XuTQ2ZmNXFNgqMlmO5+NMDJZ8AQLCPKJY1BFNdTLPfYpJmvMWreCg1jBl
         T10w==
X-Forwarded-Encrypted: i=1; AJvYcCWV3iTNAYYox1AlzsHru9m7vyisplwG1AqN4Tf+8rSy/8hkIgI9iQCGdU2QCRFpRAjbWLQnFKOiOcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXhq0jS1DeHAGVsnUPCkrLOauX4UrAlnVD4is+HgrgGxKzOEA6
	NCxEbkIqHB46cQxey1+AGYCeCc5loVTEHHUJtKrG3e+GTvIze6DSjz2yGp0KyFZ5MKM=
X-Gm-Gg: ASbGncuRj1E54ur3OAVlmO8l1An9LugsYK53luxXhzkxTvc8ecsji85g8MOMntmsNBE
	tbtsKAcCOffVRHLX/DjMw22kdwdpwmloCvHNaAtxHuaYqBNxHzUE8RfllIVZvkmlBygCnGA2SeS
	FyP0b+jmpGCXtIPAYdDwIYfbWtN2b6btIvK5AX/EwJc6DIYpAQO+C2IqG+yxcNf8jmm4TNgfCwa
	mANt7wYHlfyAkO9DvWYeQYMWN+ucWmQqjyGFcjxM/EZ2WeE4DIRLmWjpCgQLTd7JL2f+sZ9vPUf
	PVUKCNWbNbMIsSXMh+4srcUf8PPFQ5qkYl86H6qiRIdKBWAvW4qkFwqUqbESsDyTR+BVj4ynxND
	SFLt/xGi1yNTIGMjwHrzcWZ7TgpjY2wMW6Gx+48aPkQ==
X-Google-Smtp-Source: AGHT+IHr9QNx6nq0CgD6or/rsKobvrFcl0bL9J7mn1ygpYIXLnS8oK1XThgJ5+3dtK7jLpCenoLvwQ==
X-Received: by 2002:a05:6000:2584:b0:3e7:5f26:f1d7 with SMTP id ffacd0b85a97d-3e76578976cmr3370545f8f.12.1757686478881;
        Fri, 12 Sep 2025 07:14:38 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:40ce:250c:1a13:d1ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd415sm6680739f8f.30.2025.09.12.07.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:14:38 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	s32@nxp.com,
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
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: pcie: Add the NXP PCIe controller
Date: Fri, 12 Sep 2025 16:14:33 +0200
Message-ID: <20250912141436.2347852-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912141436.2347852-1-vincent.guittot@linaro.org>
References: <20250912141436.2347852-1-vincent.guittot@linaro.org>
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
 .../devicetree/bindings/pci/nxp,s32-pcie.yaml | 169 ++++++++++++++++++
 1 file changed, 169 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml b/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
new file mode 100644
index 000000000000..287596d7162d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
@@ -0,0 +1,169 @@
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
+  either Root Complex or End Point.
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
+    minItems: 7
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
+    minItems: 8
+    maxItems: 8
+
+  interrupt-names:
+    items:
+      - const: link_req_stat
+      - const: dma
+      - const: msi
+      - const: phy_link_down
+      - const: phy_link_up
+      - const: misc
+      - const: pcs
+      - const: tlp_req_no_comp
+
+  msi-parent:
+    description:
+      Use this option to reference the GIC controller node which will
+      handle the MSIs. This property can be used only in Root Complex mode.
+      The msi-parent node must be declared as "msi-controller" and the list of
+      available SPIs that can be used must be declared using "mbi-ranges".
+      If "msi-parent" is not present in the PCIe node, MSIs will be handled
+      by iMSI-RX -Integrated MSI Receiver [AXI Bridge]-, an integrated
+      MSI reception module in the PCIe controller's AXI Bridge which
+      detects and terminates inbound MSI requests (received on the RX wire).
+      These MSIs no longer appear on the AXI bus, instead a hard-wired
+      interrupt is raised, documented as "DSP AXI MSI Interrupt" in the SoC
+      Reference Manual.
+
+  nxp,phy-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Select PHY mode for PCIe controller
+    enum:
+      - crns  # Common Reference Clock, No Spread Spectrum
+      - crss  # Common Reference Clock, Spread Spectrum
+      - srns  # Separate reference Clock, No Spread Spectrum
+      - sris  # Separate Reference Clock, Independent Spread Spectrum
+
+  max-link-speed:
+    description:
+      The max link speed is normaly Gen3, but can be enforced to a lower value
+      in case of special limitations.
+    maximum: 3
+
+  num-lanes:
+    description:
+      Max bus width (1 or 2); it is the number of physical lanes
+    minimum: 1
+    maximum: 2
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - ranges
+  - nxp,phy-mode
+  - num-lanes
+  - phys
+
+additionalProperties: true
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
+        pcie0: pcie@40400000 {
+            compatible = "nxp,s32g3-pcie",
+                         "nxp,s32g2-pcie";
+            dma-coherent;
+            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
+                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
+                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
+                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
+                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
+                  /* RC configuration space, 4KB each for cfg0 and cfg1
+                   * at the end of the outbound memory map
+                   */
+                  <0x5f 0xffffe000 0x0 0x00002000>,
+                  <0x58 0x00000000 0x0 0x40000000>; /* 1GB EP addr space */
+                  reg-names = "dbi", "dbi2", "atu", "dma", "ctrl",
+                              "config", "addr_space";
+                  #address-cells = <3>;
+                  #size-cells = <2>;
+                  device_type = "pci";
+                  ranges =
+                  /* downstream I/O, 64KB and aligned naturally just
+                   * before the config space to minimize fragmentation
+                   */
+                  <0x81000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
+                  /* non-prefetchable memory, with best case size and
+                  * alignment
+                   */
+                  <0x82000000 0x0 0x00000000 0x58 0x00000000 0x7 0xfffe0000>;
+
+                  nxp,phy-mode = "crns";
+                  bus-range = <0x0 0xff>;
+                  interrupts =  <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+                                <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+                                <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+                                <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+                                <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+                                <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+                                <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+                                <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+                  interrupt-names = "link_req_stat", "dma", "msi",
+                                    "phy_link_down", "phy_link_up", "misc",
+                                    "pcs", "tlp_req_no_comp";
+                  #interrupt-cells = <1>;
+                  interrupt-map-mask = <0 0 0 0x7>;
+                  interrupt-map = <0 0 0 1 &gic 0 0 0 128 4>,
+                                  <0 0 0 2 &gic 0 0 0 129 4>,
+                                  <0 0 0 3 &gic 0 0 0 130 4>,
+                                  <0 0 0 4 &gic 0 0 0 131 4>;
+                  msi-parent = <&gic>;
+
+                  num-lanes = <2>;
+                  phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
+        };
+    };
-- 
2.43.0


