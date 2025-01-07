Return-Path: <linux-pci+bounces-19472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 901E1A04C65
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 23:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126CF1886AF7
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 22:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C3E1F8AF0;
	Tue,  7 Jan 2025 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BCBE9tNO"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261A51DE4CA;
	Tue,  7 Jan 2025 22:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736288957; cv=fail; b=qphLECcil0SjZZJOBVgSxEaWGsXnxmQhoRHDjLFFGuMEPaFpeAZ27FFpjdpj8WcaZGftLscdLjVFd1d2FRsE3HcyRkILeviGOr6ZMJqsvcbE8K9tZ9iGGQl6cGrPlbaDD+uqQNzWtW2EDq1R3wrbCWIjL6FFpuRT8wQmEP0WIYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736288957; c=relaxed/simple;
	bh=JZQzsVbjw+y6RtTgV3YNaGYsh0XB0vVf48o5RMy9Tyc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVFlTFQXtECmtYKSh0jIjap0HAezx8RQ38QCiaY0+P7aaPmOBjw1HilTEBuM+1NOPTgemS721yHGuiAJDr9cY5+qOHNfUoOZ+YIaM24ee3ZgeVeKyYEdw3VYJtT3iR1hx7MkvC+HAT5wX2Knbil0mEQTOPZHjYBbN5K8MB2MH3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BCBE9tNO; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSM6HAuaK4C7UqUu8WG4io91gvyK7MflIURJTf23wCfECw4hnz6oMyRU5tv/iZP9oRJP5kDJ4NcXNXSoUV4U6f5oE7hGxdnItZQWZ9s7e1uqlfMM5F0ad0+neuvf/HNJ+2VhdMhrpNVZRZHNO+qSJsIfkE482q4FUa85aWO2tU4sx0vIwhSv0LA2rAoscBYbcQQ942LNruRiyzYiUUF0QNa0tjriQBJjteZu0vNsSpGs3eERbIWjdKrMe9Hh+qEgFvau5tvHMHOCkcloXSnFVYAleccr7dVf/1DJzyEQDNgmofOGmzYizVsHpO4vkqb/BWvs1EddF4x59WThx/dAoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0Z6mOG2wel5lqR7ORAItwmCUqQLXSdEHWHg6EFol30=;
 b=kudkbUVPb4upmkrPViwqtqqdVD4NbKAfl5Y3So+84Bcc7AoHfKai1iM7mTwzsYHnxK7Owy4L4ZeEkcbM8bnxygjfX42QLWwyQCar3oa+OZQ5QXql/AUUPmSIFkGac1xoSggXWks1WGpSTKAYhLSxKJh1dH5nfW343f3Jr/J4uQZnfHEdMPUhDzS5RU6VeJzDgLpHsass03HN585HsJlrKDnKTh5RR+E3JtalWXfWhUJAm3iHtbKSEuW2opNwuPG+yVEIBfDPl51VRauxxrcUBs0zF9Oenu8zuF6xflccYOTb2BAUVvfCCGziWpx8+lzCoOP7hNbdSC9ZbcViYIf/tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0Z6mOG2wel5lqR7ORAItwmCUqQLXSdEHWHg6EFol30=;
 b=BCBE9tNOi0DcRSj3A3qjkTM7zHh+DLfzHsG1GwBtAUSouTS7yAPV4WVI/v2rStPaezC461LqOrH3Q0S3oXK2gH3q1PI2ewkezUwTQm8o1rmbgRNDwy7hCxQmnOoUoBkpgzFuvE50by6+V3BysvNpfssKCyxXkbyCbNIb9fmVA54=
Received: from SJ0PR13CA0230.namprd13.prod.outlook.com (2603:10b6:a03:2c1::25)
 by PH7PR12MB6443.namprd12.prod.outlook.com (2603:10b6:510:1f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 22:29:08 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::31) by SJ0PR13CA0230.outlook.office365.com
 (2603:10b6:a03:2c1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 22:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 22:29:08 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 16:29:05 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <yazen.ghannam@amd.com>, <x86@kernel.org>, Tony Luck
	<tony.luck@intel.com>, Mario Limonciello <mario.limonciello@amd.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Jean Delvare <jdelvare@suse.com>, "Guenter
 Roeck" <linux@roeck-us.net>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	"Hans de Goede" <hdegoede@redhat.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Naveen Krishna Chatradhi
	<naveenkrishna.chatradhi@amd.com>, Suma Hegde <suma.hegde@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>
Subject: [PATCH v3 08/12] x86/amd_nb, hwmon: (k10temp): Simplify amd_pci_dev_to_node_id()
Date: Tue, 7 Jan 2025 22:28:43 +0000
Message-ID: <20250107222847.3300430-9-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107222847.3300430-1-yazen.ghannam@amd.com>
References: <20250107222847.3300430-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|PH7PR12MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f828128-4e59-4af1-0751-08dd2f6ab391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V2Yp/3fIfZvbl8Rpd6OcyHXOXMGZVnjlm7eKFWgtqmovJ9slki8k1wEcZFgl?=
 =?us-ascii?Q?Zpk57VmUW7Q6NI4NPOsHZ+Y2MjGeXBmwAbBEG6ZXHACSt00OE5mXu4BgTqVW?=
 =?us-ascii?Q?Qy8PZn1l5YvYL09n6ugG5nsUF5dM0joPasBem11dx3qXJ4ljDPC/3uXigtNH?=
 =?us-ascii?Q?PCd+sNEBzSbcCFW4AeXFfmLvB0eKZPkY2x9vYrFMTs188+mXW4Adw/fMG8wz?=
 =?us-ascii?Q?QI4so4wUpoqx9inUAIaEl+dsO9xuxaV2O0mLCRr5Jy/zIlCzGc2O4KWEf1W1?=
 =?us-ascii?Q?UxeT7VplizlRpKp/DYZ5NfwLv1KBQpAVjXf723x0vfFyvM9YFwL2v7wqUfUU?=
 =?us-ascii?Q?pJjued5ybjHS4S5mO5zohx9iobX9Qm+aIRFaGgVO16My8vYz3Iy9iEHSaIpa?=
 =?us-ascii?Q?Wat3p5aFaREnt1hn67kI01ee0jHGob7EIRJ9bF1A2emjAhUuSHEXTJYI/dvy?=
 =?us-ascii?Q?o6ZNKF7APDrBsj8VoLV5fPQ1p2EIQQIDMm/hxlVqDXAc5aQpJ2Lf6wtFo4KW?=
 =?us-ascii?Q?6RZcTuzyu5oO1nnqtN98oGz4EsZWhm/I6x38a1lhVIB2t2KFBGR8qW0KloDJ?=
 =?us-ascii?Q?ELFC06/lpZBTfLKed+Qno6o9ySLT2M9RFHX9W3r4Yu3nn6+gUjdKFcRC03tf?=
 =?us-ascii?Q?C365BWwwg3UcVJTh4qYwMmKxr635JJV1Lakh+s9b1viwJuN7h3lHV+mLO6dJ?=
 =?us-ascii?Q?mZ3n7nbKGLZLtFOElyQMAq3LHbMX3NgxHtls7wYUQtJFgbt3RYplDnRuJLQG?=
 =?us-ascii?Q?ysqjyoY+qa6meDc0OOp9qEyB3lvDvBFeGay/FdB+ynldy12DABVNxwXzh/LS?=
 =?us-ascii?Q?r/Fqb/P4KA7HebyDfKk5Rp7xy0Tv67a5VkZoZrpfyw8uEzUNfQ8qXq81igXa?=
 =?us-ascii?Q?8ak5QVaRnLHYp+zxfsyFsS6c/rXhtYz6hG6EfNLWg1gdlQwpFot4LDelNFp0?=
 =?us-ascii?Q?3oqmVuQ30wbia3HwsG56QrKt3aBw5s+ixtpud2bnBMZvtBvzpVVVYw/rh/2K?=
 =?us-ascii?Q?gejI0Ppq3vaa3iry87b7d6qPTtH3TzBULyVk7UYeQJwWV415AXkVKOJ8n5ck?=
 =?us-ascii?Q?9Z67ZKSjJ9VDcEaAbYPHj7czEYMfDLDC1R4r/GfAe8yZcJUSSeg6HzCdzSP8?=
 =?us-ascii?Q?cI+G3hoUeS6ymOWJcwsUnLhUeBzx/Ur6PsQxMQ7Q5BUpSe87R6TryJjp1bLQ?=
 =?us-ascii?Q?auZe/6/yJiYgjZEjbVz/dmRQgJdaUD7ic1NvXN1SldlgyfzsTmj7ykjM70un?=
 =?us-ascii?Q?MdwcvlIBvyVSC4O8GkvnZ8N2Yaqgpg/66mfo37i3u+PyLEImJycgRYMb7FWd?=
 =?us-ascii?Q?bYIndE8oC6aNIdBW7vO6TPeTnih5EmUtsdBYZVbobRcHxjBuBbDE5JhI8cSH?=
 =?us-ascii?Q?LuxqxYQdEN0v9ZMP3EjHnuYliuWmYiiFk8OrVGS7YMySs8ZGzVTQ8CRliLzO?=
 =?us-ascii?Q?gu4H2zXqk54MgaiDQZMtnm51yMFpnHywBNvIqyh0oCs481w7yX0WC+ReWgqy?=
 =?us-ascii?Q?k6m+BcGtyZuohsxbQEisAhg75ymJ4Tz++bSF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 22:29:08.0581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f828128-4e59-4af1-0751-08dd2f6ab391
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6443

From: Mario Limonciello <mario.limonciello@amd.com>

amd_pci_dev_to_node_id() tries to find the AMD node ID of a device by
searching and counting devices.

The AMD node ID of an AMD node device is simply its slot number minus
the AMD node 0 slot number.

Simplify this function and move it to k10temp.c.

  [ Yazen: Update commit message and simplify function. ]

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20241206161210.163701-10-yazen.ghannam@amd.com
---
 arch/x86/include/asm/amd_nb.h | 17 -----------------
 drivers/hwmon/k10temp.c       |  5 +++++
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index b48dc6975da2..094c3be81a8d 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -82,23 +82,6 @@ u16 amd_nb_num(void);
 bool amd_nb_has_feature(unsigned int feature);
 struct amd_northbridge *node_to_amd_nb(int node);
 
-static inline u16 amd_pci_dev_to_node_id(struct pci_dev *pdev)
-{
-	struct pci_dev *misc;
-	int i;
-
-	for (i = 0; i != amd_nb_num(); i++) {
-		misc = node_to_amd_nb(i)->misc;
-
-		if (pci_domain_nr(misc->bus) == pci_domain_nr(pdev->bus) &&
-		    PCI_SLOT(misc->devfn) == PCI_SLOT(pdev->devfn))
-			return i;
-	}
-
-	WARN(1, "Unable to find AMD Northbridge id for %s\n", pci_name(pdev));
-	return 0;
-}
-
 static inline bool amd_gart_present(void)
 {
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 7dc19c5d62ac..cefa8cd184c8 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -150,6 +150,11 @@ static void read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
 			  F15H_M60H_REPORTED_TEMP_CTRL_OFFSET, regval);
 }
 
+static u16 amd_pci_dev_to_node_id(struct pci_dev *pdev)
+{
+	return PCI_SLOT(pdev->devfn) - AMD_NODE0_PCI_SLOT;
+}
+
 static void read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
 {
 	if (amd_smn_read(amd_pci_dev_to_node_id(pdev),
-- 
2.43.0


