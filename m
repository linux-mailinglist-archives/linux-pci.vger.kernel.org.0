Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E877960C645
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 10:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiJYIUN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 04:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiJYIT5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 04:19:57 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D572A27A
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 01:19:39 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29P8JXft109111;
        Tue, 25 Oct 2022 03:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666685974;
        bh=uRskjoWhYdXOY2K6XmRTl0Nf0bOphY5d8iBnN1WEdws=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OXZvfPuPKKkpCDZfNwtGp0s48Z0/u5juXMz1xZxr8s2joFFv/g1PeHlfShS4mOJz7
         n+ay3r8PYtYiG2lV4JU2lrY1BnOnpY/D6biV8YEsiqZ7OUMHO4PnA318MeDK6DOX5o
         lHkBJ5wUUK7/o8XaXLjXYWeK54ue8Zx0skNQPjpU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29P8JXD4093941
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Oct 2022 03:19:33 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 25
 Oct 2022 03:19:33 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 25 Oct 2022 03:19:33 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29P8JUcc115410;
        Tue, 25 Oct 2022 03:19:32 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Matt Ranostay <mranostay@ti.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH RESEND v2 2/2] dt-bindings: PCI: ti,j721e-pci-*: Add missing interrupt properties
Date:   Tue, 25 Oct 2022 01:19:09 -0700
Message-ID: <20221025081909.404107-3-mranostay@ti.com>
X-Mailer: git-send-email 2.38.GIT
In-Reply-To: <20221025081909.404107-1-mranostay@ti.com>
References: <20221025081909.404107-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Acked-by: Rob Herring <robh@kernel.org>
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
2.38.GIT

