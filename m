Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D5C2E2690
	for <lists+linux-pci@lfdr.de>; Thu, 24 Dec 2020 12:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgLXL6L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Dec 2020 06:58:11 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43472 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgLXL6L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Dec 2020 06:58:11 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBvMlM052125;
        Thu, 24 Dec 2020 05:57:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608811042;
        bh=ekIjBsGEy8ttVisERONWFmyGyUxpFsUO4LLaUm07A6A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=p6nk/JL/5qWdqdkMT3uZ1EPdm9BDQrfpwb4hGQX1cGDUcywFWtAUDTi0fDDxNsse6
         GqutUzh/JAPxe6lYYhZqlNJUOdafFQ7VOeWmu54q5upgBiv9rzia11ngZGJbTPs+YO
         wwFeeJ6v66anRm7FQekO9YcxFB9LuCnKirOZPcmY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BOBvMBO109218
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Dec 2020 05:57:22 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Dec 2020 05:57:22 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Dec 2020 05:57:22 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BOBv0Ht006549;
        Thu, 24 Dec 2020 05:57:17 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/4] dt-bindings: pci: ti,j721e: Add endpoint mode dt-bindings for TI's AM64 SoC
Date:   Thu, 24 Dec 2020 17:26:57 +0530
Message-ID: <20201224115658.2795-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201224115658.2795-1-kishon@ti.com>
References: <20201224115658.2795-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add endpoint mode dt-bindings for TI's AM64 SoC. This is the same IP
used in J7200, however AM64 is a non-coherent architecture.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml       | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
index d06f0c4464c6..447c8fe0f09e 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
@@ -16,12 +16,17 @@ allOf:
 properties:
   compatible:
     oneOf:
-      - description: PCIe EP controller in J7200
+      - const: ti,am64-pcie-ep
+      - const: ti,j7200-pcie-ep
+      - const: ti,j721e-pcie-ep
+      - description: PCIe EP controller in AM64
         items:
+          - const: ti,am64-pcie-ep
           - const: ti,j7200-pcie-ep
           - const: ti,j721e-pcie-ep
-      - description: PCIe EP controller in J721E
+      - description: PCIe EP controller in J7200
         items:
+          - const: ti,j7200-pcie-ep
           - const: ti,j721e-pcie-ep
 
   reg:
@@ -66,7 +71,6 @@ required:
   - power-domains
   - clocks
   - clock-names
-  - dma-coherent
   - max-functions
   - phys
   - phy-names
-- 
2.17.1

