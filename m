Return-Path: <linux-pci+bounces-19050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660249FC8C6
	for <lists+linux-pci@lfdr.de>; Thu, 26 Dec 2024 07:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905351882A54
	for <lists+linux-pci@lfdr.de>; Thu, 26 Dec 2024 06:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C4314A0A4;
	Thu, 26 Dec 2024 06:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Cx5MmId5"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3372837A;
	Thu, 26 Dec 2024 06:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735192927; cv=fail; b=l/yAx3si3oYicRMHbEyV1hoIX2Vzkp7GN7pIQn1zy0RBPT6c5yRGSgWA123m9nzd4iTqEpqHMl76m9w2yuQFDspDfzhV17A1ZB5rDfsX4Yc4zXEEnJZAz2Cke9VEqwQJHwe2QXPq3mjY/5Jd26MmropzBq4IQWnZ35RYFCZlK8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735192927; c=relaxed/simple;
	bh=9FSRkuHvkQrQ847vYl/LoJtaGbm2J+4c0TzGn+jjax0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RuqmYiWmTi07+mAiSqMxntMkYzxX0hGEXzdOe7HUXxLO4QpNIBesGmhxFLQboBZ6vsdsBdHq0m5zBlrbK5zDAhsV9CjXT2msrs8bTO6U8taD0wCYd/IwO1jeUilSBr8l33VDGYr8MLrB61aHJUgdEjs05duPJokoNOtXeIXhutI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cx5MmId5; arc=fail smtp.client-ip=40.107.95.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/TFAUOvriCTGpGXhp2v9dsW+I+AjJ2pzV1VYnwqeir83h/YE88vQC2DdwYjq+gxrytBWXQmykpY5w77JfvImLCNn6MyrE17u6hi9VEY8saBocusGOGSO0VdIrvVItgsHHLqlJPNDBOlImS6WF2g5/oeI9ZyHEznwrcFSmduhSRyGgHxVJ1ra/ij0fp2523OZnhrQfNrliuDJduPYQl0h/pPvZbBGIx+pq3QTBjJHmK0f5cBzDUTTVOmWvm94N/jVvu/usZPH1kc1CN0N0MwdMUbk4VUw5RppRqE1darBtO69XHVJoxwJZkvgTJnkef1G+/B2FydgwrLzliOaCe9Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IukivCrs/2nEppStdZoR0FzkH/FxMZF2dv3xMj7XnM0=;
 b=n57ejNQB4JUmTSw+SdjN0hhk5Ar5hoHm7HlzFMYWQ7MBEkt2MpVp543xqwWwsBFppG7lnuoGI6FGhXu/RO4rywbaKap6Sn/zN5r+BuMDT0LuBj1VWkQbcgDqeIArUcIv7RBR+L7hBUxw2ixgS5fKhDkl5rfWymNPrAnu+jmzyRPSnS3nvHwPJkyYumw8jgPCA17DzFEfdwQoW1L953fg2LWK2sXMBQ/9cKjUtKweu2im7NFS3kvBS1j3N8vT5vZVuDVvqw6sgW8nkiDUJpWMSSLwsIUDtOoDGJgkIRQU5tnDRyibXl/O6/IxuU4Q4jv1CQyxaqIGMzaRDxAdpH+67A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IukivCrs/2nEppStdZoR0FzkH/FxMZF2dv3xMj7XnM0=;
 b=Cx5MmId5N0pBiuxUmsfMnGc53ir29Z+h6RFpJ1Uet9qxX/1Ckyj3MeEMbcLF9FNK+TCtp8KJZOVgGBNIi4/G69zyYXyJEhRs86+0ccictVzUL1htDJAZm5Uc3MmKJOYnwMIGS8jo65JC4oqIo3hG5sbxDpYfjpkqJ/iWplDITTw=
Received: from BN7PR02CA0015.namprd02.prod.outlook.com (2603:10b6:408:20::28)
 by IA1PR12MB6626.namprd12.prod.outlook.com (2603:10b6:208:3a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Thu, 26 Dec
 2024 06:01:57 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:408:20:cafe::9e) by BN7PR02CA0015.outlook.office365.com
 (2603:10b6:408:20::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.14 via Frontend Transport; Thu,
 26 Dec 2024 06:01:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.12 via Frontend Transport; Thu, 26 Dec 2024 06:01:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Dec
 2024 00:01:33 -0600
Received: from xhdharinik40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 26 Dec 2024 00:01:30 -0600
From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jingoohan1@gmail.com>,
	<michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>, Thippeswamy Havalige
	<thippeswamy.havalige@amd.com>
Subject: [PATCH v6 0/3] Add support for AMD MDB IP as Root Port
Date: Thu, 26 Dec 2024 11:30:40 +0530
Message-ID: <20241226060043.18280-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: thippeswamy.havalige@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|IA1PR12MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 73557824-94d7-4a7e-179b-08dd2572ce31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KIMPflf2aMS3R6rwOl4jpK8Y77VwXVkmmgFIL/mGORzq04rGPQEHsIgWpQ/X?=
 =?us-ascii?Q?DWCVhQiVnPJQSmkadLRRwATC+03pxAdSOXmMQYAQR+lOQSYiKumPUKLy0sRh?=
 =?us-ascii?Q?2LTjXxn28DvPTOyN36d8X5LDwY/oXxKUfESVhYz4rvRGbo5pj0mr3eJLPZqB?=
 =?us-ascii?Q?OOTFqenXXiZN2Jon2HZbKEXbpJPKi8w+yDK9R0tpqbfoscPrDDOjVLiuUzde?=
 =?us-ascii?Q?nJSEiuKDHg4AuFteKAoAmYqwTXBTo3ECmfnsSr8EsvKzqA2hLGVI+sXxoY5Z?=
 =?us-ascii?Q?rePOjiclrHv40CakhRr0CvuMIpPyXo7hFVKG2CI9+EHv2LVKpoTmO8JLut8R?=
 =?us-ascii?Q?leTbk+sBYXqY5Ctrlbufj3L+vTFaVIHY+1C7prvUGOlC3E2VaWhmoKOfDYXN?=
 =?us-ascii?Q?jrKiiPb9/7mHwLCxb6+V1RkOoWs4nUcpBWIZQzOvCpZkypjyrsk30p2YDAxn?=
 =?us-ascii?Q?2o9Ly6yU+sl8a5f3k92zUOo61UbOFM5769ZbpsBdrJRXlY7az68q+Ru0OUi2?=
 =?us-ascii?Q?hZuq+RxHfr25JGzZTcqVev6SD/DO3bVnUIchxMcDq6mEebng529yLmPzsNZQ?=
 =?us-ascii?Q?laOQYxLNGfW7DoyAzNchX7mcKiadQ5W2a0eQGYVO2bkUH+HBpijCcPOksycs?=
 =?us-ascii?Q?smsS8vJVclFkfOo4cpBVy1ka5u729+r7vYJxmCNWZ87mwOq+f6OPOjonxoXH?=
 =?us-ascii?Q?Rv5DzaAB/bdCW3/fwviQTWonMt/+96RLkQuWeKQxZTM+gGps8LBvfyGJtw+t?=
 =?us-ascii?Q?basvQ6BPgENPmr3kCewyb0Jzm1oncRJ0LUf7ciYFsxe8sBJdxRGhdfIMHfsb?=
 =?us-ascii?Q?N3FvfQ0p/F1V8JDi2n+pUyt5nPYaCqHBJptQUoG01BaICcfhwXLBlG9poQls?=
 =?us-ascii?Q?mMpOSUb7sm565oa0ZNMMYMrVXyFAJeKMr7L4Vr6xOVsAkLz/uOWPjBLb4sth?=
 =?us-ascii?Q?dwSJ9BsPjHkeLeuJTfg5hvQdRbjJ7H/8NeihNBJExCzng+FLTAMzI9RztFFq?=
 =?us-ascii?Q?9MEPmjP8r4eFKlqc4iH1YCL6X1RMboio4StjodxPOGVySCqMe8+UEU3llWX+?=
 =?us-ascii?Q?/HCjRLrbUlrIi05Vzp35AFZaPpjjsvkweCv4XYcfxxaYiuIp6ITci6ISmeLN?=
 =?us-ascii?Q?ZiFvLpXWW53XzCb8a8my1fWIn21wQ74FQBWq78d4quRVZrXqKKHH0kT1qv6U?=
 =?us-ascii?Q?9DSfMVfBde/naYOFPkBT3Xqu/50b/I6/8HZpNwOT6SyyHwANLwTd2Ue8MGrF?=
 =?us-ascii?Q?WoEGMzF+H6YtvQEtROpGx5KIQA5RGi3AkRqJ+rQi6S+ROPScwCL+ROtote2e?=
 =?us-ascii?Q?CwTqbe+O4ZeyQjcwjE5h7wy/TBkiDTFtoq4Y/xIP+ZKhBvVRNGlEvbF+czMt?=
 =?us-ascii?Q?wsaPkiqD5oKAsklss8VwjU62fPw92SyxP1u/RwyJiOyvxsAxfuIuhl7v1vxT?=
 =?us-ascii?Q?9ATtqaXoFHkJxZKMtd/dPhCe0+UOltiZvCCIKAm00UzPqKIxcpxJma6rQ98M?=
 =?us-ascii?Q?z623WUIKRVistK0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2024 06:01:34.9802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73557824-94d7-4a7e-179b-08dd2572ce31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6626

This series of patch add support for AMD MDB IP as Root Port.

The AMD MDB IP support's 32 bit and 64bit BAR's at Gen5 speed.
As Root Port it supports MSI and legacy interrupts.

Thippeswamy Havalige (3):
  dt-bindings: PCI: dwc: Add AMD Versal2 mdb slcr support
  dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB PCIe Root Port Bridge
  PCI: amd-mdb: Add AMD MDB Root Port driver

 .../bindings/pci/amd,versal2-mdb-host.yaml         | 121 ++++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml      |   2 +
 drivers/pci/controller/dwc/Kconfig                 |  11 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pcie-amd-mdb.c          | 436 +++++++++++++++++++++
 5 files changed, 571 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c

-- 
1.8.3.1


