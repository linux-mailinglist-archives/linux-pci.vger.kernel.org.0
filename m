Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FC236E2B3
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 02:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhD2Aui (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Apr 2021 20:50:38 -0400
Received: from mail-co1nam11on2065.outbound.protection.outlook.com ([40.107.220.65]:19744
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229479AbhD2Auh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Apr 2021 20:50:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7rI9ah03PAMnbWuizCskj8IXhHRRHA2gwdMONBzrbVu7yrY9FJaimQIfRsxjXMMNb8JNIkOlAIU2dfAht6zb0Rp5Z0I52Q2ENwILqe7Yxag1kKw6vU7G76vdGHV98JoDMEND2M0aFCUv/AyWnVGEfoF8WCg3aka5nLvoyq/TQXLsKYl3XEUkWGuss7vR5X3iWgX+0a72rwpuSnUHqfnjyMX+seRiFWi2sCvMFP9J5fb8ngdaTJXVEYlpqgb3d2/qShU9FuKhdgkGSwG2qBVAk2UdfskSdwE424tlPGSKadD+5yDXZhXamkSxOup2Aq4Lpv7ht75AwWjVqILUDUVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zv0eB99yKphyaPeRkgf41ECxkdn4hM/x7pzwfWkxcgA=;
 b=lsTcUfRzgyvkDdqEMA6Y/Yn0E3HL6G7OWTWnhZ36cxHnLOHyQlSzcy2/pNmDXdCEmiyUfraegLcI8omLYxxxo1jC1mKpgKCmTVQ3pJXs82v5DJ7W99iQWFypIvWghNnJhXsxzKGI7Tu61sdOM1HMnYCOXsLIMiGJ0knbDvaiUPl20NrN1046yRGRkf5Tp5i/rFUDexyt19SDT1WOqk4AI+EUpm0xQ3ChaTEv33+xYl/LC8I7+EKnjDJ3neg46bkdD33WUdCWfF9nBKVEnla9SHRaqlbKGKI0sT6jSeUSDinikDyq17sv8yQzHcoeJSFvRw5lIKMYJXnCBeuNW6knEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zv0eB99yKphyaPeRkgf41ECxkdn4hM/x7pzwfWkxcgA=;
 b=Yxy7f+1H2OH+1JnJZ7sFAAnk1gYzco8t43naac/CEYIWf8OWJOafU+ipepMoHLbVZnv/dENGxoC11b9qSVWV+JSwnEhNuCl0sFUJyS3ZrFlMdhxQYseA9uyLPXT0Du3TodLoqBMCg73IlGcCLZg7XQ1wFUjIAQnrUI9RpK4QI/nWmrwgdjxChfuQMaD2JDl4JJH6I5a8yqlXyWqBDOEWfrNT/rBy66VCuO0zF/RL1LyJHdLgoyvYMrSV7BZKOR/N+0RvLetx6ogMIlb1rNEMA4aBXNzBR0XZy3PDo8kL+C6fl2CKGIOsItcFdh3VlqsllB8XN1p37V70tTXIksNPdQ==
Received: from BN9PR03CA0238.namprd03.prod.outlook.com (2603:10b6:408:f8::33)
 by MWHPR1201MB0061.namprd12.prod.outlook.com (2603:10b6:301:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 00:49:50 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::79) by BN9PR03CA0238.outlook.office365.com
 (2603:10b6:408:f8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Thu, 29 Apr 2021 00:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Thu, 29 Apr 2021 00:49:50 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 29 Apr 2021 00:49:48 +0000
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        "Shanker Donthineni" <sdonthineni@nvidia.com>
Subject: [PATCH v4 1/2] PCI: Add support for a function level reset based on _RST method
Date:   Wed, 28 Apr 2021 19:49:06 -0500
Message-ID: <20210429004907.29044-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d62703a-0023-4235-0348-08d90aa8b1c1
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0061:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0061581EC8D9C90E42C486E1C75F9@MWHPR1201MB0061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iDJC9EoqQ/cpLMnA/Ni+Q4vuzbwkLA5IFCnC/m0pBL1wyWYUC8Bxwxee1Twi0uGMiVt8ezDRnqwON4ga2/AXx2E7r5c20YAzxYwWCxeYNxQfKqPaF7025NZsPedYeqJ035wamBmsKOduyDPBRc7Ndq/1JHAfnb+G2nOeHwS8R/HkDWofdWzinmbWHjIQAlJZwILLfrvj3eY3NUsL4+IeWm6zJG4mnIJJUoyuNFTM8MU0HNIWILKsun1a/MFbJQFdXowWOJOEpHv5YatgmscU/WuH4io62+j9Gk6QeNgdW/nN17E8qP7/TZPqDzst+WTmEdqCu9H11iYiyZc0pfofUbIOBRLRNK/YgYnvLcYDKdWWPJVko8/DrrqKC9XCeEEhABCt3Q+29MkdHrdxwYoVUncck8V2/Peo2qzWbBpVFOWBfhpQGlXIrvMljmzbhBtrFpvDbybYN2VnmCpgS10nDbtfT28r69MWo7y51n4A0ujsXZ56SGxr9y5ByBhNWAx1JDEBs8BhcTDWAx89M//PbPjjjFjX4Humc9edo0OzJPBTPmJ7pKsDlCReb6G/gtTNBkeco19LcX1dbTecEXz86cc58QAgWEjmuGPkxm6nKPNdj4mHxNDiyzJrDZz9CMF/9VmoGzSYrIunAwfLYlLGF1MRyQS+nnFj7Tq4IJPVCxbLmiu7LqLuWKhzh9xzbEM4gXUxhx/Skq1ycYtQ3+IyYV6/aaHTDIyw0/iHxtJWcXs=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(36840700001)(46966006)(8936002)(70586007)(36860700001)(2906002)(356005)(4326008)(8676002)(966005)(1076003)(107886003)(5660300002)(6916009)(47076005)(83380400001)(2616005)(16526019)(316002)(26005)(186003)(54906003)(6666004)(7636003)(36756003)(82310400003)(7696005)(82740400003)(426003)(478600001)(336012)(86362001)(36906005)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 00:49:50.0876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d62703a-0023-4235-0348-08d90aa8b1c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0061
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The _RST is a standard method specified in the ACPI specification. It
provides a function level reset when it is described in the acpi_device
context associated with PCI-device.

Implement a new reset function pci_dev_acpi_reset() for probing RST
method and execute if it is defined in the firmware. The ACPI binding
information is available only after calling device_add(), so move
pci_init_reset_methods() to end of the pci_device_add().

The default priority of the acpi reset is set to below device-specific
and above hardware resets.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
changes since v2:
 - fix typo in the commit text
changes since v2:
 - rebase patch on top of https://lore.kernel.org/linux-pci/20210409192324.30080-1-ameynarkhede03@gmail.com/

 drivers/pci/pci.c   | 30 ++++++++++++++++++++++++++++++
 drivers/pci/probe.c |  2 +-
 include/linux/pci.h |  2 +-
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 664cf2d358d6..510f9224a3b0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5076,6 +5076,35 @@ static void pci_dev_restore(struct pci_dev *dev)
 		err_handler->reset_done(dev);
 }
 
+/**
+ * pci_dev_acpi_reset - do a function level reset using _RST method
+ * @dev: device to reset
+ * @probe: check if _RST method is included in the acpi_device context.
+ */
+static int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
+{
+#ifdef CONFIG_ACPI
+	acpi_handle handle = ACPI_HANDLE(&dev->dev);
+
+	/* Return -ENOTTY if _RST method is not included in the dev context */
+	if (!handle || !acpi_has_method(handle, "_RST"))
+		return -ENOTTY;
+
+	/* Return 0 for probe phase indicating that we can reset this device */
+	if (probe)
+		return 0;
+
+	/* Invoke _RST() method to perform a function level reset */
+	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
+		pci_warn(dev, "Failed to reset the device\n");
+		return -EINVAL;
+	}
+	return 0;
+#else
+	return -ENOTTY;
+#endif
+}
+
 /*
  * The ordering for functions in pci_reset_fn_methods
  * is required for reset_methods byte array defined
@@ -5083,6 +5112,7 @@ static void pci_dev_restore(struct pci_dev *dev)
  */
 const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ .reset_fn = &pci_dev_specific_reset, .name = "device_specific" },
+	{ .reset_fn = &pci_dev_acpi_reset, .name = "acpi_reset" },
 	{ .reset_fn = &pcie_reset_flr, .name = "flr" },
 	{ .reset_fn = &pci_af_flr, .name = "af_flr" },
 	{ .reset_fn = &pci_pm_reset, .name = "pm" },
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4764e031a44b..d4becd6ffb52 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2403,7 +2403,6 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
 
 	pcie_report_downtraining(dev);
-	pci_init_reset_methods(dev);
 }
 
 /*
@@ -2494,6 +2493,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	dev->match_driver = false;
 	ret = device_add(&dev->dev);
 	WARN_ON(ret < 0);
+	pci_init_reset_methods(dev);
 }
 
 struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9f8347799634..b4a5d2146542 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -49,7 +49,7 @@
 			       PCI_STATUS_SIG_TARGET_ABORT | \
 			       PCI_STATUS_PARITY)
 
-#define PCI_RESET_FN_METHODS 5
+#define PCI_RESET_FN_METHODS 6
 
 /*
  * The PCI interface treats multi-function devices as independent
-- 
2.17.1

