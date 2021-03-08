Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1E633082E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 07:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhCHGgv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 01:36:51 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57782 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbhCHGgZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 01:36:25 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1286aBsR056820;
        Mon, 8 Mar 2021 00:36:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615185371;
        bh=FejSDqeomqCQKLWeCp5I8g8qIQKEwylz/nun8gY7riQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HsN52u3Ddep1o+vJjNvcufQwUG9qFXMsHpCDA3dQskCnCDUCUHePl/N4uFr1dxNy4
         +CHh/ZCF0ECgWV+yjpI7AqeUcaQ9v/0xucP0uq1eIrR8OdlzQDgiqCLv26to/5Oiap
         G23fKjQ2ST44UK4F7bMx558Mu6KIdCPLx+8MwEno=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1286aBjl048522
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Mar 2021 00:36:11 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 8 Mar
 2021 00:36:11 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 8 Mar 2021 00:36:10 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1286ZuTU117458;
        Mon, 8 Mar 2021 00:36:06 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nadeem Athani <nadeem@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v4 2/4] dt-bindings: PCI: ti,j721e: Add host mode dt-bindings for TI's AM64 SoC
Date:   Mon, 8 Mar 2021 12:05:48 +0530
Message-ID: <20210308063550.6227-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308063550.6227-1-kishon@ti.com>
References: <20210308063550.6227-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add host mode dt-bindings for TI's AM64 SoC. This is the same IP used in
J7200, however AM64 is a non-coherent architecture.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml    | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index 963f90816645..cc900202df29 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -16,12 +16,14 @@ allOf:
 properties:
   compatible:
     oneOf:
-      - description: PCIe controller in J7200
+      - const: ti,j721e-pcie-host
+      - description: PCIe controller in AM64
         items:
-          - const: ti,j7200-pcie-host
+          - const: ti,am64-pcie-host
           - const: ti,j721e-pcie-host
-      - description: PCIe controller in J721E
+      - description: PCIe controller in J7200
         items:
+          - const: ti,j7200-pcie-host
           - const: ti,j721e-pcie-host
 
   reg:
@@ -67,6 +69,8 @@ properties:
           - const: 0xb00d
       - items:
           - const: 0xb00f
+      - items:
+          - const: 0xb010
 
   msi-map: true
 
@@ -83,7 +87,6 @@ required:
   - vendor-id
   - device-id
   - msi-map
-  - dma-coherent
   - dma-ranges
   - ranges
   - reset-gpios
-- 
2.17.1

