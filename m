Return-Path: <linux-pci+bounces-42055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E363C85877
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 15:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F3C3B2882
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E38B329369;
	Tue, 25 Nov 2025 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odVLnF0s"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E849A17C211;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081912; cv=none; b=MYu4hd6cWUeTOR8CY40FmnzQqYUmxSnYdRhrR0Sc4SO8rTQEgiiK7IvJIjUoOiKWG08aK0+oplTYlrVufKqRKSxpTnL+SB6AMeBapRxDR7nfXKFrnyXkM1/UZijEqz32RfgR9SvSXcArPY+nok4g+5yefzB1Uls+PMSmyKrx4Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081912; c=relaxed/simple;
	bh=FyDBDtcrrQWdwI3hnS/pB+Z0Cw9VWFu3vnv9gtL1Pzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tBhDu1E4qSerDbYTzayw6MQNIs5SStEtyv3QtJujRZvMkpVJar3y4aZ79YCFIN8xOg+3SjWTPtN7k6KYff1xDmqLaD/z8LVdMwvcN6X0Ahd//DWn9jEFulqi0C88/cobGl9lWkJl/EY3gQA6dEi/8m16dvHE2bdvK1e6c4WbUTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odVLnF0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FF84C2BCB8;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764081911;
	bh=FyDBDtcrrQWdwI3hnS/pB+Z0Cw9VWFu3vnv9gtL1Pzc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=odVLnF0scjlNrhsn/vBt9sRJy+ANSn2EQ2pLGo4zqxux71l7xhwykdlvtBDS2oPjW
	 bZ9736PpZn9BSV8Mt7UlXbDTeYmxisclamqsCehxgoMb4QJ5R0kgO9Ij+KrLNaEtGF
	 X55oCpqT5Simb4KRHpFgQkKwPeOlcdor2pB0c58N5o5irw/bpk+MQMa74sIkG5/0ZC
	 PXce3f8ku9rjrR7bhyJPRitnXLIAq+tgGVS0OymjSrzSDNZ3+KZRHZ0NYydtxBeDFH
	 ybZI0dcrsYnY2GK+MSPhxCr+jo/khL6C2MKGco7Li5jeC87miqJhqUdk07E6v8OEai
	 NrDNq6Am28BdA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CEDD0E6F5;
	Tue, 25 Nov 2025 14:45:11 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 25 Nov 2025 20:15:12 +0530
Subject: [PATCH v2 08/10] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key E connector
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-pci-m2-e-v2-8-32826de07cc5@oss.qualcomm.com>
References: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com>
In-Reply-To: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com>
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
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7776;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=LsGXQguEIvUP58Y5FXjG9WlZPEnelHy8ukyjl47FhqQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpJcDywix4o/qWbqg69fbCTdfFwwjg3RdzFKiFN
 gHlI8DHQrOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaSXA8gAKCRBVnxHm/pHO
 9fRHB/9JdOYdNORzpfXaLxa2grUAjr9bG160Ncw7VspOQBbbbAHwgDHlqkyOGGWVZaJy8oiDGhr
 ymS1ZBlFqUudeRlMoRrufcF237G9//bZPqjDxqfwdTL1IDQeBfyAqY0hNpX2t9+ziV8TU5t/1uu
 T8L9d/80OJEItmJ1aLkXgzZEMq3JdMv8CJJx0dpMJE8GL0ltmdVQdxTPJZQZMPwC6XthSH0bmrW
 6iCImpLciFZaeeZ93r0Py4EjcTA5IP5y0RQbC8fYEbF7cEXkqVgNzXrurTNVtTBeHUXRU/PViFc
 UDneR3Adh4b1t/L+UgvTMrxd2md8t47fOXRUrZ72tyVxabwh
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
devices along with additional interfaces like I2C for NFC solution. At any
point of time, the connector can only support either PCIe or SDIO as the
WiFi interface and USB or UART as the BT interface.

The connector provides a primary power supply of 3.3v, along with an
optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
1.8v sideband signaling.

The connector also supplies optional signals in the form of GPIOs for fine
grained power management.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 .../bindings/connector/pcie-m2-e-connector.yaml    | 178 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 179 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
new file mode 100644
index 000000000000..fe2c9a943a21
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
@@ -0,0 +1,178 @@
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
+      port@3:
+        $ref: /schemas/graph.yaml#/properties/port
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
+    description: GPIO controlled connection to W_DISABLE1# signal. This signal
+      is used by the system to disable WiFi radio in the M.2 card. Refer, PCI
+      Express M.2 Specification r4.0, sec 3.1.12.3 for more details.
+    maxItems: 1
+
+  w-disable2-gpios:
+    description: GPIO controlled connection to W_DISABLE2# signal. This signal
+      is used by the system to disable BT radio in the M.2 card. Refer, PCI
+      Express M.2 Specification r4.0, sec 3.1.12.3 for more details.
+    maxItems: 1
+
+  viocfg-gpios:
+    description: GPIO controlled connection to IO voltage configuration
+      (VIO_CFG) signal. This signal is used by the M.2 card to indicate to the
+      host system that the card supports an independent IO voltage domain for
+      the sideband signals. Refer, PCI Express M.2 Specification r4.0, sec
+      3.1.15.1 for more details.
+    maxItems: 1
+
+  uim-power-src-gpios:
+    description: GPIO controlled connection to UIM_POWER_SRC signal. This signal
+      is used when the NFC solution is implemented and receives the power output
+      from WWAN_UIM_PWR signal of the another WWAN M.2 card. Refer, PCI Express
+      M.2 Specification r4.0, sec 3.1.11.1 for more details.
+    maxItems: 1
+
+  uim-power-snk-gpios:
+    description: GPIO controlled connection to UIM_POWER_SNK signal. This signal
+      is used when the NFC solution is implemented and supplies power to the
+      Universal Integrated Circuit Card (UICC). Refer, PCI Express M.2
+      Specification r4.0, sec 3.1.11.2 for more details.
+    maxItems: 1
+
+  uim-swp-gpios:
+    description: GPIO controlled connection to UIM_SWP signal. This signal is
+      used when the NFC solution is implemented and implements the Single Wire
+      Protocol (SWP) interface to the UICC. Refer, PCI Express M.2 Specification
+      r4.0, sec 3.1.11.3 for more details.
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
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                reg = <0>;
+
+                endpoint@0 {
+                    reg = <0>;
+                    remote-endpoint = <&pcie4_port0_ep>;
+                };
+            };
+
+            port@1 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                reg = <1>;
+
+                endpoint@1 {
+                    reg = <1>;
+                    remote-endpoint = <&uart14_ep>;
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 9b3f689d1f50..f707f29d0a37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20478,6 +20478,7 @@ PCIE M.2 POWER SEQUENCING
 M:	Manivannan Sadhasivam <mani@kernel.org>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
 F:	Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
 F:	drivers/power/sequencing/pwrseq-pcie-m2.c
 

-- 
2.48.1



