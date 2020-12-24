Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AA12E269C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Dec 2020 12:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgLXL7C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Dec 2020 06:59:02 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43462 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgLXL7B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Dec 2020 06:59:01 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBvHqJ052084;
        Thu, 24 Dec 2020 05:57:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608811037;
        bh=pW+3Nkkfv15OxmYOKkSjlpKQ8IkjEw2ZblHzX+3dit8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Vgh61y9w6Up/HJhhv+RJaqSuosjJRs/GtYUreT0o1vce5vWsbUYaCkc7ndYoANQuo
         urkG3KaWFaN3WFGb4tggjDCBo15vRYkryoqg+mtVy6bGc8QOeRUNSni62Il+ij3ZGv
         Kr6tSZ9peTeATB9JZWDk+5cZfkUZ6a7D6YRzrw3Y=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BOBvH7X117455
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Dec 2020 05:57:17 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Dec 2020 05:57:17 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Dec 2020 05:57:17 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBv0Hs006549;
        Thu, 24 Dec 2020 05:57:12 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/4] dt-bindings: pci: ti,j721e: Add host mode dt-bindings for TI's AM64 SoC
Date:   Thu, 24 Dec 2020 17:26:56 +0530
Message-ID: <20201224115658.2795-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201224115658.2795-1-kishon@ti.com>
References: <20201224115658.2795-1-kishon@ti.com>
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
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml     | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index 7607018a115b..77118dba415e 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -16,12 +16,17 @@ allOf:
 properties:
   compatible:
     oneOf:
-      - description: PCIe controller in J7200
+      - const: ti,am64-pcie-host
+      - const: ti,j7200-pcie-host
+      - const: ti,j721e-pcie-host
+      - description: PCIe controller in AM64
         items:
+          - const: ti,am64-pcie-host
           - const: ti,j7200-pcie-host
           - const: ti,j721e-pcie-host
-      - description: PCIe controller in J721E
+      - description: PCIe controller in J7200
         items:
+          - const: ti,j7200-pcie-host
           - const: ti,j721e-pcie-host
 
   reg:
@@ -87,7 +92,6 @@ required:
   - vendor-id
   - device-id
   - msi-map
-  - dma-coherent
   - dma-ranges
   - ranges
   - reset-gpios
-- 
2.17.1

