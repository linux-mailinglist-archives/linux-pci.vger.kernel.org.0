Return-Path: <linux-pci+bounces-9736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F289265C6
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 18:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57B5CB27A75
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 16:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CA9181CED;
	Wed,  3 Jul 2024 16:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYV/dY/c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E439442C;
	Wed,  3 Jul 2024 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023194; cv=none; b=jpn/1QOa4yIbKyxApzZIWqVTwpy+bTs3S9bWFGh4pNmnILTh62zwrDc+YuOIGS+Go8xsYXYjTaF0x9MV+yECwef91xu85u+TFW7LXqij9QCFnbGGl+04GUt14cUNdUzvCE8QdntKUMdmWVqeRjUVEyJ7GMxmyxzAqfJpLmVaWRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023194; c=relaxed/simple;
	bh=iqoQv7Ea5scHNcYdRFyf2CSEBTLYhaq8j8HUyjyvcz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNM+DFUnG9fHTMHJuI6jXSD+EX6YgoeiDsce+Fqz18wtbVYYXqnVjFtQfNdfx6cRD5u9m7gRB+wjJrgSXEHPiOofeh8F2HWVO9VdsBaSIlMyR+SZ6+Z27dQpf5CAMHKpNPi8bBTD8epjYmpmDNsRMVtaIqXf5cVgyAjzsdOQ5UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYV/dY/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42420C2BD10;
	Wed,  3 Jul 2024 16:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720023193;
	bh=iqoQv7Ea5scHNcYdRFyf2CSEBTLYhaq8j8HUyjyvcz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eYV/dY/cHyP+cmCUv/VsrHAyPVwF3d1gKs/GRcMmxj5rKT0ymZmXJAgEtgt7K7xg+
	 19XziyLAintY+YJ1A3ndS3hFV7kznsUy+QPnwU3eIYUJgcn8ECkdqj1oC77RmmUATt
	 QV6OvL76i0Z3RzzsJyRx05zWjpt6fVPajtQWLXRhEegGnyIYmSikfO5cTgjZ9v6rSO
	 aN0aWpznyW5hNuvWz1khpJfXWFSxV1r237b3ycwj0wLs/pZug+ppPUqBH119LbLCBl
	 2qnH2L7baM111KPr33WCYAl3q5Kt1YB+cConJbZ+6Rs0eUoBZDYayI42OPC+gKV3W3
	 rIyBOn8sUYDxQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	linux-mediatek@lists.infradead.org,
	lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org,
	nbd@nbd.name,
	dd@embedd.com,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: [PATCH v4 1/4] dt-bindings: PCI: mediatek-gen3: add support for Airoha EN7581
Date: Wed,  3 Jul 2024 18:12:41 +0200
Message-ID: <138d65a140c3dcf2a6aefecc33ba6ba3ca300a23.1720022580.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720022580.git.lorenzo@kernel.org>
References: <cover.1720022580.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce Airoha EN7581 entry in mediatek-gen3 PCIe controller binding

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/pci/mediatek-pcie-gen3.yaml      | 68 +++++++++++++++++--
 1 file changed, 63 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index 76d742051f73..898c1be2d6a4 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -53,6 +53,7 @@ properties:
               - mediatek,mt8195-pcie
           - const: mediatek,mt8192-pcie
       - const: mediatek,mt8192-pcie
+      - const: airoha,en7581-pcie
 
   reg:
     maxItems: 1
@@ -76,20 +77,20 @@ properties:
 
   resets:
     minItems: 1
-    maxItems: 2
+    maxItems: 3
 
   reset-names:
     minItems: 1
-    maxItems: 2
+    maxItems: 3
     items:
-      enum: [ phy, mac ]
+      enum: [ phy, mac, phy-lane0, phy-lane1, phy-lane2 ]
 
   clocks:
-    minItems: 4
+    minItems: 1
     maxItems: 6
 
   clock-names:
-    minItems: 4
+    minItems: 1
     maxItems: 6
 
   assigned-clocks:
@@ -147,6 +148,9 @@ allOf:
           const: mediatek,mt8192-pcie
     then:
       properties:
+        clocks:
+          minItems: 4
+
         clock-names:
           items:
             - const: pl_250m
@@ -155,6 +159,15 @@ allOf:
             - const: tl_32k
             - const: peri_26m
             - const: top_133m
+
+        resets:
+          minItems: 1
+          maxItems: 2
+
+        reset-names:
+          minItems: 1
+          maxItems: 2
+
   - if:
       properties:
         compatible:
@@ -164,6 +177,9 @@ allOf:
               - mediatek,mt8195-pcie
     then:
       properties:
+        clocks:
+          minItems: 4
+
         clock-names:
           items:
             - const: pl_250m
@@ -172,6 +188,15 @@ allOf:
             - const: tl_32k
             - const: peri_26m
             - const: peri_mem
+
+        resets:
+          minItems: 1
+          maxItems: 2
+
+        reset-names:
+          minItems: 1
+          maxItems: 2
+
   - if:
       properties:
         compatible:
@@ -180,6 +205,9 @@ allOf:
               - mediatek,mt7986-pcie
     then:
       properties:
+        clocks:
+          minItems: 4
+
         clock-names:
           items:
             - const: pl_250m
@@ -187,6 +215,36 @@ allOf:
             - const: peri_26m
             - const: top_133m
 
+        resets:
+          minItems: 1
+          maxItems: 2
+
+        reset-names:
+          minItems: 1
+          maxItems: 2
+
+  - if:
+      properties:
+        compatible:
+          const: airoha,en7581-pcie
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+
+        clock-names:
+          items:
+            - const: sys-ck
+
+        resets:
+          minItems: 3
+
+        reset-names:
+          items:
+            - const: phy-lane0
+            - const: phy-lane1
+            - const: phy-lane2
+
 unevaluatedProperties: false
 
 examples:
-- 
2.45.2


