Return-Path: <linux-pci+bounces-32747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2BFB0E303
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 19:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330753AB9DB
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 17:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC552641E3;
	Tue, 22 Jul 2025 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NWNWn/6M"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8213B29E;
	Tue, 22 Jul 2025 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206651; cv=fail; b=SAA2yfXj7YDx7yQgzcuz8GJ3GBLJjCcMN2dNMUCwU3Z0HA0Y4qSI9PXWzIAMxbTYU0IEyECD0f7XanmR2CQy7uetIRBvxJmzVOVWZRLti4rOPRklJC8G9mUpjpXOOpjj3xL+uC9FLapZeaZQ1c4HRLFWHQ2zeA81fmS6YtUQupk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206651; c=relaxed/simple;
	bh=wFScrugirTYEG11k0//VoDI/lMZSBJq2uBpP1RQAZuE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TCvHFJF/CpFfI/j9fuvvZ8DjfbCSe71tpJajm6OhasLJCD4oPx/cYpzLVEzF3PURv9SBFf0Nyda/atpAPK1QFIC6BY+EzG2zm+clpKePTWHmQSpLksz5rbLc1jrA5FOrvqns5zKCmPkHk4LCJXv45Kni+30j8LGM4ZCcu3X8pfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NWNWn/6M; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVyJjw/HvWD0z/hao+1/sDEb+4AIeJat0hhDAmTxZZa6QuxjZ9qox541wjKbnTawKfGkyl7DxJ1a213pYTvB35lFT+2Rbe1ADCaiATEfCkQNCr+ZOlUYN4omJYpS62RqXG7FtVO3/FFvzrNJBYwLVvL2sbPsRyzjkNeRgBbeLSZL/rR2dD62c3x+erBKllP3M9VHxLk8F9GBclM70woOK65vx2m+y4mDNB0YhCNey+lUX9Wi0yc8bB2H//m87Hhl0SLna5VK5vLbLS+eSGdaXVL+QiDya3kKOapiwxRDQBwd51BBkbtVv5xVl9n/moyQaDcSX41eKYaDr0v3d8giXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlVLUWdk7I67k1A4oGmxAnmzXpeaZH3Ipbt6N6qXdiU=;
 b=qMxOaT8/RhHTsnPDWt5HKMrIurmHr4t5w6mIaYMTIkfEK6jC9D+D1/Zp7lrqydItksvvAVCJBS0DtVwcCLD4zpAMVVcw2iLsaeHXMZ3pEvdNRIr6lRTCyxdoqLmF9/u3lh+CJZy/wkKZ45gk1GD0vAkfJl0+GzPxubXYlz8ccMC2wd0zm+qconV1Q1j3G1feTMV6vshOnqfDhENP5N9OtvIcArDvKFhR40NUixSHQfjb68wQ+03SRPB3WeaxYgN0J/n7wkXrDoMloMAxy916aH2FILQMx8Eqy6P1Yd+ZYi+9GaHzsl59XxQ6RY+nMSd1fMutCXaoyw2fqnjGO5VXGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlVLUWdk7I67k1A4oGmxAnmzXpeaZH3Ipbt6N6qXdiU=;
 b=NWNWn/6MNVtgaMQt5pvDeGSXRjyO/IvExlsD/VmT1irL4WO0wVhhj7+EYadOAM9VrXzmB7d5e8pmRDcXhl6aVYHg24yQcmE1/9Cn+Og8tDEeBgLU2b/3i4TgKHQvQX7Y8hJYByFVvURLbMZpSKipVNI+4oeG4MXYIHHej2QOQis=
Received: from BN9P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::25)
 by MW4PR12MB7237.namprd12.prod.outlook.com (2603:10b6:303:22a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Tue, 22 Jul
 2025 17:50:47 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:10c:cafe::b5) by BN9P222CA0020.outlook.office365.com
 (2603:10b6:408:10c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Tue,
 22 Jul 2025 17:50:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 17:50:46 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 12:50:43 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <linux-usb@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
	<westeri@kernel.org>, <YehezkelShB@gmail.com>, <bhelgaas@google.com>,
	<Sanath.S@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH 0/3] thunderbolt: Update XDomain vendor properties dynamically
Date: Tue, 22 Jul 2025 23:20:23 +0530
Message-ID: <20250722175026.1994846-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|MW4PR12MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: bc783a0d-42ec-4738-7017-08ddc9484997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4tK60CvTLquTaBXuIotYszr05+9rojHjEXRT3n07k2bPDdQGdBLae1bQimbF?=
 =?us-ascii?Q?yHpnhXt2CGNGkwdHzgq/8CgqhbxgwMiRvPWDdX3PTXsHEegRaXiJF2O8iRTA?=
 =?us-ascii?Q?0PoKwE5P4b6UufI2vU/KLlUbP54lwQzYNjehhUDfYMmNHCZWX+iVLE6GDsyc?=
 =?us-ascii?Q?TSai48iPPt7LfQFAkMb6T0MUZXht1s9GByHRh4Xvs5V6EbVfotsBaD1BEzj6?=
 =?us-ascii?Q?0SYJFSeEiEioqmWNKrm2JWO9lsJuVnabelbspAiAyhRNxQmdoj8CDupJKJXB?=
 =?us-ascii?Q?y27vOq8T6QQGXcu5fLura2Ql4d+9U1Z98XBAKfzyP5YKdlHvjNOiPrvkFRgf?=
 =?us-ascii?Q?gG+Bz38Grlq1Oq2StUksIkO428vJMcaBzazT+JRZJbAC9UIxwfCKXa4bTvjE?=
 =?us-ascii?Q?iHEypWWXarUcVdoTZ2gr9mwjnjcN4aLFxJfC3hpqc29ZulpKfKWgQLZY3qnb?=
 =?us-ascii?Q?yW6yVECTsQSeyedguzB7IFV5Qb7VghkPkv1g7g4tg9yLCugP2y/uQMcAuNlf?=
 =?us-ascii?Q?o2jnzPM3uFZ4yqGh+MKwNnFHrYMkBCjRDyD/L2hVSNcqk2ejdjNs8o0OwGd9?=
 =?us-ascii?Q?pT2t15fOtPtBJEKbG2NjJLow9YtW3sA/SsPitxi3/58U0rZ0pgmgmcLmTVLX?=
 =?us-ascii?Q?KablTvWflRrkzEgZJnyDceAAwg2cfd7xSZzjsJCANPotNSEkU0TwX/Rhv+pI?=
 =?us-ascii?Q?hjnDR/v52KjS2sDmbH/ps3TC7wTzARYKF0O0YkUH+8BUwsVwSRvGOpZw1ena?=
 =?us-ascii?Q?deKHKBS2MoeYaxQP5FMoFd9kFLb5/dW4+VoMh5MTtBOD5ecS80Y0gOc133Ib?=
 =?us-ascii?Q?hpGtAOKHqNrl54Ht2MEO3nySfMP8aOHu7X+WMSqZLfk3sRy6lxJyPS7vXSsI?=
 =?us-ascii?Q?aKsH7TJshFPvnCCNpmcdKY38pUa3/5hXbVK/zYEy4C4kYaQaA05mYP3wmBNu?=
 =?us-ascii?Q?bf5oqqi/vWqWY0whexozvXEjvV3YaK/H3QvQvyrtUp0arvWpqWw+G4Pm4xDl?=
 =?us-ascii?Q?MeT2z+hez4TqBtNkYiawyJ1xQwZqs6dArVLD77dJ5vWmbTftjOmj4j3LTDEq?=
 =?us-ascii?Q?0H6cVN9wGjpyYMDRPlSCKAlZ3q6VmcrD2sM9mIFnaWb1KkL1GQ2SOKxgrD8k?=
 =?us-ascii?Q?W/Np0DYdkbAL44AUQk9skUJWSQFqrZP3wMGSXOEL1sFMv0jmZXE3Oe5Rd+/I?=
 =?us-ascii?Q?XufKAwMerrlS0XWNSZP/MshnlrO2vOz8y8NjrEz7hCnX2GjK3EnWCeTUtNE6?=
 =?us-ascii?Q?XdkhljJ5XGZh91IUowq2fhcyBdu9HWv3mR4uCPloZvtOKZc9cjpV8Ap3Wvl3?=
 =?us-ascii?Q?mR+rvlxnkWpHL1B1+N/K3zrGCeJm72HYbtyJWD/KoPlWCOo15Pj3Mf8R+DVi?=
 =?us-ascii?Q?Chc7Wzg3wUr+l+3g4QbZa7yjBz5kFIOm+oktppmfNJ5BNn0DZu7bBBJTwJSN?=
 =?us-ascii?Q?VnPLIBqhJIddaKmCMSOQKQAtGoMn63ngkZ4YD1g28GrWBDlypnipvbQmCLXj?=
 =?us-ascii?Q?tmPUWLL2NhUSSVrngZteWhN1kOCEfwvoup4y?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 17:50:46.5540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc783a0d-42ec-4738-7017-08ddc9484997
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7237

This patch series aims to update vendor properties for XDomain
dynamically for vendors like AMD, Intel and ASMedia.

Raju Rangoju (3):
  thunderbolt: Dynamically populate vendor properties for XDomain
  PCI: Add PCI vendor ID for ASMedia USB4 devices
  thunderbolt: Add vendor ASMedia in update_property_block for XDomain

 drivers/thunderbolt/nvm.c     |  2 +-
 drivers/thunderbolt/xdomain.c | 32 +++++++++++++++++++++-----------
 include/linux/pci_ids.h       |  1 +
 3 files changed, 23 insertions(+), 12 deletions(-)

-- 
2.34.1


