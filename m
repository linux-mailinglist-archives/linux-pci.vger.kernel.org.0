Return-Path: <linux-pci+bounces-38886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 648BDBF67F6
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 14:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9107050346C
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 12:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6643321C2;
	Tue, 21 Oct 2025 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t41wDtyC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AFB32F76F;
	Tue, 21 Oct 2025 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050477; cv=none; b=iOuxxbbmG7y3M6td1cf54ei95YULRpjVY3NA4Hdo+Bz68j+bVNvVadlynuMvNEG/dylLv8Ha54ajz9cjh6Q39HVHbsGBEXThn20gIogoWyuBOXi+ozLcgbwSBv+b0GXpC3hYdm2XE7ln+VSms/g/x4HdP8pCq/wsEgv2LI11cOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050477; c=relaxed/simple;
	bh=r/G+FZpStTM0vbk0p20owxrN91C3+v6SvIg6ZwkVinQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XW2iHLf7cCGQ3H45eCjsKQ7VyP8ugScpwCuxo9LR53F1dIjGMOaY4Z53FiqELQwEoecR4EeaehBpsjguh+QYcfQ/VjBaeTOfCCehtY1MN4earSihHSxEzLHgLKquecG0XzYDMV3MAja3fZbScNPR5Xs4kauYEx+QL2/LwToTtuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t41wDtyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F63DC4CEF1;
	Tue, 21 Oct 2025 12:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761050475;
	bh=r/G+FZpStTM0vbk0p20owxrN91C3+v6SvIg6ZwkVinQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t41wDtyCzusMv2f+XoJcJNP2U1VOcNslC7ZTMSGIYkeb6Vl21CxUDNgiibrqabq/l
	 Mc/GWVrBmnGLkZ5dMromcl0cQqI+KCJmRW64VL1pplho/ol8QclamFtQcA5wQcyT4c
	 vPS74W86Izx13lDO4yX+6zTHbTaVFtoQ8KG5Y/Vgd7d5Y8GX8R3MgYEMNZyVetUhTP
	 4pp+xS5o9KXvAJmwntx+ba48Nzobun9OHjtwvomac5wL5e/iUzhLDI7pgleO8EnIYu
	 wk/tbxYn6GGKobMswLSa+EZVe1vAw47vYL4zlD00yZJAWd6PDNxrIUmpA5A43KJK0k
	 iZup1PZMdPLgg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Rob Herring <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Scott Branden <sbranden@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ray Jui <rjui@broadcom.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH v4 1/5] of/irq: Add msi-parent check to of_msi_xlate()
Date: Tue, 21 Oct 2025 14:40:59 +0200
Message-ID: <20251021124103.198419-2-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251021124103.198419-1-lpieralisi@kernel.org>
References: <20251021124103.198419-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some legacy platforms the MSI controller for a PCI host bridge is
identified by an msi-parent property whose phandle points at an MSI
controller node with no #msi-cells property, that implicitly
means #msi-cells == 0.

For such platforms, mapping a device ID and retrieving the MSI controller
node becomes simply a matter of checking whether in the device hierarchy
there is an msi-parent property pointing at an MSI controller node with
such characteristics.

Add a helper function to of_msi_xlate() to check the msi-parent property in
addition to msi-map and retrieve the MSI controller node (with a 1:1 ID
deviceID-IN<->deviceID-OUT  mapping) to provide support for deviceID
mapping and MSI controller node retrieval for such platforms.

Fixes: 57d72196dfc8 ("irqchip/gic-v5: Add GICv5 ITS support")
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Cc: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/of/irq.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 65c3c23255b7..321d40ec229b 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -671,6 +671,36 @@ void __init of_irq_init(const struct of_device_id *matches)
 	}
 }
 
+static int of_check_msi_parent(struct device_node *dev_node, struct device_node **msi_node)
+{
+	struct of_phandle_args msi_spec;
+	int ret;
+
+	/*
+	 * An msi-parent phandle with a missing or == 0 #msi-cells
+	 * property identifies a 1:1 ID translation mapping.
+	 *
+	 * Set the msi controller node if the firmware matches this
+	 * condition.
+	 */
+	ret = of_parse_phandle_with_optional_args(dev_node, "msi-parent", "#msi-cells",
+						  0, &msi_spec);
+	if (ret)
+		return ret;
+
+	if ((*msi_node && *msi_node != msi_spec.np) || msi_spec.args_count != 0)
+		ret = -EINVAL;
+
+	if (!ret) {
+		/* Return with a node reference held */
+		*msi_node = msi_spec.np;
+		return 0;
+	}
+	of_node_put(msi_spec.np);
+
+	return ret;
+}
+
 /**
  * of_msi_xlate - map a MSI ID and find relevant MSI controller node
  * @dev: device for which the mapping is to be done.
@@ -678,7 +708,7 @@ void __init of_irq_init(const struct of_device_id *matches)
  * @id_in: Device ID.
  *
  * Walk up the device hierarchy looking for devices with a "msi-map"
- * property. If found, apply the mapping to @id_in.
+ * or "msi-parent" property. If found, apply the mapping to @id_in.
  * If @msi_np points to a non-NULL device node pointer, only entries targeting
  * that node will be matched; if it points to a NULL value, it will receive the
  * device node of the first matching target phandle, with a reference held.
@@ -692,12 +722,15 @@ u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in)
 
 	/*
 	 * Walk up the device parent links looking for one with a
-	 * "msi-map" property.
+	 * "msi-map" or an "msi-parent" property.
 	 */
-	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent)
+	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent) {
 		if (!of_map_id(parent_dev->of_node, id_in, "msi-map",
 				"msi-map-mask", msi_np, &id_out))
 			break;
+		if (!of_check_msi_parent(parent_dev->of_node, msi_np))
+			break;
+	}
 	return id_out;
 }
 
-- 
2.50.1


