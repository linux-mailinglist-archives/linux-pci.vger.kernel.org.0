Return-Path: <linux-pci+bounces-11522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D076194CA23
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 08:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAFE28936B
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 06:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C681316CD17;
	Fri,  9 Aug 2024 06:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PhfGeFXJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F67D16C697;
	Fri,  9 Aug 2024 06:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723183821; cv=fail; b=RDH/BLjwNZstcztrkcCJ2ZErJ10ng1KOGtx/3ORyR/hUjCBIHPhrFTK1MNmFNBEajRVqEpJqVgl7vNtf7JHjvqDbDQux2VEFdJg0U+KOr9GUxX+t+WPIX3gVwo+AhNMuQ2ZFria3AkYDDLoMEN2cTbJtO/SKMrON0RL2/1Um/K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723183821; c=relaxed/simple;
	bh=vwv1n22y/DDD6D41EOjDkNy1hjvCu1Uf2UPXvgcEYR8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ccSJirjizCqVmYgwo4HgvV9/yd/Yau62y6je4tHJjBsOKysuO3y21+GbyGyBqdg8amX83zY2hEjR6lygV5QMwQximH3Yr/DdK0GOO+sYVzFO9focx401zn8TiK2ISjhml7AHhx0KX3IL+SyjTOUNkzlBM1wUHpsY9OwjrdcVbq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PhfGeFXJ; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyVf9MVENvgH/jWGZ62jXVdsnzMhAUw7bK0lg9CuzX/SGdsIlN3LMVHYJN33DKMYRZrpNxoNCMpaziN1yEVKIXQQcvGPneLZ/Jxliua2LpIUUyGYPBTqphj1sMw61zHVkhlUDUUUcGwSOo+UF6MpVS4jmshViru3NXQt5p+Or2NV+TELD0p5w1uSb1fpxkvWTY+/TCMCj06fehdhvU3odGHdYvvfsjgkPKGuLn0TdlPyJ1t5jeQ/be9wqfnwQWtUbWAvTLTjaKW3uNyM9NLJCAafBsBPtmEkCG3yE5K5gA5q4i/rZCJMenu7vH8cTcuB6MJ2Ow0fHvA3YDCvA35gGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=or+1f6LMlJfsQshm6l2ObHqMua7C7yQPV85F+T+wR4M=;
 b=lt1SIRR/FqRcYLbxJMsEIJZCO54oz3fAy3GN/EnMPW6IDUMeTLKJVj3i4YcA8R6Ao6+uosoqTabtU7PfPNvUnz7ZaOgUKDr7fQnM/mcZutaN9+ObHF+9IYcTdKT5d9f0UX8IO4OKPoqxYW62PUBbIV1v5+hJncLWnKWUVk7rCu/kexrUt7shwxMITtD0uB68ApEbMEHovLvQLh06YGDDVJn3N3fl/A+LK7Qe11VT4ZKZVOQLFIEa3Mvl6aICk03yMQBGPtcaY0ryuxnGuFQDO9hEYIM+wWc5kg9lF3rnzyplP86N2UVS2Ui1HNUeWVQXCzRMqUF9Rq9vdmiEtlQ5mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=or+1f6LMlJfsQshm6l2ObHqMua7C7yQPV85F+T+wR4M=;
 b=PhfGeFXJJiNFGwdNcXGWJeIIphs7uUg9vZW6925unvsRmnbfNv0HavHRVhznecchfsLlCHrzoJk1RPM1aeKag0i7RfVRuTeKHwcOOsadK6PU+PK2N6N8v9wp/xV6isWA2w//62Z+s6c/gCRgVmVVRrP6R+BDjAZ9DHjIj7aIj2Y=
Received: from MW3PR05CA0008.namprd05.prod.outlook.com (2603:10b6:303:2b::13)
 by SN7PR12MB6713.namprd12.prod.outlook.com (2603:10b6:806:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 06:10:17 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:303:2b:cafe::f) by MW3PR05CA0008.outlook.office365.com
 (2603:10b6:303:2b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Fri, 9 Aug 2024 06:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 9 Aug 2024 06:10:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 Aug
 2024 01:10:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 Aug
 2024 01:10:16 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 9 Aug 2024 01:10:12 -0500
From: Thippeswamy Havalige <thippesw@amd.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <thippeswamy.havalige@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <michal.simek@amd.com>, "Thippeswamy
 Havalige" <thippesw@amd.com>
Subject: [PATCH v3 0/2] Add support for Xilinx XDMA Soft IP as Root Port
Date: Fri, 9 Aug 2024 11:39:53 +0530
Message-ID: <20240809060955.1982335-1-thippesw@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|SN7PR12MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec74c53-320b-417d-8760-08dcb839f0eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?umDIXBUld+PJm8ddsqyAxQZZzI4HyIjSWE/sqp7rwWy4hf1cxb4Plm49X9pl?=
 =?us-ascii?Q?PXTa7nJQKJTtFY+eqqMa8UPQrfsEeiK113cCd0NiXIjQGjoVFssI1l48wvX/?=
 =?us-ascii?Q?RjYLgyOYMV6hZc5JQEsMiGdeo4PltxHB9+No4FK4N9mUaRgN3cr4qn2Wno+6?=
 =?us-ascii?Q?PH1u5YVdD3K9amn5G6AKjEHcGWsgQoettskxAtN9OrM64mJ3zhXdw8L9r9rU?=
 =?us-ascii?Q?0i3Bc79ses9jxC1GAV13VMJQxbJvhc20Tk8fPo+5Dg98Em1ccBuGu4rdyhDH?=
 =?us-ascii?Q?SEe2ZIBjgoWDqA1fLK4j5QibCdexq9q2PJGUcDl9ygicQGEF5XxqTNs2alQU?=
 =?us-ascii?Q?4Bu9U9AjW3OLO2hRF31yZfbeH/gSojQ/YWYdJMbnbY90/7o3mkDel76+Kcym?=
 =?us-ascii?Q?9TRVzwOIajY49rGuwqROOjgYOcaReQCos0nYOKVZNj+LheopYvJBHx5qpSKS?=
 =?us-ascii?Q?RnXUqTyMXz4v95nv7O4P1nwZ0lvyfvisz0yQIWMa7p3cxPXcP/+wdjZbeOBN?=
 =?us-ascii?Q?5d11/G6EYEcMIk4zwO/aV+CZ0SU5kH1GGo3hNnel3rXoy4YjQVvaNzo6tzzy?=
 =?us-ascii?Q?PVW4xxBz+SDYX3ng8JiTI2MPARES8rl/nYqvPTjStHwr3abRtpXEgtlcNzw2?=
 =?us-ascii?Q?Y+xowU7BBblgm/WKnYzINDupIeLFshadJgAGvq2YZPKuokn+jHfKFFj1olso?=
 =?us-ascii?Q?AFiZbfPj0lbySD3OMiv5vmHcD37b2czpcLM3k0D9WUiMKjRHwic72IUKOY1p?=
 =?us-ascii?Q?Fyf3g2e1vzlrtTid5GEl9sMqoH6j751iANgJGrB1frjAUBQJoAtDViPsWiJQ?=
 =?us-ascii?Q?YYjFZgPpTpsqIvtQoJVzfcH0ziGHZic8XB5hIT+lzbaIyU9AS1WkiwM/h3oG?=
 =?us-ascii?Q?TRXuU0CQbceFktAN0wFqayDY0Cg4VeC+5N09rasFwlJ5V8FMrrTY0qDW4C8o?=
 =?us-ascii?Q?jccz79YtsL+2iCwvppaqRFvUAUDcNkQQ/Re8AaTOvRHRX8v8AAt5PfpWSFS9?=
 =?us-ascii?Q?bErCvpu7nasm9/twG3Qk/uzTbPXA9JE87AKtNDWLCqlqcPhG+tNBaAHWG0l3?=
 =?us-ascii?Q?UVLOO4cxkLCVq5o5loAyDGau1TfJkg7ETFwnXi9A3FLJFkQdQgKDAGPI7+cY?=
 =?us-ascii?Q?dkwIu9FVEEvUcW6HDs1fFxq2R2XQxihVopnoVnE+EheGSaWMQPe0nEEovvuf?=
 =?us-ascii?Q?HwMXzKV1hFmmP3yG7+ICwRL/ppD2qNaHNkwxbqwVkZUrzfZLV3BjBaxizwAk?=
 =?us-ascii?Q?yXtdQaMO+vHZb32NMOTmC0OVfC0lOIfHgP7rCpQTSn5InLBUOHfqu4RIdAZj?=
 =?us-ascii?Q?u6Zc2Zobui0TrFc/oqYoW0HQru7BSw+PdcbM/w9+RumpXYe7L0h2BsO+EERC?=
 =?us-ascii?Q?r9Hg/P4m+m7k1CFrBJdSX/3o8IG0bUOjvdAfmIy0whkJN3oLJoIzB4TdAzIN?=
 =?us-ascii?Q?3jEgt9l3WmToDAfKovHo0WpKsMoRzsIW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 06:10:17.2663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec74c53-320b-417d-8760-08dcb839f0eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713

This series of patch add support for Xilinx QDMA Soft IP as Root Port.

The Xilinx QDMA Soft IP support's 32 bit and 64bit BAR's.
As Root Port it supports MSI and legacy interrupts.

Thippeswamy Havalige (2):
  dt-bindings: PCI: xilinx-xdma: Add schemas for Xilinx QDMA PCIe Root
    Port Bridge
  PCI: xilinx-xdma: Add Xilinx QDMA Root Port driver

 .../devicetree/bindings/pci/xlnx,xdma-host.yaml    | 36 ++++++++++++++-
 drivers/pci/controller/pcie-xilinx-dma-pl.c        | 54 +++++++++++++++++++++-
 2 files changed, 87 insertions(+), 3 deletions(-)

-- 
1.8.3.1


