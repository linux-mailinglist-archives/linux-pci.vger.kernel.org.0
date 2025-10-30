Return-Path: <linux-pci+bounces-39858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D74FCC227F6
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 23:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2B6E4EF63D
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 22:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98282337110;
	Thu, 30 Oct 2025 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="tk/xjeKQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com [209.85.166.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D4231A567
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761861793; cv=none; b=BpX9nP+b6/6yG4B6CYmYG2cV/JgfqyF9Hy0+1i87xUUc12dRYMS/NnAvzFDVCn4U1thP8WVj4OFtSrdeso/dOeKq5XfYJWb0ON3R0NRLH2MlJHdbuN9FVpi8canQ3wSMyyubtN68aKGABOzKMJB5TS6KcbywZTCd0yOW6kiplUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761861793; c=relaxed/simple;
	bh=g0TyjQoYgqKGdvJozDxy+nVzO7SebxSVHgtLRKuRJfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3LsutD5GYv5+QPTyY0dC+vT4esXcRLPA+Dw21oIFfijnX3VCPRrJ5d84aKx/Pn3vOnn08Lrp66ziR5P/N2gRlfT7zAZRlTElIDCq8Fe4ldoZseEY9QlAmT04i8SqN9he7OcDcel2Cc3wNTgv1LpfXN3G325zUZAZx56VrTEIlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=tk/xjeKQ; arc=none smtp.client-ip=209.85.166.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f68.google.com with SMTP id ca18e2360f4ac-940f8a73275so163071739f.1
        for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 15:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761861790; x=1762466590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kY8F6K1rIyJfyukY+3kGi6ZJkc+idzdw2ZPLZkTQgao=;
        b=tk/xjeKQKRCUomi2XwloS61UK27MWvt3Y3unY2XjY3zBn943fhtQ2d1jSn4ADln1vQ
         rtZY6lOtj3Rupi+0S2DGFPF4peHeqjRwXye6JFA+Yi6tL8oDKx4qMJoUvfuDdQETBAb5
         6Ox5PRMvSPQBo3gcta41cPRm/BYBAEzAf+fSKlZwjBsF09GFKWnd9GNmmk27v4oSFJyk
         y2k6HuvGwpn9c2a9ikKYWrHnlURFQrCfBpMpHzZ3GiL2bjhP2M46YNHuHxnajpNSfabk
         IDKc1CjHIWh+uHhLi3TfiRQntOkf7cO03i0iaJpSGJ1zuwhfDmIlUtB7Ys53M+LUJaM0
         kEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761861790; x=1762466590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kY8F6K1rIyJfyukY+3kGi6ZJkc+idzdw2ZPLZkTQgao=;
        b=hdaidzTLDvA96GJCboJEf+pG0GnQNh4YGr0px4V2vEGMc7qJG6II+8ZlAtPK3KsnHa
         fQDLCOBBhxrKwprkx7K+Jj89OuZ+xZqe+xkPxVGdX5TO13VuoCmVbbaGm65FuNHJ7FUA
         5nc0dmSYVuCnhjFaJSm0YU/8Fm2oCyadVKupyKAJY2d8e6pvHablJO/MBnnR4d8YATiq
         zP/e9KOECplMTtBspIneKC058as42p+irdMcI3GJlH+9g29uAd+M9Ifmm4uW4aYIgR8d
         h+sQgTEPLScMTIQIW2RCcsby/a/wE0CUT4di1nz3Xz2UCBZ1jLktp+gvBu71lB3zU8Ah
         oeug==
X-Forwarded-Encrypted: i=1; AJvYcCWENqxkFSSQIACMVuSPJW0OmGu7iB0qRk+M8SapCVBSl186I9f2zC0QEQBvLZON/HIjY9eBCdkcT2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnLveO+28oQlVHgUNa51eUGXOBx5ahC9pk0/kVkCVcX88wD310
	HNy61ivIlBxBZxg+IDhy7uM+y+OrPstT5O/3+szIM+drC3SsHjuoizXSq95ZTfA9rZqdHAuwSVn
	snYAMnLnp9g==
X-Gm-Gg: ASbGnct9DRiHVCa5WKrHypfBcwZLha1t6/fwMuj36flkfWt/bj0TdIFZlNgeF/XNcgB
	C051Nygx360viPyhc2KFNCMEhva1xYzAcIDPPsMow6aDD47HLFGNSBMsKA8IZJetHiM4wZWhpxb
	EfEzW9C6O4ErX8a/DRVSfxdnJg3hJ7nqJMnlSSyaAgieT52FA1IfB1b1EShVlbfC7dRK8W7NuG0
	iQwZnizQ/nQ29hWsSVGx9nIgF0x9y3PJatitFdHG97qyZiqOiyWwwtstIo9DdQHvTucPIgd0GST
	tgOJmxcnOAwrF/aNeFM+2uMsJWhPvaISbaiW2H3CgP9Rapo8ZPphGtrHsQ8gvY9mg62czraQoi0
	rKmauGDwCZdNU99J8cNcceVMG0rUV66Skq695aJipgxbpUeFyOqXeGMtyC0D1INdPhw6Wl1Lt6n
	bmtBJkXZhV6NGG53pqK/GtAmFGaYVuwqeqzFc3UyhkQUs=
X-Google-Smtp-Source: AGHT+IH2ECDLiEzZGe6B8hcsGW+TrKbN+u5OLPyvgHr1FicCmPHECAKFwVMLTlNXVAMST58dw/pRxg==
X-Received: by 2002:a05:6602:1545:b0:943:83fa:ef49 with SMTP id ca18e2360f4ac-94822a4fb5cmr226769439f.15.1761861789674;
        Thu, 30 Oct 2025 15:03:09 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94359efe149sm604118039f.13.2025.10.30.15.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 15:03:09 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org
Cc: dlan@gentoo.org,
	guodong@riscstar.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/7] dt-bindings: pci: spacemit: introduce PCIe host controller
Date: Thu, 30 Oct 2025 17:02:54 -0500
Message-ID: <20251030220259.1063792-4-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030220259.1063792-1-elder@riscstar.com>
References: <20251030220259.1063792-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Device Tree binding for the PCIe root complex found on the
SpacemiT K1 SoC.  This device is derived from the Synopsys Designware
PCIe IP.  It supports up to three PCIe ports operating at PCIe gen 2
link speeds (5 GT/sec).  One of the ports uses a combo PHY, which is
typically used to support a USB 3 port.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../bindings/pci/spacemit,k1-pcie-host.yaml   | 157 ++++++++++++++++++
 1 file changed, 157 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
new file mode 100644
index 0000000000000..58239a155ecc0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
@@ -0,0 +1,157 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/spacemit,k1-pcie-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT K1 PCI Express Host Controller
+
+maintainers:
+  - Alex Elder <elder@riscstar.com>
+
+description: >
+  The SpacemiT K1 SoC PCIe host controller is based on the Synopsys
+  DesignWare PCIe IP.  The controller uses the DesignWare built-in
+  MSI interrupt controller, and supports 256 MSIs.
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
+properties:
+  compatible:
+    const: spacemit,k1-pcie
+
+  reg:
+    items:
+      - description: DesignWare PCIe registers
+      - description: ATU address space
+      - description: PCIe configuration space
+      - description: Link control registers
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: atu
+      - const: config
+      - const: link
+
+  clocks:
+    items:
+      - description: DWC PCIe Data Bus Interface (DBI) clock
+      - description: DWC PCIe application AXI-bus master interface clock
+      - description: DWC PCIe application AXI-bus slave interface clock
+
+  clock-names:
+    items:
+      - const: dbi
+      - const: mstr
+      - const: slv
+
+  resets:
+    items:
+      - description: DWC PCIe Data Bus Interface (DBI) reset
+      - description: DWC PCIe application AXI-bus master interface reset
+      - description: DWC PCIe application AXI-bus slave interface reset
+
+  reset-names:
+    items:
+      - const: dbi
+      - const: mstr
+      - const: slv
+
+  interrupts:
+    items:
+      - description: Interrupt used for MSIs
+
+  interrupt-names:
+    const: msi
+
+  spacemit,apmu:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      A phandle that refers to the APMU system controller, whose
+      regmap is used in managing resets and link state, along with
+      and offset of its reset control register.
+    items:
+      - items:
+          - description: phandle to APMU system controller
+          - description: register offset
+
+patternProperties:
+  '^pcie?@':
+    type: object
+    $ref: /schemas/pci/pci-pci-bridge.yaml#
+
+    properties:
+      phys:
+        maxItems: 1
+
+      vpcie3v3-supply:
+        description:
+          A phandle for 3.3v regulator to use for PCIe
+
+    required:
+      - phys
+      - vpcie3v3-supply
+
+    unevaluatedProperties: false
+
+required:
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - interrupts
+  - interrupt-names
+  - spacemit,apmu
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/spacemit,k1-syscon.h>
+    pcie@ca400000 {
+        device_type = "pci";
+        compatible = "spacemit,k1-pcie";
+        reg = <0xca400000 0x00001000>,
+              <0xca700000 0x0001ff24>,
+              <0x9f000000 0x00002000>,
+              <0xc0c20000 0x00001000>;
+        reg-names = "dbi",
+                    "atu",
+                    "config",
+                    "link";
+        #address-cells = <3>;
+        #size-cells = <2>;
+        ranges = <0x01000000 0x0 0x00000000 0x9f002000 0x0 0x00100000>,
+                 <0x02000000 0x0 0x90000000 0x90000000 0x0 0x0f000000>;
+        interrupts = <142>;
+        interrupt-names = "msi";
+        clocks = <&syscon_apmu CLK_PCIE1_DBI>,
+                 <&syscon_apmu CLK_PCIE1_MASTER>,
+                 <&syscon_apmu CLK_PCIE1_SLAVE>;
+        clock-names = "dbi",
+                      "mstr",
+                      "slv";
+        resets = <&syscon_apmu RESET_PCIE1_DBI>,
+                 <&syscon_apmu RESET_PCIE1_MASTER>,
+                 <&syscon_apmu RESET_PCIE1_SLAVE>;
+        reset-names = "dbi",
+                      "mstr",
+                      "slv";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pcie1_3_cfg>;
+        spacemit,apmu = <&syscon_apmu 0x3d4>;
+
+        pcie@0 {
+          device_type = "pci";
+          compatible = "pciclass,0604";
+          reg = <0x0 0x0 0x0 0x0 0x0>;
+          bus-range = <0x01 0xff>;
+          #address-cells = <3>;
+          #size-cells = <2>;
+          ranges;
+          phys = <&pcie1_phy>;
+          vpcie3v3-supply = <&pcie_vcc_3v3>;
+        };
+    };
-- 
2.48.1


