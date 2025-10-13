Return-Path: <linux-pci+bounces-37920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1A6BD4EF4
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 18:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820E15418D5
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 15:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637FD313284;
	Mon, 13 Oct 2025 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="1pxTxKAE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f195.google.com (mail-il1-f195.google.com [209.85.166.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555603128DE
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369739; cv=none; b=lE9+xYtUBud5JRmjAaGgqfv56wpsuCfFBD7zqnvwgTTevkTt02jnV4dqN25dwj5E1MfxU32TfmIHkixArA8KIXhin5p306V/qRm/EgE0Qj0AohMQKhGrxA7HKTpWCq51Q+/0rk19dRPimlVhCB21JuZQn2bvv8IHzkVp8V3PogM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369739; c=relaxed/simple;
	bh=g3onUkgevlk1RjMxAzZNUt+BDhEsfUgytM/vs6wob2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJfecR9Cz5+Tv4lBhtnBCfQmnIln5WyZvDIl/PeB4ApeJCEnKRwNMV9+EWneq18L8fMxJjJBq7kfIZDCc5KnCFkdzCajtLckE59nRYmikj3a4Eq7nBSpBES8G2KMCJ0scL1823ENmDh8vnGMDjlIy4y7/eWfztqzIY0QdPwHwig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=1pxTxKAE; arc=none smtp.client-ip=209.85.166.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f195.google.com with SMTP id e9e14a558f8ab-42d8bf52325so22332125ab.3
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760369736; x=1760974536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clcUhTCzkpc78EGP0YwMtfP0eONI0FKHMHfxFBjJETM=;
        b=1pxTxKAEKDjWDENqK9uLdjrSl0iCodsgCx5ckEZNC6hu199q2Dl2dIS/fcKEHqz7Y7
         p/CmPx9W8kNHm3Yk/EgwxUkEqKAgnloEO9jcLRJ6RkvCsxM9ChDLqEv4co1bgD9EXIUO
         OSbn51X5gPWcAx4Xmnuv3g7FxrkxUlO5BDtXGKs1VacnimO0h2g/4XvuQYNAHspaKPxI
         SlUAn4kqRAn4RQ24c5sbS0oSb+A3/HP+n42QPomD3EEKqeQshyI+kA2fHdPz4usFGl54
         PuLUFSxEb6vrecO3SqG75yf4XM83p/w1zXC+o6goBtGA0OuNQWMk5jmmGE3aFLWqUC3w
         bQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369736; x=1760974536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clcUhTCzkpc78EGP0YwMtfP0eONI0FKHMHfxFBjJETM=;
        b=ipHMhl6lv6eA+ObiSt6ck22jX7xEPZUVqyL/VaTVAPiNFcFPTBg8rXv4wkK42AGNsZ
         gmfGueekDmTB5rzB8US0rXEppSNrOxTVKWNPrLVGGWrwL3Pylo0L0mcWtugsZrAh70Iq
         1MpVY15AOipWewxvGeylw0mg/V/e+8Oj/2bftgRRFK/vrGJe9YpGOsgp/j4xttcLSOhI
         U14hxviX7oK5wWDQmLx0+kTKJM3aBC9pBf3IoTYrokpg626uwZVg0hU1VykKD4bzALp+
         ARgq2LMGpqr5J6W9lpL1SucrrHynfhnF8Xwxi+e63PvSidc/yPQZl45N1abR3euKVY/O
         /Z2A==
X-Forwarded-Encrypted: i=1; AJvYcCV1d71Mp0V2F2OAmJEv3w/lxPeznaUe4pRpf6VHIvGdezWL6WBWZRKSAhhI+IqPg7zT5Cgc+GsPvaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5LGGcI8UlWp8M2yToMupnyte2wGENWLvM21r9ovpkTIU6LHh4
	txXy5Qbc5L7AAmO+ktYc80wkBhP4rDo+CsCRyTI8W1XmGe7s5wNd+/YPXFJiHiJDGIQ=
X-Gm-Gg: ASbGncsK0paSEHfmfso6WPlFVQpKCNyvakQtnVViAmt6I3xikNTn30bZdNhWK1nAbLc
	3mMbKIgmd2Y7O/cuGRO3ErUGRhgEn46Ue7OAs3guVV8UcaFkaqWPUFFAPiim2NKPNVQ5+NnIBHN
	DwGMNjlbLRiPS6uIWFbvrIU+DoUYQS57lWgcjeFgkEtIwweUVs+SE5WIQGXAa63T90B4gUFxjAF
	DQHeoX5/Uu4eTut/bxlnMmKCaheUAq9IGgPv1FHWmoSW8zG/4iuw5QtaTAxtJL+cSsr7EYYGRnt
	8KcVjo195A9Ws/pKWj3SdGpHKCyjMxqwe/Z/ZT8U+Dp960mWkoN1FCKzUhI3gEryAxwdI8KsWBx
	LASGN15FyUoA8lgaTk4cGBGPSDUA+M+zCfs61pXJS/JFv069H1raLNjuWaruES3HdTalaP5CJQO
	LNd1BW7FNSDcKepA5JNpc=
X-Google-Smtp-Source: AGHT+IEq1wU/8vuzVnjoUBATSgPDNzjkdQ/9lH3LryiLTNpDHF/z7PYkRPiy89nhGm+aAHjbFqAt/A==
X-Received: by 2002:a05:6e02:214a:b0:42d:8bf0:29f7 with SMTP id e9e14a558f8ab-42f8736a9c8mr198413275ab.9.1760369736542;
        Mon, 13 Oct 2025 08:35:36 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f6c49b522sm3910266173.1.2025.10.13.08.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 08:35:36 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org
Cc: dlan@gentoo.org,
	guodong@riscstar.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	christian.bruel@foss.st.com,
	shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com,
	namcao@linutronix.de,
	thippeswamy.havalige@amd.com,
	inochiama@gmail.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] dt-bindings: pci: spacemit: introduce PCIe host controller
Date: Mon, 13 Oct 2025 10:35:20 -0500
Message-ID: <20251013153526.2276556-4-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251013153526.2276556-1-elder@riscstar.com>
References: <20251013153526.2276556-1-elder@riscstar.com>
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
v2: - Renamed the binding, using "host controller"
    - Added '>' to the description, and reworded it a bit
    - Added reference to /schemas/pci/snps,dw-pcie.yaml
    - Fixed and renamed the compatible string
    - Renamed the PMU property, and fixed its description
    - Consistently omit the period at the end of descriptions
    - Renamed the "global" clock to be "phy"
    - Use interrupts rather than interrupts-extended, and name the
      one interrupt "msi" to make clear its purpose
    - Added a vpcie3v3-supply property
    - Dropped the max-link-speed property
    - Changed additionalProperties to unevaluatedProperties
    - Dropped the label and status property from the example

 .../bindings/pci/spacemit,k1-pcie-host.yaml   | 156 ++++++++++++++++++
 1 file changed, 156 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
new file mode 100644
index 0000000000000..87745d49c53a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
@@ -0,0 +1,156 @@
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
+      - description: Global reset; must be deasserted for PHY to function
+
+  reset-names:
+    items:
+      - const: dbi
+      - const: mstr
+      - const: slv
+      - const: phy
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
+  num-viewport:
+    const: 8
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
+  - num-viewport
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
+                 <&syscon_apmu RESET_PCIE1_SLAVE>,
+                 <&syscon_apmu RESET_PCIE1_GLOBAL>;
+        reset-names = "dbi",
+                      "mstr",
+                      "slv",
+                      "phy";
+        phys = <&pcie1_phy>;
+        vpcie3v3-supply = <&pcie_vcc_3v3>;
+        device_type = "pci";
+        num-viewport = <8>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pcie1_3_cfg>;
+        spacemit,apmu = <&syscon_apmu 0x3d4>;
+    };
-- 
2.48.1


