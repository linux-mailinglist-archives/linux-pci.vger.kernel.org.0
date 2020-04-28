Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97861BB358
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 03:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgD1BQ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 21:16:57 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:60302 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgD1BQ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2020 21:16:57 -0400
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 2861E2049E;
        Tue, 28 Apr 2020 01:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1588036617; bh=vwdAevZE7nFNqqKFNytPSJJ+rhVHR7kKUZDeM13xDDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JSaI3qgqkkEbHX6r9osXSdimlES61/751uHPxzoAqdyP2IpAA2Z2ayswqe0K5VUhi
         8Ta1vF5rXvoljKus57URLNqOw7AI5rLhcl3pPdmf350Toc1gOeOWwb7D8pb/0Wq5iO
         5VYfMTCXEFUCPbhnJlcwq3+VAMmb2CMQes1SIHTjm5eyuT5n0S3HPu2TYcQSfxAV0S
         B8VGaM5KnQw0RLeP30M+dVLdi4F8iELz9wCk4NacZs9iyjNth7OwPXZ/WhpTUSN7Km
         ir9HCsADkKid8SJ6QXFDqrKpJ1c3zDADgNznJEsBp1KJEvI9F4PKCpsHbq5NlTOB8l
         xofqrTGG1kFDA==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/5] dt-bindings: Document Loongson PCI Host Controller
Date:   Tue, 28 Apr 2020 09:14:18 +0800
Message-Id: <20200428011429.1852081-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200428011429.1852081-1-jiaxun.yang@flygoat.com>
References: <20200428011429.1852081-1-jiaxun.yang@flygoat.com>
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
2.26.0.rc2

