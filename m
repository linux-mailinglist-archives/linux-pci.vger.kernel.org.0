Return-Path: <linux-pci+bounces-2261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4114830380
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 11:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41221C21F45
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 10:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4201CFB7;
	Wed, 17 Jan 2024 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IGqHNsjz"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3A01C688;
	Wed, 17 Jan 2024 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705487160; cv=none; b=cPrx0iBZGGe0sbXPpGukJWJwgg6cA0kPS742ni1WjW9YPSpjGaXa3IPK7E7JIIsUEmn7zj58om6A0YfOV5pRQVugPo4XtTzy5zTPMVexRcgEPLmBEMl/oMvr55mgdZ8xmWZNcEEjIGUWkCLs/mdqsOw7ogg5/LCNg3FUJrbWX74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705487160; c=relaxed/simple;
	bh=y5LACg26gms7ionU9Ein9Zbr8O1IRR5m5lnwW1h0SFU=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EXCLAIMER-MD-CONFIG; b=YE89nn444hKAHpKsHaOWU5EbuzZSq5Yv3J5tXu0YI0W8+sCX80XCCJgj/x029+nZWKc+LY/zH59fmkS02wvK48Q3wMJApzVOZ8WylwJrxaV49Nq+/sUbk/+rJIgy6Cao8NAEKehabHyVKMD69Zy1xF2j7ASg18nB8IcdaaY9lHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IGqHNsjz; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40HAPZAw105560;
	Wed, 17 Jan 2024 04:25:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705487135;
	bh=1NNkaI42Hc7TBXVBYnyRbtIbsZVBSgd7WE0qsCIVHFM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=IGqHNsjzbslsQ9R386dDMLmIBdMoPbwbZwW05P2LsDpj5s3IPMEkGNUujO9s32w9Z
	 rPnZr2yFT+0eqi6vsq53ooeFyZBpEibBPbcmu2Jz3sr74JS9I6BaBsMOqioUk74Ymv
	 Fv9DNrVl2v5FH6o3K7+5xKxsvnWdd3RxI+FCsRGA=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40HAPZD5035433
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jan 2024 04:25:35 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Jan 2024 04:25:35 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Jan 2024 04:25:35 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40HAPQIg042834;
	Wed, 17 Jan 2024 04:25:31 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <afd@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 1/3] dt-bindings: PCI: ti,j721e-pci-*: Fix check for num-lanes
Date: Wed, 17 Jan 2024 15:55:24 +0530
Message-ID: <20240117102526.557006-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117102526.557006-1-s-vadapalli@ti.com>
References: <20240117102526.557006-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The existing implementation for validating the "num-lanes" property
based on the compatible(s) doesn't enforce it. Fix it by updating the
checks to handle both single-compatible and multi-compatible cases.

Fixes: b3ba0f6e82cb ("dt-bindings: PCI: ti,j721e-pci-*: Add checks for num-lanes")
Fixes: adc14d44d7cb ("dt-bindings: PCI: ti,j721e-pci-*: Add j784s4-pci-* compatible strings")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 .../bindings/pci/ti,j721e-pci-ep.yaml         | 26 ++++++++++++++-----
 .../bindings/pci/ti,j721e-pci-host.yaml       | 26 ++++++++++++++-----
 2 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
index 97f2579ea908..278e0892f8ac 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
@@ -68,8 +68,9 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - ti,am64-pcie-ep
+          items:
+            - const: ti,am64-pcie-ep
+            - const: ti,j721e-pcie-ep
     then:
       properties:
         num-lanes:
@@ -78,9 +79,9 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - ti,j7200-pcie-ep
-            - ti,j721e-pcie-ep
+          items:
+            - const: ti,j7200-pcie-ep
+            - const: ti,j721e-pcie-ep
     then:
       properties:
         num-lanes:
@@ -90,8 +91,19 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - ti,j784s4-pcie-ep
+          items:
+            - const: ti,j721e-pcie-ep
+    then:
+      properties:
+        num-lanes:
+          minimum: 1
+          maximum: 4
+
+  - if:
+      properties:
+        compatible:
+          items:
+            - const: ti,j784s4-pcie-ep
     then:
       properties:
         num-lanes:
diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
index b7a534cef24d..36bcc8cb7896 100644
--- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
@@ -97,8 +97,9 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - ti,am64-pcie-host
+          items:
+            - const: ti,am64-pcie-host
+            - const: ti,j721e-pcie-host
     then:
       properties:
         num-lanes:
@@ -107,9 +108,9 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - ti,j7200-pcie-host
-            - ti,j721e-pcie-host
+          items:
+            - const: ti,j7200-pcie-host
+            - const: ti,j721e-pcie-host
     then:
       properties:
         num-lanes:
@@ -119,8 +120,19 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - ti,j784s4-pcie-host
+          items:
+            - const: ti,j721e-pcie-host
+    then:
+      properties:
+        num-lanes:
+          minimum: 1
+          maximum: 4
+
+  - if:
+      properties:
+        compatible:
+          items:
+            - const: ti,j784s4-pcie-host
     then:
       properties:
         num-lanes:
-- 
2.34.1


