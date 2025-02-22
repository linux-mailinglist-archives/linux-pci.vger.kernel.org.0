Return-Path: <linux-pci+bounces-22084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701D7A4078B
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 11:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CA917ACE47
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 10:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635CA2080FD;
	Sat, 22 Feb 2025 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5QP8NYF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D31B1FBE9B;
	Sat, 22 Feb 2025 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740221058; cv=none; b=lRMwWp7Ht16UZhhFde4ejtUhs1AvgoM31lkGGKTrVIZB6GLFD9cKByWiTPOyRuCnwq6/WyrIw1bz6K+yXwgr6gAZbovoryozc6AnDwvM6/7b1AlPm/vuE3FPOs5vJUfjMnEjK2ObLI4k7Ij55Z/b8AIGq/dZiuR/LSyCrwasGQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740221058; c=relaxed/simple;
	bh=1bxj/vC/QXDveDO1JYH8sC0FYLsbB1P5VxpEt6u4zPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XUb1zr0oN8OhS3wGGFgWB3pSMEcgbWsP+/ytjMk+wh9/GhorAYkPah6gPZzlJ2fSqfSt1Wk/1UTuObB1uZw4crRP41b10ay7QYUrq0CyCw/R0k9PzQWWlhr53wPtde10o6Qju4zohp/lfjYJmGg5UWS0MPlYzV9oSTK7fUa/fgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5QP8NYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DF6C4CED1;
	Sat, 22 Feb 2025 10:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740221057;
	bh=1bxj/vC/QXDveDO1JYH8sC0FYLsbB1P5VxpEt6u4zPo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p5QP8NYFIakX0saiNsA2sXR2CLO+44f61vUls0TBRjZ5wAFYtr6F/ztSg9l7h3y2X
	 +YSt+U71JsgDZ+OZAbNm4derxPT/wpDfxh6TlYKHfzmFa9n/eX5qG56JApMqBRFmky
	 1BKmflSIOuOnBdH2gZz4leohx4KsZ90rd2MAgTCRY+ZPx/SGG5nasQi47kV5jxbyhe
	 WgKwq8GEkOqVjxDhohV9bWxd+9xszKRiIEHl4kzQW4GMo7S6aAwQEwnaxoC145awui
	 3Ven1ekPNBpmIlVfAOTmrvU6PFxav7YCW3O/tLs87d0C0Ocb72LiyAwG4CIE5lqraL
	 RLdDYUsEX87/g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 22 Feb 2025 11:43:44 +0100
Subject: [PATCH v3 1/2] dt-bindings: PCI: mediatek-gen3: Add
 mediatek,pbus-csr phandle array property
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-en7581-pcie-pbus-csr-v3-1-e0cca1f4d394@kernel.org>
References: <20250222-en7581-pcie-pbus-csr-v3-0-e0cca1f4d394@kernel.org>
In-Reply-To: <20250222-en7581-pcie-pbus-csr-v3-0-e0cca1f4d394@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
X-Mailer: b4 0.14.2

Introduce the mediatek,pbus-csr property for the pbus-csr syscon node
available on EN7581 SoC. The airoha pbus-csr block provides a configuration
interface for the PBUS controller used to detect if a given address is
accessible on PCIe controller.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../devicetree/bindings/pci/mediatek-pcie-gen3.yaml     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index f05aab2b1addcac91d4685d7d94f421814822b92..162406e0691a81044406aa8f9e60605d0d917811 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -109,6 +109,17 @@ properties:
   power-domains:
     maxItems: 1
 
+  mediatek,pbus-csr:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to pbus-csr syscon
+          - description: offset of pbus-csr base address register
+          - description: offset of pbus-csr base address mask register
+    description:
+      Phandle with two arguments to the syscon node used to detect if
+      a given address is accessible on PCIe controller.
+
   '#interrupt-cells':
     const: 1
 
@@ -168,6 +179,8 @@ allOf:
           minItems: 1
           maxItems: 2
 
+        mediatek,pbus-csr: false
+
   - if:
       properties:
         compatible:
@@ -197,6 +210,8 @@ allOf:
           minItems: 1
           maxItems: 2
 
+        mediatek,pbus-csr: false
+
   - if:
       properties:
         compatible:
@@ -224,6 +239,8 @@ allOf:
           minItems: 1
           maxItems: 2
 
+        mediatek,pbus-csr: false
+
   - if:
       properties:
         compatible:

-- 
2.48.1


