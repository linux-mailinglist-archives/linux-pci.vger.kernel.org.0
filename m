Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9F421D442
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 13:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgGMLCV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 07:02:21 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56840 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbgGMLCS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 07:02:18 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06DB29G9101133;
        Mon, 13 Jul 2020 06:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594638129;
        bh=78wWOd3ZsPARwxc3JQyFkWSrWhbfEtK3ytyjWuF48qg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qiMHLkrBKlg7E2/FI2hGsxpuZtqFYY+jM1jXyNSR+bQtJQvm+lTJ2o+8RDzeX/eeI
         gG3meQG7klcVSPoxrCuldKkPg77krn3tDA2+OiH+LN1LS4mOSgpkyV5VOzjOSGcVup
         8YOuqEC+3+VL5ucz4uV7fVGbaKsL+JYFFEqhCg+w=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06DB29TL005479;
        Mon, 13 Jul 2020 06:02:09 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 13
 Jul 2020 06:02:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 13 Jul 2020 06:02:08 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06DB1gVg031460;
        Mon, 13 Jul 2020 06:02:05 -0500
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
Subject: [PATCH v7 06/14] dt-bindings: PCI: cadence: Remove "mem" from reg binding
Date:   Mon, 13 Jul 2020 16:31:33 +0530
Message-ID: <20200713110141.13156-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713110141.13156-1-kishon@ti.com>
References: <20200713110141.13156-1-kishon@ti.com>
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

