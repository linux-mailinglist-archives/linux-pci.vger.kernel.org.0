Return-Path: <linux-pci+bounces-9363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A956591A264
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 11:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6C81C21CC7
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 09:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA09213D62E;
	Thu, 27 Jun 2024 09:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BLFoZXTU"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0D813B780;
	Thu, 27 Jun 2024 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479541; cv=none; b=F50SHkxwiFYNCHXPiklLLRQ8n0twF7JaS0tQw8rTmvod/861NWWDlxWa5KOzP+VHOcsj9qb/7hwxuK0KeyupestQZY0tBMp+wPLWx6EJDNiLK/iYaPHwN6EPIxJAQAZeVl839J0PQJtLMvoIeWEPpG8TKl0w8g5xzDOuNG9onx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479541; c=relaxed/simple;
	bh=E2Nmsu/7HYQLnn0sN5b1S2heBsMjF3oRWqAoBIGaDBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VA97XT3/2zMcCEQ/oG8xTnHmHVS7zNEWH507/Xry5AfaR4N/VqxjwhvPnrNGz/YBfMICKomiOi0088oQiaBhCMPkvyfzb1PIrAAH2GYdy+I43NwEQvos4QSh5IUjVKzCuZsOYO8Fz4JturmU5Nn+Iem530Jx7/KG+UGwO5WJhgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BLFoZXTU; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 8F62B20005;
	Thu, 27 Jun 2024 09:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719479538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bOAN8DOKAutpcJ98IdSxdr6GKYFYp22/ixh21amGeTg=;
	b=BLFoZXTUyOahcb22V3K5FvkqRw9RWqaUUM+SECzMK0lB6eCEOiT4uNzzDgA2xwMjwrYCM/
	y0fZyBJz6gHkEzOnnpAcpN3dBYwcRdYmEbkBks85SaJLq1ncqugOfHIraS4FD1FcZt7z3z
	7BXpS8PeWyiWnFfbQDspOtLfOVIDR5mDZylVVvv9zHgywwy9sh7UP+aHrSggC6YIYwqa2R
	7hhY4yY3VlY5u8VHn75u9Vw9eR1x5fdM+jSAmmpP8ovdIQL4rDJr6aZwvDW5AUOlPI7avz
	mumzb8X+JJ2mykvehqYTKw/6JZ9NBUvDJG87BChGeV4pDrn6WtV6ApdwI74ikQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	UNGLinuxDriver@microchip.com,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH v3 4/7] reset: core: add get_device()/put_device on rcdev
Date: Thu, 27 Jun 2024 11:11:33 +0200
Message-ID: <20240627091137.370572-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240627091137.370572-1-herve.codina@bootlin.com>
References: <20240627091137.370572-1-herve.codina@bootlin.com>
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


