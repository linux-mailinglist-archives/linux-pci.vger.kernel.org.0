Return-Path: <linux-pci+bounces-10466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC6E934377
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 22:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52BB1F22551
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 20:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A5018757F;
	Wed, 17 Jul 2024 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oqx6p3Bh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9096224205;
	Wed, 17 Jul 2024 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721249781; cv=fail; b=hsToMhULrwrheufP7HgPQQL8YxQosKq8cs3Gerz+HPyRQItd+EFC5GcguY8jBYZM4eKvmNqhzrXLVZP00j2EWkhwOaHelNSFxnIeyBenfvFIqNIDkBVsu4FsgHMbkn9NBsoVwlxADSuLThshjwXGMSUFGIt1gva3SIM7n7PtI5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721249781; c=relaxed/simple;
	bh=ifIhAKxd79pqzmNtkedy2Lhb1w2dU1zy+Fk44QI3BxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9/XmGRoU0VF5JVjwHvGd4QzgLERY7hebYPYp/AafS6xLVuk4byLoBDsx2kjA6kJ+EdyF9F6RAvR5wdbr1BsdnkwYScvFGYbAbCx6v5F8tJuV4OmVfY3nin5z3PGXEg9PpM9leEzs0Y1u8i8wrGCQRnAyyKFYr5sPrmlBYDnAO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Oqx6p3Bh; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNBl7RMGV4xjKHJ9+NldBXKfkYgafhcZ0fHjaChqAtOQmbowaEB+1ugh6Pu9wOf8zzS018wA/J6fbOIjBzFDrJlOwgTZqiHyX0Su8ma+39FV6TspQgVwhiWHHAV33/I1MOYi2zX1vrsONrax8evDSO95dqcs4Y7LKc0Bpuv7oOI6C2aDUUPVX0iZ1x3GsjBTXBsX24mThIQY2GLLGdYZgC9yag2xLibKybYDUzqr2M4CI8R38GXR4mYjBGSgbc+SpkLN7ZEtVMc/7g0j5G8np+WU4SplMrEQWfih32NxjL9E+UbbKhZmsmxJUWU9yY3nEcTczMVqy6jJ9clHXUCq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AK+g4l1HU+APu3QjZXPZzCvFYc8zQULn5Ml4TKKJvI=;
 b=aDNGeYcB7MgaAyyA8xYMvfHg6mygcdgt7vR5Jkpj2zSAFO+/J39Gg+rbblJDnLCK4VcXfMZlhTbjQz0AQ8yzAV6dliz6n/29GLU6cqMpBF4ZCCfAmQ6/pCjDegVQ/nbSs+gXS8y5/TlrXRoeE5QVKD/f7HDovE2iaxp5LtE9SNU/ntnjRbXd+WUL2O8uc+nI0i/Mg3FNvsZrV4ovj9msOmtUi0AVu6w4bU1QtKpfl+LqYI1oyyC1alTtYM5fItxONZ0iKKm0QbB44xGALOZQOyP9bzQppVtvba/w2Wd+BxmWuH7GnblMzvZRl3cqJIw95+6OgwrVbels0Z0hIhGwXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AK+g4l1HU+APu3QjZXPZzCvFYc8zQULn5Ml4TKKJvI=;
 b=Oqx6p3BhPteBcP8m+DavAupcv/FLG0B4cyPkcSwvmLMaKcGw75iE4Vls18vC0MjOfb7tIvbJms+Sau4KVYDSwcOMn6md4UI4BY3laQrn5ahfJdAvq3QeJtpa7GAIRlwoAgY1OdtjpA3i51ZhxTGCThVwqKikUyBZ75onJAeuc3I=
Received: from CY5PR18CA0048.namprd18.prod.outlook.com (2603:10b6:930:13::33)
 by LV8PR12MB9135.namprd12.prod.outlook.com (2603:10b6:408:18c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 20:56:10 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:13:cafe::15) by CY5PR18CA0048.outlook.office365.com
 (2603:10b6:930:13::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Wed, 17 Jul 2024 20:56:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 20:56:10 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:56:08 -0500
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
	<bhelgaas@google.com>
Subject: [PATCH V3 04/10] PCI/TPH: Add pci=nostmode to force No ST Mode
Date: Wed, 17 Jul 2024 15:55:05 -0500
Message-ID: <20240717205511.2541693-5-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240717205511.2541693-1-wei.huang2@amd.com>
References: <20240717205511.2541693-1-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|LV8PR12MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: 055d737e-b403-415d-83c6-08dca6a2e2fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YDRDPMckBqn43IC9vTvhsrfsL4ylnHG/LrZA1CIQnicGXHGB4bWcMJ7mU2tg?=
 =?us-ascii?Q?VB75cnmkPZLb/CCLPSQWm8MS0KfL1EG/xDLs1sMgNznJCeEi+DgA4MG5lsmC?=
 =?us-ascii?Q?cCdg8kv+v/LIzF/IZL9c9TTIVT7xfKcgcWZvcPOHbiikfUfawcUTd8N8sYRK?=
 =?us-ascii?Q?Jln9F9sZuI5afylm0O7E/Ni3/scPgxI63gqqh63ysyNRupZcUXttihUs/I05?=
 =?us-ascii?Q?DH9/+sXTM97MT+5FOFYAOBURaN1OCAPiojpLxVuczgbOrNHK0WpfhCbj9rj6?=
 =?us-ascii?Q?ZuxNxiWsh3/iMCLvSZvCaPHBjpS6MDQQD0RGv9lSDZm86XONHoyRShwkkZF5?=
 =?us-ascii?Q?LAV4Zvt/fjCE1sUF0lL2ICg6SiUzNDd+a9tmyfEY6KQQkeRELA2OPzOYz9UA?=
 =?us-ascii?Q?rRVksDQ07VI8REi7Uvn9MyVcoUwQUFrbSs3D/YgqWjEKYAscQLbnLyxXtEw4?=
 =?us-ascii?Q?YjSPi0xkNQLr6K1ExemVEf8pN9aBenLWVbE1C9nq24d0BlvfsBfytfeLpZLx?=
 =?us-ascii?Q?5bJNL8HGvvrB5W2IitvNArZKOAs/aqDSe9V3iVgYTUcH64dri6SjkDKfQ+ib?=
 =?us-ascii?Q?lM6GbeSchfqIVK/OZFHz5+7kBKTONHC81mDjAGwqy8zAfGYSRJoqPdCFYaVJ?=
 =?us-ascii?Q?KgCp1zuTrNHi7cZTU0sfHnhZuZrzVEOKD5HO1R+oT1tp6bGwqamwpR6wDguJ?=
 =?us-ascii?Q?8H/HSP/NoIR8/7DTqPjIe7FWD6rKG5bWLHW6Qk8rS1HxFvIOVc6iZ1eT325g?=
 =?us-ascii?Q?pgJGwdVv9Pty73yNDLyjkL8NLA0xrSOEZE7OAPwo0jl025XqUYDu49bnJe8y?=
 =?us-ascii?Q?DxNZ/ZoCJtQaJqihBGk2tFB4aqXgH825ZdhDD9SnU4HwXznJ5prrzxmebYaP?=
 =?us-ascii?Q?wuxLIwMjgDUAmWPEpL3M4yN9lFPYZ+2IHwX5nBqxcJEnRBlKcmbzejQPr9PK?=
 =?us-ascii?Q?TmXPyjSRai2UJQQpaYnw2TSlPm9LSo0/9g0mmyyKPGTaJW5u6j9jeRcMAmve?=
 =?us-ascii?Q?8d+emzipyAYynHW15nQnyJhy1XyWb6i62TyLpNb6slpwyc6PtFzDLSHR/IWG?=
 =?us-ascii?Q?8LV06G1b3+EeQ+ZLy42dmtjb6ROn5LXvpLA6nxNaE1Yx0jMpFQAVDC42bOoE?=
 =?us-ascii?Q?dzFRgp70fmEuCGyUDDMplgxygI7714CzEoN251IVEAzR/mInle7qyp5EI2b5?=
 =?us-ascii?Q?HuG3CkFMN99ijc5f7pjgWZepegp2HtA40D1YstnEreNd+4Icaii4WfNQwLLp?=
 =?us-ascii?Q?EUkUK+SJPp0ASNPa1Uk214id0mLnf8LwjebNKyqyHSwT9wK70/jOJrmzwyK8?=
 =?us-ascii?Q?SdgkyTg0Fiio15mGpK5hJSDE37foEvIXWdSTB88nCLQADrsaQI06rFUpv4+C?=
 =?us-ascii?Q?w49xT2PsTGA2j9E9Kc94tCnSNsYZ4CSBPLOGIxSlY9NfrmrJf9Uiqc9alPfL?=
 =?us-ascii?Q?hG9+ShinwU3LPkbDh7hoRT64MwzZSsRt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:56:10.1030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 055d737e-b403-415d-83c6-08dca6a2e2fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9135

When "No ST mode" is enabled, endpoint devices can generate TPH headers
but with all steering tags treated as zero. A steering tag of zero is
interpreted as "using the default policy" by the root complex. This is
essential to quantify the benefit of steering tags for some given
workloads.

Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
---
 .../admin-guide/kernel-parameters.txt         |  1 +
 drivers/pci/pci-driver.c                      |  7 +++++-
 drivers/pci/pci.c                             | 12 ++++++++++
 drivers/pci/pcie/tph.c                        | 22 +++++++++++++++++++
 include/linux/pci-tph.h                       |  2 ++
 include/linux/pci.h                           |  1 +
 6 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65581ebd9b50..1b761f062969 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4656,6 +4656,7 @@
 		norid		[S390] ignore the RID field and force use of
 				one PCI domain per PCI function
 		notph		[PCIE] Do not use PCIe TPH
+		nostmode	[PCIE] Force TPH to use No ST Mode
 
 	pcie_aspm=	[PCIE] Forcibly enable or ignore PCIe Active State Power
 			Management.
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 9722d070c0ca..abe66541536e 100644
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
+			pcie_tph_set_nostmode(pci_dev);
 
 		return rc;
 	}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4cbfd5b53be8..8745ce1c4a9a 100644
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
@@ -6881,6 +6890,9 @@ static int __init pci_setup(char *str)
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
index ad58a892792c..fb8e2f920712 100644
--- a/drivers/pci/pcie/tph.c
+++ b/drivers/pci/pcie/tph.c
@@ -13,6 +13,19 @@
 
 #include "../pci.h"
 
+/* Update the ST Mode Select field of TPH Control Register */
+static void set_ctrl_reg_mode_sel(struct pci_dev *pdev, u8 st_mode)
+{
+	u32 reg_val;
+
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg_val);
+
+	reg_val &= ~PCI_TPH_CTRL_MODE_SEL_MASK;
+	reg_val |= FIELD_PREP(PCI_TPH_CTRL_MODE_SEL_MASK, st_mode);
+
+	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg_val);
+}
+
 /* Update the TPH Requester Enable field of TPH Control Register */
 static void set_ctrl_reg_req_en(struct pci_dev *pdev, u8 req_type)
 {
@@ -26,6 +39,15 @@ static void set_ctrl_reg_req_en(struct pci_dev *pdev, u8 req_type)
 	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg_val);
 }
 
+void pcie_tph_set_nostmode(struct pci_dev *pdev)
+{
+	if (!pdev->tph_cap)
+		return;
+
+	set_ctrl_reg_mode_sel(pdev, PCI_TPH_NO_ST_MODE);
+	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_TPH_ONLY);
+}
+
 void pcie_tph_disable(struct pci_dev *pdev)
 {
 	if (!pdev->tph_cap)
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index e0b782bda929..8fce3969277c 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -11,8 +11,10 @@
 
 #ifdef CONFIG_PCIE_TPH
 void pcie_tph_disable(struct pci_dev *dev);
+void pcie_tph_set_nostmode(struct pci_dev *dev);
 #else
 static inline void pcie_tph_disable(struct pci_dev *dev) {}
+static inline void pcie_tph_set_nostmode(struct pci_dev *dev) {}
 #endif
 
 #endif /* LINUX_PCI_TPH_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 05fbbd9ad6b4..ac58f3919993 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1841,6 +1841,7 @@ static inline bool pci_aer_available(void) { return false; }
 
 bool pci_ats_disabled(void);
 bool pci_tph_disabled(void);
+bool pci_tph_nostmode(void);
 
 #ifdef CONFIG_PCIE_PTM
 int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
-- 
2.45.1


