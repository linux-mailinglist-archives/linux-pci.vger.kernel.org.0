Return-Path: <linux-pci+bounces-32220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A7AB06D20
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 07:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA1817BB3D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 05:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343612749EC;
	Wed, 16 Jul 2025 05:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b="boHpzFKP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A018527991C
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 05:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752643276; cv=none; b=ioK9twTJFAFRmrT8cwC+HT+vmtAb27zMYyO+xaZKiGQUNQ4ptVOnsrk7u90oSxz38tz2GR4pk4GXDjhKThi5dtCmmCpCvP3OGiCF2Ew2e6Iki0PaAgNLSONOKrUx2FHYlqX4gyr1fY1BqNmaZBmQtnSuGjbD5Qq9SWlg+3O+XQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752643276; c=relaxed/simple;
	bh=iJEcfFsiWJ1V9+dLXeuoWVpKyPfbNwN8bvVTcoioenc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WbUTak5bBH3DkiuzOm/i7K59MZ0alTx2Qba7xHFVIN3Ac+BHEkc0QIhcfc6DqCKc/t/2QSpMmT5EjTM64iSIHFVynXItdmGS2b2fn3t//imrM3F/v0wixCwKQVsgjZZWwcAnIRM2efeXhbPhmbbLJbn2GXiW3ofBW1sEnV7X/6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b=boHpzFKP; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2025071605110300b428ed9011820e14
        for <linux-pci@vger.kernel.org>;
        Wed, 16 Jul 2025 07:11:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=oH4biYNRIXbUPcZJxbqF385p1W7crfHf3KjlM5z89+Q=;
 b=boHpzFKPjI/QwcezRqg7XNZkDTmoG0kPBkyLbWqXC/C8+1bD5yGJDmLHLQns8NTpVNil2o
 uaU05s3jQ4IP4gXJVggPCdQj5WyFYqNSw4jk3kIyBJ9g2BgqGOlMpRnS7ki3SGqcw/57bcle
 bapyZmObYxA+QWLce2K0seOTsYQraj9W9wAhMLKFYNS7XjADDNuIa3wiMMqIZtHTWIOwlYpy
 CwbKe8Xqehq3uPabDOD9Aa3d0N9GylYXTMCVO+22V+C4Q9urBS6M+/1bpxxKZEaoFaLyuIJ1
 5FbkXLfye13hyETtrGNCErrHfrqdgeNgkhg1+mTY4zG7W0ZVw3CO8QMw==;
From: huaqian.li@siemens.com
To: s-vadapalli@ti.com
Cc: baocheng.su@siemens.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	diogo.ivo@siemens.com,
	helgaas@kernel.org,
	huaqian.li@siemens.com,
	jan.kiszka@siemens.com,
	kristo@kernel.org,
	krzk+dt@kernel.org,
	kw@linux.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	nm@ti.com,
	robh@kernel.org,
	ssantosh@kernel.org,
	vigneshr@ti.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 1/7] dt-bindings: soc: ti: Add AM65 peripheral virtualization unit
Date: Wed, 16 Jul 2025 13:10:29 +0800
Message-Id: <20250716051035.170988-2-huaqian.li@siemens.com>
In-Reply-To: <20250716051035.170988-1-huaqian.li@siemens.com>
References: <e21c6ead-2bcb-422b-a1b9-eb9dd63b7dc7@ti.com>
 <20250716051035.170988-1-huaqian.li@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

The PVU allows to define a limited set of mappings for incoming DMA
requests to the system memory. It is not a real IOMMU, thus hooked up
under the TI SoC bindings.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
---
 .../bindings/soc/ti/ti,am654-pvu.yaml         | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml
new file mode 100644
index 000000000000..e4a5fc47d674
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) Siemens AG, 2024
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/ti/ti,am654-pvu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI AM654 Peripheral Virtualization Unit
+
+maintainers:
+  - Jan Kiszka <jan.kiszka@siemens.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,am654-pvu
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: cfg
+      - const: tlbif
+
+  interrupts:
+    items:
+      - description: fault interrupt
+
+  interrupt-names:
+    items:
+      - const: pvu
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+
+additionalProperties: false
+
+examples:
+  - |
+    iommu@30f80000 {
+        compatible = "ti,am654-pvu";
+        reg = <0x30f80000 0x1000>,
+              <0x36000000 0x100000>;
+        reg-names = "cfg", "tlbif";
+        interrupts-extended = <&intr_main_navss 390>;
+        interrupt-names = "pvu";
+    };
-- 
2.34.1


