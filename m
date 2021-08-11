Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41E93E91AC
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 14:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhHKMja (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 08:39:30 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58648 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbhHKMj3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 08:39:29 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17BCcuUu083260;
        Wed, 11 Aug 2021 07:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628685536;
        bh=OEHZU/iiQVxRGWPkSvAFFyNjExjrB5ZtDQI0+s9k8Zk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vCeyxgYBPH0Rb04PSqUYE/v0JFdsP7AXJ2VMaNyGg5HxPj6nSSZfMKF8GsDz1OZ2q
         xoH+FZ/KsYPKa92mvkZhxT0u9bTs60yQN3z5gUS5te9NN+JITiGifHqDcXVi32eCUT
         5ng+kgZcg9rZp53ZtM2sHG/lIh6f88kzdHZznm+o=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17BCcuvQ018442
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Aug 2021 07:38:56 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 11
 Aug 2021 07:38:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 11 Aug 2021 07:38:55 -0500
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17BCckL0053470;
        Wed, 11 Aug 2021 07:38:52 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>, <kishon@ti.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/2] dt-bindings: PCI: ti,j721e: Add bindings to specify legacy interrupts
Date:   Wed, 11 Aug 2021 18:08:45 +0530
Message-ID: <20210811123846.31921-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210811123846.31921-1-kishon@ti.com>
References: <20210811123846.31921-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add bindings to specify interrupt controller for legacy interrupts.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/pci/ti,j721e-pci-host.yaml           | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index cc900202df29..f461d7b4c0cc 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -74,6 +74,11 @@ properties:
 
   msi-map: true
 
+patternProperties:
+  "interrupt-controller":
+    type: object
+    description: interrupt controller to handle legacy interrupts.
+
 required:
   - compatible
   - reg
@@ -97,6 +102,8 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/soc/ti,sci_pm_domain.h>
     #include <dt-bindings/gpio/gpio.h>
 
@@ -131,5 +138,13 @@ examples:
             ranges = <0x01000000 0x0 0x10001000  0x00 0x10001000  0x0 0x0010000>,
                      <0x02000000 0x0 0x10011000  0x00 0x10011000  0x0 0x7fef000>;
             dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+
+
+            pcie0_intc: interrupt-controller {
+                    interrupt-controller;
+                    #interrupt-cells = <1>;
+                    interrupt-parent = <&gic500>;
+                    interrupts = <GIC_SPI 312 IRQ_TYPE_EDGE_RISING>;
+            };
         };
     };
-- 
2.17.1

