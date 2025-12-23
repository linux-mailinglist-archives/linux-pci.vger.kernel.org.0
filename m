Return-Path: <linux-pci+bounces-43580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 19866CD94CB
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 13:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3E6530136D8
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 12:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6435632BF58;
	Tue, 23 Dec 2025 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bOBRjp/h"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E38120C463;
	Tue, 23 Dec 2025 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766493492; cv=none; b=uO4FRCfe/w+OiMyBN0UaXRXQ0UnJmBkOCK9mNCsyrQ303a2nyTGhAcnqYwQHtf8ExA6xBUX8EEAPin0oU+CQw6PVPPvBfJLidnzasd3e0lW8JPmyDS4K428EYaM+H1LtaFcGWPVH3d2N3pi4BVSuJwaTtIPBQdu4tc8qkuL0+P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766493492; c=relaxed/simple;
	bh=8ESEsnepmvIsrNiJemaCHN55aMm5jVjRlxSrBa/W01M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pzt0FwioBHM5ZaIqXlLh31lNZnn1SBhA5YJVifcY+Km+JHHnLnT25K5156qInUqeQ+MGdhkIDzwtYibqt0FlDs4akuo2GitPPcdL8ckBY4D/rXjSNnE3+CJbTLKPeWcmtD7BIbIHcEZUiRidCtObE4KPSiKN2rptNSx/q4ORd3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bOBRjp/h; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1766493488;
	bh=8ESEsnepmvIsrNiJemaCHN55aMm5jVjRlxSrBa/W01M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bOBRjp/hKjObyv5QRP7IBWrNamRzrec+zigb+6fkT1mzUoiHscxC1h/nKJiRxDTXQ
	 B5yVHBczwgDoKihJvuipNTDxWpRHAbz2Dszn3228HJikaQ3qz0TsQM+BlWXOzsROSQ
	 GC781rmRtmuqk1+P7yOk7fh7lk0LD7R2YQmrzbghP98vPI1ugutE88gmH8lVi0athf
	 TyoKnw5+DL1EDqx/AJwu03KepJEvQYJyT54PLj+RIlGs/krtjUzEgUyGlpVj5bhw0x
	 RoTnISBKGJ0jzvOg+j3cx+Yq9wR1ZRYjdrtrDY1S5AFy6UdzGLwEMSdayY/uJjGNK4
	 4ezy5dWH2PEmw==
Received: from beast.luon.net (simons.connected.by.freedominter.net [45.83.240.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 99C5B17E1330;
	Tue, 23 Dec 2025 13:38:08 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id 47720117A066F; Tue, 23 Dec 2025 13:38:08 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Tue, 23 Dec 2025 13:37:51 +0100
Subject: [PATCH v5 1/8] dt-bindings: PCI: mediatek-gen3: Add MT7981 PCIe
 compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-openwrt-one-network-v5-1-7d1864ea3ad5@collabora.com>
References: <20251223-openwrt-one-network-v5-0-7d1864ea3ad5@collabora.com>
In-Reply-To: <20251223-openwrt-one-network-v5-0-7d1864ea3ad5@collabora.com>
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

Add compatible string for MediaTek MT7981 PCIe Gen3 controller.
The MT7981 PCIe controller is compatible with the MT8192 PCIe
controller.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
V1 -> V2: Improve commit subject
---
 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index 0278845701ce..4db700fc36ba 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -48,6 +48,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - mediatek,mt7981-pcie
               - mediatek,mt7986-pcie
               - mediatek,mt8188-pcie
               - mediatek,mt8195-pcie

-- 
2.51.0


