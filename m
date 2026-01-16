Return-Path: <linux-pci+bounces-45033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CDDD301F6
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 12:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E2A03019B65
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 11:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326403659F3;
	Fri, 16 Jan 2026 11:07:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4DA36165B;
	Fri, 16 Jan 2026 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768561646; cv=none; b=a/eFzk95jbEf5wXL1xszNRDHgrp0MLS6I9TRUDjUqSscqFtSSmzQvR+ofDdBinj+mDHnrmSXhRSGRCJ/OwTAXVoU6KKWqmnvHFsF1vCbbtn+0nw6p1ww8YofVOe/8/1ZzWJ54/PVkYvt0d0QIhfELn7Dz81oZbizJI7n4uCeRfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768561646; c=relaxed/simple;
	bh=XXAQraqrAYpGTQG0r7rH6SgyOFZSbzKK5aveXzq9b74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHajTFJrgscI2wfC4ixqyLoC3sWzggPjWPPpX3XgEpAFC1JK6FxtURzfRgIspp8834v+r9sOQwKhOIMb2UdYUZjkBb9ZKFWGTdeMS+e+QC75z9bPeUTP1hklkf0RtknmxcKoqHKjVMHo5SGwaB+eudZf6R66YaR1AkcThZAnx/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 60GB2fnw031253
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Fri, 16 Jan 2026 19:02:41 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Jan
 2026 19:02:41 +0800
From: Randolph <randolph@andestech.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <jingoohan1@gmail.com>,
        <mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <alex@ghiti.fr>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <ben717@andestech.com>, <inochiama@gmail.com>,
        <thippeswamy.havalige@amd.com>, <namcao@linutronix.de>,
        <shradha.t@samsung.com>, <pjw@kernel.org>,
        <christian.bruel@foss.st.com>, <quic_wenbyao@quicinc.com>,
        <vincent.guittot@linaro.org>, <elder@riscstar.com>,
        <s-vadapalli@ti.com>, <randolph.sklin@gmail.com>,
        <tim609@andestech.com>, Randolph Lin <randolph@andestech.com>
Subject: [PATCH v10 1/4] dt-bindings: PCI: Add Andes QiLai PCIe support
Date: Fri, 16 Jan 2026 19:02:31 +0800
Message-ID: <20260116110234.1908263-2-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116110234.1908263-1-randolph@andestech.com>
References: <20260116110234.1908263-1-randolph@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 60GB2fnw031253

From: Randolph Lin <randolph@andestech.com>

Add the Andes QiLai PCIe node, which includes 3 Root Complexes.
Only one example is required in the DTS bindings YAML file.

Signed-off-by: Randolph Lin <randolph@andestech.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/pci/andestech,qilai-pcie.yaml    | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml b/Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
new file mode 100644
index 000000000000..7eca3be2c8f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/andestech,qilai-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Andes QiLai PCIe host controller
+
+description:
+  Andes QiLai PCIe host controller is based on the Synopsys DesignWare
+  PCI core.
+
+maintainers:
+  - Randolph Lin <randolph@andestech.com>
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
+properties:
+  compatible:
+    const: andestech,qilai-pcie
+
+  reg:
+    items:
+      - description: Data Bus Interface (DBI) registers.
+      - description: APB registers.
+      - description: PCIe configuration space region.
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: apb
+      - const: config
+
+  ranges:
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: msi
+
+required:
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      pcie@80000000 {
+        compatible = "andestech,qilai-pcie";
+        device_type = "pci";
+        reg = <0x0 0x80000000 0x0 0x20000000>,
+              <0x0 0x04000000 0x0 0x00001000>,
+              <0x0 0x00000000 0x0 0x00010000>;
+        reg-names = "dbi", "apb", "config";
+
+        linux,pci-domain = <0>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        ranges = <0x02000000 0x00 0x10000000 0x00 0x10000000 0x0 0xf0000000>,
+                 <0x43000000 0x01 0x00000000 0x01 0x0000000 0x1f 0x00000000>;
+
+        #interrupt-cells = <1>;
+        interrupts = <0xf>;
+        interrupt-names = "msi";
+        interrupt-parent = <&plic0>;
+        interrupt-map-mask = <0 0 0 7>;
+        interrupt-map = <0 0 0 1 &plic0 0xf IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 2 &plic0 0xf IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 3 &plic0 0xf IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 4 &plic0 0xf IRQ_TYPE_LEVEL_HIGH>;
+      };
+    };
+...
-- 
2.34.1


