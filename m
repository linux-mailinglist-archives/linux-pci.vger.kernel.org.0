Return-Path: <linux-pci+bounces-38434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6395EBE747B
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 10:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72FB9563B80
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 08:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2C82D8396;
	Fri, 17 Oct 2025 08:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMlgi6WD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D3229D279;
	Fri, 17 Oct 2025 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690883; cv=none; b=mkKx0F3sCRmH0h/5woBAK2juHlB+VnltvUmG59AGELmk7/2Jezn0jxj0nsXF7hxu0vcDRc0aWVD1ONqMN3am1gWSl27gukka3YuSwk3Vb3oAkD/h2tsJjC3nMFk8O8VkEXBas0q1Y2PABqo/nlKdpoDfbai1CUaQZqmhhVVIX5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690883; c=relaxed/simple;
	bh=JVj1gYQNdufw+TmwhieihG8R1MzSzSkm4Nvrx/BeRBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diWC8sIuFakwexcnkhGLg1KVclKeoulN+dhMrfVO9yS8flHeafv9SLgBHg/+vWZcrayAVQ+Aqc+/8uTmxCubYNCJVq5LyCuPa5+xs13wtdXJG3C/iEMk6DlGSTeoH2cduRHGPrWdq2NWw17cGxt5n9Tqyuwa9bHabSJFT/jH8zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMlgi6WD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA19FC4CEFE;
	Fri, 17 Oct 2025 08:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760690883;
	bh=JVj1gYQNdufw+TmwhieihG8R1MzSzSkm4Nvrx/BeRBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TMlgi6WDROJvwgsEFXAEcTDSDrW8nYAs4gVgJxVxXbtbjlkFM/L8DmJAWzsAjVtN+
	 nLwVrG7goFBuZUXW2wQMXuWZdOAFuieKugLtiYHB7AedkkEkL/VfP4b0y/pwmD3vaa
	 7F75z/Gn5tkrYQrSf6+g+35Zws9wdtlu4RJ2tMFwtWtPsBepu6Vs6srtZJezRkSDZT
	 Yl0z1C/PdSi5UzcPrxW3sfA6PpZe4jzK61K/GZqrRqMEy0QpL/kFhEbNXqnntYoa/4
	 uz80e2fjmefO/YeiaORkjcPNw/4B99PfHTDPxyiyJ40Fadcs84UTcuxsPaxnSFop5k
	 QIe490Cvp8uRw==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Rob Herring <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Scott Branden <sbranden@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ray Jui <rjui@broadcom.com>,
	Frank Li <Frank.Li@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH v3 1/5] of/irq: Add msi-parent check to of_msi_xlate()
Date: Fri, 17 Oct 2025 10:47:48 +0200
Message-ID: <20251017084752.1590264-2-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251017084752.1590264-1-lpieralisi@kernel.org>
References: <20251017084752.1590264-1-lpieralisi@kernel.org>
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
Cc: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/of/irq.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 65c3c23255b7..e67b2041e73b 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -671,6 +671,35 @@ void __init of_irq_init(const struct of_device_id *matches)
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
+	if (!ret) {
+		if ((*msi_node && *msi_node != msi_spec.np) || msi_spec.args_count != 0)
+			ret = -EINVAL;
+
+		if (!ret) {
+			/* Return with a node reference held */
+			*msi_node = msi_spec.np;
+			return 0;
+		}
+		of_node_put(msi_spec.np);
+	}
+
+	return ret;
+}
+
 /**
  * of_msi_xlate - map a MSI ID and find relevant MSI controller node
  * @dev: device for which the mapping is to be done.
@@ -678,7 +707,7 @@ void __init of_irq_init(const struct of_device_id *matches)
  * @id_in: Device ID.
  *
  * Walk up the device hierarchy looking for devices with a "msi-map"
- * property. If found, apply the mapping to @id_in.
+ * or "msi-parent" property. If found, apply the mapping to @id_in.
  * If @msi_np points to a non-NULL device node pointer, only entries targeting
  * that node will be matched; if it points to a NULL value, it will receive the
  * device node of the first matching target phandle, with a reference held.
@@ -692,12 +721,15 @@ u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in)
 
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


