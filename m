Return-Path: <linux-pci+bounces-6848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3368B6CFD
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 10:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6022CB2213A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 08:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E79129E7A;
	Tue, 30 Apr 2024 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G0pcULHd"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72B31292D2;
	Tue, 30 Apr 2024 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466358; cv=none; b=FJBdOEmMznjozunfjuih9Z+NgF3D/gKsrG9W/hlqXawiyAK7rEv0ms2VcrPUSgYC7UttFzEfHbYcsUmtnq7ctxqygQGjWKtCCErCTPkZYbtIetPFnX2mk29s/L3QjDpbMmcu2TSlSYjS2Ch2kE5XVLHFtHohRIUwbmMJE7WZvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466358; c=relaxed/simple;
	bh=9JD6NWoGfDEIQIduEDC370roBJXlkhonyzBg+qc2pFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/yo+jd2Wm9aiwf7voo0OTFOd29VOhVFo8F6mVqvDnRNJZ8q7mdUzKJLEjIFn0EdJCEfvBq9CaDQfnuz3Gpd/EVNHBLynl9AZi0PfahENQ8FI+qIHKxvwjbJjsw4Ub5yKzRZvw8s5zDmNNBAUB5WlXD3AAW7n0yaGfG9RuZ3N2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G0pcULHd; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 8BF0520009;
	Tue, 30 Apr 2024 08:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714466355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yQCmnd7DbFj5IxQKgje4KI56L2MhsXyiKeIjOIac594=;
	b=G0pcULHd1GS1Kd5ctB8CoCy+juU+WQe4NOXWHKIOPlA2HcBeyndoLZIcNdhk8IoE+wmxrZ
	K5JEQNoVQ79/u4K3yo5AC4dhHiAFBXGI8XE7CuuDRbreLi0cRvvzKw139Wlop5I9ZHQoai
	IjzEl8+uLGxlICtjb7W/hE805uKRG06Yk1eAM5KlzyC2YPCQG+l9jlzJZSluNa1cnct8V9
	dGC0g+TmB1NyK10tEF2z7rocBsP1li2NHUmygMEw2gFs4C6YDiQQowZjOnJ6pkHSHZJ6FU
	9JIzdYkyNFMMzz/uVxv9lHEYiFqLbfaBYUCr3MkuW7OTUHmPOH4Uz8q8QrIbKg==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH 04/17] reset: core: add get_device()/put_device on rcdev
Date: Tue, 30 Apr 2024 10:37:13 +0200
Message-ID: <20240430083730.134918-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430083730.134918-1-herve.codina@bootlin.com>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

From: Clément Léger <clement.leger@bootlin.com>

Since the rcdev structure is allocated by the reset controller drivers
themselves, they need to exists as long as there is a consumer. A call to
module_get() is already existing but that does not work when using
device-tree overlays. In order to guarantee that the underlying reset
controller device does not vanish while using it, add a get_device() call
when retrieving a reset control from a reset controller device and a
put_device() when releasing that control.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/reset/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index dba74e857be6..999c3c41cf21 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -812,6 +812,7 @@ __reset_control_get_internal(struct reset_controller_dev *rcdev,
 	kref_init(&rstc->refcnt);
 	rstc->acquired = acquired;
 	rstc->shared = shared;
+	get_device(rcdev->dev);
 
 	return rstc;
 }
@@ -826,6 +827,7 @@ static void __reset_control_release(struct kref *kref)
 	module_put(rstc->rcdev->owner);
 
 	list_del(&rstc->list);
+	put_device(rstc->rcdev->dev);
 	kfree(rstc);
 }
 
-- 
2.44.0


