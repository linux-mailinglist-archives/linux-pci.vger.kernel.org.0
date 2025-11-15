Return-Path: <linux-pci+bounces-41318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8287C60B57
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 22:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 341394E492F
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 21:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327FF30C356;
	Sat, 15 Nov 2025 20:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AJKfCLLD"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC92A253939;
	Sat, 15 Nov 2025 20:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763240327; cv=none; b=NBgTgMyCZy9FuK+VPXVIzQWR9Y1l+Z4fdbjHo6yx4Wc6gqJHs/M1Jha9Vvy+z65P4VwyOZtU35kfT3V31Axt7L7FgqcpZOUpqncFPniHKaRPN0maYDDwUHwgpFKXvN8aHQHFKa4h6buDAUPKXt350UmVeUT0nh8Om2UrI6alnQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763240327; c=relaxed/simple;
	bh=hw3ZAW2zOtXRACUrBJfwNwFWR2lDq8YE4T88GaAFI9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R+SGk0ruO9+n3EGPNLdEi6jeGKkA+MlOuYZ1AG+1PN9Rnd4xsW4Wgrl//xkYITIWeZC1oz89KUjtv57zl54WV7eAaqn8aKtFQaDoGoEKOLTgYUIENOrO9spryT/Kit3zFMVlNbZYMcFyzUtBMTvVqMQ+Ll1090ojjihCXbNh4qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AJKfCLLD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763240313;
	bh=hw3ZAW2zOtXRACUrBJfwNwFWR2lDq8YE4T88GaAFI9E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AJKfCLLDEVZ2vLVs5c4AQth3HKWTJxWUAschvzx7UK7egad+wwIbwyP1CfqB9qheJ
	 ZyhUpaxUENHwiP6RELESKammjVBDat8g/h6kbAfXTsVWZqZ5VhUrZ1zhBxcLNFeJZj
	 ZRdm6VO7LpKhwNJdRtFbDq17VQNNznRUEGwPNqWKM7q2GyD04oHQ1i4XNpFJ/SLrji
	 Q0U63jm2Ka7oGMw010OayNXjsMEFItBFD9F6TTooNmZOa1F9SleM+Pq/tXp3S9tmV+
	 ps3pDTFG7xEOWoLvTkIAQnTXDaa5RItxdanzGh7Z8mDHqVJWDkxB3gtgN+6qSyjvyv
	 OmxOFYVPaqomw==
Received: from beast.luon.net (simons.connected.by.freedominter.net [45.83.240.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E8E6017E13D6;
	Sat, 15 Nov 2025 21:58:32 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id 2CCF8110527E3; Sat, 15 Nov 2025 21:58:32 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Sat, 15 Nov 2025 21:58:09 +0100
Subject: [PATCH v4 06/11] dt-bindings: net: mediatek,net: Correct bindings
 for MT7981
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251115-openwrt-one-network-v4-6-48cbda2969ac@collabora.com>
References: <20251115-openwrt-one-network-v4-0-48cbda2969ac@collabora.com>
In-Reply-To: <20251115-openwrt-one-network-v4-0-48cbda2969ac@collabora.com>
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
--
V4:
  - Move back to V2 version (widening global constraint, constraining
    per compatible)
  - Ensure all compatibles are constraint in the amount of WEDs (2 for
    everything apart from mt7981). Specifically adding constraints for
    mediatek,mt7622-eth and ralink,rt5350-eth
V2 -> V3: Only update MT7981 constraints rather then defaults
V2: Only overwrite properties that are different from the default
---
 .../devicetree/bindings/net/mediatek,net.yaml      | 26 +++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index b45f67f92e80d..cc346946291af 100644
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
@@ -249,6 +249,9 @@ allOf:
           minItems: 1
           maxItems: 1
 
+        mediatek,wed:
+          minItems: 2
+
         mediatek,wed-pcie: false
     else:
       properties:
@@ -338,12 +341,13 @@ allOf:
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
@@ -385,6 +389,9 @@ allOf:
           minItems: 2
           maxItems: 2
 
+        mediatek,wed:
+          minItems: 2
+
   - if:
       properties:
         compatible:
@@ -429,6 +436,19 @@ allOf:
             - const: xgp2
             - const: xgp3
 
+        mediatek,wed:
+          minItems: 2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ralink,rt5350-eth
+    then:
+      properties:
+        mediatek,wed:
+          minItems: 2
+
 patternProperties:
   "^mac@[0-2]$":
     type: object

-- 
2.51.0


