Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 900C012DB2E
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2019 20:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfLaTjH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 14:39:07 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:44327 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfLaTjG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Dec 2019 14:39:06 -0500
Received: by mail-il1-f194.google.com with SMTP id z12so30796055iln.11;
        Tue, 31 Dec 2019 11:39:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5BOi9Tqo4u9dYQQhDN+ySIfVzD3y1wIv8SexC5Jote4=;
        b=n/j91Mt9s8PZIauFC+5UN1uUoqP8byDLd3XZlyd26G94OHGk7gkYc2ZhxiI17aY/Rq
         5Vy3jctTGJKZkA+6qTlHhLYZ0OUOGGuxm/C5K0EeFuPKANavKa75Q94AnzzmULE7eTIA
         JrpUZcE1H82kWdN6dVQIlcWjkN6EXX9Zmr/yerbMCg06CsSiETQCTGK6TV5JEtl+w9rO
         LboSkp+z0owbAoZORQiqkRDo/OjRi2g8hsNDTNkstiYpPJaO33pVV+3zGeXReUGi90fp
         VP39U9jPrEohUeZUKXhp42TyzLkjcNy2SzI7ugV9SM9dIP38mQt/IhTu8jFjjt2eriJU
         AFWg==
X-Gm-Message-State: APjAAAUTxWLZaR1PpnzeCBHmnfCloseU7dRmIHgHM/gN5T4PN1El5Twz
        bZdBGllcaWuAwCjYja65s6FqFdY=
X-Google-Smtp-Source: APXvYqxlaSqk40VJbvxuwIXBoXMWsJitWhxWLA/op5SG2khYQCoeQkACswmjqJbzMJaU2Mft98+Lyg==
X-Received: by 2002:a92:1087:: with SMTP id 7mr32572188ilq.275.1577821145826;
        Tue, 31 Dec 2019 11:39:05 -0800 (PST)
Received: from xps15.herring.priv ([64.188.179.250])
        by smtp.googlemail.com with ESMTPSA id e1sm17860074ill.47.2019.12.31.11.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 11:39:05 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: PCI: Convert Arm Versatile binding to DT schema
Date:   Tue, 31 Dec 2019 12:39:01 -0700
Message-Id: <20191231193903.15929-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the Arm Versatile PCI host binding to a DT schema.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Murray <andrew.murray@arm.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2: no change

 .../devicetree/bindings/pci/versatile.txt     | 59 ------------
 .../devicetree/bindings/pci/versatile.yaml    | 92 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 93 insertions(+), 60 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/versatile.txt
 create mode 100644 Documentation/devicetree/bindings/pci/versatile.yaml

diff --git a/Documentation/devicetree/bindings/pci/versatile.txt b/Documentation/devicetree/bindings/pci/versatile.txt
deleted file mode 100644
index 0a702b13d2ac..000000000000
--- a/Documentation/devicetree/bindings/pci/versatile.txt
+++ /dev/null
@@ -1,59 +0,0 @@
-* ARM Versatile Platform Baseboard PCI interface
-
-PCI host controller found on the ARM Versatile PB board's FPGA.
-
-Required properties:
-- compatible: should contain "arm,versatile-pci" to identify the Versatile PCI
-  controller.
-- reg: base addresses and lengths of the PCI controller. There must be 3
-  entries:
-	- Versatile-specific registers
-	- Self Config space
-	- Config space
-- #address-cells: set to <3>
-- #size-cells: set to <2>
-- device_type: set to "pci"
-- bus-range: set to <0 0xff>
-- ranges: ranges for the PCI memory and I/O regions
-- #interrupt-cells: set to <1>
-- interrupt-map-mask and interrupt-map: standard PCI properties to define
-	the mapping of the PCI interface to interrupt numbers.
-
-Example:
-
-pci-controller@10001000 {
-	compatible = "arm,versatile-pci";
-	device_type = "pci";
-	reg = <0x10001000 0x1000
-	       0x41000000 0x10000
-	       0x42000000 0x100000>;
-	bus-range = <0 0xff>;
-	#address-cells = <3>;
-	#size-cells = <2>;
-	#interrupt-cells = <1>;
-
-	ranges = <0x01000000 0 0x00000000 0x43000000 0 0x00010000   /* downstream I/O */
-		  0x02000000 0 0x50000000 0x50000000 0 0x10000000   /* non-prefetchable memory */
-		  0x42000000 0 0x60000000 0x60000000 0 0x10000000>; /* prefetchable memory */
-
-	interrupt-map-mask = <0x1800 0 0 7>;
-	interrupt-map = <0x1800 0 0 1 &sic 28
-			 0x1800 0 0 2 &sic 29
-			 0x1800 0 0 3 &sic 30
-			 0x1800 0 0 4 &sic 27
-
-			 0x1000 0 0 1 &sic 27
-			 0x1000 0 0 2 &sic 28
-			 0x1000 0 0 3 &sic 29
-			 0x1000 0 0 4 &sic 30
-
-			 0x0800 0 0 1 &sic 30
-			 0x0800 0 0 2 &sic 27
-			 0x0800 0 0 3 &sic 28
-			 0x0800 0 0 4 &sic 29
-
-			 0x0000 0 0 1 &sic 29
-			 0x0000 0 0 2 &sic 30
-			 0x0000 0 0 3 &sic 27
-			 0x0000 0 0 4 &sic 28>;
-};
diff --git a/Documentation/devicetree/bindings/pci/versatile.yaml b/Documentation/devicetree/bindings/pci/versatile.yaml
new file mode 100644
index 000000000000..07a48c27db1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/versatile.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/versatile.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Versatile Platform Baseboard PCI interface
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+description: |+
+  PCI host controller found on the ARM Versatile PB board's FPGA.
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    const: arm,versatile-pci
+
+  reg:
+    items:
+      - description: Versatile-specific registers
+      - description: Self Config space
+      - description: Config space
+
+  ranges:
+    maxItems: 3
+
+  "#interrupt-cells": true
+
+  interrupt-map:
+    maxItems: 16
+
+  interrupt-map-mask:
+    items:
+      - const: 0x1800
+      - const: 0
+      - const: 0
+      - const: 7
+
+required:
+  - compatible
+  - reg
+  - ranges
+  - "#interrupt-cells"
+  - interrupt-map
+  - interrupt-map-mask
+
+examples:
+  - |
+    pci@10001000 {
+      compatible = "arm,versatile-pci";
+      device_type = "pci";
+      reg = <0x10001000 0x1000>,
+            <0x41000000 0x10000>,
+            <0x42000000 0x100000>;
+      bus-range = <0 0xff>;
+      #address-cells = <3>;
+      #size-cells = <2>;
+      #interrupt-cells = <1>;
+
+      ranges =
+          <0x01000000 0 0x00000000 0x43000000 0 0x00010000>,  /* downstream I/O */
+          <0x02000000 0 0x50000000 0x50000000 0 0x10000000>,  /* non-prefetchable memory */
+          <0x42000000 0 0x60000000 0x60000000 0 0x10000000>;  /* prefetchable memory */
+
+      interrupt-map-mask = <0x1800 0 0 7>;
+      interrupt-map = <0x1800 0 0 1 &sic 28>,
+          <0x1800 0 0 2 &sic 29>,
+          <0x1800 0 0 3 &sic 30>,
+          <0x1800 0 0 4 &sic 27>,
+
+          <0x1000 0 0 1 &sic 27>,
+          <0x1000 0 0 2 &sic 28>,
+          <0x1000 0 0 3 &sic 29>,
+          <0x1000 0 0 4 &sic 30>,
+
+          <0x0800 0 0 1 &sic 30>,
+          <0x0800 0 0 2 &sic 27>,
+          <0x0800 0 0 3 &sic 28>,
+          <0x0800 0 0 4 &sic 29>,
+
+          <0x0000 0 0 1 &sic 29>,
+          <0x0000 0 0 2 &sic 30>,
+          <0x0000 0 0 3 &sic 27>,
+          <0x0000 0 0 4 &sic 28>;
+    };
+
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index cc0a4a8ae06a..1072745a8fda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12580,7 +12580,7 @@ M:	Rob Herring <robh@kernel.org>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/versatile.txt
+F:	Documentation/devicetree/bindings/pci/versatile.yaml
 F:	drivers/pci/controller/pci-versatile.c
 
 PCI DRIVER FOR ARMADA 8K
-- 
2.20.1

