Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F154C348C48
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 10:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhCYJKQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 05:10:16 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51564 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhCYJKF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 05:10:05 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12P99lea038638;
        Thu, 25 Mar 2021 04:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616663387;
        bh=AeY8bwpsTEdVriFD7mSsybeuz4u/oaVgUpLB4yQ524w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mQm2QofS/bxHOXVPUhWQFlvQr24M87g5UfV2rgT36ABrGk1NUlqRdz5hlaza/m2/c
         oyPmho2Sm1hlI/TptEBx/m9CqhLYlFuVQNQBJrXf9wnNs28qh6vi+rCmxipkMjggeO
         YbMrS9JbPAIAGA+XYqBaBP+29KMeLHy9jHzWdWd8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12P99lOq032201
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Mar 2021 04:09:47 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 25
 Mar 2021 04:09:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 25 Mar 2021 04:09:47 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12P99b9w078373;
        Thu, 25 Mar 2021 04:09:43 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>
CC:     Tom Joseph <tjoseph@cadence.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 1/4] dt-bindings: PCI: ti,j721e: Add bindings to specify legacy interrupts
Date:   Thu, 25 Mar 2021 14:39:33 +0530
Message-ID: <20210325090936.9306-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210325090936.9306-1-kishon@ti.com>
References: <20210325090936.9306-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add bindings to specify interrupt controller for legacy interrupts.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index 05aeb1aa362a..3e70a8049eea 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -73,6 +73,11 @@ properties:
 
   msi-map: true
 
+patternProperties:
+  "interrupt-controller":
+    type: object
+    description: interrupt controller to handle legacy interrupts.
+
 required:
   - compatible
   - reg
@@ -130,5 +135,13 @@ examples:
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

