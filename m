Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4120E1B96FD
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 08:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgD0GGh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 02:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726221AbgD0GGh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2020 02:06:37 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F85FC061A0F;
        Sun, 26 Apr 2020 23:06:37 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 0E7C520CF2;
        Mon, 27 Apr 2020 06:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1587967597; bh=f2WebZEAIujlIGTgNQ/COhX1+VN/634eZmUQtNv+XSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QEVegUGB/zihFxG58AbaoQ4q8rCP93z9qtLRcLHd4a0xi/nRfgCQ/Pb20J2el0NyH
         Wequ1qCELu7SR/r5xG0sg2m7UsdRvb738W5qo8jdP91acpwkg8Xyx0nQ0OVLsCCURt
         UJ/ixnqrzZvUV2IJB5j0M6KXqVEE6xNhffAm7RTcNwC7odkr/PIXpCwEzZMRccpC3v
         kEqp0lWjfrM0ZgPkzY+GMMcLJkLRHbxo7B5PTbbwjiNBrgWf4xHniemyICHd+P5GG5
         THY2fAKjIgw7ZoSlZhHa7wCaldZbA9A0VzTjIGOFcjymdVUohbJT9G9LFncCi4r+GM
         vbiuDQOGti/CA==
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
Subject: [PATCH v6 3/5] dt-bindings: Document Loongson PCI Host Controller
Date:   Mon, 27 Apr 2020 14:05:40 +0800
Message-Id: <20200427060551.1372591-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
References: <20200427060551.1372591-1-jiaxun.yang@flygoat.com>
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
index 000000000000..78c5e32b2faa
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
+      - const: loongson,rs780e-pci
+      - const: loongson,ls2k-pci
+      - const: loongson,ls7a-pci
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

