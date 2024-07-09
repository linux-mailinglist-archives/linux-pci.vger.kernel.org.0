Return-Path: <linux-pci+bounces-9991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0EC92BB7B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 15:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F38EB2174A
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 13:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298BD1649C6;
	Tue,  9 Jul 2024 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mDQKBcnG"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E7015F33A;
	Tue,  9 Jul 2024 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532187; cv=fail; b=QoY3qYWJZkXopInOZTylGN2NX0HjemoLHJ8Bpk+6ySXM77zjEvqJ4ziWx0nMC02ialGvPCI8Pj+usGV0RZ8Kz+Pgj61M9MEcZ8D5ONicR0s6Q1p7ts9gF7dCRXDQts198BQj4Lz+WUbUq2BrxeuKBCC1jJkLPRAuUYTbmiBTq78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532187; c=relaxed/simple;
	bh=+YBR2k1L6ShFiFS/oAbZ+WOjgePIBRLF0V0bwLgg/6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrsGp2zUNgYKt1DqL4l0EfxhvikvMD4lhmNE2Mig57QNt6393Ov4T7TUi4TJLBwyDMO7UIii9tRab7tInhjhfUdg1x+Fj67h9CGGaASj8CrgoESk47DXRw2J1jE0jFPilj6+V53/1kfWcPzo4DvhiNNZ/QBPreMYuNU7Q5CZpZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mDQKBcnG; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naLCD4JnDWhbA0xn2ktSEQErtP9qshbDjp1WkWv9+i7U5tKMO2PlxHhmhk9jW6DO0byIkNJT0arSZ3kOgx0l21qbLgHJ1tj9WyUrktzogvlZT2hGTO/vSByZ/7lNbDTcM1aR0eLwh0IZZbVg3Xy67MonahW5mQA5lwgJc692XeO3Yvv0TE6TMrbTz1v0ZP2rEjo4ZLJlZFnmhzz0KRqW1jUoEcYLzYDHz8yXjfK4PG9u5jM7/NslhH1K2UVu649+UcRiyldExR2SnWbkF81acggERbchv6Dqa8HsnX8WqyV/TxGOkQ/cHVqQOC9+Kji+9cG8k2ko0r/2EY5DCSiBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgTDjEpgI0p+VC0WOGW6VmAZfnN0vP3Cfp3brmmaqjw=;
 b=arGXdSEBVWwlY9eV7euDUzdo8EzjfEtirgvRdPVpJl80Kv8+y7elocZU5OkoHFEO2hOvHN2J4LobYdqFI2cQU2HwFotr6jefqq0kd6b62Tx58cydEbPw/o2o2TQuwdZXYfvCnp4xTk+yCoZNY54eWyrzloRbr1Kh9uldeJH25qdgdfBNd4A804H6kBKTimy88zzF0NYtRBYdTGyUJxKJsYcS4TuRfx0o1hyGoQXpEFepalml4Cpnt2DrnYv1DOG4kyPcEB2i1l/HveVZU1RZrKz9pvNCeXUb7eFtvQLcBRAVP04jN2RtxIZ0ijvtzqRr2MG+U9DqVR/a4ZgX5wK+jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgTDjEpgI0p+VC0WOGW6VmAZfnN0vP3Cfp3brmmaqjw=;
 b=mDQKBcnGaODG6x6vOcMPe25d5q1Q1FGhZqdfhbYzd/FZfzoPRQLfafWzE77dDll+tgVQxjl4+lELcuxb6+SDEdzmwwh1DMY3ecWnpC7/EOk8o3iIAx69ATp1V7WAxDpnj/UIonBmOI5g5V/OOMFbQ50T2QZU4FgnzEoe3CMY9UQ=
Received: from SJ0PR13CA0055.namprd13.prod.outlook.com (2603:10b6:a03:2c2::30)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 13:36:23 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::b0) by SJ0PR13CA0055.outlook.office365.com
 (2603:10b6:a03:2c2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.18 via Frontend
 Transport; Tue, 9 Jul 2024 13:36:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.1 via Frontend Transport; Tue, 9 Jul 2024 13:36:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Jul
 2024 08:36:21 -0500
Received: from ubuntu.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 9 Jul 2024 08:36:20 -0500
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Stewart Hildebrand <stewart.hildebrand@amd.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] PCI: don't clear already cleared bit
Date: Tue, 9 Jul 2024 09:35:58 -0400
Message-ID: <20240709133610.1089420-2-stewart.hildebrand@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709133610.1089420-1-stewart.hildebrand@amd.com>
References: <20240709133610.1089420-1-stewart.hildebrand@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|DM6PR12MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: 5932d28c-4c84-4aee-19f8-08dca01c1fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Hn6rozcwyIF7QuuLAgvITSbs+2moz0IkUpez4nDEmkf5IB4Xh2Fsb5zCK4S?=
 =?us-ascii?Q?7XfrSzWTZM8mV+CwQqQUXctqIQe7+z04rUVnfPFDIv8kXbKCBo7pOWPetacm?=
 =?us-ascii?Q?7jWlQodZU8x0OUq8IZNUhND0gGzULSnHDSG2dQJpA2ky14u2MIxuUYROSyWG?=
 =?us-ascii?Q?7qoAGnhqeFBxFDCX70CTyehzYcjur1QavUDrhD3v9vFFzZ/ZkG0nfOIpZJE6?=
 =?us-ascii?Q?fI9+sxm/OcHzSOaYO+piP8IYg7d8iQG1WoHnotIgtPujbgcPkapjF5qGSSns?=
 =?us-ascii?Q?/AV1m1A4XrAddkpITWgIFvlaJRV+4/1qySvJP3Exe/nTtROby8joBWWB4SmU?=
 =?us-ascii?Q?ElanOU3lJ12Mfhzn1rb0vuvXyMgF41FLsgV/QLIouskDj0hJaCVYEiaBY5B7?=
 =?us-ascii?Q?0aser5EQm+ITixkmA7gTygr8XAPVj0xhOjmriLCSuFAtHyAhU9FQke1+/pSH?=
 =?us-ascii?Q?TKw+HKexqpB+4VHaGmZg0DOc710GhtzXImoKbgaqGArec2QXNjjOfMl33CH5?=
 =?us-ascii?Q?HYctUo0IfQO2I0eAQUqbQLROPy/q1DGGu9dpQn+P1DAuVamIUoXoqzGycbJU?=
 =?us-ascii?Q?mc8t//fYxeZ3XJAOqlRvS/yIoDvFDleItswSVErFezJCehipl1EZJw2Dh8ai?=
 =?us-ascii?Q?0hsFM/tacPG+bGMsT+vqlCmy84oxLhYVLAlzml1Cb77c2rN69xfm1LDeUQBi?=
 =?us-ascii?Q?Kkq+uY7F7wic3Rb8ZtVdGUokDs9p1M4WIGiX0e22tkF/6yc0MWFQX04evct+?=
 =?us-ascii?Q?cIkkjYhupxprqeDC3GRR3wAUbhp171Joc+ShVa8X1HnygWKL8LxBOGwyWDjT?=
 =?us-ascii?Q?P/fR472CZ5DnIP/j9yuGg1v4anoZZoSqWrr2Mx8s9taAmuqiQDdDEiUTjCnd?=
 =?us-ascii?Q?hJu3RCeTGyCvnjOJDjjFCt1YhlArvYJDPdejVZIVRozLIn3nkZMMzkNV5jCu?=
 =?us-ascii?Q?fm+0DpMVWFghGHQWjUSDXy+b3L6fx4O4tdr8qFpj9euN72giYt55sDzvry6J?=
 =?us-ascii?Q?eFzmiVMUHU5ZRdkK7tsYE9c5nQ1O71RU/IwT5g9bi9FE7AEAZT65Jc3wXGvh?=
 =?us-ascii?Q?YCcgAihJrQ2//qdnqdUj5Atq3uIbEoVXX42UT8UWGqmh/dthTXIUgBq22sqw?=
 =?us-ascii?Q?wFugAIcNV6srpA3hky/tqf4vEZJ5WJkz/ocreVWiezng8w4nTNVTPgDHyB5m?=
 =?us-ascii?Q?JgGN8RhDKdiHwRgNvGffOGUPCy5uVB35DTpaa1zGXz6Fy/Qw2fDNgwQ1DjUL?=
 =?us-ascii?Q?zcp9p4zHdigf8P8Ug+W5eTYtwKG9Pete0GuFNYl+Zq+QLcwHAvV5ZzQKWqIj?=
 =?us-ascii?Q?OeThlM8TiuLxrgCe9UGmERpu+04YRttLWnVHSsIfZfModhhWw6xlQ8mPFk0I?=
 =?us-ascii?Q?+eUKqA0YLKtTl6CJB6qpfFYVQd9DAJDaj1BVSCU9uzFxKnJJgnKWDS76fGLw?=
 =?us-ascii?Q?9Dw2hjdZFF+7YSFE+ktS095Z/NXbfYNL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 13:36:22.8577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5932d28c-4c84-4aee-19f8-08dca01c1fb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267

pci_reassigndev_resource_alignment() performs a PCI config read, then
then unconditionally clears a bit and issues a PCI config write.
However, the bit in question (PCI_COMMAND_MEMORY) is a RW bit, so it is
unnecessary to issue the PCI config write if the bit is already cleared.
Make the write conditional.

Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
---
Should this be folded into ("pci: restore memory decoding after
reallocation") in this series?
---
 drivers/pci/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index df550953fa26..f017e7a8f028 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6632,8 +6632,10 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	}
 
 	pci_read_config_word(dev, PCI_COMMAND, &command);
-	command &= ~PCI_COMMAND_MEMORY;
-	pci_write_config_word(dev, PCI_COMMAND, command);
+	if (command & PCI_COMMAND_MEMORY) {
+		command &= ~PCI_COMMAND_MEMORY;
+		pci_write_config_word(dev, PCI_COMMAND, command);
+	}
 
 	for (i = 0; i <= PCI_ROM_RESOURCE; i++)
 		pci_request_resource_alignment(dev, i, align, resize);
-- 
2.45.2


