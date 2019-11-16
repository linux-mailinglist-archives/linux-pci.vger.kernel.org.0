Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9EDFE9EE
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2019 01:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfKPAwn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Nov 2019 19:52:43 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45062 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfKPAwn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Nov 2019 19:52:43 -0500
Received: by mail-oi1-f196.google.com with SMTP id 14so10233900oir.12;
        Fri, 15 Nov 2019 16:52:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nWoMQ0paWOmaUsqalpGTNE9kf3zkQUzvDJAB/ODhtQI=;
        b=pWcYfcHehFfatfjpzjUhwdXkxX1SkDub3jrhghsQXkvRkodcXyv5A1ysH2nC3Di/09
         PhI36FAfOFWmIYnSXmiyPfo/8vZsVseFOZdMChvAQccvlTSzA+H1gM6SU8YMm1fZaJee
         H9cbPEb9f7s0+BoANrB5syW3wPkLmziUs5ZWoheS3F8BCdQSfV09spGvnPDhuQyGkLlK
         0b/orE0Ng51P/d13aeZxktQGrTBS8/FsZjdpoDJbVKxhkO5gr98FDmO4YkFzUUQdnWhq
         wmeI8mSSqFW6OIc5+etMa0hqO91VQj0G5f3GoddPCj9dgSSRghH7ybTl2oqgVCKTysli
         H9eQ==
X-Gm-Message-State: APjAAAUyUivQiCEoRV1Lx/DlDZgjPs6TankHicUfTe5arPxcV7iSZiuD
        p943rUFs6W9LAtY6mB05pq7JRFc=
X-Google-Smtp-Source: APXvYqxDPJ1BWP4pTS1D7z522kFc2WMxm7LqVnyyAdUsHtniQgmyyWk+hP4cf0Wf7J1GjpqUXNM68g==
X-Received: by 2002:a05:6808:b1c:: with SMTP id s28mr9147959oij.12.1573865561362;
        Fri, 15 Nov 2019 16:52:41 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id g18sm3525680otg.50.2019.11.15.16.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 16:52:40 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
Subject: [PATCH 1/3] dt-bindings: PCI: Convert Arm Versatile binding to DT schema
Date:   Fri, 15 Nov 2019 18:52:38 -0600
Message-Id: <20191116005240.15722-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the Arm Versatile PCI host binding to a DT schema.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
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
index c6c34d04ce95..48a90f0833b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12401,7 +12401,7 @@ M:	Rob Herring <robh@kernel.org>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/versatile.txt
+F:	Documentation/devicetree/bindings/pci/versatile.yaml
 F:	drivers/pci/controller/pci-versatile.c
 
 PCI DRIVER FOR ARMADA 8K
-- 
2.20.1

