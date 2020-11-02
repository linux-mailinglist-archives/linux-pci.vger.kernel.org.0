Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347892A27EE
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 11:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgKBKMf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 05:12:35 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38302 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgKBKMf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 05:12:35 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A2ACSdC003121;
        Mon, 2 Nov 2020 04:12:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604311948;
        bh=4EnqAmwlw82FiJ23Vk3WWXJCCIA3eH6H7JCGMc3LOoc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cmrqTADV+sQ+ClRKqSI+VwUNLlYqd0xOHqXb0SRfyKeXKlcEXfkJ3OzYOtycASgkD
         4M4uRvaboxOtyzth++zkqw5Rt+j+fDmG/vTN52/BE0W8cmx9Y31zFfJMGT2KcuzsWb
         YO6QyHKR8WVSn1Htz9i0jCLo2SdzAc+tzmg2r1fU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A2ACSJ0067927
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 04:12:28 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 04:12:12 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 04:12:12 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A2ABtua059084;
        Mon, 2 Nov 2020 04:12:09 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Roger Quadros <rogerq@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/8] dt-bindings: PCI: Add EP mode dt-bindings for TI's J7200 SoC
Date:   Mon, 2 Nov 2020 15:41:49 +0530
Message-ID: <20201102101154.13598-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102101154.13598-1-kishon@ti.com>
References: <20201102101154.13598-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe EP mode dt-bindings for TI's J7200 SoC.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml       | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
index 3ae3e1a2d4b0..da8c5b892104 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
@@ -15,8 +15,14 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - ti,j721e-pcie-ep
+    oneOf:
+      - description: PCIe EP controller in J7200
+        items:
+          - const: ti,j7200-pcie-ep
+          - const: ti,j721e-pcie-ep
+      - description: PCIe EP controller in J721E
+        items:
+          - const: ti,j721e-pcie-ep
 
   reg:
     maxItems: 4
-- 
2.17.1

