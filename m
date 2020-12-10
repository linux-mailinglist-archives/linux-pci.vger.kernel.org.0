Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E84D2D5AED
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 13:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387501AbgLJMvb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 07:51:31 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36396 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387506AbgLJMvV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2020 07:51:21 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BACncEF054524;
        Thu, 10 Dec 2020 06:49:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607604578;
        bh=R1MaPbeUY9MQuLOK++4xDkqG3NqXBK7qSXA9xOtlxUo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GwaVvywADS7sV/KbHDrogWzMzbFu1MgUyxqLRYGoYeYfeIikfflvPL2iA4pesoGr2
         nXoxHljEDmZ35rLinkXJricJJB//2w9JP5Q736Yu/ML5Y5XkKazKU6IvGZK2KEcGKV
         xybjz/fkEo/7pKM/JPXMj9GcIDxpx2AMr+X1qNt8=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BACnbID069100
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 06:49:38 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 10
 Dec 2020 06:49:37 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 10 Dec 2020 06:49:37 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BACnKJO112244;
        Thu, 10 Dec 2020 06:49:34 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RESEND PATCH 3/4] dt-bindings: PCI: Add EP mode dt-bindings for TI's J7200 SoC
Date:   Thu, 10 Dec 2020 18:19:16 +0530
Message-ID: <20201210124917.24185-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201210124917.24185-1-kishon@ti.com>
References: <20201210124917.24185-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe EP mode dt-bindings for TI's J7200 SoC.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml       | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
index 3766565cf258..fa449273ae2b 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
@@ -15,8 +15,14 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - ti,j721e-pcie-ep
+    oneOf:
+      - description: PCIe EP controller in J7200
+        items:
+          - const: ti,j7200-pcie-ep
+          - const: ti,j721e-pcie-ep
+      - description: PCIe EP controller in J721E
+        items:
+          - const: ti,j721e-pcie-ep
 
   reg:
     maxItems: 4
-- 
2.17.1

