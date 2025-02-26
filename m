Return-Path: <linux-pci+bounces-22434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B92A45F99
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 13:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03A11885BD8
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 12:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BD0217F48;
	Wed, 26 Feb 2025 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EHxzVjay"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7622153D1;
	Wed, 26 Feb 2025 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573852; cv=fail; b=G2p9qhp05jWo70w+b2YG7S5SAL0kzW1In+UlQMC9/5wqznMJ5IjEus2qecofxF+DV7Y0pm9Vc1mUgwjn9jMUZe0rkvf3TlsRhSLX5hprVnpg3csE7HddbQK+FzYt3yOqnuvjzzUAfHOXUjrQOP+CUz9FX6DAaeZylM8yRi8tdbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573852; c=relaxed/simple;
	bh=5l9ysTTLHF+1j0eC6hkYm6NR1mBIz/P8vlQyvykxShs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ds3bb/UHF8LCpfxwu8PDPF79kDuXESRWUBPODXYWJ6r7z3vNAyiIp/1UDhxlFgfz9Xf5DxKB61/1NkwcrUMGmKD9eLbfawY0WtNfdgqJc8heAmqLlX3theRPaO0AviDLhvNGvVptiY6WVlGIW9A9eUCgaqkkfAPB5q7nkPFgGZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EHxzVjay; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIuo1mBiIkhKME8bF1i/FJdgLve365y4ZeOYW2g4NSYhre4wqRPWLEd748YUwsYjiqF1odk/Zlw9Az7fVn5Ag4Q2favtLtyE4oLeG2nv1zu0k9w1BVxHttHUQsb5xS2dA89dITg7k93tpYE8AU4onazdNpHQkSPnV1V+lyxNQRako0k7Q2g2vqgl3mPcxdkTsHmsD+WK7PsVOK898ftp8KdxhW5iNzr/s2uTuDoaTs0QarOvA5pIVt6JiA4axvgmWwR3vMD0xwqe4Wx8LdZkyKMghMZRVozscVdHCZV/DKnGNYlFg9i8Z0S+qTQ0uFpRwOa+OjUHPDxd/lnRpp3KWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZxNaa30pD0ttjDOmrgIFq79HB8o72aTJlyqD33Bii4=;
 b=XpFYDxy8a5d08v+gyZRw9XWQdrQ3ZfVvQUFRYz1sYDZ1mZ3QG5I2YJ0xtU4uqNSvU93+gFWJb6c/TUrMLDalAGzn2GKSb9/w/11ZDpgSJ+pTt3gqIZMwyH5faEwdSF0SH8Ym6VLF6gqxg9CkpuLMmGRWjCXfQsXk8DZASCouhQsgrQvqwmYQ/hMEHoukon5s8Ckbxwat3rN4n3xULF7mgUP7J1YuY5H6fKn62Yvg9BbTQywrljma9idR+8X2KOJuBKmr1iqMKm/ivBIkRpgMUJWrhZdIZA5s0gKY0U8ULNYrh+csAY7A/yVPGtVN1TzKCU/beyk0YEsZqkk7rI1XPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZxNaa30pD0ttjDOmrgIFq79HB8o72aTJlyqD33Bii4=;
 b=EHxzVjaybj6i6pEQRgmfIR9wv0mq5ugf3hnlMye4cxa4lTZ4YSkk6EvMiKbj3WTgpzrEbA0nIA8a+o4vPViS0Jh51RunOJs54eN/PG7jqTXAxGvwZsmaZGVRlGwi+MH37z0VUxK+w4SDzpjDSfpfDwfIZMX4W+rOWrZyLz4FvPw=
Received: from MW4PR04CA0352.namprd04.prod.outlook.com (2603:10b6:303:8a::27)
 by SA3PR12MB7832.namprd12.prod.outlook.com (2603:10b6:806:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 12:44:07 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:303:8a:cafe::b8) by MW4PR04CA0352.outlook.office365.com
 (2603:10b6:303:8a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Wed,
 26 Feb 2025 12:44:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 12:44:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 06:44:05 -0600
Received: from xhdlc210316.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Feb 2025 06:44:02 -0600
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v2 0/2] Add support for PCIe RP PERST#
Date: Wed, 26 Feb 2025 18:13:56 +0530
Message-ID: <20250226124358.88227-1-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|SA3PR12MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5711d9-8ac5-4ddd-060f-08dd56634225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wVXFvoqkaMpqS4uqkiORVrujkp3RFeLC8ITFuw7fJZI7al2SFHAPwghsXhUr?=
 =?us-ascii?Q?aWFpyfNjFFUwLZpbwfrJZ8UOSyNTmITulXIljooUMiPO7hJ3PiihLxJkTxUl?=
 =?us-ascii?Q?e5o76q1psmIHHbU9IXljDqC1W0m3odpz6h6OB8wOMmbXjigEmSKBJvZIHcrd?=
 =?us-ascii?Q?FssIdZ41Qfaz5VcRGZdfD9J2K8SrhektFrFwDp8l6q+FMejMv3/58oX5eLeW?=
 =?us-ascii?Q?bCN45jqfHarZ8B+U6ZQgS652Pxs+80QaJrBzeqQXDnLqSMq0Xd9NPFbTrney?=
 =?us-ascii?Q?uEvUaWEOlmw8R2Yxue2NthqB97peSz+Ox7vA/Ppwcg3N9e8qAauxXNSJYmmZ?=
 =?us-ascii?Q?TBrWLvwHka6wRzOmZu1oHenpIS9sDXoHF7cVrtUrvYgF6cVyRaWyDyRCzKtA?=
 =?us-ascii?Q?AgtrhrzJdrS8/i+ALjmInrtxmx+kSN1EAkpC34Lo9Wiod4YULQWo9BfXDTDN?=
 =?us-ascii?Q?Ayjy6AU7HjI/2e4ND/Y+zCFIroLCrUdHbbtqLQMhnTZgqNP4gUJDwDtlEI5A?=
 =?us-ascii?Q?Z+GPvbWMAwpK8GRYz1svhKj8JwySJJWi9YU5S92tNNqbuHPMo4/V0dfzDcKE?=
 =?us-ascii?Q?L9jeHoMVtOIqV6lPpWkkJFbtLS3MtdkTanAnZPwnWAK+J3qj1BAPhzmZxB14?=
 =?us-ascii?Q?NOQXjkESqQK2w07WqeIJ+05ff9ErTMqmW7ZArVnlqlAqZKfczCkOueVVNKko?=
 =?us-ascii?Q?N308Tl0SnWo1zvnQgQVEdaCYPs7FqqbCQS1btCf2ce3XP7hVUC5+NUA8uTrF?=
 =?us-ascii?Q?A+jeYpF1nhXLWrCByq60kNuNRlfUBDvXtx1ypIyWGXYQ6UCsDpl0atMP4ceC?=
 =?us-ascii?Q?l3g/VN1vkCw3j2j8gyZCIw3c/M3t5UVJBQvQaoLF5GcLOMk47sgwmXNA0CVj?=
 =?us-ascii?Q?/t7QaqkXF5paMGcF5TV8zzxM4nzaTfnmZYQYNUW05tuROwi7OtWXzHSFDYxo?=
 =?us-ascii?Q?D5r5vCvD6S35Q1EHhr1LFZxQs1IhMLR+JBx9tDkH2P1zSE5HQ9NkpbmE8rkY?=
 =?us-ascii?Q?02WO9cYSZjfl+qkIx3TVTLkgy0DA90lZtoiDDiywzcZrbihG+g1Q8+guOM44?=
 =?us-ascii?Q?TS6Sd/FuVKpHuxdiIfI8i++tCH5jRIw4Zac31ZoVIbnSujEe24ElHxvL64YM?=
 =?us-ascii?Q?kJsprVE0PWtZt5di2LaAA9oZ2cPh33IpsXBODCqltFOiwFJXyq8h02hKRO3E?=
 =?us-ascii?Q?LSxJZ3xgvhf7nLtSn9IoKaaNSNN/quKirJtawZCDp+Cylawqb+t0z5e93Qlf?=
 =?us-ascii?Q?wwEaaXg4gQA2+bPhJg0g80Ns3CMhpQ4iEZzRvTgMc6O0IUwrHDa7unaTfOC1?=
 =?us-ascii?Q?qhXsEXZdc/QR4yt2xgCsR7SfqOP7LYqWwE4z2BO74eXVpr6LzQOQFDKOaQXq?=
 =?us-ascii?Q?5HuXG+qEoBcT4XwfVRni+j1jRXLmq1KIF9LRxLy8BF0yPysWqHhn6As85L+x?=
 =?us-ascii?Q?ZGsm1x7/m0fJpnfjInCTxj26cry8X/RR3+GTtrx+Ga2sfFfa9x8HC7p2iRqZ?=
 =?us-ascii?Q?Ru52Lt1gW4dlx2I=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 12:44:06.6232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5711d9-8ac5-4ddd-060f-08dd56634225
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7832

Add support for PCIe Root Port PERST# signal.

Add `reset-gpios` property to the Versal CPM PCIe controller binding.

Sai Krishna Musham (2):
  dt-bindings: PCI: xilinx-cpm: Add reset-gpios for PCIe RP PERST#
  PCI: xilinx-cpm: Add support for PCIe RP PERST# signal

 .../bindings/pci/xilinx-versal-cpm.yaml       |  7 ++++++
 drivers/pci/controller/pcie-xilinx-cpm.c      | 23 +++++++++++++++++++
 2 files changed, 30 insertions(+)

-- 
2.44.1


