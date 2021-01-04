Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5C92E951A
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jan 2021 13:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbhADMme (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 07:42:34 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34956 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbhADMmd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jan 2021 07:42:33 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 104Cfj1G015247;
        Mon, 4 Jan 2021 06:41:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1609764105;
        bh=ekIjBsGEy8ttVisERONWFmyGyUxpFsUO4LLaUm07A6A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eGjuHFPqO9E0G40l1ubfF9q9XagbjWUNzwQZXW6oAJmvxNDBT0kQo0NK5s3A1nE6k
         6bCIudcJxc62vSC7hsf/sK+q/YSWFz6yfi1FDiYugsJO0jbFhvpvLJ4FXsvzAutDCP
         HsOO5qhPqzyM4pX/Om61J6uPBd4UxAu619wqZSY0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 104CfjiD081592
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Jan 2021 06:41:45 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 4 Jan
 2021 06:41:21 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 4 Jan 2021 06:41:22 -0600
Received: from a0393678-ssd.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 104Cf3bj034579;
        Mon, 4 Jan 2021 06:41:18 -0600
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
Subject: [PATCH v2 3/4] dt-bindings: pci: ti,j721e: Add endpoint mode dt-bindings for TI's AM64 SoC
Date:   Mon, 4 Jan 2021 18:11:02 +0530
Message-ID: <20210104124103.30930-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210104124103.30930-1-kishon@ti.com>
References: <20210104124103.30930-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add endpoint mode dt-bindings for TI's AM64 SoC. This is the same IP
used in J7200, however AM64 is a non-coherent architecture.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml       | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
index d06f0c4464c6..447c8fe0f09e 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
@@ -16,12 +16,17 @@ allOf:
 properties:
   compatible:
     oneOf:
-      - description: PCIe EP controller in J7200
+      - const: ti,am64-pcie-ep
+      - const: ti,j7200-pcie-ep
+      - const: ti,j721e-pcie-ep
+      - description: PCIe EP controller in AM64
         items:
+          - const: ti,am64-pcie-ep
           - const: ti,j7200-pcie-ep
           - const: ti,j721e-pcie-ep
-      - description: PCIe EP controller in J721E
+      - description: PCIe EP controller in J7200
         items:
+          - const: ti,j7200-pcie-ep
           - const: ti,j721e-pcie-ep
 
   reg:
@@ -66,7 +71,6 @@ required:
   - power-domains
   - clocks
   - clock-names
-  - dma-coherent
   - max-functions
   - phys
   - phy-names
-- 
2.17.1

