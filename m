Return-Path: <linux-pci+bounces-7715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B688CAD21
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 13:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B98281C5F
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 11:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF8D6D1B4;
	Tue, 21 May 2024 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CzomieTr"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808695029D;
	Tue, 21 May 2024 11:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716289784; cv=fail; b=BBiVFGFsl8LXgYQwnwvbADff6ryW6wO27Nkqx+tW+iPGIcWq0U+PSVjpNTM/qLRJzzVRzP3/6OF4zTBR8RhW+lS82As4cwKkYDRKrhHWWa7FlA9J9sAapIAmAuVd3OA3tJoFVs0+MYpMN8Dz3EcqOpznOedQQyemUcE89xmFzXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716289784; c=relaxed/simple;
	bh=saCCHBHO7L7g9l37RyRu9wk6LYLXfdcBQczpUFBvIEc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fs2T73JJyWO1G30C/Wyg85oNtFfzaaPsbsHer6TJ+xG0qzDkLFDQIGL3bjwec5DKGaOM708SV1sHsfccIO4fS4G4ez5lS6yM7s8MXeAAKNb/fVEPAXgoX5+0cHwqlL5DjLgusdadCp0Y26cUFQsYpmlU9VCyTkV68Lpke35Q9pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CzomieTr; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnTCAmW0L2DXD4yNiVOitmVIFn3sNlrD+dKPdMKeZkPKES7regzofKRRM6VS7a+SDI9KvkMUuEZdSd3CcrzBN++ZhOGWtPcQw585NEjJdDlKqRSWJEPTbtUDQkIO+8hiVXEkKEYQ+f1zoChUUOGcecPLzuAxKbSrXIYwGSvGPfojy6fnhci225ftDZUkwA52oEHOHDOh7IB6n4r9OnW+wpjHxvEnYYacd33vdOlBHoMjwZo2qYBm1CH8ssAvLgxynEeTMVopDgVQds/xTpYsP3nLh7qd81wmRYuVfJWeETRFrv27DmBkvmiWN+cs7t2T+KXV7/iQUbNsPTbO5+Z5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUJcxN2n+Won7ugGGRgQ6dwwDr/8zvL358J6+VN7PKA=;
 b=RF3K8yRyz7BR+8HlNFuyeLUy++ZGw9MkQamMgNbtChZXTqyTcBngIuRPaQF6eUzs3kwgAthjg3Wk+eDQ+KRqqZnEQAARkRZYuo6lvrqsglm5oXo7SZd8OWkNBC+nnpB8ViQ8FKZuxFKpuELeJrfpYl1PV/TDidd1XkEYiayygyYWtT9F3uAnkmeC6dcTS7P+I1TqpiZJqQw4EDSgpMl7iE7rrRnMhCv2H6x52M0LAp5j+B3z+Jv6Dgd9xoclNsNpwBsfkZXmMENCIEjUymwJqoIZt8uLeNfunumWaGij/FxNFkRaEOQO4oJwdpsuZb7eUmkYy8AJVcz2JzfVpRHwCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lwn.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUJcxN2n+Won7ugGGRgQ6dwwDr/8zvL358J6+VN7PKA=;
 b=CzomieTr1jhuIFrYEki87qVeF9Nl5AnMK1aZJeGeGIzgcp2cV4ljVkmw61B9JnslaqirpMRMWy4tE5kq8t5WeExLW3jZw51/8CKuFJJihlLxEXgynKh5yYyy+JfJYzdweQDuoBepSvJ1MtIICoA0YAICqhO300Gy7TIFlLTZIiWlqk3P3EMAFDt6t646IVzXy69jlNh2F5Hwbjv3RH62EAfkcvyewSxD338SLfhjOs6s8udOR7WQng0TZ5M+Qxepg+PbjT46H2Z5lwGUxKvK70sje4m2B067QSnM2IKFNzusuNzu1A619yTS5JOkwu56CJOMTwb6HfkZN/JaTepmbQ==
Received: from DS7PR03CA0330.namprd03.prod.outlook.com (2603:10b6:8:2b::22) by
 IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 11:09:39 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::f8) by DS7PR03CA0330.outlook.office365.com
 (2603:10b6:8:2b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Tue, 21 May 2024 11:09:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 11:09:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 21 May
 2024 04:09:33 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 21 May 2024 04:09:32 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 21 May 2024 04:09:28 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <corbet@lwn.net>, <bhelgaas@google.com>, <galshalom@nvidia.com>,
	<leonro@nvidia.com>, <jgg@nvidia.com>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>
CC: <mmoshrefjava@nvidia.com>, <shahafs@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <jan@nvidia.com>, <tdave@nvidia.com>,
	<linux-doc@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2] PCI: Extend ACS configurability
Date: Tue, 21 May 2024 16:39:25 +0530
Message-ID: <20240521110925.3876786-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|IA1PR12MB9030:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af04927-393b-4ef0-5b92-08dc79868225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHpxNVA0T0pKaGFSYVNMUmwwOWxaVDNrMnUrbk9mUmdLeEh6aTltY29YQ0Fi?=
 =?utf-8?B?ZmxvbzRuWWtLSmdxb1lTWE1RNUwyaTErM21OYklWelpkZ1VxQktFbUptWHdI?=
 =?utf-8?B?NVJ4MHJsQlBwVkFOdUhaUmRIT200eDI5QXhlTTQ3VTdjc1k0RVc5cVZMQWto?=
 =?utf-8?B?MGpmT1hadnBEMXZJTSt4TXR6U1RXd00zVzJ2S0R4RmIxcnphSDA3bnpSV1h6?=
 =?utf-8?B?OStvdE42SEluTUlHS0l3MzNkbzExOWFlV29NY21FYnJIVHg0VnovT3ZkWUZH?=
 =?utf-8?B?MHl3Z0JGdi8vRmJjQnBhdHg4TkxwdFk1TFZiOTcreWxxNUdQS1Jad2k4c1Za?=
 =?utf-8?B?UGU5K0NaL3IwNURKTDN5VzRINWZ1Vk5Hc2J4VmVaSENTWE1jK1R3U0NucWx0?=
 =?utf-8?B?RnVwanJyMkltSUwrbkxjNFdLeXZva0R1dTRhZ0hQeHhpTUxhcmw5RS9SMWs4?=
 =?utf-8?B?WXdyNS9vbTRDU2NxaDI1dk5pY014Zm5zNExGTU9EOTBpd2JUVnp5NURudVlZ?=
 =?utf-8?B?RStROVZWeVJxM01ONi9FVTRqMWVveVB6djE3RUhpc1JyZndPZ1AvbzRjdzha?=
 =?utf-8?B?K0dOemZXaUlTWjNobUJaOTRVY0ZadFV4aE05SHdEcUR0TFlBVERwRDhRSHVm?=
 =?utf-8?B?ai9XMExZc3pOSEd6dWlWWGQ3SFpibWdPLy81T1ZrSks0cXdVME5iZGc2YVh3?=
 =?utf-8?B?bHh4K2xHbEVqMy95eEhvUWNKaEJ1V2U4RnFmUG5KTlV2LzZJYkQrOFVMSXJI?=
 =?utf-8?B?L1ZxNUoxZnJmTmthR1RUeUYxbEYxNVhyb09USVBlK2hEMmtXV2pXWEZtQ2N0?=
 =?utf-8?B?TWFMN2tYNDFhcXJMdi9ZVFVtSU5LM1dML1RPUDNEeURWTTlXc0dWOGJ0bUhQ?=
 =?utf-8?B?RTFLdXhmeDc4MmhHbEs3S0dyT3dEd0JrTXkra1hpTTgvbnpRS0VMVDl5MEg1?=
 =?utf-8?B?ZkFhNE9oQ3NpOEtTWmJ3Qm9oQWk1NEFNSkNlR2tPalZFeWpyRk53U29FVldV?=
 =?utf-8?B?TmN3Wjh0WnVMYnFhaEdUZmwrT3JDWDEyRHMzSHM3bzIyT0NSc1lDdVhXb0Fh?=
 =?utf-8?B?dGc1RmFQOU9PVXUrZUNEY1JKYVM1aFBTWVNMK1g3N1VuaFkrRWZ2dFlvQ09B?=
 =?utf-8?B?c1ZCbmgxRDk1WHdiT2pPV0NYQk9FUXI3UC9LU2t5MjExd2JNWHYxNlQwRDJj?=
 =?utf-8?B?UUdKUERRS3pvT2ZwYnJGOWw4d2RFOXN4cUpYYktxQ085cHdvMFBqOVk0eEp1?=
 =?utf-8?B?MTA0TGFTRkZoVWtuMlc5L1ptclZ6aUNmU1lBQ1U5NUFNdHhXcGJYbHplemFU?=
 =?utf-8?B?SU1IRENlS01hQzFDR3cyTTNZeXkvSWNscjdXNXdrVk15dkdWendNa0l2dDhK?=
 =?utf-8?B?YWVnSEJrWkZsbmF5ZkZUVUd4ZHhaTTN1dWQwN0Jyb0lsMDNhMHZzaVl0dGMx?=
 =?utf-8?B?SGhxSUxOOG5GZytmVWR6NFBDbktyQk8wd1J6QjAzQTMwWGs3SHlwVUhJOVcz?=
 =?utf-8?B?QS9USmVJSE10NDg2UTNTci9uUEk1dlRUejZhamtORlIxdTExTkxkTDFaVGti?=
 =?utf-8?B?STdCSDB4bENmc2RBZU5YRUp3emxYSjY4cTJkWEh6M1JTZTZIZW90Ulp3dGNz?=
 =?utf-8?B?NERsSzk3TGxhRDkwR1RJY05CUDRsMEE0TytZTmlOTzZOdllMYmtyUGVPVzdW?=
 =?utf-8?B?TmZ2TG1TMFd6N1dnS2NhWG5NcUo2MVNiTy9BTElaTkNOZ0tySDBRM0g2c3ZS?=
 =?utf-8?B?NGNTdmZ3RjJtTk5WQkoyaVVqSVVFK2FPQkp0V3BTM2JQeFd4SFdvS0dhV2hi?=
 =?utf-8?Q?hT3TdoQgtfePFD4/NyVGzPdKFtE51+54CFSrQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 11:09:39.4270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af04927-393b-4ef0-5b92-08dc79868225
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9030

For iommu_groups to form correctly, the ACS settings in the PCIe fabric
need to be setup early in the boot process, either via the BIOS or via
the kernel disable_acs_redir parameter.

disable_acs_redir allows clearing the RR|CR|EC ACS flags, but the PCIe
spec Rev3.0 already defines 7 different ACS related flags with many more
useful combinations depending on the fabric design.

For backward compatibility, leave the 'disable_acs_redir' as is and add
a new parameter 'config_acs'so that the user can directly specify the ACS
flags to set on a per-device basis. Use a similar syntax to the existing
'resource_alignment'  parameter by using the @ character and have the user
specify the ACS flags using a bit encoding. If both 'disable_acs_redir' and
'config_acs' are specified for a particular device, configuration specified
through 'config_acs' takes precedence over the other.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
v2:
* Refactored the code as per Jason's suggestion

 .../admin-guide/kernel-parameters.txt         |  22 +++
 drivers/pci/pci.c                             | 147 +++++++++++-------
 2 files changed, 111 insertions(+), 58 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 41644336e..b4a8207eb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4456,6 +4456,28 @@
 				bridges without forcing it upstream. Note:
 				this removes isolation between devices and
 				may put more devices in an IOMMU group.
+		config_acs=
+				Format:
+				=<ACS flags>@<pci_dev>[; ...]
+				Specify one or more PCI devices (in the format
+				specified above) optionally prepended with flags
+				and separated by semicolons. The respective
+				capabilities will be enabled, disabled or unchanged
+				based on what is specified in flags.
+				ACS Flags is defined as follows
+				bit-0 : ACS Source Validation
+				bit-1 : ACS Translation Blocking
+				bit-2 : ACS P2P Request Redirect
+				bit-3 : ACS P2P Completion Redirect
+				bit-4 : ACS Upstream Forwarding
+				bit-5 : ACS P2P Egress Control
+				bit-6 : ACS Direct Translated P2P
+				Each bit can be marked as
+				‘0‘ – force disabled
+				‘1’ – force enabled
+				‘x’ – unchanged.
+				Note: this may remove isolation between devices
+				and may put more devices in an IOMMU group.
 		force_floating	[S390] Force usage of floating interrupts.
 		nomio		[S390] Do not use MIO instructions.
 		norid		[S390] ignore the RID field and force use of
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a607f277c..862df97f1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -887,30 +887,67 @@ void pci_request_acs(void)
 }
 
 static const char *disable_acs_redir_param;
+static const char *config_acs_param;
 
-/**
- * pci_disable_acs_redir - disable ACS redirect capabilities
- * @dev: the PCI device
- *
- * For only devices specified in the disable_acs_redir parameter.
- */
-static void pci_disable_acs_redir(struct pci_dev *dev)
+struct pci_acs {
+	u16 cap;
+	u16 ctrl;
+	u16 fw_ctrl;
+};
+
+static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
+			     const char *p, u16 mask, u16 flags)
 {
+	char *delimit;
 	int ret = 0;
-	const char *p;
-	int pos;
-	u16 ctrl;
 
-	if (!disable_acs_redir_param)
+	if (!p)
 		return;
 
-	p = disable_acs_redir_param;
 	while (*p) {
+		if (!mask) {
+			/* Check for ACS flags */
+			delimit = strstr(p, "@");
+			if (delimit) {
+				int end;
+				u32 shift = 0;
+
+				end = delimit - p - 1;
+
+				while (end > -1) {
+					if (*(p + end) == '0') {
+						mask |= 1 << shift;
+						shift++;
+						end--;
+					} else if (*(p + end) == '1') {
+						mask |= 1 << shift;
+						flags |= 1 << shift;
+						shift++;
+						end--;
+					} else if ((*(p + end) == 'x') || (*(p + end) == 'X')) {
+						shift++;
+						end--;
+					} else {
+						pci_err(dev, "Invalid ACS flags... Ignoring\n");
+						return;
+					}
+				}
+				p = delimit + 1;
+			} else {
+				pci_err(dev, "ACS Flags missing\n");
+				return;
+			}
+		}
+
+		if (mask & ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR |
+			    PCI_ACS_UF | PCI_ACS_EC | PCI_ACS_DT)) {
+			pci_err(dev, "Invalid ACS flags specified\n");
+			return;
+		}
+
 		ret = pci_dev_str_match(dev, p, &p);
 		if (ret < 0) {
-			pr_info_once("PCI: Can't parse disable_acs_redir parameter: %s\n",
-				     disable_acs_redir_param);
-
+			pr_info_once("PCI: Can't parse acs command line parameter\n");
 			break;
 		} else if (ret == 1) {
 			/* Found a match */
@@ -930,56 +967,37 @@ static void pci_disable_acs_redir(struct pci_dev *dev)
 	if (!pci_dev_specific_disable_acs_redir(dev))
 		return;
 
-	pos = dev->acs_cap;
-	if (!pos) {
-		pci_warn(dev, "cannot disable ACS redirect for this hardware as it does not have ACS capabilities\n");
-		return;
-	}
-
-	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
+	pci_dbg(dev, "ACS mask  = 0x%X\n", mask);
+	pci_dbg(dev, "ACS flags = 0x%X\n", flags);
 
-	/* P2P Request & Completion Redirect */
-	ctrl &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC);
+	/* If mask is 0 then we copy the bit from the firmware setting. */
+	caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
+	caps->ctrl |= flags;
 
-	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
-
-	pci_info(dev, "disabled ACS redirect\n");
+	pci_info(dev, "Configured ACS to 0x%x\n", caps->ctrl);
 }
 
 /**
  * pci_std_enable_acs - enable ACS on devices using standard ACS capabilities
  * @dev: the PCI device
  */
-static void pci_std_enable_acs(struct pci_dev *dev)
+static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 {
-	int pos;
-	u16 cap;
-	u16 ctrl;
-
-	pos = dev->acs_cap;
-	if (!pos)
-		return;
-
-	pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
-	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
-
 	/* Source Validation */
-	ctrl |= (cap & PCI_ACS_SV);
+	caps->ctrl |= (caps->cap & PCI_ACS_SV);
 
 	/* P2P Request Redirect */
-	ctrl |= (cap & PCI_ACS_RR);
+	caps->ctrl |= (caps->cap & PCI_ACS_RR);
 
 	/* P2P Completion Redirect */
-	ctrl |= (cap & PCI_ACS_CR);
+	caps->ctrl |= (caps->cap & PCI_ACS_CR);
 
 	/* Upstream Forwarding */
-	ctrl |= (cap & PCI_ACS_UF);
+	caps->ctrl |= (caps->cap & PCI_ACS_UF);
 
 	/* Enable Translation Blocking for external devices and noats */
 	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
-		ctrl |= (cap & PCI_ACS_TB);
-
-	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
+		caps->ctrl |= (caps->cap & PCI_ACS_TB);
 }
 
 /**
@@ -988,23 +1006,33 @@ static void pci_std_enable_acs(struct pci_dev *dev)
  */
 static void pci_enable_acs(struct pci_dev *dev)
 {
-	if (!pci_acs_enable)
-		goto disable_acs_redir;
+	struct pci_acs caps;
+	int pos;
+
+	pos = dev->acs_cap;
+	if (!pos)
+		return;
 
-	if (!pci_dev_specific_enable_acs(dev))
-		goto disable_acs_redir;
+	pci_read_config_word(dev, pos + PCI_ACS_CAP, &caps.cap);
+	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &caps.ctrl);
+	caps.fw_ctrl = caps.ctrl;
 
-	pci_std_enable_acs(dev);
+	/* If an iommu is present we start with kernel default caps */
+	if (pci_acs_enable) {
+		if (pci_dev_specific_enable_acs(dev))
+			pci_std_enable_acs(dev, &caps);
+	}
 
-disable_acs_redir:
 	/*
-	 * Note: pci_disable_acs_redir() must be called even if ACS was not
-	 * enabled by the kernel because it may have been enabled by
-	 * platform firmware.  So if we are told to disable it, we should
-	 * always disable it after setting the kernel's default
-	 * preferences.
+	 * Always apply caps from the command line, even if there is no iommu.
+	 * Trust that the admin has a reason to change the ACS settings.
 	 */
-	pci_disable_acs_redir(dev);
+	__pci_config_acs(dev, &caps, disable_acs_redir_param,
+			 PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC,
+			 ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC));
+	__pci_config_acs(dev, &caps, config_acs_param, 0, 0);
+
+	pci_write_config_word(dev, pos + PCI_ACS_CTRL, caps.ctrl);
 }
 
 /**
@@ -7023,6 +7051,8 @@ static int __init pci_setup(char *str)
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
 			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
 				disable_acs_redir_param = str + 18;
+			} else if (!strncmp(str, "config_acs=", 11)) {
+				config_acs_param = str + 11;
 			} else {
 				pr_err("PCI: Unknown option `%s'\n", str);
 			}
@@ -7047,6 +7077,7 @@ static int __init pci_realloc_setup_params(void)
 	resource_alignment_param = kstrdup(resource_alignment_param,
 					   GFP_KERNEL);
 	disable_acs_redir_param = kstrdup(disable_acs_redir_param, GFP_KERNEL);
+	config_acs_param = kstrdup(config_acs_param, GFP_KERNEL);
 
 	return 0;
 }
-- 
2.25.1


