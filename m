Return-Path: <linux-pci+bounces-40023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED84CC27FFC
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 14:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49D734EDA8C
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 13:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67FF2FE563;
	Sat,  1 Nov 2025 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aom+jkmT"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AE82FBDE7;
	Sat,  1 Nov 2025 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003987; cv=none; b=dSkL7gkdRwTfL68VtZLiG2oVBRMu+kFm7NYaQWQsC7HzXUIcX1vFdx79inde/xqU2aT4Tz00MN3J1Go1OEJDLC4hs7//+ryRxxdDqSWf3c7opWMOuFyMrmC8M9OBTUWQQMmvK7yihs/6SKyxuyDDU3v4jldh0bCCVdLiZDkv3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003987; c=relaxed/simple;
	bh=mwUsAqDXLhSK6Bwu6bjcHXmDkab3b6jje8hKF/ZG+zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YqE/4OJvE3nuUJYnegAsVrXojVlfGAVc4wdwwttlS1n5ktxKOELQL6zAAwGCBZeQBp1qqP7+vyV/7PWUD4sNvSEnOCmnsfaM5dyCvD1626iFxsGLTcI5avi9a1d6AcOIcUwsnvDdTsQEJ8RrcNb5lagvRDtF/buhJu8X5PxX70E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aom+jkmT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762003979;
	bh=mwUsAqDXLhSK6Bwu6bjcHXmDkab3b6jje8hKF/ZG+zg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aom+jkmTgB6Zf3By+bqgUNXiJr6t5Oj545GPD4dfS4frsjZpmTO5OYdZb+1wMOtwQ
	 OZ1n5EsAAQlC5HDjcUamwUdg3PEb/sYLxV/y65RtEIojYRe57zXxmJUFC51jRWdM+/
	 Ie9lH5NSF3g0QEcrAPNNPIScjVFskrqwv2CvCUr1djqW71xqnioT5yV0WMyMT1s5dB
	 tw+asN0zosTdtxlwhWgHoIgKp8K7hDr42MxSPfAiHKx7WTJ7Q6/1gSx/XvTXwhmVIU
	 JLH/56y87I5X8XXgvIgi/gKdM3S+RH95jSnloVC7PFKXylHb4MrIx7u+r/6guP+ehu
	 w2BkDAgzvtEwA==
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A28A317E15C7;
	Sat,  1 Nov 2025 14:32:59 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id AE2A910E9D038; Sat, 01 Nov 2025 14:32:58 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Sat, 01 Nov 2025 14:32:53 +0100
Subject: [PATCH v2 08/15] dt-bindings: net: mediatek,net: Correct bindings
 for MT7981
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-openwrt-one-network-v2-8-2a162b9eea91@collabora.com>
References: <20251101-openwrt-one-network-v2-0-2a162b9eea91@collabora.com>
In-Reply-To: <20251101-openwrt-one-network-v2-0-2a162b9eea91@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Lee Jones <lee@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org, 
 linux-phy@lists.infradead.org, netdev@vger.kernel.org, 
 Daniel Golle <daniel@makrotopia.org>, Bryan Hinton <bryan@bryanhinton.com>, 
 Sjoerd Simons <sjoerd@collabora.com>
X-Mailer: b4 0.14.3

Different SoCs have different numbers of Wireless Ethernet
Dispatch (WED) units:
- MT7981: Has 1 WED unit
- MT7986: Has 2 WED units
- MT7988: Has 2 WED units

Update the binding to reflect these hardware differences. The MT7981
also uses infracfg for PHY switching, so allow that property.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
V1 -> V2: Only overwrite constraints that are different from the default
---
 Documentation/devicetree/bindings/net/mediatek,net.yaml | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index b45f67f92e80d..04224e0ff408e 100644
--- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
@@ -112,7 +112,7 @@ properties:
 
   mediatek,wed:
     $ref: /schemas/types.yaml#/definitions/phandle-array
-    minItems: 2
+    minItems: 1
     maxItems: 2
     items:
       maxItems: 1
@@ -338,12 +338,13 @@ allOf:
             - const: netsys0
             - const: netsys1
 
-        mediatek,infracfg: false
-
         mediatek,sgmiisys:
           minItems: 2
           maxItems: 2
 
+        mediatek,wed:
+          maxItems: 1
+
   - if:
       properties:
         compatible:
@@ -385,6 +386,9 @@ allOf:
           minItems: 2
           maxItems: 2
 
+        mediatek,wed:
+          minItems: 2
+
   - if:
       properties:
         compatible:
@@ -429,6 +433,9 @@ allOf:
             - const: xgp2
             - const: xgp3
 
+        mediatek,wed:
+          minItems: 2
+
 patternProperties:
   "^mac@[0-2]$":
     type: object

-- 
2.51.0


