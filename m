Return-Path: <linux-pci+bounces-38328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9E3BE2B23
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 12:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD75119C1522
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 10:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C683334372;
	Thu, 16 Oct 2025 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RG/uzljE"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01C232ED45;
	Thu, 16 Oct 2025 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609346; cv=none; b=mSqMtirSAIPcmYM4lAddTpsmCqIhgdIA38AOXu9nO7rFKd5t09sJyG3N1V9UlCVKtjbySb3PTTwuF2zveKux/GgguWB2YAaNocHDH/e/anSvaPy3f5odKS+0z6NA7QkW442V8lznVfbzy01w0oMY5l7tdY0/TUJL+uQ21k0Q7mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609346; c=relaxed/simple;
	bh=BEI3WpfnV3DAkVHimDT1eTbeDPtH/m3RFZodb7kY6GE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=milggP9EFidM0U0rlGPK7E/nCmfUxlbDNoCU0Pd73jqwfJMDhutQzy13n479/UzD2R4Cqw1MU8wgSrAXKzp/Mw1EquP7a2JwcmtDJCEHLtUBGtdfHeOPKSVLWOpSIhYzWAFLk9NrbjZpYDMlv/EmmKFCod9YqrvrBf+HoQVV6zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RG/uzljE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760609335;
	bh=BEI3WpfnV3DAkVHimDT1eTbeDPtH/m3RFZodb7kY6GE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RG/uzljEhnsovHfCnnmMPnrK+pJoTTc9sB78CLw2Vj9lG57oHc7ALzqY+ktq056uN
	 VOlsSzgEjMzGiGA+wk1YjxxZu5+Hv/opM5ZFiPm4ZTbdmDPPIhIAx7EQBiT692b3sk
	 XF1MceFhO/I0CZIbriX8Myg7N4+ivQaTFzOgFUL/5doMrk7bP9kqf8AYfv3qISOkea
	 QA6aBcTay1fhDJCx1GP9Nf0bloPaiEc2C1p1wkN7dt/F6pecVs1pggxSQvHlXjCqvY
	 QZy5zkb23m11x/27NX865Ay+VIEx839Pzdm8OXvY9go3Clv6orpFqkC3lRqFHTnxLc
	 dqkaLzHP3QF/w==
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 893B417E156C;
	Thu, 16 Oct 2025 12:08:55 +0200 (CEST)
Received: by beast.luon.net (Postfix, from userid 1000)
	id B432E10C9C792; Thu, 16 Oct 2025 12:08:53 +0200 (CEST)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Thu, 16 Oct 2025 12:08:45 +0200
Subject: [PATCH 09/15] dt-bindings: net: mediatek,net: Correct bindings for
 MT7981
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-openwrt-one-network-v1-9-de259719b6f2@collabora.com>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
In-Reply-To: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
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
 Documentation/devicetree/bindings/net/mediatek,net.yaml | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index b45f67f92e80d..453e6bb34094a 100644
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
@@ -338,12 +338,14 @@ allOf:
             - const: netsys0
             - const: netsys1
 
-        mediatek,infracfg: false
-
         mediatek,sgmiisys:
           minItems: 2
           maxItems: 2
 
+        mediatek,wed:
+          minItems: 1
+          maxItems: 1
+
   - if:
       properties:
         compatible:
@@ -385,6 +387,10 @@ allOf:
           minItems: 2
           maxItems: 2
 
+        mediatek,wed:
+          minItems: 2
+          maxItems: 2
+
   - if:
       properties:
         compatible:
@@ -429,6 +435,10 @@ allOf:
             - const: xgp2
             - const: xgp3
 
+        mediatek,wed:
+          minItems: 2
+          maxItems: 2
+
 patternProperties:
   "^mac@[0-2]$":
     type: object

-- 
2.51.0


