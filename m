Return-Path: <linux-pci+bounces-30676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF98AE9438
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 04:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE9F4E01C8
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 02:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3421F4168;
	Thu, 26 Jun 2025 02:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NQI2GrfH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE987205502
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 02:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750905461; cv=none; b=cY1We+bIrprHVKy/p3ZcdffGmqvpAUlhaL26QMOZP3tKiQj5kwSCsJg6xiOBltxu5RJSDeLm+c5KRLgjNq2Q2qcnDvxIIwAhU6duR7siT0PLdNcRX1W54MvVyvNgoUR1vOy2cxQEUnC8hznt+grNnJOPUEafIhf3so6C/lX8MeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750905461; c=relaxed/simple;
	bh=ckoT+BAsDnesgMAyQLZgXD6OEaDPUBN9XuHucBgLCfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=XtJdjbHIk0ioC6xKasWHxknPcml0IIxMRL3fpWzi8h4uHGNfNZXDvUAPTruYeCTjXAP0P/DmpnQM2rbWWrmfJ7OZ7Q0Zrnv8F6P+2rDDzRTCWLbDqa7ZNJEekh6GWK5NrjxGgmCZbvWptRR3uWWU6PEtuvf9E6GUeBvPkIVsi1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NQI2GrfH; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250626023738epoutp02663adff93ae6f0eba4881b6bd4467f2b~MdzzUIAiA2403124031epoutp02S
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 02:37:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250626023738epoutp02663adff93ae6f0eba4881b6bd4467f2b~MdzzUIAiA2403124031epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750905458;
	bh=GpGKFLRj3xJyZP39aLIHsF6XUTrUyDMCZLKHf9N0NXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NQI2GrfH+ugdo2+SQjb4Xv9WFFbOOCF6WC8fiUZdKoUA+bESN5NMMe8xyxLmjw5KW
	 fH8W1gWNFKcJIAkkQBkzUz0TmihufnPjmd+8iV/miE402XAHuzodzVHprgCNxE6se0
	 GcY363reFu4YpLudcf/cVEVG/DVo96n5cLwRaaf0=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250626023737epcas5p15fd06f0fa7ae9bf46ed8b50e2fa87799~MdzyjXME42161521615epcas5p1I;
	Thu, 26 Jun 2025 02:37:37 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.179]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bSNBl2WwVz3hhT7; Thu, 26 Jun
	2025 02:37:35 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250625165315epcas5p19f081c8a0e2e7dc87698577cc2d460ca~MV1kUqxpO1882618826epcas5p1Y;
	Wed, 25 Jun 2025 16:53:15 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250625165312epsmtip2751afed46e11b808e69c2a78a34ac3c0~MV1hjobbZ1750917509epsmtip2T;
	Wed, 25 Jun 2025 16:53:12 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-fsd@tesla.com
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com, pankaj.dubey@samsung.com,
	Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v2 06/10] dt-bindings: PCI: Add bindings support for Tesla
 FSD SoC
Date: Wed, 25 Jun 2025 22:22:25 +0530
Message-ID: <20250625165229.3458-7-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625165229.3458-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250625165315epcas5p19f081c8a0e2e7dc87698577cc2d460ca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250625165315epcas5p19f081c8a0e2e7dc87698577cc2d460ca
References: <20250625165229.3458-1-shradha.t@samsung.com>
	<CGME20250625165315epcas5p19f081c8a0e2e7dc87698577cc2d460ca@epcas5p1.samsung.com>

Document the PCIe controller device tree bindings for Tesla FSD
SoC for both RC and EP.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 .../bindings/pci/samsung,exynos-pcie.yaml     | 121 ++++++++++++------
 .../bindings/pci/tesla,fsd-pcie-ep.yaml       |  91 +++++++++++++
 2 files changed, 176 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/tesla,fsd-pcie-ep.yaml

diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
index f20ed7e709f7..595156759b06 100644
--- a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
@@ -11,16 +11,15 @@ maintainers:
   - Jaehoon Chung <jh80.chung@samsung.com>
 
 description: |+
-  Exynos5433 SoC PCIe host controller is based on the Synopsys DesignWare
+  Samsung SoCs PCIe host controller is based on the Synopsys DesignWare
   PCIe IP and thus inherits all the common properties defined in
   snps,dw-pcie.yaml.
 
-allOf:
-  - $ref: /schemas/pci/snps,dw-pcie.yaml#
-
 properties:
   compatible:
-    const: samsung,exynos5433-pcie
+    enum:
+      - samsung,exynos5433-pcie
+      - tesla,fsd-pcie
 
   reg:
     items:
@@ -37,52 +36,102 @@ properties:
   interrupts:
     maxItems: 1
 
-  clocks:
-    items:
-      - description: PCIe bridge clock
-      - description: PCIe bus clock
-
-  clock-names:
-    items:
-      - const: pcie
-      - const: pcie_bus
-
   phys:
     maxItems: 1
 
-  vdd10-supply:
-    description:
-      Phandle to a regulator that provides 1.0V power to the PCIe block.
-
-  vdd18-supply:
-    description:
-      Phandle to a regulator that provides 1.8V power to the PCIe block.
-
-  num-lanes:
-    const: 1
-
-  num-viewport:
-    const: 3
-
 required:
   - reg
   - reg-names
   - interrupts
   - "#address-cells"
   - "#size-cells"
-  - "#interrupt-cells"
-  - interrupt-map
-  - interrupt-map-mask
   - ranges
-  - bus-range
   - device_type
   - num-lanes
-  - num-viewport
   - clocks
   - clock-names
   - phys
-  - vdd10-supply
-  - vdd18-supply
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - tesla,fsd-pcie
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+
+        clock-names:
+          items:
+            - const: aux
+            - const: dbi
+            - const: mstr
+            - const: slv
+
+        samsung,syscon-pcie:
+          $ref: /schemas/types.yaml#/definitions/phandle-array
+          description: phandle for system control registers, used to
+                       control signals at system level
+
+        num-lanes:
+          maximum: 4
+
+      required:
+        - samsung,syscon-pcie
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos5433-pcie
+    then:
+      properties:
+        clocks:
+          items:
+            - description: pcie bridge clock
+            - description: pcie bus clock
+
+        clock-names:
+          items:
+            - const: pcie
+            - const: pcie_bus
+
+        vdd10-supply:
+          description:
+            phandle to a regulator that provides 1.0v power to the pcie block.
+
+        vdd18-supply:
+          description:
+            phandle to a regulator that provides 1.8v power to the pcie block.
+
+        num-lanes:
+          const: 1
+
+        num-viewport:
+          const: 3
+
+        assigned-clocks:
+          maxItems: 2
+
+        assigned-clock-parents:
+          maxItems: 2
+
+        assigned-clock-rates:
+          maxItems: 2
+
+      required:
+        - "#interrupt-cells"
+        - interrupt-map
+        - interrupt-map-mask
+        - bus-range
+        - num-viewport
+        - vdd10-supply
+        - vdd18-supply
 
 unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/pci/tesla,fsd-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/tesla,fsd-pcie-ep.yaml
new file mode 100644
index 000000000000..f85615a0225d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/tesla,fsd-pcie-ep.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/tesla,fsd-pcie-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung SoC series PCIe Endpoint Controller
+
+maintainers:
+  - Shradha Todi <shradha.t@samsung.com>
+
+description: |+
+  Samsung SoCs PCIe endpoint controller is based on the Synopsys DesignWare
+  PCIe IP and thus inherits all the common properties defined in
+  snps,dw-pcie-ep.yaml.
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
+
+properties:
+  compatible:
+    const: tesla,fsd-pcie-ep
+
+  reg:
+    maxItems: 4
+
+  reg-names:
+    items:
+      - const: elbi
+      - const: dbi
+      - const: dbi2
+      - const: addr_space
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: aux
+      - const: dbi
+      - const: mstr
+      - const: slv
+
+  num-lanes:
+    maximum: 4
+
+  samsung,syscon-pcie:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: phandle for system control registers, used to
+                 control signals at system level
+
+  phys:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - num-lanes
+  - samsung,syscon-pcie
+  - phys
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/fsd-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pcieep0: pcie-ep@16a00000 {
+            compatible = "tesla,fsd-pcie-ep";
+            reg = <0x0 0x168b0000 0x0 0x1000>,
+                  <0x0 0x16a00000 0x0 0x2000>,
+                  <0x0 0x16a01000 0x0 0x80>,
+                  <0x0 0x17000000 0x0 0xff0000>;
+            reg-names = "elbi", "dbi", "dbi2", "addr_space";
+            clocks = <&clock_fsys1 PCIE_LINK0_IPCLKPORT_AUX_ACLK>,
+                     <&clock_fsys1 PCIE_LINK0_IPCLKPORT_DBI_ACLK>,
+                     <&clock_fsys1 PCIE_LINK0_IPCLKPORT_MSTR_ACLK>,
+                     <&clock_fsys1 PCIE_LINK0_IPCLKPORT_SLV_ACLK>;
+            clock-names = "aux", "dbi", "mstr", "slv";
+            num-lanes = <4>;
+            samsung,syscon-pcie = <&sysreg_fsys1 0x50c>;
+            phys = <&pciephy1>;
+        };
+    };
+...
-- 
2.49.0


