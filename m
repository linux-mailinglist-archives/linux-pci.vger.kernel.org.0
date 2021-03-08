Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B033E330835
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 07:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbhCHGgv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 01:36:51 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55876 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhCHGg3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 01:36:29 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1286aFTn110170;
        Mon, 8 Mar 2021 00:36:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615185375;
        bh=uODH0rlQQxDYF6jAbEjsFXPgdBaCE0YdlE+2Nqq1WMA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iyB5h1StywmF+t/eccCnRaFTjuYEpQOiJ/q2x7B90bT9qUVkNMHcDF+VEdQ9UcwB9
         tUzhjeUj6FbnyIr44AYahen72rZR+mAg5qsZvMTb4aOKZOVwZD2g9H8gR4DX8+02XB
         r6uUBa8PoP5F699mi9hNWsInsxgqwRcvotVDLc6E=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1286aFGS017730
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Mar 2021 00:36:15 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 8 Mar
 2021 00:36:15 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 8 Mar 2021 00:36:15 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1286ZuTV117458;
        Mon, 8 Mar 2021 00:36:11 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nadeem Athani <nadeem@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v4 3/4] dt-bindings: PCI: ti,j721e: Add endpoint mode dt-bindings for TI's AM64 SoC
Date:   Mon, 8 Mar 2021 12:05:49 +0530
Message-ID: <20210308063550.6227-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308063550.6227-1-kishon@ti.com>
References: <20210308063550.6227-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add endpoint mode dt-bindings for TI's AM64 SoC. This is the same IP
used in J7200, however AM64 is a non-coherent architecture.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml         | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
index d06f0c4464c6..aed437dac363 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
@@ -16,12 +16,14 @@ allOf:
 properties:
   compatible:
     oneOf:
-      - description: PCIe EP controller in J7200
+      - const: ti,j721e-pcie-ep
+      - description: PCIe EP controller in AM64
         items:
-          - const: ti,j7200-pcie-ep
+          - const: ti,am64-pcie-ep
           - const: ti,j721e-pcie-ep
-      - description: PCIe EP controller in J721E
+      - description: PCIe EP controller in J7200
         items:
+          - const: ti,j7200-pcie-ep
           - const: ti,j721e-pcie-ep
 
   reg:
@@ -66,7 +68,6 @@ required:
   - power-domains
   - clocks
   - clock-names
-  - dma-coherent
   - max-functions
   - phys
   - phy-names
-- 
2.17.1

