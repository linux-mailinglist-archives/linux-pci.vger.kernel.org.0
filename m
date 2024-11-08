Return-Path: <linux-pci+bounces-16328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0083E9C1F64
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 15:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BECBB23D8F
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 14:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77131F473F;
	Fri,  8 Nov 2024 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eS3znHT6"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3035938DC8;
	Fri,  8 Nov 2024 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731076569; cv=none; b=dl31+ZhXWmDGVbQ33tIHlkDiNfKF203JOtIhaPs1urbO1oW8cSXMLCBz8v/mNNfMwYUb5EOfVmwcwS7YOEQDKsKt2UI2hPelpvrKyTRmi0HZJs0bviKc4ikCtZyeTliyjDO8KfTmuNXfa/iidLU4f1VJFjSxLEztOU9kYMERhcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731076569; c=relaxed/simple;
	bh=iC/tjyklxFXoTOf6oiIBxBquODf1xpsZRKEBUxujKqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuGD4xuev0FByaJoRvWt4EQ+NIfnzIgN1VgIFScBZMgf7CAipicrPPYFNvDwWWxEMr3FeFYJWSOiYxFEOW96ydsDpO3tN0f1fB7nrNql3Txui2R7HGgJ6UX3+33zVqBJCU5snkYse0kYYMBqwP6bLE9Ex5tUT7swtr5gYgmcHog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eS3znHT6; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id EABF12000A;
	Fri,  8 Nov 2024 14:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731076565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R60WsNzvgmPsBwX9PYv+8rZFmtBKiv6od0fGxwx0fbc=;
	b=eS3znHT6SV6YmrG5ChPGDpVal1KL4026SFCfN3KWgFZmhvApu8cKYleEZ1draEMsb2mSP7
	MnGEtVGLgsIYvOvI6VhtzE5zVljgJSBXVUGhXJNQb3ugoXuDfC7joUYzCTTXCelfG9Ig98
	OdQwHtuWNvhGF99+pPGgd8Kw8QnY5OeACsbNxzgg4nClFK8d5SeqXkbQrg/yAMU3bwYmmd
	tNfuK+/s7ez/1W73HxGxXX4dCpbEGN80VrccrrZqPwop2CtLojAIdb8kcVwPo18CItgOEo
	9j5MjYZ8U+mMw1Y2IwTESkg16HDFHsoO4S5L000VVOTJBVz87FhMzvdG6mmuBw==
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
Subject: [PATCH v2 2/6] PCI: of: Use device_{add,remove}_of_node() to attach of_node to existing device
Date: Fri,  8 Nov 2024 15:35:55 +0100
Message-ID: <20241108143600.756224-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241108143600.756224-1-herve.codina@bootlin.com>
References: <20241108143600.756224-1-herve.codina@bootlin.com>
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
2.46.2


