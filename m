Return-Path: <linux-pci+bounces-5312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E29FE88FA4D
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 834C9B21BE2
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 08:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F94554BDA;
	Thu, 28 Mar 2024 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xI15aUAH"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E3B524BD;
	Thu, 28 Mar 2024 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615873; cv=none; b=gPCfSoY+j1kbnWYNmwY5OaIR/MTVMs76RaBQ9oCVBONgUiXI+wLywgnnTJHaK2dsXeUSH4ZCK/YRLhl/DXzR/k5yLXwP5a3/VyGkehY1XsIx1cMASkrKU9eSZB9hm7vUjmCfgl1Emo5rl3dHzx1G5W31MqB1s4qIxqU+QCOmbAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615873; c=relaxed/simple;
	bh=BBKS+WkguECYPTf5EBj+LsVsSbrgWaqyjOe7ZQMnrTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJn7mbH9HHFMFURiff/NOXRIKu9DFRoKUYOLbFSdS5t3S6kFYrHyOd/IUChGMMMhjP89mBY4rYgsVugjyDDwZQOmz8yryW/k0ziPyuL9X0bMB7Y3xlTDSbS8GL7cChMHLg+LMQkwDJsSr5DORLjf7ujJjjnzCaxQDGpwRVyuk+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xI15aUAH; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42S8otY4034571;
	Thu, 28 Mar 2024 03:50:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711615855;
	bh=WJeEI3UEUOMEgTxcsOj3TBMO3CU6MpTVOo9zJtJsv6s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=xI15aUAHjQ56mvho+J0A77ltN2wGsQPERGYPhKTdR9DC18ax/NNRoL5Y4zohVIpDF
	 ppCD3t7n93iBAo5x35BiZ80EVum5kZKGqM22WHjhIxryt4bXXizrYdp6xLdO8tRi4S
	 hbRb4gCuIILXgmkVkabM1LXTiJo+ZZYJN7pzT9G4=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42S8otjD099491
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 Mar 2024 03:50:55 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Mar 2024 03:50:55 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Mar 2024 03:50:55 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42S8ofoS006765;
	Thu, 28 Mar 2024 03:50:51 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <manivannan.sadhasivam@linaro.org>,
        <fancer.lancer@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <cassel@kernel.org>, <dlemoal@kernel.org>,
        <yoshihiro.shimoda.uh@renesas.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v7 2/2] PCI: keystone: Fix pci_ops for AM654x SoC
Date: Thu, 28 Mar 2024 14:20:41 +0530
Message-ID: <20240328085041.2916899-3-s-vadapalli@ti.com>
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

In the process of converting .scan_bus() callbacks to .add_bus(), the
ks_pcie_v3_65_scan_bus() function was changed to ks_pcie_v3_65_add_bus().
The .scan_bus() method belonged to ks_pcie_host_ops which was specific
to controller version 3.65a, while the .add_bus() method had been added
to ks_pcie_ops which is shared between the controller versions 3.65a and
4.90a. Neither the older ks_pcie_v3_65_scan_bus() method, nor the newer
ks_pcie_v3_65_add_bus() method is applicable to the controller version
4.90a which is present in AM654x SoCs.

Thus, as a fix, remove "ks_pcie_v3_65_add_bus()" and move its contents
to the .msi_init callback "ks_pcie_msi_host_init()" which is specific to
the 3.65a controller.

Fixes: 6ab15b5e7057 ("PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus")
Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Suggested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 52 ++++++++---------------
 1 file changed, 18 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 5c073e520628..6cb3a4713009 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -289,6 +289,24 @@ static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
 
 static int ks_pcie_msi_host_init(struct dw_pcie_rp *pp)
 {
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+
+	/* Configure and set up BAR0 */
+	ks_pcie_set_dbi_mode(ks_pcie);
+
+	/* Enable BAR0 */
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
+
+	ks_pcie_clear_dbi_mode(ks_pcie);
+
+	/*
+	 * For BAR0, just setting bus address for inbound writes (MSI) should
+	 * be sufficient.  Use physical address to avoid any conflicts.
+	 */
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
+
 	pp->msi_irq_chip = &ks_pcie_msi_irq_chip;
 	return dw_pcie_allocate_domains(pp);
 }
@@ -445,44 +463,10 @@ static struct pci_ops ks_child_pcie_ops = {
 	.write = pci_generic_config_write,
 };
 
-/**
- * ks_pcie_v3_65_add_bus() - keystone add_bus post initialization
- * @bus: A pointer to the PCI bus structure.
- *
- * This sets BAR0 to enable inbound access for MSI_IRQ register
- */
-static int ks_pcie_v3_65_add_bus(struct pci_bus *bus)
-{
-	struct dw_pcie_rp *pp = bus->sysdata;
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
-
-	if (!pci_is_root_bus(bus))
-		return 0;
-
-	/* Configure and set up BAR0 */
-	ks_pcie_set_dbi_mode(ks_pcie);
-
-	/* Enable BAR0 */
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
-
-	ks_pcie_clear_dbi_mode(ks_pcie);
-
-	 /*
-	  * For BAR0, just setting bus address for inbound writes (MSI) should
-	  * be sufficient.  Use physical address to avoid any conflicts.
-	  */
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
-
-	return 0;
-}
-
 static struct pci_ops ks_pcie_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
-	.add_bus = ks_pcie_v3_65_add_bus,
 };
 
 /**
-- 
2.40.1


