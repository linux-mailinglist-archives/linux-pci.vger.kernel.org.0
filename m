Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23BC3CC8DF
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jul 2021 13:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbhGRLn5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Jul 2021 07:43:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232716AbhGRLn4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 18 Jul 2021 07:43:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4A0C6108B;
        Sun, 18 Jul 2021 11:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626608458;
        bh=Yxg6f6Vl7O5HHJp418DNs74biL5Q8SHGgoxNBhxuF/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EItQsymLmRgQje+Sximp2sA51G07ycSl7pHA9zhaVDs8InEHOwKSir8Yy1X/qDQhC
         iSJOpTbWSS7cXrYCib7jFgxHB4fy6iDfULSwUOL8wjd0pk/7AB2zciRbzqD+/Vb4D2
         lk6eNUshu4Ec2E50dqpW26czWwscYY1CinbaT/WXbwxdaxu8jTWt5KiYbw00YCeJdi
         4xPpRmilm7UFoGFn8s//SsIllBnsXe3qP5JWUki4B+yr+TG0OHJ4dBJT//DLZhao6H
         mYkYiQs2F3oEsJBzoWTnB7L9TnoFp0ZgPtN64pEIRT7wFD8TuZUR9cgGKc2wkFUgmf
         6+CmKmEmcraPA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m55AE-001Dvw-7W; Sun, 18 Jul 2021 13:40:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v5 1/5] dt-bindings: PCI: add snps,dw-pcie.yaml
Date:   Sun, 18 Jul 2021 13:40:48 +0200
Message-Id: <53363a7609176ca56c47ef57287466ee84087dc5.1626608375.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626608375.git.mchehab+huawei@kernel.org>
References: <cover.1626608375.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, the designware schema is defined on a text file:
	designware-pcie.txt

Convert the pci-bus part into a schema.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../devicetree/bindings/pci/snps,dw-pcie.yaml | 102 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
new file mode 100644
index 000000000000..d4441d822b91
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/snps,dw-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare PCIe interface
+
+maintainers:
+  - Jingoo Han <jingoohan1@gmail.com>
+  - Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+
+description: |
+  Synopsys DesignWare PCIe host controller
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    anyOf:
+      - {}
+      - const: snps,dw-pcie
+
+  reg:
+    description: |
+      It should contain Data Bus Interface (dbi) and config registers for all
+      versions.
+      For designware core version >= 4.80, it may contain ATU address space.
+    minItems: 2
+    maxItems: 5
+
+  reg-names:
+    minItems: 2
+    maxItems: 5
+    items:
+      enum: [dbi, dbi2, config, atu, app, elbi, mgmt, ctrl, parf, cfg, link]
+
+  num-lanes:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: |
+      number of lanes to use (this property should be specified unless
+      the link is brought already up in BIOS)
+    maximum: 16
+
+  reset-gpio:
+    description: GPIO pin number of PERST# signal
+    maxItems: 1
+    deprecated: true
+
+  reset-gpios:
+    description: GPIO controlled connection to PERST# signal
+    maxItems: 1
+
+  interrupts: true
+
+  interrupt-names: true
+
+  clocks: true
+
+  snps,enable-cdm-check:
+    type: boolean
+    description: |
+      This is a boolean property and if present enables
+      automatic checking of CDM (Configuration Dependent Module) registers
+      for data corruption. CDM registers include standard PCIe configuration
+      space registers, Port Logic registers, DMA and iATU (internal Address
+      Translation Unit) registers.
+
+  num-viewport:
+    description: |
+      number of view ports configured in hardware. If a platform
+      does not specify it, the driver autodetects it.
+    deprecated: true
+
+unevaluatedProperties: false
+
+required:
+  - reg
+  - reg-names
+  - compatible
+
+examples:
+  - |
+    bus {
+      #address-cells = <1>;
+      #size-cells = <1>;
+      pcie@dfc00000 {
+        device_type = "pci";
+        compatible = "snps,dw-pcie";
+        reg = <0xdfc00000 0x0001000>, /* IP registers */
+              <0xd0000000 0x0002000>; /* Configuration space */
+        reg-names = "dbi", "config";
+        #address-cells = <3>;
+        #size-cells = <2>;
+        ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000>,
+                 <0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
+        interrupts = <25>, <24>;
+        #interrupt-cells = <1>;
+        num-lanes = <1>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index fb6971bc28c5..c88f6cb37e47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14306,6 +14306,7 @@ M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
+F:	Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
 F:	drivers/pci/controller/dwc/*designware*
 
 PCI DRIVER FOR TI DRA7XX/J721E
-- 
2.31.1

