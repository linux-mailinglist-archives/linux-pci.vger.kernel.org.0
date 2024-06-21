Return-Path: <linux-pci+bounces-9076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44499912876
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 16:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F61B2B920
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 14:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3531B2C6BB;
	Fri, 21 Jun 2024 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qd9uhgLd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0692231F;
	Fri, 21 Jun 2024 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981357; cv=none; b=CeC6qOWixuJO0xewTbn0na1ZFCpwMki5tgq4rK6OlBsux9TCU99NnRh/DfIzgV6Mc1Il9rTx1/EpV1A5hBSreSu4GMjhynwLdGStIhTHS7gzb4tRHQPu29S3iD8c2W+L+890wSreUIQsuOsJFLgWj3fP3olST6oEE5jt2KzxqC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981357; c=relaxed/simple;
	bh=u2HF2BfpyUNmuOCq2K29l3mxTzrcir390lZ7LUajRi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kee0Op/rne5sBkwt3beE3jlwOLBj7yjSPHOXJxyE5gW9O8olyJCBPJpZn0etpH08w4tWwKNCefoDbwDGFSJ0MlpPybqzTBATI4Ajk6g5wclraqCtw+EFixegvitwPtvcP67G+nZicU+9qpgan8knbxfOmlg7y0Ot4AYfmLcqli4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qd9uhgLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF17C2BBFC;
	Fri, 21 Jun 2024 14:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718981356;
	bh=u2HF2BfpyUNmuOCq2K29l3mxTzrcir390lZ7LUajRi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qd9uhgLdRfFD1KPKC+duj+/haw+NcpLoZteMIPEgJKfbZMPIO8yV0/LnKPMzlptrw
	 R4rHee8GSY/j7VAd0k+LRl7OiKFyHQxqWVW7ytug1jXadzyFYkVpKvT3xxz9KqNGJV
	 6uy16QZIO7kuqqU+43GKA/DKvb7vqf3vcy0txtKoqPdPciakFA52oiyr1JsKQL/GwO
	 YWhzMOsOjUE/ozZYcbpz96x0yOxTg5RQPCOZwoaUxqmRO695/LowRY5jJx2ap3XMSk
	 kE63Mg70vEGp4H8hYOtp1cKm09u6l4vtUhz4e0+Zwr2yfMNCLLHliiDwLLyHQdcEWj
	 Z7U60X42FwZtA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com,
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
Subject: [PATCH 1/4] dt-bindings: PCI: mediatek-gen3: add support for Airoha EN7581
Date: Fri, 21 Jun 2024 16:48:47 +0200
Message-ID: <a215d6d8a91fccdbd1a28dd3262a3e5db1b728fd.1718980864.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718980864.git.lorenzo@kernel.org>
References: <cover.1718980864.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce Airoha EN7581 entry in mediatek-gen3 PCIe controller binding

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/pci/mediatek-pcie-gen3.yaml      | 25 +++++++++++++++----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index 76d742051f73..0f35cf49de63 100644
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
@@ -186,6 +187,20 @@ allOf:
             - const: tl_26m
             - const: peri_26m
             - const: top_133m
+  - if:
+      properties:
+        compatible:
+          const: airoha,en7581-pcie
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: sys_ck
+        reset-names:
+          items:
+            - const: phy-lane0
+            - const: phy-lane1
+            - const: phy-lane2
 
 unevaluatedProperties: false
 
-- 
2.45.2


