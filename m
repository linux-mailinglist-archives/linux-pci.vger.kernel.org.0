Return-Path: <linux-pci+bounces-19475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41675A04C74
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 23:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22473A24F4
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 22:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B06C1FA15F;
	Tue,  7 Jan 2025 22:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b0nVSMBq"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AAF1F941A;
	Tue,  7 Jan 2025 22:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736288961; cv=fail; b=lJCjDhIV+Jppou+urPC5kMPHWVF7UlyDkXyZ+EdWv7LYOJX9CY3ui+7KvBG8XhyLlPijc7A4jSzlJTdyE3B7H3NycpOZnyt9ujKJ4X+BezZdwb13OMifuGNK5teK4OGHC8rO71I8SObRvmHc6VIs+OcpfaN8+Vb+NyY9qL3NTyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736288961; c=relaxed/simple;
	bh=xjfVvZ1tTJQcU/5pcZ54OFDXcA8JLmNodnRrfoI6Ufw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azv/8ipL9SzcZof2eahxPljnqzpKb1tlR+b+wR5hSWA0poPVcKczBLr54+GhCFld/UCaJQsRNMvFYZaWZ49EBzo7eSEDXY2f/hwOy3g139AxCHcxMewjkymv+07Gnej+waP+Bh7wYxfKmF4qA+ts70Cy7Sf9iAdmvW1GcKLPVRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b0nVSMBq; arc=fail smtp.client-ip=40.107.102.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keg2RUOtf2pCx66/7myTgUpz04hNsGdMdueirOxtBB7rjmlO/lNYUjKb2nmMs3vQn6hkRPn5p0eJmJCZLvbIsCUWxLVxx3ju0Rx4VPcuyd5wgeBiskUqXSyofZ8zNohNnRVOy63PpzzeJrEaqius/TYTAXNe0S4aduCVB+N6lcKNMKaLRYZnYPg0ysSfZipFY6PIcuOYMUUbhVXfbrw8I/YRqd+JCJHtbMR0NURY5CKqQZ3RyaPnaUXfJ55Cr62vDhjtBT+QGG1416wv8Og7YV/7Gb8lgQ3KlYp5MgW0GGzoMD/UBA3zA0ydz8ruJXT2IJlsQMewcU+whIwInsBQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hz/ojI6o+sEDWZAMKn+EMapoICQf8/2vD3yUaxG5JV0=;
 b=RRA/KAv0ISK7sGlVcctA29y5Th2bbQtU4oB2Fh4lCOYjtkQNZO5s1kPLLNKqr7H+RZSX+G26vuDRpfNi8N/MJJsZgFTHy5J6T6T4wkGt2jQDh7LAVlK0K5lMMWAxYdRijao+ib5t9Qfq7K4qI9CE1ZlcnywyDfJVKBkG/K6e/6zpBzddgVTtBaNK6RLZYnU1zrG+wMlhn07RnmfSyXlDC0uyo1Z6LspMOYQL1lTmkbf/jC5rmGP9IqZLYyoJHZ/c/+tK39RyBlEb1KJZZWm4uSDm0k+00w2EgVZOx87wgZz3qwnLawHhv+BpDftTC800idoVU6PV14s0zi8tUVxw4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hz/ojI6o+sEDWZAMKn+EMapoICQf8/2vD3yUaxG5JV0=;
 b=b0nVSMBqT8zLtdp4clZJiWbQ8Gts7/J1W/pZd06OunwIQT26Vw0p0MVtV0gZtS0tDlLNkaui7KAxszPfqvTR2siQcN0VjCudzwC8gChcom8ZFVwlWKRW0kFYBn6BAINEo0s80nJ2/dSq/EqbG2VTalh7qRjCiaQiYQ2h6oS6mkE=
Received: from SJ0PR13CA0237.namprd13.prod.outlook.com (2603:10b6:a03:2c1::32)
 by CYYPR12MB8939.namprd12.prod.outlook.com (2603:10b6:930:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 22:29:12 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::20) by SJ0PR13CA0237.outlook.office365.com
 (2603:10b6:a03:2c1::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 22:29:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 22:29:11 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 16:29:08 -0600
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
Subject: [PATCH v3 12/12] x86/amd_node: Use defines for SMN register offsets
Date: Tue, 7 Jan 2025 22:28:47 +0000
Message-ID: <20250107222847.3300430-13-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|CYYPR12MB8939:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ef55e5-7978-4fcf-8ec5-08dd2f6ab59d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PrxOb2CZBgZg8ZPyhZJRNuDObvXfV/gyTKDnMgFQZ+XaJvhYgQJH5FBDma6L?=
 =?us-ascii?Q?F/rnvdv//4hiU85o77BJ0oqsSa+gJZ10vVHcV1+OuDZNhG3cYgFnvhkNiR5/?=
 =?us-ascii?Q?uRNJUDHIMl85E+utrSw/BA3jrVs0dN8TZu1viaRZMFCkJBSqxnctv9yFqytj?=
 =?us-ascii?Q?TgNoiuF9Tcjhpk8s2Ulv6OzRcwr21YGqQGPnk8AixgA9RIhdo5AJegZ7wgPC?=
 =?us-ascii?Q?1eLf6SfW643HQrw63WzCf8ybZJwxA/o2qf9hWOWQSdN9W/fJlGgW7QPvuZJd?=
 =?us-ascii?Q?DCCj41qjLtFiCVyesngyGkyZaK28uwCHEGO1O1mDLNgKTqiwTNxtTqheaB8l?=
 =?us-ascii?Q?iiEMVAazNS1AtA2gSn+1ZZOwhtvkWSwNIEk//HfgSsBoiITdp85G7IA7xjkG?=
 =?us-ascii?Q?GalDnNe5AMrJHOot6Y3zpnj6WSLlSH+krwxsjDVyZ+cnJMACm35DqAJKtKnB?=
 =?us-ascii?Q?wHw/hgu7DuE7A2pvDos2xnQkBG9fhx9JFkFk7wN5U6mSq1yk6lunR68eKBDq?=
 =?us-ascii?Q?iXq73XMQKrJoKvs+lj2gHQINtKgPBCkA8kOgjYTRppJwLQ6mGRblAOxRoJlK?=
 =?us-ascii?Q?eQWdQC6+tCbOGFiM+nxo7IL8gnA78Hg1mWfNm4NCoqRKGdCT0igLTMtRFlnu?=
 =?us-ascii?Q?bS3HxOT96w/PbkcBCIxL4d67x/NHOh3zjzBJWW4jaAqvRi9NEzbV5VT42vgi?=
 =?us-ascii?Q?UPO9XC1lSCdTpQ+b64nvRrcVWBgCgb2ckCbxUQRhTDc/mGcavFxt0ugeziFZ?=
 =?us-ascii?Q?n/6oPCEVlHsruJFtfKu7xrn/2rMZrlOrW3sMS8AVQUwnT+e/QhdDuU0PGh8C?=
 =?us-ascii?Q?0E6CdznBCx0MqSWnSg/mbYe+0ZZlF7BI9qbPsM3/BWullq4i9RMBd5pOk6up?=
 =?us-ascii?Q?P8/bIDh179YloRMP+eFqkedA72FAkOw/7xycPR3CbcfAAFHZGoxzmgKw7tXv?=
 =?us-ascii?Q?y1nwkC08Vi+O0kSTVRJVQDYyI3N/STyjbsvlbpNVRh2dulvR+klkmvSNdywc?=
 =?us-ascii?Q?EMibHrJMdk6O4H9LVNc5xwYJ6m3ztvRxdjqELxtHfnqJWAEBN5Y5Qb9YTFCv?=
 =?us-ascii?Q?oA4wkhzQrccrFlUZs7lHNMOxLY+VBkGDoqLiRAU2KaA6lxWRNhxg+WF2EIy+?=
 =?us-ascii?Q?WcAq0PsV09tjM0h7WNzfa8KPDCrmn51hXB9gRsjtANzftpVvEo4XAH4NgDJD?=
 =?us-ascii?Q?b8vT0qVjI9NSREJ7cLZF7UQ130bqo+Zl5bNJiM0xALfcVURF2iELlmq6FZK5?=
 =?us-ascii?Q?lZsw8flFwuRh4wM6+6jYAH8uxiucLl+MYSpljDs/rwMDdNjIOasICc28QLPY?=
 =?us-ascii?Q?g+Qmnw3fhQ2kHYWRvl2bgXleZOvJrRUW8kAWbMtlPNRIPgDovKrauLjcyTQs?=
 =?us-ascii?Q?aiK0nudfeoBZzbYJ6jsTB6DE6BWhdz83JPNdTYpn+dFa+K06qnLa2F/BiZzz?=
 =?us-ascii?Q?khD+T3wd2yp2w11srEjzBaYzBPrFQFO+flSApX3ICuLhGz4lNrz66Ep4Zem0?=
 =?us-ascii?Q?Gbwrqxf9o6XtUsCrq9fd48Qfrj+jqBCgBXup?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 22:29:11.4956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ef55e5-7978-4fcf-8ec5-08dd2f6ab59d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8939

There are more than one SMN index/data pair available for software use.
The register offsets are different, but the protocol is the same.

Use defines for the SMN offset values and allow the index/data offsets
to be passed to the read/write helper function.

This eases code reuse with other SMN users in the kernel.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241206161210.163701-14-yazen.ghannam@amd.com
---
 arch/x86/kernel/amd_node.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index 45077e2e6f2f..d2ec7fd555c5 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -94,6 +94,9 @@ static struct pci_dev **amd_roots;
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
 
+#define SMN_INDEX_OFFSET	0x60
+#define SMN_DATA_OFFSET		0x64
+
 /*
  * SMN accesses may fail in ways that are difficult to detect here in the called
  * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
@@ -131,7 +134,7 @@ static DEFINE_MUTEX(smn_mutex);
  * the operation is considered a success, and the caller does their own
  * checking.
  */
-static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
+static int __amd_smn_rw(u8 i_off, u8 d_off, u16 node, u32 address, u32 *value, bool write)
 {
 	struct pci_dev *root;
 	int err = -ENODEV;
@@ -145,21 +148,21 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 
 	guard(mutex)(&smn_mutex);
 
-	err = pci_write_config_dword(root, 0x60, address);
+	err = pci_write_config_dword(root, i_off, address);
 	if (err) {
 		pr_warn("Error programming SMN address 0x%x.\n", address);
 		return pcibios_err_to_errno(err);
 	}
 
-	err = (write ? pci_write_config_dword(root, 0x64, *value)
-		     : pci_read_config_dword(root, 0x64, value));
+	err = (write ? pci_write_config_dword(root, d_off, *value)
+		     : pci_read_config_dword(root, d_off, value));
 
 	return pcibios_err_to_errno(err);
 }
 
 int __must_check amd_smn_read(u16 node, u32 address, u32 *value)
 {
-	int err = __amd_smn_rw(node, address, value, false);
+	int err = __amd_smn_rw(SMN_INDEX_OFFSET, SMN_DATA_OFFSET, node, address, value, false);
 
 	if (PCI_POSSIBLE_ERROR(*value)) {
 		err = -ENODEV;
@@ -172,7 +175,7 @@ EXPORT_SYMBOL_GPL(amd_smn_read);
 
 int __must_check amd_smn_write(u16 node, u32 address, u32 value)
 {
-	return __amd_smn_rw(node, address, &value, true);
+	return __amd_smn_rw(SMN_INDEX_OFFSET, SMN_DATA_OFFSET, node, address, &value, true);
 }
 EXPORT_SYMBOL_GPL(amd_smn_write);
 
-- 
2.43.0


