Return-Path: <linux-pci+bounces-17926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6D39E95C8
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 14:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7560C28099D
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 13:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06DA226188;
	Mon,  9 Dec 2024 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fdyn6mOy"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BAC1E9B20;
	Mon,  9 Dec 2024 13:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749438; cv=none; b=iQH+HGalV1Jv7GvYH5/5qZER2HWEzn8d3uQz7ZmxpSlry0ZEzloacx2rzZFV3g2ZE2BLY2N72vE+eXlYuE0ciIipQQXIuGy8cpn0vh0MEIvZQi43B5pMBWAL0hy8nPcPF2xhftB4GbR4SEYXjJT7vVV2qRSJn+mPn8mlcwP6MFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749438; c=relaxed/simple;
	bh=4UvhhQ1Jex31RMk9g02TFZQDPBVoUdYag+WpQcTXYHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpoHZmNYOSR15M/UHElQnlmhHEj6PNJPOsHxPEYRUxSemxeg2ilgo6v/qqIY2Jc4c4CTzsTcXGel7nPWW7iJL56mDnVXwxMTkYqhqStduFAiieCkEeTL/Qlmh6+9d4TzNrgGBjrvspaphd/7w1esE1sE3VJV2ELysnbHqzVASQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fdyn6mOy; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 2FF342000D;
	Mon,  9 Dec 2024 13:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733749434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXg4BZgKA1+Ndy4F/ZpFJ4y1Qvg3Ti15BrIzt2+zxYY=;
	b=Fdyn6mOybybUkmJFzfUQMi/7/6omryhRzKYk1JqRYIvnHZfFTYK7TGRoI8rDDZW1LEmySo
	iwNuZZUxIgsmB5snqjaGu0T75fVdNVM7+X8c06D0MllgQ9TZjKCUm29HdMuse8J5pvUvOM
	0EjRHM/5GR8E90eW5nOtq+wX7GJgr2UC5Q0qlLB2fq7QJ6efRggI7yWjjSwjIa+OWmSfq5
	kC1XYoBGVHoUd0nY95KvEMjs8qTP+NdGUxZdEm8nvl6EGMBXHVCyEy/v6IYpIUMiuLXB3A
	6ddYYOooILMocP9xSS0eT+ByEwUX0o5lrSxTGH16agZ+QhaDQuoYtIjOu065uQ==
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
Subject: [PATCH v5 2/5] PCI: of: Use device_{add,remove}_of_node() to attach of_node to existing device
Date: Mon,  9 Dec 2024 14:03:34 +0100
Message-ID: <20241209130339.81354-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241209130339.81354-1-herve.codina@bootlin.com>
References: <20241209130339.81354-1-herve.codina@bootlin.com>
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
index 52f770bcc481..3cca33105b85 100644
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


