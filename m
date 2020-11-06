Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB292A9834
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 16:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgKFPL0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 10:11:26 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53972 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbgKFPLW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 10:11:22 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A6FBE9E021868;
        Fri, 6 Nov 2020 09:11:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604675474;
        bh=6VM7QPKbo+SakMqPLZgxf3iydTMk/h2RER3AICsA3wM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tROSBZbydxEZgKrEM0r7vEAfnV8fWyP5fBe7AymZL4YoUYPCocZrvcz1/m/duA+KL
         nUIP/ZIwtwSuqFLlHcv8Dte2Sw2tCxpBAnyCmRUfhEZJtppiWvJD07vHsNaKuaowWi
         m6Uagjy9J1FIc/B46do6D2sK/c8Vmc7/kH2j9ono=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A6FBEgB019556
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Nov 2020 09:11:14 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 6 Nov
 2020 09:11:14 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 6 Nov 2020 09:11:14 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A6FB7Tg092540;
        Fri, 6 Nov 2020 09:11:11 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: PCI: Make "cdns,max-outbound-regions" optional property
Date:   Fri, 6 Nov 2020 20:41:06 +0530
Message-ID: <20201106151107.3987-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106151107.3987-1-kishon@ti.com>
References: <20201106151107.3987-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make "cdns,max-outbound-regions" optional property with the default
being 32.

Link: http://lore.kernel.org/r/20201105165331.GA55814@bogus
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml    | 3 ---
 Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml | 2 --
 2 files changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
index 60b8baf299bb..21e8a8849076 100644
--- a/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
@@ -20,7 +20,4 @@ properties:
     maximum: 32
     default: 32
 
-required:
-  - cdns,max-outbound-regions
-
 additionalProperties: true
diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
index 3ae3e1a2d4b0..aae07b723fb5 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
@@ -57,7 +57,6 @@ required:
   - power-domains
   - clocks
   - clock-names
-  - cdns,max-outbound-regions
   - dma-coherent
   - max-functions
   - phys
@@ -86,7 +85,6 @@ examples:
            power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
            clocks = <&k3_clks 239 1>;
            clock-names = "fck";
-           cdns,max-outbound-regions = <16>;
            max-functions = /bits/ 8 <6>;
            dma-coherent;
            phys = <&serdes0_pcie_link>;
-- 
2.17.1

