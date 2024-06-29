Return-Path: <linux-pci+bounces-9445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C088291CD74
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 15:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C611281D2E
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 13:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60BB81751;
	Sat, 29 Jun 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gb7f+fK5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E98280035;
	Sat, 29 Jun 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719669162; cv=none; b=ZorBZKdvMmsEvhb3L4u5wGSmLWhU9G9KzqEyyk1T90U63GWJsvpz/MRZnmKL6bLAyIZGjCtXlNXiII+ewrEYsnrgCZ3chOnkZdO2lopN53IQCP75Kf9TH/8ACwfoHhIXT71e+RS3FHLVajpYWx70R/7hS58zvDkLTKPt2924aTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719669162; c=relaxed/simple;
	bh=NH5YlDzpIizrxdfHfOmD4jXJlwYT9YVWnCsdWswrG5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACozpAxei0UPAWF/AcfbqdCJwwDqiddYGdZkNGgbNgn3EEHDGOY/Y0AtbxTEaEUE1aCebQPpimob3VlzS6++ajNzYUiyO7puxL3gckGjwzG3qiqt0gWSc3KpSwWttEVuYmQnCqiEw5m0K5mdhI94QprphjtpKM4Z95rinT5R/0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gb7f+fK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D42C2BBFC;
	Sat, 29 Jun 2024 13:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719669162;
	bh=NH5YlDzpIizrxdfHfOmD4jXJlwYT9YVWnCsdWswrG5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gb7f+fK5tttDbM2PemYKGQP/53uVT9dsijwpGkzLDWlHHcCGHemnglpTh7IYGEDGi
	 DoZ45HcANLaPahQlADcGklqa1Jy8mu4nHu0c3+rN95oj11cn4ZJgBB9DLsfxPLBjBn
	 bWERAmbWieTpR3Qj6LQzX9xghX1LBF2nz0kdY1ocPyr+BVtZgL7FCooulrD/P7lUcV
	 9oDezm51pIKbKa/i1mx6RPKSYzt8OQm4v1y5TUIttfLy1PhfBjFifTShep+RMIoTDq
	 LYXFWzelJW5v7YR9wxpo9y8aOTB9KVuvQdZJaZisCuMqXkCfTyVWSsAkyh+hWLd1my
	 /jMOOToTrpWiQ==
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
Subject: [PATCH v3 1/4] dt-bindings: PCI: mediatek-gen3: add support for Airoha EN7581
Date: Sat, 29 Jun 2024 15:51:51 +0200
Message-ID: <7622715d622413d1b4d8752657f87ea81001deb9.1719668763.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719668763.git.lorenzo@kernel.org>
References: <cover.1719668763.git.lorenzo@kernel.org>
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


