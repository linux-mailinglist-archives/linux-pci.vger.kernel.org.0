Return-Path: <linux-pci+bounces-38318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B12ECBE2AD5
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 12:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5DFAD35032F
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 10:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1780831D371;
	Thu, 16 Oct 2025 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RCXNy/0w"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A370931E0EB;
	Thu, 16 Oct 2025 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609341; cv=none; b=C5/7RA1Hf5CSS1Etcv4nhqGVe55xA240Y8st1z1bo7EQEI/C3thkVDJ7AZ0FDkbMLQZ4UX1ldHlsAQZnLpUCtxApXTq2E9tvbyczCG2J+GGaeMIiJN4mIKz6fWT1z8WMaWXoDouWYcjdreftrbzqwgXqrRuNHtZJvMERRyJpS74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609341; c=relaxed/simple;
	bh=fdxmZQ5MI5GMoR8RTL5DZwAyvuuQQsmqyeZPFXoqolI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vAw7jWnUWdR7eG1EQGiV+l7l/IbTd+OaajnqAd2ldGeIuVubq0tWUfUiH8KbRKrw6kHldk8jlg9oYS/ExMLhX2+RnzlBWm0egrspLPpc1JhGc4696BePmPZPs+uLLJuzDZ/LfY4SlOxjOyEkSXHHBqpL4TURwdxHfLzNijsc6NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RCXNy/0w; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760609334;
	bh=fdxmZQ5MI5GMoR8RTL5DZwAyvuuQQsmqyeZPFXoqolI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RCXNy/0wVz1pH2LscGhHZaZ1gzhs8j+fi1TM0B05xccoohp0oc/I3/j9fpApF7im3
	 2KS2BHo47QT9NuPx+3PtdVaQxK3oMSo7eMp6IaLxO+x001dRT78e1vO+ppEOHBnbfJ
	 qn5WQwFgA0A2Uhi6UPvRVZvEksmBGerdOQUOSEfyNXA45kxSfc1am/f0xfJV0A6Udm
	 DZHpbRzvjQFzOcJrF7OMskaC/U5uDjSj0Ck65stpiYWQwBQCJjGU0Eg6gVrS5xomu7
	 qvjmVKtkPXHTm3AqwRviTzQYerTHc6hpo1w0VvARMccIismlcLvxQhAfyWIp33yi1V
	 1Qg4Zo8wdrrTw==
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7B5D217E1400;
	Thu, 16 Oct 2025 12:08:54 +0200 (CEST)
Received: by beast.luon.net (Postfix, from userid 1000)
	id A530310C9C78C; Thu, 16 Oct 2025 12:08:53 +0200 (CEST)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Thu, 16 Oct 2025 12:08:42 +0200
Subject: [PATCH 06/15] dt-bindings: phy: mediatek,tphy: Add support for
 MT7981
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-openwrt-one-network-v1-6-de259719b6f2@collabora.com>
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

Add a compatible string for Filogic 820, this chip integrates a MediaTek
generic T-PHY version 2

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


