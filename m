Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476A23C6F8A
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 13:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbhGMLVC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 07:21:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236070AbhGMLVB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Jul 2021 07:21:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 502A26128D;
        Tue, 13 Jul 2021 11:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626175091;
        bh=Sd+vNC05cQNpKJwLdrzAgfE4188+OVEtaXATT2wCqhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=StWWf4MxhMSKQKrjAw+tfgKNHFxsypXDkWtY3pKWFd+B7jLODj7Tr9sg/LjjsGqZJ
         TMwAtYHzXmAmSJQhsDDTZW6RKaIZtvJA6bqnKl5oiNlaQpfSW/pMLmXQUx9soJhfTC
         ZkasYDuUyhCBeRgfhTX6L3rE2On8YXsu+3mEgyqP/8zWfmnAvmOECHEUWbPE/ub5ZF
         L0pu+TZ2cSlXz2+iQasnJA3zgZ265lwyPXU/M0jGCsRUB1EA2zVxJTvKVnGkQYdq0F
         WQ8g+43cSkJIyESwLbgSrMM4NxHOISI/66Ctjwtcb4EKtqXMGF/7famgg5hkv4IQBn
         eYrL5OFST2qUg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m3GQK-006b3e-V1; Tue, 13 Jul 2021 13:18:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v4 2/5] dt-bindings: PCI: add snps,dw-pcie-ep.yaml
Date:   Tue, 13 Jul 2021 13:17:52 +0200
Message-Id: <58b78aa8bbafe8aa721b015dfc42bff474284f37.1626174242.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626174242.git.mchehab+huawei@kernel.org>
References: <cover.1626174242.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, the designware schema is defined on a text file:
	designware-pcie.txt

It contains two separate schemas on it:

- snps,dw-pcie
  This one uses the pci-bus.yaml schema;
- snps,dw-pcie-ep
  This one uses the pci-ep.yaml schema.

As the:
	AllOf:
	  - $ref: <foo>

for the endpoint part is different than the PCI one, place
it on a separate yaml file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../bindings/pci/snps,dw-pcie-ep.yaml         | 90 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
new file mode 100644
index 000000000000..43baf29f8dd6
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/snps,dw-pcie-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare PCIe endpoint interface
+
+maintainers:
+  - Jingoo Han <jingoohan1@gmail.com>
+  - Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+
+description: |
+  Synopsys DesignWare PCIe host controller endpoint
+
+allOf:
+  - $ref: /schemas/pci/pci-ep.yaml#
+
+properties:
+  compatible:
+    anyOf:
+      - {}
+      - const: snps,dw-pcie-ep
+
+  reg:
+    description: |
+      It should contain Data Bus Interface (dbi) and config registers for all
+      versions.
+      For designware core version >= 4.80, it may contain ATU address space.
+    minItems: 2
+    maxItems: 4
+
+  reg-names:
+    minItems: 2
+    maxItems: 4
+    items:
+      enum: [dbi, dbi2, config, atu, addr_space, link]
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
+  snps,enable-cdm-check:
+    type: boolean
+    description: |
+      This is a boolean property and if present enables
+      automatic checking of CDM (Configuration Dependent Module) registers
+      for data corruption. CDM registers include standard PCIe configuration
+      space registers, Port Logic registers, DMA and iATU (internal Address
+      Translation Unit) registers.
+
+  num-ib-windows:
+    description: number of inbound address translation windows
+    maxItems: 1
+    deprecated: true
+
+  num-ob-windows:
+    description: number of outbound address translation windows
+    maxItems: 1
+    deprecated: true
+
+  max-functions:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: maximum number of functions that can be configured
+
+required:
+  - reg
+  - reg-names
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    bus {
+      #address-cells = <1>;
+      #size-cells = <1>;
+      pcie-ep@dfd00000 {
+        compatible = "snps,dw-pcie-ep";
+        reg = <0xdfc00000 0x0001000>, /* IP registers 1 */
+              <0xdfc01000 0x0001000>, /* IP registers 2 */
+              <0xd0000000 0x2000000>; /* Configuration space */
+        reg-names = "dbi", "dbi2", "addr_space";
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index f0115c590731..f0cf510c26fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14284,6 +14284,7 @@ L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
 F:	Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+F:	Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
 F:	drivers/pci/controller/dwc/*designware*
 
 PCI DRIVER FOR TI DRA7XX/J721E
-- 
2.31.1

