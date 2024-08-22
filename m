Return-Path: <linux-pci+bounces-12045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BD295BFC3
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 22:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901271F2061D
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 20:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB58414D6FE;
	Thu, 22 Aug 2024 20:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2uiLj2H3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445591CC8AC;
	Thu, 22 Aug 2024 20:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724359365; cv=fail; b=WtwH8vef87ME59OqtR0mXf2Xwae3E+04Q3OtaiccWuNxXut71i2QcpH9h/TlwWoihwfEGExhCtgnCkJohXD6NaZPkagjd5V0dsqB9RlIL8GK8QEtFRh5xU1/q9tWEHktWvjtafoyCmrswi6HnN1ZIIbU51lXnqk8gzjDBEvewWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724359365; c=relaxed/simple;
	bh=EfUdOXOHmwrEOJ7RZBur6oecPHjnFsGocyzVQ2AWUhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGmG4r9GjVnrZND944jgHQ10P1PcYqXTdPRIYKWCBlmV1MTo7xVgUVhEMfhABvrq+tT7O8Yz69IyCQ62+f6jI4eecA98cLf5CcjARIJkCh/BHquVIGz6kuO5xj4q0gLFEl7rCxUuyn31wtGBcLS3gOO5o/l8A6nPXzgqHBSJvhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2uiLj2H3; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltSaKkHSNfLCW3CTXW8xiZnZEx2xIXhnKKS8YQ+0KvwSea4iP8x4hPDXsHkL5HAuIsrTG8gg23yBEft8mtqjEQBStIUdkoBHsLpe7vAdDiH2zTJeDvwIOfvckxczJ9l1XySd2qWGtKMEIZEzDHdn+IsWrjxaVQNkF1FkQ6Xvyr3OY1v+vUzqVFNxFeF8Bxg6Adsgh/shEoeyUHrJ8o/u78UraXjpPqwT8B+XXRvhyc/D1OP9iOhmaJeFVcq4YiBOE7OqzMxRAQMQs67EAYQD/E74JvLG3SEx1m+UhnoPoWVUSU8/HFyWhZPIpUp3e7/eelqfDqatpOsEoP1Y2tu8rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFxjTIRgbaMpDJrHdXXnF2MLO26fcyA8SkAVyNDXhUs=;
 b=fxqYleoK+iOnmNDJOmj5UPbhEfpNM4XDfQoFNIhcVAc9KYwx/WIwryesRYJtXJn+U46RrXtrVm015dtSqSdClMwzOYOCXHVj3gCD9lnWZmDJ97WgkrPrOVMqm2xp9njcPmsb1v0BY44+ZnIyDRnROUTM59/41Thla3TqmwFy02wYJ6a1ABw+lwIDG9QU/EFskbWtreBk2/+vFN4yOSNT/bm73UMDQqj6Mr5iwVt5wpb/Rn26/Ud+Vs2kRR2qhvn4DdvqqYaoCjusw4njqnjPjSeQFBYPrlVeuMuvC+ms6iOSRV//oo76NT5xiLugqbIny7Tnn0Q8c74VGknQLths2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFxjTIRgbaMpDJrHdXXnF2MLO26fcyA8SkAVyNDXhUs=;
 b=2uiLj2H3ROfisczne8p+WM+7MUreaHblrvKEjb3Q0xV5+0b71TUjbHpVK2D79r9J/tN6eqJlC59Kg/2m1P34egtOpEhPCbzPYBwM+nDwsWzdRqpVTRCJ+UAL3tDuY0wKaPFywQUSskaEu761zTN+YxecnNMRM3cB53A7PZmnnuc=
Received: from SJ0PR03CA0362.namprd03.prod.outlook.com (2603:10b6:a03:3a1::7)
 by SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 20:42:38 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::3c) by SJ0PR03CA0362.outlook.office365.com
 (2603:10b6:a03:3a1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Thu, 22 Aug 2024 20:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 20:42:37 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 15:42:35 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <Jonathan.Cameron@Huawei.com>, <helgaas@kernel.org>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>,
	<vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>,
	<bhelgaas@google.com>, <lukas@wunner.de>, <paul.e.luse@intel.com>,
	<jing2.liu@intel.com>
Subject: [PATCH V4 06/12] PCI/TPH: Add pcie_tph_enabled() to check TPH state
Date: Thu, 22 Aug 2024 15:41:14 -0500
Message-ID: <20240822204120.3634-7-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240822204120.3634-1-wei.huang2@amd.com>
References: <20240822204120.3634-1-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|SJ0PR12MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: 592de166-6ff1-40dd-d62e-08dcc2eaf54e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HNoiXdXLpvA2Wf4PmI08c1HeSJ3vj+imOIbZ21pK/jfDLVGGrWJI78VMZC3I?=
 =?us-ascii?Q?K+0aa/kJhlnjovV21lckj4sH65mYQ/+jdtaZ+RjM5D8fc1A+avpvmktfFdgy?=
 =?us-ascii?Q?it+Rqinl6u1EuypT/unUqBUcx/1Xx7bCqqUewV3lFJ3yyApdRaRHt7WkWWyi?=
 =?us-ascii?Q?qSvQ3ead66SOp7dubkvt/yVR8F7KUD5QHaJYVvW5p19YyDW29H4D7fjX15vV?=
 =?us-ascii?Q?sSas67OyiYmZzJ/WEm9OhsJR/PPgYHFPQu9p/OUODdDb+XjQ++7sjt0kkE/I?=
 =?us-ascii?Q?ucWRjhItUb3oINEbzeBULcE36oyaiGucI/qkyJImmbO2PIUfBm/VSxvl6d4m?=
 =?us-ascii?Q?SVzvUmO2ZYhCEJZb57CGEQcUzUB0B7aNyNbzgEGlO/TEMKQm3T5phQt3mIGV?=
 =?us-ascii?Q?8C8Jj0mBrUQA4Rxiq7tIPKrWq60Pwf3hNOmdM6bVjOBADkOPCST8J2JR+3Lq?=
 =?us-ascii?Q?vTm2bVdultU1BE6/RYYkiUyUXDDOSuIufteKIovVXgtbaUNM1EZBUwqZfcRA?=
 =?us-ascii?Q?yIz12grRbjFHI0MuoQHrmNC63PjdprCOcjMQiy3XhANX8M2u0swUX3tOXTE4?=
 =?us-ascii?Q?sZz4BkpBm/VhwXMpMUH4D7jU6sjFl+5yDylHWcCIp0Xbl2QMxv4lffBkZEtp?=
 =?us-ascii?Q?w9tVq40XpoIShUSXYUVciULuNJF/oOFcPsTZIRbv5kW568oKCV50F67z+/+G?=
 =?us-ascii?Q?96oQ0VWxvetB9G6+/tXgK3dp7Yi6m8tFfzz+EvAYQlLWywB4RSGTGfShea+t?=
 =?us-ascii?Q?CWg80cQOSgnh5RGy2hpsSBAbnOKy6iOrCupZmsWLzGF1InB6CIVGMJyJ2HRm?=
 =?us-ascii?Q?mTbH+XcFLJWMoSUynIQZH6uOVc5Jj87nSi2GlRyLAKIhfVk0pykOpp4s28zx?=
 =?us-ascii?Q?L3NU/y9CeKyYkkf+jubslUL6WxsjVhO1xvIwFj8xBSIhJqe0hVQhlUL2JOEs?=
 =?us-ascii?Q?jxokHmnVoWaIyJGIip0nfqwBode/mNLtdo9nWhb7y4m6fX1iuSWmAsQK7Wsn?=
 =?us-ascii?Q?X2gtf7JIcL0Z82TH4swXU2/RryNk/yFl6Q9sbwAzox+av/tiYkpxsUA/neQm?=
 =?us-ascii?Q?kKBRNyjZcDs9JCcf5uKGvUtsCjGk12JjXVpK2Ld3aQG1hXZ2EZi7FeQUk+yk?=
 =?us-ascii?Q?KX6zn1VMlZ+ZxLgGtLYaFJypozUiQc1BFFen0kT/A/H5vB6LOIGwKY6qLmYw?=
 =?us-ascii?Q?aykhsby6+eihHfuZXmoeKweNGrcnIJwPK3j5jqvDV83lLSZtBvikLJ0vhDcT?=
 =?us-ascii?Q?q3NsIi5X1WRCKg295dTNwFgX0gp2IsPQCbsFyCzm6Z6wSk5vMGm53j/BP1WT?=
 =?us-ascii?Q?pdw77wGnvQU/TQ6KQUCVCankX7Ludx2I8HoM5yPCL61J+NuGHt1R/DhUKlvN?=
 =?us-ascii?Q?36F/qzyU9tzzrh8pJSt+fJ9dUZ8B1aRHxM/HeQIjHXZdkc72hmV32QAkGC7M?=
 =?us-ascii?Q?ouBRa1ScX012A518Dv9e/fMaEwtR13Gi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 20:42:37.2550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 592de166-6ff1-40dd-d62e-08dcc2eaf54e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6967

Check if TPH has been enabled on a device.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 drivers/pci/pcie/tph.c  | 12 ++++++++++++
 include/linux/pci-tph.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
index 08ce4fdeb160..d949930e7e78 100644
--- a/drivers/pci/pcie/tph.c
+++ b/drivers/pci/pcie/tph.c
@@ -40,6 +40,18 @@ static u8 get_rp_completer_type(struct pci_dev *pdev)
 	return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
 }
 
+/**
+ * pcie_tph_enabled - Check whether TPH is enabled in device
+ * @pdev: PCI device
+ *
+ * Return: true if TPH is enabled, otherwise false
+ */
+bool pcie_tph_enabled(struct pci_dev *pdev)
+{
+	return pdev->tph_enabled;
+}
+EXPORT_SYMBOL(pcie_tph_enabled);
+
 /**
  * pcie_disable_tph - Turn off TPH support for device
  * @pdev: PCI device
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 422d395ade68..50e05cdfbc43 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -10,10 +10,12 @@
 #define LINUX_PCI_TPH_H
 
 #ifdef CONFIG_PCIE_TPH
+bool pcie_tph_enabled(struct pci_dev *pdev);
 void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph(struct pci_dev *pdev, int mode);
 int pcie_tph_modes(struct pci_dev *pdev);
 #else
+static inline bool pcie_tph_enabled(struct pci_dev *pdev) { return false; }
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
 { return -EINVAL; }
-- 
2.45.1


