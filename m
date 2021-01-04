Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1592E9533
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jan 2021 13:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbhADMno (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 07:43:44 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56494 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbhADMnn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jan 2021 07:43:43 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 104CfwsB098481;
        Mon, 4 Jan 2021 06:41:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1609764118;
        bh=pW+3Nkkfv15OxmYOKkSjlpKQ8IkjEw2ZblHzX+3dit8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=AKt/lhY0m29zqJN9KO05LwQipGxH1RVVYyYFtO7tp2VHQKUjuSdvOqjjZRC4+ilfd
         5Lolq1uWdxseCo8rjYCljMbgOQhzuG6XOGG+o48Sm3I8eoLjNZ/HrCbpX1NB0ePUOV
         kvkgSuS0jA/d0GQkxA5CA4Drj0mp2Sv1OMo45kdA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 104CfwnS080776
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Jan 2021 06:41:58 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 4 Jan
 2021 06:41:17 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 4 Jan 2021 06:41:17 -0600
Received: from a0393678-ssd.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 104Cf3bi034579;
        Mon, 4 Jan 2021 06:41:13 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nadeem Athani <nadeem@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 2/4] dt-bindings: pci: ti,j721e: Add host mode dt-bindings for TI's AM64 SoC
Date:   Mon, 4 Jan 2021 18:11:01 +0530
Message-ID: <20210104124103.30930-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210104124103.30930-1-kishon@ti.com>
References: <20210104124103.30930-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add host mode dt-bindings for TI's AM64 SoC. This is the same IP used in
J7200, however AM64 is a non-coherent architecture.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml     | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index 7607018a115b..77118dba415e 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -16,12 +16,17 @@ allOf:
 properties:
   compatible:
     oneOf:
-      - description: PCIe controller in J7200
+      - const: ti,am64-pcie-host
+      - const: ti,j7200-pcie-host
+      - const: ti,j721e-pcie-host
+      - description: PCIe controller in AM64
         items:
+          - const: ti,am64-pcie-host
           - const: ti,j7200-pcie-host
           - const: ti,j721e-pcie-host
-      - description: PCIe controller in J721E
+      - description: PCIe controller in J7200
         items:
+          - const: ti,j7200-pcie-host
           - const: ti,j721e-pcie-host
 
   reg:
@@ -87,7 +92,6 @@ required:
   - vendor-id
   - device-id
   - msi-map
-  - dma-coherent
   - dma-ranges
   - ranges
   - reset-gpios
-- 
2.17.1

