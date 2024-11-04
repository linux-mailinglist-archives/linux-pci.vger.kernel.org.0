Return-Path: <linux-pci+bounces-15983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ED99BBBB4
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 18:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05911281D0F
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 17:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE3A1CACD8;
	Mon,  4 Nov 2024 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ehKBhHGg"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEEE1B5ED0;
	Mon,  4 Nov 2024 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740814; cv=none; b=AwMJvHMnPwmwadzNq3a5EoYEBBRSkEi1ki0WcwyikHiyrDkoOmAxFeHS+cpyy+WzhhjQQ7Li+U80EuW0Z4imHYXQ9ns6mJu4WF3194oe2rXeGYJUreT1X3dNVPKzhghlDJLpNdy5moAbsa5VEQvPOU1dSMAV1n2rrpaydiDn0FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740814; c=relaxed/simple;
	bh=2bOktKmAPEkqsKGZ1qCsKyyYcjkM1ngNPOsvVPIF9n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIjQE2S8giV7WeSwESkXcdcUmpdy6xiIsxALXx2eWsj4TONbSeppWVdIMiOASXR6n/Nz3M+eFDb40ZWyROxrFETpFCM+lqnV0BDSF1QHG+/1u+JjkXhsrBOrGuiitKVnXY3iGd92jzDX/omRh/PP/Z2Eh10LnxT/lU/3wD9j1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ehKBhHGg; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 5C53D1BF20A;
	Mon,  4 Nov 2024 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730740810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TampoxF0nOUV9sc0duplKSebun+rgGbOYYjIN6TWt9s=;
	b=ehKBhHGgUKFq3vt6C4/iO/53Gx8bo3UUhFOZ/2c6SomNmHdbl+noVYLCd7pxyE6tOdznEV
	frWzFwjWP71PYG09TN56wKqEB7IPan/7r/Tas6cj2ADkkNNj8SBqnOxWVfbPNv7/gmWD3/
	8Od4JtVUutFZsEgKNPH0XOqU8quJDx3SZP75MMrzaq6n1TDy7ciG2Mbpbwv5Bljlz2Zxor
	JB/A01pUiTL8jDENVhJeQpGjXoy6Y18LbZHQTN5r+00dk9xkGJW6IOt/xJsRTdMo1ZWseM
	SwSNbK57hJMDgKNKjo2k0nc3/A0FrN7t2XYfoyGlYFwvRqr5bw4x2z5uW/CcGg==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lizhi Hou <lizhi.hou@amd.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/6] PCI: of: Use device_{add,remove}_of_node() to attach of_node to existing device
Date: Mon,  4 Nov 2024 18:19:56 +0100
Message-ID: <20241104172001.165640-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241104172001.165640-1-herve.codina@bootlin.com>
References: <20241104172001.165640-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The commit 407d1a51921e ("PCI: Create device tree node for bridge")
creates of_node for PCI devices. The newly created of_node is attached
to an existing device. This is done setting directly pdev->dev.of_node
in the code.

Even if pdev->dev.of_node cannot be previously set, this doesn't handle
the fwnode field of the struct device. Indeed, this field needs to be
set if it hasn't already been set.

device_{add,remove}_of_node() have been introduced to handle this case.

Use them instead of the direct setting.

Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/pci/of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index dacea3fc5128..141ffbb1b3e6 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -655,8 +655,8 @@ void of_pci_remove_node(struct pci_dev *pdev)
 	np = pci_device_to_OF_node(pdev);
 	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
 		return;
-	pdev->dev.of_node = NULL;
 
+	device_remove_of_node(&pdev->dev);
 	of_changeset_revert(np->data);
 	of_changeset_destroy(np->data);
 	of_node_put(np);
@@ -713,7 +713,7 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 		goto out_free_node;
 
 	np->data = cset;
-	pdev->dev.of_node = np;
+	device_add_of_node(&pdev->dev, np);
 	kfree(name);
 
 	return;
-- 
2.46.2


