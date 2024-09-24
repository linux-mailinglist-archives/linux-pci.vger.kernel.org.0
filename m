Return-Path: <linux-pci+bounces-13404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D85F8983BE6
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 05:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D29B1C21B6F
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 03:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2688F1DDE9;
	Tue, 24 Sep 2024 03:57:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C52418E1F;
	Tue, 24 Sep 2024 03:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727150229; cv=none; b=G1Mt9xzuEapDhR0KINR3y5pcdmTYRSXDUTBbYP5VSoAjpHjNzL+Mh+YSscc4n98yx1hQ1A49YYbgtxVk4jN2TCZ02TIxHfPWWHZXlBruHNdruXaJ8CjqysfaeLVp1cUzgOJj1XadSEVTy1chRan4EwOx58KOh6B1PWmcmwC/sIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727150229; c=relaxed/simple;
	bh=ft8T7vyj4O30mPZHu0cq8yjwL9jNAdrkHoj9fknanZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PBys1LVBINGr7lEBmaD/QUdRcymhWEF4hmoDcnoX5m/TPfkxRAVDHOcezBHah632yUGBT17gcyIdWrKmEIQOJDNIkUscX5Qz2qb2cVfHHecVeHssKNp0eZwl3YOlNzfml3pzwPTm3N1LcZG7KS2cCcsGRVDjjypmc8bxmWkk0LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CED721A144E;
	Tue, 24 Sep 2024 05:50:22 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9717F1A1440;
	Tue, 24 Sep 2024 05:50:22 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 93F1E183DC02;
	Tue, 24 Sep 2024 11:50:20 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: l.stach@pengutronix.de,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	frank.li@nxp.com,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	festevam@gmail.com,
	s.hauer@pengutronix.de
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 1/9] dt-bindings: imx6q-pcie: Add ref clock for i.MX95 PCIe
Date: Tue, 24 Sep 2024 11:27:36 +0800
Message-Id: <1727148464-14341-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1727148464-14341-1-git-send-email-hongxing.zhu@nxp.com>
References: <1727148464-14341-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add one ref clock for i.MX95 PCIe. Increase clocks' maxItems to 5 and
keep the same restriction with other compatible string.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  4 +--
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 25 ++++++++++++++++---
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
index a8b34f58f8f4..cddbe21f99f2 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
@@ -17,11 +17,11 @@ description:
 properties:
   clocks:
     minItems: 3
-    maxItems: 4
+    maxItems: 5
 
   clock-names:
     minItems: 3
-    maxItems: 4
+    maxItems: 5
 
   num-lanes:
     const: 1
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 1e05c560d797..4c76cd3f98a9 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -40,10 +40,11 @@ properties:
       - description: PCIe PHY clock.
       - description: Additional required clock entry for imx6sx-pcie,
            imx6sx-pcie-ep, imx8mq-pcie, imx8mq-pcie-ep.
+      - description: PCIe reference clock.
 
   clock-names:
     minItems: 3
-    maxItems: 4
+    maxItems: 5
 
   interrupts:
     items:
@@ -127,7 +128,7 @@ allOf:
     then:
       properties:
         clocks:
-          minItems: 4
+          maxItems: 4
         clock-names:
           items:
             - const: pcie
@@ -140,11 +141,10 @@ allOf:
         compatible:
           enum:
             - fsl,imx8mq-pcie
-            - fsl,imx95-pcie
     then:
       properties:
         clocks:
-          minItems: 4
+          maxItems: 4
         clock-names:
           items:
             - const: pcie
@@ -200,6 +200,23 @@ allOf:
             - const: mstr
             - const: slv
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx95-pcie
+    then:
+      properties:
+        clocks:
+          maxItems: 5
+        clock-names:
+          items:
+            - const: pcie
+            - const: pcie_bus
+            - const: pcie_phy
+            - const: pcie_aux
+            - const: ref
+
 unevaluatedProperties: false
 
 examples:
-- 
2.37.1


