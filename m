Return-Path: <linux-pci+bounces-31870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80926B00B11
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 20:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF08218902A5
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 18:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A0F2FCE08;
	Thu, 10 Jul 2025 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3i5M28W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194DB2FC3C9;
	Thu, 10 Jul 2025 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752170920; cv=none; b=hsURn3gjdqmwtkx5kSE4PTRR8nF98En3kwTrzEvM/ZRufzTEDpWvBx9OdsUEEzWt3ztYPidI50RsxHmryuEzWGBpvR6kNvK8Qx2v9i2gq7EReUnhMslKwl6FubVpCqGFNjVoK+QmxdHTKtKcjJzAoHGQU/eDisOV6hfV7qky9jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752170920; c=relaxed/simple;
	bh=1hd1i9kV4lNTqb908Co0JvC+qqj2MI2yuG0ZybZcSPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u+M3W+iiaxObGqv6uMhWea4dl6UBsZdPCV9bULj4NIcnwhUaPVPJQlHYGQHVWfQNEMq9l/XxfE8yoeIQNEjKsTHk6sVRx4gGSTb79b+IJIhBcgKxESbmZUc43qoSg+5a/agMLycXZTjZ4xeR+rBfKnsjGE0K3e5uH8sJwmyJoCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3i5M28W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FB8C4CEF1;
	Thu, 10 Jul 2025 18:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752170920;
	bh=1hd1i9kV4lNTqb908Co0JvC+qqj2MI2yuG0ZybZcSPg=;
	h=From:To:Cc:Subject:Date:From;
	b=a3i5M28W9FR+Zpl2UNCaMv9paEbRXy9sa+SswdquJfvC7taBy+Lp69NctSrRQ/g3M
	 j1/9R6GRNG9eEYwyAtNsWcjkbnU1a3FoSHifHhXolT3os3PCwo5ea1JYeBf4T1Kc3Z
	 s5s4VFEJ3L/gmcK9mKQKGMTH+4OLNZEsDAzdjCPlGQ28JaMZRIAS2S1BPulHDxQQJu
	 Z8kJOuoTvKdWxVhEB2kyLXr7m81/oyKXhd/wp1VOJounX45qAONZNM+7K2DmkWCqaV
	 SYzTyjZnIu0BTTkfZPX6OiDQt4bzcuf7RjCKtAenmSkJfCrv8wv+6ceURbsl1wgQsm
	 Exc5/NOBFAnqQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jonathan Chocron <jonnyc@amazon.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: Convert amazon,al-alpine-v[23]-pcie to DT schema
Date: Thu, 10 Jul 2025 13:08:23 -0500
Message-ID: <20250710180825.2971248-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Amazon Alpine PCIe binding to DT schema format. It's a
straight forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../pci/amazon,al-alpine-v3-pcie.yaml         | 71 +++++++++++++++++++
 .../devicetree/bindings/pci/pcie-al.txt       | 46 ------------
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
 MAINTAINERS                                   |  2 +-
 4 files changed, 73 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/amazon,al-alpine-v3-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/pcie-al.txt

diff --git a/Documentation/devicetree/bindings/pci/amazon,al-alpine-v3-pcie.yaml b/Documentation/devicetree/bindings/pci/amazon,al-alpine-v3-pcie.yaml
new file mode 100644
index 000000000000..45244cad5f30
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/amazon,al-alpine-v3-pcie.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/amazon,al-alpine-v3-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amazon Annapurna Labs Alpine v3 PCIe Host Bridge
+
+maintainers:
+  - Jonathan Chocron <jonnyc@amazon.com>
+
+description:
+  Amazon's Annapurna Labs PCIe Host Controller is based on the Synopsys
+  DesignWare PCI controller.
+
+allOf:
+  - $ref: snps,dw-pcie.yaml#
+
+properties:
+  compatible:
+    enum:
+      - amazon,al-alpine-v2-pcie
+      - amazon,al-alpine-v3-pcie
+
+  reg:
+    items:
+      - description: PCIe ECAM space
+      - description: AL proprietary registers
+      - description: Designware PCIe registers
+
+  reg-names:
+    items:
+      - const: config
+      - const: controller
+      - const: dbi
+
+  interrupts:
+    maxItems: 1
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@fb600000 {
+            compatible = "amazon,al-alpine-v3-pcie";
+            reg = <0x0 0xfb600000 0x0 0x00100000
+                  0x0 0xfd800000 0x0 0x00010000
+                  0x0 0xfd810000 0x0 0x00001000>;
+            reg-names = "config", "controller", "dbi";
+            bus-range = <0 255>;
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            #interrupt-cells = <1>;
+            interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-map-mask = <0x00 0 0 7>;
+            interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>; /* INTa */
+            ranges = <0x02000000 0x0 0xc0010000 0x0 0xc0010000 0x0 0x07ff0000>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/pcie-al.txt b/Documentation/devicetree/bindings/pci/pcie-al.txt
deleted file mode 100644
index 2ad1fe466eab..000000000000
--- a/Documentation/devicetree/bindings/pci/pcie-al.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-* Amazon Annapurna Labs PCIe host bridge
-
-Amazon's Annapurna Labs PCIe Host Controller is based on the Synopsys DesignWare
-PCI core. It inherits common properties defined in
-Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
-
-Properties of the host controller node that differ from it are:
-
-- compatible:
-	Usage: required
-	Value type: <stringlist>
-	Definition: Value should contain
-			- "amazon,al-alpine-v2-pcie" for alpine_v2
-			- "amazon,al-alpine-v3-pcie" for alpine_v3
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: Register ranges as listed in the reg-names property
-
-- reg-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: Must include the following entries
-			- "config"	PCIe ECAM space
-			- "controller"	AL proprietary registers
-			- "dbi"		Designware PCIe registers
-
-Example:
-
-	pcie-external0: pcie@fb600000 {
-		compatible = "amazon,al-alpine-v3-pcie";
-		reg = <0x0 0xfb600000 0x0 0x00100000
-		       0x0 0xfd800000 0x0 0x00010000
-		       0x0 0xfd810000 0x0 0x00001000>;
-		reg-names = "config", "controller", "dbi";
-		bus-range = <0 255>;
-		device_type = "pci";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		#interrupt-cells = <1>;
-		interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-map-mask = <0x00 0 0 7>;
-		interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>; /* INTa */
-		ranges = <0x02000000 0x0 0xc0010000 0x0 0xc0010000 0x0 0x07ff0000>;
-	};
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 69e82f438f58..b3216141881c 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -108,7 +108,7 @@ properties:
             - description: See native 'dbi' CSR region for details.
               enum: [ ctrl ]
             - description: See native 'elbi/app' CSR region for details.
-              enum: [ apb, mgmt, link, ulreg, appl ]
+              enum: [ apb, mgmt, link, ulreg, appl, controller ]
             - description: See native 'atu' CSR region for details.
               enum: [ atu_dma ]
             - description: Syscon-related CSR regions.
diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa16..17085b8a393f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19232,7 +19232,7 @@ PCIE DRIVER FOR AMAZON ANNAPURNA LABS
 M:	Jonathan Chocron <jonnyc@amazon.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/pcie-al.txt
+F:	Documentation/devicetree/bindings/pci/amazon,al-alpine-v3-pcie.yaml
 F:	drivers/pci/controller/dwc/pcie-al.c
 
 PCIE DRIVER FOR AMLOGIC MESON
-- 
2.47.2


