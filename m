Return-Path: <linux-pci+bounces-40423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3D1C37F82
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 22:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA8C14E4385
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 21:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01032EC097;
	Wed,  5 Nov 2025 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ci42NPe8"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F942E11D1;
	Wed,  5 Nov 2025 21:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377522; cv=none; b=etRnvIRdBHHiJDh9PTFGl30ttwLtqNiyDqOOWjHdNj0rk6SGilDr/nC9VF8TDF1d6bDHIKosL0HNGrOIvMsp65fficeAHXTnxs+rgZ+LqnpXFkDe1txoHQWyjf/S9rp7cMKOTItyp2jsXsPP0+j9JRcrq4RXVC2QbC5gc5/Tjb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377522; c=relaxed/simple;
	bh=awDSMBDJzPPS4EnVp8+B6nVYbJz7nRdZNkEF4vHPpPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vm72+p5OY8GaICP+MsDnFWk4PbGVQBWO4dpuM2mczkqUZtSYNQtZf/It722JbhFTBLua1GR3z1gptiCNiBwr7GnmwYkIpjfcajTtj6tn5eepeeoVMXUGutOtbk4JeMlLDEK1vocc+V0snO/ZeQRudD3Bi0Rpt7szIEziN58fdXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ci42NPe8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762377516;
	bh=awDSMBDJzPPS4EnVp8+B6nVYbJz7nRdZNkEF4vHPpPs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ci42NPe8j7NJSLA1jJMH0sd/AmJryok+Vl512uKMGj5mF2Kxb3nn2pL+6hJVPtci6
	 ZZkmTVlO1SqVesFxzX+Q4zRKCSPVZeCb7E01Cdng8wUwBesuwK9m0Tn2PfSzaN4oDo
	 fKbUfb5awtUm/uQeA2LTeJgBs9vIHwaBI8zxpWSsM6pXLyiBIHKqlnnW3zA9NjO1i/
	 ZuSqud86yIDPzsXOaxa3W11u+/4aMukzxMhNeOP9SWxZTMBWKM9ln5DhMMsdFaT1m0
	 abYnXSsuUk+88l4wwcitMfj6JmgzN8RAJhIpUuBOXP3w4aG5Tl1kvPzmbFApEnf0/2
	 KMjrOAZnCGYig==
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0997B17E1465;
	Wed,  5 Nov 2025 22:18:36 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id B56D010F352E9; Wed, 05 Nov 2025 22:18:34 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Wed, 05 Nov 2025 22:18:03 +0100
Subject: [PATCH v3 08/13] dt-bindings: net: mediatek,net: Correct bindings
 for MT7981
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-openwrt-one-network-v3-8-008e2cab38d1@collabora.com>
References: <20251105-openwrt-one-network-v3-0-008e2cab38d1@collabora.com>
In-Reply-To: <20251105-openwrt-one-network-v3-0-008e2cab38d1@collabora.com>
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

Different SoCs can have different numbers of Wireless Ethernet
Dispatch (WED) units, specifically the MT7981 only has a single WED.
Furthermore the MT7981 uses infracfg for PHY switching. Adjust bindings
to match both aspects.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
V2 -> V3: Only update MT7981 constraints rather then defaults
V1 -> V2: Only overwrite constraints that are different from the default
---
 Documentation/devicetree/bindings/net/mediatek,net.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index b45f67f92e80d..c49871438efc7 100644
--- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
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

-- 
2.51.0


