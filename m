Return-Path: <linux-pci+bounces-11295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7222947951
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 12:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242191C211D6
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 10:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ACF158A10;
	Mon,  5 Aug 2024 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FmPzDGpc"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7110613CFAD;
	Mon,  5 Aug 2024 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853197; cv=none; b=EYZTbttyeVGccwlhlyOS3jJsmqDeW2ahgTntYTxY2U168oIKE1PV/0EAAa/9zFbxaKioDpzEPe4iD7uEOkurc0Na5kAFSPl6Rw1a5kZhrmmtl4kYVWyYlQrxQ0m9P5Ri+8WE5OtrUdNOXoI9C9f37n7x3OBhvsoKiL/G2JgwH7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853197; c=relaxed/simple;
	bh=E2Nmsu/7HYQLnn0sN5b1S2heBsMjF3oRWqAoBIGaDBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGutXl9Fd5s+acY/hatT5kaiKaQuDa/lN8hupNNLfi0tt+dEWTOuH/qcLjyzw944nloyyFNJBoSSWplH9YogymOQntyFJmaW4zd4SQpulP6r/aIYkZzGvSDaMP8B5DCcU4MjtNwF65SDh95nYNsuDhHULvED9ujqDIubBGuaWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FmPzDGpc; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 5A9492000B;
	Mon,  5 Aug 2024 10:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722853193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bOAN8DOKAutpcJ98IdSxdr6GKYFYp22/ixh21amGeTg=;
	b=FmPzDGpc7scj8oA7ISfmM92KJIu4sVZjIWTGr6KvniUx49FP2Sb0JRQ30YAZMQLKswMTms
	SmrItLYKJg2+7amIq9bjY6RD29fRWGOtcxgccW//T7YklvExojnAahtWNtBiQeddHl9xa4
	dtwQ1+lSZByeArSMYGTk6tE/z5q4W1dB1Pku7j7U2nTvDRKQaSs/ydDZa5CzYbK7hxQp0V
	qyghmpR9AB8BxY++7cQfg6gjIVRDHmNssMDVS8Fx6gYi295jL59lDb0mIWl5+ltVwkpUMO
	QjwyKvEyYhZ5n2poV1Q9hr+yeZQV7yHFACR7EhIRIgUdjzr0BdR18det4xUAXA==
From: Herve Codina <herve.codina@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH v4 7/8] reset: core: add get_device()/put_device on rcdev
Date: Mon,  5 Aug 2024 12:17:23 +0200
Message-ID: <20240805101725.93947-8-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240805101725.93947-1-herve.codina@bootlin.com>
References: <20240805101725.93947-1-herve.codina@bootlin.com>
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


