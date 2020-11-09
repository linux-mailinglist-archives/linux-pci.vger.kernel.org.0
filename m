Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6972AC1B5
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 18:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbgKIREg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 12:04:36 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55352 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731082AbgKIREg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2020 12:04:36 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A9H4VSB107654;
        Mon, 9 Nov 2020 11:04:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604941471;
        bh=FZ6tzg3tQDmmfBsqprfpFisT1FjAStoGzjl9svcH6R4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VZQ972EYKD7pjVmcPZvIfE/GsUZe9VuULBhSAtw7cQXnGYNTJeTPlolqDbkE/UurM
         tJ3ia7073lxV3TJ5lOVcDdHPbBqxtcbFh69cwxSX/FEyl5sf95chv2QJcXDHe0sp+y
         p0EQ8iiOFc/WlsKp3+5qtjDNKhUfXjkf9x5km1u8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A9H4VnP057612
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Nov 2020 11:04:31 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 9 Nov
 2020 11:04:31 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 9 Nov 2020 11:04:31 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A9H4AwW036684;
        Mon, 9 Nov 2020 11:04:26 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@ti.com>, Lee Jones <lee.jones@linaro.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/7] dt-bindings: PCI: Add EP mode dt-bindings for TI's J7200 SoC
Date:   Mon, 9 Nov 2020 22:34:05 +0530
Message-ID: <20201109170409.4498-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201109170409.4498-1-kishon@ti.com>
References: <20201109170409.4498-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe EP mode dt-bindings for TI's J7200 SoC.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

