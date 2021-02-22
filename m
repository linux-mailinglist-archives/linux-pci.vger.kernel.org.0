Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9F2321541
	for <lists+linux-pci@lfdr.de>; Mon, 22 Feb 2021 12:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhBVLlm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Feb 2021 06:41:42 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33804 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhBVLll (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Feb 2021 06:41:41 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 11MBefUM040401;
        Mon, 22 Feb 2021 05:40:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1613994041;
        bh=fbKMDGrEvUOo980qTvG1SNIpxoodpmicyqIGKvKGGEg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HV1CEGFmMunvCJWu22TeXr5IYkecKQcAGaxzJyVtG7G3sYJDJyQZ4fySDFsabCLxr
         54BReqVx2qBU3sXXxVGtNtOngGszqkTHnHtPcsrY6KYmnKGoiOzDYnSVaSF6+Kup2L
         I+gXPgx5nmwIHGChjBoZYEyM33r6KkDuoNy/WCq0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 11MBefQu126125
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Feb 2021 05:40:41 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 22
 Feb 2021 05:40:40 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 22 Feb 2021 05:40:40 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 11MBeVjo105473;
        Mon, 22 Feb 2021 05:40:38 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 2/4] dt-bindings: PCI: ti,j721e: Add host mode dt-bindings for TI's AM64 SoC
Date:   Mon, 22 Feb 2021 17:10:28 +0530
Message-ID: <20210222114030.26445-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210222114030.26445-1-kishon@ti.com>
References: <20210222114030.26445-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add host mode dt-bindings for TI's AM64 SoC. This is the same IP used in
J7200, however AM64 is a non-coherent architecture.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml    | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index 50dc99ac35d9..05aeb1aa362a 100644
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
@@ -66,6 +68,8 @@ properties:
           - const: 0xb00d
       - items:
           - const: 0xb00f
+      - items:
+          - const: 0xb010
 
   msi-map: true
 
@@ -82,7 +86,6 @@ required:
   - vendor-id
   - device-id
   - msi-map
-  - dma-coherent
   - dma-ranges
   - ranges
   - reset-gpios
-- 
2.17.1

