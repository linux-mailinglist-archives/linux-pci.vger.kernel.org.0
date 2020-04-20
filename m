Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA3A1B02B4
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 09:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDTHSF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 03:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725971AbgDTHSF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Apr 2020 03:18:05 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF97C061A0F;
        Mon, 20 Apr 2020 00:18:05 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 1F44120CD8;
        Mon, 20 Apr 2020 07:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1587366775; bh=ASg+iuEBGSsKPnwR6mS70BOGMwAUI0N42iiAJ2GiVfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cT/eJyMyYOWNzwPQek4vDhuDJ5kF7yJr5Pl4cbnpwHgX9Istzl5tzX4eriXm+6E46
         58d3V0Y8/As8LJEkQVJOVX9n9W7T4h16ygnob9P4AeqBkR2xgaCywy4eSux241aZpK
         yvw2PcO17xwyfOovm8Xeqqhykly0IqtmxlQAjf3Ht+G8sFvb3IMHzPxRwFV+9+ewZg
         kOj+g/Z2YCvltJj8KpA7QuAgT3o3ck/pudTMvJCbzwI2RCQY62GIJeyMipi2jJloLr
         tcIcgx+4Z63qhI4FUPD5A1uIhkeE7ojI8ysZ1Xh0+OgNGuYNaMx5WHpXOOyhG8Fynu
         U3ElElk5X9oow==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] dt-bindings: Document Loongson PCI Host Controller
Date:   Mon, 20 Apr 2020 15:12:09 +0800
Message-Id: <20200420071220.155357-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200420071220.155357-1-jiaxun.yang@flygoat.com>
References: <20200330114239.1112759-1-jiaxun.yang@flygoat.com>
 <20200420071220.155357-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI host controller found on Loongson PCHs and SoCs.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

--
v3: Fix ranges
---
 .../devicetree/bindings/pci/loongson.yaml     | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/loongson.yaml

diff --git a/Documentation/devicetree/bindings/pci/loongson.yaml b/Documentation/devicetree/bindings/pci/loongson.yaml
new file mode 100644
index 000000000000..20b4cf3fe696
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
+      - const: loongson,ls7a-pci
+      - const: loongson,ls2k-pci
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

