Return-Path: <linux-pci+bounces-7300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C87918C12E7
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 18:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560E71F224B5
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 16:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7061708A7;
	Thu,  9 May 2024 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xsbl9g7i"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25F8170830;
	Thu,  9 May 2024 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272121; cv=fail; b=SRehp6RIrqXHJYdR4vN8c55Tm0dCDW880KdhTT6cPNhGUckMfkUEX4g9DQSH9hzVbNSHCr0nn1pUtYnp6QqLl/4sb8Il4d57onl22/j7xDKV9aLeNkzpyK2MZW4E0vs4znuriJ1m1/RMaUTyrDV/0cGSuacMHVZPSUPzQj/biis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272121; c=relaxed/simple;
	bh=xmSMpvWySVctwj0QudWyRNlIRGEIJUyuRGvkfNrHbpw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rO3bEvLecw20lAIUCZypYd5nebk6M8zE/tnPh0xFN4TKVC7h8kKCQOQH28pOWioAd/xdvwVWbAShl1rsZiLRS6IQ+iv1x8ch3SqWqJBGNMyi+I/y4fyQjzBmLnZhZpMaUtBXk767uItWX684N0gEomdWdjeANtI6i7WXH7UtTBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xsbl9g7i; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imuIE206vsJZxyOWYIItza3iPvSJNkCWqVTAt0PCya4QTgyVp3oeX+efMaEo/VisJy4bCisD+c/w3v2fI7vWZ8/fIr+pMji7B11DTwRp5Zv/X7iN40LcOC6SH4U9KtOA55xz3la55RYm2T47m+2BBMzBAvbhJklijVtoroXrLeRFIxXWg0bvL644uvD1AdzG9gdhrCDhHwZnpPjwylOvY1SUsrtWnBmlyI+HMp8mp+L+tyUiyM9X1qriQk847mgJKJB594rL4H64cznHN7e2mqGmhZEfqj7nv+TlUiWlaBrQHR+G5iHMOrp2CsH2Ht8734f/7N4UMU8eIX89yLagWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dm53saFe7QZ9LV6828TvIprYLM5llR2/Lc6g0XkwWVg=;
 b=Ww7+XFt6EPN9j+2BkvmEk3RYDzLat7lemgYu85nENgmKFPF4wNrghZS42BAJGc7qGVfioKYIKSv241bRoUzSt6nFlu/iVTMr+zdCTMCIR7dkhxk9fZJgWxFjNQ92jQIFHKDVHi1/c9rLFWfifEUIjLDJVEipyNzoxwCvawhXYk4LIIgLfs6CSnCn6c6Jl5Ve35cqrWx4KAX77JXPtbyRRFjZfCyW36LYoDMU58Zrh5xlO+ojv8WHCbhKgd1QXxAb1KO+JbnXH4VPlxHzpM6/vBWDLVQr1FMEI7BVclWf7SzLH1bEGUyrO+rU46rNx6Ahox4gUQxOmG+dtVZBdeIMKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dm53saFe7QZ9LV6828TvIprYLM5llR2/Lc6g0XkwWVg=;
 b=Xsbl9g7imEep73MceYg3G0P8guYAIWUzdZhtuKtbC9gy+d+uA1lVWh9exgECp759fj6E7jLnOB2zlnHJcX/kt8Azh+l4GOkQSuL1A9y3JfTDSpzXoo5+EMxi1OQ9GC/lzLFKZy1QGYlqar8hLt8PTwdLoL+19QA+vkSuZ4e+2CA=
Received: from CH0PR07CA0016.namprd07.prod.outlook.com (2603:10b6:610:32::21)
 by IA0PR12MB7673.namprd12.prod.outlook.com (2603:10b6:208:435::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 16:28:36 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:32:cafe::dc) by CH0PR07CA0016.outlook.office365.com
 (2603:10b6:610:32::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Thu, 9 May 2024 16:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Thu, 9 May 2024 16:28:35 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 11:28:34 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <bhelgaas@google.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>
Subject: [PATCH V1 4/9] PCI/TPH: Implement a command line option to force No ST Mode
Date: Thu, 9 May 2024 11:27:36 -0500
Message-ID: <20240509162741.1937586-5-wei.huang2@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509162741.1937586-1-wei.huang2@amd.com>
References: <20240509162741.1937586-1-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|IA0PR12MB7673:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5203a0-a0e7-4ea2-78c4-08dc7045131b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|7416005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JcWAGmEOzvIYRGzzqPuUw5xNLcoItVJp6HDTk8N7Mof4JoZ2ikY9x3w9voWW?=
 =?us-ascii?Q?4nzryrdklhNpFhVIJhk5Wq0KGvgFUlI8Zcjfjie0Q5fM3FGFBtUWMZJJj16b?=
 =?us-ascii?Q?XlPeLoPU1fBkYe4xd84cftLVgAedxxRxIYPRw/Zxa6JFg4TllQkFbjvL74j7?=
 =?us-ascii?Q?BBIkEB/j/yF4jvOzkW694gKls8UKi8Nl0f6rBt992kxy7tpc7o3JXKgw1zto?=
 =?us-ascii?Q?dACw/pFsA3d4o2qwzF95qiG7Smj9HcRSSc5MXRtq/hc37uMRfUNUgFIqRpoB?=
 =?us-ascii?Q?35Qk3w+ME99/DCkOTGUT3pYWmGeJuFVkw5df/Tp3W32IjOu1jNYP5lclRd2j?=
 =?us-ascii?Q?CvewDkvKTjUBRMIt6LqD1ob3uhaIwUEjUDBtunKDVfCH9gRRp2+SeUDGQCs3?=
 =?us-ascii?Q?OFX9deafiUmKhYalHyJO/VW2M7yrXz6JuUO0e6gNqWB7d5C/pN1+0XD8JR5x?=
 =?us-ascii?Q?eqS5C5JqrQFnLNNPj9qrT0tMdGP0JwwkKcejkUuBEhZM8Fz3pWWbDnItHz9A?=
 =?us-ascii?Q?d2Y/aZRZ8o1S6r7Dtbst2QqP/ooAiB5+DZcXM6drvYjypjZD3zzurvOqbeXC?=
 =?us-ascii?Q?hISlHZ696mjVtFV/IBbvj9YI1dcZiVcTFdbhsGp5LvjshUfxoxrEnnIJKH01?=
 =?us-ascii?Q?b/Y4HnqXvc1NBmtpfe42AExKHkUQPJJCwnO84gPwpsoXbLolQC6BCu1cP/Hk?=
 =?us-ascii?Q?MYqW6ek07A22/8bdPVTQPcXgM1n7WOv6GVIt6bXN+7P5YiAoaJHV6TVi9s0T?=
 =?us-ascii?Q?otPLwVlJzVNMXvUBx1nTiZXnV25uvbekwkyxpJvdKg3VqbMTng2pwa3SJ/iX?=
 =?us-ascii?Q?SgU9gT1erVCJc37pL+YUtVVpOfJMv4PdcOgqCO1wAhzGZA0xzYY3iYgr7+VP?=
 =?us-ascii?Q?GrgIH3cu3dKGgFE4qXRTpRXAktBYGInLS21PHqZSzW5bzbVQ5TA0zMswIcpQ?=
 =?us-ascii?Q?M+VB/Pzb2lbwbd7ajrcs+5GF/gk3XXWHj4g4AtHe3mCOOn3gETlZYh7zcKdd?=
 =?us-ascii?Q?z7yQ/sgp2puGrTY2lOemhcByeh2xM71ibgygnok2GFTZ7TIdpMi3pQNpWkgP?=
 =?us-ascii?Q?GXOK+IU2bKcu6PqgwZItOJfXlLwOuik7aec1R97ZUuRjE5MrEybRUxmv6hps?=
 =?us-ascii?Q?gsMsKdjcZjzrK1w2FHhYZPPHRIvruUIWzvCQKhimV+HT++cZxY1NhX/HcaZ0?=
 =?us-ascii?Q?41HQkTDrPHcOvOpLPoL15zrpkQB3uzFHCSooewxkFVEvoh9sXlecZcWy6JkV?=
 =?us-ascii?Q?whtlBjxe642k7f6UxYlw88ruBg7/5urX1pF+a4uwxf6SWgAbQrOndqBUM51+?=
 =?us-ascii?Q?Hdc1rQM+PJay4pRhfeFY6LI0sksC6ZoJMM79j71Pqxq9N5cHtJBacVzkjCEJ?=
 =?us-ascii?Q?X4ZIB4Bf7ldADQeishLlLp5RB0v9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(7416005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 16:28:35.4764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5203a0-a0e7-4ea2-78c4-08dc7045131b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7673

When "No ST mode" is enabled, end-point devices can generate TPH headers
but with all steering tags treated as zero. A steering tag of zero is
interpreted as "using the default policy" by the root complex. This is
essential to quantify the benefit of steering tags for some given
workloads.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 .../admin-guide/kernel-parameters.txt         |  1 +
 drivers/pci/pci-driver.c                      |  7 ++++++-
 drivers/pci/pci.c                             | 12 +++++++++++
 drivers/pci/pcie/tph.c                        | 21 +++++++++++++++++++
 include/linux/pci-tph.h                       |  3 +++
 include/linux/pci.h                           |  1 +
 6 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5681600c6941..0adbbe291783 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4594,6 +4594,7 @@
 		norid		[S390] ignore the RID field and force use of
 				one PCI domain per PCI function
 		notph		[PCIE] Do not use PCIe TPH
+		nostmode	[PCIE] Force TPH to use No ST Mode
 
 	pcie_aspm=	[PCIE] Forcibly enable or ignore PCIe Active State Power
 			Management.
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 9722d070c0ca..aa98843d9884 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -324,8 +324,13 @@ static long local_pci_probe(void *_ddi)
 	pci_dev->driver = pci_drv;
 	rc = pci_drv->probe(pci_dev, ddi->id);
 	if (!rc) {
-		if (pci_tph_disabled())
+		if (pci_tph_disabled()) {
 			pcie_tph_disable(pci_dev);
+			return rc;
+		}
+
+		if (pci_tph_nostmode())
+			tph_set_dev_nostmode(pci_dev);
 
 		return rc;
 	}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 06f9656f95bf..ba9ec6f1b51e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -160,6 +160,9 @@ static bool pcie_ats_disabled;
 /* If set, the PCIe TPH capability will not be used. */
 static bool pcie_tph_disabled;
 
+/* If TPH is enabled, "No ST Mode" will be enforced. */
+static bool pcie_tph_nostmode;
+
 /* If set, the PCI config space of each device is printed during boot. */
 bool pci_early_dump;
 
@@ -175,6 +178,12 @@ bool pci_tph_disabled(void)
 }
 EXPORT_SYMBOL_GPL(pci_tph_disabled);
 
+bool pci_tph_nostmode(void)
+{
+	return pcie_tph_nostmode;
+}
+EXPORT_SYMBOL_GPL(pci_tph_nostmode);
+
 /* Disable bridge_d3 for all PCIe ports */
 static bool pci_bridge_d3_disable;
 /* Force bridge_d3 for all PCIe ports */
@@ -6719,6 +6728,9 @@ static int __init pci_setup(char *str)
 			} else if (!strcmp(str, "notph")) {
 				pr_info("PCIe: TPH is disabled\n");
 				pcie_tph_disabled = true;
+			} else if (!strcmp(str, "nostmode")) {
+				pr_info("PCIe: TPH No ST Mode is enabled\n");
+				pcie_tph_nostmode = true;
 			} else if (!strncmp(str, "cbiosize=", 9)) {
 				pci_cardbus_io_size = memparse(str + 9, &str);
 			} else if (!strncmp(str, "cbmemsize=", 10)) {
diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
index 5dc533b89a33..d5f7309fdf52 100644
--- a/drivers/pci/pcie/tph.c
+++ b/drivers/pci/pcie/tph.c
@@ -43,6 +43,27 @@ static int tph_set_reg_field_u32(struct pci_dev *dev, u8 offset, u32 mask,
 	return ret;
 }
 
+int tph_set_dev_nostmode(struct pci_dev *dev)
+{
+	int ret;
+
+	/* set ST Mode Select to "No ST Mode" */
+	ret = tph_set_reg_field_u32(dev, PCI_TPH_CTRL,
+				    PCI_TPH_CTRL_MODE_SEL_MASK,
+				    PCI_TPH_CTRL_MODE_SEL_SHIFT,
+				    PCI_TPH_NO_ST_MODE);
+	if (ret)
+		return ret;
+
+	/* set "TPH Requester Enable" to "TPH only" */
+	ret = tph_set_reg_field_u32(dev, PCI_TPH_CTRL,
+				    PCI_TPH_CTRL_REQ_EN_MASK,
+				    PCI_TPH_CTRL_REQ_EN_SHIFT,
+				    PCI_TPH_REQ_TPH_ONLY);
+
+	return ret;
+}
+
 int pcie_tph_disable(struct pci_dev *dev)
 {
 	return  tph_set_reg_field_u32(dev, PCI_TPH_CTRL,
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index e187d7e89e8c..95269afc8b7d 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -11,9 +11,12 @@
 
 #ifdef CONFIG_PCIE_TPH
 int pcie_tph_disable(struct pci_dev *dev);
+int tph_set_dev_nostmode(struct pci_dev *dev);
 #else
 static inline int pcie_tph_disable(struct pci_dev *dev)
 { return -EOPNOTSUPP; }
+static inline int tph_set_dev_nostmode(struct pci_dev *dev)
+{ return -EOPNOTSUPP; }
 #endif
 
 #endif /* LINUX_PCI_TPH_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 63aa6f888c90..6781a1bd28c5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1867,6 +1867,7 @@ static inline bool pci_aer_available(void) { return false; }
 
 bool pci_ats_disabled(void);
 bool pci_tph_disabled(void);
+bool pci_tph_nostmode(void);
 
 #ifdef CONFIG_PCIE_PTM
 int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
-- 
2.44.0


