Return-Path: <linux-pci+bounces-36763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E32D6B95CAF
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 14:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F5718916C3
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 12:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9DA262FFC;
	Tue, 23 Sep 2025 12:12:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66AF1FBEB0;
	Tue, 23 Sep 2025 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758629548; cv=none; b=KcR/YR5DmK27Lx4+qJoFsKLXMjGByivIpzX5qkHqKftBjwike8NeBIogXvosvqhZAAnDGRmR0k/03g6sh9LmHSis7DqU39CQhPYAcQzlrBmbcchXHPa6WKYuCUjANh0CIwgTYvs7g1K9cjGbsCjHZEIxD7sOytEp1dWcpxyfsZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758629548; c=relaxed/simple;
	bh=/6tcggY9PuJaW18j/AURzVRFMAu5mMPf+O7rN81ULxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3WEtnKDBKVg9o9fiRn7YNBNm4SojXdC2+gRl36KQ/ncjL/e7JXgzAlSlOOCyYFkbJdNnUCeVh/lPKvQDesyzohlOEWJgE5OBT0dz70DEr4qBxqhk0fWzHNSrOnaoS+x4DvlGCIUjjZtZbYd/8zCp1gLfXOAnLlM8wT5MFUlIhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004758DT.eswin.cn (unknown [10.12.96.83])
	by app2 (Coremail) with SMTP id TQJkCgAHmZKTjtJomSnYAA--.60230S2;
	Tue, 23 Sep 2025 20:12:05 +0800 (CST)
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
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Yanghui Ou <ouyanghui@eswincomputing.com>
Subject: [PATCH v3 1/2] dt-bindings: PCI: EIC7700: Add Eswin PCIe host controller
Date: Tue, 23 Sep 2025 20:12:00 +0800
Message-ID: <20250923121200.1235-1-zhangsenchuan@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250923120946.1218-1-zhangsenchuan@eswincomputing.com>
References: <20250923120946.1218-1-zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgAHmZKTjtJomSnYAA--.60230S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4UKr1kCFW7JrW5tF4xJFb_yoWrCF1rpF
	ZxGFy8Wr48Xr13Z3y5XF4jkFnxJwsYkFnYkr1xWa13tr9Yqa4qqw43K3W5Aa43Gr4jq34Y
	qFsIvr1xtw17A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRuHqcUUUUU=
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/

From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>

Add Device Tree binding documentation for the Eswin EIC7700 PCIe
controller module, the PCIe controller enables the core to correctly
initialize and manage the PCIe bus and connected devices.

Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>
Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
---
 .../bindings/pci/eswin,eic7700-pcie.yaml      | 173 ++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml b/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
new file mode 100644
index 000000000000..2f105d09e38e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
@@ -0,0 +1,173 @@
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
+  - Yanghui Ou <ouyanghui@eswincomputing.com>
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
+    maximum: 4
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
+      - const: inta # Assert_INTA
+      - const: intb # Assert_INTB
+      - const: intc # Assert_INTC
+      - const: intd # Assert_INTD
+      - const: inte # Desassert_INTA
+      - const: intf # Desassert_INTB
+      - const: intg # Desassert_INTC
+      - const: inth # Desassert_INTD
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
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: cfg
+      - const: powerup
+
+patternProperties:
+  "^pcie@":
+    type: object
+    $ref: /schemas/pci/pci-pci-bridge.yaml#
+
+    properties:
+      reg:
+        maxItems: 1
+
+      resets:
+        maxItems: 1
+
+      reset-names:
+        items:
+          - const: perst
+
+    required:
+      - reg
+      - ranges
+      - resets
+      - reset-names
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - ranges
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
+            ranges = <0x01000000 0x0 0x40800000 0x0 0x40800000 0x0 0x800000>,
+                     <0x02000000 0x0 0x41000000 0x0 0x41000000 0x0 0xf000000>,
+                     <0x43000000 0x80 0x00000000 0x80 0x00000000 0x2 0x00000000>;
+            bus-range = <0x00 0xff>;
+            clocks = <&clock 203>,
+                     <&clock 204>,
+                     <&clock 205>,
+                     <&clock 206>;
+            clock-names = "mstr", "dbi", "pclk", "aux";
+            resets = <&reset 97>,
+                     <&reset 98>;
+            reset-names = "cfg", "powerup";
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
+            pcie@0 {
+                reg = <0x0 0x0 0x0 0x0 0x0>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
+                device_type = "pci";
+                num-lanes = <4>;
+                resets = <&reset 99>;
+                reset-names = "perst";
+            };
+        };
+    };
-- 
2.25.1


