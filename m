Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEEC36952B
	for <lists+linux-pci@lfdr.de>; Fri, 23 Apr 2021 16:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhDWO4H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Apr 2021 10:56:07 -0400
Received: from mail-dm6nam10on2058.outbound.protection.outlook.com ([40.107.93.58]:38370
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236957AbhDWO4G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Apr 2021 10:56:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coJ08SSBXURr2Rmqdl2ik3oujgfZlfbqL1UwCaO0G7rhej+WInytP1YrUAPWTZWD05EkcsrKNlEtMP+5Ia834YlWH88GEQ0jgpm1eEcohrxRnHAAeBmcA9M7brmiPwFV6HpesIFOGUmdEnKYz3X7UDRExKyz4gc8Z/Ov/FW9TtuBsRxYNnf/JWBPd5mAd735wjys2Ez/+5NtM10GeAhlGE5AhhZzV5N62YcONPLTl1ATLg1ztprayaUaJeXVNHOD6y7OOE499nP1tvxyljSEQfDw8PF+fZRWI4n/oLT0R7nq9XfD0HE9CYXjkY2BKHhaqmpbiNM8igfLEYIMjtGaKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DG2OwK+ClbBwNRv4zd8FiLZoQSKCA6+7DKrIzcRGrd0=;
 b=m/Y4cXcNf5H1i8BY12z94iJ8Af0YKS/YSmwSO/Cl2zzY44C/9sZHJnvVTfTr2K/XBaioxbdeLtx8IjcQXpFsVWROuz5wFe9eX2EuS44tQXWMFEDZ2QT3yWNeGjvvFoVMnGSMKI36F/UUPtgjAV4Hd63fUGarfgPytDSJsGh24koIHapr71u5EgnQOGCNTisHo80OPmCCFaE1hxu4xP3zwwJRLWyh0opY8eMI67jE7I48S4FqB7XPG1lrKyYJ5aAqXaN3pqoPOQhU8vyRN3aj5m//jKi+PY5T52iFaUQIhGdUSW81assgKY8EvWuQSft49jmatSQJKZ5ONbX1RdXiug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DG2OwK+ClbBwNRv4zd8FiLZoQSKCA6+7DKrIzcRGrd0=;
 b=gz66T51i1NeYuOocF0J6AY4q+m7EANilhHzxwHHcOM6qn14jQSqdYIVqVmoxC05vG5DrYkM/T96HDUWoOC5Sg3GH0KPNB564nWPNxIfO3YPTXHscka6bAoxMbrQNH49TQH7z5qV23GguUtbnZSt0YHf6me6LLW1XJukNaP5jsQ92XkIDkaZacIw/kO79qwQtdhRwaV8GvEF82UI3Utcc62zvaiSouc9Lu7KGsLoXf4r1n/GXMwkDSs4QGAYjbWIe6bVKHyox7MhxfiglndjZTp/63lEkftu2OGWEWiJFVna3jf3JwZUDNCDWhf4cNtny5tLMdNLVlLusqCKATJk7Sg==
Received: from DM5PR19CA0023.namprd19.prod.outlook.com (2603:10b6:3:151::33)
 by BN6PR12MB1330.namprd12.prod.outlook.com (2603:10b6:404:1e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 23 Apr
 2021 14:55:28 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::4b) by DM5PR19CA0023.outlook.office365.com
 (2603:10b6:3:151::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Fri, 23 Apr 2021 14:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 14:55:28 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 23 Apr 2021 14:55:26 +0000
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH 1/1] PCI: Add pci reset quirk for Nvidia GPUs
Date:   Fri, 23 Apr 2021 09:54:02 -0500
Message-ID: <20210423145402.14559-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8712a0da-26a1-4891-2e64-08d90667d571
X-MS-TrafficTypeDiagnostic: BN6PR12MB1330:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1330C835F5A6F1DCDB29D960C7459@BN6PR12MB1330.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7xZy/jOBrfGAax489o2FkIWq1sWJRcxWJ4WLuhmtE71crNkqN9HbERBR5NaQlxhPmBxxsdOAwLaoDJL/UTyw3UC8yttf6G8VBlpYGZOhyHzmrrbCASRY3ZkBgqC9/Pqr4ul44M945v6+IeexuQzLvSKTYgbQ8tiFhL4Zn46t1j2yYDp7/ocwI+qQ7c3sNqFUXnwtCZlbTiZC8J3y0gjCQDPYmHjsqcP0QztCnqxTiMvTrO2hb2rn7p2unZgWlLhufnKEbb7IfoKdjYzp9ILM8P0pMxN/U8gPtqVnMzLzOnDSwIb2jSZ5t5eE0Yh+Fnw8wA+aPSsDGXEbcTVzLUqrrVKRwC7sZJ8naandD8aYH2Lgjarw7SmtGnKiG9CACIM+bxL2XFBtnlLXLMq2vAyIOv2PqDZVNn+NIDAxn/O7Yy9H/waTneCeDTSfF35MP+dhkAp+tPcFcIFfy/5Ykgdxk49YFGq/wDyVQLZe5kT0f4HpPS21m+X/Kp+h3b69M1BqZvDG8DO44yu9oTKd+e3jodPtZw0DkjBbMNranujhQ4pRpgqpLyKBZG4QGSZjJj2NbFjIL6eGfE1j4+APQZKaq64RDP2+fdmWIaDNkLNzMJyH9/FVQTNRp503SS2mgsMxLqOUydIrj3PsOZVIo4fIIqEyE6wEHsz/ecnd70FBH+Q=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966006)(36840700001)(82740400003)(54906003)(70586007)(7636003)(70206006)(47076005)(7696005)(36860700001)(8676002)(4326008)(6916009)(16526019)(36756003)(5660300002)(86362001)(356005)(426003)(186003)(336012)(26005)(82310400003)(2906002)(83380400001)(6666004)(107886003)(316002)(1076003)(478600001)(36906005)(8936002)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 14:55:28.1048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8712a0da-26a1-4891-2e64-08d90667d571
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1330
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On select platforms, some Nvidia GPU devices require platform-specific
quirks around device reset, and these GPUs do not work with FLR/SBR.
For these devices, add a quirk to handle the device reset in firmware.
Platforms that need the device reset quirk expose the firmware reset
method for the affected devices and the GPUs in these platforms have
a unique device ID range.

This reset issue will be fixed in the next generation of hardware.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 drivers/pci/quirks.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3ba9e..23fc90d209c2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3913,6 +3913,59 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
 	return 0;
 }
 
+/*
+ * Some Nvidia GPU devices do not work with bus reset, SBR needs to be
+ * prevented for those affected devices.
+ */
+static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
+{
+	if ((dev->device & 0xffc0) == 0x2340)
+		dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
+			 quirk_nvidia_no_bus_reset);
+
+/*
+ * Some Nvidia GPU devices do not work with standard resets. These GPU
+ * devices are only in select systems and those systems have _RST method
+ * defined in the firmware. This quirk invokes a _RST() on the associated
+ * device to fix the reset issue.
+ */
+static int reset_nvidia_gpu_quirk(struct pci_dev *dev, int probe)
+{
+#ifdef CONFIG_ACPI
+	acpi_handle handle = ACPI_HANDLE(&dev->dev);
+
+	/*
+	 * Check for the affected devices' ID range. If device is not in
+	 * the affected range, return -ENOTTY indicating no device
+	 * specific reset method is available.
+	 */
+	if ((dev->device & 0xffc0) != 0x2340)
+		return -ENOTTY;
+
+	/*
+	 * Return -ENOTTY indicating no device-specific reset method if _RST
+	 * method is not defined
+	 */
+	if (!handle || !acpi_has_method(handle, "_RST"))
+		return -ENOTTY;
+
+	/* Return 0 for probe phase indicating that we can reset this device */
+	if (probe)
+		return 0;
+
+	/* Invoke _RST() method to perform the device-specific reset */
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
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
 		 reset_intel_82599_sfp_virtfn },
@@ -3924,6 +3977,7 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, 0x0953, delay_250ms_after_flr },
 	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
 		reset_chelsio_generic_dev },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, reset_nvidia_gpu_quirk },
 	{ 0 }
 };
 
-- 
2.17.1

