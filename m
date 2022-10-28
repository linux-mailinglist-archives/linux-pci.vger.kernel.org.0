Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF28610CE4
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 11:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJ1JRi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 05:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiJ1JRg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 05:17:36 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03931C69E3;
        Fri, 28 Oct 2022 02:17:35 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29S9HUo7052729;
        Fri, 28 Oct 2022 04:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666948650;
        bh=8pZkZUoU0muduuWHFbUZskE6PIAht2dHWIJJGA5T36g=;
        h=From:To:CC:Subject:Date;
        b=qakZHqUG6rTMLd0MS2ayC/u3KtuQq87mXW3XbO6+d7Sbt+eN5zGyYmhGJ9SKPaaP7
         KHSKrmPD9BVkJeoBPQCRuEHrdRdCuOMrYFPfRQiFVc1X71Q/X8ELgH7MZNt5rPZCM2
         2OhUmYfcqXRyXan2AbUgKgxvqNlN6qj1cA+SNYzU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29S9HUgG029497
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 04:17:30 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 04:17:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 04:17:30 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29S9HRrT036447;
        Fri, 28 Oct 2022 04:17:29 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <nm@ti.com>, <lpieralisi@kernel.org>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Matt Ranostay <mranostay@ti.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH] dt-bindings: PCI: Add host mode device-id for j721s2 platform
Date:   Fri, 28 Oct 2022 02:17:16 -0700
Message-ID: <20221028091716.21414-1-mranostay@ti.com>
X-Mailer: git-send-email 2.38.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add unique device-id of 0xb013 for j721s2 platform to oneOf field.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml | 2 ++
 1 file changed, 2 insertions(+)

This patchset was original part of this series "[PATCH v3 0/9] J721S2: Add support for additional IPs"
But has been broken out on its own based on Nishanth's advice.

Link: https://lore.kernel.org/all/20220921031327.4135-4-mranostay@ti.com/T/#mf199b3a8629377d02fd834545a4771d3ecf073c5

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index 2115d5a3f0e1..ba8def03b691 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -73,6 +73,8 @@ properties:
           - const: 0xb00f
       - items:
           - const: 0xb010
+      - items:
+          - const: 0xb013
 
   msi-map: true
 
-- 
2.38.GIT

