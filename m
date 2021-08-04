Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1983E01F8
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 15:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbhHDN3n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 09:29:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54586 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238119AbhHDN3n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Aug 2021 09:29:43 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 174DTLIT057562;
        Wed, 4 Aug 2021 08:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628083761;
        bh=OEHZU/iiQVxRGWPkSvAFFyNjExjrB5ZtDQI0+s9k8Zk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TrKEmq8xcgEV2tO3o0ydo79jpWjyEYdV7fVDliMDIxtZzb21d9j139T/zz4/kJLTl
         otoIfliqk0Z//znaO1hYLckb7V6iGqm/XYrvMRd+yceoGX8ySg/FS08KnJUG4hTLBA
         nIzFhc9z6gisr9Ue46BEDbTzTANCh28amYhjOYhE=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 174DTL2k063549
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Aug 2021 08:29:21 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 4 Aug
 2021 08:29:21 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 4 Aug 2021 08:29:21 -0500
Received: from a0393678-ssd.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 174DTDpe029237;
        Wed, 4 Aug 2021 08:29:18 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>
CC:     Tom Joseph <tjoseph@cadence.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 1/3] dt-bindings: PCI: ti,j721e: Add bindings to specify legacy interrupts
Date:   Wed, 4 Aug 2021 18:59:10 +0530
Message-ID: <20210804132912.30685-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210804132912.30685-1-kishon@ti.com>
References: <20210804132912.30685-1-kishon@ti.com>
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

