Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008312183B0
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 11:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgGHJa5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jul 2020 05:30:57 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55924 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgGHJaz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jul 2020 05:30:55 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0689Uk4F068221;
        Wed, 8 Jul 2020 04:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594200646;
        bh=wA/DJIaqqbKg+dmv5MdTfjimJ83LKxdmuu8q+r4WzXM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jAu4/3B0R471zRdVpir+e181McmhHAMrQ+yslY/46qF4TRy47Y7+waG2bBsFmDNx9
         v4kBlvawZJqYTxslTEA+G/fk+VHr6EvUrdqm1QHnaJHQBGLWwMLWFf5FfGAr1f9eGh
         aTJNkveanl1hJ1Oh7w5rxEMnvkvTlpOZT6pXE35k=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0689UkUo095732
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Jul 2020 04:30:46 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 8 Jul
 2020 04:30:45 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 8 Jul 2020 04:30:45 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0689UJEN098512;
        Wed, 8 Jul 2020 04:30:42 -0500
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
Subject: [PATCH v6 06/14] dt-bindings: PCI: cadence: Remove "mem" from reg binding
Date:   Wed, 8 Jul 2020 15:00:10 +0530
Message-ID: <20200708093018.28474-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708093018.28474-1-kishon@ti.com>
References: <20200708093018.28474-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"mem" is not a memory resource and it overlaps with PCIe config space
and memory region. Removve "mem" from reg binding.

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

