Return-Path: <linux-pci+bounces-31387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C232AAF7354
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 14:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F2B1C2479F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0A02E6D10;
	Thu,  3 Jul 2025 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eN9JfteX"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4949D2E54BF;
	Thu,  3 Jul 2025 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751544537; cv=none; b=CHj4+a1fxjKbKGwXImyCXdy7+IlsbtGJ5FNm5hkXXro7pLs+0dpCNNFp3/mMCg808FxlBnqu4hZES6Vke3+Kol+ChQRp3X0uW2lgfTbHvNJysxuVSo/uzTFz141M3lgDW/FwJXhHkjwqPdw2SZmtAVmMiTkonFQd8L1sBZiLT7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751544537; c=relaxed/simple;
	bh=uvtB0oCs74aMKuLBMLpHE5WJ8YVpay9CsNi1HZ/A9zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTCWjMYB+tvAipya5YSZHFeV3z9I/MGZ/LZyZt9m5kESafOYE5rxAkI/yluH/0FHnrg4rK1prV6xK45X0z0Pdnm83zM2/nwRAKrB1LCU+bw7BUt6YoSsBKbat2FloA5Qwbb8aL1zNIChAgcew/XRY/yDLuuvE8KPrXH64m0Ir2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eN9JfteX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751544533;
	bh=uvtB0oCs74aMKuLBMLpHE5WJ8YVpay9CsNi1HZ/A9zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eN9JfteXgu/5eC6zkJRCDnv2ULEfLQ0/bBafTSPJAe1If6ea4F2/KsQ9MqLsoMeZa
	 HYm5ibFfFn71bvgOYHpgp+GEVVXKTLxX09tjylM/nsiX78PxbHl1ikesWEjp0d1c/V
	 HgsAdHnOWNjPD0JKOA/hHTmXUJxTGp7OnWMQoZf8Zu/aAnUW3Bc0atHnk5Rd/qUSJO
	 IvZfstDhCfSHPKyNOGPSbfFE1GfkWNUFhM4hQTvEOY/afStGKWGnS5V9lce7if6xm+
	 L5hPAgbiIRgjpmGCt2ECXKVivDK2gyY0Q9XUqp5nme8STNaIjp7vPB/Whxxi3UDxJS
	 J4mBoYdfro2qw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8E36917E09C6;
	Thu,  3 Jul 2025 14:08:52 +0200 (CEST)
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
Subject: [PATCH v2 2/3] dt-bindings: PCI: mediatek-gen3: Add support for MT6991/MT8196
Date: Thu,  3 Jul 2025 14:08:46 +0200
Message-ID: <20250703120847.121826-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703120847.121826-1-angelogioacchino.delregno@collabora.com>
References: <20250703120847.121826-1-angelogioacchino.delregno@collabora.com>
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
index 162406e0691a..fe3b17b92597 100644
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
+          maxItems: 2
+
+        reset-names:
+          items:
+            - const: phy
+            - const: mac
+
+        mediatek,pbus-csr: false
+
   - if:
       properties:
         compatible:
-- 
2.49.0


