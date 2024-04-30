Return-Path: <linux-pci+bounces-6852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FB48B6D0F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 10:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4171C22AF4
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 08:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D5719DF4C;
	Tue, 30 Apr 2024 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CYR+iijX"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50E5127E05;
	Tue, 30 Apr 2024 08:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466366; cv=none; b=dFWounQ5MsDFIvjVs11DShuFXROJYpPxeth8rkiztYvVHOM6MX+L9A2UAuOfos0QNPqAR4eUZqkVcb3Ka8r9WnXxRJuKne+pRyVQpjkUaYPhIOoHHwOMUkmECRgZaIPaD67pKXHgOSf1V7THPl/s9lqKdoV9sfOr40enUljFytY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466366; c=relaxed/simple;
	bh=pPIRCQnCQ54gleMHzSJgynVz1ieLpAHzSMf1eRn4xpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FecCaoDY7cbPLzXErxkaG6Fcj+zLT8m8JfNhNKwNiDHt31guld1BxhJniAKrWjKyJrWwSHS06qGC9rzix6ZNgLSVlB5LOobR7ypMs4HUyaCxOMgvia7oTA1ApGwHRi6/yMGVyBy2HFPyuT20/c6S+elB482fKhsBhkDRBGVwya0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CYR+iijX; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 6C5F62000B;
	Tue, 30 Apr 2024 08:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714466362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d5YbcXC52ww526burA7UWFbg9yga41Sb6wn1P/AlvTU=;
	b=CYR+iijXYHPyEiqnx/a6T1Ywhq1GpJRb33mcIqa0sWGRBTzYskWJ37NbriQ7KbCIGg+MbC
	yr+I66X2h1KHobrrbkVVmZTiZkd2ek5UejeyML0Toq57SjSpzVk6Yq1BySS9HqKRzkcHQe
	APlDG3MgOOGKDNAV6Ohx8FBqmCvsV81Am2at7qCjOGfgFkkkywyqsnvelCRdsCFwA+hsZZ
	Sexj5w2EfPRSWqjxdME2KBfSUomSPIEQE5T7o/qnnUJSBnUJjd1WrWgkONlwUXjeQOcfEN
	ieimIcMD9QlPcxAeojY8/HqPPjEPrzeqIIuEo9oMCITGltbaKRvvgC0euMHBaw==
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
	stable@vger.kernel.org
Subject: [PATCH 08/17] net: lan966x: remove debugfs directory in probe() error path
Date: Tue, 30 Apr 2024 10:37:17 +0200
Message-ID: <20240430083730.134918-9-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430083730.134918-1-herve.codina@bootlin.com>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

A debugfs directory entry is create early during probe(). This entry is
not removed on error path leading to some "already present" issues in
case of EPROBE_DEFER.

Create this entry later in the probe() code to avoid the need to change
many 'return' in 'goto' and add the removal in the already present error
path.

Fixes: 942814840127 ("net: lan966x: Add VCAP debugFS support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 2635ef8958c8..61d88207eed4 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -1087,8 +1087,6 @@ static int lan966x_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, lan966x);
 	lan966x->dev = &pdev->dev;
 
-	lan966x->debugfs_root = debugfs_create_dir("lan966x", NULL);
-
 	if (!device_get_mac_address(&pdev->dev, mac_addr)) {
 		ether_addr_copy(lan966x->base_mac, mac_addr);
 	} else {
@@ -1179,6 +1177,8 @@ static int lan966x_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, -ENODEV,
 				     "no ethernet-ports child found\n");
 
+	lan966x->debugfs_root = debugfs_create_dir("lan966x", NULL);
+
 	/* init switch */
 	lan966x_init(lan966x);
 	lan966x_stats_init(lan966x);
@@ -1257,6 +1257,8 @@ static int lan966x_probe(struct platform_device *pdev)
 	destroy_workqueue(lan966x->stats_queue);
 	mutex_destroy(&lan966x->stats_lock);
 
+	debugfs_remove_recursive(lan966x->debugfs_root);
+
 	return err;
 }
 
-- 
2.44.0


