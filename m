Return-Path: <linux-pci+bounces-38323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A136FBE2B82
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 12:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5804877AA
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 10:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF13B32E736;
	Thu, 16 Oct 2025 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y2kTAhnh"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0282331DDB9;
	Thu, 16 Oct 2025 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609342; cv=none; b=p1oHwl62oDxGVVoK8Zf+g8d5oqRtr5/SNRoVOxBFt/P+YWw1pias69x8Zc5P2jkDmaMMOeZdu7I+Rc7NG+qRorxLL7JB6yB501QbGhmEN4eVo93d8wP+916aUaRfSuq2dM35rZRVmUp/Q21HdDQkXCq0lPRwd9Zps3dPtru/3Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609342; c=relaxed/simple;
	bh=F9fawG1dTHERqo07t+5z+NJo3HhYUlGxKpLEWlNHroE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F6gp48OFdcAAzsPuXQ6gkvApQdQ50cD+b2iuM5BBSLRcVcV9Lus3Sunld1Q7C3q85hAp8fpIztw1HQGvwlXRU2sSk0RQxb7OB399+Z/Z7FH/Hk0dDSqIPiVqHoLHV4PRLRSdbi79iRK+17+jw3XJdD0ji1gyM+cdRtQbJ96J6Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y2kTAhnh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760609335;
	bh=F9fawG1dTHERqo07t+5z+NJo3HhYUlGxKpLEWlNHroE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y2kTAhnhKvmN3531kyO7g4tqiihggZJ0XjB42+CeCYp6NYJMrg5UYToVq0CwHnLUB
	 o6CiOwGfzzp8KTgOoqyPjEVhtm72+2izrD9KXm6xXsERvwj+S4V8maaiQ5vlT7Bhca
	 KGcnESmVaKqy+RzjFxt6LaQQlKPSKZ9c5io/drbETOSVOcKkhH2HOSwLPsqDsD4HZX
	 f2I6R/EMJWlNeQ1CEfOJWXXUTdoOlUiPB3pt8vWdM4Tahw8gj+y0D1xWbo/DP7io4C
	 80+lERU0zQp/Pj+H9XmSGiFQQamOHfjrCiONXquqhsDlrK9MzpZtor1TNd9kHVkxRa
	 K/cqafSIOhjFA==
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DD40717E1413;
	Thu, 16 Oct 2025 12:08:54 +0200 (CEST)
Received: by beast.luon.net (Postfix, from userid 1000)
	id CC83F10C9C79A; Thu, 16 Oct 2025 12:08:53 +0200 (CEST)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Thu, 16 Oct 2025 12:08:49 +0200
Subject: [PATCH 13/15] arm64: dts: mediatek: mt7981b: Add wifi memory
 region
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-openwrt-one-network-v1-13-de259719b6f2@collabora.com>
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

Add required memory region for the builtin wifi block. Disable the block
by default as it won't function properly without at least pin muxing.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index c85fa0ddf2da8..fbccb63227e89 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -69,6 +69,11 @@ secmon_reserved: secmon@43000000 {
 			no-map;
 		};
 
+		wmcpu_emi: wmcpu-reserved@47c80000 {
+			reg = <0 0x47c80000 0 0x100000>;
+			no-map;
+		};
+
 		wo_emi0: wo-emi@47d80000 {
 			reg = <0 0x47d80000 0 0x40000>;
 			no-map;
@@ -494,6 +499,8 @@ wifi: wifi@18000000 {
 			clock-names = "mcu", "ap2conn";
 			resets = <&watchdog MT7986_TOPRGU_CONSYS_SW_RST>;
 			reset-names = "consys";
+			memory-region = <&wmcpu_emi>;
+			status = "disabled";
 		};
 	};
 

-- 
2.51.0


