Return-Path: <linux-pci+bounces-5074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3EF88A07F
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 13:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6696A2C3731
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 12:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A018654770;
	Mon, 25 Mar 2024 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ts7D4Wli"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7FC12C540;
	Mon, 25 Mar 2024 05:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345083; cv=none; b=sIYSW3h4/HvBlKcc1hDz7p5cnsdKDPVTgcIA4VTYsE7tuziVA/YMRypTfUugL29D907+rFd7PX2DoSnDDayJFFAXJon9PBVhR0s8aC9hVbjtdiYOoPeYWriJVRNUXEcn0u90xTSxayNSPeauUt/sla0fQQt6KM+uhDi2VCi0DyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345083; c=relaxed/simple;
	bh=Jvf+H6ieo/8EAZ+s5j1RuVdOtsHd7dg2T3/Rgugut+U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UyhBxvz3zWADPVkvLayCScYnwvkGUhAeguvtlpJubi0pf/+2hFDcAEXbkqAwT3C1af03WrcHQDuFBiOC+8UhrtJ2FT2uWYTv6HFdp1hzzXQMwV+p57ncpAZ9LMHRoMUp1LuwG6BWzMTBfBobVTBAkS7eijTixs2fbDy5pTR28o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ts7D4Wli; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42P5bSkQ009285;
	Mon, 25 Mar 2024 00:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711345048;
	bh=WllkeeCUlpO3Is+q7yv1amdCx71KYpwEFW3qr6wcwuQ=;
	h=From:To:CC:Subject:Date;
	b=Ts7D4WlioYdzk5H16+Xbav3KXH1QA5xUpajtpD2hKCyAXQILpAZKlUvuLB7nechy3
	 WVMcuirW0r0ndD4gw/lPJUs4t/0Ms8aLDrcJCuCCpF7qp4B2zP6xnMnUHHjTSuc9aj
	 DgZ3Himvo8cSrzb5in5lJo2BIn/p/LyBnVh+8JgI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42P5bSKu127602
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 00:37:28 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 00:37:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 00:37:28 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42P5bNCA105361;
	Mon, 25 Mar 2024 00:37:24 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <manivannan.sadhasivam@linaro.org>,
        <fancer.lancer@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <cassel@kernel.org>, <dlemoal@kernel.org>,
        <yoshihiro.shimoda.uh@renesas.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4] PCI: keystone: Fix pci_ops for AM654x SoC
Date: Mon, 25 Mar 2024 11:07:22 +0530
Message-ID: <20240325053722.1955433-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
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
ks_pcie_v3_65_add_bus() method are applicable to the controller version
4.90a which is present in AM654x SoCs.

Thus, as a fix, move the contents of "ks_pcie_v3_65_add_bus()" to the
.host_init callback "ks_pcie_host_init()" and execute it only for non
AM654x SoC devices which have the v3.65a DWC PCIe IP Controllers.

Fixes: 6ab15b5e7057 ("PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus")
Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20240325.
This patch is technically the next version for the v3 patch at:
https://patchwork.kernel.org/project/linux-pci/patch/20231019081330.2975470-1-s-vadapalli@ti.com/
but the implementation is based on the RFC patch at:
https://patchwork.kernel.org/project/linux-pci/patch/20231027084159.4166188-1-s-vadapalli@ti.com/
Since the RFC patch mentioned above fixes the same issue being
fixed by the v3 patch, I have dropped the v3 patch and am using
the RFC patch since it is a cleaner implementation and was discussed at:
https://lore.kernel.org/r/20231019220847.GA1413474@bhelgaas/

Regards,
Siddharth.

 drivers/pci/controller/dwc/pci-keystone.c | 51 ++++++++---------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 844de4418724..f45bdeac520a 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -445,44 +445,10 @@ static struct pci_ops ks_child_pcie_ops = {
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
@@ -822,6 +788,23 @@ static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret < 0)
 		return ret;
 
+	if (!ks_pcie->is_am6) {
+		/* Configure and set up BAR0 */
+		ks_pcie_set_dbi_mode(ks_pcie);
+
+		/* Enable BAR0 */
+		dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
+		dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
+
+		ks_pcie_clear_dbi_mode(ks_pcie);
+
+		/*
+		 * For BAR0, just setting bus address for inbound writes (MSI) should
+		 * be sufficient.  Use physical address to avoid any conflicts.
+		 */
+		dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
+	}
+
 #ifdef CONFIG_ARM
 	/*
 	 * PCIe access errors that result into OCP errors are caught by ARM as
-- 
2.40.1


