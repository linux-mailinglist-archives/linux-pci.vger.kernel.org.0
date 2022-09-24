Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFE05E9057
	for <lists+linux-pci@lfdr.de>; Sun, 25 Sep 2022 00:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiIXWfq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 18:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbiIXWfp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 18:35:45 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6E53AE7A;
        Sat, 24 Sep 2022 15:35:44 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28OMZS1R000775;
        Sat, 24 Sep 2022 17:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1664058928;
        bh=L4nwi1Dr9PJPTrvCgOGMknOZq4MyXg6aj+GxNtU5xSA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dk3qb4ZZbHe5snTKgIZ7EEpqP/b9MQugnTtFLTir9UPiXgtKGLZU6SKorgQY28rX8
         e1pt9Pq4kaWvtm1ySllRRuGMc177eRWBfxuml2jV5LKgvkY82awKjo1jZPfMjnY+jW
         ipebysBJMC7xYYglrzamiQ0iaCoizwPqGGqd5P6g=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28OMZSRU093475
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 24 Sep 2022 17:35:28 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Sat, 24
 Sep 2022 17:35:28 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Sat, 24 Sep 2022 17:35:28 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28OMZPtF044762;
        Sat, 24 Sep 2022 17:35:27 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <bhelgaas@google.com>, <krzk@kernel.org>, <robh+dt@kernel.org>,
        <kishon@ti.com>, <vigneshr@ti.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH v2 2/2] dt-bindings: PCI: ti,j721e-pci-*: Add missing interrupt properties
Date:   Sat, 24 Sep 2022 15:35:17 -0700
Message-ID: <20220924223517.123343-3-mranostay@ti.com>
X-Mailer: git-send-email 2.38.0.rc0.52.gdda7228a83
In-Reply-To: <20220924223517.123343-1-mranostay@ti.com>
References: <20220924223517.123343-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Both interrupts, and interrupt names weren't defined in both EP and host
yaml. Also define the only possible interrupt-name as link_state, and
maxItems of interrupts to one.

This patch resolves the following warning:

arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dtb: pcie-ep@2910000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts' were unexpected)
        From schema Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml

Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml | 7 +++++++
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml         | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
index aed437dac363..10e6eabdff53 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
@@ -58,6 +58,13 @@ properties:
   dma-coherent:
     description: Indicates that the PCIe IP block can ensure the coherency
 
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: link_state
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index 0f5914a22c14..d9df7cd922f1 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -76,6 +76,13 @@ properties:
 
   msi-map: true
 
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: link_state
+
   interrupt-controller:
     type: object
     additionalProperties: false
-- 
2.38.0.rc0.52.gdda7228a83

