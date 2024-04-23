Return-Path: <linux-pci+bounces-6578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2418AE9F1
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 16:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5631F229DA
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 14:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4984213C3CC;
	Tue, 23 Apr 2024 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MeezJZrF"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63A713B7AB;
	Tue, 23 Apr 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884242; cv=none; b=iVIEVTYBNpG0u2OCuF5UP9IybSgtEgHM+/QCaSXByLgCaYavH6GYZE1lldlUpF1VVsokJB73Jy8faFIYlqAJ5EQ38JJiI02YBz9KNJ8jkmxdGu4PaSML6C2IEQzcW7fPNtNvPR/9T+9NfFYpMSeljbob5VyiZYmwt8mcCgx7ie8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884242; c=relaxed/simple;
	bh=6Sg7pfkwoCdHyxPYWfO/0nEXEYlUdqzDZq+0lCLAjXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/sSr13mOT6VvBNgIKDB4BnfCyFYfqHa+6CeP84lFY3J67XgMnKYfcymrXBqJgL5gv6iMuJZsUmw/OqFIgMWQs4ZOtQUl0lsVPeZKXKwBcFeaqKiKs/XA8yztmId4frMI7xGVRJkopbHI08ynNJolyL/Pa37J5FRFdcpw/xkaZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MeezJZrF; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 045542000F;
	Tue, 23 Apr 2024 14:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713884237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJkxtHqhgZHsEW6tFHhsuGDRyY1D69IDz218tw2fS/g=;
	b=MeezJZrFFkR3jPaPfy3EAOhU/EaTtkTNzT6dlO6ziw0NB/w+j2zvYx3B6HKfGWQIA2jX3L
	kM0xRVdCv/L3FYNkwuupfif6z8wY6B5RAacA2kLL6pU4OC2AbSXmvb/CjO+xeH1H1wc/4d
	6PIc7zMMFnmQdznnU+isuuzSzlDcuNU6gC9/8p6A3zba+A7OqA0GGmNRdQDDbWbH1Xvkyc
	7WcyBvlX4RCYKkjK7x991gFa6T4+vvoyBFPSpV1dExU9at8etWLvhvDVLteQAK9Pbl25sN
	dfTL94v2X92SbClMEM3OPuTWp4Ci7MpmJhjPtz2sUWy/h1O5CG+C/fQJDM54CA==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Rob Herring <robh@kernel.org>
Cc: Max Zhen <max.zhen@amd.com>,
	Sonal Santan <sonal.santan@amd.com>,
	Stefano Stabellini <stefano.stabellini@xilinx.com>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/2] PCI: of: Attach created of_node to existing device
Date: Tue, 23 Apr 2024 16:56:59 +0200
Message-ID: <20240423145703.604489-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423145703.604489-1-herve.codina@bootlin.com>
References: <20240423145703.604489-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The commit 407d1a51921e ("PCI: Create device tree node for bridge")
creates of_node for PCI devices.

During the insertion handling of these new DT nodes done by of_platform,
new devices (struct device) are created. For each PCI devices a struct
device is already present (created and handled by the PCI core).
Having a second struct device to represent the exact same PCI device is
not correct.

On the of_node creation:
- tell the of_platform that there is no need to create a device for this
  node (OF_POPULATED flag),
- link this newly created of_node to the already present device,
- tell fwnode that the device attached to this of_node is ready using
  fwnode_dev_initialized().

On the of_node removal, revert the operations.

Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/pci/of.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 51e3dd0ea5ab..5afd2731e876 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -615,7 +615,8 @@ void of_pci_remove_node(struct pci_dev *pdev)
 	np = pci_device_to_OF_node(pdev);
 	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
 		return;
-	pdev->dev.of_node = NULL;
+
+	device_remove_of_node(&pdev->dev);
 
 	of_changeset_revert(np->data);
 	of_changeset_destroy(np->data);
@@ -668,12 +669,22 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 	if (ret)
 		goto out_free_node;
 
+	/*
+	 * This of_node will be added to an existing device.
+	 * Avoid any device creation and use the existing device
+	 */
+	of_node_set_flag(np, OF_POPULATED);
+	np->fwnode.dev = &pdev->dev;
+	fwnode_dev_initialized(&np->fwnode, true);
+
 	ret = of_changeset_apply(cset);
 	if (ret)
 		goto out_free_node;
 
 	np->data = cset;
-	pdev->dev.of_node = np;
+
+	/* Add the of_node to the existing device */
+	device_add_of_node(&pdev->dev, np);
 	kfree(name);
 
 	return;
-- 
2.44.0


