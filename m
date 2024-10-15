Return-Path: <linux-pci+bounces-14521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 438A899E1CA
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 10:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6FE1B22134
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 08:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EF01D9580;
	Tue, 15 Oct 2024 08:57:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A2A1CEAD3;
	Tue, 15 Oct 2024 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982647; cv=none; b=C4mB155Kfs3beeeIIa9VmbZSGrx/UzI5jL8g2LuawgAczMjBTte4Rth0hnlS+KrZujiHcMnBJ9DiLa1bWQG11uyL4cfM8YKy9y/T50M015MeDDlzk2WRTu3zSM8ouyrz4gJMMN4/OsAsWPIYN5Rmfr1knAPHlQbDR/tKimBdMw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982647; c=relaxed/simple;
	bh=Dti4PgfwotkBHW4ZTTTV0D9nI7BsYJsuI6h/6skhEdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ssXXG5T/cYWINOtID6jwsr+XNlSG97EL899wmdbILFiSOoits4sPcUJOH4APa3OkkmhQw07IWp1A5N5+cn1Q5awbk3ffhiosLcry8p2G5iKnRGwyYcKq+ch1nHifFn/QkHVz9jYoW/OxP61NPw10pkyL28lJT51Pj6d2Tclp23c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E84331A0456;
	Tue, 15 Oct 2024 10:57:23 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ABC291A059C;
	Tue, 15 Oct 2024 10:57:23 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8CD74183DC02;
	Tue, 15 Oct 2024 16:57:21 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	festevam@gmail.com,
	s.hauer@pengutronix.de
Cc: hongxing.zhu@nxp.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: [PATCH v4 1/9] dt-bindings: imx6q-pcie: Add ref clock for i.MX95 PCIe RC
Date: Tue, 15 Oct 2024 16:33:25 +0800
Message-Id: <1728981213-8771-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1728981213-8771-1-git-send-email-hongxing.zhu@nxp.com>
References: <1728981213-8771-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Previous reference clock of i.MX95 PCIe RC is on when system boot to
kernel. But boot firmware change the behavor, it is off when boot. So it
needs be turn on when it is used. Also it needs be turn off/on when suspend
and resume.

Add one ref clock for i.MX95 PCIe RC. Increase clocks' maxItems to 5 and keep
the same restriction with other compatible string.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  4 +--
 .../bindings/pci/fsl,imx6q-pcie-ep.yaml       |  1 +
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 25 ++++++++++++++++---
 3 files changed, 24 insertions(+), 6 deletions(-)

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
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index 84ca12e8b25b..f41f704c6729 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
@@ -103,6 +103,7 @@ allOf:
       properties:
         clocks:
           minItems: 4
+          maxItems: 4
         clock-names:
           items:
             - const: pcie
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


