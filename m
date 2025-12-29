Return-Path: <linux-pci+bounces-43794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 541B3CE6894
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 12:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D2713005EB6
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 11:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ADC2EB5A6;
	Mon, 29 Dec 2025 11:32:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019E22DC344;
	Mon, 29 Dec 2025 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767007937; cv=none; b=SLCIN7KUtReEMWyUzEq7vnUlgE4YTdpA2bXZRzec/6vrT1cpzmvdeMaLoTRVCb2HpJoBrP+i81+rdeaHvKhqHlKuofKPyO3ecfXb0KcpfZh2fSAsoTh3b4bHc4WEAvrJ3BLBf4iuq68AthPdHx9MMcXtKI+BhFab9AfRUCzcO8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767007937; c=relaxed/simple;
	bh=Pbcq19isPFypswc9lypP49kdkmbWbx9SJexhiFp73zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpG1LQz9MCDR7I2Zu3bUhwi7rv6/fjCdftZP4gGnL/7V51b8DwJb+JcnHVLe0m2J03r6QGiQ40AZIeS1f2iPhGSYCN50l6jIPXdB6ELhR/PnbJanil4C6JSGSG4Fz6ycdwFJgMoSlMVRhh3dLjT4/tGfQM3fYxm3zgQGSJad+mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004758DT.eswin.cn (unknown [10.12.96.83])
	by app1 (Coremail) with SMTP id TAJkCgC3sWmkZlJpDMGLAA--.57920S2;
	Mon, 29 Dec 2025 19:31:50 +0800 (CST)
From: zhangsenchuan@eswincomputing.com
To: bhelgaas@google.com,
	mani@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	p.zabel@pengutronix.de,
	jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christian.bruel@foss.st.com,
	mayank.rana@oss.qualcomm.com,
	shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com,
	thippeswamy.havalige@amd.com,
	inochiama@gmail.com,
	Frank.li@nxp.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	ouyanghui@eswincomputing.com,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: [PATCH v9 1/2] dt-bindings: PCI: eic7700: Add Eswin PCIe host controller
Date: Mon, 29 Dec 2025 19:31:34 +0800
Message-ID: <20251229113135.1876-1-zhangsenchuan@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20251229113021.1859-1-zhangsenchuan@eswincomputing.com>
References: <20251229113021.1859-1-zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgC3sWmkZlJpDMGLAA--.57920S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4UKr1kCFW5Gr4fGrWfKrg_yoWrArW5pF
	ZrCFW8Wr48Xr1fAw4UJF1jkF13Ja1vkFnYyr1xW3W3t3s5ta4qqr43KF13J345Gr4jq34Y
	gFnIv34xtw17A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/pci/eswin,eic7700-pcie.yaml      | 167 ++++++++++++++++++
 1 file changed, 167 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml b/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
new file mode 100644
index 000000000000..9c0150834e6d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
@@ -0,0 +1,167 @@
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
+  Eswin EIC7700 SoC PCIe root complex controller is based on the Synopsys
+  DesignWare PCIe IP.
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
+      - const: elbi
+
+  ranges:
+    maxItems: 3
+
+  '#interrupt-cells':
+    const: 1
+
+  interrupt-names:
+    items:
+      - const: msi
+      - const: inta
+      - const: intb
+      - const: intc
+      - const: intd
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
+      - const: phy_reg
+      - const: aux
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: dbi
+      - const: pwr
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
+      num-lanes:
+        maximum: 4
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
+      - num-lanes
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
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
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
+            reg-names = "dbi", "config", "elbi";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            #interrupt-cells = <1>;
+            ranges = <0x01000000 0x0 0x40800000 0x0 0x40800000 0x0 0x800000>,
+                     <0x02000000 0x0 0x41000000 0x0 0x41000000 0x0 0xf000000>,
+                     <0x43000000 0x80 0x00000000 0x80 0x00000000 0x2 0x00000000>;
+            bus-range = <0x00 0xff>;
+            clocks = <&clock 144>,
+                     <&clock 145>,
+                     <&clock 146>,
+                     <&clock 147>;
+            clock-names = "mstr", "dbi", "phy_reg", "aux";
+            resets = <&reset 97>,
+                     <&reset 98>;
+            reset-names = "dbi", "pwr";
+            interrupts = <220>, <179>, <180>, <181>, <182>, <183>, <184>, <185>, <186>;
+            interrupt-names = "msi", "inta", "intb", "intc", "intd";
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


