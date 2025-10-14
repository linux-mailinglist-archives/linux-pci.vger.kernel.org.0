Return-Path: <linux-pci+bounces-38028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AADD1BD89CA
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 11:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A7354E5DF8
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 09:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871D32ECE89;
	Tue, 14 Oct 2025 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgAAaxiV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA2F2EBDC5;
	Tue, 14 Oct 2025 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435949; cv=none; b=LLIhfwE+5OrO/H88sAtCIQaKEaIq5XDipK3fYPp/N/FeRBJFANprzLzHOOaojPhGI6dTpNkWSeYhR9GnSp4ConHUet0FCPz+gtRLSAJVP+dH9q0e86zUpKNNytYWT/sxvBvG2pTc9Zt/sISgHSyZbNUVw6i9Ui9klRcFoX/0tPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435949; c=relaxed/simple;
	bh=Y0bEX5hkAWRJGif5UBaJSI/DJMYF6LpNlNLgCxXcdQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUqGTotezM5C5Gfn+8aJ6LPYdZpoK7gaH6PWLtEpo0J225GgCtZVXQ2M5Xss0W5Dvhz9GFzGuyJ/lArhOyLh98khyOmjjLE5rBg91KQvs6AAGwlxdtNYAd+38KISVeS/WcnSILcrvFAK8IqbUMz6lDDuYKaCx9HYUNHNBLoDaKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgAAaxiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075D9C4CEE7;
	Tue, 14 Oct 2025 09:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760435948;
	bh=Y0bEX5hkAWRJGif5UBaJSI/DJMYF6LpNlNLgCxXcdQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OgAAaxiVcgTmp+m3JLTe9FVIKnHuVzIyx7Zd6lxzOOsRxgW/1jR+2UWkpI+lcgQ6V
	 JlSRhEOKj6zTUaNJ5Kmqh6lGuXNMdrvEhycEn4LVjlCWPg6db+whgEjKao8qeDGPYE
	 7iETeBDpoqKAYQPqksB+k5aNRuOcrO08Uoz8inrI6l1rhq90hn0XotgXYPhRNpz7Ne
	 KqFbmn/fOWSGwzhT1ymEnGGg4+E5J2gnelPEofdRnhqOu+GD9J4GRyn07uHAJx+WIT
	 zBxnNaP2PB4gCZOJ0+vDCnv81jPJ2BanIy+TF93TE1s5Qps/gH+rbjufpGJT4GX6zy
	 H8EZYZg9jknmA==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: [PATCH v2 4/4] irqchip/gic-its: Rework platform MSI deviceID detection
Date: Tue, 14 Oct 2025 11:58:45 +0200
Message-ID: <20251014095845.1310624-5-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251014095845.1310624-1-lpieralisi@kernel.org>
References: <20251014095845.1310624-1-lpieralisi@kernel.org>
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
- It triggers an excessive WARN_ON on wrong of_phandle_args count detection
- It is duplicated between GICv3 and GICv5 for no good reason
- It does not use the OF phandle iterator code that simplifies
  the msi-parent property parsing

Implement a helper function that addresses the full set of issues in one go
by consolidating GIC v3 and v5 code and converting the msi-parent parsing
loop to the more modern OF phandle iterator API, fixing the
struct device_node reference leak in the process.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-its-msi-parent.c | 98 ++++++++----------------
 1 file changed, 33 insertions(+), 65 deletions(-)

diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-gic-its-msi-parent.c
index eb1473f1448a..a65f762b7dd4 100644
--- a/drivers/irqchip/irq-gic-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-its-msi-parent.c
@@ -142,83 +142,51 @@ static int its_v5_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 #define its_v5_pci_msi_prepare	NULL
 #endif /* !CONFIG_PCI_MSI */
 
-static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
-				  u32 *dev_id)
+static int __of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev, u32 *dev_id,
+				phys_addr_t *pa, bool is_v5)
 {
-	int ret, index = 0;
+	struct of_phandle_iterator it;
+	uint32_t args;
+	int ret;
 
 	/* Suck the DeviceID out of the msi-parent property */
-	do {
-		struct of_phandle_args args;
+	of_for_each_phandle(&it, ret, dev->of_node, "msi-parent", "#msi-cells", -1) {
+		/* GICv5 ITS domain matches the MSI controller node parent */
+		struct device_node *np __free(device_node) = is_v5 ? of_get_parent(it.node)
+							     : of_node_get(it.node);
 
-		ret = of_parse_phandle_with_args(dev->of_node,
-						 "msi-parent", "#msi-cells",
-						 index, &args);
-		if (args.np == irq_domain_get_of_node(domain)) {
-			if (WARN_ON(args.args_count != 1))
-				return -EINVAL;
-			*dev_id = args.args[0];
-			break;
+		if (np == irq_domain_get_of_node(domain)) {
+			if (of_phandle_iterator_args(&it, &args, 1) != 1) {
+				dev_warn(dev, "Bogus msi-parent property\n");
+				ret = -EINVAL;
+			}
+
+			if (!ret && is_v5)
+				ret = its_translate_frame_address(it.node, pa);
+
+			if (!ret)
+				*dev_id = args;
+
+			of_node_put(it.node);
+			return ret;
 		}
-		index++;
-	} while (!ret);
-
-	if (ret) {
-		struct device_node *np = NULL;
-
-		ret = of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &np, dev_id);
-		if (np)
-			of_node_put(np);
 	}
 
-	return ret;
+	struct device_node *msi_ctrl __free(device_node) = NULL;
+
+	return of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &msi_ctrl, dev_id);
+}
+
+static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
+			      u32 *dev_id)
+{
+	return __of_pmsi_get_dev_id(domain, dev, dev_id, NULL, false);
 }
 
 static int of_v5_pmsi_get_msi_info(struct irq_domain *domain, struct device *dev,
 				   u32 *dev_id, phys_addr_t *pa)
 {
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
-		}
-	}
-
-	return ret;
+	return __of_pmsi_get_dev_id(domain, dev, dev_id, pa, true);
 }
 
 int __weak iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
-- 
2.50.1


