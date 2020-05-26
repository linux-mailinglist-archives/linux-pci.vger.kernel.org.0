Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004341E1E5E
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 11:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388547AbgEZJWi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 05:22:38 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:34270 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388425AbgEZJWi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 05:22:38 -0400
Received: from localhost.localdomain (unknown [142.147.94.151])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 60E4520CF0;
        Tue, 26 May 2020 09:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1590484957; bh=Ke6cPvHXKiPrY2g75japQ2FrKO93C44dRXKjeYxEPWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rMUpl24If/+8mkwsrw/bpSV6FPS+dZVqxHXbXIXR0OGzseXXu/Ll66WOTRfSdDg4F
         BuLLdFhK0/oYr7mHwSh62zBUfD14DMczkU1MeKgivX/atv1H03P/HNXp/ZfO4aDqZ5
         y/Fe0yA44osE4+WlhaWRIm15c0wdPH2EqTShad60FL21seQGat+SR+ivda4AsUvbya
         GJAv2k8nOSKW1C/ekrNYJN79fPoOyRH00xhmQqK+Pa/WPGNNGkFKy20QdGDwhNsyWL
         CIrkHAhYkodQ/A1k9gzbHDL0C1VDGKXI/dtbDub0WXl445INtnJCJFIvSxwDIoM85/
         piu33YpZl5Glw==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-pci@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH v11 3/5] dt-bindings: Document Loongson PCI Host Controller
Date:   Tue, 26 May 2020 17:21:14 +0800
Message-Id: <20200526092130.145550-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200526092130.145550-1-jiaxun.yang@flygoat.com>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
 <20200526092130.145550-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI host controller found on Loongson PCHs and SoCs.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/loongson.yaml     | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/loongson.yaml

diff --git a/Documentation/devicetree/bindings/pci/loongson.yaml b/Documentation/devicetree/bindings/pci/loongson.yaml
new file mode 100644
index 000000000000..30e7cf1aeb87
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/loongson.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/loongson.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson PCI Host Controller
+
+maintainers:
+  - Jiaxun Yang <jiaxun.yang@flygoat.com>
+
+description: |+
+  PCI host controller found on Loongson PCHs and SoCs.
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: loongson,ls2k-pci
+      - const: loongson,ls7a-pci
+      - const: loongson,rs780e-pci
+
+  reg:
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: CFG0 standard config space register
+      - description: CFG1 extended config space register
+
+  ranges:
+    minItems: 1
+    maxItems: 3
+
+
+required:
+  - compatible
+  - reg
+  - ranges
+
+examples:
+  - |
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pcie@1a000000 {
+            compatible = "loongson,rs780e-pci";
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            // CPU_PHYSICAL(2)  SIZE(2)
+            reg = <0x0 0x1a000000  0x0 0x2000000>;
+
+            // BUS_ADDRESS(3)  CPU_PHYSICAL(2)  SIZE(2)
+            ranges = <0x01000000 0x0 0x00004000  0x0 0x00004000  0x0 0x00004000>,
+                     <0x02000000 0x0 0x40000000  0x0 0x40000000  0x0 0x40000000>;
+        };
+    };
+...
-- 
2.27.0.rc0

