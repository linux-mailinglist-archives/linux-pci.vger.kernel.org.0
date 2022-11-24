Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA21C6373A7
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 09:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiKXIOW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 03:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiKXINj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 03:13:39 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523B453EE1;
        Thu, 24 Nov 2022 00:13:00 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AO8CqZ7025091;
        Thu, 24 Nov 2022 02:12:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669277572;
        bh=32Ubr6pDmwWnVPRGFAMV+5MACScah3nsX53UXKG5qPs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=n5NJZjya4w2wmH047lBAXkjaTZVRRemzt5Erx6L8AAqofXpYdsN2KINByQnv75ZW9
         xPfp0ZL3ZX9ArViPNswVlklLj+yAu1IS75sJOUDn7w05qPUzUJGu23XkO6ceXLZ3I0
         WoNzVBkVxNK6LagtYV+PJKQi1Z65mkwAJqDHsIu4=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AO8Cqd7064121
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Nov 2022 02:12:52 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 24
 Nov 2022 02:12:52 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 24 Nov 2022 02:12:52 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AO8Cm1D022325;
        Thu, 24 Nov 2022 02:12:50 -0600
From:   Matt Ranostay <mranostay@ti.com>
To:     <rogerq@kernel.org>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>,
        <krzysztof.kozlowski@linaro.org>, <vigneshr@ti.com>,
        <tjoseph@cadence.com>, <sergio.paracuellos@gmail.com>,
        <pthombar@cadence.com>, <linux-pci@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH v7 4/5] dt-bindings: PCI: ti,j721e-pci-*: add j784s4-pci-* compatible strings
Date:   Thu, 24 Nov 2022 00:12:20 -0800
Message-ID: <20221124081221.1206167-5-mranostay@ti.com>
X-Mailer: git-send-email 2.38.GIT
In-Reply-To: <20221124081221.1206167-1-mranostay@ti.com>
References: <20221124081221.1206167-1-mranostay@ti.com>
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

Add definition for j784s4-pci-ep + j784s4-pci-host devices along with
schema checks for num-lanes.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml     | 12 ++++++++++++
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml   | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
index 1aeea168d3d0..2e6226cbd1d3 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
@@ -14,6 +14,7 @@ properties:
   compatible:
     oneOf:
       - const: ti,j721e-pcie-ep
+      - const: ti,j784s4-pcie-ep
       - description: PCIe EP controller in AM64
         items:
           - const: ti,am64-pcie-ep
@@ -87,6 +88,17 @@ allOf:
           minimum: 1
           maximum: 2
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - ti,j784s4-pcie-ep
+    then:
+      properties:
+        num-lanes:
+          minimum: 1
+          maximum: 4
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index 8eca0d08303f..100d3f556adb 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -14,6 +14,7 @@ properties:
   compatible:
     oneOf:
       - const: ti,j721e-pcie-host
+      - const: ti,j784s4-pcie-host
       - description: PCIe controller in AM64
         items:
           - const: ti,am64-pcie-host
@@ -120,6 +121,17 @@ allOf:
           minimum: 1
           maximum: 2
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - ti,j784s4-pcie-host
+    then:
+      properties:
+        num-lanes:
+          minimum: 1
+          maximum: 4
+
 required:
   - compatible
   - reg
-- 
2.38.GIT

