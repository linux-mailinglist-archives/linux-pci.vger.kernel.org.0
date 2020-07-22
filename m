Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9C02296F7
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 13:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbgGVLEB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jul 2020 07:04:01 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39050 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgGVLEA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jul 2020 07:04:00 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06MB3o21070475;
        Wed, 22 Jul 2020 06:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595415830;
        bh=78wWOd3ZsPARwxc3JQyFkWSrWhbfEtK3ytyjWuF48qg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=F9+8gvkSiWc/MMVzVax/PG5UVT1BGX9Hvdir9cWEDIu+mcT7E4wzA+MeC3A9DyHJD
         QqBvxILk9YxP0svsNKzlffpgPDmF6exYSvD58mdgOLfax89BCo6vm5QdQghpbCR/aQ
         KTX4cC1z3o7fOiCNOTFCB/twyWCmUhmgQuBIjuwA=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06MB3oqp005891
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jul 2020 06:03:50 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 22
 Jul 2020 06:03:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 22 Jul 2020 06:03:49 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06MB3IFf078616;
        Wed, 22 Jul 2020 06:03:46 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v8 07/15] dt-bindings: PCI: cadence: Remove "mem" from reg binding
Date:   Wed, 22 Jul 2020 16:33:09 +0530
Message-ID: <20200722110317.4744-8-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722110317.4744-1-kishon@ti.com>
References: <20200722110317.4744-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"mem" is not a memory resource and it overlaps with PCIe config space
and memory region. Remove "mem" from reg binding.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/cdns,cdns-pcie-host.yaml      | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
index 84a8f095d031..6d67067843bf 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
@@ -18,13 +18,12 @@ properties:
     const: cdns,cdns-pcie-host
 
   reg:
-    maxItems: 3
+    maxItems: 2
 
   reg-names:
     items:
       - const: reg
       - const: cfg
-      - const: mem
 
   msi-parent: true
 
@@ -49,9 +48,8 @@ examples:
             device-id = <0x0200>;
 
             reg = <0x0 0xfb000000  0x0 0x01000000>,
-                  <0x0 0x41000000  0x0 0x00001000>,
-                  <0x0 0x40000000  0x0 0x04000000>;
-            reg-names = "reg", "cfg", "mem";
+                  <0x0 0x41000000  0x0 0x00001000>;
+            reg-names = "reg", "cfg";
 
             ranges = <0x02000000 0x0 0x42000000  0x0 0x42000000  0x0 0x1000000>,
                      <0x01000000 0x0 0x43000000  0x0 0x43000000  0x0 0x0010000>;
-- 
2.17.1

