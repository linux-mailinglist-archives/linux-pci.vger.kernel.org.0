Return-Path: <linux-pci+bounces-35090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F77B3B5F4
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 10:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 800517A486B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 08:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A6A28643E;
	Fri, 29 Aug 2025 08:23:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1461273811;
	Fri, 29 Aug 2025 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756455786; cv=none; b=LfuJHf7uVX9zbuB6CHtJ7IdNDAzYIEf7z2JG93D79/vqDNCVrIoT47m8iODiPvxuByJxmbRm3xN9au8EZH3SFwKqHkn+HZ0Bz2Je7EMrX534rD9VbqUZgzZfVP5e5thcB2dndMnbv07CzZgkX/sM2/ayGZVxOv/6kd/mTJkCc6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756455786; c=relaxed/simple;
	bh=xGs36GmUR4Ma64Vpf/dnzJmRSRvQApj2NRbJ7tAqxwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOhUpNgMZQnI4mMSG9pdUPrnGsn3CPaXaWm8dQ9q8jR+achbyfaMec6HDva7uIfH+awfMw0T2fNVlH+j5TL85D9ACWHYhumuOEmhNgp7n1+JZTDnknw+j1e75t2oviU/IfB3kVN1k9erWrrAYQ+mSIip3S1dG0m1r37z0qtw8w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004758DT.eswin.cn (unknown [10.12.96.83])
	by app1 (Coremail) with SMTP id TAJkCgAXLxBQY7Fo2gvFAA--.9196S2;
	Fri, 29 Aug 2025 16:22:42 +0800 (CST)
From: zhangsenchuan@eswincomputing.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de,
	johan+linaro@kernel.org,
	quic_schintav@quicinc.com,
	shradha.t@samsung.com,
	cassel@kernel.org,
	thippeswamy.havalige@amd.com,
	mayank.rana@oss.qualcomm.com,
	inochiama@gmail.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: [PATCH v2 1/2] dt-bindings: PCI: eic7700: Add Eswin eic7700 PCIe host controller
Date: Fri, 29 Aug 2025 16:22:37 +0800
Message-ID: <20250829082237.1064-1-zhangsenchuan@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250829082021.49-1-zhangsenchuan@eswincomputing.com>
References: <20250829082021.49-1-zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgAXLxBQY7Fo2gvFAA--.9196S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1kXr45urWkWryxJFW8WFg_yoWrJryrpF
	WDGFykCr48Xr13Zw48JF1jkF13JanYkFnYyrn7Wa13trZ5ta4qqr43KF13C343Gr1jq34Y
	gFnIvr1xtw17A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRmZXOUUUUU=
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/

From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>

Add Device Tree binding documentation for the ESWIN EIC7700
PCIe controller module,the PCIe controller enables the core
to correctly initialize and manage the PCIe bus and connected
devices.

Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
---
 .../bindings/pci/eswin,eic7700-pcie.yaml      | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml b/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
new file mode 100644
index 000000000000..65f640902b11
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
@@ -0,0 +1,142 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/eswin,eic7700-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Eswin EIC7700 PCIe host controller
+
+maintainers:
+  - Yu Ning <ningyu@eswincomputing.com>
+  - Senchuan Zhang <zhangsenchuan@eswincomputing.com>
+
+description:
+  The PCIe controller on EIC7700 SoC.
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+
+properties:
+  compatible:
+    const: eswin,eic7700-pcie
+
+  reg:
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: config
+      - const: mgmt
+
+  ranges:
+    maxItems: 3
+
+  num-lanes:
+    const: 4
+
+  '#interrupt-cells':
+    const: 1
+
+  interrupts:
+    maxItems: 9
+
+  interrupt-names:
+    items:
+      - const: msi
+      - const: inta
+      - const: intb
+      - const: intc
+      - const: intd
+      - const: inte
+      - const: intf
+      - const: intg
+      - const: inth
+
+  interrupt-map:
+    maxItems: 4
+
+  interrupt-map-mask:
+    items:
+      - const: 0
+      - const: 0
+      - const: 0
+      - const: 7
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: mstr
+      - const: dbi
+      - const: pclk
+      - const: aux
+
+  resets:
+    maxItems: 3
+
+  reset-names:
+    items:
+      - const: cfg
+      - const: powerup
+      - const: pwren
+
+required:
+  - compatible
+  - reg
+  - ranges
+  - num-lanes
+  - interrupts
+  - interrupt-names
+  - interrupt-map-mask
+  - interrupt-map
+  - '#interrupt-cells'
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@54000000 {
+            compatible = "eswin,eic7700-pcie";
+            reg = <0x0 0x54000000 0x0 0x4000000>,
+                  <0x0 0x40000000 0x0 0x800000>,
+                  <0x0 0x50000000 0x0 0x100000>;
+            reg-names = "dbi", "config", "mgmt";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            #interrupt-cells = <1>;
+            ranges = <0x81000000 0x0 0x40800000 0x0 0x40800000 0x0 0x800000>,
+                     <0x82000000 0x0 0x41000000 0x0 0x41000000 0x0 0xf000000>,
+                     <0xc3000000 0x80 0x00000000 0x80 0x00000000 0x2 0x00000000>;
+            bus-range = <0x0 0xff>;
+            clocks = <&clock 562>,
+                     <&clock 563>,
+                     <&clock 564>,
+                     <&clock 565>;
+            clock-names = "mstr", "dbi", "pclk", "aux";
+            resets = <&reset 8 (1 << 0)>,
+                     <&reset 8 (1 << 1)>,
+                     <&reset 8 (1 << 2)>;
+            reset-names = "cfg", "powerup", "pwren";
+            interrupts = <220>, <179>, <180>, <181>, <182>, <183>, <184>, <185>, <186>;
+            interrupt-names = "msi", "inta", "intb", "intc", "intd",
+                              "inte", "intf", "intg", "inth";
+            interrupt-parent = <&plic>;
+            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+            interrupt-map = <0x0 0x0 0x0 0x1 &plic 179>,
+                            <0x0 0x0 0x0 0x2 &plic 180>,
+                            <0x0 0x0 0x0 0x3 &plic 181>,
+                            <0x0 0x0 0x0 0x4 &plic 182>;
+            device_type = "pci";
+            num-lanes = <0x4>;
+        };
+    };
--
2.25.1


