Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639762A27D7
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 11:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgKBKMP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 05:12:15 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39018 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgKBKMO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 05:12:14 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A2AC9e4012441;
        Mon, 2 Nov 2020 04:12:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604311929;
        bh=FYw90D37wL2gJHE27Zpjj2Ud8OCfF055vtP6q/qywAw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=thHe3GPoulKfHEgeRAsonGT8NLN91lse+XH7XggL+5hBX5RD45aQ0XIjipvzNSIY+
         7/4yI5cKiDmDJItpk9RBu5UZ2ebru9lnns9vrdFYujmkQW8TuoZ+LmCGDTS1TupIqZ
         8gmXHiPh1NXQaLSD+Nh4MYLO+++wIIZyzSE//gRU=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A2AC9vf089245
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 04:12:09 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 04:12:08 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 04:12:08 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A2ABtuZ059084;
        Mon, 2 Nov 2020 04:12:05 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Roger Quadros <rogerq@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/8] dt-bindings: PCI: Add host mode dt-bindings for TI's J7200 SoC
Date:   Mon, 2 Nov 2020 15:41:48 +0530
Message-ID: <20201102101154.13598-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102101154.13598-1-kishon@ti.com>
References: <20201102101154.13598-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add host mode dt-bindings for TI's J7200 SoC.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../bindings/pci/ti,j721e-pci-host.yaml          | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index ee7a8eade3f6..ecec36c02883 100644
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
@@ -48,7 +54,11 @@ properties:
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

