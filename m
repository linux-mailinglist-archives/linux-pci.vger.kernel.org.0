Return-Path: <linux-pci+bounces-7221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3604F8BFBF3
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 13:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635311C2125D
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 11:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F058174F;
	Wed,  8 May 2024 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jYuuvzo1"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD881ACA;
	Wed,  8 May 2024 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167653; cv=fail; b=Ltug+o6KZmrOuZzY5BsC7kQOitN7edbfQ/lGt8qEPwpX4LmFXKAZRkLkeSraDlv796zPj2XagtRwoTe/PZkJRjxIibOvjGJgYBuMMVmeWWYGMOFivhukMPDXZwInFGIF+Gebqxh0CaAJBdJ1AtHn4xwRnWVkfi7uo9egbYZMOZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167653; c=relaxed/simple;
	bh=alU1ZDgrzr45WpqQixiTgtbQfoEJDUgfn7w85CTMORg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UK1aQaRV1rLlBbPS01HAcmxHy0CstVeobQ1Cj50DnQYX093+i53pZ5q97uypGNYi7F4ZUh/01yUZg8t2wD07+liqB4/gGrQUndBWVKx0UXd2alfzvGNjrQdtGvTK0O/EjGSjXrzn/SFKGF8pjXguEONwGt1fSkaOOkVhPwQ0ySs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jYuuvzo1; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDI+jS/JQzNtQKiF+0ZhyWMwe9pccMeKjvV1jldCnhnhtlEQi1zFmMkV9CAN5OO0T1awJYkPADw42UK7JoqS8wQ/GlU5UPwm0TvAUHO93yQRol4YdrNh5LWqOIBnqSeg+QH4lcaI1vHJnnhFyNYDieICvE14c8MZjoX3TYxhBBR707I2N2YsYMqp3iVW/lf+hAqhvrl7Sr/w1vE5SuUTGX3urjBxnouOSNWIYX3a640tSk+XX9zyxsfmaUEmWggJMieQ5gTVLAEY/08nLASwK+3eJhnAoS3OqxShcbkBvC0MmNSjX85Va8FIiM9oaMhtNoKpgwlzcUl9Fzigr2aQ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6XpHvbRm83eDZCXE0++oixUcydx3uKJHMJZUoSIlPU=;
 b=BCqGingzJMrijDVjyVF01MUENSidSOv1Ne8E2BGGts8Xn6v4fgdFWR8E1+XjJm8RKRhMJN1uKqayOmBmzmyn3KGLGzCbvuQLXi57RzOMQht7tfx834fEX8sHUeNJuN23sPXmVsUgz8xjG+k21rZz5j+vaObtLPrCmEeKByR3UO/23ooNZhDplDFpCrt3sdVbkV/tq/rDnk3D2csZ63LHpXcL90E8bYi0Oq/AimUyqV9fl33c+ZjoDYX/a9mf1kihDraTuCbKVl90DKNBosA38sX/fGEgeG/rEDHVtxQlIzTd90Ky6BycnUMyOY6ne06ZCzHCkZ+ehg97mWWAf/Bcww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lwn.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6XpHvbRm83eDZCXE0++oixUcydx3uKJHMJZUoSIlPU=;
 b=jYuuvzo1zhe4adMX34M9g9BJuQS8RRG8RwtrRGSiU/kLFKH7zZ/qcIamHFTgIi6WAuGS4aFyq+Lv1r3WmPxdlqiyDMK/rCceujua17jCmleyA1Wisiuti82dv9I/1KigQA+tGDOlo+PSZLOylNSIgXDWKzWwUkSjfMMGMnhjPm6jy/pW5aVGYJXn2mXL7xZ9EZwEvvybj2tSstXuPW878yucD3A/ElybouZn9bhqY8pQ2Q2zVSCujTJaBIlyLp/5i4o97BEXgQOaMaqNoQ1AfpCgvRkaDTDMi4+uG88dDN3ErWtoXKy/EJqwfMld8UiaI3admslKrx1SG8/nf3z5iQ==
Received: from CH0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::10)
 by PH7PR12MB6658.namprd12.prod.outlook.com (2603:10b6:510:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 11:27:25 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:ef:cafe::ae) by CH0P220CA0004.outlook.office365.com
 (2603:10b6:610:ef::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Wed, 8 May 2024 11:27:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.0 via Frontend Transport; Wed, 8 May 2024 11:27:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 04:27:07 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 May 2024
 04:27:06 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 8 May 2024 04:27:01 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <corbet@lwn.net>, <bhelgaas@google.com>, <galshalom@nvidia.com>,
	<leonro@nvidia.com>, <jgg@nvidia.com>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>
CC: <mmoshrefjava@nvidia.com>, <shahafs@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <jan@nvidia.com>, <tdave@nvidia.com>,
	<linux-doc@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V1] PCI: Extend ACS configurability
Date: Wed, 8 May 2024 16:56:58 +0530
Message-ID: <20240508112658.3555882-1-vidyas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|PH7PR12MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: b2cdb56f-d45b-4d56-903f-08dc6f51d595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anp5K3dGS0JNM3NGTTZTeVQxcWJsVWJqeEhpU2I1OGhLY2pNY0UrNGozNW10?=
 =?utf-8?B?RVErNWkwb3ZpbmlldjJxQTF5K0orUmhTbVQ2Wk5jcE1HTElQVDMyV1dDLzd6?=
 =?utf-8?B?Rm5MdlNFV2xOZmpwb0g2YkRLeENUYW5rcUU1NHQzejVjUDFDWExGNlRmdXFR?=
 =?utf-8?B?Q3lmV0FNNVUrQy9CZFFMbW1XMWhMcXN3Y0N4WVU3bjhrSDMyUDA0STdaYzZK?=
 =?utf-8?B?UEdTclc2M3R0cC8yUFRKajB3MmF1ZjIvNWk4UXJlMmIrcUtoVGI4NHdkbytR?=
 =?utf-8?B?U2xjQUFHWHlKcWRHbHlKR0RvemdrRytFaXRRRk53Z3RXWUNoaFB1Yzc5WHJS?=
 =?utf-8?B?TWVYQlgyczRpKzFoeFh0OGlrNTZrdkFjQ0gxTWJCTjRadkJBZk16NHBrTzhr?=
 =?utf-8?B?Yy9HemF5RndET1U0K1Y0Yjl3UURHMzlWZWpDeXFoZWZmVkhucVg2V3dsZ1hL?=
 =?utf-8?B?bGdLdUY3WG9Zc1pSTjhRU1RORlBoM29FSnZHQitmSEVVZGFoVDRUaDVpbVRG?=
 =?utf-8?B?bFRTdHN4R29vT1RNaEZSc3ZzcWNXam9KVlN0blRWVVBjdkY1R3BScFY5RGRJ?=
 =?utf-8?B?dlY5NzJrVzV1THpUTzI5Q0hVQVh0SEF0OVhiK2xkc3lxU01IQTQ0WjJyckU5?=
 =?utf-8?B?WlNLOUlHNmRCdTVOdXNqNDgxMTJ1Nk9YaXVwVkZsMzFHVHljS1JtZ2kzK0p0?=
 =?utf-8?B?ZjZ5a2QwNVNPNllDcmpCa0dpeDNDdm95aVdxSlM1YVV1Nk03ZGd1bSt2THVu?=
 =?utf-8?B?VGlqTVNveDhNZGdZVzFsZlNDVlA5T2labklJaWJnTkFIR0xNejZiYVVRK3Mx?=
 =?utf-8?B?NTExQkdGUUdyRjlBYm83bURwQjNKMmZ5NG9mRVdMZmozcVNoSzdKbGlMbE5r?=
 =?utf-8?B?TWpWcnBmSnY1ZXQvK0hLdXNjcHNlSzFHU2dUajV3dG9adHErV0RHeForWGJm?=
 =?utf-8?B?SldUclhQUi8ybytxSDZlK3crdk5vRjd2UjUrcWhZdFFMY21xcE9aZTBRb2Q1?=
 =?utf-8?B?RS9zUndHN1RLa28rRTZpRmFVRW8wYzlLNGFONDNKMUp6MjNwaFVkZExQazND?=
 =?utf-8?B?NVp3cDByYjhHTCtsNDU3Z1BsdDdONEVkRzIxMXdmcys5dlNjcTVrckVQLzBV?=
 =?utf-8?B?blBJdC9FUTlYNnNVY1BQSUZYZEsvV0NwVGdFRkIxMWdFSCtXS3RkbXhrMloz?=
 =?utf-8?B?UmVFWEtNV05WM2lndjNDNjlEOGgvcjN6aHhCeWhRaDNId1BvMXNwTFM1b0VE?=
 =?utf-8?B?S29DQWJZS2FOcGY4WEg0cWZZVVh0YW5rTjV1VkdnS2h6T2JBdlNqWHpKdXpo?=
 =?utf-8?B?RmVFVzBvQjkzZk0wWEdCWWFFSFlLNWthdnNmem5UVGtvSmJVQ3o2VTR0MDR5?=
 =?utf-8?B?MWdDdnkxU3dLSzI2WHpQVjNLODBycFZoV1NYVDJlMEtvZjdXeDM1VWZ6aEFZ?=
 =?utf-8?B?dUwzSW9EOURrYlhCRkNPeFNsb2dRelFHMmgvRGw0d0gybGlROWcyaWZQM2VY?=
 =?utf-8?B?Vy85ZUJ6ekdrZGtvbUE5Ymd1NGtCb0ZMQ3VHUU9NN3FtSUUxVkxJOXlFUTBJ?=
 =?utf-8?B?U1E2Y3VCam5ERGp2VVBkaEl6eHZNMlExV2xXYU51SzMwMkowZ3pIK1gzbmxR?=
 =?utf-8?B?YkVLdElla3NIRmk0enU0WDllSlBsVHJMK3kxQWFLdDJvYVFPSlc0VkZzRFRQ?=
 =?utf-8?B?VDJyYlFIQys4ZjhPNlBlejRFZ0ZVNmoyOEh1K2pzWlVhemVaU245djRuRXAr?=
 =?utf-8?B?VW4xM3F2N3UyM3BOOFBJM1dhbDBWbVhMR2Jkczc2V3VsN0k3NDVrYkhKSjR0?=
 =?utf-8?Q?65fmb5QvphHG77Efcy+l1JuD+6Fo+POtYpkR8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 11:27:24.3650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cdb56f-d45b-4d56-903f-08dc6f51d595
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6658

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
 .../admin-guide/kernel-parameters.txt         |  22 ++++
 drivers/pci/pci.c                             | 119 ++++++++++++++----
 2 files changed, 119 insertions(+), 22 deletions(-)

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
index a607f277c..0ad48ade9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -887,30 +887,59 @@ void pci_request_acs(void)
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
+static void __pci_config_acs(struct pci_dev *dev, const char *p,
+			     u16 mask, u16 flags)
 {
+	char *delimit;
 	int ret = 0;
-	const char *p;
-	int pos;
-	u16 ctrl;
+	u16 ctrl, pos;
 
-	if (!disable_acs_redir_param)
-		return;
-
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
@@ -932,18 +961,60 @@ static void pci_disable_acs_redir(struct pci_dev *dev)
 
 	pos = dev->acs_cap;
 	if (!pos) {
-		pci_warn(dev, "cannot disable ACS redirect for this hardware as it does not have ACS capabilities\n");
+		pci_warn(dev, "cannot configure ACS for this hardware as it does not have ACS capabilities\n");
 		return;
 	}
 
+	pci_dbg(dev, "ACS mask  = 0x%X\n", mask);
+	pci_dbg(dev, "ACS flags = 0x%X\n", flags);
+
 	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
+	ctrl &= ~mask;
+	ctrl |= flags;
+	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
 
-	/* P2P Request & Completion Redirect */
-	ctrl &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC);
+	pci_info(dev, "Configured ACS\n");
+}
 
-	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
+/**
+ * pci_disable_acs_redir - disable ACS redirect capabilities
+ * @dev: the PCI device
+ *
+ * For only devices specified in the disable_acs_redir parameter.
+ */
+static void pci_disable_acs_redir(struct pci_dev *dev)
+{
+	const char *p;
+	u16 mask = 0, flags = 0;
+
+	if (!disable_acs_redir_param)
+		return;
+
+	p = disable_acs_redir_param;
+
+	mask = PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC;
+	flags = ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC);
+
+	__pci_config_acs(dev, p, mask, flags);
+}
+
+/**
+ * pci_config_acs - configure ACS capabilities
+ * @dev: the PCI device
+ *
+ * For only devices specified in the config_acs parameter.
+ */
+static void pci_config_acs(struct pci_dev *dev)
+{
+	const char *p;
+	u16 mask = 0, flags = 0;
+
+	if (!config_acs_param)
+		return;
+
+	p = config_acs_param;
 
-	pci_info(dev, "disabled ACS redirect\n");
+	__pci_config_acs(dev, p, mask, flags);
 }
 
 /**
@@ -1005,6 +1076,7 @@ static void pci_enable_acs(struct pci_dev *dev)
 	 * preferences.
 	 */
 	pci_disable_acs_redir(dev);
+	pci_config_acs(dev);
 }
 
 /**
@@ -7023,6 +7095,8 @@ static int __init pci_setup(char *str)
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
 			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
 				disable_acs_redir_param = str + 18;
+			} else if (!strncmp(str, "config_acs=", 11)) {
+				config_acs_param = str + 11;
 			} else {
 				pr_err("PCI: Unknown option `%s'\n", str);
 			}
@@ -7047,6 +7121,7 @@ static int __init pci_realloc_setup_params(void)
 	resource_alignment_param = kstrdup(resource_alignment_param,
 					   GFP_KERNEL);
 	disable_acs_redir_param = kstrdup(disable_acs_redir_param, GFP_KERNEL);
+	config_acs_param = kstrdup(config_acs_param, GFP_KERNEL);
 
 	return 0;
 }
-- 
2.25.1


