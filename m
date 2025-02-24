Return-Path: <linux-pci+bounces-22162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 925A3A4166F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 08:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD5C1709CF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 07:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA76E1898ED;
	Mon, 24 Feb 2025 07:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="24zaAsNd"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0961BC3C;
	Mon, 24 Feb 2025 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740382917; cv=fail; b=rPTPRjgxRVcJP48xzKLi8QFyQGcV9HQr28HO5BUkVzp0rWYp7Eb+LnfEwCNBodBR0mcuGPJmtntkbpvHkFeRrw7mxr6g3qRdW2hWR+lKdg1FNUcnLQm2Rl1gUE6epfj7PF+U89Mw6CqUqFB8RyH3qmeWbPMtJfokeAdp9FSaaIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740382917; c=relaxed/simple;
	bh=2Wbl1UFSdzsCLdWqF8BeuDa/KxCbmNldEqTD6ku2ZWA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K1DM7QyKL5syi6aCVFrYg3iSexhEwvh2Ol/GGHs94FubVVVuLRsjtUavQcTStHCbzDC7n6WhCxWgxXeOTAXwSjxFSsuRLIsfisH8LgLfnxXCsZ1AX3pz4z4q/JS2DVSBQP19S+Bums5LPpZNbvmI2n+cX2RfzSyaTwyvXs7b7OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=24zaAsNd; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahkFSABpH+d7lxwe7KhahQ6LBFYJQfz3qPSsylCysnZwMxCT1Iv5VeIxVJq2pjHOBqXmtj5QqOmw9tyOxncFCObwS2begYBaz66qjCfaTLQnue8tg8/luI3fZLCOlKKyljdcR6y1lfYSZQSo70USi68+WqMb9GZsL6vxqyhCo+XCThVvNwLjxpWBvRCH8X1rLMDP0Gv1pzBQz7ATA06SAtS2v2NMDrRP7SM/rKplLAeD64eFtX1GllQfac+Cr2MIxF4gbjG5QboKW3mvBkVjDTh83hsITMKD9AKjLllnxBUOAkdQ2Vfs5CAt4+3qOgU40sFbPWCmm1Ho/odI/f1uWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+f0hSTerAk43VAGUB9kRwwRNMpNI0fZWl2ojyufimGE=;
 b=e+8/sVxOyTEsJ9XIaICS7+SMC9Xz8uBMYWQec+UsJZaeYqmnvbrSeCv75B4MNKRsRTUKN9Y3AxRKONFlrrcwIFlxQI1QTdbCY7uzSJwZgk56ud35NkTQHCSxUSUG9WQM/KCZu7Pxv4iTSKKeqamqGEsWe5AJDt701XlVBl933/3s1wxXiD7CNVaGIz8PChxhd/Y+scXfODtinDn6C6DSvokrz8VEPGeS3oBozj+muyLIjPyQzoSJrDH6KNt40j8NiUGDDDaNhoTlK/TtnN7KCsEmD/i5dpoJsn7K9Ig4e11wYKE83bNuEUEjaI4BNiqqGSeNeRVIYqngW8hwJfPsKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+f0hSTerAk43VAGUB9kRwwRNMpNI0fZWl2ojyufimGE=;
 b=24zaAsNdU1TREfvxt2V6KHd7irRYEvEwZfbZ+cTcT1b3aaB5xH2IyleDhNIAksvtkJ7f3gjKOr9iizuhRsqbUJxYbDzAodDsp1McqV+HB+t2tKldh68gvNrhrCWF4q0XLn0Ovh+K55R1LJMq36LsDvzN9gZofbHAhVUDkS08H+s=
Received: from BN9PR03CA0907.namprd03.prod.outlook.com (2603:10b6:408:107::12)
 by IA1PR12MB8493.namprd12.prod.outlook.com (2603:10b6:208:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 07:41:49 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::b5) by BN9PR03CA0907.outlook.office365.com
 (2603:10b6:408:107::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Mon,
 24 Feb 2025 07:41:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 07:41:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 01:41:48 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 01:41:48 -0600
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Feb 2025 01:41:45 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v4 0/2] Add support for Versal Net CPM5N Root Port controller
Date: Mon, 24 Feb 2025 13:11:41 +0530
Message-ID: <20250224074143.767442-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|IA1PR12MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e5d9891-e504-45f7-2149-08dd54a6b268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NnapcPXpqFtzTgA3LQBG3Urgog8a+7efURfJfFTrO2qh19MRSA09N/qoizRU?=
 =?us-ascii?Q?zJjU9Kp+ZYDDVhbeflu8T5qQv/WF/h6J6+c0GMJAU67PMSE8oDaQFe1qO1B0?=
 =?us-ascii?Q?bCZM0QeTkJ5ubXm9PyjaPYroI0eonhBGoqIrydcuNlHQllFt0HId2xVThLbF?=
 =?us-ascii?Q?7M7Q1O1sflH0tncVqvTdFPeoManzv/qc/WPI0fO2AuwnDZxOTa3yxThb6d/K?=
 =?us-ascii?Q?GxDCYDfK4H89JdUAQK1s37HE1+xPtdz/AliF++42VuTxBAdYK+JcRYKZ7lLW?=
 =?us-ascii?Q?Tx2VYzO1KFFAVv24Abh59L/KqtSscJJfXoZBBeOMXu7j0WYqa9lSdEAbQ57F?=
 =?us-ascii?Q?0Z/6KN6ud6zho28o7TOMyE2uZZTgxk8FNluVsNZtih4B9ryvIlXKhZQxz2vX?=
 =?us-ascii?Q?GTpXjJ/qpX6bi2sJo3vPL4GWsrN9VZW8nB3fO+Cx39TNCthcbYhLwpq7SXcM?=
 =?us-ascii?Q?aJ0rVk42/VqurNTQdWlawc04bGCfyJS/4IjIEOWFKoCP9fsTKkQwK8GQF4JI?=
 =?us-ascii?Q?L6QflKxito4Gvfx7+ZjHmBbsPBgDPrvfZ3KMxa+9g71juoApTZud00J0uQBB?=
 =?us-ascii?Q?061e110CPxR00H94o6nOOxpqEswNLl5CE9mU92OyplDGfXweysUUiTbBMMAm?=
 =?us-ascii?Q?Atw6Fmgw9s5JWPhD4gsb+qV2bQ2entnfdGStH8MULMypsB9aENYX4uqcIIRc?=
 =?us-ascii?Q?l78xhwZsdh0iIUPpU00QXPtfRVywxMpgv1ASIO0Mwk0T9PEeuvrlE8cOe5E2?=
 =?us-ascii?Q?8xAOvOBDmuMcjG5jfv7Wk+FWCRFcGC/PmM4FTDq+vRtGzTWo8D6U5+Z21F4t?=
 =?us-ascii?Q?VGqLUajAI6Bh2VcR8sft5Tex+r02tfthdh2jXHALFVKau+rP8JIU5sGaiQAw?=
 =?us-ascii?Q?U2kC1SL8gdlRN5MAEufhSZjqUdO0Vq/kA1ihyScBxJILueyO6cUu98nKPU5M?=
 =?us-ascii?Q?fXIvB98agKfUmUuUzy/yuYZRfjwy9DXsnd7fzqYBh/i6FzLqr2LHT3s0PLmg?=
 =?us-ascii?Q?h2c89BvxF7PaobMBEas3uzJaAbGbMeU+NVeab0JNB1YPJlXjG6ubX/dkTxIq?=
 =?us-ascii?Q?9ZKlzUa5PcvEomi510QoZzG9xVjAyL3VPIs4Mn7IIOv4TYGhb2LqN5sZK0hL?=
 =?us-ascii?Q?wSS3hjHp+NV0bqYxPH/2/bzlFJJoGxdYbvOQj0dBJf5e1yyxCOpz8Us5fJaX?=
 =?us-ascii?Q?Rhya9J14y8XmOz0a9QH0xHyYlRDb63k6qXcj8dAjCYFmehifSeujK50qEinT?=
 =?us-ascii?Q?+31/7gv9IxhGKLuB3Sx5/gSQbt2g9fv8QsB//A5Jj+r9lceV+3PVklLqlMc8?=
 =?us-ascii?Q?MNty6UFMv9PBPJIIxT+5P8ZmLIY45szu3NLPToVckMdqGUfyxLDzOLKbwke0?=
 =?us-ascii?Q?JP4FRu3zaNvXF+XjSuq9AYpZzWdsqcarersHwn13KjZBHYaQ3V9fTvcX0v2g?=
 =?us-ascii?Q?vt9UNOYXpA+3yzfB3UGxXZ0RhMLPsvvQB2Lj9gSTpgrjp9xebUS4E05RysiA?=
 =?us-ascii?Q?po8etiGHt34u5D0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 07:41:49.0482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5d9891-e504-45f7-2149-08dd54a6b268
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8493

Add support for Versal Net CPM5NC Root Port controller 0.

The Versal-Net ACAP devices include CCIX-PCIe Module (CPM). The integrated
block for CPM5NC along with the integrated bridge can function as PCIe Root
Port.

Bridge error in Versal-Net CPM5NC are handled using Versal-Net CPM5N
specific interrupt line & there is no support for legacy interrupts.

Thippeswamy Havalige (2):
  dt-bindings: PCI: xilinx-cpm: Add compatible string for CPM5NC Versal
    Net host
  PCI: xilinx-cpm: Add support for Versal Net CPM5NC Root Port
    controller

 .../bindings/pci/xilinx-versal-cpm.yaml       |  1 +
 drivers/pci/controller/pcie-xilinx-cpm.c      | 40 ++++++++++++++-----
 2 files changed, 30 insertions(+), 11 deletions(-)

-- 
2.43.0


