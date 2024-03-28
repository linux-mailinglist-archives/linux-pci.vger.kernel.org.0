Return-Path: <linux-pci+bounces-5311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B158A88FA4B
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666291F2932F
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 08:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8A85339B;
	Thu, 28 Mar 2024 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X9vvAeOf"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F564F616;
	Thu, 28 Mar 2024 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615872; cv=none; b=FeilJeSAp6pPJbqOV5xMRUu/UtzZyQE8hy97R7MLyg4po/BxxeidpBBlZAO+dexVgj+oTZfu0/CPi5Bvk3U6i9G2ANhmP3zFzjnk3XeypUfKx9ZNG1e/ep9oHvbyJJ9N2rUm0jDWu+gkZYgRIrOGzw/lp7McWAf9aN2zgDFvykI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615872; c=relaxed/simple;
	bh=rTSEfUqF+Ey5hxLei9PES4IYV37yhyPXQ+RvRflFktk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qoG/D/D6LYzSr5JFA8X4mlr4FCjlp1hHLe2o6R6SOuLtESMsfjTHgFTVZmHUwJX/oFYuGK3Mo58hGlndHWNd2h7Cs1rruPP7UxyrM7eUi3yKx61o1mkGsqCnm3rbw3oRoAfJHU05RkUtODrM8z+c93+XvcVe09HR21PQfr9Fj3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=X9vvAeOf; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42S8opZi034555;
	Thu, 28 Mar 2024 03:50:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711615851;
	bh=6fqrZ3X6rwNin1Wduprmoxkd0C8QZNIJC0NbxjX2BtE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=X9vvAeOfHD/z0/D/a906DBpDgSmWk/iTi5D9As5E1kNv2qUID56xwX2J5pH7aTQRU
	 /8Nj3o4QjGp4+U3xkJa9JRFvpsFbNyoBt6AFniQoqH/MfTpy0aMFAEMc8PdTu4ZmsW
	 AihpRchaERy3pXo94B9vy+gUhHbAcfzjsbJgqqg8=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42S8opEW031659
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 Mar 2024 03:50:51 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Mar 2024 03:50:51 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Mar 2024 03:50:51 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42S8ofoR006765;
	Thu, 28 Mar 2024 03:50:47 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <manivannan.sadhasivam@linaro.org>,
        <fancer.lancer@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <cassel@kernel.org>, <dlemoal@kernel.org>,
        <yoshihiro.shimoda.uh@renesas.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v7 1/2] PCI: keystone: Relocate ks_pcie_set/clear_dbi_mode()
Date: Thu, 28 Mar 2024 14:20:40 +0530
Message-ID: <20240328085041.2916899-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240328085041.2916899-1-s-vadapalli@ti.com>
References: <20240328085041.2916899-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Relocate ks_pcie_set_dbi_mode() and ks_pcie_clear_dbi_mode() to avoid
forward declaration in a subsequent patch. No functional change intended.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 84 +++++++++++------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 844de4418724..5c073e520628 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -245,6 +245,48 @@ static struct irq_chip ks_pcie_msi_irq_chip = {
 	.irq_unmask = ks_pcie_msi_unmask,
 };
 
+/**
+ * ks_pcie_set_dbi_mode() - Set DBI mode to access overlaid BAR mask registers
+ * @ks_pcie: A pointer to the keystone_pcie structure which holds the KeyStone
+ *	     PCIe host controller driver information.
+ *
+ * Since modification of dbi_cs2 involves different clock domain, read the
+ * status back to ensure the transition is complete.
+ */
+static void ks_pcie_set_dbi_mode(struct keystone_pcie *ks_pcie)
+{
+	u32 val;
+
+	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
+	val |= DBI_CS2;
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
+
+	do {
+		val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
+	} while (!(val & DBI_CS2));
+}
+
+/**
+ * ks_pcie_clear_dbi_mode() - Disable DBI mode
+ * @ks_pcie: A pointer to the keystone_pcie structure which holds the KeyStone
+ *	     PCIe host controller driver information.
+ *
+ * Since modification of dbi_cs2 involves different clock domain, read the
+ * status back to ensure the transition is complete.
+ */
+static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
+{
+	u32 val;
+
+	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
+	val &= ~DBI_CS2;
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
+
+	do {
+		val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
+	} while (val & DBI_CS2);
+}
+
 static int ks_pcie_msi_host_init(struct dw_pcie_rp *pp)
 {
 	pp->msi_irq_chip = &ks_pcie_msi_irq_chip;
@@ -340,48 +382,6 @@ static const struct irq_domain_ops ks_pcie_intx_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
-/**
- * ks_pcie_set_dbi_mode() - Set DBI mode to access overlaid BAR mask registers
- * @ks_pcie: A pointer to the keystone_pcie structure which holds the KeyStone
- *	     PCIe host controller driver information.
- *
- * Since modification of dbi_cs2 involves different clock domain, read the
- * status back to ensure the transition is complete.
- */
-static void ks_pcie_set_dbi_mode(struct keystone_pcie *ks_pcie)
-{
-	u32 val;
-
-	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
-	val |= DBI_CS2;
-	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
-
-	do {
-		val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
-	} while (!(val & DBI_CS2));
-}
-
-/**
- * ks_pcie_clear_dbi_mode() - Disable DBI mode
- * @ks_pcie: A pointer to the keystone_pcie structure which holds the KeyStone
- *	     PCIe host controller driver information.
- *
- * Since modification of dbi_cs2 involves different clock domain, read the
- * status back to ensure the transition is complete.
- */
-static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
-{
-	u32 val;
-
-	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
-	val &= ~DBI_CS2;
-	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
-
-	do {
-		val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
-	} while (val & DBI_CS2);
-}
-
 static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 {
 	u32 val;
-- 
2.40.1


