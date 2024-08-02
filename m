Return-Path: <linux-pci+bounces-11169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D5C94585D
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 09:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B43283CCB
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 07:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5032A15B54E;
	Fri,  2 Aug 2024 07:06:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7BD15A874;
	Fri,  2 Aug 2024 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722582392; cv=none; b=PHxhPMO0U3xDYl8vJsTSSBxYtcgyyycO5ZAxKXRTwY6gKV49rcvbTbCYiK8eLiWq2duYc++2/H9+YU51diLQY6t7+UTm+U8dXEfFLuE9V04leQUDiuXWu2tCEbzvwZ4Ew8tnViCy2VgmLdNqevgOHjOWBIG0Il9pXl33k6lzfh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722582392; c=relaxed/simple;
	bh=Tt99vW0yPGRlG70EaM0HA3UHhbwRYeYBF2lX+BqlYa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qinJf+8lxdZUty5YGvmZ7lxrmf0T9cxg7IiqYrbs11DvoocoM3mFxejTMMnSEFvdBGlL5gc4oqo6iXQZ7agNWFwac+CODkFrH6I3mLEK8dC2onuTl4Na0BzGxdx0Soq/BQn+Yaewqx/6CZ4BpSzLqJzgmP+wJ+RQ+QoEw3h/vqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 99776201083;
	Fri,  2 Aug 2024 09:06:23 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 60079201067;
	Fri,  2 Aug 2024 09:06:23 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B8276181D0F9;
	Fri,  2 Aug 2024 15:06:21 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	l.stach@pengutronix.de
Cc: hongxing.zhu@nxp.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: [PATCH v5 1/5] dt-bindings: ata: Add i.MX8QM AHCI compatible string
Date: Fri,  2 Aug 2024 14:46:49 +0800
Message-Id: <1722581213-15221-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1722581213-15221-1-git-send-email-hongxing.zhu@nxp.com>
References: <1722581213-15221-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add i.MX8QM AHCI "fsl,imx8qm-ahci" compatible strings.

i.MX8QM AHCI SATA doesn't require AHB clock rate to set the vendor
specified TIMER1MS register. ahb clock is not required by i.MX8QM AHCI.

Update the description of clocks in the dt-binding accordingly.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/ata/imx-sata.yaml     | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/imx-sata.yaml b/Documentation/devicetree/bindings/ata/imx-sata.yaml
index 68ffb97ddc9b2..f4eb3550a0960 100644
--- a/Documentation/devicetree/bindings/ata/imx-sata.yaml
+++ b/Documentation/devicetree/bindings/ata/imx-sata.yaml
@@ -19,6 +19,7 @@ properties:
       - fsl,imx53-ahci
       - fsl,imx6q-ahci
       - fsl,imx6qp-ahci
+      - fsl,imx8qm-ahci
 
   reg:
     maxItems: 1
@@ -27,12 +28,14 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 2
     items:
       - description: sata clock
       - description: sata reference clock
       - description: ahb clock
 
   clock-names:
+    minItems: 2
     items:
       - const: sata
       - const: sata_ref
@@ -58,6 +61,25 @@ properties:
     $ref: /schemas/types.yaml#/definitions/flag
     description: if present, disable spread-spectrum clocking on the SATA link.
 
+  phys:
+    items:
+      - description: phandle to SATA PHY.
+          Since "REXT" pin is only present for first lane of i.MX8QM PHY, it's
+          calibration result will be stored, passed through second lane, and
+          shared with all three lanes PHY. The first two lanes PHY are used as
+          calibration PHYs, although only the third lane PHY is used by SATA.
+      - description: phandle to the first lane PHY of i.MX8QM.
+      - description: phandle to the second lane PHY of i.MX8QM.
+
+  phy-names:
+    items:
+      - const: sata-phy
+      - const: cali-phy0
+      - const: cali-phy1
+
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -65,6 +87,31 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx53-ahci
+              - fsl,imx6q-ahci
+              - fsl,imx6qp-ahci
+    then:
+      properties:
+        clock-names:
+          minItems: 3
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8qm-ahci
+    then:
+      properties:
+        clock-names:
+          minItems: 2
+
 additionalProperties: false
 
 examples:
-- 
2.37.1


