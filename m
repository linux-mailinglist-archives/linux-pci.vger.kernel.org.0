Return-Path: <linux-pci+bounces-15134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4098B9AD290
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 19:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62C241C21A3F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 17:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB921D47CB;
	Wed, 23 Oct 2024 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IgQPnZFh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D98A1D14E9;
	Wed, 23 Oct 2024 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704136; cv=fail; b=hBRI8CdGOGwIkNl2b7O3NZxac+tDMMp7ItOly8D4nLjlRJ8vxDu9KBgCXapmniK6jo6zQA/EuQl7MQ3OFwqg7xBSGQsulftijf9WNrM2zJATVWz6AsdXnkIa/ocV9eZ/KMh47sr4G451JhKlBvELI5iVfbhr8kPv2InZygxVrjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704136; c=relaxed/simple;
	bh=oOvDgsnPSp9BHfYzWnE8Z7yqQoRpaEJHAO1S5ZxnppQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uiJwxIUrRqzWDgJ89Uecoy3MiKG7okTctddDwEKYjAH1lChzTV+pWb2UkeSFrW+M/vy9p+7KGJxkBOb/Q4fP3jAc9ZRP3iYjw4L4jHoEmCTdFl6+1t5PxjM/JYR/E5BGe9LWTwcjnlAFShDdloEDbFAcojs2xnFviUc/LWQKjG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IgQPnZFh; arc=fail smtp.client-ip=40.107.95.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFwI5qv2+lztKFtZBgQMAHDMRasCaKoi607/+/zbI/yjPRljdgW1X+PMGkWS/jHvMLo45qHGoCavOd4DDnK1+MGSdWgc2h4e6TExlzS7XHiTayA90g8lZC1pgVW27ybsCdd9d2F/HNK8548GAzZ2bQK2+wlWvLUxPtbSXCRhi0jbLilc/CRCM87CSGaNNpXeUxjQLLxNj/qY+yVbPU89vTzbCWhiTGkPKcwdZ0fXThl3NIvkERClSIf8FDaFo8kcJkRdfPXC4bE3ds69ChYpJ2SJkrlfqCIYajcmMsYn+ddtPDT0r9QYhZonYKHmyOAZB2cQdjf1PHLfBPLwIf3pEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPKe+fsjIdF+7L4mh8jZgDY7am1DoKYhNkgOoOAIE38=;
 b=EdG6x9KcOWvzp0+vPxsO3yP2JGzCRMJ3/kXhD+poMVT1oQrU2kUAvU4kSHb0xYkjaybHn61kNI9Moa/i5gla+0gk3AshAXR2jdzkHW8SveH3uKznEqFmky6q//UaLcl95kowvkjg8e5ZAOHLhh95dGivyNhJfAdQLIX7SXgD0UpC0w0bIB+SJfrccB8b4uYOVEovhMjVAvsCzlUSsCgmvPOHnhbOVhioC+2ALpO0ufWMiwEeYa2mTFfmcxEr11grIcf7hBDSTQtEHoeqI2bQ+fL1hc6WTvHtz15lO9FoOPJFOAUuguBXpSb1+AyH9zRJ6sLb5BLXpKJ/ya5psrXFCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPKe+fsjIdF+7L4mh8jZgDY7am1DoKYhNkgOoOAIE38=;
 b=IgQPnZFhs3gLH9NC7Jq9LtWJlrj251QSZjuRlc35hm2MRoJq0iOOgD0hgU7cqNEDBo6yctr76ULbRDIqYfdgxMTICtVZ8LeKu6jxv43iMhXUd6r1VPHnqqNJ7QET2sugqAAsT7U9sk6ZxGN3kWgDsQtA8Ke31yVbk69VTGL3saw=
Received: from BN9P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::19)
 by PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 17:22:10 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:408:10c:cafe::fc) by BN9P222CA0014.outlook.office365.com
 (2603:10b6:408:10c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 17:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 17:22:10 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 12:22:09 -0500
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
Subject: [PATCH 07/16] x86/amd_nb: Use topology info to get AMD node count
Date: Wed, 23 Oct 2024 17:21:41 +0000
Message-ID: <20241023172150.659002-8-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: af659f68-5af2-499a-d76b-08dcf3873a66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QtImICO3DlDXlxWk2vFIc3CQa3DJs9Y6SwdSslJnIqqVQDqdOJ2evmIQNjhl?=
 =?us-ascii?Q?NybIeesPb7/hqD3J9Jm8gzedSz97LWlpCbxUc3o7nxT4IMLZeGGSBFwiWcKw?=
 =?us-ascii?Q?LSGrAgKyU0Lt7sHSnRu3x/8Me+Gp0qDvD+OaBoKa3BwYKKfEa3t03AJtgctr?=
 =?us-ascii?Q?UWFKeK/lztY6qM5hm01sqc7TTc+CM+5mJ2eYtXCE15M408fUv+HAyCT4ap62?=
 =?us-ascii?Q?HZrxgNCJ6FlXUx4EElhSJuxqoI3xzqd65QyDAfQ8f//3rQ1te233H6AsCu3M?=
 =?us-ascii?Q?3ocJKyr/ulFo52uL++yS7+dH0ntykbkgEBfLH+nuRWWXRKRvTuFGBmunJ68K?=
 =?us-ascii?Q?zACjFhi9f6Zf8kkSc7XzI4hxQywzXixpyhYsVy3qL1sQcen/O+PMptyUIwg5?=
 =?us-ascii?Q?gzzS1D21f5FDB9ftB6gJq0J4gfxTMLzHiErOEVx682kVnv9GmsbRypzU897M?=
 =?us-ascii?Q?5+qNJNw3ij3cTAla49JlTx0vS1xsAulWzuyktvOql9+yXzftoDAZmpoqp6IQ?=
 =?us-ascii?Q?I7ObhMHqZBONVvURAmtG0HQ9jiOgM7ticWb7CYg3HdebMzj49r6OFqCyKduc?=
 =?us-ascii?Q?jnkz0oNnU79fWXsgjOBKGRRXY1wGAJZbjIZ5UdMnJfjP99y5xpY5Cx4DJs12?=
 =?us-ascii?Q?+Th1ReGuNVGffOiwvwcWq8cl2mU3XtMqlULcbx6CygXeHnzXD4Fi8VNhs7Kl?=
 =?us-ascii?Q?ivWf/5uS+VIVHc/wvVLo5KgGNJX7J13Pmjv3EOkOHQ55ZIvqYGb9H4o0v3vc?=
 =?us-ascii?Q?8T1GwKRfVTlJHE0kks9b7+UlRKUBjRXAEpx1je7Xz55IGCP+H+yb31D3Mol0?=
 =?us-ascii?Q?v8ubuVX5AleCaCoiygT1TKDgWFDCVIbx/R3qrFWoopQS62VPmghuu9cnv6S+?=
 =?us-ascii?Q?T/ts7RB1EtXwBWiiBUwg6Tb25ZEDL094i5EXweWo5S1oSNT4PiZb7EU9/c6S?=
 =?us-ascii?Q?ef4bcOEvhUOmlqLqVVJtv5vqLEManhTEDgiFVF+gv8gV56QONl548/wvAlcN?=
 =?us-ascii?Q?/WLwsXQ//7ujHyzh0imGqTxFTi+H5F4mkLJ8SZH2IkXJgOsWCTL5I8GxpCwd?=
 =?us-ascii?Q?v1ZrBIdbKnJOseapaxI+FLfbIxN0yQaXt/99y3eb7FSQGpQDn64Dt5e5bbmZ?=
 =?us-ascii?Q?clakVsMZU38F7XnuKBfv4bQtE556pmHGSqo4D5TOsoTqsiv8mUDrd4WVWNUc?=
 =?us-ascii?Q?CMzeONRyzZfKttOGeaBdumbUIEzJaCoLKkSDmJPTdgHIOQx8y76bOB7x8Ur7?=
 =?us-ascii?Q?5utgF7l5P4AXDqaEZP4G4uikkvWbCc9dqc0uMkDBoQnlg72he5IFV7oRFGN2?=
 =?us-ascii?Q?+qBfRPUceDAetIRMy1bGFeMOL1sPzUpwqUY5iPR0sI3YyXnCbHMvUJkngAPk?=
 =?us-ascii?Q?bJOfaORBr96g2GORQwzbKvreioAO00jfCpdqx4g0qL8vEcwBfA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:22:10.4783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af659f68-5af2-499a-d76b-08dcf3873a66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031

Currently, the total AMD node count is determined by searching and
counting CPU/node devices using PCI IDs.

However, AMD node information is already available through topology
CPUID/MSRs. The recent topology rework has made this info easier to
access.

Replace the node counting code with a simple product of topology info.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/amd_node.h |  5 +++++
 arch/x86/kernel/amd_nb.c        | 11 ++---------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_node.h
index 3f097dd479f8..419a0ad13ef2 100644
--- a/arch/x86/include/asm/amd_node.h
+++ b/arch/x86/include/asm/amd_node.h
@@ -25,4 +25,9 @@
 struct pci_dev *amd_node_get_func(u16 node, u8 func);
 struct pci_dev *amd_node_get_root(u16 node);
 
+static inline u16 amd_num_nodes(void)
+{
+	return topology_amd_nodes_per_pkg() * topology_max_packages();
+}
+
 #endif /*_ASM_X86_AMD_NODE_H_*/
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 135ecc0a0166..7ccd769f9c5e 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -186,7 +186,6 @@ static int amd_cache_northbridges(void)
 	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
 	struct pci_dev *misc;
 	struct amd_northbridge *nb;
-	u16 misc_count = 0;
 	u16 i;
 
 	if (amd_northbridges.num)
@@ -196,19 +195,13 @@ static int amd_cache_northbridges(void)
 		misc_ids = hygon_nb_misc_ids;
 	}
 
-	misc = NULL;
-	while ((misc = next_northbridge(misc, misc_ids)))
-		misc_count++;
-
-	if (!misc_count)
-		return -ENODEV;
+	amd_northbridges.num = amd_num_nodes();
 
-	nb = kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
+	nb = kcalloc(amd_northbridges.num, sizeof(struct amd_northbridge), GFP_KERNEL);
 	if (!nb)
 		return -ENOMEM;
 
 	amd_northbridges.nb = nb;
-	amd_northbridges.num = misc_count;
 
 	misc = NULL;
 	for (i = 0; i < amd_northbridges.num; i++) {
-- 
2.43.0


