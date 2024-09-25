Return-Path: <linux-pci+bounces-13491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65F0985319
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 08:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97EAD2841F5
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 06:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2228E156230;
	Wed, 25 Sep 2024 06:47:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFFF147C86;
	Wed, 25 Sep 2024 06:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727246826; cv=none; b=RVIu6MBeyARpHWxc8G6ShJ1+iGsDOFcYf4QCAj7PhKgZjhTcvInSPkFHED3rcGlsrADcYB2/3MPrYvLqInBO37EPH25SdvTftM90kCEKgPKAPX4PzcS5lF29WPwyUKui6aLs5uTdAsRJrdMqibcUgpMcO0OQuI02vEqNjOsW3tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727246826; c=relaxed/simple;
	bh=s39dG3Qzyk1vwY9Rq9OBpIM2tzPxIRjVphXKjRh8vYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=boP2E3ANsPyvDUSxf778XDGtJTQwyKi57+ua8i9Gn2T7MlSE9K64ZS77zqOLEiQdJAH1OCiSpqnPQdIRf1Gwv6JiG6lRA4auVzC5qNERBBGu6tn7TRiE4DFdnLLNFiHZCfjreg2QPRYNRrsNkOmzSrUZ9x4B0yIWPVgAxgITppM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CCD492029F5;
	Wed, 25 Sep 2024 08:47:02 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9CA4C200543;
	Wed, 25 Sep 2024 08:47:02 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 95CC4183AD44;
	Wed, 25 Sep 2024 14:47:00 +0800 (+08)
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
Subject: [PATCH v2 1/9] dt-bindings: imx6q-pcie: Add ref clock for i.MX95 PCIe
Date: Wed, 25 Sep 2024 14:24:29 +0800
Message-Id: <1727245477-15961-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1727245477-15961-1-git-send-email-hongxing.zhu@nxp.com>
References: <1727245477-15961-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Previous reference clock of i.MX95 is on when system boot to kernel. But
boot firmware change the behavor, it is off when boot. So it needs be turn
on when it is used. Also it needs be turn off/on when suspend and resume.

Add one ref clock for i.MX95 PCIe. Increase clocks' maxItems to 5 and keep
the same restriction with other compatible string.

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


