Return-Path: <linux-pci+bounces-44520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0321DD140D8
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 17:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8416930D1BE0
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 16:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299BF369234;
	Mon, 12 Jan 2026 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMBdNXdC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FCB36656A;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235313; cv=none; b=h3rkoW+AFjXWtzeyWr+mFx5ty5mq0ShacyG3oh0Jyx9SGsGdqHofEVY7Lv1OPgD1N39MWaUcefuhhCb6up4Uk8qyv7390PrdOgD6nonxaE1cAEaZobzmWXZSuLBeq1JHr5mp0jZnUVMtPe45RMp+8gSV/4jS8KwyrJwj5Kp8wiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235313; c=relaxed/simple;
	bh=dk4mLqGB8HV/CRsqSjV+YvmEuqYCijETIhOorvXYALk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A7eAu5wm3cbEC1iwiMubenNTJoU8C8FHCcdc4B96OLeCzADKa5u/hAp8eeRH9ivmVb/byOl61hZwegOlwGN6IF2+9nV45uVYUN1kTkre0fPx14+NSAB0TdSApkZQINza9cyhs6A/+UY+jWdMLm1GGobm2tCp9iHs5HVCoRuXGc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMBdNXdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78ECAC19422;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768235313;
	bh=dk4mLqGB8HV/CRsqSjV+YvmEuqYCijETIhOorvXYALk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uMBdNXdC2udhZv1Km1kpI8noWQQGQczFPNGoELzZ6RVtV8ZqncFTdfMLnjh3a28eW
	 YKblJ9zenujxwwEkQDgJ2Qq13oROLosr20/+OzPFY3NWAdIbs0/bw/rnK9VnmhQSN1
	 IPR0B0dPG38MlSS8c8WXvJFK9R4psLtlqQkpwImkOMmZL31J0Fb3vZcHpW/rlQxrLc
	 H7MwVxoZq/ZKb1mQ4SAvvG31eqTsxKyiI7D8f6WAe27LGxNRLTupvCw0rM8h9kM5IW
	 VLXVejfb+s5PJozbq6/EyYlrwkDumSSOFWmzegZNDnRYV+0h3iY9A3OoH6hUfDZcRe
	 nz+GoKfsyUgEw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E571C9EC7A;
	Mon, 12 Jan 2026 16:28:33 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 12 Jan 2026 21:56:04 +0530
Subject: [PATCH v4 5/9] dt-bindings: connector: Add PCIe M.2 Mechanical Key
 E connector
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-pci-m2-e-v4-5-eff84d2c6d26@oss.qualcomm.com>
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
In-Reply-To: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-acpi@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6614;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=XIar5qWWuuTCWWImKyuSAf8zg9fVNlxonQh07PPLrYk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpZSEtI+N5yAGS8NFBbCK+49S6Jd6/q1Fr+L6AM
 yL5mbWHci+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWUhLQAKCRBVnxHm/pHO
 9QL6B/4u5cfFebS4gsyqSm4c7wM0kc7PVl/RQ7clr/x/roKHYGtl0lmFzBd1bbHQfNbI13VQAPy
 SzqWiJ8Uxf66U2NweE8lQ1j18Pl/fUcgkyn7fVabjJ26jkGmDy5i5Js0Y8AVVdnvKprk6dWC7tA
 10YyLynB8cLUSw7uG5Fm9CymdrrCXSn6ykDO0qIspJpwo4zEEO85XfweSlSwB9tZdfvDvs2byWa
 S1XyWtl0bqZ68a4nSdQ4XDOwDxKqOsLazcizJt57D18Wksc2jRft1auSjL4kc42iEOit9IHe2Lz
 qMo4czTh3LEX0rU2ua3TtXrEP/i5eCHpqA7fwRHSF1AslqH7
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Add the devicetree binding for PCIe M.2 Mechanical Key E connector defined
in the PCI Express M.2 Specification, r4.0, sec 5.1.2. This connector
provides interfaces like PCIe or SDIO to attach the WiFi devices to the
host machine, USB or UART+PCM interfaces to attach the Bluetooth (BT)
devices. Spec also provides an optional interface to connect the UIM card,
but that is not covered in this binding.

The connector provides a primary power supply of 3.3v, along with an
optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
1.8v sideband signaling.

The connector also supplies optional signals in the form of GPIOs for fine
grained power management.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 .../bindings/connector/pcie-m2-e-connector.yaml    | 154 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 155 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
new file mode 100644
index 000000000000..b65b39ddfd19
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
@@ -0,0 +1,154 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/connector/pcie-m2-e-connector.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PCIe M.2 Mechanical Key E Connector
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
+
+description:
+  A PCIe M.2 E connector node represents a physical PCIe M.2 Mechanical Key E
+  connector. Mechanical Key E connectors are used to connect Wireless
+  Connectivity devices including combinations of Wi-Fi, BT, NFC to the host
+  machine over interfaces like PCIe/SDIO, USB/UART+PCM, and I2C.
+
+properties:
+  compatible:
+    const: pcie-m2-e-connector
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
+        description: Connector interfaces for Wi-Fi
+
+        properties:
+          endpoint@0:
+            $ref: /schemas/graph.yaml#/properties/endpoint
+            description: PCIe interface
+
+          endpoint@1:
+            $ref: /schemas/graph.yaml#/properties/endpoint
+            description: SDIO interface
+
+        anyOf:
+          - required:
+              - endpoint@0
+          - required:
+              - endpoint@1
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Connector interfaces for BT
+
+        properties:
+          endpoint@0:
+            $ref: /schemas/graph.yaml#/properties/endpoint
+            description: USB 2.0 interface
+
+          endpoint@1:
+            $ref: /schemas/graph.yaml#/properties/endpoint
+            description: UART interface
+
+        anyOf:
+          - required:
+              - endpoint@0
+          - required:
+              - endpoint@1
+
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: PCM/I2S interface
+
+      i2c-parent:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: I2C interface
+
+    oneOf:
+      - required:
+          - port@0
+
+  clocks:
+    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host system to
+      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.1 for
+      more details.
+    maxItems: 1
+
+  w-disable1-gpios:
+    description: GPIO input to W_DISABLE1# signal. This signal is used by the
+      system to disable WiFi radio in the M.2 card. Refer, PCI Express M.2
+      Specification r4.0, sec 3.1.12.3 for more details.
+    maxItems: 1
+
+  w-disable2-gpios:
+    description: GPIO input to W_DISABLE2# signal. This signal is used by the
+      system to disable WiFi radio in the M.2 card. Refer, PCI Express M.2
+      Specification r4.0, sec 3.1.12.3 for more details.
+    maxItems: 1
+
+  viocfg-gpios:
+    description: GPIO output to IO voltage configuration (VIO_CFG) signal. This
+      signal is used by the M.2 card to indicate to the host system that the
+      card supports an independent IO voltage domain for the sideband signals.
+      Refer, PCI Express M.2 Specification r4.0, sec 3.1.15.1 for more details.
+    maxItems: 1
+
+required:
+  - compatible
+  - vpcie3v3-supply
+
+additionalProperties: false
+
+examples:
+  # PCI M.2 Key E connector for Wi-Fi/BT with PCIe/UART interfaces
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    connector {
+        compatible = "pcie-m2-e-connector";
+        vpcie3v3-supply = <&vreg_wcn_3p3>;
+        vpcie1v8-supply = <&vreg_l15b_1p8>;
+        w-disable1-gpios = <&tlmm 117 GPIO_ACTIVE_LOW>;
+        w-disable2-gpios = <&tlmm 116 GPIO_ACTIVE_LOW>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                endpoint@0 {
+                    reg = <0>;
+                    remote-endpoint = <&pcie4_port0_ep>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                endpoint@1 {
+                    reg = <1>;
+                    remote-endpoint = <&uart14_ep>;
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 2eb7b6d26573..451c54675b24 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20795,6 +20795,7 @@ PCIE M.2 POWER SEQUENCING
 M:	Manivannan Sadhasivam <mani@kernel.org>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
 F:	Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
 F:	drivers/power/sequencing/pwrseq-pcie-m2.c
 

-- 
2.48.1



