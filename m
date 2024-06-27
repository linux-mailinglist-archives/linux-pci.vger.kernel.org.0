Return-Path: <linux-pci+bounces-9352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 641CF91A131
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 10:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDFA285757
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 08:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8F7757E5;
	Thu, 27 Jun 2024 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDP7mXAm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113CA4D8C8;
	Thu, 27 Jun 2024 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719475981; cv=none; b=S5PcttkqR9/xHdvLZcSJeeCWuWH4bCggSfEdGTARlmwCH/QwCQBc/OMBDnOHXMCnCxu7XU3mS3BS9QPKaYK83FIUK/mwDbBt0td9aTeBhITJj7QCpevo8wZ1k98QieS7prEjE5f9JZhtsJxWb9R/5L4vnxlq7IH7Aytr3SYJlpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719475981; c=relaxed/simple;
	bh=AdH9yMFml0qHN75VLNxdrAIygg5nHmecEEHRnjfXV20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTXErqCqBsPqhTOcSHgUvN86GOB/moS+kIsEIfZxV9BYlRfPyIRdEacEPTqGFqmzAdeJY/GQ3fqw6/P10m3iffk8YxZNEmtReFbT3vUO9yLRJwan6z307VLWhieLqZQdP7YRVGU828Guow39Vb408Ndt+vRQe2vYR5LRribGoQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDP7mXAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16475C2BBFC;
	Thu, 27 Jun 2024 08:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719475980;
	bh=AdH9yMFml0qHN75VLNxdrAIygg5nHmecEEHRnjfXV20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bDP7mXAma8rxtaNvsn4u+7/dPFGY/QWdQbO/qH+ZfVV/Ag4dylUyo+/mvGQUFsr0g
	 +aReros4qIQ1A4dJwUu6ZM/aIPEZVpbyYJ4euIS5ORy4if15EOu6J90Us6kEVxQoDO
	 xmxfNShl7tZjBE36cHb9C0Z1dndOmgyKws4wpErxzEk1c5YtI82w7ng+ulZnf56PTT
	 d1X0jOk17SZhO6QFiZW2ODdSxh6s2sdPUe2opmc+Ww0nbtIEE9EG2j7yWKYAyx9neV
	 ah2yWG3NTf7b0rwcYJlLOO2E9Gos2vIsezG1YiLDx38tRXTzBH4aW3ajQQb4EIhWlV
	 MHAdCk2THg65w==
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
Subject: [PATCH v2 1/4] dt-bindings: PCI: mediatek-gen3: add support for Airoha EN7581
Date: Thu, 27 Jun 2024 10:12:11 +0200
Message-ID: <c11a40dbe3e1d1e4847ceee8715c1f670fd1887b.1719475568.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719475568.git.lorenzo@kernel.org>
References: <cover.1719475568.git.lorenzo@kernel.org>
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
index 76d742051f73..59112adc9ba1 100644
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
+          maxItems: 6
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
+          maxItems: 6
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
+          maxItems: 4
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
+          maxItems: 3
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


