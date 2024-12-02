Return-Path: <linux-pci+bounces-17524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8159E0359
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 14:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CACDB30F3D
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 13:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935BA1FF61D;
	Mon,  2 Dec 2024 13:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BvD+mYQb"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8531FDE34;
	Mon,  2 Dec 2024 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733145355; cv=none; b=P824DTzc2KV3Hf0Lmv4ziQD7K6b10zBkIUodqE0/G6mAJKXD+y8S4eUVW7EZcSMwBsm4ApBQ0Lm4zj6RZjjxTAr+I1o268314NuYK0f2PE95Stw9CSesZbAMFxTbe7Q4D9F7EIt4kGC04meiqOMocEVI5/wG/ZvESY1zLqBOSSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733145355; c=relaxed/simple;
	bh=4UvhhQ1Jex31RMk9g02TFZQDPBVoUdYag+WpQcTXYHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omGWe+CdRzDf7T8HQXI+PlF08aT+kFU/02J8b1w1m6JWOguSSmrnLTf24njyp0yjlkOuLbcAaHBTQ9M9OVfmhKgixrKMaaEQSvsb3CPJXPm2F24E3P7KGbjTpevdZ686ZU+cOn5Yn1hBRYJL1kwvRTMRZ+V3P9WAb7UBhQL9leY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BvD+mYQb; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id D2083C000B;
	Mon,  2 Dec 2024 13:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733145346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXg4BZgKA1+Ndy4F/ZpFJ4y1Qvg3Ti15BrIzt2+zxYY=;
	b=BvD+mYQbJGtUgeZ9Sh7LgADooVVFb3212hNPChXaC2bPG8eHLzoUFWwxeAdGABYQa7ANqG
	4WO71eOYJn0m/fAMcxydV743pbGT4cb+J/G2E2gkzzy1aVGqMn8wc8r+riPRSaUWvb8TfH
	3krpRxDbTHv40XFsH2lVcnjWphzOloS/FLBXyiNMRF9F+Bc3Y2kE5zYRKaDh5lJeZcFsiB
	6k+Gb6nYNGNbTVA7degIi+6o8RCYgyEFpbVe+CRVCyNOIOxm77bUvcxwI+ZM9YXfPDuAyn
	Y+kKfN0ma8R1XyiVJUEKltwem/R4ar4SuHOA4qVYdlkIEk/6jqFZSEAblthmHA==
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
Subject: [PATCH v4 2/6] PCI: of: Use device_{add,remove}_of_node() to attach of_node to existing device
Date: Mon,  2 Dec 2024 14:15:14 +0100
Message-ID: <20241202131522.142268-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202131522.142268-1-herve.codina@bootlin.com>
References: <20241202131522.142268-1-herve.codina@bootlin.com>
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


