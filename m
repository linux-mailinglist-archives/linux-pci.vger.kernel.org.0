Return-Path: <linux-pci+bounces-19616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA95AA08A0C
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 09:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9CE169757
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 08:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7FE207E16;
	Fri, 10 Jan 2025 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PVj9gx4J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984E4207E07;
	Fri, 10 Jan 2025 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736497611; cv=none; b=ajXJ9Gf+hW3TD4aFYhmhs7LeDcY7LJ9JV2Qzw8RqYybhLlmQFkIre56Y9V5HyGfj++yILc3Cd0bBsil+bnLQGc9xJypn6cNzXpBKYtvmUlAB8GXrxw1yBm6Emu74mi5beSQ2rJ59ypNLDYx+kv/nydo2M1s8fF7mX/vZLB9vajc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736497611; c=relaxed/simple;
	bh=hvN6WMFdEMTej8FUIz+FisYVwp6XWKotOXXluIZYQ1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcV6p10E+ikEVxf1HuWfAcaHuO/1UpPdc3Y6PV7Ei8EhydwV6CsJra1YL8p5v378KtXJKszMNVpvkKK1TV2StdR6OdNXoqj23kNOV9LRXHCyNY+bWWtr9qWEZYy3oQqnspa1/CyX3jRFJdnuipn0fQ2v3K54KtYNg6bM6GazQR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PVj9gx4J; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay7-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::227])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 44DFBC47FB;
	Fri, 10 Jan 2025 08:21:58 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPA id 8511E20004;
	Fri, 10 Jan 2025 08:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736497316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gGktN26Hugtn1FgaDpGqq+iIoze2rydGcl15ctXuo0=;
	b=PVj9gx4JRMmzegDcF5CuMSzqnSWs1R0c+U3BDSvbwsI8tlk7wnOKMmi1ma4+rjufN/20VG
	bLh2OjSMLHjc9lE9WRYh063LlCGHhuOrxurrmUoI3IJxcGHENI3r2JQT1r4f0qGC0UUgYM
	8pdHLYfIHcHuJBOb1KpxrKEUGxtNM9+eJMV7KfGr0bPCAEq5lHxn+q4vyqrbsYDKJdTlAn
	3yQCbEickbXrA9Utrz1kEf/Gd/VxIPQCbMq30MouXxvn8e6uCWtRYwlKWV9rBdXH+yyq1Q
	/uemdRCOUrf6P6y8xxvMJmbipUFQCPxueOFUXL5l+fbLGmaBYFpRduCCH58u/Q==
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
Subject: [PATCH v6 2/5] PCI: of: Use device_{add,remove}_of_node() to attach of_node to existing device
Date: Fri, 10 Jan 2025 09:21:38 +0100
Message-ID: <20250110082143.917590-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110082143.917590-1-herve.codina@bootlin.com>
References: <20250110082143.917590-1-herve.codina@bootlin.com>
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
 drivers/pci/of.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 52f770bcc481..e6a39f0361da 100644
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
@@ -713,11 +713,18 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 		goto out_free_node;
 
 	np->data = cset;
-	pdev->dev.of_node = np;
+
+	ret = device_add_of_node(&pdev->dev, np);
+	if (ret)
+		goto out_revert_cset;
+
 	kfree(name);
 
 	return;
 
+out_revert_cset:
+	np->data = NULL;
+	of_changeset_revert(cset);
 out_free_node:
 	of_node_put(np);
 out_destroy_cset:
-- 
2.47.1


