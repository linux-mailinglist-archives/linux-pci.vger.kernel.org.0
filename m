Return-Path: <linux-pci+bounces-30377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2CCAE3F17
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 14:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E560C1883EF0
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 12:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A871A25A33E;
	Mon, 23 Jun 2025 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NrDeY5ZP"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC5930E85D;
	Mon, 23 Jun 2025 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680070; cv=none; b=DB5bnpm5qdKvbMl5mGloK0vU/2GaVmzhDDUJ6937Nlbhyi0GqpZGdIk7UuMkZRdVwKdFf2JQ+iLTBu/NwjEWEfLIGv6s1YJFeI9GpGWIG7/Pc1Te8pTyVJFmoqfB8o8VKXnK6X4+gzLL8QqIbMY6t01dSFz5Woyi942IL3cp3Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680070; c=relaxed/simple;
	bh=4YZC1yBzz98fnTISzErlxhtsitEhMR41vg8eXDbdCg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gw7UXrT3/xe2op490VTGkE2jpFGj+0191isqHhK5jmozjbn7askeGRGLTGVCHKe1oKFsg5Q5+YwhOInrLggBOarhd4yj3eEZRqiz1epAK8HvVxEJowylIb2Nf954lawidlSeAGYZNGvlm3/OqySoSg5I5oIxIMkgvxrzXwWqNXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NrDeY5ZP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750680067;
	bh=4YZC1yBzz98fnTISzErlxhtsitEhMR41vg8eXDbdCg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NrDeY5ZPfGNDNpFRaQXvk1zD2HO7zttavLLRmTDmu4irZfjDfBsspNPViZ/Z+PLd1
	 CK3Fr9jGeSoQCbTVIDeWlm+gft14jzIuxi6RIKhspkBCJ378fadHG0oYt1zRvro0qk
	 0CS4Y9LO9/z4NbBBW4jYWVx09CWSGg8ky/7Vp5k9rgqaFwOEZpzv9X8DG1Uz9eqYkt
	 jRGuTMPFBYxgoQ50HI5vFxluE1P6RAxIbJaBYwTNwJn2M7oFHC9iUoeVNp/P+FkYwS
	 64RjiXLwLvNwFJp23qzOu/Ejir2pVTjpo9HO7pzkgUq51Z/rLNsC/Nav4Pn/vFRyRG
	 3pIGLsu9/+XMQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A5C2517E10D5;
	Mon, 23 Jun 2025 14:01:06 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jianjun.wang@mediatek.com
Cc: ryder.lee@mediatek.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 2/3] dt-bindings: PCI: mediatek-gen3: Add support for MT6991/MT8196
Date: Mon, 23 Jun 2025 14:00:57 +0200
Message-ID: <20250623120058.109036-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623120058.109036-1-angelogioacchino.delregno@collabora.com>
References: <20250623120058.109036-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible strings for MT8196 and MT6991 (which are fully
compatible between each other) and clock definitions.

These new SoCs don't have tl_96m and tl_32k clocks, but need
an AHB to APB bus clock and a low power clock.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/pci/mediatek-pcie-gen3.yaml      | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index 162406e0691a..02cddf0246ce 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -52,7 +52,12 @@ properties:
               - mediatek,mt8188-pcie
               - mediatek,mt8195-pcie
           - const: mediatek,mt8192-pcie
+      - items:
+          - enum:
+              - mediatek,mt6991-pcie
+          - const: mediatek,mt8196-pcie
       - const: mediatek,mt8192-pcie
+      - const: mediatek,mt8196-pcie
       - const: airoha,en7581-pcie
 
   reg:
@@ -212,6 +217,36 @@ allOf:
 
         mediatek,pbus-csr: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt8196-pcie
+    then:
+      properties:
+        clocks:
+          minItems: 6
+
+        clock-names:
+          items:
+            - const: pl_250m
+            - const: tl_26m
+            - const: bus
+            - const: low_power
+            - const: peri_26m
+            - const: peri_mem
+
+        resets:
+          minItems: 1
+          maxItems: 2
+
+        reset-names:
+          minItems: 1
+          maxItems: 2
+
+        mediatek,pbus-csr: false
+
   - if:
       properties:
         compatible:
-- 
2.49.0


