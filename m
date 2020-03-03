Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 266D0177348
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 10:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgCCJ7W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 04:59:22 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34828 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgCCJ7V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 04:59:21 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0239xA8M006545;
        Tue, 3 Mar 2020 03:59:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583229550;
        bh=rd0eymCe4Xka8bXMlhT8cKIiDJXli0ok1kRr/8AnPJ0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=T4oqpdq8WBe6XyMwk8t82ITcaxr/QUTImzvgap7bBsPmadKsUzNRkCY9KIPCUqg7G
         7T6SP9V8YmlEcKkEk0lzTXHyK7eO+6mo2TfluRVMcuhxZhi78Bo1EaL+F7SebD/Q8+
         TPageqthJFm+vn9L+RLLYcdbvhRIs5VPFEzyElAU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0239xAv4105493
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Mar 2020 03:59:10 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 3 Mar
 2020 03:59:09 -0600
Received: from localhost.localdomain (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 3 Mar 2020 03:59:09 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 0239wtHo052895;
        Tue, 3 Mar 2020 03:59:07 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 4/4] dt-bindings: PCI: cadence: Deprecate inbound/outbound specific bindings
Date:   Tue, 3 Mar 2020 15:33:27 +0530
Message-ID: <20200303100327.3603-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303100327.3603-1-kishon@ti.com>
References: <20200303100327.3603-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Deprecate cdns,max-outbound-regions and cdns,no-bar-match-nbits as both
these could be derived from "ranges" and "dma-ranges" property.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml | 3 +--
 Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml      | 1 +
 Documentation/devicetree/bindings/pci/cdns-pcie.yaml           | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
index cabbe46ff578..84a8f095d031 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
@@ -45,8 +45,6 @@ examples:
             #size-cells = <2>;
             bus-range = <0x0 0xff>;
             linux,pci-domain = <0>;
-            cdns,max-outbound-regions = <16>;
-            cdns,no-bar-match-nbits = <32>;
             vendor-id = <0x17cd>;
             device-id = <0x0200>;
 
@@ -57,6 +55,7 @@ examples:
 
             ranges = <0x02000000 0x0 0x42000000  0x0 0x42000000  0x0 0x1000000>,
                      <0x01000000 0x0 0x43000000  0x0 0x43000000  0x0 0x0010000>;
+            dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x1 0x00000000>;
 
             #interrupt-cells = <0x1>;
 
diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
index ab6e43b636ec..d1c34f83a765 100644
--- a/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
@@ -23,5 +23,6 @@ properties:
     minimum: 0
     maximum: 64
     default: 32
+    deprecated: true
 
   msi-parent: true
diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie.yaml
index 6887ccc339cc..893cf7de9891 100644
--- a/Documentation/devicetree/bindings/pci/cdns-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/cdns-pcie.yaml
@@ -17,6 +17,7 @@ properties:
     minimum: 1
     maximum: 32
     default: 32
+    deprecated: true
 
   phys:
     description:
-- 
2.17.1

