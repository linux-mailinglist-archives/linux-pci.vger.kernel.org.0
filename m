Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211F6370412
	for <lists+linux-pci@lfdr.de>; Sat,  1 May 2021 01:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhD3X1j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 19:27:39 -0400
Received: from mail-eopbgr770043.outbound.protection.outlook.com ([40.107.77.43]:44708
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231462AbhD3X1i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Apr 2021 19:27:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSSf2NODwsWK++Vle61P2ls+rte1Gc15BpX+y7Trp/YnT3nGk2W+DDyv2Mhnc4wYEApWZwv6rWBDxsd/5Ji5hbR3DB+OQj5OKqMrissR1gaemvAyrnuXAm4uN7dj1o9bTFYNG94PM0ZrYpk0YvMGomon52ZqktHVKpN1aVEQy2SdrqBLxyZ/HWPCKaWlsghyhDGbXJTPJU07Fa8mPMxejzRNZspsqBqQ+POF7LikpzaF6fM58bTzmaZG204sdDf8Tn5QLM66LBAeiviR5AfIGP8zFV0F6KkcdoitpbicDScIovaN2shiK4JgCo0TN1LVn4u1saAivkd2jRfQfPfb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYD8zmkuXkTRZTntgEEezk0FI9TU9oRWlazn5CklR64=;
 b=nFaQILexp7ss5w1n3U8FTr3rm4XuuqNQHfaBF5R1WG1oOlJHNSr0AklwSJKMWakgWehOcD/gEccT1vsicCxHZXG1zJ9x4II8u46Pxeb7mn8d78E6aanj1sIqmOByNZtKdfUjvCyr/QVTvOHFLrNNM8VORSzkEvvZkMvGTLSD+u1AH4GuXP5COdXPjP77q/tHqPZC/UeJN3zIGwR7B8Mj5yhusAbeK6VkBQLOalmbPEkf/0YrRKr/gULn721hHrsSpD1ZJ8h7SsHzU5AV7PEJWclyxbXEOU7ztbhZVIkKztGT4raNuEs0xxNoFfp1P6FpiY2RVqsLB31C5Q6QsMzmrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYD8zmkuXkTRZTntgEEezk0FI9TU9oRWlazn5CklR64=;
 b=nY4yLkTxeiA5sq032G7pFTjUq00l9a5rN+++AzR3dyBKNPfKgfxugXdDn0+kHnTR/aaHWGFCSA5oKUdr+f1jXZ8XwwtWv/nYKkt4vG5ws5C5Jk4kg6czExdv8RM5wPgLo7GMlftsee0n4FfRHZzpDSuJRuZQXItp888Sss3LtguBww+/PPtEaywdY0X+3U+BVjWdhqu3aH+oQiIVYLmQ2vG7rdsiKcke/JRrrqW3G1P7VWBwKhRAPGsFcYrzIjnriAMD0F/JQdlNr/pavXSNhT34RGEuN/e89faQL7h+6L75tEdwLTaOzjEey11LSLDFa4puvV4meN0yL0ifdneSuw==
Received: from BN9PR03CA0655.namprd03.prod.outlook.com (2603:10b6:408:13b::30)
 by MWHPR12MB1535.namprd12.prod.outlook.com (2603:10b6:301:5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 30 Apr
 2021 23:26:47 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::5e) by BN9PR03CA0655.outlook.office365.com
 (2603:10b6:408:13b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Fri, 30 Apr 2021 23:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Fri, 30 Apr 2021 23:26:47 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 30 Apr 2021 23:26:44 +0000
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        "Shanker Donthineni" <sdonthineni@nvidia.com>
Subject: [PATCH v5 1/2] PCI: Add support for a function level reset based on _RST method
Date:   Fri, 30 Apr 2021 18:26:23 -0500
Message-ID: <20210430232624.25153-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81d3b72c-e77d-4626-6d87-08d90c2f6cb0
X-MS-TrafficTypeDiagnostic: MWHPR12MB1535:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1535D0D3D45FC2F877088633C75E9@MWHPR12MB1535.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SBnk62MATruWu0TnsWgbCKvbnQ6AQxnurl57xC19wJgzx3cG65Ofyk6P2klqyC08kSaRg13+SF89oLDyImKsrcCxHozZ8F1XCxYpnsXlJ09Q10vulICSqeT7X8s7KpZTTk1+0F25mje2LWhWCPNfXO8mDQKAgaueugH1X3LL0VzJDhtGE4NA3E44G372V4v86eNcVUd6MhxdphwK/BRnTTP08LWC6aERJmJoVnHcxOtBP3iDwRVGBPaUoy3sTyEy72FXsmrpaVeYRHUF9VSmNuaTRnWmLq/95z6TeqVxle5O60yJ9skNVuuFlAHGa1gVF2v1i+Zp80XmqwcPVTGvYlC42G1/YHzL7BqbSbyP+CJgNcfjZDzKaa/hiPNYEaFDI9bvm+KzpwJaTeKzXxhN9/8bDaJ10jf1eetibVP7kF3/QZVVNzgkaGFLLOWfTTQOLHdXKRz76U7IQGPmmcUorSpPkMGLcf3qWOqXL8OGmADeBVaXpgqODdiWkGkdl9tnlDnk0f7JecvScRdxhzV/WVANX8F5uBHrLzL2tjj01lFxHMpx2lTeG8cZeiLP9XHlbc9Xrw3W/IUjXbUnaCPEJWBStn3e5FDRgx0x1lpR0zZWJo6JcNp8BW78jfkPSncWinj9aV7pOd+xeqHjzJyRRQfCSobIzrsBUAd2GdMovuuMw6jZWpoKAETE9UUaS93v2K2QGkC1cQZFkGKeZiJUIbhLDXvviAh6CL490xiJsQw=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(36840700001)(46966006)(107886003)(7696005)(36860700001)(54906003)(82740400003)(47076005)(8676002)(4326008)(478600001)(6916009)(316002)(36906005)(8936002)(70586007)(36756003)(2906002)(336012)(426003)(2616005)(16526019)(5660300002)(70206006)(7636003)(82310400003)(26005)(966005)(86362001)(83380400001)(356005)(6666004)(186003)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 23:26:47.4464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d3b72c-e77d-4626-6d87-08d90c2f6cb0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1535
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
changes since v4:
 - change acpi reset method name from 'acpi_reset' to 'acpi'
changes since v3:
 - rebase patch on top of https://lore.kernel.org/linux-pci/20210409192324.30080-1-ameynarkhede03@gmail.com/
changes since v2:
 - fix typo in the commit text

 drivers/pci/pci.c   | 30 ++++++++++++++++++++++++++++++
 drivers/pci/probe.c |  2 +-
 include/linux/pci.h |  2 +-
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 664cf2d358d6..d39dba590583 100644
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
+	{ .reset_fn = &pci_dev_acpi_reset, .name = "acpi" },
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

