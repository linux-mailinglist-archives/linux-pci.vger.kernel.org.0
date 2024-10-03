Return-Path: <linux-pci+bounces-13755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E3A98EB59
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 10:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1F81C21218
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 08:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8C214431B;
	Thu,  3 Oct 2024 08:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dx/xIpdN"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B81E13D50A;
	Thu,  3 Oct 2024 08:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943483; cv=none; b=mLvt2SLuN0WymCGIhLJT+mJAwqmwQpOU/nyxTiB9BHUuJ2MSpmkgzlkIel4D2PwdPdSgMRogrmOwQHzyxIC8orWCa0f1dqFHMAtFDgByW5OWhkSNnqjmGncrhfTy7EYYwOtl+mKlv7JRMzJ2QdxKY3sqxC+sDsCwtz5bnQLkuMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943483; c=relaxed/simple;
	bh=J7PXTMmrD7PRnvfIKE5iU8BxLJ28M5H2FXAGE8SzaOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3KBg5BlGiFunWrNOHpNILGt5vafgDatpxvjxZiiUr48ZPc2wva8DYi1EgGXZlOzxV7AFvnQQq2RQRs8/4RVkEcumykOmsu6Vt8emLsk/HIVe9PMqASHfV46EOnRwbFHY5DawWgrYi5hCH2PXVp/az4KuXkRNqu7mS0zQYCJiRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dx/xIpdN; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id A65E0E0005;
	Thu,  3 Oct 2024 08:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727943479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ecYTblGNB4SAWjXRGVXCM0U29fxnWCzO4ZD+D2D6aw=;
	b=dx/xIpdNgmSbpLZTZDRJJmgr0pWUJnLCXNCKYwKs0I9d53UHgAUdAGNOFwn5ln1gPd1hdn
	HuEcl82d6VsiiN0SXytPwXq3DeWbxvQJ6wLxLd/HYo8lVvWCsJtCvXo6ArDZXXoApVDGpF
	uWiBUz+SFoP4txQ/sbc9kqJLWhYugiujc7j7XRGNrNdTW2nM3a+PA4zguudqdBCxHUgxPV
	5c7hIdN+jph4oAoR5feyDvOCAq3ILMy1SAT7KsvniyPVFjDZgHKQ6yp9Xg0DyT9Jkr9mPR
	1mu4v13QeiAgKkSU3cXQ4okCDaQjs9W3+p7K41uwNhpdQwp6ATwoW9+QE1fZdQ==
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
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v7 2/6] MAINTAINERS: Add the Microchip LAN966x PCI driver entry
Date: Thu,  3 Oct 2024 10:16:39 +0200
Message-ID: <20241003081647.642468-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241003081647.642468-1-herve.codina@bootlin.com>
References: <20241003081647.642468-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

After contributing the driver, add myself as the maintainer for the
Microchip LAN966x PCI driver.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c27f3190737f..79125b6f7814 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15184,6 +15184,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
 F:	drivers/irqchip/irq-lan966x-oic.c
 
+MICROCHIP LAN966X PCI DRIVER
+M:	Herve Codina <herve.codina@bootlin.com>
+S:	Maintained
+F:	drivers/misc/lan966x_pci.c
+F:	drivers/misc/lan966x_pci.dtso
+
 MICROCHIP LCDFB DRIVER
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 L:	linux-fbdev@vger.kernel.org
-- 
2.46.1


