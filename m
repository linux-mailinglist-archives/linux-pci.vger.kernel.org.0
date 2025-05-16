Return-Path: <linux-pci+bounces-27843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDCAAB9914
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 11:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCFF91BC2E93
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 09:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680C222D4EB;
	Fri, 16 May 2025 09:43:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A24230BE9;
	Fri, 16 May 2025 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388602; cv=none; b=T/GhaqXTtW2xtBXakkaTvKVEf1p0CTDFq7YTK3XDQ19CjExZ2XW/+nxiI0Y9Z305myRzZxwVFdLd9BBZBulNwJET+KkUm9wbHUi/IMl6Q6W9huKk9nS1ovYa0DIZpfUO8MPonwdWhIXtC0m4MfUwt0eRl9h+0BkX2ZoVLhn1tWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388602; c=relaxed/simple;
	bh=iRM0oIfGdVUZc4utRbh1pYtMqsKhE0xXF75fL+lPFd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PP4eScu7GM7Z6TYukoQWqp5UyDzmzUHjZVa0mk2SAqeruCp8+hphufR7QA9mGPPmQcqK3qRT6CnFNT9kFK48/4RNmmyml744z7j/Q7sINxsh0QXlRUoH/PORA559VDQ3BuWKXZ1Xbw5INjjfajT53g++6dhUlHeJlqKKxQNFx2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004758DT.eswin.cn (unknown [10.12.96.83])
	by app1 (Coremail) with SMTP id TAJkCgDX7Q6dCCdozst8AA--.60135S2;
	Fri, 16 May 2025 17:42:55 +0800 (CST)
From: zhangsenchuan@eswincomputing.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.or,
	linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de,
	johan+linaro@kernel.org,
	quic_schintav@quicinc.com,
	shradha.t@samsung.com,
	cassel@kernel.org,
	thippeswamy.havalige@amd.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: [PATCH v1 1/2] dt-bindings: PCI: eic7700: Add Eswin eic7700 PCIe host controller
Date: Fri, 16 May 2025 17:42:48 +0800
Message-ID: <20250516094249.1879-1-zhangsenchuan@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250516094057.1300-1-zhangsenchuan@eswincomputing.com>
References: <20250516094057.1300-1-zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgDX7Q6dCCdozst8AA--.60135S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1kXr45urWkXFyUtF13Jwb_yoWrCFW5pF
	Z8GFykCr48Xr13Zw48JF10kF13JanYkFnYyrn7W3WaqrsYqFyjqr4akF13G343Gr47X34Y
	gFsIvryxtw17A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRByxiUUUUU=
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/

From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>

Add Device Tree binding documentation for the ESWIN EIC7700
PCIe controller module,the PCIe controller enables the core
to correctly initialize and manage the PCIe bus and connected
devices.

Co-developed-by: Yu Ning <ningyu@eswincomputing.com>
Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
---
 .../bindings/pci/eswin,eic7700-pcie.yaml      | 171 ++++++++++++++++++
 1 file changed, 171 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml b/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
new file mode 100644
index 000000000000..e1d150c7c81a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
@@ -0,0 +1,171 @@
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
+description: |
+  The PCIe controller on EIC7700 SoC.
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
+  "#address-cells":
+    const: 3
+  "#size-cells":
+    const: 2
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
+
+  interrupt-controller:
+    type: object
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
+    description: handles to clock for the pcie controller.
+
+  clock-names:
+    items:
+      - const: pcie_aclk
+      - const: pcie_cfg_clk
+      - const: pcie_cr_clk
+      - const: pcie_aux_clk
+    description: the name of each clock.
+
+  resets:
+    description: resets to be used by the controller.
+
+  reset-names:
+    items:
+      - const: pcie_cfg
+      - const: pcie_powerup
+      - const: pcie_pwren
+    description: names of the resets listed in resets property in the same order.
+
+  bus-range:
+    items:
+      - const: 0
+      - const: 0xff
+
+  device_type:
+    const: pci
+
+  ranges: true
+
+  dma-noncoherent: true
+
+  num-lanes:
+    maximum: 4
+
+  numa-node-id:
+    maximum: 0
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - interrupt-parent
+  - interrupt-map-mask
+  - interrupt-map
+  - '#address-cells'
+  - '#size-cells'
+  - '#interrupt-cells'
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - bus-range
+  - dma-noncoherent
+  - num-lanes
+  - ranges
+  - numa-node-id
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie: pcie@54000000 {
+          compatible = "eswin,eic7700-pcie";
+          clocks = <&clock 562>,
+                   <&clock 563>,
+                   <&clock 564>,
+                   <&clock 565>;
+          clock-names = "pcie_aclk", "pcie_cfg_clk", "pcie_cr_clk", "pcie_aux_clk";
+
+          reset-names = "pcie_cfg", "pcie_powerup", "pcie_pwren";
+          resets = <&reset 8 (1 << 0)>,
+                   <&reset 8 (1 << 1)>,
+                   <&reset 8 (1 << 2)>;
+
+          #address-cells = <3>;
+          #size-cells = <2>;
+          #interrupt-cells = <1>;
+
+          reg = <0x0 0x54000000 0x0 0x4000000>,
+                <0x0 0x40000000 0x0 0x800000>,
+                <0x0 0x50000000 0x0 0x100000>;
+          reg-names = "dbi", "config", "mgmt";
+          device_type = "pci";
+
+          bus-range = <0x0 0xff>;
+          ranges = <0x81000000 0x0 0x40800000 0x0 0x40800000 0x0 0x800000>,
+                  <0x82000000 0x0 0x41000000 0x0 0x41000000 0x0 0xf000000>,
+                  <0xc3000000 0x80 0x00000000 0x80 0x00000000 0x2 0x00000000>;
+
+          num-lanes = <0x4>;
+          interrupts = <220>, <179>, <180>, <181>, <182>, <183>, <184>, <185>, <186>;
+          interrupt-names = "msi", "inta", "intb", "intc", "intd";
+          interrupt-parent = <&plic>;
+          interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+          interrupt-map = <0x0 0x0 0x0 0x1 &plic 179>,
+                          <0x0 0x0 0x0 0x2 &plic 180>,
+                          <0x0 0x0 0x0 0x3 &plic 181>,
+                          <0x0 0x0 0x0 0x4 &plic 182>;
+          status = "disabled";
+          numa-node-id = <0>;
+          dma-noncoherent;
+        };
+    };
--
2.25.1


