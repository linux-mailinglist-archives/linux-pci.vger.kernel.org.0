Return-Path: <linux-pci+bounces-33828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23730B21C96
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 07:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DBCE684D62
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 05:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB0E2E54CE;
	Tue, 12 Aug 2025 05:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JeTPDnYu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85BD2E54BB
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 05:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974948; cv=none; b=D9TwDZT0AH45s3VshU7dGL5TE5u95PeXpiyeUuUmb7LuuO6xKjL/613rABQDO6DU7tjuSgqZkPhPHHh8AQ0Mebm4eTAf+jGrZdyd6u9lejnDRTZPz5p/Y+zJR1ph6e6hzz0w3FpEa/m6yvCSDli1vFIiU6c5HpHfMGtUUBH4qIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974948; c=relaxed/simple;
	bh=tv5C5NrFgbEK0Qz216ihnRUh0xGyrEHHx6MTG0wFdsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=txvM5kgAxsr5JyGEtHwDGsEthOmJ4D9PzsD/DlZz2iKVlZRnxawaxRbrJaFQzAKB07rA34hUocILfE4jKFLyshaTlfmHi0ihbZB7IYOR494HvdRSuMMWl/ZtGqFM7g+W5UhD9vlIm7lBr10lbnOkhVqvUIJohXCUh2jKsEm1h2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JeTPDnYu; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250812050225epoutp02d16a59a9de0a48cda0b2dacfb21424fd~a7GoUja691101711017epoutp02V
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 05:02:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250812050225epoutp02d16a59a9de0a48cda0b2dacfb21424fd~a7GoUja691101711017epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754974945;
	bh=S54LpcLjSITXFL38Nc1C+zVT40bjsTQzlIyqclkPzVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JeTPDnYuQFKjUOTf8Qf/JgacAWkUrVaPAAmH0gatq5vLSDCszPks4Do5/rniN7fB9
	 yZBekS8tCKsz8fV8oRIwvUOdA1wrRX3vrHkKhZyZ64XDj35FqGHw15Zu453CsrZriX
	 0LPAoRJHEgU+4LKVWr0O92l/CL0yN3YU1dgHYoB4=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250812050224epcas5p4e05b55a5f45f116cf966dc700093eba8~a7GnpBriA0263302633epcas5p4v;
	Tue, 12 Aug 2025 05:02:24 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.95]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c1KB72z6Rz2SSKp; Tue, 12 Aug
	2025 05:02:23 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250811154725epcas5p428fa3370a32bc2b664a4fd8260078097~awQg8dEdu2612226122epcas5p4y;
	Mon, 11 Aug 2025 15:47:25 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250811154723epsmtip1209187009cea317303c81d1a099486b6~awQeURXHq2560925609epsmtip1Q;
	Mon, 11 Aug 2025 15:47:22 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc: mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com, pankaj.dubey@samsung.com,
	Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v3 07/12] dt-bindings: PCI: Add support for Tesla FSD SoC
Date: Mon, 11 Aug 2025 21:16:33 +0530
Message-ID: <20250811154638.95732-8-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811154638.95732-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250811154725epcas5p428fa3370a32bc2b664a4fd8260078097
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250811154725epcas5p428fa3370a32bc2b664a4fd8260078097
References: <20250811154638.95732-1-shradha.t@samsung.com>
	<CGME20250811154725epcas5p428fa3370a32bc2b664a4fd8260078097@epcas5p4.samsung.com>

Add Tesla FSD SoC support for both RC and EP.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 .../bindings/pci/tesla,fsd-pcie-ep.yaml       | 91 +++++++++++++++++++
 .../bindings/pci/tesla,fsd-pcie.yaml          | 77 ++++++++++++++++
 2 files changed, 168 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/tesla,fsd-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/tesla,fsd-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/tesla,fsd-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/tesla,fsd-pcie-ep.yaml
new file mode 100644
index 000000000000..8dfe0720e6ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/tesla,fsd-pcie-ep.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/tesla,fsd-pcie-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tesla FSD SoC series PCIe Endpoint Controller
+
+maintainers:
+  - Shradha Todi <shradha.t@samsung.com>
+
+description:
+  Tesla FSD SoCs PCIe endpoint controller is based on the Synopsys DesignWare
+  PCIe IP and thus inherits all the common properties defined in
+  snps,dw-pcie-ep.yaml
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
+  phys:
+    maxItems: 1
+
+  samsung,syscon-pcie:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: phandle for system control registers, used to
+                 control signals at system level
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - num-lanes
+  - phys
+  - samsung,syscon-pcie
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
+            phys = <&pciephy1>;
+            samsung,syscon-pcie = <&sysreg_fsys1 0x50c>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/pci/tesla,fsd-pcie.yaml b/Documentation/devicetree/bindings/pci/tesla,fsd-pcie.yaml
new file mode 100644
index 000000000000..533870ab1d73
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/tesla,fsd-pcie.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/tesla,fsd-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tesla FSD SoC series PCIe Host Controller
+
+maintainers:
+  - Shradha Todi <shradha.t@samsung.com>
+
+description:
+  Tesla FSD SoCs PCIe host controller inherits all the common
+  properties defined in samsung,exynos-pcie.yaml
+
+allOf:
+  - $ref: /schemas/pci/samsung,exynos-pcie.yaml#
+
+properties:
+  compatible:
+    const: tesla,fsd-pcie
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
+required:
+  - samsung,syscon-pcie
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/fsd-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcierc1: pcie@16b00000 {
+            compatible = "tesla,fsd-pcie";
+            reg = <0x0 0x16b00000 0x0 0x2000>,
+                  <0x0 0x168c0000 0x0 0x1000>,
+                  <0x0 0x18000000 0x0 0x1000>;
+            reg-names = "dbi", "elbi", "config";
+            ranges =  <0x82000000 0x0 0x18001000 0x0 0x18001000 0x0 0xffefff>;
+            clocks = <&clock_fsys1 PCIE_LINK1_IPCLKPORT_AUX_ACLK>,
+                     <&clock_fsys1 PCIE_LINK1_IPCLKPORT_DBI_ACLK>,
+                     <&clock_fsys1 PCIE_LINK1_IPCLKPORT_MSTR_ACLK>,
+                     <&clock_fsys1 PCIE_LINK1_IPCLKPORT_SLV_ACLK>;
+            clock-names = "aux", "dbi", "mstr", "slv";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            dma-coherent;
+            device_type = "pci";
+            interrupts = <GIC_SPI 117 IRQ_TYPE_EDGE_RISING>;
+            num-lanes = <4>;
+            phys = <&pciephy1>;
+            samsung,syscon-pcie = <&sysreg_fsys1 0x510>;
+        };
+    };
+...
-- 
2.49.0


