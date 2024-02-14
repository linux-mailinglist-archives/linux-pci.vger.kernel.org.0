Return-Path: <linux-pci+bounces-3424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E41AD85424A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 06:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78DC128AA24
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 05:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC3DBA26;
	Wed, 14 Feb 2024 05:21:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B1B10A01;
	Wed, 14 Feb 2024 05:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707888091; cv=none; b=NSkdHYeZI4l6gsirFtDg/k3SiqIzKVrYGhKpz6ix0cM/rOOYofxNL65zKZ2LEfSUFGs/LRVV2wF0Ev9YAWGSGVkY/8QxszsRmZEI1L/qs7lkjmQ6kkbpiezE4J/axSMVGfkpHE45G/Ch+sU8yL1CFR4tF5sYclhT9u74Rj50/tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707888091; c=relaxed/simple;
	bh=hpAAPJoWLlT8clI4+AqgtqsYjnACErm8oePco3aof+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NR5UJbNJm1nse/BkaxAgDnXX038Bq0/qbRSgM9fRcUwh2QYsiG/O44YCmwp+X+pnOcUoME8EEhXAliUfBFi5P/YtuaOZrpjXQVClMt6i1V15k0gFcjS7UgF3J6HjdgXysyTBtufu4UT8zjS06ovO5tFx7/I0m99FU6tNRwWMGgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.06,159,1705330800"; 
   d="scan'208";a="193876812"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Feb 2024 14:21:25 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id CC13B4190465;
	Wed, 14 Feb 2024 14:21:25 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] PCI: rcar-gen4: Add vendor-specific registers' setting for MSI-X
Date: Wed, 14 Feb 2024 14:21:22 +0900
Message-Id: <20240214052122.1966506-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This controller with GICv3 ITS can handle MSI-X, but it needs
to set vendor-specific registers by using the MSI address value.
To get the address, add .post_init() for it.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 27 +++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index e9166619b1f9..2ed62ffbde38 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -42,6 +42,13 @@
 #define APP_HOLD_PHY_RST	BIT(16)
 #define APP_LTSSM_ENABLE	BIT(0)
 
+/* INTC address */
+#define AXIINTCADDR		0x0a00
+
+/* INTC control & mask */
+#define AXIINTCCONT		0x0a04
+#define AXIINTCCONT_VAL		(BIT(31) | GENMASK(11, 2))
+
 #define RCAR_NUM_SPEED_CHANGE_RETRIES	10
 #define RCAR_MAX_LINK_SPEED		4
 
@@ -297,6 +304,25 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static void rcar_gen4_pcie_host_post_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
+	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
+	struct irq_data *data;
+	struct pci_dev *dev;
+	struct msi_msg msg;
+
+	if (pp->has_msi_ctrl)
+		return;
+
+	list_for_each_entry(dev, &pp->bridge->bus->devices, bus_list) {
+		data = irq_get_irq_data(dev->irq);
+		__pci_read_msi_msg(irq_data_get_msi_desc(data), &msg);
+		writel(msg.address_lo, rcar->base + AXIINTCADDR);
+		writel(AXIINTCCONT_VAL, rcar->base + AXIINTCCONT);
+	}
+}
+
 static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
@@ -308,6 +334,7 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
 
 static const struct dw_pcie_host_ops rcar_gen4_pcie_host_ops = {
 	.init = rcar_gen4_pcie_host_init,
+	.post_init = rcar_gen4_pcie_host_post_init,
 	.deinit = rcar_gen4_pcie_host_deinit,
 };
 
-- 
2.25.1


