Return-Path: <linux-pci+bounces-21898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86396A3DA1D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 13:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7CC63A6C88
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 12:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CC71F0E2D;
	Thu, 20 Feb 2025 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8DlLwpP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539B41CD15;
	Thu, 20 Feb 2025 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054610; cv=none; b=E439aSvSBJet6xPpQW092RHgBJz0vSzMZ6wdSJrPY0C0J/ijC6DjhZEZ1u9TcUf+YNziPrITcU25E7/X6up1qNqlmcbuo8d79jjMqhLWqMzXObvbN3o77/Z0+PHPSlLfBaTq0RfDmsRWENBstf3KNXpgXkAIyD83zdWuHT4iW7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054610; c=relaxed/simple;
	bh=2oH03Hf7Yq330CJVN6/UZLAQGmSYLUaXYXtI4buRWmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XH86s+Y7Qki3qscvyjTVYSaOXiDRHZc/2y4BW3+He++W5vBt+Ft5dxDcsPwPoy9iggAZ97noeLbWMZwOyrx5VyFfQi61TycTmKo99l501fcSFQybEHnZ+gB2DrBZPbWtl7TQB7IUXxhCG0zwIFlGGYPaqZzqNYIKkFaPlJlLLsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8DlLwpP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A357C4CED1;
	Thu, 20 Feb 2025 12:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740054610;
	bh=2oH03Hf7Yq330CJVN6/UZLAQGmSYLUaXYXtI4buRWmY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Q8DlLwpP7npsOZSieCsYgxpdejQMuRG2PraJUbrnpVVu7k3VUOYt9GhJaObfc01Rs
	 v5cWXF3SuKDT+/pPFF3cBnzKfkPTc1JbQXKsC/CcjDWXVTll7JB1H8FIGnzwN/bwmD
	 45lxiTfILIXmkLQXR949tASQO69XadBjRi2itwBOCoo/nNlWJwJtUuP+fLg4BBb3cy
	 TNZLd01QVt32B2lGwWTIj+NHR4P+S3/+fhhFknWBCloxE2EkFPTAp8kIUZX3iPIlXj
	 XdExBwI2oVIAj7sdtgo1FVS40PjQrnK9cF9aWDBDIQvGYbYJTcpxCHk1MX779mYZo+
	 MMGMoJsCC29BA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E907C021B1;
	Thu, 20 Feb 2025 12:30:10 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Thu, 20 Feb 2025 13:29:58 +0100
Subject: [PATCH v3] dt-bindings: pci: Convert fsl,mpc83xx-pcie to YAML
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250220-ppcyaml-pci-v3-1-ca94a4f62a85@posteo.net>
X-B4-Tracking: v=1; b=H4sIAEUgt2cC/x3MQQqAIBBA0avIrBPErEVXiRYyztRAmShEId09a
 fkW/1colIUKTKpCpkuKnLGh7xTg5uNKWkIzWGMHY63RKeHjj10nFO0YkQPyyOSgFSkTy/3f5uV
 9P73N1kldAAAA
X-Change-ID: 20250220-ppcyaml-pci-4fccfdcf6fe4
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740054609; l=6184;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=RgTRIY2UX+irY5tpqSZ3owLYm4IerY9v/YGL00K/T60=;
 b=SiGw6Nl9deNVcLRAfAQxTcbtWjLnoLVT6BuXjE7q1wX6JbtWQzDZgsSLH5lPiy8rkyodxTrGE
 eaOstuZRlEQCmen97M9JBylA4s1inXeDiqS2UvpJqn8zh5kUS9CBwEm
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

Formalise the binding for the PCI controllers in the Freescale MPC8xxx
chip family. Information about PCI-X-specific properties was taken from
fsl,pci.txt. The examples were taken from mpc8315erdb.dts and
xpedite5200_xmon.dts.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
V3:
- split out as a single patch
- remove obsolete reference to fsl,pci.txt
- remove unnecessary newline near the end of fsl,mpc8xxx-pci.yaml

V2:
- part of series [PATCH v2 00/12] YAML conversion of several Freescale/PowerPC DT bindings
  Link: https://lore.kernel.org/lkml/20250207-ppcyaml-v2-6-8137b0c42526@posteo.net/
- merge fsl,pci.txt into fsl,mpc8xxx-pci.yaml
- regroup compatible strings, list single-item values in one enum
- trim subject line (remove "binding")
- fix property order to comply with dts coding style
---
 .../devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml   | 113 +++++++++++++++++++++
 Documentation/devicetree/bindings/pci/fsl,pci.txt  |  27 -----
 2 files changed, 113 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml b/Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..28759ab1caaa9c7a475d6d9c61a6607c49dbcbb2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/pci/fsl,mpc8xxx-pci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale MPC83xx PCI/PCI-X/PCIe controllers
+
+description:
+  Binding for the PCI/PCI-X/PCIe host bridges on MPC8xxx SoCs
+
+maintainers:
+  - J. Neuschäfer <j.neuschaefer@gmx.net>
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - fsl,mpc8314-pcie
+          - fsl,mpc8349-pci
+          - fsl,mpc8540-pci
+          - fsl,mpc8548-pcie
+          - fsl,mpc8641-pcie
+      - items:
+          - enum:
+              - fsl,mpc8308-pcie
+              - fsl,mpc8315-pcie
+              - fsl,mpc8377-pcie
+              - fsl,mpc8378-pcie
+          - const: fsl,mpc8314-pcie
+      - items:
+          - const: fsl,mpc8360-pci
+          - const: fsl,mpc8349-pci
+      - items:
+          - const: fsl,mpc8540-pcix
+          - const: fsl,mpc8540-pci
+
+  reg:
+    minItems: 1
+    items:
+      - description: internal registers
+      - description: config space access registers
+
+  clock-frequency: true
+
+  interrupts:
+    items:
+      - description: Consolidated PCI interrupt
+
+  fsl,pci-agent-force-enum:
+    type: boolean
+    description:
+      Typically any Freescale PCI-X bridge hardware strapped into Agent mode is
+      prevented from enumerating the bus. The PrPMC form-factor requires all
+      mezzanines to be PCI-X Agents, but one per system may still enumerate the
+      bus.
+
+      This property allows a PCI-X bridge to be used for bus enumeration
+      despite being strapped into Agent mode.
+
+required:
+  - reg
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pcie@e0009000 {
+        compatible = "fsl,mpc8315-pcie", "fsl,mpc8314-pcie";
+        reg = <0xe0009000 0x00001000>;
+        ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
+                  0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        #interrupt-cells = <1>;
+        device_type = "pci";
+        bus-range = <0 255>;
+        interrupt-map-mask = <0xf800 0 0 7>;
+        interrupt-map = <0 0 0 1 &ipic 1 IRQ_TYPE_LEVEL_LOW
+                         0 0 0 2 &ipic 1 IRQ_TYPE_LEVEL_LOW
+                         0 0 0 3 &ipic 1 IRQ_TYPE_LEVEL_LOW
+                         0 0 0 4 &ipic 1 IRQ_TYPE_LEVEL_LOW>;
+        clock-frequency = <0>;
+    };
+
+  - |
+    pci@ef008000 {
+        compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
+        reg = <0xef008000 0x1000>;
+        ranges = <0x02000000 0 0x80000000 0x80000000 0 0x20000000
+                  0x01000000 0 0x00000000 0xd0000000 0 0x01000000>;
+        #interrupt-cells = <1>;
+        #size-cells = <2>;
+        #address-cells = <3>;
+        device_type = "pci";
+        clock-frequency = <33333333>;
+        interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+        interrupt-map = </* IDSEL */
+                         0xe000 0 0 1 &mpic 2 1
+                         0xe000 0 0 2 &mpic 3 1>;
+        interrupts-extended = <&mpic 24 2>;
+        bus-range = <0 0>;
+        fsl,pci-agent-force-enum;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/pci/fsl,pci.txt b/Documentation/devicetree/bindings/pci/fsl,pci.txt
deleted file mode 100644
index d8ac4a768e7e65b465f83308cc918ec471309dcf..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/pci/fsl,pci.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-* Bus Enumeration by Freescale PCI-X Agent
-
-Typically any Freescale PCI-X bridge hardware strapped into Agent mode
-is prevented from enumerating the bus. The PrPMC form-factor requires
-all mezzanines to be PCI-X Agents, but one per system may still
-enumerate the bus.
-
-The property defined below will allow a PCI-X bridge to be used for bus
-enumeration despite being strapped into Agent mode.
-
-Required properties:
-- fsl,pci-agent-force-enum : There is no value associated with this
-  property. The property itself is treated as a boolean.
-
-Example:
-
-	/* PCI-X bridge known to be PrPMC Monarch */
-	pci0: pci@ef008000 {
-		fsl,pci-agent-force-enum;
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
-		device_type = "pci";
-		...
-		...
-	};

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250220-ppcyaml-pci-4fccfdcf6fe4

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



