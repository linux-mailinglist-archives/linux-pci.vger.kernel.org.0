Return-Path: <linux-pci+bounces-36846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4C2B9996B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 13:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABE21883131
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 11:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5292FD7AC;
	Wed, 24 Sep 2025 11:33:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443AF2F1FC8;
	Wed, 24 Sep 2025 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758713612; cv=none; b=nkvwBbrp0DRnwxjz/Fg5ARURL57Js0jHD+xoh0TCM2on/OPWHSN8zpdLVELFotxQmXlhLX+Hr8KoQLJbnqt9E+7epElYkcEl0LXaODCJDIfcNb3rhyn0u9Rii9N/5p0yoj0cMilekgv99rb8d0msz8akJ8dTRuaCuGVCv/2W+4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758713612; c=relaxed/simple;
	bh=BY5b4n/rxibxHMpl7oAQTXxd/i7JCD1RbaziMafrpDM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RoW+YfhdB/Z2PD44mku1SsahGPxJNW92g9KbyYkojpMN5UgGe3lqGrXQ68nIxyQkSnpVao/it70MPUe6E2Mwh+hlLXatqruhk7yfcVx0spBmdbsBLs5krogmT0LX9+PgxWNZjMdu53O6dWVKHE2S6TX1pP4Uff580t5fgSTaoi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 58OBSUKS074424
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 19:28:30 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Wed, 24 Sep 2025
 19:28:30 +0800
From: Randolph Lin <randolph@andestech.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <jingoohan1@gmail.com>,
        <mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <alex@ghiti.fr>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <ben717@andestech.com>, <inochiama@gmail.com>,
        <thippeswamy.havalige@amd.com>, <namcao@linutronix.de>,
        <shradha.t@samsung.com>, <randolph.sklin@gmail.com>,
        <tim609@andestech.com>, Randolph Lin <randolph@andestech.com>
Subject: [PATCH v4 2/5] dt-bindings: PCI: Add Andes QiLai PCIe support
Date: Wed, 24 Sep 2025 19:28:17 +0800
Message-ID: <20250924112820.2003675-3-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924112820.2003675-1-randolph@andestech.com>
References: <20250924112820.2003675-1-randolph@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 58OBSUKS074424

Add the Andes QiLai PCIe node, which includes 3 Root Complexes.
Only one example is required in the DTS bindings YAML file.

Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 .../bindings/pci/andestech,qilai-pcie.yaml    | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml b/Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
new file mode 100644
index 000000000000..8effe6ebd9d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/andestech,qilai-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Andes QiLai PCIe host controller
+
+description: |+
+  Andes QiLai PCIe host controller is based on the Synopsys DesignWare
+  PCI core. It shares common features with the PCIe DesignWare core and
+  inherits common properties defined in
+  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
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
+  "#interrupt-cells":
+    const: 1
+
+  interrupt-map: true
+
+required:
+  - reg
+  - reg-names
+  - "#interrupt-cells"
+  - interrupts
+  - interrupt-names
+  - interrupt-map-mask
+  - interrupt-map
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
+      bus@80000000 {
+        compatible = "simple-bus";
+        #address-cells = <2>;
+        #size-cells = <2>;
+        dma-ranges = <0x44 0x00000000 0x04 0x00000000 0x04 0x00000000>;
+        ranges = <0x00 0x80000000 0x00 0x80000000 0x00 0x20000000>,
+                 <0x00 0x04000000 0x00 0x04000000 0x00 0x00001000>,
+                 <0x00 0x00000000 0x20 0x00000000 0x20 0x00000000>;
+
+        pci@80000000 {
+          compatible = "andestech,qilai-pcie";
+          device_type = "pci";
+          reg = <0x0 0x80000000 0x0 0x20000000>,
+                <0x0 0x04000000 0x0 0x00001000>,
+                <0x0 0x00000000 0x0 0x00010000>;
+          reg-names = "dbi", "apb", "config";
+
+          linux,pci-domain = <0>;
+          bus-range = <0x0 0xff>;
+          num-viewport = <4>;
+          #address-cells = <3>;
+          #size-cells = <2>;
+          ranges = <0x02000000 0x00 0x10000000 0x00 0x10000000 0x0 0xf0000000>,
+                   <0x43000000 0x01 0x00000000 0x01 0x0000000 0x1f 0x00000000>;
+
+          #interrupt-cells = <1>;
+          interrupts = <0xf>;
+          interrupt-names = "msi";
+          interrupt-parent = <&plic0>;
+          interrupt-map-mask = <0 0 0 7>;
+          interrupt-map = <0 0 0 1 &plic0 0xf IRQ_TYPE_LEVEL_HIGH>,
+                          <0 0 0 2 &plic0 0xf IRQ_TYPE_LEVEL_HIGH>,
+                          <0 0 0 3 &plic0 0xf IRQ_TYPE_LEVEL_HIGH>,
+                          <0 0 0 4 &plic0 0xf IRQ_TYPE_LEVEL_HIGH>;
+        };
+      };
+    };
-- 
2.34.1


