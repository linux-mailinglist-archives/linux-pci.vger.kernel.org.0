Return-Path: <linux-pci+bounces-38438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823FFBE746F
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 10:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5DE1AA1145
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 08:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F02D2D47F3;
	Fri, 17 Oct 2025 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iwe0TBnp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DB726F292;
	Fri, 17 Oct 2025 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690901; cv=none; b=ZwSLv+7oOJk99a7uR8zJsKVFrknOW4QGs/Vauuo7YGP8GpkGwGC+38VA13cXQ7/hgbegOrmAwtqgL4MAAw4PRopmIzDJpSns9dewcAJ9AVrLDmx9RWY8R2/7UhFFyeZ9ZSu2TTUACvpTC1UFsjOzmhHQ4MpcYsEh0TzMVocxLck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690901; c=relaxed/simple;
	bh=RVkyfa65ji+iVeG5m+BwMXCO2f+xUvygzZyer4ipAO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbAsEUAz8rNCrZDxNARqHw3U+f1LrZ+QvsxJ54x4Y0+Nma0vQukcO7Y0fuQhPAAmgtjCtWPV4OTLZ0GLow7kLiA/rKPahB7PgCfY1dtOwPBJK/IHuqh2N7hR0p5nOWJ4Au+C0mFyZi+WvSA4OOygjyi0bzBm47LnnGebpyo7ldA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iwe0TBnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC231C4CEE7;
	Fri, 17 Oct 2025 08:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760690900;
	bh=RVkyfa65ji+iVeG5m+BwMXCO2f+xUvygzZyer4ipAO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iwe0TBnpFzClt9Y20jsB2ePw+lmYNVEtgobf2uCd312bcIBSiTLvmqB/vK58wjCg7
	 Br8cEfkG6bbncGNfesJ5W91OmPOwRWmFvs04zN7PSjoqrvJsqXTJukcFan1g4IwhEZ
	 jidHTOVTykUEe5TYltVzRTC07oxAsXm7vVk05eo84HxModSdqO8TrNr7gvz6P7u2aO
	 CWEWQcvakcB4jIyvWtlrvBPrlZoCU6xTminoCCqSqphTFH83rFesouhB9DODt1Hfim
	 MYc/Kiq60SPXBrXU49Wte2OqeH9t0bIvd2nCiOJbqo+q1QnpNuopvT2nlhWkgCE0BI
	 BYIJrfhLwtHvQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Marc Zyngier <maz@kernel.org>,
	Scott Branden <sbranden@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ray Jui <rjui@broadcom.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH v3 5/5] irqchip/gic-its: Rework platform MSI deviceID detection
Date: Fri, 17 Oct 2025 10:47:52 +0200
Message-ID: <20251017084752.1590264-6-lpieralisi@kernel.org>
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

Current code retrieving platform devices MSI devID in the GIC ITS MSI
parent helpers suffers from some minor issues:

- It leaks a struct device_node reference
- It is duplicated between GICv3 and GICv5 for no good reason
- It does not use the OF phandle iterator code that simplifies
  the msi-parent property parsing

Consolidate GIC v3 and v5 deviceID retrieval in a function that addresses
the full set of issues in one go by merging GIC v3 and v5 code and
converting the msi-parent parsing loop to the more modern OF phandle
iterator API, fixing the struct device_node reference leak in the process.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-its-msi-parent.c | 91 ++++++------------------
 1 file changed, 23 insertions(+), 68 deletions(-)

diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-gic-its-msi-parent.c
index eb1473f1448a..12f45228c867 100644
--- a/drivers/irqchip/irq-gic-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-its-msi-parent.c
@@ -142,83 +142,38 @@ static int its_v5_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 #define its_v5_pci_msi_prepare	NULL
 #endif /* !CONFIG_PCI_MSI */
 
-static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
-				  u32 *dev_id)
+static int of_pmsi_get_msi_info(struct irq_domain *domain, struct device *dev, u32 *dev_id,
+				phys_addr_t *pa)
 {
-	int ret, index = 0;
+	struct of_phandle_iterator it;
+	int ret;
 
 	/* Suck the DeviceID out of the msi-parent property */
-	do {
-		struct of_phandle_args args;
+	of_for_each_phandle(&it, ret, dev->of_node, "msi-parent", "#msi-cells", -1) {
+		/* GICv5 ITS domain matches the MSI controller node parent */
+		struct device_node *np __free(device_node) = pa ? of_get_parent(it.node)
+								: of_node_get(it.node);
 
-		ret = of_parse_phandle_with_args(dev->of_node,
-						 "msi-parent", "#msi-cells",
-						 index, &args);
-		if (args.np == irq_domain_get_of_node(domain)) {
-			if (WARN_ON(args.args_count != 1))
-				return -EINVAL;
-			*dev_id = args.args[0];
-			break;
-		}
-		index++;
-	} while (!ret);
+		if (np == irq_domain_get_of_node(domain)) {
+			u32 args;
 
-	if (ret) {
-		struct device_node *np = NULL;
+			if (WARN_ON(of_phandle_iterator_args(&it, &args, 1) != 1))
+				ret = -EINVAL;
 
-		ret = of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &np, dev_id);
-		if (np)
-			of_node_put(np);
-	}
+			if (!ret && pa)
+				ret = its_translate_frame_address(it.node, pa);
 
-	return ret;
-}
+			if (!ret)
+				*dev_id = args;
 
-static int of_v5_pmsi_get_msi_info(struct irq_domain *domain, struct device *dev,
-				   u32 *dev_id, phys_addr_t *pa)
-{
-	int ret, index = 0;
-	/*
-	 * Retrieve the DeviceID and the ITS translate frame node pointer
-	 * out of the msi-parent property.
-	 */
-	do {
-		struct of_phandle_args args;
-
-		ret = of_parse_phandle_with_args(dev->of_node,
-						 "msi-parent", "#msi-cells",
-						 index, &args);
-		if (ret)
-			break;
-		/*
-		 * The IRQ domain fwnode is the msi controller parent
-		 * in GICv5 (where the msi controller nodes are the
-		 * ITS translate frames).
-		 */
-		if (args.np->parent == irq_domain_get_of_node(domain)) {
-			if (WARN_ON(args.args_count != 1))
-				return -EINVAL;
-			*dev_id = args.args[0];
-
-			ret = its_translate_frame_address(args.np, pa);
-			if (ret)
-				return -ENODEV;
-			break;
-		}
-		index++;
-	} while (!ret);
-
-	if (ret) {
-		struct device_node *np = NULL;
-
-		ret = of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &np, dev_id);
-		if (np) {
-			ret = its_translate_frame_address(np, pa);
-			of_node_put(np);
+			of_node_put(it.node);
+			return ret;
 		}
 	}
 
-	return ret;
+	struct device_node *msi_ctrl __free(device_node) = NULL;
+
+	return of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &msi_ctrl, dev_id);
 }
 
 int __weak iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
@@ -234,7 +189,7 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 	int ret;
 
 	if (dev->of_node)
-		ret = of_pmsi_get_dev_id(domain->parent, dev, &dev_id);
+		ret = of_pmsi_get_msi_info(domain->parent, dev, &dev_id, NULL);
 	else
 		ret = iort_pmsi_get_dev_id(dev, &dev_id);
 	if (ret)
@@ -262,7 +217,7 @@ static int its_v5_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 	if (!dev->of_node)
 		return -ENODEV;
 
-	ret = of_v5_pmsi_get_msi_info(domain->parent, dev, &dev_id, &pa);
+	ret = of_pmsi_get_msi_info(domain->parent, dev, &dev_id, &pa);
 	if (ret)
 		return ret;
 
-- 
2.50.1


