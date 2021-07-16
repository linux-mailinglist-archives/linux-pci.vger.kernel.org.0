Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059A73CB9B6
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 17:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbhGPP1Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 11:27:25 -0400
Received: from mail-bn8nam08on2086.outbound.protection.outlook.com ([40.107.100.86]:5408
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240765AbhGPP1Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jul 2021 11:27:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnfgvhtkzNCzQLZQXZG+veqIuz0jIKI0X66ZUf8CEhckwrrr4X2m6MnbNWo4NyaPoN1wDU31EA3HWFBXOQysTI21M4vj/R6eGIS6X0/xxm237priD9auW/jtvGSS6SdrrHTb7iYFOEyL8vTnLWPEQLmu/omeGCD1T6r/O3M/J+cGytaaenOqNJZ3Yth4pEiTk7f7iNV7Dv7zsvqHGiT/74MTWTUIEMSDFsMCzYm5kUz4SBHGgvvgeUPqpTnVfd3i8CN6n0UuAAnDkqfyYkAkDnFdE0DemyeOqHbmeMlQJAoWYYomh9h82R1zbXodlAJes4x/miZByNklmR6Z2ZtGxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNGEdyd2PXOAXWZpuACvKtbKoIiSd/mnufsXFJddCvc=;
 b=BovVt5TbsQAzb2YRaTjTzIQ9CiB0YBxMfi0HBvjONHMOo80W/DDY5ReVNG9Ie/e/TUiKtdYcdnH+zKcNu0idwje4mi1iJyks2NRhaflr0CnYVQTGy3LcO8QQEaOlzx1VF47IltakKvlHsXRBSggmPFHWw6YxTM9GvRoHyQXyrBEvfpOkmxebOf0KSlrjeltOmUWYCiZxVEZhHQUbm8I4YYwGqRp5kIqLnsYejwCVQk7Q1SNfeEwIWVwB0MTCuMgK16vdhPuOjzBBvZzIF6SiAvThb8BQ9qaFZxJdFsvoigARLs0KrI9t7LfwGMP/YXFpqsSWvwRD7pg3QvEn7/qb5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNGEdyd2PXOAXWZpuACvKtbKoIiSd/mnufsXFJddCvc=;
 b=Dfp6sJPdAlh9PKPNhaOBDd1dRAflFcYSTlsLkibDvhLe9mGt1mvzSeHvN5LHQqDD1ymh/fBr6Ygr/jd8qXZmW857mDoNEsC8Nf8PYhWiRVqs1zjOqs1A1y4Kdrch+l8KczFdHI0M+DzabkPB7X22uhKenvlzJtUGZhVkVee6bQuiHvkMq+MCuVEaJiqkhLQSRjCU8ZCEXKCfYGHEiBGAGAb9N9wSoptzWKDD5hOQYJjTuWfyj9n26Sby3RkVQQAMD7pVPmPaZAPHYtQ2oaok31oIB2frDywcOavvyZiMkjr2SYAVt6keZoZI1MuHVB4Y8l/LgzvwDVOd18kNVpq1wA==
Received: from BN6PR17CA0032.namprd17.prod.outlook.com (2603:10b6:405:75::21)
 by DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Fri, 16 Jul
 2021 15:24:28 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::a5) by BN6PR17CA0032.outlook.office365.com
 (2603:10b6:405:75::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Fri, 16 Jul 2021 15:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 15:24:27 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.187.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Jul 2021 15:24:25 +0000
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        "Amey Narkhede" <ameynarkhede03@gmail.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH v12 1/8] PCI: Add pcie_reset_flr to follow calling convention of other reset methods
Date:   Fri, 16 Jul 2021 10:19:39 -0500
Message-ID: <20210716151946.690-2-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716151946.690-1-sdonthineni@nvidia.com>
References: <20210716151946.690-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 865eb03a-5836-4379-7440-08d9486dcd0a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1754:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1754DAE7EE02B0A2EAB12F9DC7119@DM5PR12MB1754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zJCDgyd9feG6NfklPjRuX9g0NOSpO/lORo0VQUm84UQxNmyCStyQkwTPxgw8zqa28EdsT1dsSB2kcoAIX23rBt9OQ72XIF9PxMoylPbfqKk38PnhnxnOjZnQklJ27k4Dhe2zn2zOWH5Qjj3ZVfy2/BiGSscasSYMDMj6UflkGKDZMkBufrVQeYuY/kEXS05cNr5/nYACSxZxoq5wX8lUbj6crPkPYyqhIIVetWZD5SPl702pOBBebL/Iyy86yMoItoS6uB8tUoPbe+N5+LAk0Ma6qFR0ASYfo45za22mVbF12WRkwFyY9+8vPivOp43LUivpALlWdHYtMbxSS+vYjbrGnA9gk4EbZ3kJxugvBxk9BF5O7JDEIZA7QF+ksU5jcwXbapWsWYNkaIc4ZDD7Ei3Oj68I11Wim+33UdF/u3OcWRY2aKN/nWlYvQs95XzHUC2XzAOfUdAuG+6Y8nc+i6ax7qnBtKDp3wy/zkjk40pu52d4ODMjm4VMCUB36+cjuGovA9Ctl/PoLxkgnc9pRIROaPXqkc80bukGEbyuWCwsln42aAySkPenrjCO7hAkDfhPxZXZA6CV6etu6cAl4ISQ81PfP+uzHGmYEZAJwgcwhNy69IXcAwSs6clva99XtBK+2EmDTilTlknL/R9TwljjIpVZ44D8rzOSc3GVi55G1PuOXQSlQkV7Ho6fZEA4GZtg/Ag6rOKVua6qre9ZeBd7c8TzlJqCqlmu0vPkXQs=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(46966006)(36840700001)(82740400003)(186003)(426003)(2616005)(7636003)(82310400003)(16526019)(26005)(7696005)(34020700004)(356005)(6666004)(2906002)(5660300002)(8676002)(36756003)(47076005)(336012)(1076003)(478600001)(316002)(8936002)(83380400001)(36860700001)(70586007)(36906005)(4326008)(54906003)(86362001)(107886003)(70206006)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 15:24:27.6686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 865eb03a-5836-4379-7440-08d9486dcd0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1754
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Amey Narkhede <ameynarkhede03@gmail.com>

Add has_pcie_flr bitfield in struct pci_dev to indicate support for PCIe
FLR to avoid reading PCI_EXP_DEVCAP multiple times.

Currently there is separate function pcie_has_flr() to probe if PCIe FLR
is supported by the device which does not match the calling convention
followed by reset methods which use second function argument to decide
whether to probe or not. Add new function pcie_reset_flr() that follows
the calling convention of reset methods.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/crypto/cavium/nitrox/nitrox_main.c |  4 +-
 drivers/pci/pci.c                          | 59 +++++++++++-----------
 drivers/pci/pcie/aer.c                     | 12 ++---
 drivers/pci/probe.c                        |  6 ++-
 drivers/pci/quirks.c                       |  9 ++--
 include/linux/pci.h                        |  3 +-
 6 files changed, 45 insertions(+), 48 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
index 96bc7b5c6532d..2db3fd5815c82 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_main.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
@@ -306,9 +306,7 @@ static int nitrox_device_flr(struct pci_dev *pdev)
 		return -ENOMEM;
 	}
 
-	/* check flr support */
-	if (pcie_has_flr(pdev))
-		pcie_flr(pdev);
+	pcie_reset_flr(pdev, 0);
 
 	pci_restore_state(pdev);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index aacf575c15cff..16870e4d7863a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4621,32 +4621,12 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_wait_for_pending_transaction);
 
-/**
- * pcie_has_flr - check if a device supports function level resets
- * @dev: device to check
- *
- * Returns true if the device advertises support for PCIe function level
- * resets.
- */
-bool pcie_has_flr(struct pci_dev *dev)
-{
-	u32 cap;
-
-	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
-		return false;
-
-	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
-	return cap & PCI_EXP_DEVCAP_FLR;
-}
-EXPORT_SYMBOL_GPL(pcie_has_flr);
-
 /**
  * pcie_flr - initiate a PCIe function level reset
  * @dev: device to reset
  *
- * Initiate a function level reset on @dev.  The caller should ensure the
- * device supports FLR before calling this function, e.g. by using the
- * pcie_has_flr() helper.
+ * Initiate a function level reset unconditionally on @dev without
+ * checking any flags and DEVCAP
  */
 int pcie_flr(struct pci_dev *dev)
 {
@@ -4669,6 +4649,28 @@ int pcie_flr(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
 
+/**
+ * pcie_reset_flr - initiate a PCIe function level reset
+ * @dev: device to reset
+ * @probe: If set, only check if the device can be reset this way.
+ *
+ * Initiate a function level reset on @dev.
+ */
+int pcie_reset_flr(struct pci_dev *dev, int probe)
+{
+	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
+		return -ENOTTY;
+
+	if (!dev->has_pcie_flr)
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	return pcie_flr(dev);
+}
+EXPORT_SYMBOL_GPL(pcie_reset_flr);
+
 static int pci_af_flr(struct pci_dev *dev, int probe)
 {
 	int pos;
@@ -5151,11 +5153,9 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 	rc = pci_dev_specific_reset(dev, 0);
 	if (rc != -ENOTTY)
 		return rc;
-	if (pcie_has_flr(dev)) {
-		rc = pcie_flr(dev);
-		if (rc != -ENOTTY)
-			return rc;
-	}
+	rc = pcie_reset_flr(dev, 0);
+	if (rc != -ENOTTY)
+		return rc;
 	rc = pci_af_flr(dev, 0);
 	if (rc != -ENOTTY)
 		return rc;
@@ -5186,8 +5186,9 @@ int pci_probe_reset_function(struct pci_dev *dev)
 	rc = pci_dev_specific_reset(dev, 1);
 	if (rc != -ENOTTY)
 		return rc;
-	if (pcie_has_flr(dev))
-		return 0;
+	rc = pcie_reset_flr(dev, 1);
+	if (rc != -ENOTTY)
+		return rc;
 	rc = pci_af_flr(dev, 1);
 	if (rc != -ENOTTY)
 		return rc;
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index df4ba9b384c24..031379deb1304 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1407,13 +1407,11 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	}
 
 	if (type == PCI_EXP_TYPE_RC_EC || type == PCI_EXP_TYPE_RC_END) {
-		if (pcie_has_flr(dev)) {
-			rc = pcie_flr(dev);
-			pci_info(dev, "has been reset (%d)\n", rc);
-		} else {
-			pci_info(dev, "not reset (no FLR support)\n");
-			rc = -ENOTTY;
-		}
+		rc = pcie_reset_flr(dev, 0);
+		if (!rc)
+			pci_info(dev, "has been reset\n");
+		else
+			pci_info(dev, "not reset (no FLR support: %d)\n", rc);
 	} else {
 		rc = pci_bus_error_reset(dev);
 		pci_info(dev, "%s Port link has been reset (%d)\n",
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 79177ac37880f..d99ef232169e2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1488,6 +1488,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
 {
 	int pos;
 	u16 reg16;
+	u32 reg32;
 	int type;
 	struct pci_dev *parent;
 
@@ -1498,8 +1499,9 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	pdev->pcie_cap = pos;
 	pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
 	pdev->pcie_flags_reg = reg16;
-	pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
-	pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
+	pci_read_config_dword(pdev, pos + PCI_EXP_DEVCAP, &reg32);
+	pdev->pcie_mpss = reg32 & PCI_EXP_DEVCAP_PAYLOAD;
+	pdev->has_pcie_flr = !!(reg32 & PCI_EXP_DEVCAP_FLR);
 
 	parent = pci_upstream_bridge(pdev);
 	if (!parent)
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6d74386eadc2c..90144fbc4f4ea 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3852,7 +3852,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
 	u32 cfg;
 
 	if (dev->class != PCI_CLASS_STORAGE_EXPRESS ||
-	    !pcie_has_flr(dev) || !pci_resource_start(dev, 0))
+	    pcie_reset_flr(dev, 1) || !pci_resource_start(dev, 0))
 		return -ENOTTY;
 
 	if (probe)
@@ -3921,13 +3921,10 @@ static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
  */
 static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
 {
-	if (!pcie_has_flr(dev))
-		return -ENOTTY;
+	int ret = pcie_reset_flr(dev, probe);
 
 	if (probe)
-		return 0;
-
-	pcie_flr(dev);
+		return ret;
 
 	msleep(250);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 540b377ca8f61..5652214fe3a58 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -337,6 +337,7 @@ struct pci_dev {
 	u8		msi_cap;	/* MSI capability offset */
 	u8		msix_cap;	/* MSI-X capability offset */
 	u8		pcie_mpss:3;	/* PCIe Max Payload Size Supported */
+	u8		has_pcie_flr:1; /* PCIe FLR supported */
 	u8		rom_base_reg;	/* Config register controlling ROM */
 	u8		pin;		/* Interrupt pin this device uses */
 	u16		pcie_flags_reg;	/* Cached PCIe Capabilities Register */
@@ -1228,7 +1229,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 			     enum pci_bus_speed *speed,
 			     enum pcie_link_width *width);
 void pcie_print_link_status(struct pci_dev *dev);
-bool pcie_has_flr(struct pci_dev *dev);
+int pcie_reset_flr(struct pci_dev *dev, int probe);
 int pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
-- 
2.25.1

