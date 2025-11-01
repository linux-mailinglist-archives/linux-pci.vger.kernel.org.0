Return-Path: <linux-pci+bounces-40021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5B2C27FED
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 14:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0902A4F1945
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 13:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB1C2FD7AE;
	Sat,  1 Nov 2025 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BtFcb+yo"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18FD2FB987;
	Sat,  1 Nov 2025 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003987; cv=none; b=Qz4vcIGi7qLyMU271jo7FIHhj/ENcPJ5cJ/0vfy6jXZAX8nm97/2M6+c5e2lHgiWRb7mgFiwHbuQB9JX4JnU1gqsxrA9V7JmMplICtAd4//OjwEZiRhPPKYcD12vbGRRZslIHK04Frpf7/yUj29jhDYsd0F5lSBKSCD5uqUoqWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003987; c=relaxed/simple;
	bh=SVBGzs4HAWPDYtgEeumBTo3s6Iuq3KtldyS/whJEcpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uP45luUXtLO/QOwc/9hAyaVOFYasYRees8ryA+yGNgfEMmM7bdHs2hIOgGLTUXPKdPgn04bE8m26PGlHe16ebFnz2LybrGC7UTj1JS9UZCIm3D/pFgYZTmhUsAWLmAXnnVZphJMaRpxPAOl9zjESb+whcc69zfnrakDU/QdEQlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BtFcb+yo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762003979;
	bh=SVBGzs4HAWPDYtgEeumBTo3s6Iuq3KtldyS/whJEcpA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BtFcb+yopgqlolTHrtEfTmWlM4gpMe9LQVBCDqFSrDvhWFlgxXXm+c59II0CHyFwZ
	 0uaAq1yiXOLdHTsIiXZKFj19Bc7qQ2pfhK4c+ZBaYzF8kW+5IoC3uUeRCZDhIbde3G
	 86jEZvlI/lPDrysARC7nOjE1p2Kf4+IYbCi7/QYXYI6bwEyrTCv/JHN3N6Tj3xn9wu
	 vdT2UJiHb1jDHUKdKYkzUlks9Brk73UimvzGctrSnoL6EkN0+W2Hx626BoUCDW/coD
	 CNX1jFWDmQoBiCOXG46xw1tP61yDvQcYEzZMIAUHQU4PlZ+wBamesZq9W3wg5XEiEV
	 mmRUII0Iz6Ytg==
Received: from beast.luon.net (simons.connected.by.freedominter.net [45.83.240.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7D0CD17E1580;
	Sat,  1 Nov 2025 14:32:59 +0100 (CET)
Received: by beast.luon.net (Postfix, from userid 1000)
	id C732D10E9D040; Sat, 01 Nov 2025 14:32:58 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Sat, 01 Nov 2025 14:32:57 +0100
Subject: [PATCH v2 12/15] arm64: dts: mediatek: mt7981b: Disable wifi by
 default
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-openwrt-one-network-v2-12-2a162b9eea91@collabora.com>
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

Disable the wifi block by default as it won't function properly without
at least pin muxing.

This doesn't enable wifi on any of the existing mt7981b devices as a
required memory-region property is missing, causing the driver to fail
probing anyway.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
V2: Newly introduced patch
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index 2c9819f28fdc2..065f5a3c8b26a 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -499,6 +499,7 @@ wifi@18000000 {
 			clock-names = "mcu", "ap2conn";
 			resets = <&watchdog MT7986_TOPRGU_CONSYS_SW_RST>;
 			reset-names = "consys";
+			status = "disabled";
 		};
 	};
 

-- 
2.51.0


