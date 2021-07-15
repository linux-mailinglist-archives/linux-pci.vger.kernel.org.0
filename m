Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930963CAE8D
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 23:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhGOVe4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 17:34:56 -0400
Received: from mail-bn7nam10on2082.outbound.protection.outlook.com ([40.107.92.82]:58720
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231192AbhGOVey (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jul 2021 17:34:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4ZSG4xCzwFm4xkK45Lzvsi1Utnu6aDIHryM/oIdFqdCB6PTXP4WnHMhhztAZwBpFFz53veNmgSIsUoFymXWeJ8IHhkVd2T1mhlc57UsXuRMH6PGaDv9tNYhlEmlCTMnCqLqZFIaflGqa94/vNJhMp/st0EFXOC+/2fw/Q6dtExrQUT2yiJR/bYeaBMy7ZAjysKP1cOwjG+dvAvi6LKFm9yGd1zBvW5EVC/Ubk2yJP3xt8HDbDVK5NTpIP9t02si9j3Zp9SnHRBJK9MLgUmIAgiTnkXiVo+frlqUY26Whtkyyi2jO7lD0K0pgVPr5ZKeC5uohMvLUqIbamb9LI782w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNGEdyd2PXOAXWZpuACvKtbKoIiSd/mnufsXFJddCvc=;
 b=SS+9RfpUF7rVN8xnB6IJiCDzNnbRsHEvXpRSwGTwX/GZyJ1Yfuf103fqRvVZT3MOQbaJg13xZHwNL74igO/l3zlLZGQNhb16SU3/5Vny8Lz0fpJSbXpsOefeMyEkRycwEUpIRvRIgFMwNeBpiWr9r9nH8Tx1Hwhrz040olpXJbBzcVg4Ia2odqTXdXJhTZFFXA12vguGXC2TCpO6GYtn5AMyGWtipd1zqHCZ3tOBLCuc09z1W6+89C487yj0YWj2Y4FTaz+WsAY7f/3F5eMIwfyO0+UKTkggyreuvi+NFM36y9Yu1RVtzvIvpZuSQ1bgK86yiNsle9MNCHENbCYmKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNGEdyd2PXOAXWZpuACvKtbKoIiSd/mnufsXFJddCvc=;
 b=L/uIJw0h6glMcG+WsxIouvKuvb6G/NrFsVE50k1VLUVn8tBxcjPmp8eiTwQ01oBD9sScX64vT3IErzYGrxROJeCJuu9FggZPuEiCxVFdt64oZo1uXLLFk18zOZL+vKhyrZuO0kVWqKfX8HWDJVhnVeIfUVGJOYX/GCqS6BckN6hDX+BHz8zIDzEUT5FQHQ1q+Zb46H4/QxQI7Tj5aIb/fVdKS91x3GuBA7jcEYSpS27TQdFa1OvHLEmwVDVOB6DV1Kz1u3RoZx0Sm7x/MJ+tU6/8wscvM3dTeyeuI6TtVjG92+ZOmhoIpt4uyGwrzlsmEp+eUq/wLGXqD3EE5Xo2DQ==
Received: from BN6PR22CA0034.namprd22.prod.outlook.com (2603:10b6:404:37::20)
 by CY4PR12MB1255.namprd12.prod.outlook.com (2603:10b6:903:36::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Thu, 15 Jul
 2021 21:31:59 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::8e) by BN6PR22CA0034.outlook.office365.com
 (2603:10b6:404:37::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Thu, 15 Jul 2021 21:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 21:31:58 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.187.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 21:31:56 +0000
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        "Amey Narkhede" <ameynarkhede03@gmail.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH v11 1/8] PCI: Add pcie_reset_flr to follow calling convention of other reset methods
Date:   Thu, 15 Jul 2021 16:30:53 -0500
Message-ID: <20210715213100.11539-2-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210715213100.11539-1-sdonthineni@nvidia.com>
References: <20210715213100.11539-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21670185-f272-412a-a799-08d947d7fa20
X-MS-TrafficTypeDiagnostic: CY4PR12MB1255:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1255E721346A25F4E356F783C7129@CY4PR12MB1255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D1hTivFfKeSCHdsS4HX7t4f+jFI9U2EchJGfO9aXtxqq9kHc2zN8pnWh46y4yblbZfItyM3d9kbzuVV6mnmkgeGciXDgv9toUsg+pGR+wYujGUuako2VfOKWhbqdm0LScVXbcCc544ABPT2v2CcQuGKy94V6i/aG8dzpLBzfgV7C7K2AF3inN5e1CQY+1xYetimm2V5P4VhNWn8OkrbkpGn26znllBwo+t051P0o0VwMAPAWA24y9EpkNIls1p0/9nNPda3Y0cfTdQ+nnwrqepfOGzjDghGLRw1YZ+Jjr1mbhcVN0VTX0UFdkzINk1PYGDYYVqUxqUjAPIs0x9wgNS5H7ibOnZndKIHWZ6jiffyhv+55N2oRfQ7sQ6JW1cQaU7mmFIWmDFVZMc2z3iS2aE8MIRMiAHPN9zgdRaMZl05Q8RB9vwGJUQZEGOKVpY/9jCskuJLDDMYV2Zs2/rAB1XQzRg10ASHkiWQMFWpT+pagq+QlniRCp75MLvaqOuzAp6C7ilZsd1EPZUtT6eKPzRtnPctF0/24H9km7buvEzrkelzA0RmgCoyTBo6URgVlVO77eJZNM6aZ29V6AzGnePWmi9kdEm5DD1S9/ZAGtdMeG2anKgqT3qRyPCYUlSeevu72c9gjJre/SAMXnASYfMcT6QV4KIg0suhBdCKj1CXHJTqC2XQIZw9wPHYaWKOy8zL445z4kcjM7n9e9tSfLY09FxJUlJ3nQISm09WvAD4=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(36840700001)(46966006)(70586007)(2616005)(6916009)(6666004)(5660300002)(336012)(478600001)(86362001)(16526019)(4326008)(70206006)(426003)(26005)(186003)(36906005)(316002)(34020700004)(82310400003)(82740400003)(8936002)(36756003)(8676002)(83380400001)(7636003)(356005)(36860700001)(107886003)(7696005)(54906003)(2906002)(1076003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 21:31:58.7261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21670185-f272-412a-a799-08d947d7fa20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1255
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

