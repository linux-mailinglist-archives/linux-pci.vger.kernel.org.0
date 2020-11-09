Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C242AC1B1
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 18:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbgKIREb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 12:04:31 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45170 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731014AbgKIREb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2020 12:04:31 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A9H4Psw001565;
        Mon, 9 Nov 2020 11:04:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604941466;
        bh=8qpWBhSOnsx9lAnm/8wFcks6d+5yJT629ZlkAE4C1c0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=daXEncNvCbFYGPndsN5fooYtXf4dcTmb4FH7NFUquOG+2TMJrhkN4AUL5R4JIcNN7
         +PmduFQxuBWC5SsdAXzOcNJvWMI4dLbG79sARMpdDT11n5akQVRm2dLuHaELnA211I
         o/dFgsmpqlXHmwepNndmZcAPnetqyRRdkMJsu+5E=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A9H4PV1107666
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Nov 2020 11:04:25 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 9 Nov
 2020 11:04:25 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 9 Nov 2020 11:04:25 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A9H4AwV036684;
        Mon, 9 Nov 2020 11:04:19 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@ti.com>, Lee Jones <lee.jones@linaro.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/7] dt-bindings: PCI: Add host mode dt-bindings for TI's J7200 SoC
Date:   Mon, 9 Nov 2020 22:34:04 +0530
Message-ID: <20201109170409.4498-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201109170409.4498-1-kishon@ti.com>
References: <20201109170409.4498-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add host mode dt-bindings for TI's J7200 SoC.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pci/ti,j721e-pci-host.yaml          | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index ee7a8eade3f6..ecec36c02883 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -15,8 +15,14 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - ti,j721e-pcie-host
+    oneOf:
+      - description: PCIe controller in J7200
+        items:
+          - const: ti,j7200-pcie-host
+          - const: ti,j721e-pcie-host
+      - description: PCIe controller in J721E
+        items:
+          - const: ti,j721e-pcie-host
 
   reg:
     maxItems: 4
@@ -48,7 +54,11 @@ properties:
     const: 0x104c
 
   device-id:
-    const: 0xb00d
+    oneOf:
+      - items:
+          - const: 0xb00d
+      - items:
+          - const: 0xb00f
 
   msi-map: true
 
-- 
2.17.1

