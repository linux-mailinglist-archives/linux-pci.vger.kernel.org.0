Return-Path: <linux-pci+bounces-34284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CE8B2C250
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 13:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD5F1967064
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D33433472B;
	Tue, 19 Aug 2025 11:55:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022126.outbound.protection.outlook.com [40.107.75.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865C232C339;
	Tue, 19 Aug 2025 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604518; cv=fail; b=H33hG81ZMpU9s2rS5jrNWfdZNi6eGQi+mlV6fJNVTenK8Hi6j1Ne+oJ4rx2fqloLbD/JEAXbvHBKItNWssrVafbBcUjqgEeNx3QKd/L6eyCyyXsRyO0snxc0nLO4hv9WNtr3g6WRypTiIfrM60Uu87nFjl48SLahmwa/a14h49I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604518; c=relaxed/simple;
	bh=G5eOl/Xm3GP9bTaLZSi9myToHoyTJVqJ7DYrdSEslFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZfpKbbz/JwSYZmh6tgkEVyiDH97vowxyWDC84ECq57Cq1fxXTtWPo76PwHrirWBHMWRA4XJc8EyjKBrKMfYlnQzy4Ps/IYtdXspBw9D9fn7aWBryDmcnOCqetRW2yVNrpF360oAptUKxypROJoh49G+9oYmCHAGvZXgOdf2mG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKh+4AT12UGFczLpNKK31rbxL94HudywV5OhvvEEU4PMdku1sV1biElkHJXR1cIiH+H18/+m8HHcFfNVAD3V1kw7cCt4NPgKYowP2AOhQcYSHWL8hsgHHdVkHAkQzpbKKPp3WDmFpxue0BGdEyLoI0Et214JzmmDEhuqAXldpIP8ZBVB2jNXo8UXAiZz6MBISVJ2xQOM9CiiKgWmwb62ZO6d+PAgHRBBdyqf66OAqYRhoa/pmyl1W9R609B5nMlP6OvuX6tXcubklHnEzOZL7AwyFpfrHweXZRrVEuaF2JwHPEdm2Dkhtg+7Ri/Beg7k4KlVgRp/r/yyjc6XgM3NbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8BToPZxjTD4L5jPzzFAljpwlBxu60t0OjqLNMwJZRo=;
 b=vOdpPV8niyNsX3qd1TJeuuc0mrrMIjCsuUzKNJ6P9v81LegE1ZKwG5pOiZtpxMdbj3YLyxiQ/gxpdRtZukEJL8mbgeqspxodMapDbMlErU1epRYMmRK2ilQFI+TgZfIbdNLBywU7uqWIE/i2bM4KehwAiOiRjXJytQtrWlf25TwBWbIrsjs1iZNS3Re5b0dU+a1hveZT/MQeeF7R3tmlTbfu6ypvQ09Fmgt5zurb0QyE8FIDhVTGE/Ua0Yx724mqOD7IKUQT8tjdmjXicGPVVchhjSym6YEm5t/4q26X1/v8/in38c+5a43YACwqcoQENLQ3CYdk8BYk+Xw4BYEEgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from OS0PR01CA0052.jpnprd01.prod.outlook.com (2603:1096:604:98::23)
 by KL1PR06MB6650.apcprd06.prod.outlook.com (2603:1096:820:fc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 11:55:13 +0000
Received: from OSA0EPF000000CD.apcprd02.prod.outlook.com
 (2603:1096:604:98:cafe::65) by OS0PR01CA0052.outlook.office365.com
 (2603:1096:604:98::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Tue,
 19 Aug 2025 11:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CD.mail.protection.outlook.com (10.167.240.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 11:55:11 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id DD99841604F5;
	Tue, 19 Aug 2025 19:55:09 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	mani@kernel.org,
	robh@kernel.org,
	kwilczynski@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mpillai@cadence.com,
	fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com,
	peter.chen@cixtech.com,
	cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v8 11/15] PCI: Add Cix Technology Vendor and Device ID
Date: Tue, 19 Aug 2025 19:52:35 +0800
Message-ID: <20250819115239.4170604-12-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250819115239.4170604-1-hans.zhang@cixtech.com>
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CD:EE_|KL1PR06MB6650:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2f0cd291-649f-4050-c793-08dddf174086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yDHaQWyMbZ9HyaPiJbUyBnZR6Ky0clftfpNbtWNJbNdok3qnAKeek/M4gopO?=
 =?us-ascii?Q?+InjNF2a+e+VHR1+UT7MK+THk5YlWdmuAADWyltuQGu97UOV/lnzcDAjfQA6?=
 =?us-ascii?Q?jooYSjwg6lDiJ0afNETLC/SSbYzuahpDLKxJO7rCaMK1/sCtiLxZjD3FGBq+?=
 =?us-ascii?Q?sElQeiQZd6QNjl6opyHMlYTGzw8f6WMAZxl9Y4dQ9RfctrOnjlBwwTb14H/V?=
 =?us-ascii?Q?u9BCRHD+bnWX3Iv7hygBbl+N5Ot5W8PUDQfKh3xdpXeKbBkqoTSwW2d8MA61?=
 =?us-ascii?Q?wyz8bOxQebWTc2HeduKDnUyZhCA8EUcWLQFfvBSk1l2ErFU37RSCL+rFa2aG?=
 =?us-ascii?Q?94L/rdojMpacO3aujW6guSVpu3ACXpE/GAHA4eo0AjkJ2K+6QliKPHQojRkS?=
 =?us-ascii?Q?7S/A3cjQjQWid+1EfLVxvC+JLRaLMpIulDC4qmiN6jEx9aJZWADXe566Wz6+?=
 =?us-ascii?Q?RQbghn5tL7i+DvF/FU8NRTeTiPy1S4NPFpnQBtGt4maO9cgM/K4ipJUbpwPl?=
 =?us-ascii?Q?BTGsMLHWeaLEd6l6Mi2YmYwOZiqMEoxoYi774X56MNhKJDyeOL8uWg/6taMr?=
 =?us-ascii?Q?IxnVf+9U7O4HYL7eR8EfkTXyySumEi4uEQSwNq8zX85UA234FT9tBF+uorKX?=
 =?us-ascii?Q?uP3J3/V3tI4JeTPmfxfZQu3UDgZsXvi94CKPzl1E8Tp5hyZDL2FVGAhDJVJZ?=
 =?us-ascii?Q?KfT/IzEWAglWvaBssbbB3hIQ+4flobC1JzmI6q6BhvHIeFLI6xNrcKydtMx1?=
 =?us-ascii?Q?98Jvvt5x7rCL36ShJkRA4hqwTxrdb3mlef8xaQtDA14EOKaKvxuwXF2n8RgK?=
 =?us-ascii?Q?N43slCpSxCZPuwfx/NMkxpiq0vSd9kynSRs3UZC8E1wc/ju8n41Q0O4F0L8T?=
 =?us-ascii?Q?P3kPUcs9M1YYjO/WtVXt4ZFTO1NVQ1fb6pxOW7/XdLB0knNhDOYU3yA/pu5Z?=
 =?us-ascii?Q?U0cZsMZsYY/dG803fCJrpMyfi11OMCrTegAaf1fkmIDaN0ZqJIylVfntGYkK?=
 =?us-ascii?Q?VU/qiohLDo32rbedlSl5A/M2jZky+TEhVw+pmJjckTIQNLoGZdEtEyF85Ps/?=
 =?us-ascii?Q?mVHymqv2clNJGX4RIml7uZKbcrUwfhiKRxxRK6Utp2wro2beFoZghk4X8u5s?=
 =?us-ascii?Q?Kzr9SnLzurJNZv9ZRN/rRN9bwgB6Xp+01yLuaH93d/58hp0IDvJCWPHDB+yW?=
 =?us-ascii?Q?k/NUO0szP81mIH7ycPUXlBmQgzNbA2BwCx0RyNOq9H9Vw7/KE2ZY1G5kKwC0?=
 =?us-ascii?Q?J3zk7GOjknYqgcsnVsoAMxMY27O1aNa3XCAvHssVhO0qB9iUSEKMZsqr2TSa?=
 =?us-ascii?Q?duWjuh9znFWlJ4UAZ53pG20571rv2q91+Yxb8hzXj06IVIBNuMR0u498rEOc?=
 =?us-ascii?Q?0yBfmoqLHuMr9Ty/wVPwjmq3wBZRGkpfICKfh+vZ1yv3gsG3GkK0yExFrdWp?=
 =?us-ascii?Q?jhPNVwpafBtdayHAEKYtmgS/oXiMuWK5AT0ajQ5HoHYU5AaxYHzsLrCcvGoR?=
 =?us-ascii?Q?EJ3OIYhPHJFkM0HGjfrhhzZGY/BnAbLw+tks?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 11:55:11.0984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0cd291-649f-4050-c793-08dddf174086
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CD.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6650

From: Hans Zhang <hans.zhang@cixtech.com>

Add Cixtech P1 (internal name sky1) as a vendor and device ID for PCI
devices. This ID will be used by the CIX Sky1 PCIe host controller driver.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 include/linux/pci_ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 92ffc4373f6d..24b04d085920 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2631,6 +2631,9 @@
 
 #define PCI_VENDOR_ID_CXL		0x1e98
 
+#define PCI_VENDOR_ID_CIX		0x1f6c
+#define PCI_DEVICE_ID_CIX_SKY1		0x0001
+
 #define PCI_VENDOR_ID_TEHUTI		0x1fc9
 #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
 #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
-- 
2.49.0


