Return-Path: <linux-pci+bounces-7865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9068D083C
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 18:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21AECB336E1
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 16:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E0A168C0C;
	Mon, 27 May 2024 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EengVC3r"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1C6167291;
	Mon, 27 May 2024 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826510; cv=none; b=JaaW2OZ4OBAp4r2Z4CiWBz8oUIZcPLk23iBp2vLI/qygpxwxZm/yS4/Q18tcRRqZoqGYk70pMGq7KpRDEiNx4eNdfMamA5vpCKRqL5VQIM72ce9QCvDQxufHY2Irmp8yLK8t27chc4Hl8hyF3ZT9ZwzFBC/WJ0Ea+2LW0NCxBAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826510; c=relaxed/simple;
	bh=E2Nmsu/7HYQLnn0sN5b1S2heBsMjF3oRWqAoBIGaDBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XV8ZAf7CZVIDpobj8Ji6/XJ6Ov3FQV1zEzO346gEmDuNBMaYH7XGE0DqREUfqr3INap07sGs5ny1nRAenGadXYV/aT86NqnILY/AOFNSnYg1w9rIa4SIb4mOxnLm3ZDlnH/+G8XKR/e00NHyyZpE9SOEoJPVHRgiuWuYTIzPf5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EengVC3r; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id E54D5FF810;
	Mon, 27 May 2024 16:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716826505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bOAN8DOKAutpcJ98IdSxdr6GKYFYp22/ixh21amGeTg=;
	b=EengVC3rkV2AdgX2gUMxvuPJrkjrG9Id9BGc2TzsDfOh9F9xdVgWDv7UaVJztjDqCVoZTa
	KlGs1D+C8gveTFGS1Dn7nYjiR+WS+GlxfpSazJxn8Uy8QgbcACVwbZ7xDBymiBlFk6UG4D
	4jjuKtCigVm/JuJ9mSlrx9euQ5TyAXK93RvGrUwa4FbvBahFUGbIt1id8TecYs9kKirod2
	dSfgpdAzePZG8UOgAxH3RLpxWOvMoQcu8ttprKDI23osJb8s2z4xkvl+lAcdgAithHghe0
	1JUCFiZgfvMp6eRZDamI9S69eDFVHXSWRBsij5GN7su9cWMuhV55MN+VSg0sRA==
From: Herve Codina <herve.codina@bootlin.com>
To: Simon Horman <horms@kernel.org>,
	Sai Krishna Gajula <saikrishnag@marvell.com>,
	Herve Codina <herve.codina@bootlin.com>,
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
Subject: [PATCH v2 04/19] reset: core: add get_device()/put_device on rcdev
Date: Mon, 27 May 2024 18:14:31 +0200
Message-ID: <20240527161450.326615-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240527161450.326615-1-herve.codina@bootlin.com>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
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
2.45.0


