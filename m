Return-Path: <linux-pci+bounces-38510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4C5BEB5AD
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 21:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D383504237
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 19:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C5A332910;
	Fri, 17 Oct 2025 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="B0Xs/t2B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com [209.85.166.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B47C23EA88
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760728072; cv=none; b=treL+/j0NLMCfI1Z7qHrMPvqFpnpvonh/ApCSmD9tR2OjB/cDeohwwh49CceUB/MMhxVU5xHb1ZdQ7TWJTTIX3t4Acip4YVeo970NQPxQ57R/dkrX44TS2umbds+91/YDACZRIy2hQS5jRHDeHmBF6Ujw8RKxFUJlskJFFScva0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760728072; c=relaxed/simple;
	bh=gSA8pzE96CptaNNhmH2TKS9Z/TX8WVfVdY5RfpgB+X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6XGL994hEt+UNzDoGhCURpg5SA1BZZHvBWspVOepABYvL01BpeySqTEV6t7OY+yMXIInevoWcXwwJe8LlrJOIyEJdkzXZ1RzRYOn2gSSkaNs3PhTWaoAH5QsYiCGFgvvUytYtxJoRDJsxbY5AAc7AbME6NOqbxGMs/ihFWobIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=B0Xs/t2B; arc=none smtp.client-ip=209.85.166.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f66.google.com with SMTP id ca18e2360f4ac-938de0df471so196621139f.2
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 12:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760728068; x=1761332868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wipx6KUf5lXNnshQnWU8AGb6pBA1b4PqRzR3i29GydQ=;
        b=B0Xs/t2BZg2MRNTW0WNu8tW8U8O6d1wWBwsDDdRPVKO8t2h8ZkEopykzgoli3yGp6y
         oK/pSCuA8x55SGWwOu+btU3d0kWcJyMacvmb2SznYHuuXwS1DVSSzWAtzLj+2UUwTkRn
         5Dc5p1Md/7n59TLQBm9pOEFwM0XlZJDaA0bhjgdmS9FsUWDYlZaDk1dAC88oPS04sk6Y
         jn0hugTebhOgvcOxKK2VFeBDzfNpcdFhAnx6NmxcNzUrI3dn2TUNwVYqCJbKIxyoXKSC
         SdL6Tn25xfyUZwYZY8dvPROUmpSfsSszXb9Z7E9v2T2l3kmMarUFgTumVAEegx2bOsMo
         ngJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760728068; x=1761332868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wipx6KUf5lXNnshQnWU8AGb6pBA1b4PqRzR3i29GydQ=;
        b=nZeAARMBlznfhf3ozHdzoOXfg2HN/puRyxOue7D6jtFh3uvU6l/JkuT/DDLfMOO/Nl
         1wzrsfJpVRPTSMKF5wHmJqmuIw9EOjYS17Fj8Rft1oQf6nAoJCxDT4GNpC1vdLbeWsU4
         JZMI1IPQ93dfHAhwn4Z1MAJVUpqWCMXldsdKzJcsto4W9IwOH3kiY6sKD2arYiGGnJ3L
         wvcVpy2OOjsTAJoIxk/KOxVOWgCH3Q7MbhVSao43IIuJvFXU4eXcBbje+qEj+8JjWopD
         +QAMOuOPEjkFRZztxah4rTVOFBEakbTZibbfnhNXOHLpftklJhlxsBrJrrjbPrFELG6w
         9Qqw==
X-Forwarded-Encrypted: i=1; AJvYcCW9aqggwFpZaCa1Y807FIkICZyIpI89Wl06DBCv+FGyjxKMCFtgIM+IUGY5dudzPVcIrN99U6GSTJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKmuZIVIQEbXROksD7wnRh2ntGcCnRbpEC0sY3M5D3HR5Fazcc
	CgCt+M3nFts82REqH/ov49AIzmKgm9i983dAdYookbupJYUhC/6Jw9+7kEiYMDh5ldI=
X-Gm-Gg: ASbGnctDmwCnnw82X0kTqLy6e3lreVMW8CM1q/7wIXuJIj/03+ypku7Lxtt+VwvAqR2
	t0+C5QkSG5R2uNZ7IgPMPSzglErmSdz1BM3PRPtUaHFLzBlbiO+D7VjUr/CZeLkHXvVVS7kQ+EF
	D8mZ/4TTGCmhVpfYMcCy7bf4JtwH/hXhy34190r8NHbDmfk/pM3EHVAg2ll0bd88NdS+VEcg4A0
	+rvN9PlaO9nz0hvtivh4znQDiogs8O8K06SwaoTJxlBJ5Kx9wUZ1NSikt7CKG1MumVtJ1w6OI7Z
	OJ/OUpNqB3C9lW3c71PiYHySb1BXkmc7VpPLXkX1OhK6qXtOcMHC+GwTzu3F1k+BOJ7TFkgob7n
	RXAn/y+lWW21X6rLi6CTXuHf9kbMkcf3z4EO8Qlo/D2EvAv1RkPu2jFRVfph1GDsLyJpZ2ihAFL
	TvnJoS0lsQFne1tSaKrHbqzYVItq/lKR3k2UcV/lZ4GSw=
X-Google-Smtp-Source: AGHT+IGlmzrh73wRb0y67T37imaj4fcl25NZgeEColbyy8xRcDJKg9j4yQIgu1HP8DHaZFDT+Smbzg==
X-Received: by 2002:a05:6e02:188b:b0:430:b05a:ecb3 with SMTP id e9e14a558f8ab-430c52899ddmr71652585ab.9.1760728068556;
        Fri, 17 Oct 2025 12:07:48 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9768b98sm153462173.46.2025.10.17.12.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 12:07:48 -0700 (PDT)
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
Subject: [PATCH v3 3/7] dt-bindings: pci: spacemit: introduce PCIe host controller
Date: Fri, 17 Oct 2025 14:07:35 -0500
Message-ID: <20251017190740.306780-4-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251017190740.306780-1-elder@riscstar.com>
References: <20251017190740.306780-1-elder@riscstar.com>
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
v3: - Remove the "num-viewport" property
    - A "phy" reset is no longer required

 .../bindings/pci/spacemit,k1-pcie-host.yaml   | 147 ++++++++++++++++++
 1 file changed, 147 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
new file mode 100644
index 0000000000000..89f8b6b579c6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
@@ -0,0 +1,147 @@
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
+  phys:
+    maxItems: 1
+
+  vpcie3v3-supply:
+    description:
+      A phandle for 3.3v regulator to use for PCIe
+
+  device_type:
+    const: pci
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - spacemit,apmu
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - interrupts
+  - interrupt-names
+  - phys
+  - vpcie3v3-supply
+  - device_type
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/spacemit,k1-syscon.h>
+    pcie@ca400000 {
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
+        phys = <&pcie1_phy>;
+        vpcie3v3-supply = <&pcie_vcc_3v3>;
+        device_type = "pci";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pcie1_3_cfg>;
+        spacemit,apmu = <&syscon_apmu 0x3d4>;
+    };
-- 
2.48.1


