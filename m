Return-Path: <linux-pci+bounces-16783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343359C9095
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 18:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D905B28C16
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 16:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704D618E030;
	Thu, 14 Nov 2024 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eZ30xuhY"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2B7188714;
	Thu, 14 Nov 2024 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603304; cv=none; b=uz5c3/WrZONAWPeBMfjEc/WRtkkLPT1LwD8hKViv8+yLbdYO9gumw3NKAoUJmmV+w2XxoqVYJ9fxtJm78h1obt30qAw7r/luQKwQr9F6rPPfmAMuMDsm0aBS4eCIEObZJjIGfANGvDTrOg0D3iYtEPq5ENRWWge7CNghX7utMv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603304; c=relaxed/simple;
	bh=Z2tfhuE7Txdvc7dCcFHyCx58HkE3VsQDeYlOPaFdI6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuaXr6tscet/XpHIve0m9tLQgxP42U9/e2EEZgxyI/AoKnNmrudmHhu8zUHPelk0uM0WFMAUtrxBMOHGBprpp2v4pRrOITdhE+RmEJGMBHzVSRsKknbEkESQgxLbZIl6vJ0RfwnVirvjwekiS6jyk0JMkta8rQMP1vzpZ0UVGNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eZ30xuhY; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id DC58CE000C;
	Thu, 14 Nov 2024 16:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731603295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bK5E5mCWOjNDUa0ziJGmJm0bi5qZCUbfWxCC7XPA504=;
	b=eZ30xuhYaIu8NbJqlpYvPBChUiBcEjm2rqFz5B4dmQtvuYDQ+YnySQaZZXbq8AxvRwsBuQ
	7UjxvW6gqNR5UZD7bZ305uEhnu6kMyj1N+GanVJWGApFnrbZmXRnvtBB4tT093ERoZAseu
	zO4Z93yFz2mwdeqQ84j4muQ+p/xgVnTM6cYxQ9lRWUMHVhxzONnTZqVPmtcbNzU1K1VF2n
	CPP4gUeR9HqjgIp27UjDy637eb6uI4aM1isXN+Fg/9GNxPXdfZxLm7NDVVvcwg4mJPzmtR
	gx683KOe6dftpEwpIWLbjLSzEUYSj4SOmdnH0lVsGVZst7F1DbPlFh2lKKlg1A==
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
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v3 2/6] PCI: of: Use device_{add,remove}_of_node() to attach of_node to existing device
Date: Thu, 14 Nov 2024 17:54:38 +0100
Message-ID: <20241114165446.611458-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114165446.611458-1-herve.codina@bootlin.com>
References: <20241114165446.611458-1-herve.codina@bootlin.com>
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
2.47.0


