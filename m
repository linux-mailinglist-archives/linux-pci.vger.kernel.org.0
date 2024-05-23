Return-Path: <linux-pci+bounces-7768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2286B8CCC54
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 08:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4287D1C22090
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 06:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF75F13B580;
	Thu, 23 May 2024 06:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sguFma4z"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6E313C69C;
	Thu, 23 May 2024 06:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716446171; cv=fail; b=EjyrCy8SjE71+KViJ+LlTZ5uotRMdoQF1o2d8yDaOYdA75rHGMhrttC3UBLDyUQgzImMu1pe1AyuQ29lNsXfkcZTJWDMucnTNzy42UEQQHdmIV9cdhgjEF3o+eeVPBtixDyfJob+XibaYaWlvtlcae9rs31qOzUCC8Om0y9sGSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716446171; c=relaxed/simple;
	bh=HMLVv0gg58VjhCqwAJOZXVU2O9CN73JpAtQXPPL/4WU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQ88gOMpg/ITwQngGY4DOMu0EBqqWB5/dejwc+bWEMQl5XW/MguCcZnjM89Im85IhYXNoJP4p1Y8kYJAH2t3sQEnWbdJByqiK1ABXJIDKaKjTC2q8jL4aIto93fpFU2GlwIEjem1zNEQOk4WxhRZG5KjaeOlZkkoV7SXBHO/CQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sguFma4z; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=as9Of/GEgoxCeaxemA+qE3iiuibDQk/FC4Y3zC5EuRXNgOOB3g5kt9kn6QVRM8JoUyFfpUw6yVklepd2cG3Q4BmHA/bLnPxTfd37lAgFeEde6gZaDbqgN/eW340PPBYXUYmGyqTQDQwgdFilqXQP1jEu5dC/w7zqnFBhZu1cRXEcdpn0GE/VtL+GJ7iLt/I5TOI77Sl3LXkzg3zB4MO2p061Ujr65/QzQ+1URrpjn6FcErTMEYBEd85x9xit18AUQbs5qWUMZTUTR+twRhZFtDt2L5/wTjv92m5uid70ibXwMOVAsYq0lPB3Rn4NqYBXmu/HBECUBu9ZkdyLbhfaTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aE1zdlWl0Hve9jA7n9z2Mn7xd8cBPbQbkziWOC+UkBI=;
 b=j4J98jlDq1ZKY/FDd//+HSUwzWCrBX+sEGLppQWlc3QtoH4riSRkr/KZDk5TWXFQY/C6sWcp2vE1cPU2OFjlfYaIZHEss/k/olb1dE0ZD3tTTLIzOeFqw+ZJTe8IjmIHFODjoNq4Nd/Y13gdlbwY+Yfm5Xi8JM/WlG6fjZGAQthNaWpu0DHJe7quviVQSzHuqqNjZViZFmK/LiYyLKZTBf9WYUm4355Ok0ksZMgQYNDR1HykkdNk8bTkFVbq/n3Oo3lLBpf0hvkC8glENCtq8p85q6+WSNoPlJ/byByccBRdSR7cOrzdXfaNkCdeMbyDQg748Axd3RZBiz4oh3tt8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lwn.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aE1zdlWl0Hve9jA7n9z2Mn7xd8cBPbQbkziWOC+UkBI=;
 b=sguFma4z6ENH7BD3Dt5mzHHgy6iWOOwmtePGomFPULFG3lc7WeLLO71L+U6stRomNoZf683ctZhHIdUNCa12NCzS13vC/QT5fxkwZxfK90u+2T5SyQi21DOXOQBPFcxH74rkkrvmGUW+9iCbUvqwn+LHJIPp/XBu9mIBi/eWV7FDox8kD5MgH8Yl2XquqiQLRePVAXWONjH/ZsQ0UeN4YdFZjaTH6dNYe65sMK7nDfojfHEWDJizfB6Q6InM7EfT4UbDG2AsrquBwuFFVx/e4k8jg7zUD/9RAqrPemrhCTdG5WA3S591dCtzNOD2P9eI+fH8UDrYfmlV64rfmFkilQ==
Received: from BLAPR05CA0033.namprd05.prod.outlook.com (2603:10b6:208:335::14)
 by CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 06:36:05 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::65) by BLAPR05CA0033.outlook.office365.com
 (2603:10b6:208:335::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20 via Frontend
 Transport; Thu, 23 May 2024 06:36:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 06:36:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 23:35:48 -0700
Received: from vidyas-desktop.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 22 May 2024 23:35:41 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <corbet@lwn.net>, <bhelgaas@google.com>, <galshalom@nvidia.com>,
	<leonro@nvidia.com>, <jgg@nvidia.com>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>
CC: <mmoshrefjava@nvidia.com>, <shahafs@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <jan@nvidia.com>, <tdave@nvidia.com>,
	<linux-doc@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V3] PCI: Extend ACS configurability
Date: Thu, 23 May 2024 12:05:28 +0530
Message-ID: <20240523063528.199908-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240521110925.3876786-1-vidyas@nvidia.com>
References: <20240521110925.3876786-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|CY5PR12MB6384:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c14254-4b8b-44fe-95de-08dc7af29f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXI1bmJUTFRjcDZOUFYzR0o4R0ZVWTFQR0NCUS9QbWxjN1lodnVGSDNuVFhS?=
 =?utf-8?B?bFpsd00vRHdYYmh2Q2tkQUNHdURjdU9jZ3BBcDhzTGdsSXAwL3NkdGJNSzlx?=
 =?utf-8?B?ZDNyUmM2bUprUXdZT3lRemM4NnozVERPSkcvaEhkZFZsRDYyckdwZW93SVpM?=
 =?utf-8?B?NG5OWCtsc2NOQmNqdVQ0U0FrWHJvVHp5NUtnZ0s2cGNRTzU0K0tMbkVRS3BJ?=
 =?utf-8?B?NlNYMCttbUdnditva3V4bUNGR1ZZUTVydEcySWdBalNrZXNsQXBVWjBxZFRj?=
 =?utf-8?B?Q3k1TVRidFVWVjJBZHYxeVJrRG03ZDZ1NDN0ampjazdBMjhQdmt5ZVo5ZVNB?=
 =?utf-8?B?Uk1pZGtDRGpFRitnRE5WU1ZTb3lhUm9FV3lBaDJLR20yek1zWVJDR1BQeVBX?=
 =?utf-8?B?Q0c2ZlhiZVp4SHRKVmpHRjM4bTlMd0o0YjVqNWZqNHJRVkE5R1BtMnRqcVAz?=
 =?utf-8?B?Kzc4cURuVk81UnNhVkg3MVlZSzBJdllxVEthWG1iZCtoK1QzT1VabWhwa0o1?=
 =?utf-8?B?V2ZJZFBTc0U4NGd4aC9XU1BCRjE4bEVXK0kyMThPYVVNZmpKNG8rN2VxVUpF?=
 =?utf-8?B?WERuS3dTN1Q1YWc0emVBTDVIYUNISm5jRHlwd2gzZ1hhcjhrNkpvTnoyWWNW?=
 =?utf-8?B?UmY0VTNWK1QvQUJUV2RTNWtYWjhvQ3NyRTNWVzNZWXFhMjdWN2h3QVlWdlRM?=
 =?utf-8?B?WVQ0Wjd0KzVCS1BYZnlhUlkyYTVCSDZMdGRvdVJHeUxseis1b3BpTEtha3FG?=
 =?utf-8?B?Q1dlb0hDRE12ZHBNdEJWRjBhOFBUbGw3UEV3VUtGYzVNM0Iwd0R1bXVEbEFM?=
 =?utf-8?B?YkREZVRsd3lUVTFlVGgwK1Y5Q1dYeWpSdmMya2hoeEZ3c041VHIzVVdHZ2Np?=
 =?utf-8?B?U1pNdjd1Wjc4alFOelpXRUtsWWdORlJyTDlrQjdCTUd3THI5dHpFdlpBRVdi?=
 =?utf-8?B?MDk0ZU9laDlkZm1CMmhIVHBvMkhqTUlRdnhkYmVwd3A2WDJVM2NRaFJoaDBm?=
 =?utf-8?B?NE9JdjV5OVdCUjdOQWJaMktacEdhWmNLdXlWbXBZcWRSbXEyQm9xWkE0VWlW?=
 =?utf-8?B?WnNtNlNMTEVhWDR6eGd5dyszTm1qZTVJQjhOSmsySTZHUHg0STVNLytDSDVB?=
 =?utf-8?B?MC9SS1JEOXF2ZXZIb0s5WWNaNFBFZFZpNWxTN3RrVW9TdjU5TzJ6bjI1Y0JB?=
 =?utf-8?B?Q3ZMWWZET1kyNGsyalR4Z1ladEtzdytWbDY5Q1lBS2lqd2JRU2xRTVBCaThG?=
 =?utf-8?B?ckZYRXZmUVlLWUcwQ2NQUStBTmwwVnZ3ODFsSUhaWnpQRW04ZTdlZGlyMVVV?=
 =?utf-8?B?eXpwbjJvZmdyZmp0RXlFTThJVEVYZlJyMUtyUjEwcjNybkI5REllK3AwWjhY?=
 =?utf-8?B?a3FMcElwUnRBdW03QitUa0daSk1aUTk4S09NM2JhRGtnekNLdDBLaEZ3TU91?=
 =?utf-8?B?NCtPV0Z4UHI0S3gzWU1LeDZueTF3TkR0eDZzeVFPSTFLNk14NTVuaHFyUXJm?=
 =?utf-8?B?dXc2ektKMlQ5Qk0xd3JLY0VlbjVnS2NOMTJTb3AwTnp4dmdhY3JLd1pld3V3?=
 =?utf-8?B?YzdYdzVTMEtITHIrTzR6K1dwMVJFMHNvR0xOTENrdUN0dTg0U2RnbWtDMkhq?=
 =?utf-8?B?Z2lZM1lBT2hYVXlHQUQ1bU10WkxvTGVGYVdiakhab2poNk5IeXpFb3U1VXlw?=
 =?utf-8?B?a3lkRDMxanhSbElhaVlWcDI2M0FvdTl5aGlXdTdVc05Vb2NPSTdRMDA2cmda?=
 =?utf-8?B?ZzlhNDlva2Z4THhqUUtnNERMUElSdDZqVE11N1RXeml1TDZDWURCUzZML09T?=
 =?utf-8?Q?f+JVtQA6YwVdBnpteawQRRkJA0nOz2o9TqqzY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 06:36:04.8516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c14254-4b8b-44fe-95de-08dc7af29f26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384

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
v3:
* Fixed a documentation issue reported by kernel test bot

v2:
* Refactored the code as per Jason's suggestion

 .../admin-guide/kernel-parameters.txt         |  22 +++
 drivers/pci/pci.c                             | 148 +++++++++++-------
 2 files changed, 112 insertions(+), 58 deletions(-)

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
index a607f277c..a46264f83 100644
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
@@ -930,56 +967,38 @@ static void pci_disable_acs_redir(struct pci_dev *dev)
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
+ * @caps: default ACS controls
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
@@ -988,23 +1007,33 @@ static void pci_std_enable_acs(struct pci_dev *dev)
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
@@ -7023,6 +7052,8 @@ static int __init pci_setup(char *str)
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
 			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
 				disable_acs_redir_param = str + 18;
+			} else if (!strncmp(str, "config_acs=", 11)) {
+				config_acs_param = str + 11;
 			} else {
 				pr_err("PCI: Unknown option `%s'\n", str);
 			}
@@ -7047,6 +7078,7 @@ static int __init pci_realloc_setup_params(void)
 	resource_alignment_param = kstrdup(resource_alignment_param,
 					   GFP_KERNEL);
 	disable_acs_redir_param = kstrdup(disable_acs_redir_param, GFP_KERNEL);
+	config_acs_param = kstrdup(config_acs_param, GFP_KERNEL);
 
 	return 0;
 }
-- 
2.25.1


