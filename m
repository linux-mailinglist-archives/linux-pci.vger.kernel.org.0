Return-Path: <linux-pci+bounces-40422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36461C37FE2
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 22:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0681A20CDA
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 21:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C447D2EB861;
	Wed,  5 Nov 2025 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E+0/zF+6"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5170F2E1EE5;
	Wed,  5 Nov 2025 21:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377522; cv=none; b=N/N5kTpdig3mE9S+tSsnVXzmeHrrHv9GrI/T7NPuWrp71KltOQyJOSl6e+6W4rjaWWy6gUvppW9S4P9mvtU99x3xNMiIymlTnHR+7ujESXVBFra6XtLZ0GRMWA3IFGTCvZ3NKhUEXsR3yVQ0QEHpNfdwXw5vEu4QMxxqt5xGZTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377522; c=relaxed/simple;
	bh=0HQMjZYjWvOC8AwZB4R1t/Hz5V/fyYneHN+5PdUNP20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gBMjbv3xbPWA5l11OkoGDLCy4ynqb6Tv9CdjN6Cx1/x3Hbdrt5X1l7RrwyFtNI475/7PNTu07P1MuIBCLjOr+NbjSbI8NfWatnIJj/ipFUhu8uRJp70oxavlA2uKQcurOF6iW+eUNl6naq2TcDHQRqE8jnVrNT03bY3EMq1m3Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=E+0/zF+6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762377515;
	bh=0HQMjZYjWvOC8AwZB4R1t/Hz5V/fyYneHN+5PdUNP20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E+0/zF+6oMms5hJTlxoUCNIi/DeN8KiZrnBjTBO/RUtepOeAYNieN3YDaZ8sXRCTg
	 0R4a3m6gZap6/EjIdz0PgdQPDVl9JQK5VgB55EKabHBR9y9ltShIHngSc/xm9yFlMI
	 e6ixnHLiAseOdlMdjnDpsPHOMWyTbKeOpTxoXQKNIAcKLCostve024jIAdX+WRmgu5
	 6NqNKuorQRxMCvKTbxg23/bThwa8zbmNRYlUVmCggyw/jMvLUIxcgoofcpGAaa5WNW
	 TNK9SI7WAfpfKHGvNQQrbqK72CLMqOvL0yUsGw5hcX5VNIfNcnZGSDoK7P7sGaTTge
	 EvrkabOTCXGdQ==
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D171217E141C;
	Wed,  5 Nov 2025 22:18:35 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id A705710F352E3; Wed, 05 Nov 2025 22:18:34 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Wed, 05 Nov 2025 22:18:00 +0100
Subject: [PATCH v3 05/13] dt-bindings: phy: mediatek,tphy: Add support for
 MT7981
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-openwrt-one-network-v3-5-008e2cab38d1@collabora.com>
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
 Sjoerd Simons <sjoerd@collabora.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3

Add a compatible string for Filogic 820, this chip integrates a MediaTek
generic T-PHY version 2

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
 Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
index b2218c1519391..ff5c77ef11765 100644
--- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
+++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
@@ -80,6 +80,7 @@ properties:
               - mediatek,mt2712-tphy
               - mediatek,mt6893-tphy
               - mediatek,mt7629-tphy
+              - mediatek,mt7981-tphy
               - mediatek,mt7986-tphy
               - mediatek,mt8183-tphy
               - mediatek,mt8186-tphy

-- 
2.51.0


