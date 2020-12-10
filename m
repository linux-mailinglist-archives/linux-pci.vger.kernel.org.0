Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDEC2D5AE5
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 13:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387647AbgLJMvc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 07:51:32 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36384 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732831AbgLJMvR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2020 07:51:17 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BACnYbx054509;
        Thu, 10 Dec 2020 06:49:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607604574;
        bh=9r3OpoyxWVqS2L6/mR3PuWOon4szAflduHj2tvsI/KY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JhC+MbCkPAYYj5f1fdqMquE7WHiqGjDQqhCXATiuKRoh7++qzytqxBFK+x6jsrD5i
         1xdKWQ4TJAP5J83/sftrCx3iwXVlMaFsfY8GrhFr43X/lJ67CsmPCamjlmSsq7gYva
         1Isy69CYAM0z9jEOWQFpqzy8AD2BqpoGkulr0HD8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BACnYGs016377
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 06:49:34 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 10
 Dec 2020 06:49:33 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 10 Dec 2020 06:49:33 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BACnKJN112244;
        Thu, 10 Dec 2020 06:49:30 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RESEND PATCH 2/4] dt-bindings: PCI: Add host mode dt-bindings for TI's J7200 SoC
Date:   Thu, 10 Dec 2020 18:19:15 +0530
Message-ID: <20201210124917.24185-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201210124917.24185-1-kishon@ti.com>
References: <20201210124917.24185-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add host mode dt-bindings for TI's J7200 SoC.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pci/ti,j721e-pci-host.yaml          | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index 2b6a1a5eaf7a..0880a613ece6 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -15,8 +15,14 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - ti,j721e-pcie-host
+    oneOf:
+      - description: PCIe controller in J7200
+        items:
+          - const: ti,j7200-pcie-host
+          - const: ti,j721e-pcie-host
+      - description: PCIe controller in J721E
+        items:
+          - const: ti,j721e-pcie-host
 
   reg:
     maxItems: 4
@@ -51,7 +57,11 @@ properties:
     const: 0x104c
 
   device-id:
-    const: 0xb00d
+    oneOf:
+      - items:
+          - const: 0xb00d
+      - items:
+          - const: 0xb00f
 
   msi-map: true
 
-- 
2.17.1

