Return-Path: <linux-pci+bounces-44191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E060CFE41A
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 15:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE602300AB10
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 14:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD613321B0;
	Wed,  7 Jan 2026 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YovLkGIx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760CB32E74F;
	Wed,  7 Jan 2026 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795086; cv=none; b=kZUhUOuH7bMI2rJerYNHxicTLvDETCBpWtfaeSOQa5JF5axWxNMuXiYjdkV4ShE9Ge1/ORc4winl2e3p8hG8H6+1kr5rDSbasfAMZlXqP+AzsjOEdb80QOsOfyfG3Cd2zPIohNg+iChmvGGQ6D7EO6nUN9Zk8Fi9yIQOMDj4QIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795086; c=relaxed/simple;
	bh=zJfvRXCYye5682BMelCMtb0AFYNRSb1336iBytN0JdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=idBm3B4nGY6eg6oxelW2xddM8PG3VCBNPUHw7Se+6pTx51Y+/Jdz3eVGrWzRTUHA8O8zhtA3iyrlYpHXNaKvFC8rMWQzAh27jQe2nqCIPoNrC4wcNrBi5IdgoN7ov1rGm770iyob5UG1SfptqRCb0uIh3JJr7r37PMVwbLhaXQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YovLkGIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB485C19422;
	Wed,  7 Jan 2026 14:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767795086;
	bh=zJfvRXCYye5682BMelCMtb0AFYNRSb1336iBytN0JdE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YovLkGIxSaFLHlvoCEUFTqJfUAo9oG3RMHu33YQzGPKoUkADFsworFGBqs8LHRhlY
	 njYCjtTWjPznTYSSDqYpnINg7QBYyXmNzU+Y9ZVqT2JEX+Eb9Q6rlqZN6r4X1kjbXg
	 IriSq+L8hfdjfem/f7xqgJp0ENZtXUZNzr7Ve/6X604ZRbLeQ5/fjyZOwkA7R6Qpbx
	 TEM/5qCo0036PIm2iowgT8AS/TKtSujUjDI6q2pY/JxNW1kqeNGeHakNREiZpBhhGJ
	 s4v5D+XsbT23Zp3rD5fOWYAljxspb3g0eRJ9gV6W2vxxpc+L8NrSlRpPEpT8PEAw99
	 G5arTpmE2Yz4w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0B8CFD637;
	Wed,  7 Jan 2026 14:11:25 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 07 Jan 2026 19:41:24 +0530
Subject: [PATCH v5 2/5] dt-bindings: connector: Add PCIe M.2 Mechanical Key
 M connector
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-pci-m2-v5-2-8173d8a72641@oss.qualcomm.com>
References: <20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com>
In-Reply-To: <20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-pm@vger.kernel.org, linux-ide@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5628;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=YTQhSamgN1w43R48rC+Jx7Y/pUNa3PeiP09cyA1Kc2U=;
 b=owGbwMvMwMUYOl/w2b+J574ynlZLYsiMy+yWqvXe33060sNz9/P+46Vla4x/pNzd9uTnpu9nw
 w0XadqldDIaszAwcjHIiimypC911mr0OH1jSYT6dJhBrEwgUxi4OAVgIsKV7P9TJq36ZsTQsyb1
 ddPrsrSyz62tacs8PLuLf35RjWS/7fZ+ZU5jRIXZIp5XN0seWWVw2Svd8SvSzFylULC952Fduay
 ZCccqr+P6u9eXnnHZHDw/b00eW4rIudfLvWWUncJTQ8NyN6/Nu1Ck3Ocp6W75juGGGOPk/x0Vjp
 H+xa+uGry0z1SaXPQ8fF3b4dwXC9lkP/fq3c1k2LSoJ0PiWtg+juTPuZbNUfu4Hlvy3Iv1fKQ42
 dGx4MZD6Z2N3w5MnbXigbDZjbfyLOL1208Xe+9k1p0t8Og6R2XN/GUtgemun8Wr5l/Y1frb/avG
 nLDH8xQbE1Wcty7VkCqL2ybzbXZ5Z5nVqnypVVvkmOs6AA==
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Add the devicetree binding for PCIe M.2 Mechanical Key M connector defined
in the PCI Express M.2 Specification, r4.0, sec 5.3. This connector
provides interfaces like PCIe and SATA to attach the Solid State Drives
(SSDs) to the host machine along with additional interfaces like USB, and
SMBus for debugging and supplementary features.

The connector provides a primary power supply of 3.3v, along with an
optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
1.8v sideband signaling.

The connector also supplies optional signals in the form of GPIOs for fine
grained power management.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 .../bindings/connector/pcie-m2-m-connector.yaml    | 133 +++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
new file mode 100644
index 000000000000..e912ee6f6a59
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
@@ -0,0 +1,133 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/connector/pcie-m2-m-connector.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PCIe M.2 Mechanical Key M Connector
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
+
+description:
+  A PCIe M.2 M connector node represents a physical PCIe M.2 Mechanical Key M
+  connector. The Mechanical Key M connectors are used to connect SSDs to the
+  host system over PCIe/SATA interfaces. These connectors also offer optional
+  interfaces like USB, SMBus.
+
+properties:
+  compatible:
+    const: pcie-m2-m-connector
+
+  vpcie3v3-supply:
+    description: A phandle to the regulator for 3.3v supply.
+
+  vpcie1v8-supply:
+    description: A phandle to the regulator for VIO 1.8v supply.
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description: OF graph bindings modeling the interfaces exposed on the
+      connector. Since a single connector can have multiple interfaces, every
+      interface has an assigned OF graph port number as described below.
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Host interfaces of the connector
+
+        properties:
+          endpoint@0:
+            $ref: /schemas/graph.yaml#/properties/endpoint
+            description: PCIe interface
+
+          endpoint@1:
+            $ref: /schemas/graph.yaml#/properties/endpoint
+            description: SATA interface
+
+        anyOf:
+          - required:
+              - endpoint@0
+          - required:
+              - endpoint@1
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: USB 2.0 interface
+
+      i2c-parent:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: SMBus interface
+
+    required:
+      - port@0
+
+  clocks:
+    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host system to
+      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.1 for
+      more details.
+    maxItems: 1
+
+  pedet-gpios:
+    description: GPIO input to PEDET signal. This signal is used by the host
+      systems to determine the communication protocol that the M.2 card uses;
+      SATA signaling (low) or PCIe signaling (high). Refer, PCI Express M.2
+      Specification r4.0, sec 3.3.4.2 for more details.
+    maxItems: 1
+
+  viocfg-gpios:
+    description: GPIO output to IO voltage configuration (VIO_CFG) signal. This
+      signal is used by the M.2 card to indicate to the host system that the
+      card supports an independent IO voltage domain for the sideband signals.
+      Refer, PCI Express M.2 Specification r4.0, sec 3.1.15.1 for more details.
+    maxItems: 1
+
+  pwrdis-gpios:
+    description: GPIO input to Power Disable (PWRDIS) signal. This signal is
+      used by the host system to disable power on the M.2 card. Refer, PCI
+      Express M.2 Specification r4.0, sec 3.3.5.2 for more details.
+    maxItems: 1
+
+  pln-gpios:
+    description: GPIO output to Power Loss Notification (PLN#) signal. This
+      signal is use to notify the M.2 card by the host system that the power
+      loss event is expected to occur. Refer, PCI Express M.2 Specification
+      r4.0, sec 3.2.17.1 for more details.
+    maxItems: 1
+
+  plas3-gpios:
+    description: GPIO output to Power Loss Acknowledge (PLA_S3#) signal. This
+      signal is used by the M.2 card to notify the host system, the status of
+      the M.2 card's preparation for power loss.
+    maxItems: 1
+
+required:
+  - compatible
+  - vpcie3v3-supply
+
+additionalProperties: false
+
+examples:
+  # PCI M.2 Key M connector for SSDs with PCIe interface
+  - |
+    connector {
+        compatible = "pcie-m2-m-connector";
+        vpcie3v3-supply = <&vreg_nvme>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                reg = <0>;
+
+                endpoint@0 {
+                    reg = <0>;
+                    remote-endpoint = <&pcie6_port0_ep>;
+                };
+            };
+        };
+    };

-- 
2.48.1



