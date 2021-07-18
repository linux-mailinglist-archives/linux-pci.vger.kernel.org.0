Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6513CC8C8
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jul 2021 13:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhGRLn5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Jul 2021 07:43:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232685AbhGRLn4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 18 Jul 2021 07:43:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCD1F61181;
        Sun, 18 Jul 2021 11:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626608458;
        bh=0bFVagzdp1XGgS+X1lOG3Ht/cN8VMfcZGqfv6GMLViM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nyP25/nmZukyw+2KP+YE3Qn1HS/hUApC78eRYJADhAGar0YdDute4Y6f3BpWzBZ1n
         NdRgcF3i3jZ9ZTK7WwMqcN/ZyX6U//V3CIblT7tapzSBhTWUy9n9EsO4oOUBdH7Pjm
         /NjXmvwwqe/fAMQSxaj8R38k66pDhsfErhGR3UHMSHLmSdrjQDn4afOo2n9KLcVoAu
         rIssSvua6PaPlGNy1W1WLT+2Oheg9TPwlLXtQ95s+7NbhyCRyLFGPHAsUOb01rDNjK
         OhsC6XiGfyBpveGDTnew+4SgdwyGFnWiSn+ishcjr13ttMei/06qYQR0DJHiwiFRt9
         QkEdIlB1AcsXw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m55AE-001Dvz-9V; Sun, 18 Jul 2021 13:40:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v5 2/5] dt-bindings: PCI: add snps,dw-pcie-ep.yaml
Date:   Sun, 18 Jul 2021 13:40:49 +0200
Message-Id: <26025b256232c2e4bd91954907b9d92db27199a3.1626608375.git.mchehab+huawei@kernel.org>
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
index 000000000000..b5935b1b153f
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
+      enum: [dbi, dbi2, config, atu, addr_space, link, atu_dma, appl]
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
index c88f6cb37e47..5818733eace7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14307,6 +14307,7 @@ L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
 F:	Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+F:	Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
 F:	drivers/pci/controller/dwc/*designware*
 
 PCI DRIVER FOR TI DRA7XX/J721E
-- 
2.31.1

