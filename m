Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31365E9052
	for <lists+linux-pci@lfdr.de>; Sun, 25 Sep 2022 00:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiIXWfi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 18:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiIXWfh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 18:35:37 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952542FFE9;
        Sat, 24 Sep 2022 15:35:35 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28OMZOWE122504;
        Sat, 24 Sep 2022 17:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1664058924;
        bh=Icw6d4OdZKqCcXq6wLYUsMbI5ceyx2wFeFx2Bd30FLg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hRjgamhkNAB5kFvXrfiyIY+4+OHDX3sCd36u+6nHWSv1Z0Lr12Q1cxnNQcpIo0jof
         sONuvYigCx2URvMM52eiCMCgd5bZvrUh7LpYk7x2Zl4YSqZJHoME2XiYvReCzvn72H
         g0bX7bLiEurteGAdWTHENKKhDoPc/2fMITq5o++M=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28OMZO92039821
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 24 Sep 2022 17:35:24 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Sat, 24
 Sep 2022 17:35:24 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Sat, 24 Sep 2022 17:35:24 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28OMZM58030391;
        Sat, 24 Sep 2022 17:35:23 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <bhelgaas@google.com>, <krzk@kernel.org>, <robh+dt@kernel.org>,
        <kishon@ti.com>, <vigneshr@ti.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH v2 1/2] dt-bindings: PCI: ti,j721e-pci-host: add interrupt controller definition
Date:   Sat, 24 Sep 2022 15:35:16 -0700
Message-ID: <20220924223517.123343-2-mranostay@ti.com>
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

Add missing 'interrupt-controller' property and related subnodes to resolve
the following warning:

arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dtb: pcie@2910000: Unevaluated properties are not allowed ('interrupt-controller' was unexpected)
        From schema: Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml

Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index 2115d5a3f0e1..0f5914a22c14 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -76,6 +76,19 @@ properties:
 
   msi-map: true
 
+  interrupt-controller:
+    type: object
+    additionalProperties: false
+
+    properties:
+      interrupt-controller: true
+
+      '#interrupt-cells':
+        const: 1
+
+      interrupts:
+        maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.38.0.rc0.52.gdda7228a83

