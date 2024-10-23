Return-Path: <linux-pci+bounces-15129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFE89AD272
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 19:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11BA21F21FEF
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 17:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197C21CEEB2;
	Wed, 23 Oct 2024 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CMlxkEZk"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D9875809;
	Wed, 23 Oct 2024 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704130; cv=fail; b=J/ANrAF5tp3uZDfKSJeoRp7m7bfFQDElAwxbA/q6emUsO+/5iFpxHvdz9IRBAsEoYlS1tYSQ23Gy8WLTDMOypFd0K0qp4ID40DulbOdj+1mjMYk0/E4bJpzpKJLJGtwTg73sIOgMQ/nt4QXq7lMpJJaRHKN1toaZ0TITBwi3Pw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704130; c=relaxed/simple;
	bh=/uV2y9qYhLf9P9mABYvlYIAtQ6LQiCFoqUU1/0/I8Kg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbm/UzhCfQhp6HBfHVvp1SzG/aRbaJN6bEsspzbdiw+pCH03S+wYoshbmdssq+9XE6NJ1lBYcvRQBOV1GiQuelTehcO0vR2XRIvqciA31As24BjJFQJ/E/0QtbDTOFqGZ7TkM80+Gv2vz5AVUpLSDMmgTe8j19fv3BACxYoLgms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CMlxkEZk; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfIgjWS+PYjLyg8ah+gWPlVzKamZd6F/1L0BNAnCDWIaDyv+5klDk3n+CQwtnOs8WsPFur2hvahLGQffoN6RaNZ8TFFCacFE1YQDp7DdhA5F6GIPSvqZZoAtJRErO/CC4LKBkaC88TpF6jO+vjRsOyf7dHMaOUblmWCt5hJ+ie8HMRM3EY3zn6QzCb+vsKZkE0QJRJbZ9Vk8CYLgy8q0oieWmN5XVesrHtTHi6uLribRwaoUb/ofQWvo1iOUabJywOsR3VPR7tzw5ujd2xzJHcKGZhkrcFYhBLA8E7qBni3kClmCauSlvdBG1Pafd5aFJhuY3j19MzW/+E9HUMdLwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYTLkH/mZD7UGt5ZYPEGA+hEksxYN49GsZlC9wOy8jA=;
 b=P/SAQxzbZuMeNb/c/plZdlBuHtBBlOSb2Gvd6k4zi2X9vbbaMoVfNT03e1OkEz9WJ9slMgieMYr3f96W8ENJCOhiUMz81VYyx1DvgFDbKdjPSsw/iLfmE2IkKuVgm7nhTw56EqRLNmeioli+zvCJZmS5lupOkkrk/qQwD/O0qAV48WWcfssUvK/C/3QHw91qiJHJ3qZ+M+K4RbfSOdVN7htlK/3mam3R2VhIvFwudSDuVQhaU052lTWJaEyIT89vkPe79+exthr224nJKQSIKELt8BsKVDgaVpPdejzYy0DncmWTEEz7btzp5zz8gbZfJ20g0jJ5pcCwnGkkwZB0mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYTLkH/mZD7UGt5ZYPEGA+hEksxYN49GsZlC9wOy8jA=;
 b=CMlxkEZkZdy2DrrL1kVe7AwIWBJlruFTZ6ZhQ89kdhxQrk1f8PghFdg4q4AS5bLkFA26+t8pi8gc5r8hQkMqOTSVJnpod3hKKvn5RKvHqLMEKecRwgPdDpiDMb7DBpCg2mb6wkFf+XeH4bgKIZQ9qOXzfZHWzg2yFenTcCDkyU0=
Received: from BN0PR08CA0009.namprd08.prod.outlook.com (2603:10b6:408:142::13)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 17:22:05 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::c8) by BN0PR08CA0009.outlook.office365.com
 (2603:10b6:408:142::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Wed, 23 Oct 2024 17:22:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 17:22:05 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:22:04 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, <mario.limonciello@amd.com>,
	<bhelgaas@google.com>, <Shyam-sundar.S-k@amd.com>, <richard.gong@amd.com>,
	<jdelvare@suse.com>, <linux@roeck-us.net>, <clemens@ladisch.de>,
	<hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>, <naveenkrishna.chatradhi@amd.com>,
	<carlos.bilbao.osdev@gmail.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 02/16] x86/amd_nb: Restrict init function to AMD-based systems
Date: Wed, 23 Oct 2024 17:21:36 +0000
Message-ID: <20241023172150.659002-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023172150.659002-1-yazen.ghannam@amd.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 02210d45-db06-440b-3062-08dcf3873771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wKja+YVymazqWY0OC9EqY2kfRXUxVulHmRHXEAG1TyDG+IeEOhgXaSp+ZZUj?=
 =?us-ascii?Q?WFF62jRqi3ww3il1O3yj5NAHV28P6wddjMi6v7bdEcpFtaUnHJ+V5iM8zNJH?=
 =?us-ascii?Q?IlXqsAlallW4rD6LMykjNbD7I+2sfQOZ5YrT0ORSafdJR9eU/6f7Cw2Bj3Rt?=
 =?us-ascii?Q?gI6Abj3EbB6D+AEji2b7Xjmlsq6BIh3vguMM2Jrg37TO5hF0zvW0vFalypo0?=
 =?us-ascii?Q?QvWpfWDjAW9JhVDeet7Xb7MzlpyotXERnb6d0yUJzmALVjIa5GIxaWTKYzFl?=
 =?us-ascii?Q?85Ax7ws/uJx7fowfueJNxMorqe3blljayuBMEOGGIZXAv8sy7CC7O//AXxRL?=
 =?us-ascii?Q?tgi+aDsXLzWwK4Gq3oPyp8XgeTirdfVB9oc3F1k6gTdfF2zBWe+aadZp/NTW?=
 =?us-ascii?Q?FSFka9MZUUfffxWYJPYnZEz84mZOEfMCWjb++RadvRxPH86FTTl3IoNsEa94?=
 =?us-ascii?Q?8c3DNkan7w3DxMdoTI/J7VF9FVOrWo4dH/RPJg0V4oWpSPx8Gol3TL+20DEp?=
 =?us-ascii?Q?8g/Vcom5fthir2rtbSKzmI+LPY9IhUAkBHW2WT3IVk6tcBh6jM7FGLiiJER6?=
 =?us-ascii?Q?inu7U8uKCf6WiaBI2qFk9Au6vG6YkWb3Hy4M4rZY9o10Lus1yuKqZbYs/TfB?=
 =?us-ascii?Q?9/P+CRUFbi9iIDLorEz3Ec5q9UVWaKEAYs4uxUGaPlhtnZcTSYDYb/VhxppB?=
 =?us-ascii?Q?UDQs4pWzIuHqgz1BJQj50Mt1HOuT5Bbm7K1f9V1ZyO+SBOMH4Np+XqbUBrI9?=
 =?us-ascii?Q?sNvMOckRj+Nu0LeouGkXYkluTQW2nLdsUUL2oy5vOYAQq39ZSEHwduMK6BXY?=
 =?us-ascii?Q?HRzxdVE7IfSSgpYyI7vPJNvUDdV7V9GnOgsCIVpn9/xbaDqB9REz8WaQnH7U?=
 =?us-ascii?Q?LfKPNEPfiCFa49y0HfCCuNn7L//pS+6xWrC6+edbAr0VJnw7FKylvzxVlDvH?=
 =?us-ascii?Q?/xUuHm2vU47YU0tORnkgmCjz463OzfkcCuXJI6FBNwwQZ9oYRisEE9UUJrAi?=
 =?us-ascii?Q?FO11FlCsmmEghog8svhl8pVIOBqpv9JwjiWBfrC104eL6y3ABngIUBeH7LuR?=
 =?us-ascii?Q?Dnzd/76kB98t0t3IV+j+5w3hMk8+7UXDkZuA6kMFcM2hJJpTj2JW7GbxGFwu?=
 =?us-ascii?Q?fzQ29kw81exVjH+6VkEr+rJVeRwTT/6Yai1q/SQUJtegcZS9Dfh9FzKFxCHF?=
 =?us-ascii?Q?OUoe1k/YxnTjV1rc18iEGrE992gFm1NZFf1pgs3F3jCpRr6eOBqWJQBDTgx6?=
 =?us-ascii?Q?aD5rGiyrxeLAdo0njpnLUCtZVaKTXdZmfj4OMiQcZFVrDTMUJ6OhmK1eN0SI?=
 =?us-ascii?Q?LL4WmMV59CmZHWPOcsNAL1D3IMNDz44lgIxVNbzRNRVotZrLvCEM7969f0Jt?=
 =?us-ascii?Q?J5gZip7i2DGvrHr+pArrDPJcINPspXKTH7JRP0BNjRnTQb9c7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:22:05.5442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02210d45-db06-440b-3062-08dcf3873771
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979

The code implicitly operates on AMD-based systems by matching on PCI
IDs. However, the use of these IDs is going away.

Add an explicit CPU vendor check instead of relying on PCI IDs.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/amd_nb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 9fe9972d2071..37b8244899d8 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -582,6 +582,10 @@ static __init void fix_erratum_688(void)
 
 static __init int init_amd_nbs(void)
 {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+		return 0;
+
 	amd_cache_northbridges();
 	amd_cache_gart();
 
-- 
2.43.0


