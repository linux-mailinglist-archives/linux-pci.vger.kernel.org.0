Return-Path: <linux-pci+bounces-17856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 305E79E7573
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 17:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A7F18861A5
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 16:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B06D211466;
	Fri,  6 Dec 2024 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zxDcMQUt"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051E720FA9A;
	Fri,  6 Dec 2024 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501560; cv=fail; b=g7+C9clnG41XUpI9A6FbL5DC3n/7VG1epYeOhaj+sQKRtp92w6+ygGulUpNypR4VnBiyh05sYIy8zmQSVhLLQFbSBjxJJc1Hmis6sGa/p1ISeK0VipU912a2KH8fXIcOs2OQQ2e4kJ3qwVg07FZzEoggplPVdDo6uzKuHLxZZh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501560; c=relaxed/simple;
	bh=KYMkyD09g66g1KOmFrbgLAtyxx2po0J/C/CdY6F7zW8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5xfNue7gmrNviMGyO3IzOdiQEyYU4oYQRICELVH8mTTm1OSVsPxwSm7jL6/39SgxbJaRbI+m6mrkJqN8CypdsoFmU2lLGP+4ABiG+pX5Dkfj2Bo8vpQ7xAzc13bgKA4R7mr2s5fyQkrCiLkjL4Io2k2mMEND3uJ8IGWo+r0n0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zxDcMQUt; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P24kErQqYbVqx9AfMhZfufYyHo/PqjdJBXZAWp/YlL5VjhBhJYeYB+Et/6QMbHAQDhKzn/ViJpV8WF4X1ETzw/o+L5ghbWCpUHo9Ii51HY7LmCfDYPYTm4ZCpkgPil3t2tzj9toYCeH/c2a9pT39hqz6hah1+6P2PV/lc3kKuNA6TsX5IdHWq9DFWwDrM8ncY5LNWtV9kGglyKQ/49KypUu90yyjrCj547b2hha1h3liTnWfEgyi1CvxzJu/BzczZdaT2+X+q6Rd4HYF7avdbeqeECloc1Ua0bLjS59Vj8Go/k7DntCwVjwVf/CJwuZ9O6pRInKMSzwh4vEPQO4kkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fwT3ZKKS0G3C1n9Is0V1PZ7P4RBFR+IA1u6KPmwxU4=;
 b=vnUvrec3iJcDlXFj9qQH1J5GtZF70gb0sM5rrHsa+o0yBNZ0UJHWCyTAzRXChxBuImS2yZfTmQxnT3zpBGYh1oiv1aaGRg7yeWhEG4owEj3FSEin++6rARj1lBOk0PAQ+eN7GDxKcOEH6Y6X64upOTbopEruAWvBLQmGmsLPIrK9vZFEPPHXpoQ/+0e7Jrmuh7C0yKgoXbj8ABZBsmVxVJkWRq/9etQsfqyz9TpKlZdnMw7AvHuefHAF+akCL5alQaoUQd1LzcJrxU+04V9MMeTxdh/IMDdL+p9NBeCum2z5dMpTrHdK3uVPeNrb8zOsa/WJYn6aqxq+6NYs7XWIEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fwT3ZKKS0G3C1n9Is0V1PZ7P4RBFR+IA1u6KPmwxU4=;
 b=zxDcMQUtfUXoAZVWcVzS7BCuaVnhgGFoo1864i6zcv1TbsxJV1+ft4ByU0mZJ44BbB3JOuDjAqOORJypbKc27P1lDIDgpUYdeKC1QfEkhxNDtk0Im13mKwWzhMMgMbpZVv9zsy4Q9SMw+YFKMw70/r9pL9O70ruT67vulfivS2E=
Received: from DM6PR02CA0064.namprd02.prod.outlook.com (2603:10b6:5:177::41)
 by SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.22; Fri, 6 Dec
 2024 16:12:32 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::ec) by DM6PR02CA0064.outlook.office365.com
 (2603:10b6:5:177::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Fri,
 6 Dec 2024 16:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 16:12:32 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 10:12:31 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <yazen.ghannam@amd.com>, <x86@kernel.org>, Tony Luck
	<tony.luck@intel.com>, Mario Limonciello <mario.limonciello@amd.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Jean Delvare <jdelvare@suse.com>, "Guenter
 Roeck" <linux@roeck-us.net>, Clemens Ladisch <clemens@ladisch.de>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Naveen
 Krishna Chatradhi" <naveenkrishna.chatradhi@amd.com>, Suma Hegde
	<suma.hegde@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>
Subject: [PATCH v2 09/16] x86/amd_nb, hwmon: (k10temp): Simplify amd_pci_dev_to_node_id()
Date: Fri, 6 Dec 2024 16:12:02 +0000
Message-ID: <20241206161210.163701-10-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206161210.163701-1-yazen.ghannam@amd.com>
References: <20241206161210.163701-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|SA1PR12MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da51e1f-7967-454e-67c3-08dd1610ca2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y6yg8+E5JWSgb92rTagorQ06nmfPPCnbBc6NHTBEufxE78fqn/4RC8XW9PcK?=
 =?us-ascii?Q?NYWZGsGYzALomztfecpuY5+YnHSfTAEpB4vy13/a0FafYhxJQzmBcBTquGPe?=
 =?us-ascii?Q?FcXZsKb0ejRlYf/ihGSAYrMFcIlHfYzCFr9C0DEvrntYjQ20MkRqYc3LYE4k?=
 =?us-ascii?Q?abrCFfpIIOCNfI+a7j/A/RdsYXWVDlvwi/LGsPRgrAXaUpVJwgY0ah0MgH2X?=
 =?us-ascii?Q?AMjOOheRPYE69Odka3Ppm8PbnrQ7LwxKon0Gh2HdoSqzX675zcCcB7A6zeX+?=
 =?us-ascii?Q?FP93FFhnaXd6RQFHCJo0NEANz+sTTIyr1MyHB6huODvC4krhgP5II524Om9V?=
 =?us-ascii?Q?etRbtZW6tw5NmU2MFjk7zKCEZHufc9iUHjq6L3OixWquo/juPZPJzIQnQENR?=
 =?us-ascii?Q?cb011L09ZnqeC2cF6de3tdyRAhuiXd1gEGV131RKCJr4bGRRtD3qV0Wtx2pS?=
 =?us-ascii?Q?SfGdXp+S+LzTIm75s7CurqBOJ6FrZzW8P1SS5bX7vWSR/6fr8ceUEBoCNydY?=
 =?us-ascii?Q?nsrrrINM6vwZjkho8pZPYI4NjQ6AxWPsBanBcOzSe1V6s1gxdD9BEsdABzjL?=
 =?us-ascii?Q?+TqWsuqp7JWo3slZoGI2+gHDsfsgtKpeVni4PK7r9DD9hW2NDJv4+iBFf9l3?=
 =?us-ascii?Q?y6O9Yj2L6boA7dSWPlzq2slOXmr9zTJYNjZhAdXm2DadiXguLYjoFr3hOtoy?=
 =?us-ascii?Q?zHAoq51MYwSzGw4d7LnovVvLncozN5hn+It86uvl+gg96IeD2a8SwOVf3sHB?=
 =?us-ascii?Q?pdShTZM8k+U4yux3rX/C8VogdMad32h+cdz9exDClRElWye1Squm2FtjVMud?=
 =?us-ascii?Q?8a6fZbzKx4qC9BCsh9QN6Zllms5b9/OY9TeZrbFdxjH1YRYzU0tvtd32MWia?=
 =?us-ascii?Q?VBAoLwTodsQWHSxnBoCpsizF4bsPGMvKMS1xI9MgqgN8DvesnN6E+oAkyjm7?=
 =?us-ascii?Q?vo/3ZCQikENzAiKmGcP53ASLIDZ0GpztsA5KeJljT2XfncAp1bWnSlJY+M1N?=
 =?us-ascii?Q?adeYRxyI1XOWegOVCFRr07WsWuiMyPEUl3z1+Lmnkpc5XPSqsBqG0XxTPCE4?=
 =?us-ascii?Q?OEH7iUcBevq8+9lmuWBhucvazwxEA6mRh4z7tFyOhE/JIU2cj5NT5+H9b5us?=
 =?us-ascii?Q?2EBVTsPDb7BxWXKUgKKk5Dl1Wx7GlnFbgvwgQoEdwsNXoyG6kQpTcaM4UmAi?=
 =?us-ascii?Q?LNCEF5cO6kISqtttVzMM4CIrD1pqzOL/MH+6cs7NikZvoaIQ/xsL3sw8cg6y?=
 =?us-ascii?Q?BuCT/kBj0NXPXKZqzxvRKONel2AGzEBjNNV2kK508J5LdQ6Ja0ZZM6UzjYeY?=
 =?us-ascii?Q?oUlMmc0B6Vwc1biBNWHK8BA1VXBf31YOslRVR/vvXEDql8TBMXlGo4NaaCzd?=
 =?us-ascii?Q?hlSuODuXh+3KSJHQfuYrdbgTEfARgHsjtAlNWXfAF2Us098Eo6cO2Q1wVkJM?=
 =?us-ascii?Q?D/c0oaL8OROMRS0ZNX1q+r+mycDzHykUg2MzhcKUw6xxVI+AMSCKxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:12:32.2514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da51e1f-7967-454e-67c3-08dd1610ca2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845

From: Mario Limonciello <mario.limonciello@amd.com>

amd_pci_dev_to_node_id() tries to find the AMD node ID of a device by
searching and counting devices.

The AMD node ID of an AMD node device is simply its slot number minus
the AMD node 0 slot number.

Simplify this function and move it to k10temp.c.

[Yazen: Update commit message and simplify function]

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/20241023172150.659002-10-yazen.ghannam@amd.com
    
    v1->v2:
    * Move simplified function to k10temp.c.
     * Based on the original idea from Mario.
     * This can be removed when reworking k10temp.

 arch/x86/include/asm/amd_nb.h | 17 -----------------
 drivers/hwmon/k10temp.c       |  5 +++++
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 31547108de1a..066dc3801430 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -52,23 +52,6 @@ u16 amd_nb_num(void);
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


