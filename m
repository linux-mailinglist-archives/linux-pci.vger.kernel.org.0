Return-Path: <linux-pci+bounces-9243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1699F916D19
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 17:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D586B212F0
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 15:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C3C43ADE;
	Tue, 25 Jun 2024 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j00yzSkr"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E9BD2F5;
	Tue, 25 Jun 2024 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329561; cv=fail; b=UyIYPh8UbY17414aRaFxJEkZURIdW+DEaLfM2tFu7qHFFIhuIipF+gqcnm93l9l+eUXsNJkxflAUpslltVHRLGPgmdlhiyEnRlxWaWYCcX0ZszvkaUQHsWjvgI6hlcXQHmyQJi8SPhbmvxMf/ywhhFk4T8gr6gJFJ6l7DK0csIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329561; c=relaxed/simple;
	bh=KHt0RpG5dnA8kOae25yt32DIykKult4obl/GjxJeeYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CypYcgA2wSZDP5ucT0k8cWOWUIEeZEDnoRoXn7oQ9dzd/DvkxyrznzOY019A+1V9Hq5fzy4nsGNSH6JEb9tTXExzL90K2ACXKVUjPgPdO+u7tor3GFgc6oAuiBpr9RqLiA6Z3K+IuUgUdKwb5hA1E1Gh+xPxdH/LKcNrmPRCWSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j00yzSkr; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCsR3aFCjyogkDFisn1v2SKm8F1Y74+pzfW7p6WJ1kt5B/TgAleZdK7kEXSDhMrWOAmrK2KaXC7FFhVRZXFtMznW7cKY/pGT5RVSoPUks4tAotz8hJVJmmO8XtMvnwc7DfGs4AEnQlFvJbh2zlycTUfV4sYfauEDt0bot5CG4VQjsbDHmR6VQy+M9FZ83knntwuh2fbbzTEwTswsf5bqgc2TYT81jhLFOGMzU3V4fsuqUilGQurQqKCIQpko6vh2I5hVCRAH2krQ1O01yri/cFbGIwZNh0uhT5w/ab5ERgnKQ+Dy4/G3mCPmCJwU3ZTlprRQ72n5KWye9WvxwIdwAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GaPJcGVSdfrhNeh0Ebq+VIaaX4/pI0PSg5FeC3SeCTw=;
 b=MGYS7sYGGQfPRGAXHt6iefdsPqD29zY7eBhbe2l34stvMwJsjgJ7Buzs7i3WrNilzX+25EfFTTULWa6CoUKpoP0uG1B8WURjhpsQgluFz13Fgcq5Am0lF7vp3vm8RkKWSQ0YEdwC2cymIFFUNJvZnyTG9/qdCZTyRJc5DJInAkQlkqAvcgPspGYPL4K8ORxubHEsB73EWDN38LFgipJaSR6MSh9kRZi9fO5i/8W0i9Iy2pwRSEWcGK4XXAOzPBR6FuTznGPh2u9dPZS1xR/08Dg863j2v7xRo86ick6omkPE0SnBfOjuC5VO7VhVaCj13OLjikSDckwJ1nCrfE8vcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lwn.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaPJcGVSdfrhNeh0Ebq+VIaaX4/pI0PSg5FeC3SeCTw=;
 b=j00yzSkrfUBpk6eLCSFBNOZue7l8S0iYQKoQs7yTAs9xZ/hRs9W/lpIomSvb8Ll7zCQOl9wZTF3uwvjLco6RAuDCmQy1zm4kbckuRIzdQeqLKw+DauSoResECskwcJF9sHfIzMMRu1ZYHvbfI/ShA5uwRfFRt3SJPqTczfDZEBeHEnVodhYzvqGhPbC9y+2ODkJ0XfQn+0cnvFzYRaqWGxN5ClYT8d9Qyd+CqBh2+zrnfQMQQ9v4dh5l9o3HMTtrbOykU8p+m+sMj43zrQvW3Bcf/WWQm3c6lNBhym0IFTb9yOV9CjwoiAe9imRy5auNjNhsicfjGH4GHWvP7mZBHA==
Received: from BYAPR06CA0071.namprd06.prod.outlook.com (2603:10b6:a03:14b::48)
 by PH7PR12MB5618.namprd12.prod.outlook.com (2603:10b6:510:134::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 15:32:30 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::a) by BYAPR06CA0071.outlook.office365.com
 (2603:10b6:a03:14b::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Tue, 25 Jun 2024 15:32:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 15:32:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 08:32:13 -0700
Received: from vidyas-desktop.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 08:32:07 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <corbet@lwn.net>, <bhelgaas@google.com>, <galshalom@nvidia.com>,
	<leonro@nvidia.com>, <jgg@nvidia.com>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>
CC: <mmoshrefjava@nvidia.com>, <shahafs@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <jan@nvidia.com>, <tdave@nvidia.com>,
	<linux-doc@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V4] PCI: Extend ACS configurability
Date: Tue, 25 Jun 2024 21:01:50 +0530
Message-ID: <20240625153150.159310-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523063528.199908-1-vidyas@nvidia.com>
References: <20240523063528.199908-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|PH7PR12MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 586d6fab-24da-4653-ca1b-08dc952c062c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFdRUThXbXpxN3R0eThkb3Nza1E3SG5Ba0twMTVzNUlPS3g4dXgyMWw0TzFI?=
 =?utf-8?B?eW9USFhLWkpzNTc2R3lpcWdpVDlyRS9tSUxHZHVBbjUxM2F5ZWQwcDEwL0lm?=
 =?utf-8?B?YjZGUkpvQUtJQTlQL2VSYm1YNDFWS1RuOHdRRzNnL2pPNUY1N1ROcHVwY04w?=
 =?utf-8?B?RzNkZjRqUDRrTndQQUQyY3pON0g4VHl3alVFdFhuRDc4aXhZZ0JCVEU2cm94?=
 =?utf-8?B?aWVrZlhHYS9OdjAwSUdPVU1IR3NHYVNKOG9hV1NpRTFTYngxb2NPT3dyeGZF?=
 =?utf-8?B?WEM5RE5NYnRDZ0tTRlhuTTQ0ZVp1ekYzRnZGSjR2S2hUOHVKTVZnZ2ZLaUZv?=
 =?utf-8?B?KzdBalp3MTlrN3hGa0liNWdFcFkwaFlmUUt2L1o2c2NibjJtdDdnWWgyRUsw?=
 =?utf-8?B?Vno3M0NUNHZ5anYxTDN4UHA5NTRybythWTlVKzZNdGdvRnZkNW5rRWkrRE1C?=
 =?utf-8?B?WURPR282OVBGS3I0M1dnZG8wajRTWkNBNThBR0RJQ3VrbHhBS0M3cFk4SUc0?=
 =?utf-8?B?dlJHcGFHMkRCbFJ3S1RGSm9tWEgrK1FEVytHRWtpNWRhYVFiakZhNzRnaW0w?=
 =?utf-8?B?bWNsOXBsNmxuK2p1REgxY2E1S0R4K1BFQXVyeUNPalc3V2JNR2QyK1hMWG0z?=
 =?utf-8?B?eXhzV1o4WGhOVW9PQUUyNXdqdTljT1BjM1NUdEtNa084Zno3VjJleDFUNVdj?=
 =?utf-8?B?WTZOZXNLdGNzOU1uSDRGTVFvb3BMWFlzeW1wa3BRcWNVZVNuNzR3QlUyRjFR?=
 =?utf-8?B?OHRwMk9mbzRZaTJuS3FQR0J2SHRvNlZZOXV4NGkwNTZ2QTl6eGx0TGhXQ3ov?=
 =?utf-8?B?K2RIcks1SmdRd3dDVzdaQnlsSzRGNk5HOUgrM3orZWZXMWpTL09HRGFhWE1M?=
 =?utf-8?B?Q3FvUTNTVXdhWnZGNzFYZWpuU0VRMk9QNC9xOWlmQXkwNmppZ094NWptaHpz?=
 =?utf-8?B?a01GZVQwTGg0N3lGSEFOc1pnQzZ2Y0kwTGZaSytvOWpGQ1hwNE1HdnpscmNy?=
 =?utf-8?B?OWQySklLTGxOVjhVTWNCdFRwRk1jUk1qZlZuNVIwclpBWEtkTjdGSVB2bml4?=
 =?utf-8?B?U3gyUmJmOCtXeVFpZGdBMFB0ZzR5c1NFYVFtWlF1blRGTTUxb3pHQkNiNFBp?=
 =?utf-8?B?Y1RGeWpyckVyWGp5cHVnSXlRdHV0UTk0Q0FzT3hBeFhhQkhSUTlZMlAzYjN6?=
 =?utf-8?B?WFNrWkx3emJDWkYya1g4UW1QTnpMbTlERi9NZ3pRSUwvTGkwcFQ1YUttTm1y?=
 =?utf-8?B?S3VYYUZ4M3MrL2lScXdGT0ZqNXlRVUJKUVFBeVVlYlQzQkRIYzFjNVdqaEJ5?=
 =?utf-8?B?SE9DTDZUTktSWGxEdk44OU1VN2pOVFR0L0tOa1VqaGpZN0tWZzFSR0hBZmNU?=
 =?utf-8?B?NTAxQVdRV0gzdzBBMHhWMVZqRGJncTRtRDIwU3VHZXFDRk9XQmVjUFk0Z3o2?=
 =?utf-8?B?Vjc2YXFMREZNbHMvVk02TVBIVDMxTFJjZ3kreGdid2ZUV2dQVnZXSldrYmxk?=
 =?utf-8?B?ZlRadjkxOUFtRHVZY0FsNlNkZjRDL2J3UnUvZGpXbkljditTaktHQ2dnNXRz?=
 =?utf-8?B?bWVxZlVqcEpkNmE1ZUsyWVZXR3N1cUFHNkp2YkxZTnZRUWQwVmV0c0l4czFP?=
 =?utf-8?B?cDk4MnA0M25PUkgrNTk5VU5zWTBXWmFSNER4ckRaeVFWdGx3Z0xpT2tsY2tY?=
 =?utf-8?B?Zm1MdlN6YVJNNlMzNi9vL1MzMVVmVHlDbU5jRkZNaVRWQXNMOXFreVMyUmhB?=
 =?utf-8?B?MEtPQy90N0o1S1FZZXBkZjh4Y3N2MUZCc1RDdGZnTnNjbDQ3SmJUVXJlYm9w?=
 =?utf-8?B?NWkrVk91Q3VCVXJHNVZMcHNzVFdnb0lyc1gzY1RpUkVYbWJ3M09MT1BXM1d6?=
 =?utf-8?B?MGpFYTljamlDR0dQdG1ZSlcraklPemNyYitTcEVDcmVEbUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 15:32:29.4153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 586d6fab-24da-4653-ca1b-08dc952c062c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5618

PCIe ACS settings control the level of isolation and the possible P2P
paths between devices. With greater isolation the kernel will create
smaller iommu_groups and with less isolation there is more HW that
can achieve P2P transfers. From a virtualization perspective all
devices in the same iommu_group must be assigned to the same VM as
they lack security isolation.

There is no way for the kernel to automatically know the correct
ACS settings for any given system and workload. Existing command line
options (ex:- disable_acs_redir) allow only for large scale change,
disabling all isolation, but this is not sufficient for more complex cases.

Add a kernel command-line option 'config_acs' to directly control all the
ACS bits for specific devices, which allows the operator to setup the
right level of isolation to achieve the desired P2P configuration.
The definition is future proof, when new ACS bits are added to the spec
the open syntax can be extended.

ACS needs to be setup early in the kernel boot as the ACS settings
effect how iommu_groups are formed. iommu_group formation is a one
time event during initial device discovery, changing ACS bits after
kernel boot can result in an inaccurate view of the iommu_groups
compared to the current isolation configuration.

ACS applies to PCIe Downstream Ports and multi-function devices.
The default ACS settings are strict and deny any direct traffic
between two functions. This results in the smallest iommu_group the
HW can support. Frequently these values result in slow or
non-working P2PDMA.

ACS offers a range of security choices controlling how traffic is
allowed to go directly between two devices. Some popular choices:
  - Full prevention
  - Translated requests can be direct, with various options
  - Asymmetric direct traffic, A can reach B but not the reverse
  - All traffic can be direct
Along with some other less common ones for special topologies.

The intention is that this option would be used with expert knowledge
of the HW capability and workload to achieve the desired
configuration.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
v4:
* Changed commit message (Courtesy: Jason) to provide more details

v3:
* Fixed a documentation issue reported by kernel test bot

v2:
* Refactored the code as per Jason's suggestion

 .../admin-guide/kernel-parameters.txt         |  22 +++
 drivers/pci/pci.c                             | 148 +++++++++++-------
 2 files changed, 112 insertions(+), 58 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 500cfa776225..42d0f6fd40d0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4619,6 +4619,28 @@
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
index 55078c70a05b..6661932afe59 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -946,30 +946,67 @@ void pci_request_acs(void)
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
@@ -989,56 +1026,38 @@ static void pci_disable_acs_redir(struct pci_dev *dev)
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
@@ -1047,23 +1066,33 @@ static void pci_std_enable_acs(struct pci_dev *dev)
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
@@ -6740,6 +6769,8 @@ static int __init pci_setup(char *str)
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
 			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
 				disable_acs_redir_param = str + 18;
+			} else if (!strncmp(str, "config_acs=", 11)) {
+				config_acs_param = str + 11;
 			} else {
 				pr_err("PCI: Unknown option `%s'\n", str);
 			}
@@ -6764,6 +6795,7 @@ static int __init pci_realloc_setup_params(void)
 	resource_alignment_param = kstrdup(resource_alignment_param,
 					   GFP_KERNEL);
 	disable_acs_redir_param = kstrdup(disable_acs_redir_param, GFP_KERNEL);
+	config_acs_param = kstrdup(config_acs_param, GFP_KERNEL);
 
 	return 0;
 }
-- 
2.25.1


