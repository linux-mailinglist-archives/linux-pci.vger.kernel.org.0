Return-Path: <linux-pci+bounces-10581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39AC9388DF
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 08:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2792B20E3A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 06:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B4F17BCA;
	Mon, 22 Jul 2024 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rtKuw8kq"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1651863F;
	Mon, 22 Jul 2024 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721629589; cv=fail; b=FCXgdnCT0Bu+zlJ0BpyypYqCibx8V7HoC8/0AzZF6tu5zMCtpISmicALaZ4nhmZhFlPebTJfvjVq/MqOdSWa/hEOtWuEX6GIpR4pmDpk2LUTHjCYzd2huONN0ehG4YaW/pAlAPqCH42F5aOWAXyE+/a7TB0oUI/M4g4VuBeMU9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721629589; c=relaxed/simple;
	bh=GbUh4/IRcy52YfxmFvJ+aKVJ/2rnOSSGsPaFagm8gNk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T2LBImkdotBGYJOEydVmp7TQxAmlxonjFmt61IzpGy1GXLojbmgsKRiTBXNSwPcAZgH4pPIjmnDNRnifMwj7jg/Mo+mJq0w7kEAsbV6MEHFN/aXhEzOe6GkTM7xWleS2Bf24tRrcuerFAoCafOTxhzXp7omZABwmxPRN99o+zQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rtKuw8kq; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6QEPw9zmhq+tV/gJlBZ16/4WIcrF6mtTeXUWQD5L7xWJfzNuJ1I8NQhK8ae041CyhQRhRBGyNHbyF5LjvGV+yYStl9bUgn4OEMpTRiWt7MK4Xr1JwLki+rsaxROlRUvOqNtXyaxv04GLr/WDjAtp7gW8oMte86usrqqePzxEN0CTOLwVciknwzEo/hq8VIGXHF4iUCraJR81S6804UeNsOFoKEaQNjZmZb3lN+7J6PIV2pU6D1bGe6BZweyCGwbOMGUyi7qOWg3JXGqYEXVXWqUnMZofZzOj2aQcA4nqCxq+gS2i86Ra6D6NIFFtejTso2X+sdmLd2jJ+v4ua1MdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSeXNLa9odPskqVpG+u+6Oqqltm+z9XiEnJsSFoeSLQ=;
 b=xcXbePXESkKQUbENSzUdccv7tphUmnHOSfQtaJ+pOmbC0OfNf989LqwVYRNE0kRM1R2OpcFaHF5t+T5ID5M/NVSj5OU0/Y0VMvDq9OajpbR+pablUd+kfNpA+vmE/ElOagoF9McEDDwR9LpJ4ffF8yfCdeOIoVZAPfp1YSe8gmc5rTK0C4xIbXPTAai5Srrmv0ICTSP44gA43pdBowqnn/oaP3Cv0QEnA84z1JmVO0s3xJ7g5yKRzmA+WSwcfRrEtmG2d2kaozg6KCdao966mdbCFfn6C26A/G6rMT5VJUxeEZCqYGUV6u+XQM/bRbe6bU0lRowVPwns66qpQ76xZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSeXNLa9odPskqVpG+u+6Oqqltm+z9XiEnJsSFoeSLQ=;
 b=rtKuw8kqSF0sQYqMRXopFH/tT8mYbuEj6CnRUnIAoVykbFa3kfHlu7yzOBcfWP0VMsjfGxLpJqfyMpFpnB3xQ14NQnWsqiB6M1XbwdWlBA3irwaYOoVHUvfj6QHjRKt58Ios2xkbTsmDs19lR5iq2oWcM/68Ez9+BdU8CeLb9dE=
Received: from CH2PR18CA0052.namprd18.prod.outlook.com (2603:10b6:610:55::32)
 by SN7PR12MB6981.namprd12.prod.outlook.com (2603:10b6:806:263::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Mon, 22 Jul
 2024 06:26:25 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::6) by CH2PR18CA0052.outlook.office365.com
 (2603:10b6:610:55::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Mon, 22 Jul 2024 06:26:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 06:26:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 22 Jul
 2024 01:26:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 22 Jul
 2024 01:26:20 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 22 Jul 2024 01:26:17 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <thippeswamy.havalige@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <michal.simek@amd.com>, "Thippeswamy
 Havalige" <thippesw@amd.com>
Subject: [PATCH v2 0/2] Add support for Xilinx XDMA Soft IP as Root Port
Date: Mon, 22 Jul 2024 11:55:56 +0530
Message-ID: <20240722062558.1578744-1-thippesw@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|SN7PR12MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d803fb5-3b45-400c-9de7-08dcaa173470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d8SdLNhNT9i5GU+3Kw23fP9seZ4MRddR328ZUsEEj4Q655S+9AualNvuHWCr?=
 =?us-ascii?Q?FWGbL3W4tvxgpkAbStQrRrf9GH1bDLcexMA8FXIHMR4SivXYmmbCLJkJt7LC?=
 =?us-ascii?Q?VmAtMIpFCGROnbtUe+DgKyxOSaT4F10zLXPIj2Gdqqg436nOyQpvXmIdhk+P?=
 =?us-ascii?Q?JrgsnfP0L5jFIPWVpHZTtGmhLpWnLEy85Wlyh3yYUyB1wURqj05+1EOCQsMT?=
 =?us-ascii?Q?YAp1c3Wyh4pFYHRvemhNTDwWVLHNhUjhG6D/L123KleGlj2PPNSMpvCyLbO3?=
 =?us-ascii?Q?Hot4C7qdrgg88Thb82UjQxPHVfqn5g+YVFgiMK92lc2RlibTsrdW4qQ2SAMm?=
 =?us-ascii?Q?dpYQF5dVVpLmFxONQ0lnAjW992nFWfo77ddSiQko41ZelXET8jgudmitMJ6p?=
 =?us-ascii?Q?qSm42J7fkFxdBPsCindklfgRQqWxuAhp8KHaZaWI6wxbtRsheC6oFfkWxgZi?=
 =?us-ascii?Q?SWHYmNC7BEal+1XskIh6pTkgthmU32TfKYV0g+QJEIFHjlQ74REhiucBHscV?=
 =?us-ascii?Q?WRGKTcW5cq3bzP2VijphVm2AFVkNloNJ1qx9qqz2jTDqeahThzhLJ7TqdacN?=
 =?us-ascii?Q?kIHMe+pJhXTbfsJ8pHElDmaorPnlB/kvHxY9bU2xcgYSRbgNGm+0OkX3CVBI?=
 =?us-ascii?Q?WE4S2iTAsPnqeMKLDcVIpq5JrKNIWZ6pnCKUUetJz9qAqlWYEz79PC113/D/?=
 =?us-ascii?Q?wIHoeqNQDiMDHT4yyM7e0Uk/9bPPRbIEDEDVvkuHSUM1NAv4isTDQUU76v9C?=
 =?us-ascii?Q?ipx25/howW/35Miu6a5lVT3VRgxup3FLHabUc7EXZ1ZM/PRNoDyhi7X1RFCa?=
 =?us-ascii?Q?11Lm7cG/vkQEHAgPZpv8/kenqaVIPA9JUZEUbWNOFP1+ktBdER3y+cbs3fyU?=
 =?us-ascii?Q?AtZsVOAZQyyvtQ4EbuGM3ZLCtSIMImnEMK5kr6llx+fT3YA8RkLk2kmDH4L5?=
 =?us-ascii?Q?xrvUyghulEhjomOGlkDq8UD/TaTRMm3qadRPAQK/GbdbNsYjQYb1guE3UQMq?=
 =?us-ascii?Q?iI5Q25aoulhUABod0PiNEtV1pslRombmKw+TORyhvwr/oRlhB6Jz5zZhW07V?=
 =?us-ascii?Q?4clDUz1Fjbz3dc49T6paIBQoI5AfpcpKfqhi715qKQCZSZ/EtOJI2Hk9cGjr?=
 =?us-ascii?Q?GuLuXoahzHXjns89DNCZC0XgBSNax2Q+H4K9FpOv64AqR7EU0wLv/spNf4/9?=
 =?us-ascii?Q?GkhuMR7CD0jfSiMx45lx33ZXIVadIhcUQREpOxJqUJraDpm03fwvP/HhkwPs?=
 =?us-ascii?Q?bopi5JpIP7KqicEszY/gSsSADFJTD/+xMJzklAFjGu30Hg9WUyGK0VfuHtXp?=
 =?us-ascii?Q?6IHM93KAXoA7jy7K2i9YzEBufTHgp8dGyGHvAA+vYIyA3X+O/1CN5pAcxHRV?=
 =?us-ascii?Q?ITi/lm6sgQyvHRmyIO1tZt7Fc+dBzKpaxJtKe5iIPpbzaBNiGQlBWwAgqGCR?=
 =?us-ascii?Q?y7c4gu/x7dIyjCZyjd6okeYQwbMWkOXB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 06:26:21.9283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d803fb5-3b45-400c-9de7-08dcaa173470
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6981

This series of patch add support for Xilinx QDMA Soft IP as Root Port.

The Xilinx QDMA Soft IP support's 32 bit and 64bit BAR's.
As Root Port it supports MSI and legacy interrupts.

Thippeswamy Havalige (2):
  dt-bindings: PCI: xilinx-xdma: Add schemas for Xilinx QDMA PCIe Root
    Port Bridge
  PCI: xilinx-xdma: Add Xilinx QDMA Root Port driver

 .../bindings/pci/xlnx,xdma-host.yaml          | 41 ++++++++++++-
 drivers/pci/controller/pcie-xilinx-dma-pl.c   | 58 ++++++++++++++++++-
 2 files changed, 94 insertions(+), 5 deletions(-)

-- 
2.25.1


