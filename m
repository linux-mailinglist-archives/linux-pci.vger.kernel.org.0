Return-Path: <linux-pci+bounces-27931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE4EABB9BF
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8E667A9F64
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 09:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CFA2741D0;
	Mon, 19 May 2025 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EjuQ3hlv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C06272E65
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747647000; cv=none; b=f6GXg3CIPs44WGb+svRWF1KtRj+mGaZRg1SibekfS2X9i5qSP8cAQUouJLjmqWrfE0t1PjU88A/dcH4WShRTV+CVALjc5msuRzGQZzAadNa4fxvxcp852gmzYHzCMlZRxXGmtAqmmW9DirITQJNYqfxCoMQEA9Xe3POtYHbYjZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747647000; c=relaxed/simple;
	bh=o7E4Ge5+IqmPYeWMzVGgLfbb1jj2dtv2UWR5K2wT+dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=dy8gxZI6KQQPw9ZX0yXjUiCHqHg5tDWSGEuFvRiH0c408DrYMiGflIFNvAWYXiH+q4/nlk9AFs+i/ISW4itDhIYmQn9rG/bpohQze68UBI78KL1mIMALl5SqaoKe+fDcSM1a09dJDus7lbK+3CIUS8JEjBDQDR5LeS3ICuLjuko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EjuQ3hlv; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250519092955epoutp0442bdd7fc3e79ea375919625198846cd8~A467mBvMB1579415794epoutp04r
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:29:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250519092955epoutp0442bdd7fc3e79ea375919625198846cd8~A467mBvMB1579415794epoutp04r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1747646995;
	bh=G6bxBd/QHvNMBGkOZD6iu8vb/nuF7pjsH4P9bCfA75s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EjuQ3hlvoeEE2XNt3PjQGUO4dnkZDv1/EbuVeI0wggWL7c87CJZtRF0FUmkHE4QvV
	 2uAoX1/1lZ5RWdzvMYuFaxhyO4xZW4MpIKf5M4axXah20hzezK3qj3lBVZ6nAaUtPp
	 eaAJmW18cggYQ5QGAWftDKk8+ImSj+jrc37hATf0=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250519092955epcas5p20f3de7692b8000623ede42fec91be7af~A467BsoSp2975829758epcas5p2J;
	Mon, 19 May 2025 09:29:55 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.177]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4b1C811dHJz6B9mC; Mon, 19 May
	2025 09:29:53 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250518193248epcas5p2543146c715eb249ea6c2ce3c78d03b34~AtgB1aqiq2822528225epcas5p2u;
	Sun, 18 May 2025 19:32:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250518193248epsmtrp14b16d55e1cf09c0fcbcf001d4c29aedf~AtgBpZoXP2445124451epsmtrp1h;
	Sun, 18 May 2025 19:32:48 +0000 (GMT)
X-AuditID: b6c32a29-566fe7000000223e-34-682a35e02254
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	34.C1.08766.0E53A286; Mon, 19 May 2025 04:32:48 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250518193245epsmtip1d90c3479b8645ecfad9cfb93a33d0c16~Atf_65Vev1176111761epsmtip1H;
	Sun, 18 May 2025 19:32:45 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.or,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com, Shradha Todi
	<shradha.t@samsung.com>
Subject: [PATCH 06/10] dt-bindings: PCI: Add bindings support for Tesla FSD
 SoC
Date: Mon, 19 May 2025 01:01:48 +0530
Message-ID: <20250518193152.63476-7-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250518193152.63476-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSnO4DU60Mg3dneSwezNvGZvF30jF2
	iyVNGRZr9p5jsph/5ByrxY1fbawWK77MZLc42vqf2eLlrHtsFg09v1ktNj2+xmpxedccNouz
	846zWUxY9Y3F4uz3BUwWLX9aWCzWHrnLbnG3pZPV4v+eHewWvYdrLXbeOcHsIOrx+9ckRo+d
	s+6yeyzYVOqxaVUnm8eda3vYPJ5cmc7ksXlJvUffllWMHke+Tmfx+LxJLoArissmJTUnsyy1
	SN8ugStj0cXdrAUbXSruPb/C0sC4VK+LkZNDQsBEYvvZRawgtpDAbkaJNS9LIeKSEp8vrmOC
	sIUlVv57zt7FyAVU84lR4ujyFmaQBJuAlkTj1y4wW0TgBKNE3y1LkCJmgfdMEjMX/ALrFhbw
	l5j6bA0LiM0ioCoxddddxi5GDg5eASuJt/f1QEwJAXmJ/g4JkApOAWuJbeunMkHcYyWx8MlO
	RhCbV0BQ4uTMJ2BTmIHKm7fOZp7AKDALSWoWktQCRqZVjJKpBcW56bnFhgWGeanlesWJucWl
	eel6yfm5mxjBkailuYNx+6oPeocYmTgYDzFKcDArifCu2qyRIcSbklhZlVqUH19UmpNafIhR
	moNFSZxX/EVvipBAemJJanZqakFqEUyWiYNTqoFp8px7U3Nl1e3jn4tFnGy1iMmZdNH7yZxt
	t0ptTtVcPfKn85dkEVeI8O+100Nc1IpedrRcyPa6GLBN7b93yIaM/bKr7a+GBzjd9XXjOtiw
	8caF5OhNDz91xNa5Sl6xYJhwS98lSIe9SXzO/4N7HnNuj/uV1Lyad8v8SfY/fkuXdfCqv7Pa
	szvq8f1HlVO+epXV2XVLpVexdLLKK/atyDxUPc+o0EH6ZoPRwe032c5/aa3iOvcoNDVs+cUw
	k91LOGWOCwZudosstTRjf5MbxCKaUrmo4M+7WWHrD+wy/vysYIfNne/Gsy3klspILja9NSFb
	9ODF9dc9464Jzdk8O6F/Imdqst7nc7YZ/Aej2ASVWIozEg21mIuKEwHXt3VgMwMAAA==
X-CMS-MailID: 20250518193248epcas5p2543146c715eb249ea6c2ce3c78d03b34
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250518193248epcas5p2543146c715eb249ea6c2ce3c78d03b34
References: <20250518193152.63476-1-shradha.t@samsung.com>
	<CGME20250518193248epcas5p2543146c715eb249ea6c2ce3c78d03b34@epcas5p2.samsung.com>

Document the PCIe controller device tree bindings for Tesla FSD
SoC for both RC and EP.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 .../bindings/pci/samsung,exynos-pcie-ep.yaml  |  66 ++++++
 .../bindings/pci/samsung,exynos-pcie.yaml     | 199 ++++++++++++------
 2 files changed, 198 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos-pcie-ep.yaml

diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie-ep.yaml
new file mode 100644
index 000000000000..5d4a9067f727
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie-ep.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/samsung,exynos-pcie-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung SoC series PCIe Endpoint Controller
+
+maintainers:
+  - Shradha Todi <shradha.t@samsung.co>
+
+description: |+
+  Samsung SoCs PCIe endpoint controller is based on the Synopsys DesignWare
+  PCIe IP and thus inherits all the common properties defined in
+  snps,dw-pcie-ep.yaml.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - tesla,fsd-pcie-ep
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - tesla,fsd-pcie-ep
+    then:
+      properties:
+        samsung,syscon-pcie:
+          description: phandle for system control registers, used to
+                       control signals at system level
+
+      required:
+        - samsung,syscon-pcie
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
diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
index f20ed7e709f7..a3803bf0ef84 100644
--- a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
@@ -11,78 +11,113 @@ maintainers:
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
-
-  reg:
-    items:
-      - description: Data Bus Interface (DBI) registers.
-      - description: External Local Bus interface (ELBI) registers.
-      - description: PCIe configuration space region.
-
-  reg-names:
-    items:
-      - const: dbi
-      - const: elbi
-      - const: config
-
-  interrupts:
-    maxItems: 1
-
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
-  phys:
-    maxItems: 1
-
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
-required:
-  - reg
-  - reg-names
-  - interrupts
-  - "#address-cells"
-  - "#size-cells"
-  - "#interrupt-cells"
-  - interrupt-map
-  - interrupt-map-mask
-  - ranges
-  - bus-range
-  - device_type
-  - num-lanes
-  - num-viewport
-  - clocks
-  - clock-names
-  - phys
-  - vdd10-supply
-  - vdd18-supply
+    oneOf:
+      - enum:
+          - samsung,exynos5433-pcie
+          - tesla,fsd-pcie
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
+        samsung,syscon-pcie:
+          description: phandle for system control registers, used to
+                       control signals at system level
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
+        reg:
+          items:
+            - description: controller's own configuration registers
+                           are available.
+            - description: controller's application logic registers
+            - description: configuration registers
+
+        reg-names:
+          items:
+            - const: dbi
+            - const: elbi
+            - const: config
+
+        interrupts:
+          maxItems: 1
+
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
+        phys:
+          maxItems: 1
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
+        - reg
+        - reg-names
+        - interrupts
+        - "#address-cells"
+        - "#size-cells"
+        - "#interrupt-cells"
+        - interrupt-map
+        - interrupt-map-mask
+        - ranges
+        - bus-range
+        - device_type
+        - num-lanes
+        - num-viewport
+        - clocks
+        - clock-names
+        - phys
+        - vdd10-supply
+        - vdd18-supply
 
 unevaluatedProperties: false
 
@@ -116,4 +151,34 @@ examples:
         interrupt-map-mask = <0 0 0 0>;
         interrupt-map = <0 0 0 0 &gic GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
     };
+  - |
+    #include <dt-bindings/clock/fsd-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pcierc0: pcie@16a00000 {
+            compatible = "tesla,fsd-pcie";
+            reg = <0x0 0x16a00000 0x0 0x2000>,
+                  <0x0 0x168b0000 0x0 0x1000>,
+                  <0x0 0x17000000 0x0 0x1000>;
+            reg-names = "dbi", "elbi", "config";
+            ranges =  <0x82000000 0 0x17001000 0 0x17001000 0 0xffefff>;
+            clocks = <&clock_fsys1 PCIE_LINK0_IPCLKPORT_AUX_ACLK>,
+                     <&clock_fsys1 PCIE_LINK0_IPCLKPORT_DBI_ACLK>,
+                     <&clock_fsys1 PCIE_LINK0_IPCLKPORT_MSTR_ACLK>,
+                     <&clock_fsys1 PCIE_LINK0_IPCLKPORT_SLV_ACLK>;
+            clock-names = "aux", "dbi", "mstr", "slv";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            dma-coherent;
+            device_type = "pci";
+            interrupts = <GIC_SPI 115 IRQ_TYPE_EDGE_RISING>;
+            num-lanes = <4>;
+            samsung,syscon-pcie = <&sysreg_fsys1 0x50c>;
+            phys = <&pciephy1>;
+            iommu-map = <0x0 &smmu_imem 0x0 0x10000>;
+            iommu-map-mask = <0x0>;
+        };
+    };
 ...
-- 
2.49.0


