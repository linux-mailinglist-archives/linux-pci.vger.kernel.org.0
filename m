Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51889462B5C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 04:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbhK3D7h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 22:59:37 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37694 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhK3D7h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 22:59:37 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AU3uDEr112724;
        Mon, 29 Nov 2021 21:56:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638244573;
        bh=Ha0V4PmCOgZff0BHT0vZFCGQfr74hT/a0iLObfvUcFA=;
        h=From:To:CC:Subject:Date;
        b=NWq64XNBTowXaL9reh5WKjGOKQ4VYfLXStM1b5n94275uwOUws8I0BDj5ku6Y4sQ6
         FMgZ2JLNuMIfBWqHlwLh3NH33EDGnD1kaanPitHWVIKfuGBsSNI0u1rmpHj1lmZXHS
         nrlRgDN4+2FxDkg6vXe90UzjuUHd1CpnwZhOrPDw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AU3uDJ3056423
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Nov 2021 21:56:13 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 29
 Nov 2021 21:56:13 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 29 Nov 2021 21:56:13 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AU3u9DF065773;
        Mon, 29 Nov 2021 21:56:10 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] dt-bindings: PCI: ti,j721e: Add device id for J721S2
Date:   Tue, 30 Nov 2021 09:26:07 +0530
Message-ID: <20211130035608.13492-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document the device id of J721S2 SoC.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---

changes since v1:
- changed (oneOf, items) into enum

 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml   | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index cc900202df29..41df8f1c2d4c 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -64,13 +64,11 @@ properties:
     const: 0x104c
 
   device-id:
-    oneOf:
-      - items:
-          - const: 0xb00d
-      - items:
-          - const: 0xb00f
-      - items:
-          - const: 0xb010
+    enum:
+      - 0xb00d
+      - 0xb00f
+      - 0xb010
+      - 0xb013
 
   msi-map: true
 
-- 
2.17.1

