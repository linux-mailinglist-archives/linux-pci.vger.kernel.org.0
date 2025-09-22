Return-Path: <linux-pci+bounces-36624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8806B8F3F5
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 09:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30DC3BFCCF
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 07:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633E82F618F;
	Mon, 22 Sep 2025 07:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ODtkd9rv"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20F72F2916;
	Mon, 22 Sep 2025 07:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525196; cv=none; b=dpAph+KWWenMxd16QtSEJhWxBb84joA7tWYOcx+BRKfin37FeJsxW7huQ32vOrA5SCGMEvnLPUsAjev2Qo1ir9KITTCP26lJC0K3nNiew1IQ89B2U7RsAmW+hep3zHihySIelUsmgew1zk3GPa+2ZF0fv32mqq05Owtm5OwHOiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525196; c=relaxed/simple;
	bh=8YCqD/X4C6XNr2qVICFl11I+6jGisDXmmkdkUVDT5Ek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+GLZkZGRJ71eAztmKvf3m2B99DFziJ5MuRRM2ncjgViG25VEUEv5/MfeofnRRx6lp/RJtNYLfR2CT5FBinzad3mOAVfQSLw6bMmBoqtVB05wB0Dpxn2aRWAVdWo7zVeEv2b4Lc2WePPkBbH7MkWVP4clwWHWokUVnPM/z6t7rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ODtkd9rv; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58M7CtrF1183992;
	Mon, 22 Sep 2025 02:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758525175;
	bh=j54wOZWYBv+WbN005PAbMoK18i+fCxKDRhnfRbi4+us=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ODtkd9rvjsNmSLZAf1hHJLQWGt8iDGDyUsmgQDF+VzVh6/eFBIgBsFplpdpj6cDzP
	 WN8yOUfrnkMHZLZ0gYHyGPiqJqfWre+pQV/HXb6GZi/QOQ0v2pQXDsLJYImx7O+b63
	 x1aigCD7Ryelsnw/9wrcfsyHo9JNBnPmz/TQlKeo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58M7CtXs118005
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 22 Sep 2025 02:12:55 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 22
 Sep 2025 02:12:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Sep 2025 02:12:54 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58M7CN0V2369246;
	Mon, 22 Sep 2025 02:12:48 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <christian.bruel@foss.st.com>, <quic_wenbyao@quicinc.com>,
        <inochiama@gmail.com>, <mayank.rana@oss.qualcomm.com>,
        <thippeswamy.havalige@amd.com>, <shradha.t@samsung.com>,
        <cassel@kernel.org>, <kishon@kernel.org>,
        <sergio.paracuellos@gmail.com>, <18255117159@163.com>,
        <rongqianfeng@vivo.com>, <jirislaby@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v3 4/4] PCI: keystone: Add support to build as a loadable module
Date: Mon, 22 Sep 2025 12:42:16 +0530
Message-ID: <20250922071222.2814937-5-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922071222.2814937-1-s-vadapalli@ti.com>
References: <20250922071222.2814937-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The 'pci-keystone.c' driver is the application/glue/wrapper driver for the
Designware PCIe Controllers on TI SoCs. Now that all of the helper APIs
that the 'pci-keystone.c' driver depends upon have been exported for use,
enable support to build the driver as a loadable module.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v2 of this patch is at:
https://lore.kernel.org/r/20250912122356.3326888-11-s-vadapalli@ti.com/
Changes since v2:
- Based on Mani's feedback, all code changes associated with driver
  removal have been discarded.

 drivers/pci/controller/dwc/Kconfig        | 6 +++---
 drivers/pci/controller/dwc/pci-keystone.c | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 34abc859c107..46012d6a607e 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -482,10 +482,10 @@ config PCI_DRA7XX_EP
 	  This uses the DesignWare core.
 
 config PCI_KEYSTONE
-	bool
+	tristate
 
 config PCI_KEYSTONE_HOST
-	bool "TI Keystone PCIe controller (host mode)"
+	tristate "TI Keystone PCIe controller (host mode)"
 	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
@@ -497,7 +497,7 @@ config PCI_KEYSTONE_HOST
 	  DesignWare core functions to implement the driver.
 
 config PCI_KEYSTONE_EP
-	bool "TI Keystone PCIe controller (endpoint mode)"
+	tristate "TI Keystone PCIe controller (endpoint mode)"
 	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index f9f8235ea3cd..2fbc714bb6e5 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -17,6 +17,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
@@ -1134,6 +1135,7 @@ static const struct of_device_id ks_pcie_of_match[] = {
 	},
 	{ },
 };
+MODULE_DEVICE_TABLE(of, ks_pcie_of_match);
 
 static int ks_pcie_probe(struct platform_device *pdev)
 {
@@ -1382,3 +1384,7 @@ static struct platform_driver ks_pcie_driver = {
 	},
 };
 builtin_platform_driver(ks_pcie_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("PCIe host controller driver for Texas Instruments Keystone SoCs");
+MODULE_AUTHOR("Murali Karicheri <m-karicheri2@ti.com>");
-- 
2.43.0


