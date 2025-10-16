Return-Path: <linux-pci+bounces-38313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDB0BE2AF7
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 12:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EECB8505EFF
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 10:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7C92DE704;
	Thu, 16 Oct 2025 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ERa9DvmB"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02FE32863E;
	Thu, 16 Oct 2025 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609338; cv=none; b=k83sV6eqzkiWC6c6yqnolmqlEkEzxSh/Ymw66XchxW8zsnZrcXW9jY4dNObTbdH9XPDrMJUqvszVEr24UC0N1GXBfls/9ts2iHHE0xg6KtQkUUak4gQSzv9ow53W6IEoMHZD4h5TtCoyjCAOdngGhlc/dp6wS8QMUKAD5MHq3Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609338; c=relaxed/simple;
	bh=DPOaRFuwOoLbPy5eXYRvHIT1zjRLOstWIzlStDl1Vtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tuDOtvvTX2j1n1NuNksNrH4lqTc0YnFYyTYPIUlrsvvpCb+Bv+xADMu36K9QBDxVa9MbORMcO0Fz9y0HTd9Gctu4Fd7ZsiLyLTE0wo4Tn/uuT9A4N4j3MGFjisR4Y8avhTiQEWd4jreCMZvrEIod5pyJSxbzaMwbF1/RnDtOK6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ERa9DvmB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760609334;
	bh=DPOaRFuwOoLbPy5eXYRvHIT1zjRLOstWIzlStDl1Vtc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ERa9DvmB5rzvKYvlPsAxSeYaGbRiOabDCdvgj1ncj1WLtXJfHBZAfJ+ZHTQ3PRww0
	 yHMfZHOss5K9qJ4O9THXNVdsm2S+Oal4JoAZx735VtCJ1M1kz4CikSm3YcJT1ZXkvi
	 U7k2rtzw7mg+pSjAkXL30AdDsk4oOso9/soVGIBNik/Fap97Ou2+MhVmioLlaNM1sr
	 pljrRdxgroc1HrqHC48RrmN0etZTS3NX+CjoS1G/8Sun7MdBrtgUyAW/jISLjSQ1qB
	 obH56TA1sedFHMiNmbtQSBMBgEWFjEOqEJ6oBD7zPVoPkgEVl5SQBP2h3ViecDVnkf
	 uQR0lk4sGRLeg==
Received: from beast.luon.net (simons.connected.by.freedominter.net [45.83.240.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sjoerd)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0B51117E12BA;
	Thu, 16 Oct 2025 12:08:54 +0200 (CEST)
Received: by beast.luon.net (Postfix, from userid 1000)
	id 9A80610C9C788; Thu, 16 Oct 2025 12:08:53 +0200 (CEST)
From: Sjoerd Simons <sjoerd@collabora.com>
Date: Thu, 16 Oct 2025 12:08:40 +0200
Subject: [PATCH 04/15] dt-bindings: mfd: syscon: Add mt7981-topmisc
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-openwrt-one-network-v1-4-de259719b6f2@collabora.com>
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

This hardware block amongst other things includes a multiplexer for a
high-speed Combo-Phy. This binding allows exposing the multiplexer

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


