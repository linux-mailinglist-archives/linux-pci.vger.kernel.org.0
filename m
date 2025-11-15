Return-Path: <linux-pci+bounces-41311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B2EC60B02
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 21:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 1B0EA20897
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 20:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C1F23C8C7;
	Sat, 15 Nov 2025 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="d6IFiUNq"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223F023372C;
	Sat, 15 Nov 2025 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763240323; cv=none; b=Nu+V4xvd1zY4Ac2NwcIcmnGlIYtqcFpay4dG0uKzTXg/PX44fzQclgl9DQQwxc/jS7Cy7ePBeJeaNkGh3kDtXgx0Nnx+tKAxk2TC2xBdWUPVLYJWPvld2qxGkNoETTHoFpzaENA8KfxXdyRebMzh2mQ35hN/g4rOKny1Bj7d9Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763240323; c=relaxed/simple;
	bh=BNloXSmxfui+A+UD0vb6639VkVLh4h7qFS1iqqJUbUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u2NYQd13BhbfoGVBGtpemAQgiDOwX1JGhjrrty7IE6K2E0YZBsSjKF9+JpD/pXXbqYVf4cVKxnK4Er6beuMxOW0QE3Bu3Ncr4yZoEPETIR7RIshXYufOeTvINmTnD0jtKgIXONU44f4xpUxyWg1aonkF+9/8YKsko5cWaYBSbYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=d6IFiUNq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763240312;
	bh=BNloXSmxfui+A+UD0vb6639VkVLh4h7qFS1iqqJUbUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d6IFiUNqQD+93pkq4ov86+rPsBtqWuNo+o78OoQQeHDVPP6RnQvqLT0il8ol+tsgU
	 YMhKX0Dz+TVcC3EtyHF7Ck6JT2/94g3FzZeYYCK8zWmMpsh5DSSZjwm9ME60o3QjoV
	 aOlfgrFV808O7OmvfGCGPaouspC95qn7GlhLeK8hX25M45q2CTlbc8uP12FRDKPVwK
	 LBDVWjUfhgIZz3+HIzzg0OF6DEGWUKypIn05PzcPlXgp4iu/wxaIF0yTtyjJD/dJgg
	 u/IO3GbZ5fekm38/cTda66Kaxq1x5qkpojvKA3nkAb/chsHnprCZNbOK1OnknsJ9O0
	 ypAexouToZ05Q==
Received: from beast.luon.net (simons.connected.by.freedominter.net [45.83.240.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6FCE517E00B0;
	Sat, 15 Nov 2025 21:58:32 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id 11F6A110527D9; Sat, 15 Nov 2025 21:58:32 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Sat, 15 Nov 2025 21:58:04 +0100
Subject: [PATCH v4 01/11] dt-bindings: mfd: syscon: Add mt7981-topmisc
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251115-openwrt-one-network-v4-1-48cbda2969ac@collabora.com>
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
 Sjoerd Simons <sjoerd@collabora.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3

This hardware block amongst other things includes a multiplexer for a
high-speed Combo-Phy. This binding allows exposing the multiplexer

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 657c38175fba2..51511078c4c3b 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -193,6 +193,7 @@ properties:
           - mediatek,mt2701-pctl-a-syscfg
           - mediatek,mt2712-pctl-a-syscfg
           - mediatek,mt6397-pctl-pmic-syscfg
+          - mediatek,mt7981-topmisc
           - mediatek,mt7988-topmisc
           - mediatek,mt8135-pctl-a-syscfg
           - mediatek,mt8135-pctl-b-syscfg

-- 
2.51.0


