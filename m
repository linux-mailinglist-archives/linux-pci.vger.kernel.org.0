Return-Path: <linux-pci+bounces-20640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E57AA24FD1
	for <lists+linux-pci@lfdr.de>; Sun,  2 Feb 2025 20:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4F6162C09
	for <lists+linux-pci@lfdr.de>; Sun,  2 Feb 2025 19:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C3C1FECAB;
	Sun,  2 Feb 2025 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoQEosl+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF748F6C;
	Sun,  2 Feb 2025 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738524892; cv=none; b=E3zklR1WmSd7j3FgArooJCY6bJL4BCPJ0IvWjzeiOZEbdILVcS+a3R9j6P8rn2iu+Cdp0WYiYniagEerF9FYQUK/mrpBVDLa72ATcE4+hKUkAlCIa4b2lYztmCGWRLVOrV7rArYVm7jEimTzx08asPRK+m+Uc6rX92YG6NsuuOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738524892; c=relaxed/simple;
	bh=MvBbBz0UZOoSGohxLQSCxzUNlNMms+bHXssaD7TA7kM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qc33qrDPnqyzrZWyaE29FGYVHeIn2mb1vR4x+pm/MERjtrvc+nLA2uTJPaLzjuRn9WMsUnjjogogUIJISnYJDKqSeb+VLpz1s90lx7LhROasAe5tZ1+PK8XVBpP8lfirVQheLuWGCf/TumvSmIdknzKYl8d/nWHYHoSXOGtDHzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoQEosl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BD8C4CED1;
	Sun,  2 Feb 2025 19:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738524891;
	bh=MvBbBz0UZOoSGohxLQSCxzUNlNMms+bHXssaD7TA7kM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WoQEosl+kDVcBNcdo7cvQYIgXbTT5tTmnDqMV9AMJ6djArwFsEsHCXEKfVJQMHZ6L
	 yrE4ceg/FnZd1XyLpM7030LJI/7+cEe2ZJuGPznhVaivGi2CD8723aVX+NfWTfkptq
	 8fzGuCWhx7oSbxKo7Tl6THLJa31crMZjKZNMKEtNsITK2WJ/7IGBK7C999UL91DUOE
	 BBzDyAhSe6eg2yinOLYbTG96Ut4jUChFEoRKjFzcC8KH/W5kXPssGwdZ1JHhbk1ZHZ
	 3tTfmbJSw22qW2dfyM6J+Z9pxX91Xza9OQTSFtIxv10Hz9ShQctfXXroKVdc/Qv6bq
	 FcgDBdNPSSaNA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 02 Feb 2025 20:34:23 +0100
Subject: [PATCH v2 1/2] dt-bindings: PCI: mediatek-gen3: Add
 mediatek,pbus-csr phandle property
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250202-en7581-pcie-pbus-csr-v2-1-65dcb201c9a9@kernel.org>
References: <20250202-en7581-pcie-pbus-csr-v2-0-65dcb201c9a9@kernel.org>
In-Reply-To: <20250202-en7581-pcie-pbus-csr-v2-0-65dcb201c9a9@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce the mediatek,pbus-csr property for the pbus-csr syscon node
available on EN7581 SoC. The airoha pbus-csr block provides a configuration
interface for the PBUS controller used to detect if a given address is on
PCIE0, PCIE1 or PCIE2.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../devicetree/bindings/pci/mediatek-pcie-gen3.yaml          | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index f05aab2b1addcac91d4685d7d94f421814822b92..02f2cd9bcf007c1f16b18b1330a88ce43807a9be 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -109,6 +109,12 @@ properties:
   power-domains:
     maxItems: 1
 
+  mediatek,pbus-csr:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon node used to detect if a given address is on
+      the PCIe ports.
+
   '#interrupt-cells':
     const: 1
 
@@ -168,6 +174,8 @@ allOf:
           minItems: 1
           maxItems: 2
 
+        mediatek,pbus-csr: false
+
   - if:
       properties:
         compatible:
@@ -197,6 +205,8 @@ allOf:
           minItems: 1
           maxItems: 2
 
+        mediatek,pbus-csr: false
+
   - if:
       properties:
         compatible:
@@ -224,6 +234,8 @@ allOf:
           minItems: 1
           maxItems: 2
 
+        mediatek,pbus-csr: false
+
   - if:
       properties:
         compatible:

-- 
2.48.1


