Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F812E2699
	for <lists+linux-pci@lfdr.de>; Thu, 24 Dec 2020 12:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgLXL65 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Dec 2020 06:58:57 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41556 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgLXL64 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Dec 2020 06:58:56 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBvCrD086849;
        Thu, 24 Dec 2020 05:57:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608811032;
        bh=5LOsNk+DfZ3KJX3uwomu6Vnma6rc/1g2DMZdSRAxi8s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tGydbZysrBUh3mESmaR7CxQsvo9rm1NXXlHyEHU2YdPr1bK4i288o54WjUiE7MbFP
         5l69rNOLRJ67hyLaX82kd651vj7WA2eQPsWg8UKVNqs8D4SBBcwLZIMlUj4elq5g0m
         4dOXCCKlgcIcaBNn0VkLQUdr37VWlLRpDTGX+ELo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BOBvCWE117324
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Dec 2020 05:57:12 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Dec 2020 05:57:11 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Dec 2020 05:57:11 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBv0Hr006549;
        Thu, 24 Dec 2020 05:57:07 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/4] dt-bindings: PCI: ti,j721e: Add binding to represent refclk to the connector
Date:   Thu, 24 Dec 2020 17:26:55 +0530
Message-ID: <20201224115658.2795-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201224115658.2795-1-kishon@ti.com>
References: <20201224115658.2795-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add binding to represent refclk to the PCIe connector.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/pci/ti,j721e-pci-host.yaml         | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index 0880a613ece6..7607018a115b 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -46,12 +46,21 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
-    description: clock-specifier to represent input to the PCIe
+    minItems: 1
+    maxItems: 2
+    description: clock-specifier to represent input to the PCIe for 1 item.
+      2nd item if present represents reference clock to the connector.
 
   clock-names:
-    items:
-      - const: fck
+    oneOf:
+      - description: Represent input clock to the PCIe
+        items:
+          - const: fck
+      - description: Represent input clock to the PCIe and reference clock to
+          the connector.
+        items:
+          - const: fck
+          - const: pcie_refclk
 
   vendor-id:
     const: 0x104c
-- 
2.17.1

