Return-Path: <linux-pci+bounces-301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB6D7FF77E
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 17:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17F8281944
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 16:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A7255C14;
	Thu, 30 Nov 2023 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R2xXMZck"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0460910D0;
	Thu, 30 Nov 2023 08:57:13 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPA id BB2681BF203;
	Thu, 30 Nov 2023 16:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701363432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XjanQLiV96Fread002ZWRWE0O5XHgSgVvDb1R2qXIW8=;
	b=R2xXMZckGm13RP0RGLzamc4Vgb6v7iI8z4vIwQ/qs0jNoSNLHzqHx3vBAFWijCIKXGoCkR
	L6jLjdFc4H6Ypp8lt0HC2umsPm0Wtp/2Dg6BX51kdMlpF7uwLCXm1tTJceX9HXlOFdwslW
	SSTu2wlzabNte5XhMNvUumhiEkxKoxVxq5vbS87LrpgMM/BBWUboYAfkiC2t3dZzr5VR2N
	uhTN4z5TIGNF1F+ruh4VjIQkmBtVJiE9yt1oVGQgWo63uHXekz3R9hFZ/3zTzAVW5zCXLa
	hltDZrB5FZRCau61Gfr4AZkomtvzn+FetxJhKnEtAO95BL7grV5qp7Qc+q6MXA==
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
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] PCI: of: Attach created of_node to existing device
Date: Thu, 30 Nov 2023 17:56:59 +0100
Message-ID: <20231130165700.685764-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231130165700.685764-1-herve.codina@bootlin.com>
References: <20231130165700.685764-1-herve.codina@bootlin.com>
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
new devices (struct device) are created.
For each PCI devices a struct device is already present (created and
handled by the PCI core).
Having a second struct device to represent the exact same PCI device is
not correct.

On the of_node creation, tell the of_platform that there is no need to
create a device for this node (OF_POPULATED flag), link this newly
created of_node to the already present device and tell fwnode that the
device attached to this of_node is ready (fwnode_dev_initialized()).

With this fix, the of_node are available in the sysfs device tree:
/sys/devices/platform/soc/d0070000.pcie/
+ of_node -> .../devicetree/base/soc/pcie@d0070000
+ pci0000:00
  + 0000:00:00.0
    + of_node -> .../devicetree/base/soc/pcie@d0070000/pci@0,0
    + 0000:01:00.0
      + of_node -> .../devicetree/base/soc/pcie@d0070000/pci@0,0/dev@0,0

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
2.42.0


